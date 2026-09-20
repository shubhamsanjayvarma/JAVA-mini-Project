<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${course.title} - Learning Portal" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <div>
        <h2>${course.title}</h2>
        <span style="font-size: 0.85rem; color: var(--text-muted);">
            Taught by ${course.instructorName} &bull; Overall Progress: <strong>${enrollment.progressPercentage}%</strong>
        </span>
    </div>
    <a href="${pageContext.request.contextPath}/student/my-courses" class="btn btn-secondary btn-sm">&larr; Back to My Courses</a>
</div>

<div class="course-viewer">
    <!-- Left Sidebar: Curriculum Navigator -->
    <div class="curriculum-sidebar">
        <div style="margin-bottom: 1rem; padding-bottom: 0.75rem; border-bottom: 1px solid var(--border-color);">
            <div style="display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 0.25rem;">
                <span>Completion Status</span>
                <strong>${enrollment.progressPercentage}%</strong>
            </div>
            <div class="progress-container">
                <div class="progress-bar ${enrollment.progressPercentage >= 100 ? 'completed' : ''}" 
                     style="width: ${enrollment.progressPercentage}%;"></div>
            </div>
        </div>

        <h3 style="font-size: 0.95rem; color: var(--primary-color); margin-bottom: 0.75rem;">Modules & Lessons</h3>
        <c:forEach var="moduleItem" items="${curriculum}" varStatus="mIdx">
            <div class="curriculum-module">
                <h4>${moduleItem.title}</h4>
                <ul class="lesson-list">
                    <c:forEach var="les" items="${moduleItem.lessons}">
                        <li class="lesson-item ${activeLesson != null && activeLesson.lessonId == les.lessonId ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/student/course?id=${course.courseId}&lessonId=${les.lessonId}">
                                ${les.title}
                            </a>
                            <c:if test="${les.completed}">
                                <span class="lesson-status-icon" title="Lesson Completed">&check;</span>
                            </c:if>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>

        <!-- Course Assessments -->
        <c:if test="${not empty assessments}">
            <div style="margin-top: 1.5rem; padding-top: 1rem; border-top: 2px solid var(--border-color);">
                <h3 style="font-size: 0.95rem; color: var(--primary-color); margin-bottom: 0.5rem;">Assessments</h3>
                <ul class="lesson-list">
                    <c:forEach var="ass" items="${assessments}">
                        <li class="lesson-item" style="background:#f0fdf4;">
                            <a href="${pageContext.request.contextPath}/student/assessment?id=${ass.assessmentId}" style="color: #15803d; font-weight: 500;">
                                &#9998; ${ass.title}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    </div>

    <!-- Right Pane: Active Lesson Reader -->
    <div class="lesson-content-pane">
        <c:choose>
            <c:when test="${activeLesson != null}">
                <div style="display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem;">
                    <div>
                        <h2 style="font-size: 1.4rem; color: var(--primary-color); margin-bottom: 0.25rem;">
                            ${activeLesson.title}
                        </h2>
                        <span style="font-size: 0.8rem; color: var(--text-muted);">
                            Estimated duration: ${activeLesson.durationMinutes} minutes
                        </span>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${activeLesson.completed}">
                                <span class="badge badge-pass" style="padding: 0.4rem 0.8rem;">&check; Completed</span>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/student/course" method="post">
                                    <input type="hidden" name="courseId" value="${course.courseId}">
                                    <input type="hidden" name="lessonId" value="${activeLesson.lessonId}">
                                    <button type="submit" class="btn btn-success btn-sm">
                                        Mark as Completed &check;
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="lesson-content-body">
                    ${activeLesson.content}
                </div>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 3rem; color: var(--text-muted);">
                    <p>Select a lesson from the left syllabus to begin studying.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
