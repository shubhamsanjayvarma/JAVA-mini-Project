<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="Courses Catalog" />
<c:set var="isPublicPage" value="true" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 2: Courses Hero Header Banner -->
<section class="courses-page-header">
    <div class="courses-hero-content">
        <div class="breadcrumb-nav">
            <a href="${pageContext.request.contextPath}/">Home</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF5722; font-weight: 700;">Courses</span>
        </div>
        <h1 class="courses-hero-title">Explore Our Courses</h1>
        <div class="courses-hero-stats-row">
            <div class="courses-hero-stat-item">
                <svg width="18" height="18" fill="none" stroke="#FF5722" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/></svg>
                <span><strong>12,000+</strong> Active Students</span>
            </div>
            <div class="courses-hero-stat-item">
                <svg width="18" height="18" fill="none" stroke="#FF5722" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/></svg>
                <span><strong>80+</strong> Expert Mentors</span>
            </div>
            <div class="courses-hero-stat-item">
                <svg width="18" height="18" fill="none" stroke="#10b981" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                <span><strong>100% Free</strong> Academic Certification</span>
            </div>
        </div>
    </div>
</section>

<!-- Screen 2: Catalog Layout (Sidebar Filters + Results Catalog) -->
<div class="courses-layout-grid">
    <!-- Left Filter Sidebar -->
    <aside class="filter-sidebar-card">
        <div class="filter-sidebar-header">
            <div class="filter-sidebar-title">
                <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/></svg>
                Filter Courses
            </div>
            <a href="${pageContext.request.contextPath}/courses" class="filter-reset-link">Reset</a>
        </div>

        <form action="${pageContext.request.contextPath}/courses" method="get" id="coursesFilterForm">
            <!-- Search Keyword -->
            <div class="filter-group-block">
                <div class="filter-group-title">Search</div>
                <div class="filter-search-box">
                    <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                    <input type="text" name="q" value="${searchQuery != null ? searchQuery : ''}" placeholder="Course title, keywords...">
                </div>
            </div>

            <!-- Subject Categories -->
            <div class="filter-group-block">
                <div class="filter-group-title">Category</div>
                <div class="filter-checklist">
                    <label class="filter-check-item">
                        <span>
                            <input type="radio" name="category" value="" ${empty selectedCategory || selectedCategory eq 'ALL' ? 'checked' : ''} onchange="this.form.submit()"> All Disciplines
                        </span>
                        <span class="filter-item-count">All</span>
                    </label>
                    <label class="filter-check-item">
                        <span>
                            <input type="radio" name="category" value="Computer Science" ${selectedCategory eq 'Computer Science' ? 'checked' : ''} onchange="this.form.submit()"> Computer Science
                        </span>
                        <span class="filter-item-count">CS</span>
                    </label>
                    <label class="filter-check-item">
                        <span>
                            <input type="radio" name="category" value="Web Development" ${selectedCategory eq 'Web Development' ? 'checked' : ''} onchange="this.form.submit()"> Web Development
                        </span>
                        <span class="filter-item-count">WD</span>
                    </label>
                    <label class="filter-check-item">
                        <span>
                            <input type="radio" name="category" value="Database Systems" ${selectedCategory eq 'Database Systems' ? 'checked' : ''} onchange="this.form.submit()"> Database Systems
                        </span>
                        <span class="filter-item-count">DB</span>
                    </label>
                    <label class="filter-check-item">
                        <span>
                            <input type="radio" name="category" value="Algorithms" ${selectedCategory eq 'Algorithms' ? 'checked' : ''} onchange="this.form.submit()"> Algorithms & DSA
                        </span>
                        <span class="filter-item-count">DSA</span>
                    </label>
                </div>
            </div>

            <!-- Academic Level Filter -->
            <div class="filter-group-block">
                <div class="filter-group-title">Difficulty Level</div>
                <div class="filter-checklist">
                    <label class="filter-check-item">
                        <span><input type="checkbox" checked> All Levels</span>
                        <span class="filter-item-count">100%</span>
                    </label>
                    <label class="filter-check-item">
                        <span><input type="checkbox"> Beginner</span>
                        <span class="filter-item-count">Intro</span>
                    </label>
                    <label class="filter-check-item">
                        <span><input type="checkbox"> Intermediate</span>
                        <span class="filter-item-count">Core</span>
                    </label>
                    <label class="filter-check-item">
                        <span><input type="checkbox"> Advanced</span>
                        <span class="filter-item-count">Adv</span>
                    </label>
                </div>
            </div>

            <!-- Duration Filter -->
            <div class="filter-group-block">
                <div class="filter-group-title">Duration</div>
                <div class="filter-checklist">
                    <label class="filter-check-item">
                        <span><input type="checkbox"> 0 - 10 Hours</span>
                        <span class="filter-item-count">Crash</span>
                    </label>
                    <label class="filter-check-item">
                        <span><input type="checkbox" checked> 10 - 40 Hours</span>
                        <span class="filter-item-count">Semester</span>
                    </label>
                    <label class="filter-check-item">
                        <span><input type="checkbox"> 40+ Hours</span>
                        <span class="filter-item-count">Deep</span>
                    </label>
                </div>
            </div>

            <!-- Star Rating Filter -->
            <div class="filter-group-block" style="margin-bottom: 1.75rem;">
                <div class="filter-group-title">Rating</div>
                <div class="filter-checklist">
                    <label class="filter-check-item">
                        <span style="display:inline-flex; align-items:center; gap:0.35rem;">
                            <input type="checkbox" checked>
                            <span style="color:#FF5722;">★★★★★</span> 4.5 & up
                        </span>
                    </label>
                    <label class="filter-check-item">
                        <span style="display:inline-flex; align-items:center; gap:0.35rem;">
                            <input type="checkbox">
                            <span style="color:#FF5722;">★★★★☆</span> 4.0 & up
                        </span>
                    </label>
                </div>
            </div>

            <button type="submit" class="btn-auth-primary" style="padding: 0.65rem;">
                Apply Filters
            </button>
        </form>
    </aside>

    <!-- Right Results Section -->
    <main class="results-catalog-column">
        <!-- Results Top Bar -->
        <div class="results-toolbar-row">
            <div class="results-count-heading">
                Showing <span style="color: #FF5722;">${not empty courses ? fn:length(courses) : 0}</span> Available Courses
            </div>
            <div class="results-sort-group">
                <label for="sortSelector" style="font-size: 0.85rem; color: #6b7280; font-weight: 600;">Sort By:</label>
                <select id="sortSelector" class="sort-select-dropdown">
                    <option>Most Popular</option>
                    <option>Highest Rated</option>
                    <option>Newest Curriculum</option>
                    <option>Duration: Short to Long</option>
                </select>
            </div>
        </div>

        <!-- Course Cards Grid (Screen 2: 3-column layout) -->
        <c:choose>
            <c:when test="${not empty courses}">
                <div class="courses-cards-grid-3">
                    <c:forEach var="course" items="${courses}" varStatus="status">
                        <c:choose>
                            <c:when test="${fn:containsIgnoreCase(course.title, 'Java') || fn:containsIgnoreCase(course.category, 'Computer')}">
                                <c:set var="cardThumb" value="images/thumb-java.jpg" />
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(course.title, 'Web') || fn:containsIgnoreCase(course.category, 'Web')}">
                                <c:set var="cardThumb" value="images/thumb-webdev.jpg" />
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(course.title, 'Data') || fn:containsIgnoreCase(course.category, 'Database')}">
                                <c:set var="cardThumb" value="images/thumb-datascience.jpg" />
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(course.title, 'Algorithm') || fn:containsIgnoreCase(course.category, 'Algorithms')}">
                                <c:set var="cardThumb" value="images/thumb-ai.jpg" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="cardThumb" value="images/thumb-cybersecurity.jpg" />
                            </c:otherwise>
                        </c:choose>

                        <div class="course-catalog-card">
                            <div class="card-thumb-wrap">
                                <img src="${pageContext.request.contextPath}/${cardThumb}" alt="${course.title}" class="card-thumb-img">
                                <div class="card-duration-badge">${course.durationHours} Hours</div>
                            </div>
                            <div class="card-content-body">
                                <div>
                                    <span class="card-badge-cat">${course.category}</span>
                                    <h2 class="card-course-title">${course.title}</h2>
                                    <p class="card-instructor-text">Instructor: <strong>${course.instructorName}</strong></p>
                                </div>
                                <div>
                                    <div class="card-rating-enrolled-row">
                                        <span style="display:inline-flex; align-items:center; gap:0.3rem;">
                                            <span style="color:#FF5722;">★</span> <strong>4.8</strong> (1.2k)
                                        </span>
                                        <span style="color:#6b7280; font-size:0.75rem;">
                                            ${course.enrolledStudentCount} enrolled
                                        </span>
                                    </div>
                                    <div class="card-button-row">
                                        <a href="${pageContext.request.contextPath}/course-details?id=${course.courseId}" class="btn-card-details">
                                            Details
                                        </a>
                                        <a href="${pageContext.request.contextPath}/course-details?id=${course.courseId}" class="btn-card-enroll">
                                            Enroll
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card" style="text-align: center; padding: 4rem 2rem; background: #ffffff; border-radius: 14px;">
                    <svg width="48" height="48" fill="none" stroke="#9ca3af" stroke-width="1.5" viewBox="0 0 24 24" style="margin: 0 auto 1rem auto;"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>
                    <h3 style="font-size: 1.25rem; font-weight: 800; color: #111827; margin-bottom: 0.5rem;">No Courses Found</h3>
                    <p style="color: #6b7280; font-size: 0.92rem; margin-bottom: 1.5rem;">We couldn't find any courses matching your filter criteria. Try clearing the filters.</p>
                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary" style="background: #FF5722; border-color: #FF5722;">Reset Filters & View All</a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
