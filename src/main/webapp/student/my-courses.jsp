<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="My Enrolled Courses" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>My Enrolled Courses</h2>
    <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">Explore More Courses</a>
</div>

<c:choose>
    <c:when test="${not empty enrollments}">
        <div class="grid-2">
            <c:forEach var="enrollment" items="${enrollments}">
                <div class="card" style="display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <div class="card-header" style="display: flex; justify-content: space-between;">
                            <span class="badge" style="background:#e0f2fe; color:#0369a1;">${enrollment.courseCategory}</span>
                            <span class="badge badge-active">${enrollment.status}</span>
                        </div>
                        <div class="card-body">
                            <h3 style="font-size: 1.15rem; color: var(--primary-color); margin-bottom: 0.5rem;">
                                ${enrollment.courseTitle}
                            </h3>
                            <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem;">
                                Instructor: <strong>${enrollment.instructorName}</strong>
                            </p>

                            <div style="margin-top: 1rem;">
                                <div style="display: flex; justify-content: space-between; font-size: 0.85rem; margin-bottom: 0.25rem;">
                                    <span>Course Progress</span>
                                    <strong>${enrollment.progressPercentage}%</strong>
                                </div>
                                <div class="progress-container">
                                    <div class="progress-bar ${enrollment.progressPercentage >= 100 ? 'completed' : ''}" 
                                         style="width: ${enrollment.progressPercentage}%;"></div>
                                </div>
                                <span style="font-size: 0.75rem; color: var(--text-muted);">
                                    ${enrollment.completedLessons} of ${enrollment.totalLessons} lessons completed
                                </span>
                            </div>
                        </div>
                    </div>
                    <div style="padding: 0.75rem 1.25rem; background: #f8fafc; border-top: 1px solid var(--border-color); display: flex; justify-content: flex-end;">
                        <a href="${pageContext.request.contextPath}/student/course?id=${enrollment.courseId}" class="btn btn-primary">
                            Enter Course &rarr;
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card">
            <div class="card-body" style="text-align: center; padding: 3rem;">
                <p style="color: var(--text-muted); font-size: 1.05rem;">You have not enrolled in any courses yet.</p>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary" style="margin-top: 1rem;">Browse Course Catalog</a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
