package com.ocms.service;

import com.ocms.dao.CourseDAO;
import com.ocms.dao.EnrollmentDAO;
import com.ocms.dao.LessonDAO;
import com.ocms.dao.UserDAO;
import com.ocms.model.Course;
import com.ocms.model.Enrollment;
import com.ocms.model.User;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

/**
 * Service managing Course Enrollments and Progress tracking.
 */
public class EnrollmentService {

    private static final Logger LOGGER = Logger.getLogger(EnrollmentService.class.getName());
    private final EnrollmentDAO enrollmentDAO;
    private final CourseDAO courseDAO;
    private final UserDAO userDAO;
    private final LessonDAO lessonDAO;

    public EnrollmentService() {
        this.enrollmentDAO = new EnrollmentDAO();
        this.courseDAO = new CourseDAO();
        this.userDAO = new UserDAO();
        this.lessonDAO = new LessonDAO();
    }

    /**
     * Enrolls a student in a course with validation.
     *
     * @return null if successful, or error message string if failed
     */
    public String enrollStudent(int userId, int courseId) {
        User user = userDAO.findById(userId);
        if (user == null || !"STUDENT".equalsIgnoreCase(user.getRole())) {
            return "Only registered students may enroll in courses.";
        }

        Course course = courseDAO.findById(courseId);
        if (course == null || !"PUBLISHED".equalsIgnoreCase(course.getStatus())) {
            return "Course is not currently available for enrollment.";
        }

        if (enrollmentDAO.isEnrolled(userId, courseId)) {
            return "You are already enrolled in this course.";
        }

        boolean success = enrollmentDAO.enroll(userId, courseId);
        if (success) {
            LOGGER.info("Student " + userId + " enrolled successfully in course " + courseId);
            return null;
        } else {
            return "Enrollment failed due to a database conflict or error.";
        }
    }

    public boolean isEnrolled(int userId, int courseId) {
        return enrollmentDAO.isEnrolled(userId, courseId);
    }

    public Enrollment getEnrollment(int userId, int courseId) {
        return enrollmentDAO.getEnrollment(userId, courseId);
    }

    public Enrollment getEnrollmentById(int enrollmentId) {
        return enrollmentDAO.findById(enrollmentId);
    }

    public List<Enrollment> getStudentEnrollments(int userId) {
        return enrollmentDAO.findByUserId(userId);
    }

    public List<Enrollment> getCourseEnrollments(int courseId) {
        return enrollmentDAO.findByCourseId(courseId);
    }

    public List<Enrollment> getAllEnrollments() {
        return enrollmentDAO.findAll();
    }

    public boolean markLessonCompleted(int enrollmentId, int lessonId) {
        return enrollmentDAO.markLessonCompleted(enrollmentId, lessonId);
    }

    public Set<Integer> getCompletedLessonIds(int enrollmentId) {
        return lessonDAO.findCompletedLessonIds(enrollmentId);
    }
}
