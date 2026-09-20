package com.ocms.controller.instructor;

import com.ocms.model.Attempt;
import com.ocms.model.Course;
import com.ocms.model.Enrollment;
import com.ocms.service.AssessmentService;
import com.ocms.service.CourseService;
import com.ocms.service.EnrollmentService;
import com.ocms.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller for instructors to monitor enrolled students and their assessment performance.
 */
@WebServlet(urlPatterns = {"/instructor/students"})
public class InstructorStudentsServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();
    private final EnrollmentService enrollmentService = new EnrollmentService();
    private final AssessmentService assessmentService = new AssessmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer instructorId = SessionUtil.getLoggedInUserId(session);

        if (instructorId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Course> myCourses = courseService.getCoursesByInstructor(instructorId);
        List<Enrollment> enrolledStudents = new ArrayList<>();

        for (Course c : myCourses) {
            enrolledStudents.addAll(enrollmentService.getCourseEnrollments(c.getCourseId()));
        }

        // Check if an assessment is selected to see student scores
        String assessmentIdParam = request.getParameter("assessmentId");
        if (assessmentIdParam != null && !assessmentIdParam.trim().isEmpty()) {
            try {
                int assessmentId = Integer.parseInt(assessmentIdParam.trim());
                List<Attempt> attempts = assessmentService.getAssessmentAttempts(assessmentId);
                request.setAttribute("assessmentAttempts", attempts);
                request.setAttribute("selectedAssessment", assessmentService.getAssessmentById(assessmentId));
            } catch (NumberFormatException ignored) {}
        }

        request.setAttribute("courses", myCourses);
        request.setAttribute("enrollments", enrolledStudents);
        request.getRequestDispatcher("/instructor/students.jsp").forward(request, response);
    }
}
