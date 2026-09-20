<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="${course.title} - Course Details" />
<c:set var="isPublicPage" value="true" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<c:if test="${not empty param.error}">
    <div class="alert alert-error" style="max-width: 1380px; margin: 1.5rem auto 0 auto;">${param.error}</div>
</c:if>

<!-- Screen 3: Course Details Hero Bar -->
<section class="course-details-hero-bar">
    <div class="course-details-container">
        <div class="breadcrumb-nav">
            <a href="${pageContext.request.contextPath}/">Home</a> &nbsp;&gt;&nbsp; 
            <a href="${pageContext.request.contextPath}/courses">Courses</a> &nbsp;&gt;&nbsp; 
            <a href="${pageContext.request.contextPath}/courses?category=${course.category}">${course.category}</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF5722; font-weight: 700;">${course.title}</span>
        </div>

        <div style="margin-top: 1rem;">
            <span class="card-badge-cat" style="font-size: 0.8rem; padding: 0.25rem 0.75rem;">${course.category}</span>
            <h1 style="font-size: 2.25rem; font-weight: 900; color: #111827; margin: 0.6rem 0 0.75rem 0; letter-spacing: -0.02em;">
                ${course.title}
            </h1>
            <div style="display: flex; align-items: center; gap: 1.75rem; flex-wrap: wrap; font-size: 0.92rem; color: #4b5563;">
                <div style="display: inline-flex; align-items: center; gap: 0.5rem;">
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ff7a1a; color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.75rem;">
                        ${fn:substring(course.instructorName, 0, 1)}
                    </div>
                    <span>Taught by <strong style="color: #111827;">${course.instructorName}</strong></span>
                </div>
                <div style="display: inline-flex; align-items: center; gap: 0.35rem;">
                    <span style="color: #FF5722;">★★★★★</span>
                    <strong style="color: #111827;">4.8</strong> (2,450 ratings)
                </div>
                <div style="display: inline-flex; align-items: center; gap: 0.4rem;">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/></svg>
                    <span>${course.enrolledStudentCount} Enrolled Students</span>
                </div>
                <div style="display: inline-flex; align-items: center; gap: 0.4rem;">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                    <span>${course.durationHours} Hours Total Content</span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Screen 3: Details Main Grid (Content Left, Sticky CTA Right) -->
