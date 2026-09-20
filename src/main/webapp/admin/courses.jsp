<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Course Records Oversight" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>All Academic Course Records</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Institutional course repository</span>
</div>

<div class="card">
    <div class="card-header">Course Records (${courses.size()})</div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Course Title</th>
                        <th>Instructor</th>
                        <th>Category</th>
                        <th>Hours</th>
                        <th>Modules</th>
                        <th>Enrollments</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${courses}">
                        <tr>
                            <td>${c.courseId}</td>
                            <td><strong>${c.title}</strong></td>
                            <td>${c.instructorName}</td>
                            <td>${c.category}</td>
                            <td>${c.durationHours}</td>
                            <td>${c.moduleCount}</td>
                            <td>${c.enrolledStudentCount}</td>
                            <td>
                                <span class="badge ${c.status eq 'PUBLISHED' ? 'badge-published' : 'badge-draft'}">
                                    ${c.status}
                                </span>
                            </td>
                            <td style="white-space: nowrap; display: flex; gap: 0.35rem;">
                                <form action="${pageContext.request.contextPath}/admin/courses" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="toggleStatus">
                                    <input type="hidden" name="courseId" value="${c.courseId}">
                                    <button type="submit" class="btn btn-sm btn-secondary">
                                        ${c.status eq 'PUBLISHED' ? 'Unpublish' : 'Publish'}
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/courses" method="post" class="confirm-delete" style="display:inline;">
                                    <input type="hidden" name="action" value="deleteCourse">
                                    <input type="hidden" name="courseId" value="${c.courseId}">
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
