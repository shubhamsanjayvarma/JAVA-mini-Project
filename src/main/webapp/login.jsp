<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Login" />
<c:set var="isPublicPage" value="true" scope="request" />
<c:set var="isAuthPage" value="true" scope="request" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- ====================================================================
     SCREEN 4: EXACT ELEARN LOGIN PAGE (Split-Screen Layout)
     ==================================================================== -->
<div class="auth-split-container">
    <!-- Left Form Side -->
    <div class="auth-form-column">
        <div class="auth-form-inner">
            <!-- Brand Header -->
            <div class="auth-brand-head">
                <a href="${pageContext.request.contextPath}/" class="auth-logo-link">
                    <svg viewBox="0 0 48 48" fill="none" class="brand-cap-svg" style="width:34px; height:34px;">
                        <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                        <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                        <path d="M42 19V34C42 35.1 41.1 36 40 36C38.9 36 38 35.1 38 34V19" stroke="#E64A19" stroke-width="2" stroke-linecap="round"/>
                        <circle cx="39" cy="35" r="2.5" fill="#E64A19"/>
                    </svg>
                    <span class="auth-logo-title">Elearn</span>
                </a>
            </div>

            <div class="auth-headings">
                <h1 class="auth-main-title">Welcome Back</h1>
                <p class="auth-sub-title">Login to continue your learning journey.</p>
            </div>

            <!-- Error Alerts -->
            <c:if test="${not empty errorMessage}">
                <div class="auth-alert-error">${errorMessage}</div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="auth-alert-success">${successMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form-body">
                <div class="auth-field-group">
                    <label for="email" class="auth-label">Email Address</label>
                    <input type="email" id="email" name="email" class="auth-input-control" 
                           placeholder="Enter your email" value="${email != null ? email : ''}" required autofocus>
                </div>

                <div class="auth-field-group">
                    <label for="password" class="auth-label">Password</label>
                    <input type="password" id="password" name="password" class="auth-input-control" 
                           placeholder="Enter your password" required>
                </div>

                <div class="auth-options-row">
                    <label class="auth-checkbox-label">
                        <input type="checkbox" name="remember" value="true">
                        <span>Remember Me</span>
                    </label>
                    <a href="#" class="auth-forgot-link">Forgot Password?</a>
                </div>

                <button type="submit" class="btn-auth-primary">Login</button>
            </form>

            <div class="auth-divider-wrap">
                <span>or continue with</span>
            </div>

            <!-- Social Action Row matching Reference Screen 4 -->
            <div class="auth-social-group">
                <button type="button" class="btn-social-outline">
                    <svg viewBox="0 0 24 24" width="18" height="18">
                        <path fill="#EA4335" d="M12 5c1.6 0 3 .6 4.1 1.7l3.1-3.1C17.3 1.8 14.8 1 12 1 7.5 1 3.7 3.6 1.9 7.3l3.7 2.9C6.5 7.2 9 5 12 5z"/>
                        <path fill="#4285F4" d="M23.5 12.3c0-.8-.1-1.7-.2-2.3H12v4.6h6.5c-.3 1.5-1.1 2.8-2.4 3.7l3.7 2.9c2.2-2 3.7-5 3.7-8.9z"/>
                        <path fill="#FBBC05" d="M5.6 14.8c-.2-.7-.4-1.5-.4-2.8s.2-2.1.4-2.8L1.9 6.3C.7 8.7 0 10.8 0 12s.7 3.3 1.9 5.7l3.7-2.9z"/>
                        <path fill="#34A853" d="M12 23c3.2 0 6-1.1 8-3l-3.7-2.9c-1.1.7-2.5 1.2-4.3 1.2-3 0-5.5-2.2-6.4-5.2L1.9 16C3.7 19.7 7.5 23 12 23z"/>
                    </svg>
                    Google
                </button>
                <button type="button" class="btn-social-outline">
                    <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                    </svg>
                    GitHub
                </button>
            </div>

            <div class="auth-footer-note">
                Don't have an account? <a href="${pageContext.request.contextPath}/register" class="auth-orange-link">Register here</a>
            </div>

            <!-- TSEC Academic Evaluation Credentials Box -->
            <div class="auth-academic-demo-box">
                <span class="demo-box-label">Quick Test Logins (TSEC Sem III):</span>
                <div class="demo-pills-row">
                    <button type="button" class="demo-credential-chip" onclick="document.getElementById('email').value='rahul.kumar@ocms.com'; document.getElementById('password').value='Student@123';">
                        Student: rahul.kumar@ocms.com
                    </button>
                    <button type="button" class="demo-credential-chip" onclick="document.getElementById('email').value='prof.sharma@ocms.com'; document.getElementById('password').value='Instructor@123';">
                        Instructor: prof.sharma@ocms.com
                    </button>
                    <button type="button" class="demo-credential-chip" onclick="document.getElementById('email').value='admin@ocms.com'; document.getElementById('password').value='Admin@123';">
                        Admin: admin@ocms.com
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Graphic Visual Side -->
    <div class="auth-visual-column">
        <div class="auth-visual-inner">
            <div class="auth-aura-glow"></div>
            <div class="auth-dots-pattern"></div>
            
            <div class="auth-illustration-wrap">
                <img src="${pageContext.request.contextPath}/images/login-illustration.png" alt="Learn Grow Achieve" class="auth-illustration-img">
            </div>

            <div class="auth-slogan-block">
                <h2>Learn</h2>
                <h2>Grow</h2>
                <h2>Achieve</h2>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
