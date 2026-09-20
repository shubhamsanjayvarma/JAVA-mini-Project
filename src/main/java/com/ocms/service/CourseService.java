package com.ocms.service;

import com.ocms.dao.CourseDAO;
import com.ocms.dao.LessonDAO;
import com.ocms.dao.ModuleDAO;
import com.ocms.model.Course;
import com.ocms.model.Lesson;
import com.ocms.model.Module;
import java.util.List;
import java.util.Set;

/**
 * Service handling Course and Curriculum business logic.
 */
public class CourseService {

    private final CourseDAO courseDAO;
    private final ModuleDAO moduleDAO;
    private final LessonDAO lessonDAO;

    public CourseService() {
        this.courseDAO = new CourseDAO();
        this.moduleDAO = new ModuleDAO();
        this.lessonDAO = new LessonDAO();
    }

    public List<Course> getPublishedCourses() {
        return courseDAO.findAllPublished();
    }

    public List<Course> searchCourses(String keyword, String category) {
        return courseDAO.search(keyword, category);
    }

    public List<Course> getCoursesByInstructor(int instructorId) {
        return courseDAO.findByInstructorId(instructorId);
    }

    public List<Course> getAllCourses() {
        return courseDAO.findAll();
    }

    public Course getCourseById(int courseId) {
        return courseDAO.findById(courseId);
    }

    /**
     * Loads the full curriculum hierarchy for a course (Modules and their Lessons).
     * If completedLessonIds is provided, marks lessons as completed for student view.
     */
    public List<Module> getCourseCurriculum(int courseId, Set<Integer> completedLessonIds) {
        List<Module> modules = moduleDAO.findByCourseId(courseId);
        for (Module m : modules) {
            List<Lesson> lessons = lessonDAO.findByModuleId(m.getModuleId());
            if (completedLessonIds != null) {
                for (Lesson l : lessons) {
                    l.setCompleted(completedLessonIds.contains(l.getLessonId()));
                }
            }
            m.setLessons(lessons);
        }
        return modules;
    }

    public boolean createCourse(Course course) {
        if (course.getTitle() == null || course.getTitle().trim().isEmpty()) {
            return false;
        }
        return courseDAO.create(course);
    }

    public boolean updateCourse(Course course) {
        return courseDAO.update(course);
    }

    public boolean deleteCourse(int courseId) {
        return courseDAO.delete(courseId);
    }

    // Module management
    public boolean createModule(Module module) {
        return moduleDAO.create(module);
    }

    public boolean updateModule(Module module) {
        return moduleDAO.update(module);
    }

    public boolean deleteModule(int moduleId) {
        return moduleDAO.delete(moduleId);
    }

    public Module getModuleById(int moduleId) {
        return moduleDAO.findById(moduleId);
    }

    // Lesson management
    public boolean createLesson(Lesson lesson) {
        return lessonDAO.create(lesson);
    }

    public boolean updateLesson(Lesson lesson) {
        return lessonDAO.update(lesson);
    }

    public boolean deleteLesson(int lessonId) {
        return lessonDAO.delete(lessonId);
    }

    public Lesson getLessonById(int lessonId) {
        return lessonDAO.findById(lessonId);
    }
}
