<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="All Enrollments" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Student Course Enrollments</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Institutional registration and learning progress records</span>
</div>

<div class="card">
    <div class="card-header">All Active &amp; Completed Enrollments (${enrollments.size()})</div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Enrollment ID</th>
                                <th>Student</th>
                                <th>Email</th>
                                <th>Course Title</th>
                                <th>Instructor</th>
                                <th>Curriculum Progress</th>
                                <th>Enrollment Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="en" items="${enrollments}">
                                <tr>
                                    <td>#${en.enrollmentId}</td>
                                    <td><strong>${en.studentName}</strong></td>
                                    <td>${en.studentEmail}</td>
                                    <td>${en.courseTitle}</td>
                                    <td>${en.instructorName}</td>
                                    <td style="min-width: 150px;">
                                        <div style="display: flex; justify-content: space-between; font-size: 0.75rem;">
                                            <span>${en.completedLessons} / ${en.totalLessons} lessons</span>
                                            <strong>${en.progressPercentage}%</strong>
                                        </div>
                                        <div class="progress-container">
                                            <div class="progress-bar ${en.progressPercentage >= 100 ? 'completed' : ''}" 
                                                 style="width: ${en.progressPercentage}%;"></div>
                                        </div>
                                    </td>
                                    <td>${en.enrolledAt}</td>
                                    <td>
                                        <span class="badge ${en.status eq 'ACTIVE' ? 'badge-active' : 'badge-draft'}">
                                            ${en.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); text-align: center; padding: 2rem;">No enrollment records found.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
