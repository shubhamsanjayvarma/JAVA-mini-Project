-- ====================================================================
-- Online Course Management System (OCMS)
-- Seed Data: Demo Accounts, Courses, Modules, Lessons, Assessments
-- Academic Year: 2026-2027 | Sr. No. 29 | Roll No: 108-111
-- ====================================================================

USE ocms_db;

-- Clear any existing records in reverse dependency order
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE attempt_answers;
TRUNCATE TABLE attempts;
TRUNCATE TABLE options;
TRUNCATE TABLE questions;
TRUNCATE TABLE assessments;
TRUNCATE TABLE lesson_progress;
TRUNCATE TABLE enrollments;
TRUNCATE TABLE lessons;
TRUNCATE TABLE modules;
TRUNCATE TABLE courses;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------------------
-- 1. USERS
-- Passwords hashed via PBKDF2WithHmacSHA256:
-- Admin:      Admin@123      -> d4f3aa305b677b173d017b7fa9d9854e:c0698f8990d73b8292fce64899b4640bf68967fdedbe0f7af77188b5e7ea3c15
-- Instructor: Instructor@123 -> dfe2fed7594cf1f7af017fbb0b3629ed:a7713e35c81ce786eccb9a2a6720fbc609ef208c3ec8d0a2f177cbc845d1ad3c
-- Student:    Student@123    -> 5a61566ec34ab10ee7f03ab9bce1e405:844c77443f7076af7ebb8db498bbb0a7dbe24892d1189b5f8febb5f14a57e156
-- --------------------------------------------------------------------
INSERT INTO users (user_id, full_name, email, password_hash, role, status, phone, bio) VALUES
(1, 'System Administrator', 'admin@ocms.com', 'd4f3aa305b677b173d017b7fa9d9854e:c0698f8990d73b8292fce64899b4640bf68967fdedbe0f7af77188b5e7ea3c15', 'ADMIN', 'ACTIVE', '+91 9820011223', 'Head Administrator, Academic Affairs.'),
(2, 'Prof. Ramesh Sharma', 'prof.sharma@ocms.com', 'dfe2fed7594cf1f7af017fbb0b3629ed:a7713e35c81ce786eccb9a2a6720fbc609ef208c3ec8d0a2f177cbc845d1ad3c', 'INSTRUCTOR', 'ACTIVE', '+91 9819922334', 'Assistant Professor, Department of Computer Engineering.'),
(3, 'Prof. Neha Patel', 'prof.patel@ocms.com', 'dfe2fed7594cf1f7af017fbb0b3629ed:a7713e35c81ce786eccb9a2a6720fbc609ef208c3ec8d0a2f177cbc845d1ad3c', 'INSTRUCTOR', 'ACTIVE', '+91 9819933445', 'Associate Professor, Department of Information Technology.'),
(4, 'Rahul Kumar', 'rahul.kumar@ocms.com', '5a61566ec34ab10ee7f03ab9bce1e405:844c77443f7076af7ebb8db498bbb0a7dbe24892d1189b5f8febb5f14a57e156', 'STUDENT', 'ACTIVE', '+91 9702244556', 'B.Tech CSE (AIML), Semester 3, Roll No: 108.'),
(5, 'Priya Singh', 'priya.singh@ocms.com', '5a61566ec34ab10ee7f03ab9bce1e405:844c77443f7076af7ebb8db498bbb0a7dbe24892d1189b5f8febb5f14a57e156', 'STUDENT', 'ACTIVE', '+91 9702255667', 'B.Tech CSE (AIML), Semester 3, Roll No: 109.'),
(6, 'Amit Verma', 'amit.verma@ocms.com', '5a61566ec34ab10ee7f03ab9bce1e405:844c77443f7076af7ebb8db498bbb0a7dbe24892d1189b5f8febb5f14a57e156', 'STUDENT', 'ACTIVE', '+91 9702266778', 'B.Tech CSE (AIML), Semester 3, Roll No: 110.');

-- --------------------------------------------------------------------
-- 2. COURSES
-- --------------------------------------------------------------------
INSERT INTO courses (course_id, instructor_id, title, description, category, duration_hours, status) VALUES
(1, 2, 'Full Stack Java Programming (Course 2113611)', 'Comprehensive coverage of server-side Java web architecture including Java Servlets, JSP lifecycle, MVC design pattern, JDBC persistence, and session security.', 'Computer Science', 45, 'PUBLISHED'),
(2, 2, 'Relational Database Management with MySQL', 'Fundamentals of relational data modeling, normalization (1NF-BCNF), ACID properties, indexed queries, transactions, and JDBC integration.', 'Database Systems', 30, 'PUBLISHED'),
(3, 3, 'Data Structures & Algorithms in Java', 'Core algorithmic techniques: linear data structures, binary search trees, hashing, graph traversals, and asymptotic complexity analysis.', 'Algorithms', 40, 'PUBLISHED'),
(4, 3, 'Web Technologies & Frontend Essentials', 'Foundational web development covering semantic HTML5 markup, responsive CSS layout techniques, and DOM interaction.', 'Web Development', 25, 'PUBLISHED');

