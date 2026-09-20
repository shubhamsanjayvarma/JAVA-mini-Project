package com.ocms.controller.instructor;

import com.ocms.model.Course;
import com.ocms.service.CourseService;
import com.ocms.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller for creating and editing Courses.
 */
@WebServlet(urlPatterns = {"/instructor/course-form"})
public class InstructorCourseFormServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer instructorId = SessionUtil.getLoggedInUserId(session);

        if (instructorId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int courseId = Integer.parseInt(idParam.trim());
                Course course = courseService.getCourseById(courseId);
                if (course != null && course.getInstructorId() == instructorId) {
                    request.setAttribute("course", course);
                } else {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses");
                    return;
                }
            } catch (NumberFormatException ignored) {
            }
        }

        request.getRequestDispatcher("/instructor/course-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer instructorId = SessionUtil.getLoggedInUserId(session);

        if (instructorId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("courseId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String durationParam = request.getParameter("durationHours");
        String status = request.getParameter("status");

        if (title == null || title.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Title and description are required.");
            request.getRequestDispatcher("/instructor/course-form.jsp").forward(request, response);
            return;
        }

        int duration = 0;
        try {
            if (durationParam != null && !durationParam.trim().isEmpty()) {
                duration = Integer.parseInt(durationParam.trim());
            }
        } catch (NumberFormatException ignored) {
        }

        if (idParam != null && !idParam.trim().isEmpty()) {
            // Edit existing course
            try {
                int courseId = Integer.parseInt(idParam.trim());
                Course course = courseService.getCourseById(courseId);
                if (course != null && course.getInstructorId() == instructorId) {
                    course.setTitle(title.trim());
                    course.setDescription(description.trim());
                    course.setCategory(category != null ? category.trim() : "General");
                    course.setDurationHours(duration);
                    course.setStatus(status != null ? status.trim() : "PUBLISHED");
                    courseService.updateCourse(course);
                }
            } catch (NumberFormatException ignored) {
            }
        } else {
            // Create new course
            Course course = new Course();
            course.setInstructorId(instructorId);
            course.setTitle(title.trim());
            course.setDescription(description.trim());
            course.setCategory(category != null ? category.trim() : "General");
            course.setDurationHours(duration);
            course.setStatus(status != null ? status.trim() : "PUBLISHED");
            courseService.createCourse(course);
        }

        response.sendRedirect(request.getContextPath() + "/instructor/courses");
    }
}
