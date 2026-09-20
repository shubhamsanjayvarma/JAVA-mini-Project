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
import java.util.List;

/**
 * Controller for instructors to view their courses and handle course deletion.
 */
@WebServlet(urlPatterns = {"/instructor/courses"})
public class InstructorCoursesServlet extends HttpServlet {

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

        List<Course> courses = courseService.getCoursesByInstructor(instructorId);
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/instructor/courses.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        String courseIdParam = request.getParameter("courseId");

        if ("delete".equals(action) && courseIdParam != null) {
            try {
                int courseId = Integer.parseInt(courseIdParam.trim());
                Course course = courseService.getCourseById(courseId);
                // Verify instructor owns the course
                if (course != null && course.getInstructorId() == instructorId) {
                    courseService.deleteCourse(courseId);
                }
            } catch (NumberFormatException ignored) {
            }
        }

        response.sendRedirect(request.getContextPath() + "/instructor/courses");
    }
}
