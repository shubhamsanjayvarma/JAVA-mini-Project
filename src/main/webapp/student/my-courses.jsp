<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="My Enrolled Courses" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 7: Header & Action Bar -->
<div class="dash-header-row">
    <div>
        <h1 class="dash-greeting-title">My Courses</h1>
        <p class="dash-greeting-subtitle">Track your enrolled coursework, syllabus progression, and completion status.</p>
    </div>
    <a href="${pageContext.request.contextPath}/courses" class="btn-dash-primary">
        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
        Enroll New Course
    </a>
</div>

<!-- Screen 7: Tab Filters (All, In Progress, Completed) -->
<div class="courses-tab-bar">
    <button type="button" class="course-tab-pill active" onclick="filterMyCourses('all', this)">
        All Courses (${not empty enrollments ? fn:length(enrollments) : 0})
    </button>
    <button type="button" class="course-tab-pill" onclick="filterMyCourses('in-progress', this)">
        In Progress
    </button>
    <button type="button" class="course-tab-pill" onclick="filterMyCourses('completed', this)">
        Completed
    </button>
</div>

<!-- Screen 7: Horizontal Enrolled Course Cards List -->
<c:choose>
    <c:when test="${not empty enrollments}">
        <div id="myCoursesList" style="display: flex; flex-direction: column; gap: 1rem;">
            <c:forEach var="en" items="${enrollments}">
                <c:choose>
                    <c:when test="${fn:containsIgnoreCase(en.courseTitle, 'Java')}">
                        <c:set var="enThumb" value="images/thumb-java.jpg" />
                    </c:when>
                    <c:when test="${fn:containsIgnoreCase(en.courseTitle, 'Web')}">
                        <c:set var="enThumb" value="images/thumb-webdev.jpg" />
                    </c:when>
                    <c:when test="${fn:containsIgnoreCase(en.courseTitle, 'Data')}">
                        <c:set var="enThumb" value="images/thumb-datascience.jpg" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="enThumb" value="images/thumb-ai.jpg" />
                    </c:otherwise>
                </c:choose>

                <div class="my-course-row-card my-course-card-item" data-status="${en.progressPercentage >= 100 ? 'completed' : 'in-progress'}">
                    <img src="${pageContext.request.contextPath}/${enThumb}" alt="${en.courseTitle}" class="my-course-thumb">
                    
                    <div class="my-course-details">
                        <div style="display: flex; align-items: center; gap: 0.6rem; margin-bottom: 0.35rem;">
                            <span class="card-badge-cat" style="font-size: 0.72rem; padding: 0.15rem 0.5rem; margin-bottom: 0;">
                                ${en.courseCategory != null ? en.courseCategory : 'Computer Science'}
                            </span>
                            <c:if test="${en.progressPercentage >= 100}">
                                <span class="badge badge-published" style="font-size: 0.7rem;">&check; COMPLETED</span>
                            </c:if>
                        </div>
                        <h2 class="my-course-name">${en.courseTitle}</h2>
                        <p class="my-course-instructor">Instructor: <strong>${en.instructorName}</strong> &bull; ${en.completedLessons} of ${en.totalLessons} Lessons Completed</p>
                    </div>

                    <div class="my-course-progress-block">
                        <div style="flex: 1;">
                            <div style="display: flex; justify-content: space-between; font-size: 0.78rem; font-weight: 700; color: #4b5563; margin-bottom: 4px;">
                                <span>Progress</span>
                                <span>${en.progressPercentage}%</span>
                            </div>
                            <div class="progress-track-bg">
                                <div class="progress-track-fill ${en.progressPercentage >= 100 ? 'green' : ''}" style="width: ${en.progressPercentage}%;"></div>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/student/course?id=${en.courseId}" class="btn-dash-primary" style="padding: 0.55rem 1.15rem; font-size: 0.85rem; white-space: nowrap;">
                            <c:choose>
                                <c:when test="${en.progressPercentage >= 100}">Review &rarr;</c:when>
                                <c:otherwise>Continue &rarr;</c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="dash-panel-card" style="text-align: center; padding: 4rem 2rem;">
            <svg width="48" height="48" fill="none" stroke="#9ca3af" stroke-width="1.5" viewBox="0 0 24 24" style="margin: 0 auto 1rem auto;"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>
            <h3 style="font-size: 1.25rem; font-weight: 800; color: #111827; margin-bottom: 0.5rem;">No Enrolled Courses</h3>
            <p style="color: #6b7280; font-size: 0.92rem; margin-bottom: 1.5rem;">You haven't enrolled in any courses yet. Browse our full catalog to start your learning path.</p>
            <a href="${pageContext.request.contextPath}/courses" class="btn-dash-primary">Explore Academic Courses</a>
        </div>
    </c:otherwise>
</c:choose>

<script>
function filterMyCourses(filter, btn) {
    document.querySelectorAll('.course-tab-pill').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    const items = document.querySelectorAll('.my-course-card-item');
    items.forEach(item => {
        if (filter === 'all') {
            item.style.display = 'flex';
        } else if (item.getAttribute('data-status') === filter) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });
}
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
