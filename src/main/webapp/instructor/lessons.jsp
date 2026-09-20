<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Lessons - ${module.title}" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <div>
        <h2>Module Lessons: ${module.title}</h2>
        <span style="font-size: 0.85rem; color: var(--text-muted);">Course: ${course.title}</span>
    </div>
    <a href="${pageContext.request.contextPath}/instructor/modules?courseId=${course.courseId}" class="btn btn-secondary btn-sm">&larr; Back to Modules</a>
</div>

<div class="card" style="margin-bottom: 2rem;">
    <div class="card-header">Add New Lesson to Module</div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/instructor/lessons" method="post">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="moduleId" value="${module.moduleId}">
            <input type="hidden" name="courseId" value="${course.courseId}">

            <div class="form-row">
                <div class="form-group" style="flex: 3;">
                    <label for="title">Lesson Title *</label>
                    <input type="text" id="title" name="title" class="form-control" placeholder="e.g. Understanding Polymorphism" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label for="durationMinutes">Duration (Mins) *</label>
                    <input type="number" id="durationMinutes" name="durationMinutes" class="form-control" value="20" min="5" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label for="orderIndex">Order *</label>
                    <input type="number" id="orderIndex" name="orderIndex" class="form-control" value="1" min="1" required>
                </div>
            </div>

            <div class="form-group">
                <label for="content">Lesson Learning Content / Lecture Notes *</label>
                <textarea id="content" name="content" class="form-control" style="min-height: 140px;" 
                          placeholder="Enter complete educational content, code samples, or theory explanations..." required></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Publish Lesson to Module</button>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
