<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Student Registration" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div style="max-width: 580px; margin: 1.5rem auto;">
    <div class="card">
        <div class="card-header" style="text-align: center;">
            <h3 style="color: var(--primary-color);">Student Enrollment Registration</h3>
            <span style="font-size: 0.8rem; color: var(--text-muted);">Create a new learner account</span>
        </div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" 
                           value="${fullName != null ? fullName : ''}" placeholder="e.g. Rahul Kumar" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Institutional Email *</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               value="${email != null ? email : ''}" placeholder="student@ocms.com" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Contact Phone</label>
                        <input type="text" id="phone" name="phone" class="form-control" 
                               value="${phone != null ? phone : ''}" placeholder="+91 9876543210">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password (min 6 characters) *</label>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="Enter secure password" required minlength="6">
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password *</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                               placeholder="Re-enter password" required minlength="6">
                    </div>
                </div>

                <div class="form-group">
                    <label for="bio">Academic Background / Roll Number</label>
                    <textarea id="bio" name="bio" class="form-control" style="min-height: 70px;" 
                              placeholder="e.g. B.Tech CSE (AIML), Sem 3, Roll 108">${bio != null ? bio : ''}</textarea>
                </div>

                <button type="submit" class="btn btn-accent" style="width: 100%; padding: 0.75rem; margin-top: 0.5rem; font-size: 0.95rem;">
                    Complete Registration
                </button>
            </form>

            <div style="margin-top: 1.25rem; text-align: center; font-size: 0.85rem;">
                <span style="color: var(--text-muted);">Already registered?</span>
                <a href="${pageContext.request.contextPath}/login" style="color: var(--secondary-color); font-weight: 500;">Sign In</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
