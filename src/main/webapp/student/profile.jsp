<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="My Profile" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 15: Header Bar -->
<div class="dash-header-row">
    <div>
        <div class="topbar-breadcrumb" style="margin-bottom: 0.35rem;">
            <a href="${pageContext.request.contextPath}/student/dashboard">&larr; Back to Dashboard</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF6500; font-weight: 700;">Account Settings</span>
        </div>
        <h1 class="dash-greeting-title">Profile & Credentials</h1>
        <p class="dash-greeting-subtitle">Manage your personal information, university credentials, and security password.</p>
    </div>
</div>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-error">${errorMessage}</div>
</c:if>

<!-- Screen 15: Two-Column Profile Layout -->
<div style="display: grid; grid-template-columns: 1.65fr 1fr; gap: 1.75rem; align-items: start;">
    <!-- Left Column: Personal Information Form -->
    <div class="dash-panel-card" style="padding: 2rem;">
        <!-- Avatar & User Heading -->
        <div style="display: flex; align-items: center; gap: 1.25rem; padding-bottom: 1.5rem; margin-bottom: 1.5rem; border-bottom: 1px solid #f3f4f6;">
            <div style="width: 68px; height: 68px; border-radius: 50%; background: #FF6500; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.8rem; font-weight: 900; box-shadow: 0 4px 14px rgba(255, 101, 0, 0.3);">
                ${not empty user.fullName ? fn:substring(user.fullName, 0, 1) : 'S'}
            </div>
            <div>
                <h2 style="font-size: 1.35rem; font-weight: 900; color: #111827; margin-bottom: 0.25rem;">${user.fullName}</h2>
                <div style="display: flex; align-items: center; gap: 0.65rem;">
                    <span class="badge badge-role-student" style="font-size: 0.75rem;">${user.role}</span>
                    <span style="font-size: 0.85rem; color: #6b7280;">${user.email}</span>
                </div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/student/profile" method="post">
            <input type="hidden" name="action" value="updateProfile">

            <div class="form-group" style="margin-bottom: 1.25rem;">
                <label for="fullName" style="font-size: 0.88rem; font-weight: 700; color: #111827; margin-bottom: 0.4rem; display: block;">
                    Full Name *
                </label>
                <input type="text" id="fullName" name="fullName" class="form-control" value="${user.fullName}" required style="padding: 0.7rem 0.9rem;">
            </div>

            <div class="form-group" style="margin-bottom: 1.25rem;">
                <label style="font-size: 0.88rem; font-weight: 700; color: #111827; margin-bottom: 0.4rem; display: block;">
                    Institutional Email Address (Read Only)
                </label>
                <input type="text" class="form-control" value="${user.email}" disabled style="background: #f9fafb; color: #6b7280; padding: 0.7rem 0.9rem;">
            </div>

            <div class="form-group" style="margin-bottom: 1.25rem;">
                <label for="phone" style="font-size: 0.88rem; font-weight: 700; color: #111827; margin-bottom: 0.4rem; display: block;">
                    Phone Number
                </label>
                <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}" placeholder="+91 9876543210" style="padding: 0.7rem 0.9rem;">
            </div>

            <div class="form-group" style="margin-bottom: 1.75rem;">
                <label for="bio" style="font-size: 0.88rem; font-weight: 700; color: #111827; margin-bottom: 0.4rem; display: block;">
                    Academic Bio / Department & Roll Number
                </label>
                <textarea id="bio" name="bio" class="form-control" style="min-height: 100px; padding: 0.75rem 0.9rem; line-height: 1.6;" 
                          placeholder="B.Tech Computer Engineering &bull; Roll No. 108 &bull; FSJP">${user.bio}</textarea>
            </div>

            <button type="submit" class="btn-dash-primary" style="padding: 0.75rem 1.85rem;">
                Save Profile Changes &rarr;
            </button>
        </form>
    </div>

    <!-- Right Column: Security & Password Card -->
    <div>
        <div class="dash-panel-card" style="padding: 1.75rem; margin-bottom: 1.5rem;">
            <h3 class="dash-panel-title" style="margin-bottom: 0.35rem;">Security & Password</h3>
            <p style="font-size: 0.82rem; color: #6b7280; margin-bottom: 1.25rem;">Ensure your account uses a strong password.</p>

            <form action="${pageContext.request.contextPath}/student/profile" method="post">
                <input type="hidden" name="action" value="changePassword">

                <div class="form-group" style="margin-bottom: 1.15rem;">
                    <label for="oldPassword" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                        Current Password *
                    </label>
                    <input type="password" id="oldPassword" name="oldPassword" class="form-control" required style="padding: 0.65rem 0.85rem;">
                </div>

                <div class="form-group" style="margin-bottom: 1.15rem;">
                    <label for="newPassword" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                        New Password (min 6 characters) *
                    </label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required minlength="6" style="padding: 0.65rem 0.85rem;">
                </div>

                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label for="confirmPassword" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                        Confirm New Password *
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required minlength="6" style="padding: 0.65rem 0.85rem;">
                </div>

                <button type="submit" class="btn-dash-outline" style="width: 100%; justify-content: center; padding: 0.7rem;">
                    Update Password
                </button>
            </form>
        </div>

        <!-- Academic Credentials Info Box -->
        <div class="dash-panel-card" style="background: #fffcf9; border-color: #FFE4D6; padding: 1.5rem;">
            <div style="font-size: 0.8rem; font-weight: 800; color: #FF6500; text-transform: uppercase; margin-bottom: 0.5rem;">
                Academic Project Information
            </div>
            <div style="font-size: 0.85rem; color: #4b5563; line-height: 1.6;">
                <p style="margin: 0 0 0.35rem 0;"><strong>Course:</strong> Full Stack Java Programming (2113611)</p>
                <p style="margin: 0 0 0.35rem 0;"><strong>Program:</strong> B.Tech CSE (AI & ML) - Sem III</p>
                <p style="margin: 0;"><strong>Roll No. Range:</strong> 108 – 111</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