-- --------------------------------------------------------------------
-- 3. MODULES
-- --------------------------------------------------------------------
INSERT INTO modules (module_id, course_id, title, description, order_index) VALUES
(1, 1, 'Module 1: Java Servlet Architecture', 'Understanding HTTP lifecycle, HttpServletRequest, HttpServletResponse, ServletConfig, and ServletContext.', 1),
(2, 1, 'Module 2: JavaServer Pages (JSP)', 'JSP translation phase, directive elements, expression language (EL), action tags, and JSTL standard library.', 2),
(3, 1, 'Module 3: Database Persistence with JDBC', 'JDBC drivers, Connection management, PreparedStatement, ResultSet processing, and transaction rollback.', 3),
(4, 2, 'Module 1: Relational Schema Design', 'Entity relationship diagrams, primary and foreign key constraints, and normalization principles.', 1),
(5, 2, 'Module 2: SQL DDL, DML and Transactions', 'Data definition, parameterized queries, aggregate functions, and commit/rollback operations.', 2),
(6, 3, 'Module 1: Arrays and Linked Lists', 'Contiguous vs linked node memory representations, pointer manipulation, and traversal mechanics.', 1),
(7, 3, 'Module 2: Stacks, Queues and Recursion', 'LIFO/FIFO data structures, call stack mechanics, and divide-and-conquer recurrences.', 2);

-- --------------------------------------------------------------------
-- 4. LESSONS
-- --------------------------------------------------------------------
INSERT INTO lessons (lesson_id, module_id, title, content, duration_minutes, order_index) VALUES
(1, 1, 'Introduction to Java Servlets & Lifecycle', 'A Servlet is a Java class that extends the capabilities of servers that host applications accessed via a request-response programming model. The Servlet lifecycle consists of three primary phases: init() for initialization, service() for processing incoming requests via doGet/doPost, and destroy() for garbage collection and resource deallocation.', 25, 1),
(2, 1, 'Request Processing & HTTP Sessions', 'The HttpServletRequest interface encapsulates HTTP headers, query parameters, and form payload. Sessions are managed through HttpSession using server-side session tracking with JSESSIONID cookies. Session invalidation on logout prevents session hijacking.', 30, 2),
(3, 1, 'Servlet Filters & Interceptors', 'Servlet Filters provide a powerful mechanism to intercept requests and responses prior to reaching target controllers. They are ideal for cross-cutting concerns such as authentication verification, role authorization, and character encoding.', 20, 3),
(4, 2, 'JSP Architecture & Translation Phase', 'When a JSP page is first requested, the servlet container translates the JSP file into a Java source file (.java), compiles it into bytecode (.class), and executes it as a standard Java Servlet. Scriptlets should be avoided in favor of EL and JSTL.', 25, 1),
(5, 2, 'JSP Standard Tag Library (JSTL) & EL', 'JSTL simplifies presentation logic with standard tags such as c:if, c:forEach, c:choose, and c:out. Expression Language (EL) syntax (${user.fullName}) cleanly accesses JavaBeans without requiring scriptlet syntax.', 30, 2),
(6, 3, 'JDBC Architecture & PreparedStatement', 'Java Database Connectivity (JDBC) defines an API for database-independent connectivity. PreparedStatement pre-compiles SQL statements, improving execution speed and offering complete protection against SQL injection attacks by strictly separating SQL syntax from parameter values.', 35, 1),
(7, 3, 'JDBC Transactions & Connection Utilities', 'By default, JDBC operates in auto-commit mode. By setting connection.setAutoCommit(false), multiple related DML statements can be batched together. If any operation fails, connection.rollback() preserves data integrity.', 30, 2),
(8, 4, 'Relational Modeling & Keys', 'Relational theory organizes data into tables (relations) comprising rows (tuples) and columns (attributes). Candidate keys uniquely identify records, with one designated as Primary Key. Foreign keys enforce referential integrity.', 25, 1),
(9, 4, 'Normalization (1NF to BCNF)', 'Normalization minimizes redundancy and eliminates insertion, update, and deletion anomalies. 1NF enforces atomic values. 2NF removes partial functional dependencies. 3NF removes transitive functional dependencies.', 35, 2),
(10, 5, 'ACID Properties and Isolation Levels', 'Transactions must satisfy Atomicity (all-or-nothing), Consistency (state transitions satisfy constraints), Isolation (concurrency control), and Durability (committed changes persist).', 30, 1),
(11, 6, 'Singly vs Doubly Linked Lists', 'Linked lists allocate nodes dynamically with explicit pointer references. Inserting at the head operates in O(1) time complexity compared to O(n) element shifting in fixed-size arrays.', 30, 1),
(12, 7, 'Stack Implementation & Applications', 'Stacks enforce Last-In First-Out (LIFO) discipline using push, pop, and peek operations. Common applications include balanced parenthesis parsing, postfix expression evaluation, and function call execution frames.', 30, 1);

