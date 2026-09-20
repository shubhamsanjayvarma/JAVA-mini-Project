package com.ocms.service;

import com.ocms.dao.UserDAO;
import com.ocms.model.User;
import com.ocms.util.PasswordUtil;
import java.util.List;
import java.util.logging.Logger;

/**
 * Service handling User management, Registration, and Authentication.
 */
public class UserService {

    private static final Logger LOGGER = Logger.getLogger(UserService.class.getName());
    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * Authenticates a user by email and plaintext password.
     *
     * @param email    user's email address
     * @param password plaintext password
     * @return User object if credentials are valid and user is ACTIVE; null otherwise
     */
    public User authenticate(String email, String password) {
        if (email == null || password == null) {
            return null;
        }

        User user = userDAO.findByEmail(email.trim().toLowerCase());
        if (user == null) {
            LOGGER.warning("Authentication failed: User not found for email: " + email);
            return null;
        }

        if (!"ACTIVE".equalsIgnoreCase(user.getStatus())) {
            LOGGER.warning("Authentication rejected: Account is inactive for email: " + email);
            return null;
        }

        if (PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            return user;
        }

        LOGGER.warning("Authentication failed: Incorrect password for email: " + email);
        return null;
    }

    /**
     * Registers a new student account.
     *
     * @return error message if registration fails, or null if successful
     */
    public String registerStudent(String fullName, String email, String password, String phone, String bio) {
        return registerUser(fullName, email, password, phone, bio, "STUDENT");
    }

    /**
     * Registers a new user account with a specified role (STUDENT, INSTRUCTOR, ADMIN).
     *
     * @return error message if registration fails, or null if successful
     */
    public String registerUser(String fullName, String email, String password, String phone, String bio, String role) {
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Full name is required.";
        }
        if (email == null || !email.contains("@") || !email.contains(".")) {
            return "A valid email address is required.";
        }
        if (password == null || password.length() < 6) {
            return "Password must be at least 6 characters in length.";
        }

        String normalizedEmail = email.trim().toLowerCase();
        if (userDAO.findByEmail(normalizedEmail) != null) {
            return "An account with email " + normalizedEmail + " already exists.";
        }

        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(normalizedEmail);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        if (role != null && !role.trim().isEmpty()) {
            String upper = role.trim().toUpperCase();
            if ("INSTRUCTOR".equals(upper) || "ADMIN".equals(upper)) {
                user.setRole(upper);
            } else {
                user.setRole("STUDENT");
            }
        } else {
            user.setRole("STUDENT");
        }
        user.setStatus("ACTIVE");
        user.setPhone(phone != null ? phone.trim() : null);
        user.setBio(bio != null ? bio.trim() : null);

        boolean created = userDAO.create(user);
        return created ? null : "Failed to create account due to a database error.";
    }

    /**
     * Creates a new user (used by administrators to create instructors or admins).
     */
    public String createUser(User user, String password) {
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return "Email is required.";
        }
        if (password == null || password.length() < 6) {
            return "Password must be at least 6 characters.";
        }

        String normalizedEmail = user.getEmail().trim().toLowerCase();
        if (userDAO.findByEmail(normalizedEmail) != null) {
            return "Email already in use.";
        }

        user.setEmail(normalizedEmail);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        return userDAO.create(user) ? null : "Database error creating user.";
    }

    public boolean updateProfile(User user) {
        return userDAO.update(user);
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        User user = userDAO.findById(userId);
        if (user == null || newPassword == null || newPassword.length() < 6) {
            return false;
        }

        if (!PasswordUtil.verifyPassword(oldPassword, user.getPasswordHash())) {
            return false;
        }

        String newHash = PasswordUtil.hashPassword(newPassword);
        return userDAO.updatePassword(userId, newHash);
    }

    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    public User getUserById(int userId) {
        return userDAO.findById(userId);
    }

    public boolean deleteUser(int userId) {
        return userDAO.delete(userId);
    }
}
