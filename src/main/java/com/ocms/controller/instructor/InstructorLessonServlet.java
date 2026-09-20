package com.ocms.controller.instructor;

import com.ocms.model.Course;
import com.ocms.model.Lesson;
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

/**
 * Controller for managing Lessons within a Module.
 */
@WebServlet(urlPatterns = {"/instructor/lessons"})
public class InstructorLessonServlet extends HttpServlet {

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

        String moduleIdParam = request.getParameter("moduleId");
        if (moduleIdParam == null || moduleIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        try {
            int moduleId = Integer.parseInt(moduleIdParam.trim());
            Module module = courseService.getModuleById(moduleId);

            if (module == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses");
                return;
            }

            Course course = courseService.getCourseById(module.getCourseId());
            if (course == null || course.getInstructorId() != instructorId) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses");
                return;
            }

            request.setAttribute("module", module);
            request.setAttribute("course", course);
            request.getRequestDispatcher("/instructor/lessons.jsp").forward(request, response);
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
        String moduleIdParam = request.getParameter("moduleId");
        String courseIdParam = request.getParameter("courseId");

        if (moduleIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        int moduleId = Integer.parseInt(moduleIdParam.trim());
        Module module = courseService.getModuleById(moduleId);
        if (module == null) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        Course course = courseService.getCourseById(module.getCourseId());
        if (course == null || course.getInstructorId() != instructorId) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses");
            return;
        }

        if ("create".equals(action)) {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String durationParam = request.getParameter("durationMinutes");
            String orderParam = request.getParameter("orderIndex");

            int duration = 15;
            int order = 1;
            try {
                if (durationParam != null) duration = Integer.parseInt(durationParam.trim());
                if (orderParam != null) order = Integer.parseInt(orderParam.trim());
            } catch (NumberFormatException ignored) {}

            if (title != null && !title.trim().isEmpty() && content != null && !content.trim().isEmpty()) {
                Lesson l = new Lesson();
                l.setModuleId(moduleId);
                l.setTitle(title.trim());
                l.setContent(content.trim());
                l.setDurationMinutes(duration);
                l.setOrderIndex(order);
                courseService.createLesson(l);
            }
        } else if ("delete".equals(action)) {
            String lessonIdParam = request.getParameter("lessonId");
            if (lessonIdParam != null) {
                try {
                    int lessonId = Integer.parseInt(lessonIdParam.trim());
                    courseService.deleteLesson(lessonId);
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(request.getContextPath() + "/instructor/modules?courseId=" + course.getCourseId());
    }
}
