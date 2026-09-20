package com.ocms.dao;

import com.ocms.model.Lesson;
import com.ocms.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * JDBC Data Access Object for Lessons.
 */
public class LessonDAO {

    private static final Logger LOGGER = Logger.getLogger(LessonDAO.class.getName());

    public List<Lesson> findByModuleId(int moduleId) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT * FROM lessons WHERE module_id = ? ORDER BY order_index ASC, lesson_id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToLesson(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving lessons for module: " + moduleId, e);
        }
        return list;
    }

    public Lesson findById(int lessonId) {
        String sql = "SELECT * FROM lessons WHERE lesson_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToLesson(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding lesson by id: " + lessonId, e);
        }
        return null;
    }

    public boolean create(Lesson lesson) {
        String sql = "INSERT INTO lessons (module_id, title, content, duration_minutes, order_index) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, lesson.getModuleId());
            ps.setString(2, lesson.getTitle());
            ps.setString(3, lesson.getContent());
            ps.setInt(4, lesson.getDurationMinutes());
            ps.setInt(5, lesson.getOrderIndex());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        lesson.setLessonId(gk.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating lesson: " + lesson.getTitle(), e);
        }
        return false;
    }

    public boolean update(Lesson lesson) {
        String sql = "UPDATE lessons SET title = ?, content = ?, duration_minutes = ?, order_index = ? WHERE lesson_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lesson.getTitle());
            ps.setString(2, lesson.getContent());
            ps.setInt(3, lesson.getDurationMinutes());
            ps.setInt(4, lesson.getOrderIndex());
            ps.setInt(5, lesson.getLessonId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating lesson id: " + lesson.getLessonId(), e);
        }
        return false;
    }

    public boolean delete(int lessonId) {
        String sql = "DELETE FROM lessons WHERE lesson_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting lesson id: " + lessonId, e);
        }
        return false;
    }

    public int countByCourseId(int courseId) {
        String sql = "SELECT COUNT(l.lesson_id) FROM lessons l "
                   + "JOIN modules m ON l.module_id = m.module_id "
                   + "WHERE m.course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting lessons for course: " + courseId, e);
        }
        return 0;
    }

    public Set<Integer> findCompletedLessonIds(int enrollmentId) {
        Set<Integer> completed = new HashSet<>();
        String sql = "SELECT lesson_id FROM lesson_progress WHERE enrollment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, enrollmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    completed.add(rs.getInt("lesson_id"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving completed lessons for enrollment: " + enrollmentId, e);
        }
        return completed;
    }

    private Lesson mapResultSetToLesson(ResultSet rs) throws SQLException {
        Lesson l = new Lesson();
        l.setLessonId(rs.getInt("lesson_id"));
        l.setModuleId(rs.getInt("module_id"));
        l.setTitle(rs.getString("title"));
        l.setContent(rs.getString("content"));
        l.setDurationMinutes(rs.getInt("duration_minutes"));
        l.setOrderIndex(rs.getInt("order_index"));
        l.setCreatedAt(rs.getTimestamp("created_at"));
        return l;
    }
}
