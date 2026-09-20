package com.ocms.controller;

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
 * Public catalog controller for searching and browsing published courses.
 */
@WebServlet(urlPatterns = {"/courses"})
public class CourseListServlet extends HttpServlet {

    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("q");
        String category = request.getParameter("category");

        List<Course> courses;
        if ((keyword != null && !keyword.trim().isEmpty()) || (category != null && !category.trim().isEmpty())) {
            courses = courseService.searchCourses(keyword, category);
        } else {
            courses = courseService.getPublishedCourses();
        }

        request.setAttribute("courses", courses);
        request.setAttribute("searchQuery", keyword);
        request.setAttribute("selectedCategory", category);
        request.getRequestDispatcher("/courses.jsp").forward(request, response);
    }
}
