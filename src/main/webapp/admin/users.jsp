<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="User Management" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>User Account Administration</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Manage platform users, roles, and status</span>
</div>

<div class="grid-2" style="grid-template-columns: 2fr 1fr; align-items: start;">
    <!-- Users Table -->
    <div class="card">
        <div class="card-header">All Registered Users (${users.size()})</div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td><strong>${u.fullName}</strong></td>
                                <td>${u.email}</td>
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
                                <td style="white-space: nowrap; display: flex; gap: 0.35rem;">
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <button type="submit" class="btn btn-sm btn-secondary" title="Toggle active/inactive status">
                                            ${u.status eq 'ACTIVE' ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>

                                    <!-- Prevent deleting the current admin -->
                                    <c:if test="${u.userId != sessionScope.userId}">
                                        <form action="${pageContext.request.contextPath}/admin/users" method="post" class="confirm-delete" style="display:inline;">
                                            <input type="hidden" name="action" value="deleteUser">
                                            <input type="hidden" name="userId" value="${u.userId}">
                                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Create Faculty / Admin Form -->
    <div class="card">
        <div class="card-header">Create Faculty / Admin Account</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/users" method="post">
                <input type="hidden" name="action" value="createUser">

                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" placeholder="e.g. Prof. Arvind Gupta" required>
                </div>

                <div class="form-group">
                    <label for="email">Institutional Email *</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="staff@ocms.com" required>
                </div>

                <div class="form-group">
                    <label for="password">Initial Password *</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Min 6 characters" required minlength="6">
                </div>

                <div class="form-group">
                    <label for="role">Assigned Role *</label>
                    <select id="role" name="role" class="form-control" required>
                        <option value="INSTRUCTOR">INSTRUCTOR (Faculty)</option>
                        <option value="ADMIN">ADMIN (System Administrator)</option>
                        <option value="STUDENT">STUDENT (Learner)</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Contact</label>
                    <input type="text" id="phone" name="phone" class="form-control" placeholder="+91 9876543210">
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%;">Create Account</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
