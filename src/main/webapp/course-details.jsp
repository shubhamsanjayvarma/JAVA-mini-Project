<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${course.title} - Details" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<c:if test="${not empty param.error}">
    <div class="alert alert-error">${param.error}</div>
</c:if>

<div class="card" style="border-top: 4px solid var(--secondary-color);">
    <div class="card-body" style="padding: 2rem;">
        <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem;">
            <div>
                <span class="badge" style="background:#e0f2fe; color:#0369a1; margin-bottom: 0.5rem;">${course.category}</span>
                <h2 style="font-size: 1.6rem; color: var(--primary-color); margin: 0.35rem 0;">${course.title}</h2>
                <p style="color: var(--text-muted); font-size: 0.9rem;">
                    Taught by <strong>${course.instructorName}</strong> &bull; Total Duration: ${course.durationHours} Hours &bull; ${course.enrolledStudentCount} Active Students
                </p>
            </div>
            <div>
                <c:choose>
                    <c:when test="${isEnrolled}">
                        <a href="${pageContext.request.contextPath}/student/course?id=${course.courseId}" class="btn btn-success" style="padding: 0.65rem 1.25rem;">
                            &check; Already Enrolled - Open Course
                        </a>
                    </c:when>
                    <c:when test="${sessionScope.userRole eq 'STUDENT'}">
                        <form action="${pageContext.request.contextPath}/student/enroll" method="post" style="display: inline;">
                            <input type="hidden" name="courseId" value="${course.courseId}">
                            <button type="submit" class="btn btn-primary" style="padding: 0.65rem 1.25rem;">
                                Enroll in this Course
                            </button>
                        </form>
                    </c:when>
                    <c:when test="${empty sessionScope.userId}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="padding: 0.65rem 1.25rem;">
                            Log In to Enroll
                        </a>
                    </c:when>
                </c:choose>
            </div>
        </div>

        <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border-color);">
            <h4 style="color: var(--primary-color); margin-bottom: 0.5rem;">Course Overview</h4>
            <p style="color: var(--text-secondary); line-height: 1.8;">${course.description}</p>
        </div>
    </div>
</div>

<!-- Detailed Syllabus Structure -->
<div class="card">
    <div class="card-header">Course Curriculum & Learning Modules</div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty curriculum}">
                <c:forEach var="module" items="${curriculum}" varStatus="mStatus">
                    <div style="margin-bottom: 1.5rem; padding-bottom: 1.25rem; border-bottom: 1px solid var(--border-color);">
                        <h3 style="font-size: 1.05rem; color: var(--primary-color); margin-bottom: 0.35rem;">
                            ${module.title}
                        </h3>
                        <c:if test="${not empty module.description}">
                            <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0.75rem;">${module.description}</p>
                        </c:if>

                        <c:if test="${not empty module.lessons}">
                            <table class="data-table" style="font-size: 0.85rem;">
                                <thead>
                                    <tr>
                                        <th style="width: 60px;">#</th>
                                        <th>Lesson Title</th>
                                        <th style="width: 120px;">Duration</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="lesson" items="${module.lessons}" varStatus="lStatus">
                                        <tr>
                                            <td>${mStatus.count}.${lStatus.count}</td>
                                            <td>${lesson.title}</td>
                                            <td>${lesson.durationMinutes} mins</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted);">Curriculum modules are currently being prepared by the department instructor.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
