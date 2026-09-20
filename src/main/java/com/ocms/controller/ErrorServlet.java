package com.ocms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Clean, safe error page controller that avoids exposing stack traces.
 */
@WebServlet(urlPatterns = {"/error"})
public class ErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if ("403".equals(code)) {
            request.setAttribute("errorCode", "403");
            request.setAttribute("errorTitle", "Access Denied");
            request.setAttribute("errorMessage", "You do not have permission to access the requested resource.");
        } else if ("404".equals(code)) {
            request.setAttribute("errorCode", "404");
            request.setAttribute("errorTitle", "Resource Not Found");
            request.setAttribute("errorMessage", "The page or item you requested does not exist.");
        } else {
            request.setAttribute("errorCode", "500");
            request.setAttribute("errorTitle", "System Notice");
            request.setAttribute("errorMessage", "An unexpected condition occurred. Please try again or return to home.");
        }
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}
