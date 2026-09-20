package com.ocms.controller.admin;

import com.ocms.model.User;
import com.ocms.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for administrators to manage institutional user accounts.
 */
@WebServlet(urlPatterns = {"/admin/users"})
public class AdminUsersServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("createUser".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String phone = request.getParameter("phone");

            if (fullName != null && email != null && password != null) {
                User u = new User();
                u.setFullName(fullName.trim());
                u.setEmail(email.trim());
                u.setRole(role != null ? role.trim() : "INSTRUCTOR");
                u.setStatus("ACTIVE");
                u.setPhone(phone != null ? phone.trim() : null);
                userService.createUser(u, password);
            }
        } else if ("toggleStatus".equals(action)) {
            String userIdParam = request.getParameter("userId");
            if (userIdParam != null) {
                try {
                    int userId = Integer.parseInt(userIdParam.trim());
                    User u = userService.getUserById(userId);
                    if (u != null) {
                        u.setStatus("ACTIVE".equalsIgnoreCase(u.getStatus()) ? "INACTIVE" : "ACTIVE");
                        userService.updateProfile(u);
                    }
                } catch (NumberFormatException ignored) {}
            }
        } else if ("deleteUser".equals(action)) {
            String userIdParam = request.getParameter("userId");
            if (userIdParam != null) {
                try {
                    int userId = Integer.parseInt(userIdParam.trim());
                    userService.deleteUser(userId);
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
