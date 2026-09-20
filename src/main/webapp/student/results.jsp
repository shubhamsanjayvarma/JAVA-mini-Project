<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Assessment Results" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>My Assessment Results</h2>
    <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-secondary btn-sm">&larr; Back to Dashboard</a>
</div>

<!-- Detailed Attempt Review Pane (if an attempt is active) -->
<c:if test="${not empty attempt}">
    <div class="card" style="border-top: 4px solid ${attempt.passed ? 'var(--success-color)' : 'var(--danger-color)'};">
        <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
            <span style="font-size: 1.1rem; font-weight: 600;">Result Review: ${attempt.assessmentTitle}</span>
            <c:choose>
                <c:when test="${attempt.passed}">
                    <span class="badge badge-pass" style="font-size: 0.9rem; padding: 0.4rem 0.8rem;">PASSED</span>
                </c:when>
                <c:otherwise>
                    <span class="badge badge-fail" style="font-size: 0.9rem; padding: 0.4rem 0.8rem;">FAILED</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-body">
            <div class="grid-3" style="margin-bottom: 1.5rem; background: #f8fafc; padding: 1rem; border-radius: var(--radius-sm);">
                <div>
                    <span style="font-size: 0.8rem; color: var(--text-muted);">Course</span>
                    <p style="font-weight: 600; color: var(--primary-color);">${attempt.courseTitle}</p>
                </div>
                <div>
                    <span style="font-size: 0.8rem; color: var(--text-muted);">Score Earned</span>
                    <p style="font-weight: 600; color: var(--primary-color);">${attempt.score} / ${attempt.totalScore} (${attempt.percentage}%)</p>
                </div>
                <div>
                    <span style="font-size: 0.8rem; color: var(--text-muted);">Passing Criteria</span>
                    <p style="font-weight: 600; color: var(--text-secondary);">${attempt.passingScore} Marks Required</p>
                </div>
            </div>

            <h4 style="color: var(--primary-color); margin-bottom: 1rem;">Submitted Answers Analysis</h4>
            <c:forEach var="ans" items="${attempt.answers}" varStatus="aStatus">
                <div style="margin-bottom: 1rem; padding: 0.75rem 1rem; border-left: 4px solid ${ans.correct ? '#276749' : '#9b2c2c'}; background: #ffffff; border-radius: var(--radius-sm); box-shadow: var(--shadow-sm);">
                    <p style="font-weight: 600; font-size: 0.9rem; color: var(--primary-color); margin-bottom: 0.25rem;">
                        ${aStatus.count}. ${ans.questionText}
                    </p>
                    <p style="font-size: 0.85rem; color: var(--text-secondary);">
                        Selected Option: <strong>${ans.selectedOptionText}</strong> 
                        <span style="margin-left: 0.5rem; font-weight: 600; color: ${ans.correct ? 'var(--success-color)' : 'var(--danger-color)'};">
                            ${ans.correct ? '&#10004; Correct' : '&#10008; Incorrect'}
                        </span>
                    </p>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<!-- History Table -->
<div class="card">
    <div class="card-header">All Submitted Assessments</div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty attempts}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Assessment</th>
                                <th>Course</th>
                                <th>Score</th>
                                <th>Percentage</th>
                                <th>Result</th>
                                <th>Attempt Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="att" items="${attempts}">
                                <tr>
                                    <td><strong>${att.assessmentTitle}</strong></td>
                                    <td>${att.courseTitle}</td>
                                    <td>${att.score} / ${att.totalScore}</td>
                                    <td>${att.percentage}%</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${att.passed}">
                                                <span class="badge badge-pass">PASSED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-fail">FAILED</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${att.attemptedAt}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/student/results?attemptId=${att.attemptId}" class="btn btn-sm btn-secondary">
                                            Review &rarr;
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); text-align: center; padding: 2rem;">No assessment results recorded yet.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
