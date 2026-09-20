package com.ocms.dao;

import com.ocms.model.Assessment;
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
 * JDBC Data Access Object for Assessments.
 */
public class AssessmentDAO {

    private static final Logger LOGGER = Logger.getLogger(AssessmentDAO.class.getName());

    public List<Assessment> findByCourseId(int courseId) {
        List<Assessment> list = new ArrayList<>();
        String sql = "SELECT a.*, c.title AS course_title, "
                   + "(SELECT COUNT(*) FROM questions q WHERE q.assessment_id = a.assessment_id) AS q_count "
                   + "FROM assessments a "
                   + "JOIN courses c ON a.course_id = c.course_id "
                   + "WHERE a.course_id = ? "
                   + "ORDER BY a.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToAssessment(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding assessments for course: " + courseId, e);
        }
        return list;
    }

    public List<Assessment> findByInstructorId(int instructorId) {
        List<Assessment> list = new ArrayList<>();
        String sql = "SELECT a.*, c.title AS course_title, "
                   + "(SELECT COUNT(*) FROM questions q WHERE q.assessment_id = a.assessment_id) AS q_count "
                   + "FROM assessments a "
                   + "JOIN courses c ON a.course_id = c.course_id "
                   + "WHERE c.instructor_id = ? "
                   + "ORDER BY a.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instructorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToAssessment(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding assessments for instructor: " + instructorId, e);
        }
        return list;
    }

    public Assessment findById(int assessmentId) {
        String sql = "SELECT a.*, c.title AS course_title, "
                   + "(SELECT COUNT(*) FROM questions q WHERE q.assessment_id = a.assessment_id) AS q_count "
                   + "FROM assessments a "
                   + "JOIN courses c ON a.course_id = c.course_id "
                   + "WHERE a.assessment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assessmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAssessment(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding assessment by id: " + assessmentId, e);
        }
        return null;
    }

    public boolean create(Assessment assessment) {
        String sql = "INSERT INTO assessments (course_id, title, description, passing_score, total_marks, duration_minutes) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, assessment.getCourseId());
            ps.setString(2, assessment.getTitle());
            ps.setString(3, assessment.getDescription());
            ps.setInt(4, assessment.getPassingScore());
            ps.setInt(5, assessment.getTotalMarks());
            ps.setInt(6, assessment.getDurationMinutes());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        assessment.setAssessmentId(gk.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating assessment: " + assessment.getTitle(), e);
        }
        return false;
    }

    public boolean update(Assessment assessment) {
        String sql = "UPDATE assessments SET title = ?, description = ?, passing_score = ?, total_marks = ?, duration_minutes = ? WHERE assessment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, assessment.getTitle());
            ps.setString(2, assessment.getDescription());
            ps.setInt(3, assessment.getPassingScore());
            ps.setInt(4, assessment.getTotalMarks());
            ps.setInt(5, assessment.getDurationMinutes());
            ps.setInt(6, assessment.getAssessmentId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating assessment id: " + assessment.getAssessmentId(), e);
        }
        return false;
    }

    public boolean delete(int assessmentId) {
        String sql = "DELETE FROM assessments WHERE assessment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assessmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting assessment id: " + assessmentId, e);
        }
        return false;
    }

    public int countByInstructor(int instructorId) {
        String sql = "SELECT COUNT(a.assessment_id) FROM assessments a "
                   + "JOIN courses c ON a.course_id = c.course_id "
                   + "WHERE c.instructor_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instructorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting assessments for instructor: " + instructorId, e);
        }
        return 0;
    }

    private Assessment mapResultSetToAssessment(ResultSet rs) throws SQLException {
        Assessment a = new Assessment();
        a.setAssessmentId(rs.getInt("assessment_id"));
        a.setCourseId(rs.getInt("course_id"));
        a.setTitle(rs.getString("title"));
        a.setDescription(rs.getString("description"));
        a.setPassingScore(rs.getInt("passing_score"));
        a.setTotalMarks(rs.getInt("total_marks"));
        a.setDurationMinutes(rs.getInt("duration_minutes"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setCourseTitle(rs.getString("course_title"));
        a.setQuestionCount(rs.getInt("q_count"));
        return a;
    }
}
