package com.ocms.dao;

import com.ocms.model.Enrollment;
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
 * JDBC Data Access Object for Course Enrollments and Progress.
 */
public class EnrollmentDAO {

    private static final Logger LOGGER = Logger.getLogger(EnrollmentDAO.class.getName());

    public boolean isEnrolled(int userId, int courseId) {
        String sql = "SELECT 1 FROM enrollments WHERE user_id = ? AND course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking enrollment: user=" + userId + ", course=" + courseId, e);
        }
        return false;
    }

    public Enrollment getEnrollment(int userId, int courseId) {
        String sql = "SELECT e.*, c.title AS course_title, c.category AS course_category, "
                   + "u_inst.full_name AS instructor_name, "
                   + "u_stud.full_name AS student_name, u_stud.email AS student_email "
                   + "FROM enrollments e "
                   + "JOIN courses c ON e.course_id = c.course_id "
                   + "JOIN users u_inst ON c.instructor_id = u_inst.user_id "
                   + "JOIN users u_stud ON e.user_id = u_stud.user_id "
                   + "WHERE e.user_id = ? AND e.course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Enrollment en = mapResultSetToEnrollment(rs);
                    populateProgress(conn, en);
                    return en;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment", e);
        }
        return null;
    }

    public Enrollment findById(int enrollmentId) {
        String sql = "SELECT e.*, c.title AS course_title, c.category AS course_category, "
                   + "u_inst.full_name AS instructor_name, "
                   + "u_stud.full_name AS student_name, u_stud.email AS student_email "
                   + "FROM enrollments e "
                   + "JOIN courses c ON e.course_id = c.course_id "
                   + "JOIN users u_inst ON c.instructor_id = u_inst.user_id "
                   + "JOIN users u_stud ON e.user_id = u_stud.user_id "
                   + "WHERE e.enrollment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Enrollment en = mapResultSetToEnrollment(rs);
                    populateProgress(conn, en);
                    return en;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment by id: " + enrollmentId, e);
        }
        return null;
    }

    /**
     * Enrolls a student using a database transaction with duplicate protection.
     */
    public boolean enroll(int userId, int courseId) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin transaction

            // Step 1: Check duplicate
            String checkSql = "SELECT enrollment_id FROM enrollments WHERE user_id = ? AND course_id = ? FOR UPDATE";
            try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                checkPs.setInt(1, userId);
                checkPs.setInt(2, courseId);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        conn.rollback();
                        LOGGER.warning("Duplicate enrollment rejected: user=" + userId + ", course=" + courseId);
                        return false;
                    }
                }
            }

            // Step 2: Insert enrollment
            String insertSql = "INSERT INTO enrollments (user_id, course_id, status) VALUES (?, ?, 'ACTIVE')";
            try (PreparedStatement insertPs = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                insertPs.setInt(1, userId);
                insertPs.setInt(2, courseId);
                int affected = insertPs.executeUpdate();
                if (affected > 0) {
                    conn.commit(); // Commit transaction
                    return true;
                }
            }

            conn.rollback();
            return false;
        } catch (SQLException e) {
            DBConnection.rollback(conn);
            LOGGER.log(Level.SEVERE, "Transaction rollback during course enrollment", e);
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

    public List<Enrollment> findByUserId(int userId) {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT e.*, c.title AS course_title, c.category AS course_category, "
                   + "u_inst.full_name AS instructor_name, "
                   + "u_stud.full_name AS student_name, u_stud.email AS student_email "
                   + "FROM enrollments e "
                   + "JOIN courses c ON e.course_id = c.course_id "
                   + "JOIN users u_inst ON c.instructor_id = u_inst.user_id "
                   + "JOIN users u_stud ON e.user_id = u_stud.user_id "
                   + "WHERE e.user_id = ? "
                   + "ORDER BY e.enrolled_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Enrollment en = mapResultSetToEnrollment(rs);
                    populateProgress(conn, en);
                    list.add(en);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving enrollments for user: " + userId, e);
        }
        return list;
    }

    public List<Enrollment> findByCourseId(int courseId) {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT e.*, c.title AS course_title, c.category AS course_category, "
                   + "u_inst.full_name AS instructor_name, "
                   + "u_stud.full_name AS student_name, u_stud.email AS student_email "
                   + "FROM enrollments e "
                   + "JOIN courses c ON e.course_id = c.course_id "
                   + "JOIN users u_inst ON c.instructor_id = u_inst.user_id "
                   + "JOIN users u_stud ON e.user_id = u_stud.user_id "
                   + "WHERE e.course_id = ? "
                   + "ORDER BY e.enrolled_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Enrollment en = mapResultSetToEnrollment(rs);
                    populateProgress(conn, en);
                    list.add(en);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving enrollments for course: " + courseId, e);
        }
        return list;
    }

    public List<Enrollment> findAll() {
        List<Enrollment> list = new ArrayList<>();
        String sql = "SELECT e.*, c.title AS course_title, c.category AS course_category, "
                   + "u_inst.full_name AS instructor_name, "
                   + "u_stud.full_name AS student_name, u_stud.email AS student_email "
                   + "FROM enrollments e "
                   + "JOIN courses c ON e.course_id = c.course_id "
                   + "JOIN users u_inst ON c.instructor_id = u_inst.user_id "
                   + "JOIN users u_stud ON e.user_id = u_stud.user_id "
                   + "ORDER BY e.enrolled_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Enrollment en = mapResultSetToEnrollment(rs);
                populateProgress(conn, en);
                list.add(en);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all enrollments", e);
        }
        return list;
    }

    public boolean markLessonCompleted(int enrollmentId, int lessonId) {
        String sql = "INSERT IGNORE INTO lesson_progress (enrollment_id, lesson_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            ps.setInt(2, lessonId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error marking lesson completed", e);
        }
        return false;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM enrollments";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting enrollments", e);
        }
        return 0;
    }

    public int countByInstructor(int instructorId) {
        String sql = "SELECT COUNT(e.enrollment_id) FROM enrollments e "
                   + "JOIN courses c ON e.course_id = c.course_id "
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
            LOGGER.log(Level.SEVERE, "Error counting enrollments for instructor: " + instructorId, e);
        }
        return 0;
    }

    private void populateProgress(Connection conn, Enrollment en) {
        try {
            // Count total lessons in course
            String totalSql = "SELECT COUNT(l.lesson_id) FROM lessons l "
                            + "JOIN modules m ON l.module_id = m.module_id "
                            + "WHERE m.course_id = ?";
            int total = 0;
            try (PreparedStatement ps = conn.prepareStatement(totalSql)) {
                ps.setInt(1, en.getCourseId());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        total = rs.getInt(1);
                    }
                }
            }

            // Count completed lessons for this enrollment
            String completedSql = "SELECT COUNT(*) FROM lesson_progress WHERE enrollment_id = ?";
            int completed = 0;
            try (PreparedStatement ps = conn.prepareStatement(completedSql)) {
                ps.setInt(1, en.getEnrollmentId());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        completed = rs.getInt(1);
                    }
                }
            }

            en.setTotalLessons(total);
            en.setCompletedLessons(completed);
            double pct = total > 0 ? (completed * 100.0) / total : 0.0;
            en.setProgressPercentage(Math.round(pct * 10.0) / 10.0);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error computing progress for enrollment: " + en.getEnrollmentId(), e);
        }
    }

    private Enrollment mapResultSetToEnrollment(ResultSet rs) throws SQLException {
        Enrollment e = new Enrollment();
        e.setEnrollmentId(rs.getInt("enrollment_id"));
        e.setUserId(rs.getInt("user_id"));
        e.setCourseId(rs.getInt("course_id"));
        e.setEnrolledAt(rs.getTimestamp("enrolled_at"));
        e.setStatus(rs.getString("status"));
        e.setCourseTitle(rs.getString("course_title"));
        e.setCourseCategory(rs.getString("course_category"));
        e.setInstructorName(rs.getString("instructor_name"));
        e.setStudentName(rs.getString("student_name"));
        e.setStudentEmail(rs.getString("student_email"));
        return e;
    }
}
