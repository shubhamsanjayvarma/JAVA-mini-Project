package com.ocms.controller;

import com.ocms.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller managing Student Registration.
 */
@WebServlet(urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String bio = request.getParameter("bio");

        // Basic client validation check server-side
        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            preserveFormFields(request, fullName, email, phone, bio);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        String error = userService.registerStudent(fullName, email, password, phone, bio);
        if (error == null) {
            response.sendRedirect(request.getContextPath() + "/login?msg=registered");
        } else {
            request.setAttribute("errorMessage", error);
            preserveFormFields(request, fullName, email, phone, bio);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private void preserveFormFields(HttpServletRequest req, String name, String email, String phone, String bio) {
        req.setAttribute("fullName", name);
        req.setAttribute("email", email);
        req.setAttribute("phone", phone);
        req.setAttribute("bio", bio);
    }
}
