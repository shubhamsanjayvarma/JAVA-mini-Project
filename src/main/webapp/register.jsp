<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Create Your Account" />
<c:set var="isPublicPage" value="true" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- ====================================================================
     EXACT ELEARN REGISTRATION PAGE (Matching User Reference Image)
     ==================================================================== -->
<div class="auth-split-container">
    <!-- Left Registration Form Side -->
    <div class="auth-form-column">
        <div class="auth-form-inner-wide">
            
            <!-- Eyebrow -->
            <div class="auth-eyebrow-row">
                <span class="auth-eyebrow-dash"></span>
                <span class="auth-eyebrow-text">JOIN ELEARN</span>
            </div>

            <!-- Header Titles -->
            <h1 class="auth-main-title">Create Your Account</h1>
            <p class="auth-sub-title">Join thousands of learners today and start your learning journey with Elearn.</p>

            <!-- Error Notification -->
            <c:if test="${not empty errorMessage}">
                <div class="auth-alert-error" style="margin-bottom: 1.25rem;">
                    <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:0.5rem; flex-shrink:0;"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                    <span>${errorMessage}</span>
                </div>
            </c:if>

            <!-- Role Selector ("I am a") -->
            <div class="reg-role-section">
                <label class="reg-role-label">I am a</label>
                <div class="reg-role-cards-grid">
                    <!-- Student Card (Default Active) -->
                    <div class="reg-role-card ${empty selectedRole or selectedRole eq 'STUDENT' ? 'active' : ''}" 
                         id="cardStudent" onclick="selectRole('STUDENT')">
                        <div class="role-card-icon-box role-icon-student">
                            <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF6500"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
                        </div>
                        <div class="role-card-info">
                            <div class="role-card-name">Student</div>
                            <div class="role-card-tagline">Learn new skills</div>
                        </div>
                    </div>

                    <!-- Instructor Card -->
                    <div class="reg-role-card ${selectedRole eq 'INSTRUCTOR' ? 'active' : ''}" 
                         id="cardInstructor" onclick="selectRole('INSTRUCTOR')">
                        <div class="role-card-icon-box role-icon-instructor">
                            <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="#FF6500" stroke-width="2"><path d="M2 3h20v14H2z"></path><path d="M8 21h8"></path><path d="M12 17v4"></path></svg>
                        </div>
                        <div class="role-card-info">
                            <div class="role-card-name">Instructor</div>
                            <div class="role-card-tagline">Share your knowledge</div>
                        </div>
                    </div>

                    <!-- Administrator Card -->
                    <div class="reg-role-card ${selectedRole eq 'ADMIN' ? 'active' : ''}" 
                         id="cardAdmin" onclick="selectRole('ADMIN')">
                        <div class="role-card-icon-box role-icon-admin">
                            <svg viewBox="0 0 24 24" width="22" height="22" fill="#FF6500"><path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"/></svg>
                        </div>
                        <div class="role-card-info">
                            <div class="role-card-name">Administrator</div>
                            <div class="role-card-tagline">Manage the platform</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Registration Form -->
            <form action="${pageContext.request.contextPath}/register" method="post" class="reg-form-grid" id="registerForm">
                <input type="hidden" name="role" id="roleInputField" value="${not empty selectedRole ? selectedRole : 'STUDENT'}">

                <!-- Row 1: Full Name & Email Address -->
                <div class="reg-field-pair">
                    <div class="reg-field-item">
                        <label for="fullName" class="reg-label">Full Name</label>
                        <div class="reg-input-wrap">
                            <svg class="reg-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            <input type="text" id="fullName" name="fullName" class="reg-input-control" 
                                   placeholder="Enter your full name" value="${fullName != null ? fullName : ''}" required autofocus>
                        </div>
                    </div>
                    
                    <div class="reg-field-item">
                        <label for="email" class="reg-label">Email Address</label>
                        <div class="reg-input-wrap">
                            <svg class="reg-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            <input type="email" id="email" name="email" class="reg-input-control" 
                                   placeholder="Enter your email address" value="${email != null ? email : ''}" required>
                        </div>
                    </div>
                </div>

                <!-- Row 2: Password & Confirm Password -->
                <div class="reg-field-pair">
                    <div class="reg-field-item">
                        <label for="password" class="reg-label">Password</label>
                        <div class="reg-input-wrap">
                            <svg class="reg-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            <input type="password" id="password" name="password" class="reg-input-control" 
                                   placeholder="Create a password" required minlength="6">
                            <button type="button" class="reg-pw-toggle" onclick="togglePasswordVisibility('password', this)" title="Show/Hide Password">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                    </div>
                    
                    <div class="reg-field-item">
                        <label for="confirmPassword" class="reg-label">Confirm Password</label>
                        <div class="reg-input-wrap">
                            <svg class="reg-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="reg-input-control" 
                                   placeholder="Confirm your password" required minlength="6">
                            <button type="button" class="reg-pw-toggle" onclick="togglePasswordVisibility('confirmPassword', this)" title="Show/Hide Password">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Row 3: Phone Number (Optional) -->
                <div class="reg-field-item full-width">
                    <label for="phone" class="reg-label">Phone Number (Optional)</label>
                    <div class="reg-input-wrap">
                        <svg class="reg-input-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                        <input type="tel" id="phone" name="phone" class="reg-input-control" 
                               placeholder="Enter your phone number" value="${phone != null ? phone : ''}">
                    </div>
                </div>

                <!-- Terms & Privacy Agreement -->
                <div class="reg-terms-row">
                    <label class="reg-checkbox-label">
                        <input type="checkbox" name="terms" required checked class="reg-checkbox-input">
                        <span class="reg-checkbox-text">
                            I agree to the <a href="${pageContext.request.contextPath}/#about" class="text-orange">Terms of Use</a> and <a href="${pageContext.request.contextPath}/#about" class="text-orange">Privacy Policy</a>
                        </span>
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-reg-submit">
                    Create Account &rarr;
                </button>

                <!-- Divider -->
                <div class="reg-divider">
                    <span>or sign up with</span>
                </div>

                <!-- Social Logins -->
                <div class="reg-social-grid">
                    <button type="button" class="btn-social-reg" onclick="alert('Google authentication demo: Please complete registration form above or use quick demo credentials.')">
                        <svg width="18" height="18" viewBox="0 0 24 24" class="social-btn-icon">
                            <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.665-5.17 3.665-9.17z"/>
                            <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.24v3.15C3.26 21.36 7.33 24 12 24z"/>
                            <path fill="#FBBC05" d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.24C.45 8.15 0 9.92 0 12s.45 3.85 1.24 5.42l4.04-3.15z"/>
                            <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.24 6.58l4.04 3.15c.95-2.83 3.6-4.98 6.72-4.98z"/>
                        </svg>
                        <span>Continue with Google</span>
                    </button>

                    <button type="button" class="btn-social-reg" onclick="alert('GitHub authentication demo: Please complete registration form above or use quick demo credentials.')">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="#181717" class="social-btn-icon">
                            <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0 0 24 12c0-6.63-5.37-12-12-12z"/>
                        </svg>
                        <span>Continue with GitHub</span>
                    </button>
                </div>

                <!-- Bottom Login Link -->
                <div class="reg-bottom-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-orange" style="font-weight: 700;">Login here</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Right Feature Showcase & Student Visual Side -->
    <div class="auth-visual-column">
        <div class="auth-showcase-panel-wrapper">
            <img src="${pageContext.request.contextPath}/images/register-showcase-panel.png" 
                 alt="Start Your Learning Journey with Elearn" 
                 class="auth-showcase-panel-img">
        </div>
    </div>
</div>

<script>
function selectRole(role) {
    document.getElementById('roleInputField').value = role;
    const cards = {
        'STUDENT': document.getElementById('cardStudent'),
        'INSTRUCTOR': document.getElementById('cardInstructor'),
        'ADMIN': document.getElementById('cardAdmin')
    };
    Object.keys(cards).forEach(r => {
        if (cards[r]) {
            if (r === role) {
                cards[r].classList.add('active');
            } else {
                cards[r].classList.remove('active');
            }
        }
    });
}

function togglePasswordVisibility(fieldId, btn) {
    const input = document.getElementById(fieldId);
    if (input.type === 'password') {
        input.type = 'text';
        btn.style.color = '#FF6500';
    } else {
        input.type = 'password';
        btn.style.color = '#98A2B3';
    }
}
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
