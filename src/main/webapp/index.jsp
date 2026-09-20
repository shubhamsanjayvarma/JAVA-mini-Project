<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Home - Academic Portal" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="card" style="margin-bottom: 2rem; border-top: 4px solid var(--accent-orange); border-radius: 24px;">
    <div class="card-body" style="padding: 3rem 2.5rem;">
        <span style="font-size: 0.85rem; font-weight: 700; color: var(--accent-orange); text-transform: uppercase; letter-spacing: 0.08em; display: block; margin-bottom: 0.5rem;">Elearn Academic LMS</span>
        <h2 style="font-size: 2.25rem; font-weight: 800; color: var(--text-primary); letter-spacing: -0.03em; margin-bottom: 0.75rem;">
            Online Course Management System
        </h2>
        <p style="font-size: 1.05rem; color: var(--text-secondary); max-width: 800px; margin-bottom: 1.75rem;">
            A complete, production-style academic mini project implementing a robust multi-tiered 
            course delivery, assessment, and progress tracking system built strictly with Java, Servlets, JSP, JDBC, and MySQL.
        </p>
        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/courses" class="btn btn-accent" style="padding: 0.75rem 1.6rem;">Browse Course Catalog</a>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="padding: 0.75rem 1.6rem;">Portal Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary" style="padding: 0.75rem 1.6rem;">Student Registration</a>
        </div>
    </div>
</div>

<div class="grid-2">
    <!-- Project Academic Context -->
    <div class="card">
        <div class="card-header">Academic Allocation Context</div>
        <div class="card-body">
            <table class="data-table">
                <tr><th>Institute</th><td>Thakur Shyamnarayan Engineering College</td></tr>
                <tr><th>Program</th><td>B.Tech CSE (AIML) &bull; Semester III</td></tr>
                <tr><th>Course</th><td>Full Stack Java Programming (FSJP - 2113611)</td></tr>
                <tr><th>Academic Year</th><td>2026-2027</td></tr>
                <tr><th>Project Allocation</th><td>Sr. No. 29 &bull; Roll No: 108-111 (Lead: 108)</td></tr>
                <tr><th>Mandatory Stack</th><td><strong>JSP, Java Servlet, JDBC, MySQL</strong></td></tr>
            </table>
        </div>
    </div>

    <!-- Demo Accounts for Viva Evaluation -->
    <div class="card">
        <div class="card-header">Demo Accounts for Viva Demonstration</div>
        <div class="card-body">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Role</th>
                        <th>Email</th>
                        <th>Password</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><span class="badge badge-role-admin">Admin</span></td>
                        <td>admin@ocms.com</td>
                        <td><code>Admin@123</code></td>
                    </tr>
                    <tr>
                        <td><span class="badge badge-role-instructor">Instructor</span></td>
                        <td>prof.sharma@ocms.com</td>
                        <td><code>Instructor@123</code></td>
                    </tr>
                    <tr>
                        <td><span class="badge badge-role-student">Student</span></td>
                        <td>rahul.kumar@ocms.com</td>
                        <td><code>Student@123</code></td>
                    </tr>
                </tbody>
            </table>
            <p style="font-size: 0.8rem; color: var(--text-muted); margin-top: 0.75rem;">
                * Passwords are encrypted using standard JDK <code>PBKDF2WithHmacSHA256</code> password hashing.
            </p>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header">Core Architectural Capabilities</div>
    <div class="card-body">
        <div class="grid-3">
            <div>
                <h4 style="color: var(--primary-color); margin-bottom: 0.4rem;">1. Role Separation</h4>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">
                    Server-side Servlet Filters enforce strict role boundaries across Student, Instructor, and Admin routes.
                </p>
            </div>
            <div>
                <h4 style="color: var(--primary-color); margin-bottom: 0.4rem;">2. ACID Transactions</h4>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">
                    Course enrollment and assessment submissions utilize JDBC transactions with rollback and unique database constraints.
                </p>
            </div>
            <div>
                <h4 style="color: var(--primary-color); margin-bottom: 0.4rem;">3. Real Progress Tracking</h4>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">
                    Lesson completion and assessment percentage metrics are dynamically computed from normalized MySQL records.
                </p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
