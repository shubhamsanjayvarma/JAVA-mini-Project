package com.ocms.dao;

import com.ocms.model.Module;
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
 * JDBC Data Access Object for Modules.
 */
public class ModuleDAO {

    private static final Logger LOGGER = Logger.getLogger(ModuleDAO.class.getName());

    public List<Module> findByCourseId(int courseId) {
        List<Module> list = new ArrayList<>();
        String sql = "SELECT * FROM modules WHERE course_id = ? ORDER BY order_index ASC, module_id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToModule(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving modules for course: " + courseId, e);
        }
        return list;
    }

    public Module findById(int moduleId) {
        String sql = "SELECT * FROM modules WHERE module_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToModule(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding module by id: " + moduleId, e);
        }
        return null;
    }

    public boolean create(Module module) {
        String sql = "INSERT INTO modules (course_id, title, description, order_index) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, module.getCourseId());
            ps.setString(2, module.getTitle());
            ps.setString(3, module.getDescription());
            ps.setInt(4, module.getOrderIndex());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        module.setModuleId(gk.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating module: " + module.getTitle(), e);
        }
        return false;
    }

    public boolean update(Module module) {
        String sql = "UPDATE modules SET title = ?, description = ?, order_index = ? WHERE module_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, module.getTitle());
            ps.setString(2, module.getDescription());
            ps.setInt(3, module.getOrderIndex());
            ps.setInt(4, module.getModuleId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating module id: " + module.getModuleId(), e);
        }
        return false;
    }

    public boolean delete(int moduleId) {
        String sql = "DELETE FROM modules WHERE module_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, moduleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting module id: " + moduleId, e);
        }
        return false;
    }

    private Module mapResultSetToModule(ResultSet rs) throws SQLException {
        Module m = new Module();
        m.setModuleId(rs.getInt("module_id"));
        m.setCourseId(rs.getInt("course_id"));
        m.setTitle(rs.getString("title"));
        m.setDescription(rs.getString("description"));
        m.setOrderIndex(rs.getInt("order_index"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        return m;
    }
}
