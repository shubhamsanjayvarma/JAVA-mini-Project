<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Online Course Management System"} | Elearn OCMS</title>
    <!-- Google Fonts: Plus Jakarta Sans & Caveat -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&family=Caveat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=4">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css?v=4">
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
                        <svg viewBox="0 0 48 48" fill="none" class="brand-cap-svg" style="width:28px; height:28px;">
                            <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                            <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                            <path d="M42 19V34C42 35.1 41.1 36 40 36C38.9 36 38 35.1 38 34V19" stroke="#E64A19" stroke-width="2" stroke-linecap="round"/>
                            <circle cx="39" cy="35" r="2.5" fill="#E64A19"/>
                        </svg>
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
        <!-- Public Top Navigation Header (Elearn Exact Brand Header) -->
        <header class="public-top-header">
            <div class="public-header-container">
                <a href="${pageContext.request.contextPath}/" class="portal-brand" title="Elearn">
                    <div class="brand-cap-icon">
                        <svg viewBox="0 0 48 48" width="42" height="42" fill="none" xmlns="http://www.w3.org/2000/svg" class="cap-svg">
                            <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                            <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                            <path d="M42 19V34C42 35.1 41.1 36 40 36C38.9 36 38 35.1 38 34V19" stroke="#E64A19" stroke-width="2.5" stroke-linecap="round"/>
                            <circle cx="39" cy="35" r="2.5" fill="#E64A19"/>
                        </svg>
                    </div>
                    <div class="brand-text-block">
                        <span class="brand-title">Elearn</span>
                        <span class="brand-subtitle">Online Course Management System</span>
                    </div>
                </a>
                <jsp:include page="/WEB-INF/includes/nav-public.jsp" />
            </div>
        </header>
        <main class="public-main-wrapper ${isHomePage ? 'public-main-home' : ''}">
    </c:otherwise>
</c:choose>
