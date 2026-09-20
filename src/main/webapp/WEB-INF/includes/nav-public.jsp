<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="nav-and-actions-wrapper">
    <!-- Center Navigation Links -->
    <nav class="center-nav-links">
        <a href="${pageContext.request.contextPath}/" class="nav-item ${isHomePage ? 'active' : ''}">
            Home
            <c:if test="${isHomePage}">
                <span class="nav-active-pill"></span>
            </c:if>
        </a>
        <a href="${pageContext.request.contextPath}/courses" class="nav-item ${pageTitle eq 'Course Catalog' ? 'active' : ''}">
            Courses
            <c:if test="${pageTitle eq 'Course Catalog'}">
                <span class="nav-active-pill"></span>
            </c:if>
        </a>
        <a href="${pageContext.request.contextPath}/#categories" class="nav-item">About</a>
        <a href="${pageContext.request.contextPath}/#about" class="nav-item">Contact</a>
    </nav>

    <!-- Search Form -->
    <form action="${pageContext.request.contextPath}/courses" method="get" class="nav-search-form">
        <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        <input type="text" name="q" class="nav-search-input" placeholder="Search courses, instructors..." value="${param.q != null ? param.q : ''}">
    </form>

    <!-- Right Login & Register or Dashboard Buttons -->
    <div class="nav-auth-buttons">
        <c:choose>
            <c:when test="${not empty sessionScope.userId}">
                <c:choose>
                    <c:when test="${sessionScope.userRole eq 'STUDENT'}">
                        <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-nav-login">Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.userRole eq 'INSTRUCTOR'}">
                        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn-nav-login">Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-nav-login">Dashboard</a>
                    </c:when>
                </c:choose>
                <a href="${pageContext.request.contextPath}/logout" class="btn-nav-register" style="background:#fee2e2; color:#b91c1c; border-color:#fca5a5;">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn-nav-login">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn-nav-register">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
