package com.ocms.controller.admin;

import com.ocms.model.Course;
import com.ocms.service.CourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for administrators to monitor and manage all courses across departments.
 */
@WebServlet(urlPatterns = {"/admin/courses"})
public class AdminCoursesServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Course> courses = courseService.getAllCourses();
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/admin/courses.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String courseIdParam = request.getParameter("courseId");

        if (courseIdParam != null) {
            try {
                int courseId = Integer.parseInt(courseIdParam.trim());
                if ("deleteCourse".equals(action)) {
                    courseService.deleteCourse(courseId);
                } else if ("toggleStatus".equals(action)) {
                    Course c = courseService.getCourseById(courseId);
                    if (c != null) {
                        c.setStatus("PUBLISHED".equalsIgnoreCase(c.getStatus()) ? "DRAFT" : "PUBLISHED");
                        courseService.updateCourse(c);
                    }
                }
            } catch (NumberFormatException ignored) {}
        }

        response.sendRedirect(request.getContextPath() + "/admin/courses");
    }
}
