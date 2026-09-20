<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="User Login" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div style="max-width: 480px; margin: 2rem auto;">
    <div class="card">
        <div class="card-header" style="text-align: center;">
            <h3 style="color: var(--primary-color);">Portal Authentication</h3>
            <span style="font-size: 0.8rem; color: var(--text-muted);">Sign in to access your dashboard</span>
        </div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Institutional Email</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="${email != null ? email : ''}" placeholder="username@ocms.com" required autofocus>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Enter your account password" required>
                </div>

                <button type="submit" class="btn btn-accent" style="width: 100%; padding: 0.75rem; margin-top: 0.5rem; font-size: 0.95rem;">
                    Sign In
                </button>
            </form>

            <div style="margin-top: 1.25rem; text-align: center; font-size: 0.85rem;">
                <span style="color: var(--text-muted);">Don't have an account?</span>
                <a href="${pageContext.request.contextPath}/register" style="color: var(--secondary-color); font-weight: 500;">Register as Student</a>
            </div>
        </div>
    </div>

    <!-- Quick viva helper -->
    <div class="card" style="font-size: 0.8rem;">
        <div class="card-header" style="padding: 0.5rem 1rem;">Demo Credentials</div>
        <div class="card-body" style="padding: 0.75rem 1rem;">
            <p><strong>Admin:</strong> <code>admin@ocms.com</code> / <code>Admin@123</code></p>
            <p><strong>Instructor:</strong> <code>prof.sharma@ocms.com</code> / <code>Instructor@123</code></p>
            <p><strong>Student:</strong> <code>rahul.kumar@ocms.com</code> / <code>Student@123</code></p>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
