<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Assessment Results" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 10: Top Navigation & Page Title -->
<div class="dash-header-row">
    <div>
        <div class="topbar-breadcrumb" style="margin-bottom: 0.35rem;">
            <a href="${pageContext.request.contextPath}/student/dashboard">&larr; Back to Dashboard</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF6500; font-weight: 700;">Assessment Results</span>
        </div>
        <h1 class="dash-greeting-title">My Assessment Performance</h1>
        <p class="dash-greeting-subtitle">Review your quiz scores, submission details, and syllabus answer breakdowns.</p>
    </div>
    <a href="${pageContext.request.contextPath}/student/my-courses" class="btn-dash-primary">
        Return to My Courses &rarr;
    </a>
</div>

<!-- Screen 10: Detailed Active Attempt Card -->
<c:if test="${not empty attempt}">
    <div class="dash-panel-card" style="padding: 2rem; background: ${attempt.passed ? 'linear-gradient(135deg, #f0fdf4 0%, #ffffff 100%)' : 'linear-gradient(135deg, #fff1f2 0%, #ffffff 100%)'}; border-color: ${attempt.passed ? '#bbf7d0' : '#fecdd3'}; margin-bottom: 2rem;">
        <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 1.5rem; margin-bottom: 1.75rem;">
            <div style="display: flex; align-items: center; gap: 1.25rem;">
                <div style="width: 64px; height: 64px; border-radius: 50%; background: ${attempt.passed ? '#10b981' : '#f43f5e'}; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.8rem; box-shadow: 0 6px 18px ${attempt.passed ? 'rgba(16, 185, 129, 0.3)' : 'rgba(244, 63, 94, 0.3)'}; flex-shrink: 0;">
                    ${attempt.passed ? '🏆' : '⚠️'}
                </div>
                <div>
                    <h2 style="font-size: 1.5rem; font-weight: 900; color: #111827; margin-bottom: 0.25rem;">
                        ${attempt.passed ? 'Congratulations, You Passed!' : 'Assessment Complete - Review Required'}
                    </h2>
                    <p style="color: #4b5563; font-size: 0.95rem; margin: 0;">
                        ${attempt.assessmentTitle} &bull; Course: <strong>${attempt.courseTitle}</strong>
                    </p>
                </div>
            </div>

            <div>
                <span class="badge ${attempt.passed ? 'badge-pass' : 'badge-fail'}" style="font-size: 0.95rem; padding: 0.5rem 1.25rem; font-weight: 800;">
                    ${attempt.passed ? 'PASSED & ACCREDITED' : 'RETRY RECOMMENDED'}
                </span>
            </div>
        </div>

        <!-- 3 Stat Metrics Badges -->
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.25rem; margin-bottom: 1.75rem;">
            <div style="background: #ffffff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 1.15rem; text-align: center;">
                <span style="font-size: 0.8rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">Score Earned</span>
                <h3 style="font-size: 1.6rem; font-weight: 900; color: #111827; margin-top: 0.25rem;">${attempt.score} / ${attempt.totalScore}</h3>
            </div>
            <div style="background: #ffffff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 1.15rem; text-align: center;">
                <span style="font-size: 0.8rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">Overall Percentage</span>
                <h3 style="font-size: 1.6rem; font-weight: 900; color: ${attempt.passed ? '#10b981' : '#f43f5e'}; margin-top: 0.25rem;">${attempt.percentage}%</h3>
            </div>
            <div style="background: #ffffff; border: 1px solid #e5e7eb; border-radius: 12px; padding: 1.15rem; text-align: center;">
                <span style="font-size: 0.8rem; color: #6b7280; font-weight: 600; text-transform: uppercase;">Passing Criteria</span>
                <h3 style="font-size: 1.6rem; font-weight: 900; color: #111827; margin-top: 0.25rem;">${attempt.passingScore} Marks</h3>
            </div>
        </div>

        <!-- Submitted Answers Analysis -->
        <div>
            <h3 style="font-size: 1.15rem; font-weight: 800; color: #111827; margin-bottom: 1rem;">
                Question-by-Question Analysis
            </h3>
            <div style="display: flex; flex-direction: column; gap: 0.85rem;">
                <c:forEach var="ans" items="${attempt.answers}" varStatus="aStatus">
                    <div style="background: #ffffff; border: 1.5px solid ${ans.correct ? '#bbf7d0' : '#fecdd3'}; border-radius: 10px; padding: 1rem 1.25rem; display: flex; align-items: flex-start; justify-content: space-between; gap: 1rem;">
                        <div>
                            <span style="font-size: 0.78rem; font-weight: 800; color: ${ans.correct ? '#10b981' : '#ef4444'}; text-transform: uppercase;">
                                Question ${aStatus.count}
                            </span>
                            <h4 style="font-size: 0.95rem; font-weight: 700; color: #111827; margin: 0.25rem 0 0.5rem 0;">
                                ${ans.questionText}
                            </h4>
                            <p style="font-size: 0.85rem; color: #4b5563; margin: 0;">
                                Selected Answer: <strong>${ans.selectedOptionText}</strong>
                            </p>
                        </div>
                        <div style="flex-shrink: 0;">
                            <span class="badge ${ans.correct ? 'badge-pass' : 'badge-fail'}" style="padding: 0.35rem 0.75rem;">
                                ${ans.correct ? '✔ Correct' : '✖ Incorrect'}
                            </span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</c:if>

<!-- Screen 10: All Historical Attempts Table -->
<div class="dash-panel-card">
    <div class="dash-panel-header">
        <h2 class="dash-panel-title">All Assessment Submissions</h2>
        <span style="font-size: 0.82rem; color: #6b7280;">${not empty attempts ? fn:length(attempts) : 0} Total Records</span>
    </div>

    <c:choose>
        <c:when test="${not empty attempts}">
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Assessment Title</th>
                            <th>Associated Course</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Status</th>
                            <th>Attempt Date</th>
                            <th style="text-align: right;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="att" items="${attempts}">
                            <tr>
                                <td><strong>${att.assessmentTitle}</strong></td>
                                <td>${att.courseTitle}</td>
                                <td><strong>${att.score}</strong> / ${att.totalScore}</td>
                                <td><strong>${att.percentage}%</strong></td>
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
                                <td style="font-size: 0.82rem; color: #6b7280;">${att.attemptedAt}</td>
                                <td style="text-align: right;">
                                    <a href="${pageContext.request.contextPath}/student/results?attemptId=${att.attemptId}" class="btn-dash-outline" style="padding: 0.35rem 0.8rem; font-size: 0.78rem;">
                                        Review Breakdown &rarr;
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div style="text-align: center; padding: 2.5rem 1rem; color: #6b7280;">
                <p>No assessment attempts recorded yet. Enroll in a course and take a module quiz to view your academic results here.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
