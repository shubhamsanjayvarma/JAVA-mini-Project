package com.ocms.controller.student;

import com.ocms.model.Assessment;
import com.ocms.model.Attempt;
import com.ocms.model.Enrollment;
import com.ocms.service.AssessmentService;
import com.ocms.service.EnrollmentService;
import com.ocms.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Controller for students to take assessments and submit multiple choice answers.
 */
@WebServlet(urlPatterns = {"/student/assessment"})
public class StudentAssessmentServlet extends HttpServlet {

    private final AssessmentService assessmentService = new AssessmentService();
    private final EnrollmentService enrollmentService = new EnrollmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = SessionUtil.getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
            return;
        }

        try {
            int assessmentId = Integer.parseInt(idParam.trim());
            Assessment assessment = assessmentService.getAssessmentById(assessmentId);

            if (assessment == null) {
                response.sendRedirect(request.getContextPath() + "/student/my-courses");
                return;
            }

            // Verify student is enrolled in this course
            Enrollment enrollment = enrollmentService.getEnrollment(userId, assessment.getCourseId());
            if (enrollment == null) {
                response.sendRedirect(request.getContextPath() + "/error?code=403");
                return;
            }

            request.setAttribute("assessment", assessment);
            request.setAttribute("enrollment", enrollment);
            request.getRequestDispatcher("/student/assessment.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
        }
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

        String assessmentIdParam = request.getParameter("assessmentId");
        String enrollmentIdParam = request.getParameter("enrollmentId");

        if (assessmentIdParam == null || enrollmentIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
            return;
        }

        try {
            int assessmentId = Integer.parseInt(assessmentIdParam.trim());
            int enrollmentId = Integer.parseInt(enrollmentIdParam.trim());

            // Extract question choices from form: param names format "q_<questionId>"
            Map<Integer, Integer> answers = new HashMap<>();
            for (String paramName : request.getParameterMap().keySet()) {
                if (paramName.startsWith("q_")) {
                    try {
                        int questionId = Integer.parseInt(paramName.substring(2));
                        String optVal = request.getParameter(paramName);
                        if (optVal != null && !optVal.trim().isEmpty()) {
                            answers.put(questionId, Integer.parseInt(optVal.trim()));
                        }
                    } catch (NumberFormatException ignored) {
                    }
                }
            }

            Attempt attempt = assessmentService.submitAssessment(assessmentId, userId, enrollmentId, answers);
            if (attempt != null) {
                response.sendRedirect(request.getContextPath() + "/student/results?attemptId=" + attempt.getAttemptId());
            } else {
                response.sendRedirect(request.getContextPath() + "/student/assessment?id=" + assessmentId + "&error=submission_failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
        }
    }
}
