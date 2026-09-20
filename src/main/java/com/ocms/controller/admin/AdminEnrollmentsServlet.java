package com.ocms.controller.admin;

import com.ocms.model.Enrollment;
import com.ocms.service.EnrollmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for administrators to view and monitor all student enrollments and progress.
 */
@WebServlet(urlPatterns = {"/admin/enrollments"})
public class AdminEnrollmentsServlet extends HttpServlet {

    private final EnrollmentService enrollmentService = new EnrollmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Enrollment> enrollments = enrollmentService.getAllEnrollments();
        request.setAttribute("enrollments", enrollments);
        request.getRequestDispatcher("/admin/enrollments.jsp").forward(request, response);
    }
}
