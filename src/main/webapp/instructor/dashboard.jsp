<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Instructor Dashboard" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Instructor Teaching Dashboard</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Welcome, <strong>${sessionScope.userName}</strong></span>
</div>

<!-- Database Metrics -->
<div class="stats-grid">
    <div class="stat-card">
        <span class="stat-label">Assigned Courses</span>
        <span class="stat-value">${stats.courseCount}</span>
        <span class="stat-meta">Active departmental subjects</span>
    </div>
    <div class="stat-card">
        <span class="stat-label">Enrolled Students</span>
        <span class="stat-value">${stats.studentCount}</span>
        <span class="stat-meta">Total learner enrollments</span>
    </div>
    <div class="stat-card">
        <span class="stat-label">Assessments Created</span>
        <span class="stat-value">${stats.assessmentCount}</span>
        <span class="stat-meta">Active multiple choice evaluations</span>
    </div>
</div>

<div class="card">
    <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
        <span>My Assigned Courses</span>
        <a href="${pageContext.request.contextPath}/instructor/course-form" class="btn btn-sm btn-primary">+ Create New Course</a>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty stats.courses}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Course Title</th>
                                <th>Category</th>
                                <th>Duration</th>
                                <th>Modules</th>
                                <th>Students</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${stats.courses}">
                                <tr>
                                    <td><strong>${c.title}</strong></td>
                                    <td>${c.category}</td>
                                    <td>${c.durationHours} hrs</td>
                                    <td>${c.moduleCount}</td>
                                    <td>${c.enrolledStudentCount}</td>
                                    <td>
                                        <span class="badge ${c.status eq 'PUBLISHED' ? 'badge-published' : 'badge-draft'}">
                                            ${c.status}
                                        </span>
                                    </td>
                                    <td style="white-space: nowrap;">
                                        <a href="${pageContext.request.contextPath}/instructor/modules?courseId=${c.courseId}" class="btn btn-sm btn-secondary">
                                            Curriculum
                                        </a>
                                        <a href="${pageContext.request.contextPath}/instructor/course-form?id=${c.courseId}" class="btn btn-sm btn-secondary">
                                            Edit
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); text-align: center; padding: 2rem;">No courses created yet. Click above to create your first course.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
