package com.ocms.dao;

import com.ocms.model.Attempt;
import com.ocms.model.AttemptAnswer;
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
 * JDBC Data Access Object for Assessment Attempts and Results.
 */
public class AttemptDAO {

    private static final Logger LOGGER = Logger.getLogger(AttemptDAO.class.getName());

    /**
     * Records a student assessment attempt and their chosen answers within a transaction.
     */
    public boolean saveAttempt(Attempt attempt, List<AttemptAnswer> answers) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin transaction

            String sql = "INSERT INTO attempts (assessment_id, user_id, enrollment_id, score, total_score, percentage, passed) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            int attemptId = 0;
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, attempt.getAssessmentId());
                ps.setInt(2, attempt.getUserId());
                ps.setInt(3, attempt.getEnrollmentId());
                ps.setInt(4, attempt.getScore());
                ps.setInt(5, attempt.getTotalScore());
                ps.setBigDecimal(6, attempt.getPercentage());
                ps.setBoolean(7, attempt.isPassed());
                ps.executeUpdate();
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        attemptId = gk.getInt(1);
                        attempt.setAttemptId(attemptId);
                    }
                }
            }

            if (attemptId > 0 && answers != null && !answers.isEmpty()) {
                String ansSql = "INSERT INTO attempt_answers (attempt_id, question_id, selected_option_id, is_correct) "
                              + "VALUES (?, ?, ?, ?)";
                try (PreparedStatement ansPs = conn.prepareStatement(ansSql)) {
                    for (AttemptAnswer ans : answers) {
                        ansPs.setInt(1, attemptId);
                        ansPs.setInt(2, ans.getQuestionId());
                        ansPs.setInt(3, ans.getSelectedOptionId());
                        ansPs.setBoolean(4, ans.isCorrect());
                        ansPs.addBatch();
                    }
                    ansPs.executeBatch();
                }
            }

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            DBConnection.rollback(conn);
            LOGGER.log(Level.SEVERE, "Transaction rollback saving assessment attempt", e);
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

    public List<Attempt> findByUserId(int userId) {
        List<Attempt> list = new ArrayList<>();
        String sql = "SELECT att.*, ass.title AS assessment_title, c.title AS course_title, ass.passing_score "
                   + "FROM attempts att "
                   + "JOIN assessments ass ON att.assessment_id = ass.assessment_id "
                   + "JOIN courses c ON ass.course_id = c.course_id "
                   + "WHERE att.user_id = ? "
                   + "ORDER BY att.attempted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToAttempt(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving attempts for user: " + userId, e);
        }
        return list;
    }

    public List<Attempt> findByAssessmentId(int assessmentId) {
        List<Attempt> list = new ArrayList<>();
        String sql = "SELECT att.*, ass.title AS assessment_title, c.title AS course_title, ass.passing_score, "
                   + "u.full_name AS student_name, u.email AS student_email "
                   + "FROM attempts att "
                   + "JOIN assessments ass ON att.assessment_id = ass.assessment_id "
                   + "JOIN courses c ON ass.course_id = c.course_id "
                   + "JOIN users u ON att.user_id = u.user_id "
                   + "WHERE att.assessment_id = ? "
                   + "ORDER BY att.attempted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assessmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attempt a = mapResultSetToAttempt(rs);
                    a.setStudentName(rs.getString("student_name"));
                    a.setStudentEmail(rs.getString("student_email"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving attempts for assessment: " + assessmentId, e);
        }
        return list;
    }

    public Attempt findById(int attemptId) {
        String sql = "SELECT att.*, ass.title AS assessment_title, c.title AS course_title, ass.passing_score, "
                   + "u.full_name AS student_name, u.email AS student_email "
                   + "FROM attempts att "
                   + "JOIN assessments ass ON att.assessment_id = ass.assessment_id "
                   + "JOIN courses c ON ass.course_id = c.course_id "
                   + "JOIN users u ON att.user_id = u.user_id "
                   + "WHERE att.attempt_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attemptId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Attempt a = mapResultSetToAttempt(rs);
                    a.setStudentName(rs.getString("student_name"));
                    a.setStudentEmail(rs.getString("student_email"));

                    // Load attempt answers
                    String ansSql = "SELECT aa.*, q.question_text, o.option_text AS selected_option_text "
                                  + "FROM attempt_answers aa "
                                  + "JOIN questions q ON aa.question_id = q.question_id "
                                  + "JOIN options o ON aa.selected_option_id = o.option_id "
                                  + "WHERE aa.attempt_id = ?";
                    try (PreparedStatement ansPs = conn.prepareStatement(ansSql)) {
                        ansPs.setInt(1, attemptId);
                        try (ResultSet ansRs = ansPs.executeQuery()) {
                            List<AttemptAnswer> answers = new ArrayList<>();
                            while (ansRs.next()) {
                                AttemptAnswer ans = new AttemptAnswer();
                                ans.setAnswerId(ansRs.getInt("answer_id"));
                                ans.setAttemptId(ansRs.getInt("attempt_id"));
                                ans.setQuestionId(ansRs.getInt("question_id"));
                                ans.setSelectedOptionId(ansRs.getInt("selected_option_id"));
                                ans.setCorrect(ansRs.getBoolean("is_correct"));
                                ans.setQuestionText(ansRs.getString("question_text"));
                                ans.setSelectedOptionText(ansRs.getString("selected_option_text"));
                                answers.add(ans);
                            }
                            a.setAnswers(answers);
                        }
                    }
                    return a;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding attempt by id: " + attemptId, e);
        }
        return null;
    }

    public int countByStudent(int userId) {
        String sql = "SELECT COUNT(*) FROM attempts WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting attempts for user: " + userId, e);
        }
        return 0;
    }

    private Attempt mapResultSetToAttempt(ResultSet rs) throws SQLException {
        Attempt a = new Attempt();
        a.setAttemptId(rs.getInt("attempt_id"));
        a.setAssessmentId(rs.getInt("assessment_id"));
        a.setUserId(rs.getInt("user_id"));
        a.setEnrollmentId(rs.getInt("enrollment_id"));
        a.setScore(rs.getInt("score"));
        a.setTotalScore(rs.getInt("total_score"));
        a.setPercentage(rs.getBigDecimal("percentage"));
        a.setPassed(rs.getBoolean("passed"));
        a.setAttemptedAt(rs.getTimestamp("attempted_at"));
        a.setAssessmentTitle(rs.getString("assessment_title"));
        a.setCourseTitle(rs.getString("course_title"));
        a.setPassingScore(rs.getInt("passing_score"));
        return a;
    }
}
