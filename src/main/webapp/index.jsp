<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Home" />
<c:set var="isHomePage" value="true" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- ====================================================================
     1. HERO SECTION (EXACT ELEARN DESIGN)
     ==================================================================== -->
<section class="elearn-hero">
    <div class="hero-container">
        <!-- Left Hero Content -->
        <div class="hero-left">
            <span class="hero-eyebrow">LEARN &nbsp;&bull;&nbsp; GROW &nbsp;&bull;&nbsp; ACHIEVE</span>
            <h1 class="hero-heading">
                Your Learning<br>
                Journey <span class="text-orange">Starts Here</span>
            </h1>
            <p class="hero-subtext">
                Elearn is a modern online course management system designed to help students learn from expert instructors, build in-demand skills, and achieve their academic and career goals.
            </p>
            
            <div class="hero-cta-group">
                <a href="${pageContext.request.contextPath}/courses" class="btn-hero-orange">
                    Browse Courses
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="btn-arrow-icon">
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                        <polyline points="12 5 19 12 12 19"></polyline>
                    </svg>
                </a>
                <a href="#about" class="btn-hero-outline">Learn More</a>
            </div>

            <!-- 4 Value Props / Highlights Row -->
            <div class="hero-features-row">
                <div class="hero-feature-item">
                    <div class="feature-icon-wrapper">
                        <!-- Open Book Icon -->
                        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" class="feature-svg">
                            <path d="M12 4.5C10.3 3.5 8.2 3 6 3C3.8 3 1.7 3.5 0 4.5V20.5C1.7 19.5 3.8 19 6 19C8.2 19 10.3 19.5 12 20.5C13.7 19.5 15.8 19 18 19C20.2 19 22.3 19.5 24 20.5V4.5C22.3 3.5 20.2 3 18 3C15.8 3 13.7 3.5 12 4.5ZM11 18.5C9.5 17.6 7.8 17 6 17C4.6 17 3.2 17.3 2 18V6.2C3.2 5.5 4.6 5.1 6 5.1C7.8 5.1 9.5 5.6 11 6.5V18.5ZM22 18C20.8 17.3 19.4 17 18 17C16.2 17 14.5 17.6 13 18.5V6.5C14.5 5.6 16.2 5.1 18 5.1C19.4 5.1 20.8 5.5 22 6.2V18Z"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <strong>Wide Range</strong>
                        <span>of Courses</span>
                    </div>
                </div>

                <div class="hero-feature-item">
                    <div class="feature-icon-wrapper">
                        <!-- Expert Instructors Icon -->
                        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" class="feature-svg">
                            <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <strong>Learn from</strong>
                        <span>Expert Instructors</span>
                    </div>
                </div>

                <div class="hero-feature-item">
                    <div class="feature-icon-wrapper">
                        <!-- Track Progress Bar Chart Icon -->
                        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" class="feature-svg">
                            <path d="M5 9.2H8V19H5V9.2ZM10.5 5H13.5V19H10.5V5ZM16 12.8H19V19H16V12.8Z"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <strong>Track Your</strong>
                        <span>Progress</span>
                    </div>
                </div>

                <div class="hero-feature-item">
                    <div class="feature-icon-wrapper">
                        <!-- Award / Certified Medal Icon -->
                        <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor" class="feature-svg">
                            <path d="M12 2C9.24 2 7 4.24 7 7C7 8.38 7.56 9.63 8.47 10.53L4 19.5L7.5 18L10 21L12 16.3L14 21L16.5 18L20 19.5L15.53 10.53C16.44 9.63 17 8.38 17 7C17 4.24 14.76 2 12 2ZM12 10C10.34 10 9 8.66 9 7C9 5.34 10.34 4 12 4C13.66 4 15 5.34 15 7C15 8.66 13.66 10 12 10Z"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <strong>Get Certified</strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Hero Visual & Floating Badges -->
        <div class="hero-right">
            <!-- Warm Aura Backdrop Circle -->
            <div class="hero-aura-circle"></div>

            <!-- Dotted Pattern Accent -->
            <div class="hero-dots-accent"></div>

            <!-- Curled Doodle Arrow & Handwritten Motto -->
            <div class="hero-doodle-wrapper">
                <span class="hero-handwritten-text">Education today, a better tomorrow!</span>
                <svg class="hero-doodle-arrow" width="80" height="50" viewBox="0 0 90 60" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M15 15 C 40 5, 70 25, 48 50" stroke="#6B7280" stroke-width="1.8" stroke-dasharray="3 3" stroke-linecap="round"/>
                    <path d="M38 46 L 48 50 L 46 39" stroke="#6B7280" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>

            <!-- Student Portrait Image -->
            <div class="hero-student-wrapper">
                <img src="${pageContext.request.contextPath}/images/hero-student.jpg" alt="Student learning with Elearn" class="hero-student-photo">
            </div>

            <!-- 3 Stacked Floating Cards on Right -->
            <div class="hero-floating-cards">
                <!-- Card 1 -->
                <div class="floating-info-card">
                    <div class="floating-card-icon">
                        <svg viewBox="0 0 24 24" width="24" height="24" fill="#FF5722">
                            <path d="M12 3L1 9L12 15L21 10.09V17H23V9M5 13.18V17.18L12 21L19 17.18V13.18L12 17L5 13.18Z"/>
                        </svg>
                    </div>
                    <div class="floating-card-body">
                        <strong>Learn</strong>
                        <span>Anytime, Anywhere</span>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="floating-info-card">
                    <div class="floating-card-icon">
                        <svg viewBox="0 0 24 24" width="24" height="24" fill="#FF5722">
                            <path d="M5 9.2H8V19H5V9.2ZM10.5 5H13.5V19H10.5V5ZM16 12.8H19V19H16V12.8Z"/>
                        </svg>
                    </div>
                    <div class="floating-card-body">
                        <strong>Build</strong>
                        <span>In-Demand Skills</span>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="floating-info-card">
                    <div class="floating-card-icon">
                        <svg viewBox="0 0 24 24" width="24" height="24" fill="#FF5722">
                            <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                        </svg>
                    </div>
                    <div class="floating-card-body">
                        <strong>Join a Growing</strong>
                        <span>Learning Community</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ====================================================================
     2. POPULAR CATEGORIES SECTION
     ==================================================================== -->
