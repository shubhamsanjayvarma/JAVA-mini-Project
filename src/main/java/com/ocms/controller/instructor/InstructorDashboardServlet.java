package com.ocms.controller.instructor;

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
 * Controller for the Instructor Dashboard.
 */
@WebServlet(urlPatterns = {"/instructor/dashboard"})
public class InstructorDashboardServlet extends HttpServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer instructorId = SessionUtil.getLoggedInUserId(session);

        if (instructorId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Map<String, Object> stats = dashboardService.getInstructorDashboard(instructorId);
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/instructor/dashboard.jsp").forward(request, response);
    }
}
