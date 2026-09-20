<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Curriculum - ${course.title}" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <div>
        <h2>Curriculum Structure: ${course.title}</h2>
        <span style="font-size: 0.85rem; color: var(--text-muted);">Manage modules and sequential lesson units</span>
    </div>
    <a href="${pageContext.request.contextPath}/instructor/courses" class="btn btn-secondary btn-sm">&larr; Back to Courses</a>
</div>

<div class="grid-2">
    <!-- Existing Modules List -->
    <div class="card">
        <div class="card-header">Course Modules & Lessons</div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty modules}">
                    <c:forEach var="moduleItem" items="${modules}" varStatus="mStatus">
                        <div style="margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 1px solid var(--border-color);">
                            <div style="display: flex; justify-content: space-between; align-items: baseline;">
                                <h4 style="color: var(--primary-color);">Module ${mStatus.count}: ${moduleItem.title}</h4>
                                <div style="display: flex; gap: 0.5rem;">
                                    <a href="${pageContext.request.contextPath}/instructor/lessons?moduleId=${moduleItem.moduleId}" class="btn btn-sm btn-primary">
                                        Manage Lessons (${moduleItem.lessons.size()})
                                    </a>
                                    <form action="${pageContext.request.contextPath}/instructor/modules" method="post" class="confirm-delete" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="courseId" value="${course.courseId}">
                                        <input type="hidden" name="moduleId" value="${moduleItem.moduleId}">
                                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                    </form>
                                </div>
                            </div>
                            <c:if test="${not empty moduleItem.description}">
                                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 0.35rem 0;">${moduleItem.description}</p>
                            </c:if>

                            <c:if test="${not empty moduleItem.lessons}">
                                <ul style="list-style: none; margin-top: 0.5rem; padding-left: 1rem;">
                                    <c:forEach var="les" items="${moduleItem.lessons}" varStatus="lStatus">
                                        <li style="font-size: 0.85rem; padding: 0.25rem 0; color: var(--text-secondary);">
                                            &bull; ${les.title} <span style="color: var(--text-muted);">(${les.durationMinutes} mins)</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-muted);">No modules added to this course yet. Use the form on the right to add the first module.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Add Module Form -->
    <div class="card">
        <div class="card-header">Add New Module</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/instructor/modules" method="post">
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="courseId" value="${course.courseId}">

                <div class="form-group">
                    <label for="title">Module Title *</label>
                    <input type="text" id="title" name="title" class="form-control" placeholder="e.g. Module 1: Introduction to OOP" required>
                </div>

                <div class="form-group">
                    <label for="orderIndex">Sequence Order Index</label>
                    <input type="number" id="orderIndex" name="orderIndex" class="form-control" value="${modules.size() + 1}" min="1" required>
                </div>

                <div class="form-group">
                    <label for="description">Module Description / Learning Goals</label>
                    <textarea id="description" name="description" class="form-control" placeholder="Brief outline of concepts covered in this module..."></textarea>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%;">Add Module to Curriculum</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
