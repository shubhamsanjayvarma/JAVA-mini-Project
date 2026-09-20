<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="pageTitle" value="User Management" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 14: Top Bar -->
<div class="dash-header-row">
    <div>
        <div class="topbar-breadcrumb" style="margin-bottom: 0.35rem;">
            <a href="${pageContext.request.contextPath}/admin/dashboard">&larr; Back to Dashboard</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF6500; font-weight: 700;">Users Management</span>
        </div>
        <h1 class="dash-greeting-title">User Account Administration</h1>
        <p class="dash-greeting-subtitle">Provision faculty accounts, manage student registrations, and toggle system statuses.</p>
    </div>
</div>

<!-- Screen 14: Two-Column Users Management Layout -->
<div style="display: grid; grid-template-columns: 2fr 1.15fr; gap: 1.75rem; align-items: start;">
    <!-- Left Column: Users Table Panel -->
    <div class="dash-panel-card">
        <div class="dash-panel-header">
            <h2 class="dash-panel-title">All Registered Users (${not empty users ? fn:length(users) : 0})</h2>
            <span style="font-size: 0.8rem; color: #6b7280;">Real-time database records</span>
        </div>

        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>User Profile</th>
                        <th>Email Address</th>
                        <th>Assigned Role</th>
                        <th>Status</th>
                        <th style="text-align: right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>
                                <div style="display: flex; align-items: center; gap: 0.65rem;">
                                    <div style="width: 32px; height: 32px; border-radius: 50%; background: #111827; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 700; flex-shrink: 0;">
                                        ${fn:substring(u.fullName, 0, 1)}
                                    </div>
                                    <strong style="color: #111827;">${u.fullName}</strong>
                                </div>
                            </td>
                            <td style="font-size: 0.85rem; color: #6b7280;">${u.email}</td>
                            <td>
                                <span class="badge ${u.role eq 'ADMIN' ? 'badge-role-admin' : (u.role eq 'INSTRUCTOR' ? 'badge-role-instructor' : 'badge-role-student')}">
                                    ${u.role}
                                </span>
                            </td>
                            <td>
                                <span class="badge ${u.status eq 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">
                                    ${u.status}
                                </span>
                            </td>
                            <td style="text-align: right; white-space: nowrap;">
                                <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="toggleStatus">
                                    <input type="hidden" name="userId" value="${u.userId}">
                                    <button type="submit" class="btn-dash-outline" style="padding: 0.35rem 0.75rem; font-size: 0.75rem;" title="Toggle active/inactive status">
                                        ${u.status eq 'ACTIVE' ? 'Deactivate' : 'Activate'}
                                    </button>
                                </form>

                                <c:if test="${u.userId != sessionScope.userId}">
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');" style="display:inline;">
                                        <input type="hidden" name="action" value="deleteUser">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <button type="submit" class="btn-dash-outline" style="padding: 0.35rem 0.75rem; font-size: 0.75rem; color: #ef4444; border-color: #fecdd3;">
                                            Delete
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Right Column: Provision New User Account Card -->
    <div class="dash-panel-card" style="padding: 1.75rem;">
        <h3 class="dash-panel-title" style="margin-bottom: 0.35rem;">Provision New User</h3>
        <p style="font-size: 0.82rem; color: #6b7280; margin-bottom: 1.5rem;">Create verified instructor, administrator, or student accounts.</p>

        <form action="${pageContext.request.contextPath}/admin/users" method="post">
            <input type="hidden" name="action" value="createUser">

            <div class="form-group" style="margin-bottom: 1.15rem;">
                <label for="fullName" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                    Full Name *
                </label>
                <input type="text" id="fullName" name="fullName" class="form-control" placeholder="e.g. Prof. Arvind Sharma" required style="padding: 0.65rem 0.85rem;">
            </div>

            <div class="form-group" style="margin-bottom: 1.15rem;">
                <label for="email" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                    Institutional Email *
                </label>
                <input type="email" id="email" name="email" class="form-control" placeholder="staff@ocms.com" required style="padding: 0.65rem 0.85rem;">
            </div>

            <div class="form-group" style="margin-bottom: 1.15rem;">
                <label for="password" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                    Initial Password *
                </label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Min 6 characters" required minlength="6" style="padding: 0.65rem 0.85rem;">
            </div>

            <div class="form-group" style="margin-bottom: 1.15rem;">
                <label for="role" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                    Assigned Role *
                </label>
                <select id="role" name="role" class="form-control" required style="padding: 0.65rem 0.85rem;">
                    <option value="INSTRUCTOR">INSTRUCTOR (Faculty)</option>
                    <option value="ADMIN">ADMIN (System Administrator)</option>
                    <option value="STUDENT">STUDENT (Learner)</option>
                </select>
            </div>

            <div class="form-group" style="margin-bottom: 1.5rem;">
                <label for="phone" style="font-size: 0.85rem; font-weight: 700; color: #111827; margin-bottom: 0.35rem; display: block;">
                    Phone Contact
                </label>
                <input type="text" id="phone" name="phone" class="form-control" placeholder="+91 9876543210" style="padding: 0.65rem 0.85rem;">
            </div>

            <button type="submit" class="btn-dash-primary" style="width: 100%; justify-content: center; padding: 0.75rem;">
                Create Account &rarr;
            </button>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
