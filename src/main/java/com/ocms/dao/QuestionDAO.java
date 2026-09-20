package com.ocms.dao;

import com.ocms.model.Option;
import com.ocms.model.Question;
import com.ocms.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * JDBC Data Access Object for Assessment Questions and Options.
 */
public class QuestionDAO {

    private static final Logger LOGGER = Logger.getLogger(QuestionDAO.class.getName());

    public List<Question> findByAssessmentId(int assessmentId) {
        List<Question> questions = new ArrayList<>();
        String qSql = "SELECT * FROM questions WHERE assessment_id = ? ORDER BY order_index ASC, question_id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(qSql)) {
            ps.setInt(1, assessmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question();
                    q.setQuestionId(rs.getInt("question_id"));
                    q.setAssessmentId(rs.getInt("assessment_id"));
                    q.setQuestionText(rs.getString("question_text"));
                    q.setMarks(rs.getInt("marks"));
                    q.setOrderIndex(rs.getInt("order_index"));
                    questions.add(q);
                }
            }

            // Populate options for each question
            String optSql = "SELECT * FROM options WHERE question_id = ? ORDER BY order_index ASC, option_id ASC";
            try (PreparedStatement optPs = conn.prepareStatement(optSql)) {
                for (Question q : questions) {
                    optPs.setInt(1, q.getQuestionId());
                    try (ResultSet optRs = optPs.executeQuery()) {
                        List<Option> opts = new ArrayList<>();
                        while (optRs.next()) {
                            Option o = new Option();
                            o.setOptionId(optRs.getInt("option_id"));
                            o.setQuestionId(optRs.getInt("question_id"));
                            o.setOptionText(optRs.getString("option_text"));
                            o.setCorrect(optRs.getBoolean("is_correct"));
                            o.setOrderIndex(optRs.getInt("order_index"));
                            opts.add(o);
                        }
                        q.setOptions(opts);
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding questions for assessment: " + assessmentId, e);
        }
        return questions;
    }

    public boolean createQuestionWithOptions(Question question, List<Option> options) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Transaction

            String qSql = "INSERT INTO questions (assessment_id, question_text, marks, order_index) VALUES (?, ?, ?, ?)";
            int questionId = 0;
            try (PreparedStatement ps = conn.prepareStatement(qSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, question.getAssessmentId());
                ps.setString(2, question.getQuestionText());
                ps.setInt(3, question.getMarks());
                ps.setInt(4, question.getOrderIndex());
                ps.executeUpdate();
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        questionId = gk.getInt(1);
                        question.setQuestionId(questionId);
                    }
                }
            }

            if (questionId > 0 && options != null) {
                String optSql = "INSERT INTO options (question_id, option_text, is_correct, order_index) VALUES (?, ?, ?, ?)";
                try (PreparedStatement optPs = conn.prepareStatement(optSql)) {
                    for (Option opt : options) {
                        optPs.setInt(1, questionId);
                        optPs.setString(2, opt.getOptionText());
                        optPs.setBoolean(3, opt.isCorrect());
                        optPs.setInt(4, opt.getOrderIndex());
                        optPs.addBatch();
                    }
                    optPs.executeBatch();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            DBConnection.rollback(conn);
            LOGGER.log(Level.SEVERE, "Transaction rollback creating question with options", e);
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.WARNING, "Error closing connection", ex);
                }
            }
        }
    }

    public boolean delete(int questionId) {
        String sql = "DELETE FROM questions WHERE question_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, questionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting question id: " + questionId, e);
        }
        return false;
    }
}
