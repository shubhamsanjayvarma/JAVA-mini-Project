<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="${assessment.title} - Online Assessment" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 9: Assessment Header with Countdown Timer -->
<div class="dash-header-row" style="margin-bottom: 1.25rem;">
    <div>
        <div class="topbar-breadcrumb" style="margin-bottom: 0.35rem;">
            <a href="${pageContext.request.contextPath}/student/course?id=${assessment.courseId}">&larr; Return to Course</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF6500; font-weight: 700;">Assessment</span>
        </div>
        <h1 class="dash-greeting-title" style="font-size: 1.55rem;">${assessment.title}</h1>
        <p class="dash-greeting-subtitle">
            Course: <strong>${assessment.courseTitle}</strong> &bull; Total Questions: ${not empty assessment.questions ? fn:length(assessment.questions) : 0} &bull; Passing Score: ${assessment.passingScore}
        </p>
    </div>

    <!-- Active Countdown Timer Badge -->
    <div class="timer-badge-pill" id="assessmentTimer">
        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        <span id="timerDisplay">14:59</span>
    </div>
</div>

<c:if test="${not empty param.error}">
    <div class="alert alert-error">Submission failed. Please try again.</div>
</c:if>

<!-- Instructions Card -->
<div class="dash-panel-card" style="padding: 1.15rem 1.5rem; margin-bottom: 1.5rem; background: #fffcf9; border-color: #FFE4D6;">
    <div style="display: flex; align-items: center; gap: 0.75rem;">
        <div style="width: 32px; height: 32px; border-radius: 50%; background: #FFF1E8; color: #FF6500; display: flex; align-items: center; justify-content: center; font-size: 1rem; flex-shrink: 0;">
            💡
        </div>
        <div style="font-size: 0.88rem; color: #4b5563;">
            <strong>Instructions:</strong> Read each question carefully. Select the most accurate option and click <strong>Submit Assessment</strong> when done. Your final score and answer analysis will be calculated immediately.
        </div>
    </div>
</div>

<!-- Screen 9: Questions Form -->
<form action="${pageContext.request.contextPath}/student/assessment" method="post" id="assessmentForm">
    <input type="hidden" name="assessmentId" value="${assessment.assessmentId}">
    <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">

    <div style="display: flex; flex-direction: column; gap: 1.5rem;">
        <c:forEach var="q" items="${assessment.questions}" varStatus="qStatus">
            <div class="dash-panel-card" style="margin-bottom: 0;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.75rem;">
                    <span style="font-size: 0.8rem; font-weight: 800; color: #FF6500; text-transform: uppercase; background: #FFF1E8; padding: 0.2rem 0.65rem; border-radius: 6px;">
                        Question ${qStatus.count} of ${fn:length(assessment.questions)}
                    </span>
                    <span style="font-size: 0.8rem; font-weight: 700; color: #6b7280;">
                        ${q.marks} Mark${q.marks > 1 ? 's' : ''}
                    </span>
                </div>

                <h2 style="font-size: 1.15rem; font-weight: 800; color: #111827; margin-bottom: 1.25rem; line-height: 1.4;">
                    ${q.questionText}
                </h2>

                <!-- Options List with Styled Option Labels -->
                <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                    <c:forEach var="opt" items="${q.options}" varStatus="oStatus">
                        <label style="display: flex; align-items: center; gap: 0.95rem; padding: 0.95rem 1.25rem; border: 1.5px solid #e5e7eb; border-radius: 10px; cursor: pointer; transition: all 0.15s ease; background: #ffffff;">
                            <input type="radio" name="q_${q.questionId}" value="${opt.optionId}" required style="accent-color: #FF6500; width: 18px; height: 18px;">
                            <span style="font-size: 0.92rem; font-weight: 600; color: #374151;">
                                ${opt.optionText}
                            </span>
                        </label>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Submit Toolbar -->
    <div style="margin-top: 2rem; display: flex; align-items: center; justify-content: space-between; background: #ffffff; padding: 1.25rem 1.75rem; border-radius: 14px; border: 1px solid #E4E7EC; box-shadow: 0 4px 16px rgba(0,0,0,0.02);">
        <a href="${pageContext.request.contextPath}/student/course?id=${assessment.courseId}" class="btn-dash-outline">
            Cancel & Return
        </a>
        <button type="submit" class="btn-dash-primary" style="padding: 0.75rem 2.25rem; font-size: 1rem;">
            Submit Assessment &rarr;
        </button>
    </div>
</form>

<script>
// Assessment countdown timer (15 minutes)
let timeRemaining = 15 * 60;
const timerDisplay = document.getElementById('timerDisplay');
const countdownInterval = setInterval(() => {
    timeRemaining--;
    if (timeRemaining <= 0) {
        clearInterval(countdownInterval);
        alert('Time is up! Submitting your answers automatically.');
        document.getElementById('assessmentForm').submit();
        return;
    }
    const minutes = Math.floor(timeRemaining / 60);
    const seconds = timeRemaining % 60;
    timerDisplay.textContent = (minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
}, 1000);
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
