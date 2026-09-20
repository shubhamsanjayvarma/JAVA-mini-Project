package com.ocms.controller.student;

import com.ocms.service.DashboardService;
import com.ocms.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * Controller for the Student Dashboard.
 */
@WebServlet(urlPatterns = {"/student/dashboard"})
public class StudentDashboardServlet extends HttpServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = SessionUtil.getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Map<String, Object> dashboardData = dashboardService.getStudentDashboard(userId);
        request.setAttribute("stats", dashboardData);
        request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
    }
}