-- --------------------------------------------------------------------
-- 5. ENROLLMENTS
-- --------------------------------------------------------------------
INSERT INTO enrollments (enrollment_id, user_id, course_id, enrolled_at, status) VALUES
(1, 4, 1, '2026-08-01 10:00:00', 'ACTIVE'),
(2, 4, 2, '2026-08-05 14:30:00', 'ACTIVE'),
(3, 5, 1, '2026-08-02 11:15:00', 'ACTIVE'),
(4, 5, 3, '2026-08-10 09:00:00', 'ACTIVE'),
(5, 6, 1, '2026-08-03 16:45:00', 'ACTIVE');

-- --------------------------------------------------------------------
-- 6. LESSON PROGRESS (Rahul Kumar has completed 4 of 7 lessons in Course 1 = 57%)
-- --------------------------------------------------------------------
INSERT INTO lesson_progress (enrollment_id, lesson_id, completed_at) VALUES
(1, 1, '2026-08-02 11:00:00'),
(1, 2, '2026-08-03 15:30:00'),
(1, 3, '2026-08-04 17:00:00'),
(1, 4, '2026-08-05 12:00:00'),
(2, 8, '2026-08-06 18:00:00'),
(3, 1, '2026-08-03 10:00:00'),
(3, 2, '2026-08-04 14:00:00');

-- --------------------------------------------------------------------
-- 7. ASSESSMENTS
-- --------------------------------------------------------------------
INSERT INTO assessments (assessment_id, course_id, title, description, passing_score, total_marks, duration_minutes) VALUES
(1, 1, 'FSJP Mid-Term Assessment: Servlets & JSP', 'Evaluates core conceptual understanding of Java Servlet lifecycles, session tracking, filters, and JDBC PreparedStatement.', 60, 100, 30),
(2, 2, 'RDBMS Fundamentals Assessment', 'Tests understanding of relational keys, normalization forms, transactions, and SQL query constraints.', 50, 100, 25);

-- --------------------------------------------------------------------
-- 8. QUESTIONS & OPTIONS FOR ASSESSMENT 1
-- --------------------------------------------------------------------
INSERT INTO questions (question_id, assessment_id, question_text, marks, order_index) VALUES
(1, 1, 'Which method in the HttpServlet lifecycle is executed only once when the servlet is first instantiated?', 20, 1),
(2, 1, 'Why is PreparedStatement preferred over Statement in JDBC applications?', 20, 2),
(3, 1, 'What is the primary role of a Servlet Filter in Java web applications?', 20, 3),
(4, 1, 'Which scope in JSP has the longest lifespan across multiple browser sessions?', 20, 4),
(5, 1, 'How can you prevent duplicate course enrollments at the database level?', 20, 5);

INSERT INTO options (option_id, question_id, option_text, is_correct, order_index) VALUES
(1, 1, 'service()', FALSE, 1),
(2, 1, 'init()', TRUE, 2),
(3, 1, 'doGet()', FALSE, 3),
(4, 1, 'destroy()', FALSE, 4),

(5, 2, 'It allows dynamic concatenation of user input strings directly into SQL syntax.', FALSE, 1),
(6, 2, 'It pre-compiles the query and binds parameters safely, preventing SQL injection.', TRUE, 2),
(7, 2, 'It automatically commits all transactions without requiring explicit rollback handlers.', FALSE, 3),
(8, 2, 'It eliminates the need to install a relational database driver.', FALSE, 4),

(9, 3, 'To render HTML layouts directly to the browser window.', FALSE, 1),
(10, 3, 'To intercept incoming requests and outgoing responses for authentication and authorization.', TRUE, 2),
(11, 3, 'To replace the MySQL database connection pool.', FALSE, 3),
(12, 3, 'To compile JSP files into Java bytecode.', FALSE, 4),

(13, 4, 'pageContext scope', FALSE, 1),
(14, 4, 'request scope', FALSE, 2),
(15, 4, 'session scope', FALSE, 3),
(16, 4, 'application (ServletContext) scope', TRUE, 4),

(17, 5, 'By writing client-side JavaScript alerts on the submit button.', FALSE, 1),
(18, 5, 'By declaring a UNIQUE composite constraint on (user_id, course_id).', TRUE, 2),
(19, 5, 'By dropping the enrollments table on every new student registration.', FALSE, 3),
(20, 5, 'By disabling primary keys in the database schema.', FALSE, 4);

-- --------------------------------------------------------------------
-- 9. SAMPLE ATTEMPTS & RESULTS (Rahul Kumar completed Assessment 1 with 80%)
-- --------------------------------------------------------------------
INSERT INTO attempts (attempt_id, assessment_id, user_id, enrollment_id, score, total_score, percentage, passed, attempted_at) VALUES
(1, 1, 4, 1, 80, 100, 80.00, TRUE, '2026-08-06 16:30:00');

INSERT INTO attempt_answers (answer_id, attempt_id, question_id, selected_option_id, is_correct) VALUES
(1, 1, 1, 2, TRUE),
(2, 1, 2, 6, TRUE),
(3, 1, 3, 10, TRUE),
(4, 1, 4, 15, FALSE),  -- Rahul selected session scope instead of application
(5, 1, 5, 18, TRUE);
