<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${course != null ? 'Edit Course' : 'Create Course'}" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<!-- Screen 12: Breadcrumb & Title Bar -->
<div class="dash-header-row" style="margin-bottom: 1.5rem;">
    <div>
        <div class="topbar-breadcrumb" style="margin-bottom: 0.35rem;">
            <a href="${pageContext.request.contextPath}/instructor/dashboard">&larr; Back to Dashboard</a> &nbsp;&gt;&nbsp; 
            <a href="${pageContext.request.contextPath}/instructor/courses">Courses</a> &nbsp;&gt;&nbsp; 
            <span style="color: #FF6500; font-weight: 700;">${course != null ? 'Edit Course' : 'Create Course'}</span>
        </div>
        <h1 class="dash-greeting-title">${course != null ? 'Edit Course Details' : 'Create New Course Offering'}</h1>
        <p class="dash-greeting-subtitle">Define course metadata, target category, duration, and learning objectives.</p>
    </div>
    <a href="${pageContext.request.contextPath}/instructor/courses" class="btn-dash-outline">
        Cancel & Return
    </a>
</div>

<!-- Screen 12: 4-Step Authoring Wizard Header -->
<div class="dash-panel-card" style="padding: 1.15rem 1.5rem; margin-bottom: 1.75rem; background: #ffffff;">
    <div style="display: flex; align-items: center; justify-content: space-between; position: relative;">
        <!-- Step 1: Active -->
        <div style="display: flex; align-items: center; gap: 0.65rem; z-index: 2;">
            <div style="width: 32px; height: 32px; border-radius: 50%; background: #FF6500; color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.9rem;">
                1
            </div>
            <div style="display: flex; flex-direction: column;">
                <span style="font-size: 0.88rem; font-weight: 800; color: #111827;">Basic Info</span>
                <span style="font-size: 0.72rem; color: #FF6500; font-weight: 600;">In Progress</span>
            </div>
        </div>

        <div style="flex: 1; height: 2px; background: #e5e7eb; margin: 0 1rem;"></div>

        <!-- Step 2 -->
        <div style="display: flex; align-items: center; gap: 0.65rem; z-index: 2; opacity: 0.6;">
            <div style="width: 32px; height: 32px; border-radius: 50%; background: #f3f4f6; color: #6b7280; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">
                2
            </div>
            <div style="display: flex; flex-direction: column;">
                <span style="font-size: 0.88rem; font-weight: 700; color: #4b5563;">Media & Assets</span>
                <span style="font-size: 0.72rem; color: #9ca3af;">Next</span>
            </div>
        </div>

        <div style="flex: 1; height: 2px; background: #e5e7eb; margin: 0 1rem;"></div>

        <!-- Step 3 -->
        <div style="display: flex; align-items: center; gap: 0.65rem; z-index: 2; opacity: 0.6;">
            <div style="width: 32px; height: 32px; border-radius: 50%; background: #f3f4f6; color: #6b7280; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">
                3
            </div>
            <div style="display: flex; flex-direction: column;">
                <span style="font-size: 0.88rem; font-weight: 700; color: #4b5563;">Curriculum</span>
                <span style="font-size: 0.72rem; color: #9ca3af;">Upcoming</span>
            </div>
        </div>

        <div style="flex: 1; height: 2px; background: #e5e7eb; margin: 0 1rem;"></div>

        <!-- Step 4 -->
        <div style="display: flex; align-items: center; gap: 0.65rem; z-index: 2; opacity: 0.6;">
            <div style="width: 32px; height: 32px; border-radius: 50%; background: #f3f4f6; color: #6b7280; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">
                4
            </div>
            <div style="display: flex; flex-direction: column;">
                <span style="font-size: 0.88rem; font-weight: 700; color: #4b5563;">Publish</span>
                <span style="font-size: 0.72rem; color: #9ca3af;">Final</span>
            </div>
        </div>
    </div>
</div>

<!-- Screen 12: Main Form Card -->
<div style="max-width: 860px; margin: 0 auto;">
    <div class="dash-panel-card" style="padding: 2.25rem;">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/instructor/course-form" method="post">
            <c:if test="${course != null}">
                <input type="hidden" name="courseId" value="${course.courseId}">
            </c:if>

            <div class="form-group" style="margin-bottom: 1.5rem;">
                <label for="title" style="font-weight: 800; font-size: 0.92rem; color: #111827; margin-bottom: 0.5rem; display: block;">
                    Course Title *
                </label>
                <input type="text" id="title" name="title" class="form-control" style="font-size: 1rem; padding: 0.75rem 1rem;"
                       value="${course != null ? course.title : ''}" placeholder="e.g. Advanced Java & Enterprise Architectures" required>
            </div>

            <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.25rem; margin-bottom: 1.5rem;">
                <div class="form-group">
                    <label for="category" style="font-weight: 800; font-size: 0.88rem; color: #111827; margin-bottom: 0.45rem; display: block;">
                        Subject Discipline *
                    </label>
                    <select id="category" name="category" class="form-control" style="padding: 0.7rem;" required>
                        <option value="Computer Science" ${course != null && course.category eq 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                        <option value="Database Systems" ${course != null && course.category eq 'Database Systems' ? 'selected' : ''}>Database Systems</option>
                        <option value="Algorithms" ${course != null && course.category eq 'Algorithms' ? 'selected' : ''}>Algorithms & DSA</option>
                        <option value="Web Development" ${course != null && course.category eq 'Web Development' ? 'selected' : ''}>Web Development</option>
                        <option value="General" ${course != null && course.category eq 'General' ? 'selected' : ''}>General Engineering</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="durationHours" style="font-weight: 800; font-size: 0.88rem; color: #111827; margin-bottom: 0.45rem; display: block;">
                        Duration (Hours) *
                    </label>
                    <input type="number" id="durationHours" name="durationHours" class="form-control" style="padding: 0.7rem;"
                           value="${course != null ? course.durationHours : 30}" min="1" required>
                </div>

                <div class="form-group">
                    <label for="status" style="font-weight: 800; font-size: 0.88rem; color: #111827; margin-bottom: 0.45rem; display: block;">
                        Publication Status *
                    </label>
                    <select id="status" name="status" class="form-control" style="padding: 0.7rem;" required>
                        <option value="PUBLISHED" ${course != null && course.status eq 'PUBLISHED' ? 'selected' : ''}>PUBLISHED</option>
                        <option value="DRAFT" ${course != null && course.status eq 'DRAFT' ? 'selected' : ''}>DRAFT</option>
                        <option value="ARCHIVED" ${course != null && course.status eq 'ARCHIVED' ? 'selected' : ''}>ARCHIVED</option>
                    </select>
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 2rem;">
                <label for="description" style="font-weight: 800; font-size: 0.88rem; color: #111827; margin-bottom: 0.45rem; display: block;">
                    Course Description & Learning Outcomes *
                </label>
                <textarea id="description" name="description" class="form-control" style="min-height: 140px; padding: 0.85rem; line-height: 1.6;" 
                          placeholder="Describe the syllabus, modules covered, hands-on lab prerequisites, and expected learning outcomes..." required>${course != null ? course.description : ''}</textarea>
            </div>

            <div style="display: flex; justify-content: flex-end; gap: 1rem; padding-top: 1.5rem; border-top: 1px solid #f3f4f6;">
                <a href="${pageContext.request.contextPath}/instructor/courses" class="btn-dash-outline">
                    Cancel
                </a>
                <button type="submit" class="btn-dash-primary" style="padding: 0.75rem 2rem; font-size: 1rem;">
                    ${course != null ? 'Update Course & Save' : 'Publish Course &rarr;'}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
