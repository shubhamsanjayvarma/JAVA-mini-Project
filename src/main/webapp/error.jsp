<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${errorTitle != null ? errorTitle : 'System Notice'}" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div style="max-width: 540px; margin: 3rem auto; text-align: center;">
    <div class="card" style="padding: 2rem;">
        <h1 style="font-size: 3rem; color: var(--danger-color); line-height: 1; margin-bottom: 0.5rem;">
            ${errorCode != null ? errorCode : "Notice"}
        </h1>
        <h2 style="font-size: 1.35rem; color: var(--primary-color); margin-bottom: 1rem;">
            ${errorTitle != null ? errorTitle : "An error occurred"}
        </h2>
        <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">
            ${errorMessage != null ? errorMessage : "The requested resource could not be processed as expected."}
        </p>
        <div>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Return to Homepage</a>
            <c:if test="${not empty sessionScope.userId}">
                <c:choose>
                    <c:when test="${sessionScope.userRole eq 'STUDENT'}">
                        <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-secondary">Go to Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.userRole eq 'INSTRUCTOR'}">
                        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-secondary">Go to Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Go to Dashboard</a>
                    </c:when>
                </c:choose>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
