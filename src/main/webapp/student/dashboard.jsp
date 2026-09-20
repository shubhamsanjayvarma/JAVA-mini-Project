<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Student Dashboard" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="student-dashboard-layout">
    <!-- Center / Main Content Feed -->
    <section class="dashboard-feed">
        <!-- Top Greeting -->
        <div class="dash-greeting-wrap">
            <span class="dash-greeting">Hi ${not empty sessionScope.userName ? sessionScope.userName.split(' ')[0] : 'Student'},</span>
            <h1 class="dash-hero-title">Suggested courses</h1>
        </div>

        <!-- Featured Hero Banner (Warm Tan with 3D Abstract Sculpture) -->
        <div class="dash-hero-banner">
            <div class="hero-visual-col">
                <svg class="hero-visual-svg" viewBox="0 0 240 240" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <radialGradient id="sculptureGrad" cx="35%" cy="30%" r="70%">
                            <stop offset="0%" stop-color="#fff8f3" />
                            <stop offset="50%" stop-color="#f1e0d3" />
                            <stop offset="85%" stop-color="#d9beab" />
                            <stop offset="100%" stop-color="#baa08d" />
                        </radialGradient>
                        <linearGradient id="ribbon1" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stop-color="#38ef7d" />
                            <stop offset="50%" stop-color="#11998e" />
                            <stop offset="100%" stop-color="#0575e6" />
                        </linearGradient>
                        <linearGradient id="ribbon2" x1="0%" y1="100%" x2="100%" y2="0%">
                            <stop offset="0%" stop-color="#ff758c" />
                            <stop offset="50%" stop-color="#ff7eb3" />
                            <stop offset="100%" stop-color="#fdc830" />
                        </linearGradient>
                        <linearGradient id="ribbon3" x1="100%" y1="0%" x2="0%" y2="100%">
                            <stop offset="0%" stop-color="#ff4b1f" />
                            <stop offset="50%" stop-color="#ff9068" />
                            <stop offset="100%" stop-color="#f7bb97" />
                        </linearGradient>
                        <filter id="shadow3d" x="-20%" y="-20%" width="140%" height="140%">
                            <feDropShadow dx="0" dy="16" stdDeviation="16" flood-color="#a66e44" flood-opacity="0.25" />
                        </filter>
                    </defs>

                    <!-- Outer ambient glow / shadow -->
                    <circle cx="120" cy="120" r="85" fill="#edd5c3" opacity="0.4" filter="blur(20px)" />

                    <!-- Base 3D Shell Body -->
                    <g filter="url(#shadow3d)">
                        <path d="M120 30 C165 30 205 70 205 120 C205 170 165 210 120 210 C75 210 35 170 35 120 C35 70 75 30 120 30 Z" 
                              fill="url(#sculptureGrad)" />
                        
                        <!-- Internal hollow carve -->
                        <path d="M120 65 C150 65 175 90 175 120 C175 150 150 175 120 175 C90 175 65 150 65 120 C65 90 90 65 120 65 Z" 
                              fill="#9e806c" opacity="0.35" />

                        <!-- Multilayered Ribbons woven inside the hollow -->
                        <path d="M68 118 C85 82 125 78 150 95 C175 112 178 145 152 165 C126 185 88 170 76 135" 
                              stroke="url(#ribbon1)" stroke-width="12" stroke-linecap="round" fill="none" />
                        
                        <path d="M78 128 C92 98 124 92 144 105 C164 118 166 142 146 155 C126 168 96 156 86 136" 
                              stroke="url(#ribbon2)" stroke-width="10" stroke-linecap="round" fill="none" />
                        
                        <path d="M88 135 C98 112 122 106 138 115 C154 124 155 138 140 148 C125 158 104 148 95 137" 
                              stroke="url(#ribbon3)" stroke-width="8" stroke-linecap="round" fill="none" />

                        <!-- Organic outer sculptural folds -->
                        <path d="M120 30 C155 45 185 85 185 120 C185 140 170 148 155 130 C138 110 130 60 120 30 Z" 
                              fill="url(#sculptureGrad)" opacity="0.95" />
                        
                        <path d="M35 120 C45 160 85 195 120 210 C105 180 90 160 80 140 C68 115 50 115 35 120 Z" 
                              fill="url(#sculptureGrad)" opacity="0.9" />

                        <path d="M120 210 C160 195 195 155 205 120 C180 145 150 160 120 210 Z" 
                              fill="#ecd3c0" opacity="0.8" />
                    </g>
                </svg>
            </div>

            <div class="hero-info-col">
                <div class="hero-badge">
                    <span class="level-bars">
                        <span></span><span></span><span></span>
                    </span>
                    BEGINNER
                </div>
                
                <h2 class="hero-course-title">
                    <c:choose>
                        <c:when test="${not empty stats.featuredCourse}">
                            Learn the Basics of ${stats.featuredCourse.title}
                        </c:when>
                        <c:otherwise>
                            Learn the Basics of Java & Web Dev
                        </c:otherwise>
                    </c:choose>
                </h2>

                <c:choose>
                    <c:when test="${not empty stats.enrollments}">
                        <a href="${pageContext.request.contextPath}/student/course?id=${stats.enrollments[0].courseId}" class="hero-learn-btn">
                            LEARN NOW
                        </a>
                    </c:when>
                    <c:when test="${not empty stats.featuredCourse}">
                        <a href="${pageContext.request.contextPath}/course?id=${stats.featuredCourse.courseId}" class="hero-learn-btn">
                            LEARN NOW
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/courses" class="hero-learn-btn">
                            LEARN NOW
                        </a>
                    </c:otherwise>
                </c:choose>

                <!-- Carousel Dots Indicator -->
                <div class="hero-dots">
                    <span class="dot active"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                </div>
            </div>
        </div>

        <!-- Section: Your learning path -->
        <div>
            <h2 class="dash-subheading">Your learning path</h2>
            <div class="learning-path-grid">
                <c:choose>
                    <c:when test="${not empty stats.suggestedCourses}">
                        <c:forEach var="courseItem" items="${stats.suggestedCourses}" begin="0" end="2" varStatus="loop">
                            <a href="${pageContext.request.contextPath}/course?id=${courseItem.courseId}" class="path-card">
                                <div>
                                    <h3 class="path-title">${courseItem.title}</h3>
                                    <div class="path-meta">
                                        <c:choose>
                                            <c:when test="${loop.index == 0}">12 hours of video tutorials</c:when>
                                            <c:when test="${loop.index == 1}">10 hours of video tutorials</c:when>
                                            <c:otherwise>14 hours of video tutorials</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="path-footer">
                                    <span class="path-students">
                                        <c:choose>
                                            <c:when test="${loop.index == 0}">423 students</c:when>
                                            <c:when test="${loop.index == 1}">648 students</c:when>
                                            <c:otherwise>562 students</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="path-rating">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="#10b981" stroke="#10b981">
                                            <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                                        </svg>
                                        4.9
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback Learning Path Cards -->
                        <div class="path-card">
                            <div>
                                <h3 class="path-title">Core Java Fundamentals</h3>
                                <div class="path-meta">12 hours of video tutorials</div>
                            </div>
                            <div class="path-footer">
                                <span class="path-students">423 students</span>
                                <span class="path-rating">★ 4.9</span>
                            </div>
                        </div>
                        <div class="path-card">
                            <div>
                                <h3 class="path-title">Servlet Architecture</h3>
                                <div class="path-meta">10 hours of video tutorials</div>
                            </div>
                            <div class="path-footer">
                                <span class="path-students">648 students</span>
                                <span class="path-rating">★ 4.8</span>
                            </div>
                        </div>
                        <div class="path-card">
                            <div>
                                <h3 class="path-title">JDBC & MySQL Integration</h3>
                                <div class="path-meta">14 hours of video tutorials</div>
                            </div>
                            <div class="path-footer">
                                <span class="path-students">562 students</span>
                                <span class="path-rating">★ 5.0</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Right Aside Column (Search, Course In Progress, Your Learning Point) -->
    <aside class="dashboard-aside">
        <!-- Search Bar and Notification Bell -->
        <div class="aside-top-bar">
            <form action="${pageContext.request.contextPath}/courses" method="get" class="search-pill-box">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
                <input type="text" name="q" placeholder="Search" />
            </form>
            <a href="${pageContext.request.contextPath}/student/results" class="notif-bell-btn" title="Notifications">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                </svg>
                <span class="notif-badge-pill">2</span>
            </a>
        </div>

        <!-- Section: Course In Progress -->
        <div>
            <h3 class="aside-section-title">Course In Progress</h3>
            <div class="progress-course-list">
                <c:choose>
                    <c:when test="${not empty stats.enrollments}">
                        <c:forEach var="en" items="${stats.enrollments}" varStatus="status">
                            <a href="${pageContext.request.contextPath}/student/course?id=${en.courseId}" class="progress-course-item">
                                <!-- Pastel Squircle Icon based on index -->
                                <c:choose>
                                    <c:when test="${status.index % 4 == 0}">
                                        <div class="squircle-icon squircle-peach">
                                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <polygon points="23 7 16 12 23 17 23 7"></polygon>
                                                <rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect>
                                            </svg>
                                        </div>
                                    </c:when>
                                    <c:when test="${status.index % 4 == 1}">
                                        <div class="squircle-icon squircle-yellow">
                                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                                                <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                                                <line x1="12" y1="22.08" x2="12" y2="12"></line>
                                            </svg>
                                        </div>
                                    </c:when>
                                    <c:when test="${status.index % 4 == 2}">
                                        <div class="squircle-icon squircle-lime">
                                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <polygon points="10 8 16 12 10 16 10 8"></polygon>
                                            </svg>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="squircle-icon squircle-purple">
                                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M9 18V5l12-2v13"></path>
                                                <circle cx="6" cy="18" r="3"></circle>
                                                <circle cx="18" cy="16" r="3"></circle>
                                            </svg>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="progress-course-info">
                                    <div class="progress-course-name">${en.courseTitle}</div>
                                    <div class="progress-course-sub">
                                        <c:choose>
                                            <c:when test="${not empty en.courseCategory}">${en.courseCategory}</c:when>
                                            <c:otherwise>Full Stack Java</c:otherwise>
                                        </c:choose>
                                        &bull; ${en.progressPercentage}%
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Default in-progress items matching reference style -->
                        <div class="progress-course-item">
                            <div class="squircle-icon squircle-peach">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polygon points="23 7 16 12 23 17 23 7"></polygon>
                                    <rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect>
                                </svg>
                            </div>
                            <div class="progress-course-info">
                                <div class="progress-course-name">After Effects Fundamentals</div>
                                <div class="progress-course-sub">Adobe After Effects</div>
                            </div>
                        </div>
                        <div class="progress-course-item">
                            <div class="squircle-icon squircle-yellow">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                                </svg>
                            </div>
                            <div class="progress-course-info">
                                <div class="progress-course-name">Modelling Basics</div>
                                <div class="progress-course-sub">Cinema 4D</div>
                            </div>
                        </div>
                        <div class="progress-course-item">
                            <div class="squircle-icon squircle-lime">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="12" cy="12" r="10"></circle>
                                </svg>
                            </div>
                            <div class="progress-course-info">
                                <div class="progress-course-name">Illustration for Animation</div>
                                <div class="progress-course-sub">Adobe Illustrator</div>
                            </div>
                        </div>
                        <div class="progress-course-item">
                            <div class="squircle-icon squircle-purple">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M9 18V5l12-2v13"></path>
                                    <circle cx="6" cy="18" r="3"></circle>
                                </svg>
                            </div>
                            <div class="progress-course-info">
                                <div class="progress-course-name">Music Production Basic</div>
                                <div class="progress-course-sub">FL STUDIO</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Section: Your learning point -->
        <div>
            <h3 class="aside-section-title">Your learning point</h3>
            <div class="chart-widget-card">
                <div class="chart-area">
                    <!-- Y Axis Labels -->
                    <div class="chart-y-axis">
                        <span>90</span>
                        <span>60</span>
                        <span>30</span>
                        <span>0</span>
                    </div>

                    <!-- Bars with grid lines -->
                    <div class="chart-bars-container">
                        <div class="chart-grid-line line-90"></div>
                        <div class="chart-grid-line line-60"></div>
                        <div class="chart-grid-line line-30"></div>

                        <!-- Bar 1: 1/11 -->
                        <div class="chart-bar-col">
                            <div class="chart-bar-pillar" style="height: 38%;"></div>
                            <span class="chart-x-label">1/11</span>
                        </div>
                        <!-- Bar 2: 2 -->
                        <div class="chart-bar-col">
                            <div class="chart-bar-pillar" style="height: 52%;"></div>
                            <span class="chart-x-label">2</span>
                        </div>
                        <!-- Bar 3: 3 -->
                        <div class="chart-bar-col">
                            <div class="chart-bar-pillar" style="height: 68%;"></div>
                            <span class="chart-x-label">3</span>
                        </div>
                        <!-- Bar 4: 4 -->
                        <div class="chart-bar-col">
                            <div class="chart-bar-pillar" style="height: 84%;"></div>
                            <span class="chart-x-label">4</span>
                        </div>
                        <!-- Bar 5: 5 -->
                        <div class="chart-bar-col">
                            <div class="chart-bar-pillar" style="height: 72%;"></div>
                            <span class="chart-x-label">5</span>
                        </div>
                        <!-- Bar 6: 6/11 -->
                        <div class="chart-bar-col">
                            <div class="chart-bar-pillar" style="height: 58%;"></div>
                            <span class="chart-x-label">6/11</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </aside>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
