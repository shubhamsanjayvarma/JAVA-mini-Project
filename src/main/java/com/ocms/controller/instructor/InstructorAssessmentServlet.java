package com.ocms.controller.instructor;

import com.ocms.model.Assessment;
import com.ocms.model.Course;
import com.ocms.model.Option;
import com.ocms.model.Question;
import com.ocms.service.AssessmentService;
import com.ocms.service.CourseService;
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
 * Controller for instructors to create assessments and add multiple-choice questions.
 */
@WebServlet(urlPatterns = {"/instructor/assessments"})
public class InstructorAssessmentServlet extends HttpServlet {

    private final AssessmentService assessmentService = new AssessmentService();
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

        String assessmentIdParam = request.getParameter("id");
        if (assessmentIdParam != null && !assessmentIdParam.trim().isEmpty()) {
            try {
                int assessmentId = Integer.parseInt(assessmentIdParam.trim());
                Assessment assessment = assessmentService.getAssessmentById(assessmentId);
                request.setAttribute("assessment", assessment);
            } catch (NumberFormatException ignored) {}
        }

        List<Course> courses = courseService.getCoursesByInstructor(instructorId);
        List<Assessment> assessments = assessmentService.getAssessmentsByInstructor(instructorId);

        request.setAttribute("courses", courses);
        request.setAttribute("assessments", assessments);
        request.getRequestDispatcher("/instructor/assessments.jsp").forward(request, response);
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

        if ("createAssessment".equals(action)) {
            String courseIdParam = request.getParameter("courseId");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String passScoreParam = request.getParameter("passingScore");
            String totalMarksParam = request.getParameter("totalMarks");
            String durationParam = request.getParameter("durationMinutes");

            try {
                int courseId = Integer.parseInt(courseIdParam.trim());
                int passScore = Integer.parseInt(passScoreParam.trim());
                int totalMarks = Integer.parseInt(totalMarksParam.trim());
                int duration = Integer.parseInt(durationParam.trim());

                Assessment a = new Assessment();
                a.setCourseId(courseId);
                a.setTitle(title.trim());
                a.setDescription(description != null ? description.trim() : "");
                a.setPassingScore(passScore);
                a.setTotalMarks(totalMarks);
                a.setDurationMinutes(duration);

                assessmentService.createAssessment(a);
            } catch (Exception ignored) {}

        } else if ("addQuestion".equals(action)) {
            String assessmentIdParam = request.getParameter("assessmentId");
            String questionText = request.getParameter("questionText");
            String marksParam = request.getParameter("marks");
            String correctOptionIndex = request.getParameter("correctOption"); // "1", "2", "3", "4"

            try {
                int assessmentId = Integer.parseInt(assessmentIdParam.trim());
                int marks = Integer.parseInt(marksParam.trim());
                int correctIdx = Integer.parseInt(correctOptionIndex.trim());

                Question q = new Question();
                q.setAssessmentId(assessmentId);
                q.setQuestionText(questionText.trim());
                q.setMarks(marks);
                q.setOrderIndex(1);

                List<Option> options = new ArrayList<>();
                for (int i = 1; i <= 4; i++) {
                    String optText = request.getParameter("option" + i);
                    if (optText != null && !optText.trim().isEmpty()) {
                        Option opt = new Option();
                        opt.setOptionText(optText.trim());
                        opt.setCorrect(i == correctIdx);
                        opt.setOrderIndex(i);
                        options.add(opt);
                    }
                }

                assessmentService.addQuestion(q, options);
                response.sendRedirect(request.getContextPath() + "/instructor/assessments?id=" + assessmentId);
                return;
            } catch (Exception ignored) {}

        } else if ("deleteAssessment".equals(action)) {
            String assessmentIdParam = request.getParameter("assessmentId");
            if (assessmentIdParam != null) {
                try {
                    int assessmentId = Integer.parseInt(assessmentIdParam.trim());
                    assessmentService.deleteAssessment(assessmentId);
                } catch (NumberFormatException ignored) {}
            }
        }

        response.sendRedirect(request.getContextPath() + "/instructor/assessments");
    }
}
