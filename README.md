# Online Course Management System (OCMS)

> **Academic Mini Project Submission**  
> **Institute**: Thakur Shyamnarayan Engineering College (TSEC)  
> **Program**: B.Tech in Computer Science and Engineering (Artificial Intelligence & Machine Learning)  
> **Semester**: Third Semester (Sem III)  
> **Course**: Full Stack Java Programming (FSJP)  
> **Course Code**: 2113611  
> **Academic Year**: 2026-2027  
> **Project Allocation**: Sr. No. 29  
> **Assigned Roll Number Range**: 108–111  
> **Candidate Roll Number**: 108  

---

## 1. Mandatory Technology Allocation

In strict compliance with the college syllabus and technology allocation requirements, this enterprise-grade academic mini-project is built **purely** using core Java enterprise specifications without third-party frameworks:

- **Language / Platform**: Java (JDK 17 / 27)
- **View Layer**: Jakarta Server Pages (JSP 3.1) & JSTL 3.0 Core Tags
- **Controller Layer**: Jakarta Servlet API 6.0 (`HttpServlet`, `Filter`)
- **Data Access Layer**: Raw JDBC with `PreparedStatement`, `DataSource`/`DriverManager`, and manual transaction boundaries (`setAutoCommit(false)`, `commit()`, `rollback()`)
- **Database Engine**: MySQL Server 8.4 Community Edition
- **Application Server**: Apache Tomcat 10.1
- **Build System**: Apache Maven 3.9+
- **Styling & Interactivity**: Pure Semantic HTML5, Vanilla CSS3 (Custom Design System), and Vanilla JavaScript (No React, Angular, Vue, Bootstrap, or Tailwind)

---

## 2. Project Presentation & Directory Structure

```text
online-course-management/
│
├── pom.xml
├── README.md
├── .gitignore
├── database/
│   ├── schema.sql
│   └── seed.sql
│
└── src/
    └── main/
        ├── java/
        │   └── com.ocms/
        │       ├── controller/
        │       │   ├── LoginServlet.java
        │       │   ├── LogoutServlet.java
        │       │   ├── RegisterServlet.java
        │       │   ├── CourseListServlet.java
        │       │   ├── CourseDetailsServlet.java
        │       │   ├── ErrorServlet.java
        │       │   ├── student/
        │       │   │   ├── StudentDashboardServlet.java
        │       │   │   ├── StudentCoursesServlet.java
        │       │   │   ├── StudentCourseViewServlet.java
        │       │   │   ├── EnrollmentServlet.java
        │       │   │   ├── StudentAssessmentServlet.java
        │       │   │   ├── StudentResultsServlet.java
        │       │   │   └── StudentProfileServlet.java
        │       │   ├── instructor/
        │       │   │   ├── InstructorDashboardServlet.java
        │       │   │   ├── InstructorCoursesServlet.java
        │       │   │   ├── InstructorCourseFormServlet.java
        │       │   │   ├── InstructorModuleServlet.java
        │       │   │   ├── InstructorLessonServlet.java
        │       │   │   ├── InstructorAssessmentServlet.java
        │       │   │   └── InstructorStudentsServlet.java
        │       │   └── admin/
        │       │       ├── AdminDashboardServlet.java
        │       │       ├── AdminUsersServlet.java
        │       │       ├── AdminCoursesServlet.java
        │       │       └── AdminEnrollmentsServlet.java
        │       │
        │       ├── dao/
        │       │   ├── UserDAO.java
        │       │   ├── CourseDAO.java
        │       │   ├── ModuleDAO.java
        │       │   ├── LessonDAO.java
        │       │   ├── EnrollmentDAO.java
        │       │   ├── AssessmentDAO.java
        │       │   ├── QuestionDAO.java
        │       │   └── AttemptDAO.java
        │       │
        │       ├── filter/
        │       │   ├── AuthenticationFilter.java
        │       │   └── AuthorizationFilter.java
        │       │
        │       ├── model/
        │       │   ├── User.java
        │       │   ├── Course.java
        │       │   ├── Module.java
        │       │   ├── Lesson.java
        │       │   ├── Enrollment.java
        │       │   ├── Assessment.java
        │       │   ├── Question.java
        │       │   ├── Option.java
        │       │   ├── Attempt.java
        │       │   └── AttemptAnswer.java
        │       │
        │       ├── service/
        │       │   ├── UserService.java
        │       │   ├── CourseService.java
        │       │   ├── EnrollmentService.java
        │       │   ├── AssessmentService.java
        │       │   └── DashboardService.java
        │       │
        │       └── util/
        │           ├── DBConnection.java
        │           ├── PasswordUtil.java
        │           └── SessionUtil.java
        │
        ├── resources/
        │   ├── db.properties
        │   └── db.properties.example
        │
        └── webapp/
            ├── css/
            │   ├── style.css
            │   └── dashboard.css
            ├── js/
            │   └── app.js
            ├── images/
            ├── WEB-INF/
            │   ├── web.xml
            │   └── includes/
            │       ├── header.jsp
            │       ├── footer.jsp
            │       ├── nav-public.jsp
            │       ├── nav-student.jsp
            │       ├── nav-instructor.jsp
            │       └── nav-admin.jsp
            │
            ├── index.jsp
            ├── login.jsp
            ├── register.jsp
            ├── courses.jsp
            ├── course-details.jsp
            ├── dashboard.jsp
            ├── error.jsp
            │
            ├── student/
            │   ├── dashboard.jsp
            │   ├── my-courses.jsp
            │   ├── course.jsp
            │   ├── assessment.jsp
            │   ├── results.jsp
            │   └── profile.jsp
            │
            ├── instructor/
            │   ├── dashboard.jsp
            │   ├── courses.jsp
            │   ├── course-form.jsp
            │   ├── modules.jsp
            │   ├── lessons.jsp
            │   ├── assessments.jsp
            │   └── students.jsp
            │
            └── admin/
                ├── dashboard.jsp
                ├── users.jsp
                ├── courses.jsp
                └── enrollments.jsp
```

