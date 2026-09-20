package com.ocms.filter;

import com.ocms.util.SessionUtil;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet Filter enforcing Role-Based Access Control (RBAC).
 * Ensures students cannot access instructor/admin endpoints, and instructors cannot access admin endpoints.
 */
@WebFilter(urlPatterns = {"/student/*", "/instructor/*", "/admin/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        String role = SessionUtil.getLoggedInUserRole(session);
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = uri.substring(contextPath.length());

        if (path.startsWith("/student/") && !"STUDENT".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(contextPath + "/error?code=403");
            return;
        }

        if (path.startsWith("/instructor/") && !"INSTRUCTOR".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(contextPath + "/error?code=403");
            return;
        }

        if (path.startsWith("/admin/") && !"ADMIN".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(contextPath + "/error?code=403");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