<section class="elearn-section" id="categories">
    <div class="section-container">
        <div class="section-header-row">
            <h2 class="section-title">Popular Categories</h2>
            <a href="${pageContext.request.contextPath}/courses" class="section-link-orange">
                View All Categories
                <span class="link-arrow">&rarr;</span>
            </a>
        </div>

        <div class="categories-grid-8">
            <!-- 1. Programming (Active in reference) -->
            <a href="${pageContext.request.contextPath}/courses?category=Computer+Science" class="cat-box active">
                <div class="cat-icon-symbol">&lt;/&gt;</div>
                <span class="cat-label">Programming</span>
            </a>

            <!-- 2. Data Science -->
            <a href="${pageContext.request.contextPath}/courses?category=Data+Science" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M5 9.2H8V19H5V9.2ZM10.5 5H13.5V19H10.5V5ZM16 12.8H19V19H16V12.8Z"/>
                    </svg>
                </div>
                <span class="cat-label">Data Science</span>
            </a>

            <!-- 3. Web Development -->
            <a href="${pageContext.request.contextPath}/courses?category=Web+Development" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM11 19.93C7.05 19.44 4 16.08 4 12C4 11.38 4.08 10.79 4.21 10.21L9 15V16C9 17.1 9.9 18 11 18V19.93ZM17.9 17.39C17.64 16.58 16.9 16 16 16H15V13C15 12.45 14.55 12 14 12H8V10H10C10.55 10 11 9.55 11 9V7H13C14.1 7 15 6.1 15 5V4.59C17.93 5.78 20 8.65 20 12C20 14.08 19.2 15.97 17.9 17.39Z"/>
                    </svg>
                </div>
                <span class="cat-label">Web Development</span>
            </a>

            <!-- 4. Artificial Intelligence -->
            <a href="${pageContext.request.contextPath}/courses?category=Artificial+Intelligence" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M12 2C13.1 2 14 2.9 14 4V5H16C17.66 5 19 6.34 19 8V18C19 19.66 17.66 21 16 21H8C6.34 21 5 19.66 5 18V8C5 6.34 6.34 5 8 5H10V4C10 2.9 10.9 2 12 2ZM7.5 11C6.67 11 6 11.67 6 12.5C6 13.33 6.67 14 7.5 14C8.33 14 9 13.33 9 12.5C9 11.67 8.33 11 7.5 11ZM16.5 11C15.67 11 15 11.67 15 12.5C15 13.33 15.67 14 16.5 14C17.33 14 18 13.33 18 12.5C18 11.67 17.33 11 16.5 11ZM15 17H9V18.5H15V17Z"/>
                    </svg>
                </div>
                <span class="cat-label">Artificial Intelligence</span>
            </a>

            <!-- 5. Business -->
            <a href="${pageContext.request.contextPath}/courses?category=Business" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M20 6H16V4C16 2.89 15.11 2 14 2H10C8.89 2 8 2.89 8 4V6H4C2.89 6 2.01 6.89 2.01 8L2 19C2 20.11 2.89 21 4 21H20C21.11 21 22 20.11 22 19V8C22 6.89 21.11 6 20 6ZM10 4H14V6H10V4ZM20 19H4V8H20V19Z"/>
                    </svg>
                </div>
                <span class="cat-label">Business</span>
            </a>

            <!-- 6. Design -->
            <a href="${pageContext.request.contextPath}/courses?category=Design" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M12 3C6.5 3 2 6.5 2 12C2 14.5 3.5 16.5 5.5 16.5C6.5 16.5 7 16 7 15C7 14.5 6.5 14 6.5 13.5C6.5 12.5 7.5 11.5 8.5 11.5H10C12.8 11.5 15 9.3 15 6.5C15 4.6 13.7 3 12 3ZM6.5 10C5.7 10 5 9.3 5 8.5C5 7.7 5.7 7 6.5 7C7.3 7 8 7.7 8 8.5C8 9.3 7.3 10 6.5 10ZM9.5 7C8.7 7 8 6.3 8 5.5C8 4.7 8.7 4 9.5 4C10.3 4 11 4.7 11 5.5C11 6.3 10.3 7 9.5 7ZM14.5 7C13.7 7 13 6.3 13 5.5C13 4.7 13.7 4 14.5 4C15.3 4 16 4.7 16 5.5C16 6.3 15.3 7 14.5 7ZM17.5 10C16.7 10 16 9.3 16 8.5C16 7.7 16.7 7 17.5 7C18.3 7 19 7.7 19 8.5C19 9.3 18.3 10 17.5 10Z"/>
                    </svg>
                </div>
                <span class="cat-label">Design</span>
            </a>

            <!-- 7. Cloud Computing -->
            <a href="${pageContext.request.contextPath}/courses?category=Cloud+Computing" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M19.35 10.04C18.67 6.59 15.64 4 12 4C9.11 4 6.6 5.64 5.35 8.04C2.34 8.36 0 10.91 0 14C0 17.31 2.69 20 6 20H19C21.76 20 24 17.76 24 15C24 12.36 21.95 10.22 19.35 10.04ZM19 18H6C3.79 18 2 16.21 2 14C2 11.95 3.53 10.24 5.56 10.03L6.63 9.92L7.13 8.97C8.08 7.14 9.94 6 12 6C14.62 6 16.88 7.86 17.39 10.43L17.69 11.93L19.22 12.04C20.78 12.14 22 13.45 22 15C22 16.65 20.65 18 19 18Z"/>
                    </svg>
                </div>
                <span class="cat-label">Cloud Computing</span>
            </a>

            <!-- 8. Cybersecurity -->
            <a href="${pageContext.request.contextPath}/courses?category=Cybersecurity" class="cat-box">
                <div class="cat-icon-svg">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                        <path d="M12 1L3 5V11C3 16.55 6.84 21.74 12 23C17.16 21.74 21 16.55 21 11V5L12 1ZM12 11.99H19C18.47 16.11 15.72 19.78 12 20.93V12H5V6.3L12 3.19V11.99Z"/>
                    </svg>
                </div>
                <span class="cat-label">Cybersecurity</span>
            </a>
        </div>
    </div>