---

## 3. Key Architectural Features

1. **Strict Model-View-Controller (MVC)**:
   - **Model**: Plain Old Java Objects (`User`, `Course`, `Module`, `Lesson`, `Assessment`, etc.) encapsulating domain data.
   - **View**: Clean JSPs using JSTL `<c:forEach>`, `<c:choose>`, `<c:if>`, `<c:out>`. Zero scriptlet (`<% ... %>`) spaghetti.
   - **Controller**: Dedicated `HttpServlet` classes routing requests, validating forms, orchestrating services, and forwarding to JSP views (`request.getRequestDispatcher(...).forward(request, response)`).
2. **Robust Security & Session Management**:
   - **AuthenticationFilter**: Intercepts `/student/*`, `/instructor/*`, and `/admin/*` URI prefixes to prevent unauthorized URL tampering.
   - **AuthorizationFilter**: Enforces Role-Based Access Control (RBAC), verifying that students cannot access instructor or admin areas.
   - **Cryptographic Password Hashing**: Utilizes industry-standard `PBKDF2WithHmacSHA256` with randomly generated salt (16 bytes) and 65,536 iterations. Passwords are never stored in plaintext.
3. **Database Integrity & ACID Transactions**:
   - Course enrollment, progress calculation, and assessment submission are wrapped inside explicit JDBC database transactions (`conn.setAutoCommit(false)`).
   - SQL Injection protection via 100% parameterized `PreparedStatement`.
   - Guaranteed resource closure via Java `try-with-resources` statements.
4. **Live Progress Tracking & Automated Grading**:
   - Dynamically tracks lesson completion in the database (`lesson_progress`).
   - Automatically recomputes the exact completion percentage (`completed_lessons / total_lessons * 100`).
   - Dynamically evaluates assessment submissions question-by-question, checks correctness, tallies scores, updates enrollment pass/fail status, and persists individual attempt records.

---

## 4. Viva Voce Accounts & Credentials

The database comes pre-seeded with dedicated demo accounts across all three roles for evaluation and presentation:

| Role | Name | Email | Password | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **Admin** | System Administrator | `admin@ocms.com` | `Admin@123` | System oversight, user activation, course approvals, enrollment auditing |
| **Instructor** | Prof. Rajesh Sharma | `prof.sharma@ocms.com` | `Instructor@123` | Course creation, curriculum authoring, quiz formulation, grading oversight |
| **Instructor** | Prof. Neha Patel | `prof.patel@ocms.com` | `Instructor@123` | Additional instructor profile managing Database Systems curriculum |
| **Student** | Rahul Kumar | `rahul.kumar@ocms.com` | `Student@123` | Active enrolled student with lessons marked complete & quizzes taken |
| **Student** | Priya Singh | `priya.singh@ocms.com` | `Student@123` | Student enrolled in Full Stack Java Programming (FSJP 2113611) |
| **Student** | Amit Verma | `amit.verma@ocms.com` | `Student@123` | Fresh student profile available for enrollment testing |

---

## 5. Setup & Execution Instructions

### Prerequisites
- JDK 17 or higher
- Apache Maven 3.8+
- MySQL Server 8.0+
- Apache Tomcat 10.1+

### Step 1: Database Setup
1. Log into your MySQL instance:
   ```bash
   mysql -u root -p
   ```
2. Execute the database schema and seed scripts:
   ```sql
   source database/schema.sql;
   source database/seed.sql;
   ```
3. Update connection parameters in `src/main/resources/db.properties` if your MySQL port or root password differs:
   ```properties
   db.url=jdbc:mysql://localhost:3306/ocms_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
   db.username=root
   db.password=root1234
   ```

### Step 2: Build with Maven
In the project root directory, run:
```bash
mvn clean package
```
This produces `target/ocms.war`.

### Step 3: Deploy to Apache Tomcat
1. Copy `target/ocms.war` to your Tomcat `webapps/` directory:
   ```bash
   cp target/ocms.war $CATALINA_HOME/webapps/
   ```
2. Start Tomcat:
   - On Windows: `%CATALINA_HOME%\bin\catalina.bat run`
   - On Linux/macOS: `$CATALINA_HOME/bin/catalina.sh run`
3. Access the application in your browser at:
   ```text
   http://localhost:8080/ocms/
   ```

---

## 6. Viva Voce Technical Defense Q&A

### Q1: Why use Servlet filters instead of checking user sessions inside every individual JSP or Servlet?
**Answer**: Servlet filters provide a centralized, declarative mechanism (Chain of Responsibility pattern) to intercept incoming requests before they hit any servlet or JSP. Checking sessions in every servlet or JSP leads to code duplication, human error, and security loopholes. By using `AuthenticationFilter` and `AuthorizationFilter` mapped to URL patterns (`/student/*`, `/instructor/*`, `/admin/*`), access control is universally and reliably enforced at a single gateway.

### Q2: What is the difference between `Statement` and `PreparedStatement` in JDBC?
**Answer**:
1. **Performance**: `PreparedStatement` is pre-compiled by the database engine once, and can be executed multiple times with different parameters with high efficiency.
2. **Security**: `PreparedStatement` automatically treats parameters as literals rather than executable SQL, completely eliminating the risk of SQL Injection attacks. All queries in this project strictly use `PreparedStatement`.

### Q3: Why is PBKDF2 preferred over plain SHA-256 or MD5 for password storage?
**Answer**: MD5 and plain SHA-256 are fast hash functions vulnerable to brute-force and dictionary attacks using Rainbow Tables. PBKDF2 (Password-Based Key Derivation Function 2) incorporates a cryptographically secure random salt (preventing rainbow table attacks) and executes tens of thousands of HMAC iterations (65,536 iterations in this project), which drastically slows down offline brute-force attempts.

### Q4: How is ACID compliance maintained during course enrollment and quiz submissions?
**Answer**: In `EnrollmentDAO` and `AttemptDAO`, auto-commit mode is disabled via `connection.setAutoCommit(false)`. Multiple related operations (e.g., verifying prerequisites, inserting the attempt record, inserting each individual question answer, and recalculating the total score/percentage) execute within a single transactional unit. If any operation fails, `connection.rollback()` is invoked to prevent orphan or inconsistent records; otherwise, `connection.commit()` commits the entire operation atomically.
