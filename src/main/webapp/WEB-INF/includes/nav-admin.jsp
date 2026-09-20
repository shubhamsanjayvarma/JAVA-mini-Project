<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="sidebar-nav">
    <a href="${pageContext.request.contextPath}/admin/dashboard" 
       class="sidebar-icon-link ${pageTitle eq 'Admin Dashboard' ? 'active' : ''}" 
       title="Admin Dashboard">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="3" width="18" height="18" rx="5"></rect>
            <path d="M7 13l3-3 4 4 3-3"></path>
        </svg>
    </a>
    <a href="${pageContext.request.contextPath}/admin/users" 
       class="sidebar-icon-link ${pageTitle eq 'User Management' ? 'active' : ''}" 
       title="User Management">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
            <circle cx="9" cy="7" r="4"></circle>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
        </svg>
    </a>
    <a href="${pageContext.request.contextPath}/admin/courses" 
       class="sidebar-icon-link ${pageTitle eq 'Course Administration' ? 'active' : ''}" 
       title="Course Administration">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
            <line x1="8" y1="6" x2="16" y2="6"></line>
            <line x1="8" y1="10" x2="16" y2="10"></line>
        </svg>
    </a>
    <a href="${pageContext.request.contextPath}/admin/enrollments" 
       class="sidebar-icon-link ${pageTitle eq 'Enrollment Oversight' ? 'active' : ''}" 
       title="Enrollment Oversight">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
            <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
            <line x1="9" y1="11" x2="15" y2="11"></line>
        </svg>
    </a>
</nav>