</section>

<!-- ====================================================================
     3. FEATURED COURSES SECTION
     ==================================================================== -->
<section class="elearn-section" id="courses">
    <div class="section-container">
        <div class="section-header-row">
            <h2 class="section-title">Featured Courses</h2>
            <a href="${pageContext.request.contextPath}/courses" class="section-link-orange">
                View All Courses
                <span class="link-arrow">&rarr;</span>
            </a>
        </div>

        <div class="courses-grid-6">
            <!-- Card 1: Java Programming Fundamentals -->
            <a href="${pageContext.request.contextPath}/course-details?id=1" class="course-card-compact">
                <div class="course-thumb-container">
                    <img src="${pageContext.request.contextPath}/images/thumb-java.jpg" alt="Java Programming Fundamentals" class="course-thumb-img">
                </div>
                <div class="course-card-details">
                    <h3 class="course-card-title">Java Programming Fundamentals</h3>
                    <span class="course-instructor-name">Prof. A. Sharma</span>
                    <div class="course-meta-row">
                        <span class="meta-rating"><span class="star-gold">&#9733;</span> 4.8</span>
                        <span class="meta-enrolled">
                            <svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor" class="meta-users-icon">
                                <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                            </svg>
                            1.2K enrolled
                        </span>
                    </div>
                </div>
            </a>

            <!-- Card 2: Web Development Complete Guide -->
            <a href="${pageContext.request.contextPath}/course-details?id=4" class="course-card-compact">
                <div class="course-thumb-container">
                    <img src="${pageContext.request.contextPath}/images/thumb-webdev.jpg" alt="Web Development Complete Guide" class="course-thumb-img">
                </div>
                <div class="course-card-details">
                    <h3 class="course-card-title">Web Development Complete Guide</h3>
                    <span class="course-instructor-name">Dr. R. Verma</span>
                    <div class="course-meta-row">
                        <span class="meta-rating"><span class="star-gold">&#9733;</span> 4.6</span>
                        <span class="meta-enrolled">
                            <svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor" class="meta-users-icon">
                                <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                            </svg>
                            980 enrolled
                        </span>
                    </div>
                </div>
            </a>

            <!-- Card 3: Data Science with Python -->
            <a href="${pageContext.request.contextPath}/course-details?id=5" class="course-card-compact">
                <div class="course-thumb-container">
                    <img src="${pageContext.request.contextPath}/images/thumb-datascience.jpg" alt="Data Science with Python" class="course-thumb-img">
                </div>
                <div class="course-card-details">
                    <h3 class="course-card-title">Data Science with Python</h3>
                    <span class="course-instructor-name">Prof. K. Mehta</span>
                    <div class="course-meta-row">
                        <span class="meta-rating"><span class="star-gold">&#9733;</span> 4.7</span>
                        <span class="meta-enrolled">
                            <svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor" class="meta-users-icon">
                                <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                            </svg>
                            870 enrolled
                        </span>
                    </div>
                </div>
            </a>

            <!-- Card 4: Introduction to Artificial Intelligence -->
            <a href="${pageContext.request.contextPath}/course-details?id=6" class="course-card-compact">
                <div class="course-thumb-container">
                    <img src="${pageContext.request.contextPath}/images/thumb-ai.jpg" alt="Introduction to Artificial Intelligence" class="course-thumb-img">
                </div>
                <div class="course-card-details">
                    <h3 class="course-card-title">Introduction to Artificial Intelligence</h3>
                    <span class="course-instructor-name">Dr. P. Rao</span>
                    <div class="course-meta-row">
                        <span class="meta-rating"><span class="star-gold">&#9733;</span> 4.9</span>
                        <span class="meta-enrolled">
                            <svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor" class="meta-users-icon">
                                <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                            </svg>
                            1.5K enrolled
                        </span>
                    </div>
                </div>
            </a>

            <!-- Card 5: Business Management Essentials -->
            <a href="${pageContext.request.contextPath}/course-details?id=7" class="course-card-compact">
                <div class="course-thumb-container">
                    <img src="${pageContext.request.contextPath}/images/thumb-business.jpg" alt="Business Management Essentials" class="course-thumb-img">
                </div>
                <div class="course-card-details">
                    <h3 class="course-card-title">Business Management Essentials</h3>
                    <span class="course-instructor-name">Prof. S. Iyer</span>
                    <div class="course-meta-row">
                        <span class="meta-rating"><span class="star-gold">&#9733;</span> 4.5</span>
                        <span class="meta-enrolled">
                            <svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor" class="meta-users-icon">
                                <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                            </svg>
                            640 enrolled
                        </span>
                    </div>
                </div>
            </a>

            <!-- Card 6: Cybersecurity Basics -->
            <a href="${pageContext.request.contextPath}/course-details?id=8" class="course-card-compact">
                <div class="course-thumb-container">
                    <img src="${pageContext.request.contextPath}/images/thumb-cybersecurity.jpg" alt="Cybersecurity Basics" class="course-thumb-img">
                </div>
                <div class="course-card-details">
                    <h3 class="course-card-title">Cybersecurity Basics</h3>
                    <span class="course-instructor-name">Dr. M. Khan</span>
                    <div class="course-meta-row">
                        <span class="meta-rating"><span class="star-gold">&#9733;</span> 4.7</span>
                        <span class="meta-enrolled">
                            <svg viewBox="0 0 24 24" width="13" height="13" fill="currentColor" class="meta-users-icon">
                                <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                            </svg>
                            720 enrolled
                        </span>
                    </div>
                </div>
            </a>
        </div>
    </div>
