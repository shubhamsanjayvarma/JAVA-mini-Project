package com.ocms.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Centralized JDBC Database Connection Utility.
 * Manages database driver initialization and establishes connections from db.properties.
 */
public class DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                LOGGER.severe("Unable to locate db.properties on classpath.");
            } else {
                properties.load(input);
                String driver = properties.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                Class.forName(driver);
                LOGGER.info("MySQL JDBC Driver registered successfully: " + driver);
            }
        } catch (IOException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize database driver or read db.properties", e);
        }
    }

    private DBConnection() {
        // Private constructor to prevent instantiation
    }

    /**
     * Obtains a new JDBC database connection.
     * Callers must close the connection using try-with-resources.
     *
     * @return an open java.sql.Connection
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        String url = properties.getProperty("db.url");
        String user = properties.getProperty("db.username");
        String pass = properties.getProperty("db.password");

        if (url == null) {
            throw new SQLException("Database connection URL not configured in db.properties.");
        }

        return DriverManager.getConnection(url, user, pass);
    }

    /**
     * Utility method to safely close a ResultSet.
     */
    public static void close(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Failed to close ResultSet", e);
            }
        }
    }

    /**
     * Utility method to safely close a Statement.
     */
    public static void close(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Failed to close Statement", e);
            }
        }
    }

    /**
     * Utility method to safely close a Connection.
     */
    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Failed to close Connection", e);
            }
        }
    }

    /**
     * Utility method to rollback a transaction safely.
     */
    public static void rollback(Connection conn) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Failed to rollback database transaction", e);
            }
        }
    }
}
