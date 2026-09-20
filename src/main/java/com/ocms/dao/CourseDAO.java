package com.ocms.dao;

import com.ocms.model.Course;
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
 * JDBC Data Access Object for Courses.
 */
public class CourseDAO {

    private static final Logger LOGGER = Logger.getLogger(CourseDAO.class.getName());

    public Course findById(int courseId) {
        String sql = "SELECT c.*, u.full_name AS instructor_name, "
                   + "(SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id) AS student_count, "
                   + "(SELECT COUNT(*) FROM modules m WHERE m.course_id = c.course_id) AS module_count "
                   + "FROM courses c "
                   + "JOIN users u ON c.instructor_id = u.user_id "
                   + "WHERE c.course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCourse(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding course by id: " + courseId, e);
        }
        return null;
    }

    public List<Course> findAllPublished() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name AS instructor_name, "
                   + "(SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id) AS student_count, "
                   + "(SELECT COUNT(*) FROM modules m WHERE m.course_id = c.course_id) AS module_count "
                   + "FROM courses c "
                   + "JOIN users u ON c.instructor_id = u.user_id "
                   + "WHERE c.status = 'PUBLISHED' "
                   + "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving published courses", e);
        }
        return list;
    }

    public List<Course> findByInstructorId(int instructorId) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name AS instructor_name, "
                   + "(SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id) AS student_count, "
                   + "(SELECT COUNT(*) FROM modules m WHERE m.course_id = c.course_id) AS module_count "
                   + "FROM courses c "
                   + "JOIN users u ON c.instructor_id = u.user_id "
                   + "WHERE c.instructor_id = ? "
                   + "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instructorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToCourse(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving courses for instructor: " + instructorId, e);
        }
        return list;
    }

    public List<Course> findAll() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name AS instructor_name, "
                   + "(SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id) AS student_count, "
                   + "(SELECT COUNT(*) FROM modules m WHERE m.course_id = c.course_id) AS module_count "
                   + "FROM courses c "
                   + "JOIN users u ON c.instructor_id = u.user_id "
                   + "ORDER BY c.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToCourse(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all courses", e);
        }
        return list;
    }

    public List<Course> search(String keyword, String category) {
        List<Course> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT c.*, u.full_name AS instructor_name, "
            + "(SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id) AS student_count, "
            + "(SELECT COUNT(*) FROM modules m WHERE m.course_id = c.course_id) AS module_count "
            + "FROM courses c "
            + "JOIN users u ON c.instructor_id = u.user_id "
            + "WHERE c.status = 'PUBLISHED' "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(c.title) LIKE ? OR LOWER(c.description) LIKE ?) ");
            String term = "%" + keyword.trim().toLowerCase() + "%";
            params.add(term);
            params.add(term);
        }

        if (category != null && !category.trim().isEmpty() && !"ALL".equalsIgnoreCase(category)) {
            sql.append("AND c.category = ? ");
            params.add(category.trim());
        }

        sql.append("ORDER BY c.created_at DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToCourse(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error searching courses", e);
        }
        return list;
    }

    public boolean create(Course course) {
        String sql = "INSERT INTO courses (instructor_id, title, description, category, duration_hours, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, course.getInstructorId());
            ps.setString(2, course.getTitle());
            ps.setString(3, course.getDescription());
            ps.setString(4, course.getCategory());
            ps.setInt(5, course.getDurationHours());
            ps.setString(6, course.getStatus() != null ? course.getStatus() : "PUBLISHED");

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        course.setCourseId(gk.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating course: " + course.getTitle(), e);
        }
        return false;
    }

    public boolean update(Course course) {
        String sql = "UPDATE courses SET title = ?, description = ?, category = ?, duration_hours = ?, status = ? WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setString(3, course.getCategory());
            ps.setInt(4, course.getDurationHours());
            ps.setString(5, course.getStatus());
            ps.setInt(6, course.getCourseId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating course id: " + course.getCourseId(), e);
        }
        return false;
    }

    public boolean delete(int courseId) {
        String sql = "DELETE FROM courses WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting course id: " + courseId, e);
        }
        return false;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM courses";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting courses", e);
        }
        return 0;
    }

    public int countByInstructor(int instructorId) {
        String sql = "SELECT COUNT(*) FROM courses WHERE instructor_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, instructorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting courses for instructor: " + instructorId, e);
        }
        return 0;
    }

    private Course mapResultSetToCourse(ResultSet rs) throws SQLException {
        Course c = new Course();
        c.setCourseId(rs.getInt("course_id"));
        c.setInstructorId(rs.getInt("instructor_id"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setCategory(rs.getString("category"));
        c.setDurationHours(rs.getInt("duration_hours"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));
        c.setInstructorName(rs.getString("instructor_name"));
        c.setEnrolledStudentCount(rs.getInt("student_count"));
        c.setModuleCount(rs.getInt("module_count"));
        return c;
    }
}
