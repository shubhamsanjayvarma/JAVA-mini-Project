<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Instructor Courses" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Course Management</h2>
    <a href="${pageContext.request.contextPath}/instructor/course-form" class="btn btn-primary">+ Create New Course</a>
</div>

<div class="card">
    <div class="card-header">Course Offerings</div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty courses}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Category</th>
                                <th>Duration</th>
                                <th>Modules</th>
                                <th>Enrollments</th>
                                <th>Status</th>
                                <th>Manage</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${courses}">
                                <tr>
                                    <td><strong>${c.title}</strong></td>
                                    <td>${c.category}</td>
                                    <td>${c.durationHours} Hours</td>
                                    <td>${c.moduleCount}</td>
                                    <td>${c.enrolledStudentCount}</td>
                                    <td>
                                        <span class="badge ${c.status eq 'PUBLISHED' ? 'badge-published' : 'badge-draft'}">
                                            ${c.status}
                                        </span>
                                    </td>
                                    <td style="white-space: nowrap; display: flex; gap: 0.35rem;">
                                        <a href="${pageContext.request.contextPath}/instructor/modules?courseId=${c.courseId}" class="btn btn-sm btn-primary">
                                            Curriculum
                                        </a>
                                        <a href="${pageContext.request.contextPath}/instructor/course-form?id=${c.courseId}" class="btn btn-sm btn-secondary">
                                            Edit
                                        </a>
                                        <form action="${pageContext.request.contextPath}/instructor/courses" method="post" class="confirm-delete" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="courseId" value="${c.courseId}">
                                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); text-align: center; padding: 2rem;">No courses available. Click "+ Create New Course" to add one.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
