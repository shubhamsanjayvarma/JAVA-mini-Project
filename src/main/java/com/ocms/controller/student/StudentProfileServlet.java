package com.ocms.controller.student;

import com.ocms.model.User;
import com.ocms.service.UserService;
import com.ocms.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller for managing Student Profile information and password.
 */
@WebServlet(urlPatterns = {"/student/profile"})
public class StudentProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = SessionUtil.getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = userService.getUserById(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = SessionUtil.getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        User user = userService.getUserById(userId);

        if ("updateProfile".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String bio = request.getParameter("bio");

            if (fullName != null && !fullName.trim().isEmpty()) {
                user.setFullName(fullName.trim());
                user.setPhone(phone != null ? phone.trim() : null);
                user.setBio(bio != null ? bio.trim() : null);
                userService.updateProfile(user);
                SessionUtil.setLoggedInUser(session, user);
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Full name cannot be blank.");
            }
        } else if ("changePassword".equals(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (newPassword == null || !newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "New passwords do not match.");
            } else if (newPassword.length() < 6) {
                request.setAttribute("errorMessage", "Password must be at least 6 characters.");
            } else {
                boolean success = userService.changePassword(userId, oldPassword, newPassword);
                if (success) {
                    request.setAttribute("successMessage", "Password changed successfully.");
                } else {
                    request.setAttribute("errorMessage", "Current password was incorrect.");
                }
            }
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
    }
}
