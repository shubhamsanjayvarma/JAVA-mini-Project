<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="My Profile" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Student Profile Management</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Manage your personal and credential information</span>
</div>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-error">${errorMessage}</div>
</c:if>

<div class="grid-2">
    <!-- Profile Info Form -->
    <div class="card">
        <div class="card-header">Personal Information</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/student/profile" method="post">
                <input type="hidden" name="action" value="updateProfile">

                <div class="form-group">
                    <label>Institutional Email (Read Only)</label>
                    <input type="text" class="form-control" value="${user.email}" disabled style="background:#edf2f7;">
                </div>

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" value="${user.fullName}" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}">
                </div>

                <div class="form-group">
                    <label for="bio">Academic Bio / Roll Number</label>
                    <textarea id="bio" name="bio" class="form-control" style="min-height: 80px;">${user.bio}</textarea>
                </div>

                <button type="submit" class="btn btn-primary">Save Profile Changes</button>
            </form>
        </div>
    </div>

    <!-- Password Change Form -->
    <div class="card">
        <div class="card-header">Security & Password</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/student/profile" method="post">
                <input type="hidden" name="action" value="changePassword">

                <div class="form-group">
                    <label for="oldPassword">Current Password</label>
                    <input type="password" id="oldPassword" name="oldPassword" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="newPassword">New Password (min 6 characters)</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required minlength="6">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required minlength="6">
                </div>

                <button type="submit" class="btn btn-secondary">Update Password</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
