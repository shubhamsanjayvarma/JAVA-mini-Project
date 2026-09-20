<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:choose>
    <c:when test="${not empty sessionScope.userId}">
                    </main><!-- /.dashboard-main-body -->
                </div><!-- /.app-content-wrapper -->
            </div><!-- /.app-frame -->
        </div><!-- /.app-viewport -->
    </c:when>
    <c:otherwise>
        </main>
        <footer class="public-footer">
            <p><strong>Online Course Management System (OCMS) &bull; Elearn Portal</strong></p>
            <p>Full Stack Java Programming (Course 2113611) &bull; Academic Year 2026-2027</p>
            <p>Thakur Shyamnarayan Engineering College &bull; Department of Computer Engineering</p>
            <p style="font-size: 0.75rem; color: var(--text-light); margin-top: 0.5rem;">
                Sr. No. 29 &bull; Roll Number Range: 108-111 &bull; Technology: JSP + Servlet + JDBC + MySQL
            </p>
        </footer>
    </c:otherwise>
</c:choose>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
