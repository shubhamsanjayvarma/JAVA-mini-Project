<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Enrolled Students" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Student Performance & Enrollments</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Monitor student engagement and evaluation metrics</span>
</div>

<!-- Assessment Scores Breakdown (if filtered) -->
<c:if test="${not empty selectedAssessment}">
    <div class="card" style="border-top: 4px solid var(--secondary-color);">
        <div class="card-header">
            Assessment Results: <strong>${selectedAssessment.title}</strong>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty assessmentAttempts}">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Student Name</th>
                                    <th>Email</th>
                                    <th>Score</th>
                                    <th>Percentage</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="att" items="${assessmentAttempts}">
                                    <tr>
                                        <td><strong>${att.studentName}</strong></td>
                                        <td>${att.studentEmail}</td>
                                        <td>${att.score} / ${att.totalScore}</td>
                                        <td>${att.percentage}%</td>
                                        <td>
                                            <span class="badge ${att.passed ? 'badge-pass' : 'badge-fail'}">
                                                ${att.passed ? 'PASSED' : 'FAILED'}
                                            </span>
                                        </td>
                                        <td>${att.attemptedAt}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-muted);">No attempts recorded yet for this assessment.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</c:if>

<!-- Enrolled Students Table -->
<div class="card">
    <div class="card-header">Active Course Enrollments</div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty enrollments}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Student Name</th>
                                <th>Email</th>
                                <th>Course Title</th>
                                <th>Progress</th>
                                <th>Enrolled Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="en" items="${enrollments}">
                                <tr>
                                    <td><strong>${en.studentName}</strong></td>
                                    <td>${en.studentEmail}</td>
                                    <td>${en.courseTitle}</td>
                                    <td style="min-width: 140px;">
                                        <div style="display: flex; justify-content: space-between; font-size: 0.75rem;">
                                            <span>${en.completedLessons}/${en.totalLessons} lessons</span>
                                            <strong>${en.progressPercentage}%</strong>
                                        </div>
                                        <div class="progress-container">
                                            <div class="progress-bar ${en.progressPercentage >= 100 ? 'completed' : ''}" 
                                                 style="width: ${en.progressPercentage}%;"></div>
                                        </div>
                                    </td>
                                    <td>${en.enrolledAt}</td>
                                    <td><span class="badge badge-active">${en.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); text-align: center; padding: 2rem;">No students enrolled in your courses yet.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
