<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${course != null ? 'Edit Course' : 'Create Course'}" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>${course != null ? 'Edit Course Details' : 'Create New Course Offering'}</h2>
    <a href="${pageContext.request.contextPath}/instructor/courses" class="btn btn-secondary btn-sm">&larr; Back to Courses</a>
</div>

<div style="max-width: 720px; margin: 0 auto;">
    <div class="card">
        <div class="card-header">${course != null ? 'Update Existing Course' : 'New Course Specification'}</div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/instructor/course-form" method="post">
                <c:if test="${course != null}">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                </c:if>

                <div class="form-group">
                    <label for="title">Course Title *</label>
                    <input type="text" id="title" name="title" class="form-control" 
                           value="${course != null ? course.title : ''}" placeholder="e.g. Advanced Java Programming" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="category">Subject Discipline / Category *</label>
                        <select id="category" name="category" class="form-control" required>
                            <option value="Computer Science" ${course != null && course.category eq 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                            <option value="Database Systems" ${course != null && course.category eq 'Database Systems' ? 'selected' : ''}>Database Systems</option>
                            <option value="Algorithms" ${course != null && course.category eq 'Algorithms' ? 'selected' : ''}>Algorithms</option>
                            <option value="Web Development" ${course != null && course.category eq 'Web Development' ? 'selected' : ''}>Web Development</option>
                            <option value="General" ${course != null && course.category eq 'General' ? 'selected' : ''}>General</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="durationHours">Estimated Duration (Hours) *</label>
                        <input type="number" id="durationHours" name="durationHours" class="form-control" 
                               value="${course != null ? course.durationHours : 30}" min="1" required>
                    </div>

                    <div class="form-group">
                        <label for="status">Publication Status *</label>
                        <select id="status" name="status" class="form-control" required>
                            <option value="PUBLISHED" ${course != null && course.status eq 'PUBLISHED' ? 'selected' : ''}>PUBLISHED</option>
                            <option value="DRAFT" ${course != null && course.status eq 'DRAFT' ? 'selected' : ''}>DRAFT</option>
                            <option value="ARCHIVED" ${course != null && course.status eq 'ARCHIVED' ? 'selected' : ''}>ARCHIVED</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Course Syllabus Overview & Objectives *</label>
                    <textarea id="description" name="description" class="form-control" style="min-height: 120px;" 
                              placeholder="Describe learning outcomes, target audience, and subject scope..." required>${course != null ? course.description : ''}</textarea>
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 0.75rem; margin-top: 1rem;">
                    <a href="${pageContext.request.contextPath}/instructor/courses" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        ${course != null ? 'Save Course Changes' : 'Publish Course'}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
