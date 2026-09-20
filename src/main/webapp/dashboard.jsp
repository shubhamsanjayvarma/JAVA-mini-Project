<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Role Dispatcher: Route user to their role-specific dashboard --%>
<c:choose>
    <c:when test="${empty sessionScope.loggedInUser}">
        <c:redirect url="/login" />
    </c:when>
    <c:when test="${sessionScope.userRole == 'STUDENT'}">
        <c:redirect url="/student/dashboard" />
    </c:when>
    <c:when test="${sessionScope.userRole == 'INSTRUCTOR'}">
        <c:redirect url="/instructor/dashboard" />
    </c:when>
    <c:when test="${sessionScope.userRole == 'ADMIN'}">
        <c:redirect url="/admin/dashboard" />
    </c:when>
    <c:otherwise>
        <c:redirect url="/login" />
    </c:otherwise>
</c:choose>
