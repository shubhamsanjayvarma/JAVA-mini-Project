package com.ocms.controller;

import com.ocms.model.Course;
import com.ocms.model.Module;
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
import java.util.List;

/**
 * Public course syllabus and details controller.
 */
@WebServlet(urlPatterns = {"/course-details"})
public class CourseDetailsServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();
    private final EnrollmentService enrollmentService = new EnrollmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/courses");
            return;
        }

        try {
            int courseId = Integer.parseInt(idParam.trim());
            Course course = courseService.getCourseById(courseId);
            if (course == null) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            List<Module> curriculum = courseService.getCourseCurriculum(courseId, null);

            // Check if current logged in student is already enrolled
            boolean isEnrolled = false;
            HttpSession session = request.getSession(false);
            if (SessionUtil.isLoggedIn(session) && "STUDENT".equalsIgnoreCase(SessionUtil.getLoggedInUserRole(session))) {
                Integer userId = SessionUtil.getLoggedInUserId(session);
                if (userId != null) {
                    isEnrolled = enrollmentService.isEnrolled(userId, courseId);
                }
            }

            request.setAttribute("course", course);
            request.setAttribute("curriculum", curriculum);
            request.setAttribute("isEnrolled", isEnrolled);
            request.getRequestDispatcher("/course-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/courses");
        }
    }
}