</section>

<!-- ====================================================================
     4. BOTTOM STATS BANNER & GET STARTED CTA
     ==================================================================== -->
<section class="elearn-section" style="padding-top: 0.5rem; margin-bottom: 2rem;">
    <div class="section-container">
        <div class="stats-cta-banner">
            <!-- Left 4 Stats Group -->
            <div class="stats-items-group">
                <!-- Stat 1: Students -->
                <div class="stat-badge-item">
                    <div class="stat-round-icon">
                        <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                            <path d="M16 11C17.66 11 18.99 9.66 18.99 8C18.99 6.34 17.66 5 16 5C14.34 5 13 6.34 13 8C13 9.66 14.34 11 16 11ZM8 11C9.66 11 10.99 9.66 10.99 8C10.99 6.34 9.66 5 8 5C6.34 5 5 6.34 5 8C5 9.66 6.34 11 8 11ZM8 13C5.67 13 1 14.17 1 16.5V19H15V16.5C15 14.17 10.33 13 8 13ZM16 13C15.71 13 15.38 13.02 15.03 13.05C16.19 13.89 17 15.02 17 16.5V19H23V16.5C23 14.17 18.33 13 16 13Z"/>
                        </svg>
                    </div>
                    <div class="stat-meta">
                        <span class="stat-number">5,000+</span>
                        <span class="stat-label">Students</span>
                    </div>
                </div>

                <!-- Stat 2: Courses -->
                <div class="stat-badge-item">
                    <div class="stat-round-icon">
                        <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                            <path d="M12 4.5C10.3 3.5 8.2 3 6 3C3.8 3 1.7 3.5 0 4.5V20.5C1.7 19.5 3.8 19 6 19C8.2 19 10.3 19.5 12 20.5C13.7 19.5 15.8 19 18 19C20.2 19 22.3 19.5 24 20.5V4.5C22.3 3.5 20.2 3 18 3C15.8 3 13.7 3.5 12 4.5ZM11 18.5C9.5 17.6 7.8 17 6 17C4.6 17 3.2 17.3 2 18V6.2C3.2 5.5 4.6 5.1 6 5.1C7.8 5.1 9.5 5.6 11 6.5V18.5ZM22 18C20.8 17.3 19.4 17 18 17C16.2 17 14.5 17.6 13 18.5V6.5C14.5 5.6 16.2 5.1 18 5.1C19.4 5.1 20.8 5.5 22 6.2V18Z"/>
                        </svg>
                    </div>
                    <div class="stat-meta">
                        <span class="stat-number">200+</span>
                        <span class="stat-label">Courses</span>
                    </div>
                </div>

                <!-- Stat 3: Expert Instructors -->
                <div class="stat-badge-item">
                    <div class="stat-round-icon">
                        <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                            <path d="M12 12C14.21 12 16 10.21 16 8C16 5.79 14.21 4 12 4C9.79 4 8 5.79 8 8C8 10.21 9.79 12 12 12ZM12 14C9.33 14 4 15.34 4 18V20H20V18C20 15.34 14.67 14 12 14Z"/>
                        </svg>
                    </div>
                    <div class="stat-meta">
                        <span class="stat-number">50+</span>
                        <span class="stat-label">Expert Instructors</span>
                    </div>
                </div>

                <!-- Stat 4: Average Rating -->
                <div class="stat-badge-item">
                    <div class="stat-round-icon">
                        <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF5722">
                            <path d="M12 17.27L18.18 21L16.54 13.97L22 9.24L14.81 8.63L12 2L9.19 8.63L2 9.24L7.46 13.97L5.82 21L12 17.27Z"/>
                        </svg>
                    </div>
                    <div class="stat-meta">
                        <span class="stat-number">4.8/5</span>
                        <span class="stat-label">Average Rating</span>
                    </div>
                </div>
            </div>

            <!-- Vertical Divider -->
            <div class="banner-vertical-divider"></div>

            <!-- Right Callout & Get Started Button -->
            <div class="banner-callout-side">
                <div class="banner-callout-text">
                    <h4>Start Learning Today!</h4>
                    <p>Join thousands of learners and build your future with Elearn.</p>
                </div>
                <a href="${pageContext.request.contextPath}/register" class="btn-banner-get-started">
                    Get Started
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="btn-arrow-icon">
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                        <polyline points="12 5 19 12 12 19"></polyline>
                    </svg>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- ====================================================================
     5. VIVA DEMO CREDENTIALS & ACADEMIC ALLOCATION (TSEC Sem III)
     ==================================================================== -->
