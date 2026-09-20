<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:choose>
    <c:when test="${not empty sessionScope.userId and not isHomePage and not isPublicPage}">
                    </main><!-- /.dashboard-main-body -->
                </div><!-- /.app-content-wrapper -->
            </div><!-- /.app-frame -->
        </div><!-- /.app-viewport -->
    </c:when>
    <c:otherwise>
        </main>

        <!-- ====================================================================
             ELEARN CALL-TO-ACTION (CTA) BANNER (Matches Reference Mockup)
             ==================================================================== -->
        <section class="footer-cta-section">
            <div class="footer-cta-container">
                <div class="footer-cta-card">
                    <!-- Background Dot Matrix Grid (Top Right) -->
                    <div class="footer-cta-dots">
                        <svg width="68" height="48" viewBox="0 0 68 48" fill="none">
                            <g fill="#FDBA74" opacity="0.85">
                                <circle cx="6" cy="6" r="2.2" />
                                <circle cx="22" cy="6" r="2.2" />
                                <circle cx="38" cy="6" r="2.2" />
                                <circle cx="54" cy="6" r="2.2" />
                                <circle cx="6" cy="18" r="2.2" />
                                <circle cx="22" cy="18" r="2.2" />
                                <circle cx="38" cy="18" r="2.2" />
                                <circle cx="54" cy="18" r="2.2" />
                                <circle cx="6" cy="30" r="2.2" />
                                <circle cx="22" cy="30" r="2.2" />
                                <circle cx="38" cy="30" r="2.2" />
                                <circle cx="54" cy="30" r="2.2" />
                                <circle cx="6" cy="42" r="2.2" />
                                <circle cx="22" cy="42" r="2.2" />
                                <circle cx="38" cy="42" r="2.2" />
                                <circle cx="54" cy="42" r="2.2" />
                            </g>
                        </svg>
                    </div>

                    <!-- Left Graduation Cap Badge & Sparkle Accents -->
                    <div class="footer-cta-icon-group">
                        <div class="cta-sparkle-rays">
                            <span class="sparkle-ray sparkle-ray-1"></span>
                            <span class="sparkle-ray sparkle-ray-2"></span>
                        </div>
                        <div class="footer-cta-cap-badge">
                            <svg viewBox="0 0 64 64" width="52" height="52" fill="none">
                                <path d="M32 12 L6 26 L32 40 L58 26 Z" fill="#FF6500" />
                                <path d="M14 30.5 V42 C14 42 21 50 32 50 C43 50 50 42 50 42 V30.5 L32 41.5 Z" fill="#101828" />
                                <path d="M51 28 V44 C51 46 49 48 47 48" stroke="#FF6500" stroke-width="2.5" stroke-linecap="round" />
                                <circle cx="47" cy="48" r="3" fill="#FF6500" />
                            </svg>
                        </div>
                    </div>

                    <!-- Content Block -->
                    <div class="footer-cta-content">
                        <span class="footer-cta-eyebrow">READY TO LEARN?</span>
                        <h2 class="footer-cta-heading">
                            Start Your Learning Journey <span class="text-orange">Today</span>
                        </h2>
                        <p class="footer-cta-subtext">
                            Join thousands of learners and take the next step towards a brighter future.
                        </p>
                    </div>

                    <!-- Right Action Button -->
                    <div class="footer-cta-action">
                        <a href="${pageContext.request.contextPath}/register" class="footer-cta-btn">
                            Get Started &rarr;
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- ====================================================================
             ELEARN DEEP DARK NAVY 5-COLUMN FOOTER
             ==================================================================== -->
        <footer class="elearn-dark-footer">
            <div class="footer-container">
                <div class="footer-columns-grid">
                    <!-- Column 1: Brand, About, Socials & Handwritten Motto -->
                    <div class="footer-col footer-col-brand">
                        <a href="${pageContext.request.contextPath}/" class="footer-brand-header">
                            <div class="footer-brand-icon">
                                <svg viewBox="0 0 48 48" width="38" height="38" fill="none">
                                    <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF6500"/>
                                    <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E55A00"/>
                                    <path d="M42 19V34C42 35.1 41.1 36 40 36C38.9 36 38 35.1 38 34V19" stroke="#E55A00" stroke-width="2" stroke-linecap="round"/>
                                    <circle cx="39" cy="35" r="2.5" fill="#E55A00"/>
                                </svg>
                            </div>
                            <div>
                                <div class="footer-brand-title">Elearn</div>
                                <div class="footer-brand-subtitle">Online Course Management System</div>
                            </div>
                        </a>
                        
                        <p class="footer-brand-description">
                            Elearn is a modern online learning platform designed to help students learn from expert instructors, build in-demand skills, and achieve their academic and career goals.
                        </p>

                        <!-- Social Media Icons -->
                        <div class="footer-social-row">
                            <a href="https://instagram.com" target="_blank" rel="noopener" class="footer-social-btn" title="Instagram">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>
                            </a>
                            <a href="https://linkedin.com" target="_blank" rel="noopener" class="footer-social-btn" title="LinkedIn">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg>
                            </a>
                            <a href="https://youtube.com" target="_blank" rel="noopener" class="footer-social-btn" title="YouTube">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22.54 6.42a2.78 2.78 0 0 0-1.94-2C18.88 4 12 4 12 4s-6.88 0-8.6.46a2.78 2.78 0 0 0-1.94 2A29 29 0 0 0 1 11.75a29 29 0 0 0 .46 5.33A2.78 2.78 0 0 0 3.4 19c1.72.46 8.6.46 8.6.46s6.88 0 8.6-.46a2.78 2.78 0 0 0 1.94-2 29 29 0 0 0 .46-5.25 29 29 0 0 0-.46-5.33z"></path><polygon points="9.75 15.02 15.5 11.75 9.75 8.48 9.75 15.02" fill="currentColor"></polygon></svg>
                            </a>
                            <a href="https://twitter.com" target="_blank" rel="noopener" class="footer-social-btn" title="Twitter">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>
                            </a>
                        </div>

                        <!-- Handwritten Motto -->
                        <div class="footer-motto-wrapper">
                            <div class="footer-motto-text">
                                <span>Learn Today</span>
                                <span>Lead Tomorrow</span>
                            </div>
                            <svg class="footer-motto-curve" viewBox="0 0 120 18" fill="none">
                                <path d="M 4 12 C 40 18, 75 17, 116 6" stroke="#FF6500" stroke-width="2.6" stroke-linecap="round" />
                            </svg>
                        </div>
                    </div>

                    <!-- Column 2: Quick Links -->
                    <div class="footer-col">
                        <h4 class="footer-col-title">Quick Links</h4>
                        <ul class="footer-nav-list footer-chevron-list">
                            <li><a href="${pageContext.request.contextPath}/"><span class="nav-chevron">&rsaquo;</span> Home</a></li>
                            <li><a href="${pageContext.request.contextPath}/courses"><span class="nav-chevron">&rsaquo;</span> Courses</a></li>
                            <li><a href="${pageContext.request.contextPath}/#about"><span class="nav-chevron">&rsaquo;</span> About Us</a></li>
                            <li><a href="${pageContext.request.contextPath}/#contact"><span class="nav-chevron">&rsaquo;</span> Contact</a></li>
                            <li><a href="${pageContext.request.contextPath}/courses"><span class="nav-chevron">&rsaquo;</span> Blog</a></li>
                            <li><a href="${pageContext.request.contextPath}/#faq"><span class="nav-chevron">&rsaquo;</span> FAQ</a></li>
                        </ul>
                    </div>

                    <!-- Column 3: For Learners -->
                    <div class="footer-col">
                        <h4 class="footer-col-title">For Learners</h4>
                        <ul class="footer-nav-list footer-icon-list">
                            <li>
                                <a href="${pageContext.request.contextPath}/courses">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                                    Browse Courses
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/student/my-courses">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                    My Learning
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/student/dashboard">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="20" x2="12" y2="10"></line><line x1="18" y1="20" x2="18" y2="4"></line><line x1="6" y1="20" x2="6" y2="16"></line></svg>
                                    Track Progress
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/student/results">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="6"></circle><path d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"></path></svg>
                                    Get Certificates
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/courses">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                    Learning Community
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/#about">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
                                    Help & Support
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Column 4: For Instructors -->
                    <div class="footer-col">
                        <h4 class="footer-col-title">For Instructors</h4>
                        <ul class="footer-nav-list footer-icon-list">
                            <li>
                                <a href="${pageContext.request.contextPath}/instructor/course-form">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                                    Create a Course
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/instructor/courses">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="22 7 13.5 15.5 8.5 10.5 2 17"></polyline><polyline points="16 7 22 7 22 13"></polyline></svg>
                                    Manage Courses
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/instructor/students">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                    View Students
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/instructor/dashboard">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>
                                    Analytics
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/instructor/dashboard">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"></rect><line x1="2" y1="10" x2="22" y2="10"></line></svg>
                                    Earnings
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/#about">
                                    <svg class="footer-item-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
                                    Instructor Guide
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Column 5: Contact Us -->
                    <div class="footer-col footer-col-contact">
                        <h4 class="footer-col-title">Contact Us</h4>
                        <ul class="footer-contact-list">
                            <li class="contact-item">
                                <svg class="contact-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                <div class="contact-text">
                                    <strong>Thakur Shyamnarayan</strong><br>
                                    Engineering College<br>
                                    Kandivali, Mumbai - 400101
                                </div>
                            </li>
                            <li class="contact-item">
                                <svg class="contact-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                                <div class="contact-text">
                                    <a href="mailto:support@elearn.in">support@elearn.in</a>
                                </div>
                            </li>
                            <li class="contact-item">
                                <svg class="contact-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                                <div class="contact-text">
                                    <a href="tel:+912212345678">+91 22 1234 5678</a>
                                </div>
                            </li>
                            <li class="contact-item">
                                <svg class="contact-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                <div class="contact-text">
                                    Mon - Sat, 9:00 AM - 6:00 PM
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Footer Bottom Bar -->
                <div class="footer-bottom-bar">
                    <div class="footer-copyright">
                        &copy; 2026 Elearn. All rights reserved.
                    </div>

                    <div class="footer-bottom-right">
                        <div class="footer-policy-links">
                            <a href="${pageContext.request.contextPath}/#about">Privacy Policy</a>
                            <span class="policy-divider">|</span>
                            <a href="${pageContext.request.contextPath}/#about">Terms of Use</a>
                            <span class="policy-divider">|</span>
                            <a href="${pageContext.request.contextPath}/#about">Refund Policy</a>
                        </div>

                        <div class="footer-built-by">
                            <svg class="footer-heart-svg" viewBox="0 0 24 24" width="22" height="22" fill="#FF6500">
                                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                            </svg>
                            <div class="footer-built-text">
                                <span class="built-line1">Built for Learners,</span>
                                <span class="built-line2">By Learners.</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </c:otherwise>
</c:choose>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
