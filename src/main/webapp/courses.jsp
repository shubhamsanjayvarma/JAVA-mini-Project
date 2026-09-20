<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Course Catalog" />
<jsp:include page="/WEB-INF/includes/header.jsp" />

<div class="page-title-bar">
    <h2>Academic Course Catalog</h2>
    <span style="font-size: 0.9rem; color: var(--text-muted);">Browse accredited course offerings</span>
</div>

<!-- Search & Filtering Form (Standard HTML Form + Servlet + JDBC) -->
<div class="card" style="margin-bottom: 1.5rem;">
    <div class="card-body" style="padding: 1rem 1.25rem;">
        <form action="${pageContext.request.contextPath}/courses" method="get" class="form-row" style="align-items: flex-end;">
            <div class="form-group" style="flex: 2; margin-bottom: 0;">
                <label for="q">Search Keyword</label>
                <input type="text" id="q" name="q" class="form-control" 
                       value="${searchQuery != null ? searchQuery : ''}" placeholder="e.g. Java, MySQL, Servlets...">
            </div>
            <div class="form-group" style="flex: 1; margin-bottom: 0;">
                <label for="category">Subject Category</label>
                <select id="category" name="category" class="form-control">
                    <option value="ALL">All Disciplines</option>
                    <option value="Computer Science" ${selectedCategory eq 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                    <option value="Database Systems" ${selectedCategory eq 'Database Systems' ? 'selected' : ''}>Database Systems</option>
                    <option value="Algorithms" ${selectedCategory eq 'Algorithms' ? 'selected' : ''}>Algorithms</option>
                    <option value="Web Development" ${selectedCategory eq 'Web Development' ? 'selected' : ''}>Web Development</option>
                </select>
            </div>
            <div style="display: flex; gap: 0.5rem;">
                <button type="submit" class="btn btn-primary">Filter Courses</button>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">Reset</a>
            </div>
        </form>
    </div>
</div>

<!-- Course Cards Grid -->
<c:choose>
    <c:when test="${not empty courses}">
        <div class="grid-2">
            <c:forEach var="course" items="${courses}">
                <div class="card" style="display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                            <span class="badge" style="background:#e0f2fe; color:#0369a1;">${course.category}</span>
                            <span style="font-size: 0.8rem; color: var(--text-muted);">${course.durationHours} Hours Duration</span>
                        </div>
                        <div class="card-body">
                            <h3 style="font-size: 1.15rem; color: var(--primary-color); margin-bottom: 0.5rem;">
                                ${course.title}
                            </h3>
                            <p style="font-size: 0.875rem; color: var(--text-secondary); margin-bottom: 1rem;">
                                ${course.description}
                            </p>
                            <div style="font-size: 0.8rem; color: var(--text-muted);">
                                <p><strong>Instructor:</strong> ${course.instructorName}</p>
                                <p><strong>Curriculum:</strong> ${course.moduleCount} Modules &bull; ${course.enrolledStudentCount} Enrolled Students</p>
                            </div>
                        </div>
                    </div>
                    <div style="padding: 0.75rem 1.25rem; background: #f8fafc; border-top: 1px solid var(--border-color); display: flex; justify-content: flex-end;">
                        <a href="${pageContext.request.contextPath}/course-details?id=${course.courseId}" class="btn btn-sm btn-primary">
                            View Curriculum & Enroll &rarr;
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card">
            <div class="card-body" style="text-align: center; padding: 3rem;">
                <p style="color: var(--text-muted); font-size: 1.05rem;">No courses found matching your filter criteria.</p>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary" style="margin-top: 1rem;">View All Courses</a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
