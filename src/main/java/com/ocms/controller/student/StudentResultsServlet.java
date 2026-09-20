package com.ocms.controller.student;

import com.ocms.model.Attempt;
import com.ocms.service.AssessmentService;
import com.ocms.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller displaying assessment results and attempt reviews for Students.
 */
@WebServlet(urlPatterns = {"/student/results"})
public class StudentResultsServlet extends HttpServlet {

    private final AssessmentService assessmentService = new AssessmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = SessionUtil.getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String attemptIdParam = request.getParameter("attemptId");
        if (attemptIdParam != null && !attemptIdParam.trim().isEmpty()) {
            try {
                int attemptId = Integer.parseInt(attemptIdParam.trim());
                Attempt attempt = assessmentService.getAttemptDetails(attemptId);

                // Verify attempt belongs to current user
                if (attempt != null && attempt.getUserId() == userId) {
                    request.setAttribute("attempt", attempt);
                }
            } catch (NumberFormatException ignored) {
            }
        }

        List<Attempt> attempts = assessmentService.getStudentAttempts(userId);
        request.setAttribute("attempts", attempts);
        request.getRequestDispatcher("/student/results.jsp").forward(request, response);
    }
}
