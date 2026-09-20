package com.ocms.controller;

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
 * Controller managing User Authentication and Session establishment.
 */
@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (SessionUtil.isLoggedIn(session)) {
            String role = SessionUtil.getLoggedInUserRole(session);
            redirectToDashboard(response, request.getContextPath(), role);
            return;
        }

        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
            request.setAttribute("errorMessage", "Invalid email address or password.");
        } else if ("auth_required".equals(error)) {
            request.setAttribute("errorMessage", "Please log in to access the requested page.");
        }

        String msg = request.getParameter("msg");
        if ("logged_out".equals(msg)) {
            request.setAttribute("successMessage", "You have been successfully logged out.");
        } else if ("registered".equals(msg)) {
            request.setAttribute("successMessage", "Registration successful! Please log in with your credentials.");
        }

        request.setAttribute("isAuthPage", true);
        request.setAttribute("isPublicPage", true);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("isAuthPage", true);
            request.setAttribute("isPublicPage", true);
            request.setAttribute("errorMessage", "Both email and password are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userService.authenticate(email, password);
        if (user != null) {
            HttpSession session = request.getSession(true);
            SessionUtil.setLoggedInUser(session, user);
            redirectToDashboard(response, request.getContextPath(), user.getRole());
        } else {
            request.setAttribute("isAuthPage", true);
            request.setAttribute("isPublicPage", true);
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void redirectToDashboard(HttpServletResponse response, String contextPath, String role)
            throws IOException {
        if ("STUDENT".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/student/dashboard");
        } else if ("INSTRUCTOR".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/instructor/dashboard");
        } else if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/admin/dashboard");
        } else {
            response.sendRedirect(contextPath + "/index.jsp");
        }
    }
}
