package com.ocms.controller.instructor;

import com.ocms.model.Course;
import com.ocms.model.Module;
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
 * Controller for managing Course Modules.
 */
@WebServlet(urlPatterns = {"/instructor/modules"})
public class InstructorModuleServlet extends HttpServlet {

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

        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam == null || courseIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdParam.trim());
            Course course = courseService.getCourseById(courseId);

            if (course == null || course.getInstructorId() != instructorId) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses");
                return;
            }

            List<Module> modules = courseService.getCourseCurriculum(courseId, null);
            request.setAttribute("course", course);
            request.setAttribute("modules", modules);
            request.getRequestDispatcher("/instructor/modules.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
        }
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

        if (courseIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        int courseId = Integer.parseInt(courseIdParam.trim());
        Course course = courseService.getCourseById(courseId);
        if (course == null || course.getInstructorId() != instructorId) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        if ("create".equals(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String orderParam = request.getParameter("orderIndex");

            int order = 1;
            try {
                if (orderParam != null) order = Integer.parseInt(orderParam.trim());
            } catch (NumberFormatException ignored) {}

            if (title != null && !title.trim().isEmpty()) {
                Module m = new Module();
                m.setCourseId(courseId);
                m.setTitle(title.trim());
                m.setDescription(description != null ? description.trim() : "");
                m.setOrderIndex(order);
                courseService.createModule(m);
            }
        } else if ("delete".equals(action)) {
            String moduleIdParam = request.getParameter("moduleId");
            if (moduleIdParam != null) {
                try {
                    int moduleId = Integer.parseInt(moduleIdParam.trim());
                    courseService.deleteModule(moduleId);
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(request.getContextPath() + "/instructor/modules?courseId=" + courseId);
    }
}
