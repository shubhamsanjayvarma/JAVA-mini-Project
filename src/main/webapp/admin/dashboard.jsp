<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Administrator Dashboard" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 13: Admin Dashboard Header -->
<div class="dash-header-row">
    <div>
        <h1 class="dash-greeting-title">System Administration 🛡️</h1>
        <p class="dash-greeting-subtitle">Platform operational metrics, role administration, and institutional oversight.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/users" class="btn-dash-primary">
        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/></svg>
        Manage All Users
    </a>
</div>

<!-- Screen 13: 4 Stat Metrics Cards -->
<div class="dash-stats-grid">
    <div class="stat-widget-card">
        <div class="stat-icon-circle orange">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.totalUsers}</span>
            <span class="stat-data-label">Total Registered Users</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle green">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 14l9-5-9-5-9 5 9 5z"/><path stroke-linecap="round" stroke-linejoin="round" d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0112 20.055a11.952 11.952 0 01-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.studentCount}</span>
            <span class="stat-data-label">Active Students</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle blue">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.instructorCount}</span>
            <span class="stat-data-label">Faculty Instructors</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle yellow">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.courseCount}</span>
            <span class="stat-data-label">Active Courses</span>
        </div>
    </div>
</div>

<!-- Screen 13: Two-Column Admin Layout -->
<div class="dash-two-col-grid">
    <!-- Left Column: Recent Platform Users & Courses -->
    <div class="dash-left-col">
        <!-- Recent Users Table Panel -->
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">Recent User Accounts</h2>
                <a href="${pageContext.request.contextPath}/admin/users" style="font-size: 0.85rem; color: #FF6500; font-weight: 700; text-decoration: none;">
                    Manage All &rarr;
                </a>
            </div>

            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Email Address</th>
                            <th>Role</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${stats.recentUsers}">
                            <tr>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.65rem;">
                                        <div style="width: 28px; height: 28px; border-radius: 50%; background: #111827; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 0.75rem; font-weight: 700;">
                                            ${fn:substring(u.fullName, 0, 1)}
                                        </div>
                                        <strong style="color: #111827;">${u.fullName}</strong>
                                    </div>
                                </td>
                                <td style="font-size: 0.85rem; color: #6b7280;">${u.email}</td>
                                <td>
                                    <span class="badge ${u.role eq 'ADMIN' ? 'badge-role-admin' : (u.role eq 'INSTRUCTOR' ? 'badge-role-instructor' : 'badge-role-student')}">
                                        ${u.role}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${u.status eq 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">
                                        ${u.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Institutional Courses Panel -->
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">Active Course Offerings</h2>
                <a href="${pageContext.request.contextPath}/admin/courses" style="font-size: 0.85rem; color: #FF6500; font-weight: 700; text-decoration: none;">
                    View Catalog &rarr;
                </a>
            </div>

            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Course Title</th>
                            <th>Faculty Instructor</th>
                            <th>Enrollments</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${stats.recentCourses}">
                            <tr>
                                <td><strong style="color: #111827;">${c.title}</strong></td>
                                <td style="color: #4b5563;">${c.instructorName}</td>
                                <td style="font-weight: 700; color: #111827;">${c.enrolledStudentCount}</td>
                                <td>
                                    <span class="badge ${c.status eq 'PUBLISHED' ? 'badge-published' : 'badge-draft'}">
                                        ${c.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Right Column: User Distribution Breakdown & Operations -->
    <div class="dash-right-col">
        <!-- Distribution Widget -->
        <div class="dash-panel-card">
            <h3 class="dash-panel-title" style="margin-bottom: 1.25rem;">User Role Distribution</h3>

            <div style="display: flex; flex-direction: column; gap: 1rem;">
                <div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.82rem; font-weight: 700; margin-bottom: 0.35rem;">
                        <span style="color: #10b981;">Students (${stats.studentCount})</span>
                        <span>${stats.totalUsers > 0 ? Math.round((stats.studentCount * 100.0) / stats.totalUsers) : 0}%</span>
                    </div>
                    <div class="progress-track-bg">
                        <div class="progress-track-fill green" style="width: ${stats.totalUsers > 0 ? (stats.studentCount * 100.0) / stats.totalUsers : 0}%;"></div>
                    </div>
                </div>

                <div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.82rem; font-weight: 700; margin-bottom: 0.35rem;">
                        <span style="color: #3b82f6;">Faculty Instructors (${stats.instructorCount})</span>
                        <span>${stats.totalUsers > 0 ? Math.round((stats.instructorCount * 100.0) / stats.totalUsers) : 0}%</span>
                    </div>
                    <div class="progress-track-bg">
                        <div class="progress-track-fill" style="background: #3b82f6; width: ${stats.totalUsers > 0 ? (stats.instructorCount * 100.0) / stats.totalUsers : 0}%;"></div>
                    </div>
                </div>

                <div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.82rem; font-weight: 700; margin-bottom: 0.35rem;">
                        <span style="color: #8b5cf6;">System Administrators (${stats.adminCount})</span>
                        <span>${stats.totalUsers > 0 ? Math.round((stats.adminCount * 100.0) / stats.totalUsers) : 0}%</span>
                    </div>
                    <div class="progress-track-bg">
                        <div class="progress-track-fill" style="background: #8b5cf6; width: ${stats.totalUsers > 0 ? (stats.adminCount * 100.0) / stats.totalUsers : 0}%;"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Administration Actions -->
        <div class="dash-panel-card">
            <h3 class="dash-panel-title" style="margin-bottom: 1rem;">Admin Shortcuts</h3>
            <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn-dash-primary" style="justify-content: center;">
                    + Provision New User
                </a>
                <a href="${pageContext.request.contextPath}/admin/courses" class="btn-dash-outline" style="justify-content: center;">
                    Manage Course Catalog &rarr;
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="btn-dash-outline" style="justify-content: center;">
                    View System Reports &rarr;
                </a>
            </div>
        </div>

        <!-- Server & Database Health Badge -->
        <div class="dash-panel-card" style="background: #f8fafc; border: 1px dashed #d1d5db;">
            <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem;">
                <span style="width: 10px; height: 10px; border-radius: 50%; background: #10b981; display: inline-block;"></span>
                <strong style="font-size: 0.88rem; color: #111827;">System Health: Optimal</strong>
            </div>
            <p style="font-size: 0.8rem; color: #6b7280; margin: 0; line-height: 1.5;">
                Tomcat 10.1 &bull; MySQL 8.4 Engine Active &bull; Connection Pool: Operational &bull; FSJP Viva Ready.
            </p>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
