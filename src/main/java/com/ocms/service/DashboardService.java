package com.ocms.service;

import com.ocms.dao.AssessmentDAO;
import com.ocms.dao.AttemptDAO;
import com.ocms.dao.CourseDAO;
import com.ocms.dao.EnrollmentDAO;
import com.ocms.dao.UserDAO;
import com.ocms.model.Attempt;
import com.ocms.model.Course;
import com.ocms.model.Enrollment;
import com.ocms.model.User;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service providing database-driven dashboard statistics.
 * No hardcoded or fake counters.
 */
public class DashboardService {

    private final UserDAO userDAO;
    private final CourseDAO courseDAO;
    private final EnrollmentDAO enrollmentDAO;
    private final AssessmentDAO assessmentDAO;
    private final AttemptDAO attemptDAO;

    public DashboardService() {
        this.userDAO = new UserDAO();
        this.courseDAO = new CourseDAO();
        this.enrollmentDAO = new EnrollmentDAO();
        this.assessmentDAO = new AssessmentDAO();
        this.attemptDAO = new AttemptDAO();
    }

    public Map<String, Object> getStudentDashboard(int userId) {
        Map<String, Object> stats = new HashMap<>();
        List<Enrollment> enrollments = enrollmentDAO.findByUserId(userId);
        List<Attempt> attempts = attemptDAO.findByUserId(userId);

        int completedCourses = 0;
        double sumProgress = 0.0;
        for (Enrollment e : enrollments) {
            sumProgress += e.getProgressPercentage();
            if (e.getProgressPercentage() >= 100.0) {
                completedCourses++;
            }
        }

        double avgProgress = enrollments.isEmpty() ? 0.0 : Math.round((sumProgress / enrollments.size()) * 10.0) / 10.0;

        List<Course> suggestedCourses = courseDAO.findAllPublished();

        stats.put("enrolledCount", enrollments.size());
        stats.put("completedCoursesCount", completedCourses);
        stats.put("averageProgress", avgProgress);
        stats.put("attemptCount", attempts.size());
        stats.put("enrollments", enrollments);
        stats.put("recentAttempts", attempts.size() > 5 ? attempts.subList(0, 5) : attempts);
        stats.put("suggestedCourses", suggestedCourses);
        stats.put("featuredCourse", !suggestedCourses.isEmpty() ? suggestedCourses.get(0) : null);

        return stats;
    }

    public Map<String, Object> getInstructorDashboard(int instructorId) {
        Map<String, Object> stats = new HashMap<>();
        List<Course> courses = courseDAO.findByInstructorId(instructorId);
        int totalStudents = enrollmentDAO.countByInstructor(instructorId);
        int totalAssessments = assessmentDAO.countByInstructor(instructorId);

        stats.put("courseCount", courses.size());
        stats.put("studentCount", totalStudents);
        stats.put("assessmentCount", totalAssessments);
        stats.put("courses", courses);

        return stats;
    }

    public Map<String, Object> getAdminDashboard() {
        Map<String, Object> stats = new HashMap<>();
        int totalUsers = userDAO.countAll();
        int studentCount = userDAO.countByRole("STUDENT");
        int instructorCount = userDAO.countByRole("INSTRUCTOR");
        int adminCount = userDAO.countByRole("ADMIN");
        int courseCount = courseDAO.countAll();
        int enrollmentCount = enrollmentDAO.countAll();

        List<User> recentUsers = userDAO.findAll();
        if (recentUsers.size() > 8) {
            recentUsers = recentUsers.subList(0, 8);
        }

        List<Course> recentCourses = courseDAO.findAll();
        if (recentCourses.size() > 6) {
            recentCourses = recentCourses.subList(0, 6);
        }

        stats.put("totalUsers", totalUsers);
        stats.put("studentCount", studentCount);
        stats.put("instructorCount", instructorCount);
        stats.put("adminCount", adminCount);
        stats.put("courseCount", courseCount);
        stats.put("enrollmentCount", enrollmentCount);
        stats.put("recentUsers", recentUsers);
        stats.put("recentCourses", recentCourses);

        return stats;
    }
}
