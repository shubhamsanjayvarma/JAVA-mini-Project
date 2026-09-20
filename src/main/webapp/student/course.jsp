<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="${course.title} - Video Player" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 8: Top Player Title & Return Navigation -->
<div class="dash-header-row" style="margin-bottom: 1.25rem;">
    <div>
        <div class="topbar-breadcrumb" style="margin-bottom: 0.35rem;">
            <a href="${pageContext.request.contextPath}/student/my-courses">&larr; Back to My Courses</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF6500; font-weight: 700;">${course.title}</span>
        </div>
        <h1 class="dash-greeting-title" style="font-size: 1.45rem;">
            ${activeLesson != null ? activeLesson.title : course.title}
        </h1>
    </div>
    <div style="display: flex; align-items: center; gap: 0.75rem;">
        <c:if test="${activeLesson != null}">
            <c:choose>
                <c:when test="${activeLesson.completed}">
                    <span class="badge badge-pass" style="padding: 0.55rem 1.15rem; font-size: 0.85rem;">
                        &check; Lesson Completed
                    </span>
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/student/course" method="post" style="margin: 0;">
                        <input type="hidden" name="courseId" value="${course.courseId}">
                        <input type="hidden" name="lessonId" value="${activeLesson.lessonId}">
                        <button type="submit" class="btn-dash-primary" style="padding: 0.55rem 1.15rem; font-size: 0.85rem; background: #10b981; box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);">
                            &check; Mark Lesson Completed
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
</div>