<section class="elearn-section academic-footer-section" id="about">
    <div class="section-container">
        <div class="academic-drawer-card">
            <div class="academic-drawer-header">
                <div>
                    <span class="academic-badge">Academic Project Context</span>
                    <h3 style="font-size:1.1rem; font-weight:800; margin-top:0.35rem; color:#111827;">Thakur Shyamnarayan Engineering College &bull; Full Stack Java Programming (2113611)</h3>
                    <p style="font-size:0.8rem; color:#6B7280; margin-top:0.2rem;">Sr. No. 29 &bull; Roll Number Range: 108–111 &bull; Core Stack: Jakarta Servlet + JSP + JDBC + MySQL</p>
                </div>
                <div class="academic-quick-links">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-primary">Quick Login</a>
                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-sm btn-secondary">Database Catalog</a>
                </div>
            </div>
            
            <div class="academic-credentials-grid">
                <div class="cred-pill">
                    <div>
                        <span class="badge badge-role-admin">Admin</span>
                        <code style="margin-left:0.5rem; font-weight:600;">admin@ocms.com</code>
                    </div>
                    <span class="cred-pass">Password: <code>Admin@123</code></span>
                </div>
                <div class="cred-pill">
                    <div>
                        <span class="badge badge-role-instructor">Instructor</span>
                        <code style="margin-left:0.5rem; font-weight:600;">prof.sharma@ocms.com</code>
                    </div>
                    <span class="cred-pass">Password: <code>Instructor@123</code></span>
                </div>
                <div class="cred-pill">
                    <div>
                        <span class="badge badge-role-student">Student</span>
                        <code style="margin-left:0.5rem; font-weight:600;">rahul.kumar@ocms.com</code>
                    </div>
                    <span class="cred-pass">Password: <code>Student@123</code></span>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
