package com.ocms.controller.student;

import com.ocms.model.Enrollment;
import com.ocms.service.EnrollmentService;
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
 * Controller displaying courses the current student is enrolled in.
 */
@WebServlet(urlPatterns = {"/student/my-courses"})
public class StudentCoursesServlet extends HttpServlet {

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

        List<Enrollment> enrollments = enrollmentService.getStudentEnrollments(userId);
        request.setAttribute("enrollments", enrollments);
        request.getRequestDispatcher("/student/my-courses.jsp").forward(request, response);
    }
}
