<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Student Dashboard" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 6: Greeting Top Bar -->
<div class="dash-header-row">
    <div>
        <h1 class="dash-greeting-title">Welcome back, ${not empty sessionScope.userName ? sessionScope.userName : 'Student'}! 👋</h1>
        <p class="dash-greeting-subtitle">Here is what is happening with your courses and learning progress today.</p>
    </div>
    <a href="${pageContext.request.contextPath}/courses" class="btn-dash-primary">
        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
        Browse All Courses
    </a>
</div>

<!-- Screen 6: 4 Stat Widget Cards -->
<div class="dash-stats-grid">
    <div class="stat-widget-card">
        <div class="stat-icon-circle orange">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.enrolledCount}</span>
            <span class="stat-data-label">Enrolled Courses</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle blue">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.enrolledCount - stats.completedCoursesCount}</span>
            <span class="stat-data-label">In Progress</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle green">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.completedCoursesCount}</span>
            <span class="stat-data-label">Completed Courses</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle yellow">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.averageProgress}%</span>
            <span class="stat-data-label">Average Progress</span>
        </div>
    </div>
</div>

<!-- Screen 6: Two-Column Dashboard Content Layout -->
<div class="dash-two-col-grid">
    <!-- Left Column: Continue Learning & Enrolled Courses -->
    <div class="dash-left-col">
        <!-- Continue Learning Primary Banner Card -->
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">Continue Learning</h2>
                <a href="${pageContext.request.contextPath}/student/my-courses" style="font-size: 0.85rem; color: #FF6500; text-decoration: none; font-weight: 700;">View All &rarr;</a>
            </div>

            <c:choose>
                <c:when test="${not empty stats.enrollments}">
                    <c:set var="activeEnr" value="${stats.enrollments[0]}" />
                    <c:choose>
                        <c:when test="${fn:containsIgnoreCase(activeEnr.courseTitle, 'Java')}">
                            <c:set var="bannerThumb" value="images/thumb-java.jpg" />
                        </c:when>
                        <c:when test="${fn:containsIgnoreCase(activeEnr.courseTitle, 'Web')}">
                            <c:set var="bannerThumb" value="images/thumb-webdev.jpg" />
                        </c:when>
                        <c:when test="${fn:containsIgnoreCase(activeEnr.courseTitle, 'Data')}">
                            <c:set var="bannerThumb" value="images/thumb-datascience.jpg" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="bannerThumb" value="images/thumb-ai.jpg" />
                        </c:otherwise>
                    </c:choose>

                    <div class="continue-course-card">
                        <img src="${pageContext.request.contextPath}/${bannerThumb}" alt="${activeEnr.courseTitle}" class="continue-thumb">
                        <div class="continue-info">
                            <div style="font-size: 0.75rem; font-weight: 700; color: #FF6500; text-transform: uppercase; margin-bottom: 2px;">
                                ${activeEnr.courseCategory != null ? activeEnr.courseCategory : 'Core Course'}
                            </div>
                            <h3 class="continue-title">${activeEnr.courseTitle}</h3>
                            <div class="progress-track-bg">
                                <div class="progress-track-fill" style="width: ${activeEnr.progressPercentage}%;"></div>
                            </div>
                            <div style="display: flex; align-items: center; justify-content: space-between;">
                                <span class="progress-percent-label">${activeEnr.progressPercentage}% Completed</span>
                                <a href="${pageContext.request.contextPath}/student/course?id=${activeEnr.courseId}" class="btn-dash-primary" style="padding: 0.45rem 1rem; font-size: 0.82rem;">
                                    Resume Lecture &rarr;
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 2rem 1rem;">
                        <p style="color: #6b7280; font-size: 0.92rem; margin-bottom: 1rem;">You are not currently enrolled in any course.</p>
                        <a href="${pageContext.request.contextPath}/courses" class="btn-dash-primary">Explore Available Courses</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Recent Enrolled Courses List -->
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">My Courses Progress</h2>
                <span style="font-size: 0.82rem; color: #6b7280;">${stats.enrolledCount} Active</span>
            </div>

            <c:choose>
                <c:when test="${not empty stats.enrollments}">
                    <div style="display: flex; flex-direction: column; gap: 1rem;">
                        <c:forEach var="en" items="${stats.enrollments}">
                            <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.85rem 1rem; background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 10px;">
                                <div style="flex: 1; margin-right: 1.5rem;">
                                    <h4 style="font-size: 0.95rem; font-weight: 800; color: #111827; margin-bottom: 0.35rem;">${en.courseTitle}</h4>
                                    <div style="display: flex; align-items: center; gap: 0.85rem;">
                                        <div class="progress-track-bg" style="width: 140px; margin-bottom: 0;">
                                            <div class="progress-track-fill ${en.progressPercentage >= 100 ? 'green' : ''}" style="width: ${en.progressPercentage}%;"></div>
                                        </div>
                                        <span style="font-size: 0.78rem; font-weight: 700; color: #4b5563;">${en.progressPercentage}%</span>
                                    </div>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${en.progressPercentage >= 100}">
                                            <a href="${pageContext.request.contextPath}/student/course?id=${en.courseId}" class="btn-dash-outline" style="padding: 0.4rem 0.85rem; font-size: 0.8rem; color: #10b981; border-color: #a7f3d0;">
                                                &check; Review Course
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/student/course?id=${en.courseId}" class="btn-dash-outline" style="padding: 0.4rem 0.85rem; font-size: 0.8rem;">
                                                Continue &rarr;
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="color: #6b7280; font-size: 0.9rem; text-align: center; padding: 1.5rem 0;">No enrolled courses yet.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Right Column: Learning Progress Donut & Recent Activity -->
    <div class="dash-right-col">
        <!-- Learning Progress Widget (Donut + Bars) -->
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">Overall Completion</h2>
                <span style="font-size: 0.82rem; font-weight: 700; color: #FF6500;">Academic Track</span>
            </div>

            <div class="learning-progress-widget">
                <!-- SVG Donut Chart -->
                <div class="donut-progress-box">
                    <svg width="120" height="120" viewBox="0 0 120 120">
                        <circle cx="60" cy="60" r="50" fill="none" stroke="#f3f4f6" stroke-width="12" />
                        <circle cx="60" cy="60" r="50" fill="none" stroke="#FF6500" stroke-width="12" 
                                stroke-dasharray="314.16" 
                                stroke-dashoffset="${314.16 - (314.16 * stats.averageProgress / 100)}" 
                                stroke-linecap="round" />
                    </svg>
                    <div class="donut-percentage-text">${stats.averageProgress}%</div>
                </div>

                <!-- Study Time Activity -->
                <div style="flex: 1; padding-left: 0.5rem;">
                    <div style="margin-bottom: 0.75rem;">
                        <span style="font-size: 0.78rem; color: #6b7280;">Completed Lessons</span>
                        <h4 style="font-size: 1.15rem; font-weight: 800; color: #111827;">${stats.completedCoursesCount} / ${stats.enrolledCount} Courses</h4>
                    </div>
                    <div>
                        <span style="font-size: 0.78rem; color: #6b7280;">Total Quizzes Attempted</span>
                        <h4 style="font-size: 1.15rem; font-weight: 800; color: #111827;">${stats.attemptCount} Assessments</h4>
                    </div>
                </div>
            </div>

            <!-- Weekly Activity Bar Chart Visual -->
            <div style="margin-top: 1.25rem; padding-top: 1rem; border-top: 1px solid #f3f4f6;">
                <div style="display: flex; align-items: flex-end; justify-content: space-between; height: 85px; padding: 0 0.5rem;">
                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                        <div style="width: 18px; height: 35px; background: #FFF1E8; border-radius: 4px;"></div>
                        <span style="font-size: 0.7rem; color: #9ca3af; font-weight: 600;">Mon</span>
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                        <div style="width: 18px; height: 50px; background: #FFF1E8; border-radius: 4px;"></div>
                        <span style="font-size: 0.7rem; color: #9ca3af; font-weight: 600;">Tue</span>
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                        <div style="width: 18px; height: 70px; background: #FF6500; border-radius: 4px;"></div>
                        <span style="font-size: 0.7rem; color: #FF6500; font-weight: 700;">Wed</span>
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                        <div style="width: 18px; height: 40px; background: #FFF1E8; border-radius: 4px;"></div>
                        <span style="font-size: 0.7rem; color: #9ca3af; font-weight: 600;">Thu</span>
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                        <div style="width: 18px; height: 60px; background: #FFF1E8; border-radius: 4px;"></div>
                        <span style="font-size: 0.7rem; color: #9ca3af; font-weight: 600;">Fri</span>
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
                        <div style="width: 18px; height: 25px; background: #FFF1E8; border-radius: 4px;"></div>
                        <span style="font-size: 0.7rem; color: #9ca3af; font-weight: 600;">Sat</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity Timeline / Assessments Card -->
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">Recent Quiz Activity</h2>
                <a href="${pageContext.request.contextPath}/student/results" style="font-size: 0.82rem; color: #FF6500; text-decoration: none; font-weight: 700;">All Results &rarr;</a>
            </div>

            <c:choose>
                <c:when test="${not empty stats.recentAttempts}">
                    <div class="activity-timeline-list">
                        <c:forEach var="att" items="${stats.recentAttempts}">
                            <div class="activity-item-row">
                                <div class="activity-icon-bullet" style="background: ${att.passed ? '#ecfdf5' : '#fef2f2'}; color: ${att.passed ? '#10b981' : '#ef4444'};">
                                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4"/></svg>
                                </div>
                                <div class="activity-item-text" style="flex:1;">
                                    <strong>Score: ${att.score} / ${att.totalQuestions} (${att.passed ? 'PASSED' : 'REVIEW'})</strong>
                                    <span>${att.formattedDate != null ? att.formattedDate : 'Completed recently'}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="color: #6b7280; font-size: 0.88rem; text-align: center; padding: 1rem 0;">
                        No quiz attempts recorded yet. Head over to your course syllabus to take chapter assessments!
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
