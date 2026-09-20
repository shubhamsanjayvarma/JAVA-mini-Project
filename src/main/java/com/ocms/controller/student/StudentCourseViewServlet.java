package com.ocms.controller.student;

import com.ocms.model.Assessment;
import com.ocms.model.Course;
import com.ocms.model.Enrollment;
import com.ocms.model.Lesson;
import com.ocms.model.Module;
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
import java.util.List;
import java.util.Set;

/**
 * Controller allowing enrolled students to view course curriculum, read lessons,
 * and mark lessons as completed to advance their real progress.
 */
@WebServlet(urlPatterns = {"/student/course"})
public class StudentCourseViewServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();
    private final EnrollmentService enrollmentService = new EnrollmentService();
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

        String courseIdParam = request.getParameter("id");
        if (courseIdParam == null || courseIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdParam.trim());
            Enrollment enrollment = enrollmentService.getEnrollment(userId, courseId);

            if (enrollment == null) {
                // Student not enrolled in this course
                response.sendRedirect(request.getContextPath() + "/course-details?id=" + courseId);
                return;
            }

            Course course = courseService.getCourseById(courseId);
            Set<Integer> completedLessonIds = enrollmentService.getCompletedLessonIds(enrollment.getEnrollmentId());
            List<Module> curriculum = courseService.getCourseCurriculum(courseId, completedLessonIds);
            List<Assessment> assessments = assessmentService.getAssessmentsByCourse(courseId);

            // Active lesson being viewed
            Lesson activeLesson = null;
            String lessonIdParam = request.getParameter("lessonId");
            if (lessonIdParam != null && !lessonIdParam.trim().isEmpty()) {
                int lessonId = Integer.parseInt(lessonIdParam.trim());
                activeLesson = courseService.getLessonById(lessonId);
                if (activeLesson != null) {
                    activeLesson.setCompleted(completedLessonIds.contains(activeLesson.getLessonId()));
                }
            } else if (!curriculum.isEmpty() && !curriculum.get(0).getLessons().isEmpty()) {
                activeLesson = curriculum.get(0).getLessons().get(0);
            }

            request.setAttribute("course", course);
            request.setAttribute("enrollment", enrollment);
            request.setAttribute("curriculum", curriculum);
            request.setAttribute("activeLesson", activeLesson);
            request.setAttribute("assessments", assessments);

            request.getRequestDispatcher("/student/course.jsp").forward(request, response);
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

        String courseIdParam = request.getParameter("courseId");
        String lessonIdParam = request.getParameter("lessonId");

        if (courseIdParam != null && lessonIdParam != null) {
            try {
                int courseId = Integer.parseInt(courseIdParam.trim());
                int lessonId = Integer.parseInt(lessonIdParam.trim());
                Enrollment enrollment = enrollmentService.getEnrollment(userId, courseId);

                if (enrollment != null) {
                    enrollmentService.markLessonCompleted(enrollment.getEnrollmentId(), lessonId);
                }

                response.sendRedirect(request.getContextPath() + "/student/course?id=" + courseId + "&lessonId=" + lessonId);
                return;
            } catch (NumberFormatException ignored) {
            }
        }

        response.sendRedirect(request.getContextPath() + "/student/my-courses");
    }
}
