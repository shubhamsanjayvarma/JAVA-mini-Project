<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Register" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- ====================================================================
     SCREEN 5: EXACT ELEARN REGISTRATION PAGE (Split-Screen Layout)
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
                <h1 class="auth-main-title">Create Your Account</h1>
                <p class="auth-sub-title">Join thousands of learners today.</p>
            </div>

            <!-- Error Alerts -->
            <c:if test="${not empty errorMessage}">
                <div class="auth-alert-error">${errorMessage}</div>
            </c:if>

            <!-- Role Selector Tabs (Students / Instructor matching reference) -->
            <div class="auth-role-tabs">
                <button type="button" class="auth-role-tab active" id="tabStudent" onclick="selectRole('STUDENT')">
                    Students
                </button>
                <button type="button" class="auth-role-tab" id="tabInstructor" onclick="selectRole('INSTRUCTOR')">
                    Instructor
                </button>
            </div>

            <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form-body">
                <input type="hidden" name="role" id="selectedRoleInput" value="STUDENT">

                <div class="auth-field-group">
                    <label for="fullName" class="auth-label">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="auth-input-control" 
                           placeholder="Enter your full name" value="${fullName != null ? fullName : ''}" required autofocus>
                </div>

                <div class="auth-field-group">
                    <label for="email" class="auth-label">Email Address</label>
                    <input type="email" id="email" name="email" class="auth-input-control" 
                           placeholder="Enter your email" value="${email != null ? email : ''}" required>
                </div>

                <div class="auth-field-group">
                    <label for="password" class="auth-label">Password</label>
                    <input type="password" id="password" name="password" class="auth-input-control" 
                           placeholder="Create a password" required minlength="6">
                </div>

                <div class="auth-field-group">
                    <label for="confirmPassword" class="auth-label">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="auth-input-control" 
                           placeholder="Confirm your password" required minlength="6">
                </div>

                <div class="auth-options-row" style="margin-top: 0.25rem;">
                    <label class="auth-checkbox-label">
                        <input type="checkbox" name="terms" required checked>
                        <span>I agree to the Terms and Conditions</span>
                    </label>
                </div>

                <button type="submit" class="btn-auth-primary">Register</button>
            </form>

            <div class="auth-footer-note" style="margin-top: 1.5rem;">
                Already have an account? <a href="${pageContext.request.contextPath}/login" class="auth-orange-link">Login here</a>
            </div>
        </div>
    </div>

    <!-- Right Graphic Visual Side -->
    <div class="auth-visual-column">
        <div class="auth-visual-inner">
            <div class="auth-aura-glow"></div>
            <div class="auth-dots-pattern"></div>
            
            <div class="auth-photo-wrap">
                <img src="${pageContext.request.contextPath}/images/register-student.png" alt="Student learning journey" class="auth-student-img">
            </div>

            <div class="auth-journey-callout">
                <h2>Start Your<br>Learning Journey</h2>
                <p>Gain new skills, get certified, and build a brighter future with Elearn.</p>
            </div>
        </div>
    </div>
</div>

<script>
function selectRole(role) {
    document.getElementById('selectedRoleInput').value = role;
    if (role === 'STUDENT') {
        document.getElementById('tabStudent').classList.add('active');
        document.getElementById('tabInstructor').classList.remove('active');
    } else {
        document.getElementById('tabInstructor').classList.add('active');
        document.getElementById('tabStudent').classList.remove('active');
    }
}
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
