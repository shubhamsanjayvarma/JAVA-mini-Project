<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${assessment.title} - Assessment" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <div>
        <h2>${assessment.title}</h2>
        <span style="font-size: 0.85rem; color: var(--text-muted);">
            Course: ${assessment.courseTitle} &bull; Total Marks: ${assessment.totalMarks} &bull; Passing Score: ${assessment.passingScore}
        </span>
    </div>
    <a href="${pageContext.request.contextPath}/student/course?id=${assessment.courseId}" class="btn btn-secondary btn-sm">&larr; Return to Course</a>
</div>

<c:if test="${not empty param.error}">
    <div class="alert alert-error">Submission failed. Please try again.</div>
</c:if>

<div class="card" style="margin-bottom: 1.5rem;">
    <div class="card-body" style="padding: 1.25rem;">
        <p style="color: var(--text-secondary); margin-bottom: 0.5rem;">${assessment.description}</p>
        <p style="font-size: 0.85rem; color: var(--text-muted);">
            Instructions: Answer all questions below. Each question carries marks as indicated. Select one option per question and click <strong>Submit Assessment</strong> when finished.
        </p>
    </div>
</div>

<form action="${pageContext.request.contextPath}/student/assessment" method="post">
    <input type="hidden" name="assessmentId" value="${assessment.assessmentId}">
    <input type="hidden" name="enrollmentId" value="${enrollment.enrollmentId}">

    <c:forEach var="q" items="${assessment.questions}" varStatus="qStatus">
        <div class="question-block">
            <h4>Question ${qStatus.count}: ${q.questionText} <span style="font-size: 0.8rem; color: var(--text-muted); font-weight: normal;">(${q.marks} Marks)</span></h4>

            <div style="margin-top: 0.75rem;">
                <c:forEach var="opt" items="${q.options}">
                    <label class="option-choice">
                        <input type="radio" name="q_${q.questionId}" value="${opt.optionId}" required>
                        <span>${opt.optionText}</span>
                    </label>
                </c:forEach>
            </div>
        </div>
    </c:forEach>

    <div style="text-align: center; margin: 2rem 0;">
        <button type="submit" class="btn btn-primary" style="padding: 0.75rem 2rem; font-size: 1rem;">
            Submit Assessment
        </button>
    </div>
</form>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
