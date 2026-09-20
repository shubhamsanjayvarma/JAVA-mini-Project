<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Assessment Management" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Course Assessment Management</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Author evaluations and configure multiple-choice questions</span>
</div>

<div class="grid-2">
    <!-- Left Column: Existing Assessments -->
    <div class="card">
        <div class="card-header">Existing Course Assessments</div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty assessments}">
                    <c:forEach var="ass" items="${assessments}">
                        <div style="margin-bottom: 1.25rem; padding-bottom: 1rem; border-bottom: 1px solid var(--border-color);">
                            <div style="display: flex; justify-content: space-between; align-items: baseline;">
                                <h4 style="color: var(--primary-color);">
                                    <a href="${pageContext.request.contextPath}/instructor/assessments?id=${ass.assessmentId}" style="text-decoration: none; color: inherit;">
                                        ${ass.title}
                                    </a>
                                </h4>
                                <span class="badge" style="background:#e0f2fe; color:#0369a1;">${ass.questionCount} Questions</span>
                            </div>
                            <p style="font-size: 0.85rem; color: var(--text-secondary); margin: 0.25rem 0;">${ass.courseTitle}</p>
                            <p style="font-size: 0.8rem; color: var(--text-muted);">
                                Pass: ${ass.passingScore} / ${ass.totalMarks} Marks &bull; Duration: ${ass.durationMinutes} mins
                            </p>
                            <div style="display: flex; gap: 0.5rem; margin-top: 0.5rem;">
                                <a href="${pageContext.request.contextPath}/instructor/assessments?id=${ass.assessmentId}" class="btn btn-sm btn-primary">
                                    Author Questions &rarr;
                                </a>
                                <a href="${pageContext.request.contextPath}/instructor/students?assessmentId=${ass.assessmentId}" class="btn btn-sm btn-secondary">
                                    View Scores
                                </a>
                                <form action="${pageContext.request.contextPath}/instructor/assessments" method="post" class="confirm-delete" style="display:inline;">
                                    <input type="hidden" name="action" value="deleteAssessment">
                                    <input type="hidden" name="assessmentId" value="${ass.assessmentId}">
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-muted);">No assessments created yet. Use the form below to create one.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Right Column: Create Assessment OR Add Questions to Selected Assessment -->
    <div>
        <c:choose>
            <c:when test="${not empty assessment}">
                <!-- Question Authoring Form -->
                <div class="card">
                    <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                        <span>Add Question: ${assessment.title}</span>
                        <a href="${pageContext.request.contextPath}/instructor/assessments" class="btn btn-sm btn-secondary">New Assessment Form</a>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/instructor/assessments" method="post">
                            <input type="hidden" name="action" value="addQuestion">
                            <input type="hidden" name="assessmentId" value="${assessment.assessmentId}">

                            <div class="form-group">
                                <label for="questionText">Question Statement *</label>
                                <textarea id="questionText" name="questionText" class="form-control" placeholder="Enter question..." required style="min-height: 80px;"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="marks">Question Marks *</label>
                                <input type="number" id="marks" name="marks" class="form-control" value="20" min="1" required>
                            </div>

                            <label style="font-weight: 600; font-size: 0.85rem; color: var(--text-secondary); display: block; margin-bottom: 0.5rem;">
                                Options &amp; Correct Answer Selection *
                            </label>

                            <c:forEach var="i" begin="1" end="4">
                                <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem;">
                                    <input type="radio" name="correctOption" value="${i}" ${i == 1 ? 'checked' : ''} title="Mark as correct answer" required>
                                    <input type="text" name="option${i}" class="form-control" placeholder="Option ${i} text" required>
                                </div>
                            </c:forEach>
                            <span style="font-size: 0.75rem; color: var(--text-muted); display: block; margin-bottom: 1rem;">
                                * Select the radio button corresponding to the correct answer.
                            </span>

                            <button type="submit" class="btn btn-primary" style="width: 100%;">Add Question to Assessment</button>
                        </form>
                    </div>
                </div>

                <!-- Existing Questions List -->
                <c:if test="${not empty assessment.questions}">
                    <div class="card" style="margin-top: 1rem;">
                        <div class="card-header">Current Questions (${assessment.questions.size()})</div>
                        <div class="card-body" style="font-size: 0.85rem;">
                            <c:forEach var="q" items="${assessment.questions}" varStatus="qStatus">
                                <div style="margin-bottom: 0.75rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--border-color);">
                                    <p><strong>${qStatus.count}. ${q.questionText}</strong> (${q.marks} Marks)</p>
                                    <ul style="list-style: none; padding-left: 1rem;">
                                        <c:forEach var="opt" items="${q.options}">
                                            <li style="color: ${opt.correct ? 'var(--success-color)' : 'var(--text-secondary)'}; font-weight: ${opt.correct ? '600' : 'normal'};">
                                                ${opt.correct ? '&#10004;' : '&bull;'} ${opt.optionText}
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <!-- Create Assessment Form -->
                <div class="card">
                    <div class="card-header">Create New Course Assessment</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/instructor/assessments" method="post">
                            <input type="hidden" name="action" value="createAssessment">

                            <div class="form-group">
                                <label for="courseId">Associated Course *</label>
                                <select id="courseId" name="courseId" class="form-control" required>
                                    <c:forEach var="c" items="${courses}">
                                        <option value="${c.courseId}">${c.title}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="title">Assessment Title *</label>
                                <input type="text" id="title" name="title" class="form-control" placeholder="e.g. Mid-Term Evaluation" required>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="totalMarks">Total Marks *</label>
                                    <input type="number" id="totalMarks" name="totalMarks" class="form-control" value="100" min="10" required>
                                </div>
                                <div class="form-group">
                                    <label for="passingScore">Passing Marks *</label>
                                    <input type="number" id="passingScore" name="passingScore" class="form-control" value="50" min="5" required>
                                </div>
                                <div class="form-group">
                                    <label for="durationMinutes">Duration (Mins) *</label>
                                    <input type="number" id="durationMinutes" name="durationMinutes" class="form-control" value="30" min="5" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="description">Instructions / Scope</label>
                                <textarea id="description" name="description" class="form-control" placeholder="Assessment instructions for candidates..."></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary" style="width: 100%;">Create Assessment</button>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
