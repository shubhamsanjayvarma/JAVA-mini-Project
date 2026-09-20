<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Online Course Management System"} | Elearn OCMS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<c:choose>
    <c:when test="${not empty sessionScope.userId}">
        <!-- Authenticated App Frame Shell (Elearn Theme) -->
        <div class="app-viewport">
            <div class="app-frame">
                <!-- Left Vertical Icon Sidebar -->
                <aside class="app-sidebar">
                    <a href="${pageContext.request.contextPath}/" class="sidebar-brand" title="Elearn OCMS">
                        <span>Elearn</span>
                    </a>
                    
                    <c:choose>
                        <c:when test="${sessionScope.userRole eq 'STUDENT'}">
                            <jsp:include page="/WEB-INF/includes/nav-student.jsp" />
                        </c:when>
                        <c:when test="${sessionScope.userRole eq 'INSTRUCTOR'}">
                            <jsp:include page="/WEB-INF/includes/nav-instructor.jsp" />
                        </c:when>
                        <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                            <jsp:include page="/WEB-INF/includes/nav-admin.jsp" />
                        </c:when>
                    </c:choose>

                    <div class="sidebar-footer">
                        <a href="${pageContext.request.contextPath}/logout" class="sidebar-icon-link" title="Logout (${sessionScope.userName})">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                <polyline points="16 17 21 12 16 7"></polyline>
                                <line x1="21" y1="12" x2="9" y2="12"></line>
                            </svg>
                        </a>
                        <a href="${pageContext.request.contextPath}/${sessionScope.userRole.toLowerCase()}/profile" class="user-avatar-btn" title="${sessionScope.userName} (${sessionScope.userRole})">
                            <div class="user-avatar-circle">
                                ${sessionScope.userName != null ? sessionScope.userName.substring(0, 1).toUpperCase() : 'U'}
                            </div>
                        </a>
                    </div>
                </aside>

                <!-- App Main Content Area -->
                <div class="app-content-wrapper">
    </c:when>
    <c:otherwise>
        <!-- Public Top Navigation Header -->
        <header class="public-top-header">
            <div class="public-header-container">
                <a href="${pageContext.request.contextPath}/" class="portal-brand">
                    <div class="brand-icon-logo">E</div>
                    <div>
                        <h1>Elearn <span style="display:inline; font-size: 0.85rem; color: var(--accent-orange); font-weight:700;">OCMS</span></h1>
                        <span>Thakur Shyamnarayan Engineering College</span>
                    </div>
                </a>
                <jsp:include page="/WEB-INF/includes/nav-public.jsp" />
            </div>
        </header>
        <main class="public-main-wrapper">
    </c:otherwise>
</c:choose>