<!-- Screen 8: Course Player Grid (Main Player + Curriculum Sidebar) -->
<div class="course-player-grid">
    <!-- Left Column: HTML5 Video Screen & Lesson Notes -->
    <div class="player-main-col">
        <!-- Video Screen Container -->
        <c:choose>
            <c:when test="${fn:containsIgnoreCase(course.title, 'Java')}">
                <c:set var="playerThumb" value="images/thumb-java.jpg" />
            </c:when>
            <c:when test="${fn:containsIgnoreCase(course.title, 'Web')}">
                <c:set var="playerThumb" value="images/thumb-webdev.jpg" />
            </c:when>
            <c:when test="${fn:containsIgnoreCase(course.title, 'Data')}">
                <c:set var="playerThumb" value="images/thumb-datascience.jpg" />
            </c:when>
            <c:otherwise>
                <c:set var="playerThumb" value="images/thumb-ai.jpg" />
            </c:otherwise>
        </c:choose>

        <div class="video-player-container">
            <img src="${pageContext.request.contextPath}/${playerThumb}" alt="Video Player Background" class="video-code-bg">
            <div class="video-play-btn" onclick="alert('Streaming Interactive Lesson Lecture in 1080p Full HD');">
                <svg width="28" height="28" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
            </div>
            <!-- Subtitle badge bottom-left -->
            <div style="position: absolute; bottom: 15px; left: 15px; background: rgba(0,0,0,0.75); color: #ffffff; padding: 0.35rem 0.75rem; border-radius: 6px; font-size: 0.8rem; font-weight: 600; backdrop-filter: blur(4px);">
                HD 1080p &bull; ${activeLesson != null ? activeLesson.durationMinutes : 15}:00 Mins Lecture
            </div>
        </div>

        <!-- Lesson Navigation Tabs (Notes, Resources, Code) -->
        <div class="dash-panel-card" style="padding: 1.75rem;">
            <div class="lesson-tabs-header">
                <a href="#notes" class="lesson-tab-link active">Lesson Notes</a>
                <a href="#resources" class="lesson-tab-link">Downloads & Code</a>
                <a href="#qa" class="lesson-tab-link">Discussion Forum</a>
            </div>

            <c:choose>
                <c:when test="${activeLesson != null}">
                    <div style="line-height: 1.8; color: #374151; font-size: 0.95rem;">
                        <h2 style="font-size: 1.25rem; font-weight: 800; color: #111827; margin-bottom: 0.75rem;">
                            ${activeLesson.title}
                        </h2>
                        <div style="background: #f9fafb; border-left: 4px solid #FF6500; padding: 1rem 1.25rem; border-radius: 0 8px 8px 0; margin-bottom: 1.25rem;">
                            <span style="font-size: 0.8rem; font-weight: 700; color: #FF6500; text-transform: uppercase;">Key Takeaways</span>
                            <p style="margin: 0.25rem 0 0 0; color: #4b5563; font-size: 0.9rem;">
                                In this lesson, we study fundamental architecture principles, component lifecycle management, and practical code implementations verified for academic assessment.
                            </p>
                        </div>
                        <div style="font-size: 0.92rem; color: #4b5563;">
                            ${activeLesson.content}
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 3rem 1rem; color: #6b7280;">
                        <p>Select any lesson module from the right curriculum navigator to start streaming.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Right Column: Course Content & Modules Sidebar -->
    <aside class="course-content-sidebar">
        <!-- Progress Summary Header -->
        <div style="padding: 1.25rem 1.5rem; background: #ffffff; border-bottom: 1px solid #E4E7EC;">
            <div style="display: flex; justify-content: space-between; font-size: 0.82rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem;">
                <span>Course Completion</span>
                <span style="color: #FF6500;">${enrollment.progressPercentage}%</span>
            </div>
            <div class="progress-track-bg" style="margin-bottom: 0;">
                <div class="progress-track-fill ${enrollment.progressPercentage >= 100 ? 'green' : ''}" style="width: ${enrollment.progressPercentage}%;"></div>
            </div>
        </div>

        <!-- Modules Accordion -->
        <div class="accordion-lessons-list">
            <c:forEach var="moduleItem" items="${curriculum}" varStatus="mIdx">
                <div class="accordion-module-header">
                    Module ${mIdx.count}: ${moduleItem.title}
                </div>
                <c:forEach var="les" items="${moduleItem.lessons}" varStatus="lIdx">
                    <a href="${pageContext.request.contextPath}/student/course?id=${course.courseId}&lessonId=${les.lessonId}" 
                       class="accordion-lesson-row ${activeLesson != null && activeLesson.lessonId == les.lessonId ? 'active' : ''}">
                        <div style="display: flex; align-items: center; gap: 0.65rem; flex: 1; min-width: 0;">
                            <c:choose>
                                <c:when test="${les.completed}">
                                    <div style="width: 20px; height: 20px; border-radius: 50%; background: #ecfdf5; color: #10b981; display: flex; align-items: center; justify-content: center; font-size: 0.72rem; font-weight: 800; flex-shrink: 0;">
                                        &check;
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="width: 20px; height: 20px; border-radius: 50%; background: #f3f4f6; color: #9ca3af; display: flex; align-items: center; justify-content: center; font-size: 0.72rem; flex-shrink: 0;">
                                        ${lIdx.count}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <span style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                ${les.title}
                            </span>
                        </div>
                        <span style="font-size: 0.75rem; color: #9ca3af; margin-left: 0.5rem; flex-shrink: 0;">
                            ${les.durationMinutes}m
                        </span>
                    </a>
                </c:forEach>
            </c:forEach>
        </div>

        <!-- Course Assessments Card in Sidebar -->
        <c:if test="${not empty assessments}">
            <div style="padding: 1.25rem; background: #fffaf7; border-top: 1px solid #FFE4D6;">
                <div style="font-size: 0.8rem; font-weight: 800; color: #FF6500; text-transform: uppercase; margin-bottom: 0.5rem;">
                    Course Chapter Assessments
                </div>
                <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                    <c:forEach var="ass" items="${assessments}">
                        <a href="${pageContext.request.contextPath}/student/assessment?id=${ass.assessmentId}" 
                           class="btn-dash-primary" style="padding: 0.5rem 0.85rem; font-size: 0.82rem; justify-content: space-between;">
                            <span>✍️ ${ass.title}</span>
                            <span>Take Quiz &rarr;</span>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </aside>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
