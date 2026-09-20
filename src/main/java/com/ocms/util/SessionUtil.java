package com.ocms.util;

import com.ocms.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Session Management Utility.
 * Centralizes session attribute keys and retrieval logic.
 */
public class SessionUtil {

    public static final String SESSION_USER = "loggedInUser";
    public static final String SESSION_USER_ID = "userId";
    public static final String SESSION_USER_ROLE = "userRole";
    public static final String SESSION_USER_NAME = "userName";

    private SessionUtil() {
    }

    /**
     * Associates authenticated user details with the session.
     */
    public static void setLoggedInUser(HttpSession session, User user) {
        if (session != null && user != null) {
            session.setAttribute(SESSION_USER, user);
            session.setAttribute(SESSION_USER_ID, user.getUserId());
            session.setAttribute(SESSION_USER_ROLE, user.getRole());
            session.setAttribute(SESSION_USER_NAME, user.getFullName());
        }
    }

    /**
     * Checks if the session has an authenticated user.
     */
    public static boolean isLoggedIn(HttpSession session) {
        return session != null && session.getAttribute(SESSION_USER_ID) != null;
    }

    /**
     * Retrieves the currently logged in User POJO, or null if unauthenticated.
     */
    public static User getLoggedInUser(HttpSession session) {
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute(SESSION_USER);
    }

    /**
     * Retrieves the user ID of the logged in user, or null if unauthenticated.
     */
    public static Integer getLoggedInUserId(HttpSession session) {
        if (session == null) {
            return null;
        }
        return (Integer) session.getAttribute(SESSION_USER_ID);
    }

    /**
     * Retrieves the role string (STUDENT, INSTRUCTOR, ADMIN) of the logged in user.
     */
    public static String getLoggedInUserRole(HttpSession session) {
        if (session == null) {
            return null;
        }
        return (String) session.getAttribute(SESSION_USER_ROLE);
    }

    /**
     * Terminates the user session.
     */
    public static void invalidate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
