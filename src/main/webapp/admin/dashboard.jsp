<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Administrator Dashboard" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>System Administration Dashboard</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Institution-wide operational metrics</span>
</div>

<!-- System Statistics -->
<div class="stats-grid">
    <div class="stat-card">
        <span class="stat-label">Total Users</span>
        <span class="stat-value">${stats.totalUsers}</span>
        <span class="stat-meta">${stats.studentCount} Students &bull; ${stats.instructorCount} Faculty &bull; ${stats.adminCount} Admins</span>
    </div>
    <div class="stat-card">
        <span class="stat-label">Active Courses</span>
        <span class="stat-value">${stats.courseCount}</span>
        <span class="stat-meta">Across all academic departments</span>
    </div>
    <div class="stat-card">
        <span class="stat-label">Total Enrollments</span>
        <span class="stat-value">${stats.enrollmentCount}</span>
        <span class="stat-meta">Active student subscriptions</span>
    </div>
</div>

<div class="grid-2">
    <!-- Recent Users -->
    <div class="card">
        <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
            <span>Recent System Accounts</span>
            <a href="${pageContext.request.contextPath}/admin/users" style="font-size: 0.8rem; color: var(--secondary-color); text-decoration: none;">Manage All &rarr;</a>
        </div>
        <div class="card-body">
            <table class="data-table" style="font-size: 0.85rem;">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${stats.recentUsers}">
                        <tr>
                            <td><strong>${u.fullName}</strong></td>
                            <td>${u.email}</td>
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

    <!-- Institutional Courses -->
    <div class="card">
        <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
            <span>Institutional Courses</span>
            <a href="${pageContext.request.contextPath}/admin/courses" style="font-size: 0.8rem; color: var(--secondary-color); text-decoration: none;">Manage All &rarr;</a>
        </div>
        <div class="card-body">
            <table class="data-table" style="font-size: 0.85rem;">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Instructor</th>
                        <th>Students</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${stats.recentCourses}">
                        <tr>
                            <td><strong>${c.title}</strong></td>
                            <td>${c.instructorName}</td>
                            <td>${c.enrolledStudentCount}</td>
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

<jsp:include page="/WEB-INF/includes/footer.jsp" />
