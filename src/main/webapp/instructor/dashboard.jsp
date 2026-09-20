<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Instructor Dashboard" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 11: Instructor Dashboard Header -->
<div class="dash-header-row">
    <div>
        <h1 class="dash-greeting-title">Instructor Portal 👨‍🏫</h1>
        <p class="dash-greeting-subtitle">Manage your assigned curriculum, track student progress, and author assessments.</p>
    </div>
    <a href="${pageContext.request.contextPath}/instructor/course-form" class="btn-dash-primary">
        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
        Create New Course
    </a>
</div>

<!-- Screen 11: 4 Stat Metrics Cards -->
<div class="dash-stats-grid">
    <div class="stat-widget-card">
        <div class="stat-icon-circle orange">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.courseCount}</span>
            <span class="stat-data-label">Assigned Courses</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle blue">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.studentCount}</span>
            <span class="stat-data-label">Enrolled Students</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle green">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">${stats.assessmentCount}</span>
            <span class="stat-data-label">Assessments Created</span>
        </div>
    </div>

    <div class="stat-widget-card">
        <div class="stat-icon-circle yellow">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"/></svg>
        </div>
        <div class="stat-data-wrap">
            <span class="stat-data-number">4.9 ★</span>
            <span class="stat-data-label">Average Faculty Rating</span>
        </div>
    </div>
</div>

<!-- Screen 11: Two-Column Main Content -->
<div class="dash-two-col-grid">
    <!-- Left Column: Courses Table -->
    <div class="dash-left-col">
        <div class="dash-panel-card">
            <div class="dash-panel-header">
                <h2 class="dash-panel-title">My Published Courses</h2>
                <a href="${pageContext.request.contextPath}/instructor/courses" style="font-size: 0.85rem; color: #FF6500; font-weight: 700; text-decoration: none;">
                    Manage All &rarr;
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty stats.courses}">
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Course Title</th>
                                    <th>Category</th>
                                    <th>Duration</th>
                                    <th>Modules</th>
                                    <th>Enrolled</th>
                                    <th>Status</th>
                                    <th style="text-align: right;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${stats.courses}">
                                    <tr>
                                        <td>
                                            <strong style="color: #111827;">${c.title}</strong>
                                        </td>
                                        <td>
                                            <span class="card-badge-cat" style="font-size: 0.72rem; padding: 0.15rem 0.5rem;">${c.category}</span>
                                        </td>
                                        <td style="font-size: 0.82rem; color: #6b7280;">${c.durationHours}h</td>
                                        <td style="font-size: 0.82rem; color: #6b7280;">${c.moduleCount}</td>
                                        <td style="font-size: 0.82rem; font-weight: 700; color: #111827;">${c.enrolledStudentCount}</td>
                                        <td>
                                            <span class="badge ${c.status eq 'PUBLISHED' ? 'badge-published' : 'badge-draft'}">
                                                ${c.status}
                                            </span>
                                        </td>
                                        <td style="text-align: right; white-space: nowrap;">
                                            <a href="${pageContext.request.contextPath}/instructor/modules?courseId=${c.courseId}" class="btn-dash-outline" style="padding: 0.35rem 0.75rem; font-size: 0.78rem;">
                                                Curriculum
                                            </a>
                                            <a href="${pageContext.request.contextPath}/instructor/course-form?id=${c.courseId}" class="btn-dash-outline" style="padding: 0.35rem 0.75rem; font-size: 0.78rem;">
                                                Edit
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
                        <p>No courses assigned or created yet. Start authoring your first curriculum module.</p>
                        <a href="${pageContext.request.contextPath}/instructor/course-form" class="btn-dash-primary" style="margin-top: 1rem;">Create Course Now</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Right Column: Quick Operations & Teaching Insights -->
    <div class="dash-right-col">
        <!-- Quick Action Panel -->
        <div class="dash-panel-card">
            <h3 class="dash-panel-title" style="margin-bottom: 1rem;">Authoring Shortcuts</h3>
            <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                <a href="${pageContext.request.contextPath}/instructor/course-form" class="btn-dash-primary" style="justify-content: center;">
                    + Author New Course Offering
                </a>
                <a href="${pageContext.request.contextPath}/instructor/assessments" class="btn-dash-outline" style="justify-content: center;">
                    Author Assessment Quiz &rarr;
                </a>
                <a href="${pageContext.request.contextPath}/instructor/students" class="btn-dash-outline" style="justify-content: center;">
                    View Student Enrollments &rarr;
                </a>
            </div>
        </div>

        <!-- Academic Accreditation Card -->
        <div class="dash-panel-card" style="background: #fffcf9; border-color: #FFE4D6;">
            <div style="display: flex; align-items: center; gap: 0.65rem; margin-bottom: 0.5rem;">
                <div style="width: 28px; height: 28px; border-radius: 50%; background: #FF6500; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 800;">
                    ✓
                </div>
                <h4 style="font-size: 0.95rem; font-weight: 800; color: #111827; margin: 0;">Syllabus Accreditation</h4>
            </div>
            <p style="font-size: 0.85rem; color: #4b5563; line-height: 1.6; margin: 0;">
                All courses published on Elearn OCMS comply with FSJP Course Code 2113611 standards. Ensure each module contains at least 3 structured lessons and 1 chapter evaluation.
            </p>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