<div class="course-details-container">
    <div class="course-details-grid">
        <!-- Left Main Column -->
        <main class="details-main-content">
            <!-- Navigation Tabs -->
            <div class="details-tabs-header">
                <a href="#overview" class="details-tab-pill active">Overview</a>
                <a href="#curriculum" class="details-tab-pill">Curriculum</a>
                <a href="#instructor" class="details-tab-pill">Instructor</a>
                <a href="#reviews" class="details-tab-pill">Reviews</a>
            </div>

            <!-- Feature Chips Row -->
            <div class="details-feature-chips-row">
                <div class="feature-chip-box">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/></svg>
                    Verified Certificate
                </div>
                <div class="feature-chip-box">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>
                    Hands-On Projects
                </div>
                <div class="feature-chip-box">
                    <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                    Lifetime Access
                </div>
            </div>

            <!-- "What You Will Learn" Card -->
            <div style="background: #FFF9F5; border: 1.5px solid #FFE4D6; border-radius: 12px; padding: 1.5rem; margin-bottom: 2rem;">
                <h3 style="font-size: 1.15rem; font-weight: 800; color: #111827; margin-bottom: 1rem;">What You'll Learn in this Course</h3>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.85rem;">
                    <div style="display: flex; align-items: flex-start; gap: 0.6rem; font-size: 0.88rem; color: #374151;">
                        <svg width="18" height="18" fill="none" stroke="#10b981" stroke-width="2.5" viewBox="0 0 24 24" style="flex-shrink:0; margin-top:2px;"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        <span>Comprehensive grasp of core and advanced subject fundamentals</span>
                    </div>
                    <div style="display: flex; align-items: flex-start; gap: 0.6rem; font-size: 0.88rem; color: #374151;">
                        <svg width="18" height="18" fill="none" stroke="#10b981" stroke-width="2.5" viewBox="0 0 24 24" style="flex-shrink:0; margin-top:2px;"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        <span>Production-grade best practices and robust architecture</span>
                    </div>
                    <div style="display: flex; align-items: flex-start; gap: 0.6rem; font-size: 0.88rem; color: #374151;">
                        <svg width="18" height="18" fill="none" stroke="#10b981" stroke-width="2.5" viewBox="0 0 24 24" style="flex-shrink:0; margin-top:2px;"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        <span>Hands-on lab exercises and real-world assignments</span>
                    </div>
                    <div style="display: flex; align-items: flex-start; gap: 0.6rem; font-size: 0.88rem; color: #374151;">
                        <svg width="18" height="18" fill="none" stroke="#10b981" stroke-width="2.5" viewBox="0 0 24 24" style="flex-shrink:0; margin-top:2px;"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        <span>Preparation for university semester viva and technical interviews</span>
                    </div>
                </div>
            </div>

            <!-- Course Overview Description -->
            <div id="overview" style="margin-bottom: 2.5rem;">
                <h3 style="font-size: 1.25rem; font-weight: 800; color: #111827; margin-bottom: 0.75rem;">Course Description</h3>
                <p style="color: #4b5563; line-height: 1.8; font-size: 0.95rem;">
                    ${course.description}
                </p>
            </div>

            <!-- Curriculum Section -->
            <div id="curriculum" style="margin-bottom: 2.5rem;">
                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.25rem;">
                    <h3 style="font-size: 1.25rem; font-weight: 800; color: #111827;">Course Curriculum</h3>
                    <span style="font-size: 0.85rem; color: #6b7280; font-weight: 600;">
                        ${not empty curriculum ? fn:length(curriculum) : 0} Modules &bull; ${course.durationHours} Total Hours
                    </span>
                </div>

                <c:choose>
                    <c:when test="${not empty curriculum}">
                        <div style="display: flex; flex-direction: column; gap: 1rem;">
                            <c:forEach var="moduleItem" items="${curriculum}" varStatus="mStatus">
                                <div style="border: 1px solid #e5e7eb; border-radius: 12px; overflow: hidden;">
                                    <div style="background: #f9fafb; padding: 1rem 1.25rem; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #e5e7eb;">
                                        <div>
                                            <span style="font-size: 0.78rem; font-weight: 700; color: #FF5722; text-transform: uppercase;">Module ${mStatus.count}</span>
                                            <h4 style="font-size: 1rem; font-weight: 800; color: #111827; margin-top: 2px;">${moduleItem.title}</h4>
                                        </div>
                                        <span style="font-size: 0.82rem; color: #6b7280; font-weight: 600;">
                                            ${not empty moduleItem.lessons ? fn:length(moduleItem.lessons) : 0} Lessons
                                        </span>
                                    </div>
                                    <c:if test="${not empty moduleItem.lessons}">
                                        <div style="padding: 0.5rem 1.25rem;">
                                            <c:forEach var="les" items="${moduleItem.lessons}" varStatus="lStatus">
                                                <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid #f3f4f6;">
                                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                                        <div style="width: 26px; height: 26px; border-radius: 50%; background: #FFF1E8; color: #FF5722; display: flex; align-items: center; justify-content: center;">
                                                            <svg width="12" height="12" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
                                                        </div>
                                                        <span style="font-size: 0.9rem; font-weight: 600; color: #374151;">
                                                            ${mStatus.count}.${lStatus.count} ${les.title}
                                                        </span>
                                                    </div>
                                                    <div style="display: flex; align-items: center; gap: 1rem;">
                                                        <span style="font-size: 0.75rem; color: #FF5722; background: #fff0e6; padding: 0.15rem 0.5rem; border-radius: 4px; font-weight: 700;">Preview</span>
                                                        <span style="font-size: 0.82rem; color: #6b7280;">${les.durationMinutes} mins</span>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p style="color: #6b7280; font-size: 0.9rem;">Course curriculum and modules are currently in preparation.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Instructor Section -->
            <div id="instructor" style="margin-bottom: 2rem;">
                <h3 style="font-size: 1.25rem; font-weight: 800; color: #111827; margin-bottom: 1rem;">Instructor</h3>
                <div style="display: flex; gap: 1.25rem; align-items: flex-start; background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 12px; padding: 1.5rem;">
                    <div style="width: 64px; height: 64px; border-radius: 50%; background: #ff7a1a; color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 1.6rem; flex-shrink: 0;">
                        ${fn:substring(course.instructorName, 0, 1)}
                    </div>
                    <div>
                        <h4 style="font-size: 1.15rem; font-weight: 800; color: #111827; margin-bottom: 0.2rem;">${course.instructorName}</h4>
                        <p style="font-size: 0.82rem; color: #FF5722; font-weight: 700; margin-bottom: 0.6rem;">Senior Faculty & Course Mentor</p>
                        <p style="font-size: 0.88rem; color: #4b5563; line-height: 1.6;">
                            Expert academician in ${course.category} with years of instructional leadership and enterprise consulting experience. Passionate about empowering students through high-quality coursework and practical learning.
                        </p>
                    </div>
                </div>
            </div>
        </main>

        <!-- Right Column: Sticky Enrollment CTA Card (Screen 3) -->
        <aside class="sticky-enrollment-card">
            <!-- Video Preview Box -->
            <c:choose>
                <c:when test="${fn:containsIgnoreCase(course.title, 'Java') || fn:containsIgnoreCase(course.category, 'Computer')}">
                    <c:set var="detailThumb" value="images/thumb-java.jpg" />
                </c:when>
                <c:when test="${fn:containsIgnoreCase(course.title, 'Web') || fn:containsIgnoreCase(course.category, 'Web')}">
                    <c:set var="detailThumb" value="images/thumb-webdev.jpg" />
                </c:when>
                <c:when test="${fn:containsIgnoreCase(course.title, 'Data') || fn:containsIgnoreCase(course.category, 'Database')}">
                    <c:set var="detailThumb" value="images/thumb-datascience.jpg" />
                </c:when>
                <c:when test="${fn:containsIgnoreCase(course.title, 'Algorithm') || fn:containsIgnoreCase(course.category, 'Algorithms')}">
                    <c:set var="detailThumb" value="images/thumb-ai.jpg" />
                </c:when>
                <c:otherwise>
                    <c:set var="detailThumb" value="images/thumb-cybersecurity.jpg" />
                </c:otherwise>
            </c:choose>

            <div class="card-video-preview-box">
                <img src="${pageContext.request.contextPath}/${detailThumb}" alt="Course Video Preview">
                <div class="card-play-icon-btn" onclick="alert('Playing Course Syllabus Preview Video (HTML5 Player)');">
                    <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
                </div>
            </div>

            <!-- Enrollment Card Body -->
            <div class="card-enrollment-body">
                <div class="price-tag-row">
                    <span>Free</span>
                    <span style="font-size: 0.95rem; color: #9ca3af; text-decoration: line-through; font-weight: 500; margin-left: 0.5rem;">₹3,499</span>
                    <span class="card-badge-cat" style="font-size: 0.72rem; vertical-align: middle; margin-left: 0.5rem;">100% Academic Pass</span>
                </div>

                <c:choose>
                    <c:when test="${isEnrolled}">
                        <a href="${pageContext.request.contextPath}/student/course?id=${course.courseId}" class="btn-already-enrolled">
                            &check; Already Enrolled - Continue Learning &rarr;
                        </a>
                    </c:when>
                    <c:when test="${sessionScope.userRole eq 'STUDENT'}">
                        <form action="${pageContext.request.contextPath}/student/enroll" method="post">
                            <input type="hidden" name="courseId" value="${course.courseId}">
                            <button type="submit" class="btn-enroll-hero">
                                Enroll in this Course &rarr;
                            </button>
                        </form>
                    </c:when>
                    <c:when test="${empty sessionScope.userId}">
                        <a href="${pageContext.request.contextPath}/login" class="btn-enroll-hero">
                            Log In to Enroll &rarr;
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-enroll-hero">
                            Go to Dashboard &rarr;
                        </a>
                    </c:otherwise>
                </c:choose>

                <div style="font-size: 0.8rem; text-align: center; color: #6b7280; margin-bottom: 1.25rem;">
                    Instant access upon enrollment &bull; Self-paced learning
                </div>

                <div style="border-top: 1px solid #f3f4f6; padding-top: 1.25rem;">
                    <h4 style="font-size: 0.92rem; font-weight: 800; color: #111827; margin-bottom: 0.85rem;">This course includes:</h4>
                    <div class="includes-checklist">
                        <div class="includes-checklist-item">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                            <span>${course.durationHours} Hours on-demand video</span>
                        </div>
                        <div class="includes-checklist-item">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>
                            <span>Downloadable lecture notes & code samples</span>
                        </div>
                        <div class="includes-checklist-item">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"/></svg>
                            <span>Accessible on Mobile, Desktop and Tablet</span>
                        </div>
                        <div class="includes-checklist-item">
                            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/></svg>
                            <span>Certificate of Course Completion</span>
                        </div>
                    </div>
                </div>
            </div>
        </aside>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
