const fs = require('fs');
const path = require('path');

const webappDir = path.join(__dirname, 'src', 'main', 'webapp');
const outDir = path.join(__dirname, 'public');

console.log('[Build] Generating Vercel static deployment bundle in public/...');

// 1. Recursive copy helper
function copyDirSync(src, dest) {
    if (!fs.existsSync(src)) return;
    if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });

    const entries = fs.readdirSync(src, { withFileTypes: true });
    for (const entry of entries) {
        const srcPath = path.join(src, entry.name);
        const destPath = path.join(dest, entry.name);

        if (entry.isDirectory()) {
            copyDirSync(srcPath, destPath);
        } else {
            fs.copyFileSync(srcPath, destPath);
        }
    }
}

// 2. Copy static assets
copyDirSync(path.join(webappDir, 'css'), path.join(outDir, 'css'));
copyDirSync(path.join(webappDir, 'images'), path.join(outDir, 'images'));
copyDirSync(path.join(webappDir, 'js'), path.join(outDir, 'js'));

// 3. Helper to write both <name>.html and <name>/index.html for clean URLs
function writeRoute(routePath, htmlContent) {
    // Write <routePath>.html
    const directFile = path.join(outDir, `${routePath}.html`);
    fs.mkdirSync(path.dirname(directFile), { recursive: true });
    fs.writeFileSync(directFile, htmlContent, 'utf8');

    // Also write <routePath>/index.html
    const dirFile = path.join(outDir, routePath, 'index.html');
    fs.mkdirSync(path.dirname(dirFile), { recursive: true });
    fs.writeFileSync(dirFile, htmlContent, 'utf8');
}

// 4. Shared HTML Blocks
const commonHead = `
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&family=Caveat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css?v=5">
    <link rel="stylesheet" href="/css/dashboard.css?v=5">
`;

function getPublicHeader(activeTab = 'home') {
    return `
    <header class="public-top-header">
        <div class="public-header-container">
            <a href="/" class="portal-brand" title="Elearn">
                <div class="brand-cap-icon">
                    <svg viewBox="0 0 48 48" width="42" height="42" fill="none" class="cap-svg">
                        <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                        <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                        <path d="M42 19V34C42 35.1 41.1 36 40 36C38.9 36 38 35.1 38 34V19" stroke="#E64A19" stroke-width="2.5" stroke-linecap="round"/>
                        <circle cx="39" cy="35" r="2.5" fill="#E64A19"/>
                    </svg>
                </div>
                <div class="brand-text-block">
                    <span class="brand-title">Elearn</span>
                    <span class="brand-subtitle">Online Course Management System</span>
                </div>
            </a>
            
            <div class="nav-and-actions-wrapper">
                <nav class="center-nav-links">
                    <a href="/" class="nav-item ${activeTab === 'home' ? 'active' : ''}">
                        Home
                        ${activeTab === 'home' ? '<span class="nav-active-pill"></span>' : ''}
                    </a>
                    <a href="/courses" class="nav-item ${activeTab === 'courses' ? 'active' : ''}">
                        Courses
                        ${activeTab === 'courses' ? '<span class="nav-active-pill"></span>' : ''}
                    </a>
                    <a href="/#categories" class="nav-item">About</a>
                    <a href="/#about" class="nav-item">Contact</a>
                </nav>

                <form action="/courses" method="get" class="nav-search-form">
                    <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="11" cy="11" r="8"></circle>
                        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                    </svg>
                    <input type="text" name="q" class="nav-search-input" placeholder="Search courses, instructors...">
                </form>

                <div class="nav-auth-buttons">
                    <a href="/login" class="btn-nav-login">Login</a>
                    <a href="/register" class="btn-nav-register">Register</a>
                </div>
            </div>
        </div>
    </header>
    `;
}

const publicFooter = `
    <!-- CTA BANNER -->
    <section class="footer-cta-section">
        <div class="footer-cta-container">
            <div class="footer-cta-card">
                <div class="footer-cta-dots">
                    <svg width="68" height="48" viewBox="0 0 68 48" fill="none">
                        <g fill="#FDBA74" opacity="0.85">
                            <circle cx="6" cy="6" r="2.2" /><circle cx="22" cy="6" r="2.2" /><circle cx="38" cy="6" r="2.2" /><circle cx="54" cy="6" r="2.2" />
                            <circle cx="6" cy="18" r="2.2" /><circle cx="22" cy="18" r="2.2" /><circle cx="38" cy="18" r="2.2" /><circle cx="54" cy="18" r="2.2" />
                            <circle cx="6" cy="30" r="2.2" /><circle cx="22" cy="30" r="2.2" /><circle cx="38" cy="30" r="2.2" /><circle cx="54" cy="30" r="2.2" />
                            <circle cx="6" cy="42" r="2.2" /><circle cx="22" cy="42" r="2.2" /><circle cx="38" cy="42" r="2.2" /><circle cx="54" cy="42" r="2.2" />
                        </g>
                    </svg>
                </div>
                <div class="footer-cta-icon-group">
                    <div class="footer-cta-cap-badge">
                        <svg viewBox="0 0 64 64" width="52" height="52" fill="none">
                            <path d="M32 12 L6 26 L32 40 L58 26 Z" fill="#FF6500" />
                            <path d="M14 30.5 V42 C14 42 21 50 32 50 C43 50 50 42 50 42 V30.5 L32 41.5 Z" fill="#101828" />
                            <path d="M51 28 V44 C51 46 49 48 47 48" stroke="#FF6500" stroke-width="2.5" stroke-linecap="round" />
                            <circle cx="47" cy="48" r="3" fill="#FF6500" />
                        </svg>
                    </div>
                </div>
                <div class="footer-cta-content">
                    <h2 class="footer-cta-title">Start Learning Today With Free Courses</h2>
                    <p class="footer-cta-subtitle">Join thousands of students and instructors advancing their knowledge on Elearn.</p>
                </div>
                <div class="footer-cta-action">
                    <a href="/register" class="btn-footer-cta-white">
                        Get Started Free
                        <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                            <polyline points="12 5 19 12 12 19"></polyline>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- 5-COLUMN FOOTER -->
    <footer class="elearn-footer">
        <div class="footer-main-container">
            <div class="footer-5col-grid">
                <div class="footer-col footer-col-brand">
                    <div class="footer-brand-header">
                        <svg viewBox="0 0 48 48" width="36" height="36" fill="none">
                            <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF6500"/>
                            <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                            <path d="M42 19V34C42 35.1 41.1 36 40 36C38.9 36 38 35.1 38 34V19" stroke="#E64A19" stroke-width="2.5" stroke-linecap="round"/>
                            <circle cx="39" cy="35" r="2.5" fill="#E64A19"/>
                        </svg>
                        <span class="footer-brand-title">Elearn</span>
                    </div>
                    <p class="footer-brand-desc">Online Course Management System built with enterprise-grade standards for modern higher education.</p>
                </div>
                <div class="footer-col">
                    <h4 class="footer-col-heading">Quick Links</h4>
                    <ul class="footer-nav-list">
                        <li><a href="/">Home</a></li>
                        <li><a href="/courses">All Courses</a></li>
                        <li><a href="/login">Login</a></li>
                        <li><a href="/register">Register</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4 class="footer-col-heading">Top Categories</h4>
                    <ul class="footer-nav-list">
                        <li><a href="/courses?cat=Web">Web Development</a></li>
                        <li><a href="/courses?cat=Data">Data Science</a></li>
                        <li><a href="/courses?cat=Java">Java Programming</a></li>
                        <li><a href="/courses?cat=AI">Artificial Intelligence</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4 class="footer-col-heading">Portal Access</h4>
                    <ul class="footer-nav-list">
                        <li><a href="/student/dashboard">Student Dashboard</a></li>
                        <li><a href="/instructor/dashboard">Instructor Dashboard</a></li>
                        <li><a href="/admin/dashboard">Admin Dashboard</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4 class="footer-col-heading">Academic Project</h4>
                    <p style="color:#94a3b8; font-size:0.85rem; line-height:1.5;">TSEC FSJP Mini Project<br>Roll No Range: 108–111<br>Core Stack: JSP + Servlet + JDBC + MySQL</p>
                </div>
            </div>
            <div class="footer-bottom-bar">
                <p>&copy; 2026 Elearn Online Course Management System. All rights reserved.</p>
                <p style="font-size:0.75rem; color:#64748b;">Sr. No. 29 &bull; Roll Number Range: 108–111 &bull; Full Stack Java Programming</p>
            </div>
        </div>
    </footer>
    <script src="/js/app.js"></script>
    <script src="/js/demo.js"></script>
`;

// Helper script for interactive demo on Vercel
const demoJsContent = `
// Interactive demo logic for Vercel deployment
document.addEventListener('DOMContentLoaded', function() {
    // Auth redirect handler for static preview
    const loginForm = document.querySelector('.auth-form-body');
    if (loginForm && window.location.pathname.includes('/login')) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = (document.getElementById('email')?.value || '').toLowerCase();
            if (email.includes('admin')) {
                window.location.href = '/admin/dashboard';
            } else if (email.includes('instructor') || email.includes('sharma') || email.includes('patel')) {
                window.location.href = '/instructor/dashboard';
            } else {
                window.location.href = '/student/dashboard';
            }
        });
    }

    const regForm = document.querySelector('.reg-form-body');
    if (regForm && window.location.pathname.includes('/register')) {
        regForm.addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Registration Successful! Redirecting to login...');
            window.location.href = '/login';
        });
    }
});
`;
fs.writeFileSync(path.join(outDir, 'js', 'demo.js'), demoJsContent, 'utf8');

// 5. Generate Home Page (index.html)
let indexJsp = fs.readFileSync(path.join(webappDir, 'index.jsp'), 'utf8');
// Clean JSP tags
indexJsp = indexJsp
    .replace(/<%@.*?%>/g, '')
    .replace(/<c:set.*?\/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/header.jsp" \/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/footer.jsp" \/>/g, '')
    .replace(/\${pageContext\.request\.contextPath}/g, '');

const homeHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home | Elearn OCMS</title>
    ${commonHead}
</head>
<body>
    ${getPublicHeader('home')}
    <main class="public-main-wrapper public-main-home">
        ${indexJsp}
    ${publicFooter}
</body>
</html>`;
fs.writeFileSync(path.join(outDir, 'index.html'), homeHtml, 'utf8');

// 6. Generate Login Page
let loginJsp = fs.readFileSync(path.join(webappDir, 'login.jsp'), 'utf8');
loginJsp = loginJsp
    .replace(/<%@.*?%>/g, '')
    .replace(/<c:set.*?\/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/header.jsp" \/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/footer.jsp" \/>/g, '')
    .replace(/<c:if test="\${not empty errorMessage}">[\s\S]*?<\/c:if>/g, '')
    .replace(/<c:if test="\${not empty successMessage}">[\s\S]*?<\/c:if>/g, '')
    .replace(/\${email != null \? email : ''}/g, 'rahul.kumar@ocms.com')
    .replace(/\${pageContext\.request\.contextPath}/g, '');

// Add quick credentials bar for reviewers
const credentialsBar = `
    <div style="background:#eff6ff; border:1px solid #bfdbfe; border-radius:8px; padding:0.75rem 1rem; margin-bottom:1.25rem; font-size:0.85rem; color:#1e40af;">
        <strong>Demo Accounts (Click to Fill):</strong>
        <div style="display:flex; gap:0.5rem; margin-top:0.4rem; flex-wrap:wrap;">
            <button type="button" onclick="document.getElementById('email').value='admin@ocms.com';document.getElementById('password').value='Admin@123'" style="padding:3px 8px; border-radius:4px; border:1px solid #93c5fd; background:#fff; cursor:pointer;">Admin</button>
            <button type="button" onclick="document.getElementById('email').value='prof.sharma@ocms.com';document.getElementById('password').value='Instructor@123'" style="padding:3px 8px; border-radius:4px; border:1px solid #93c5fd; background:#fff; cursor:pointer;">Instructor</button>
            <button type="button" onclick="document.getElementById('email').value='rahul.kumar@ocms.com';document.getElementById('password').value='Student@123'" style="padding:3px 8px; border-radius:4px; border:1px solid #93c5fd; background:#fff; cursor:pointer;">Student</button>
        </div>
    </div>
`;
loginJsp = loginJsp.replace('<form action="/login"', `${credentialsBar}<form action="/login"`);

const loginHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login | Elearn OCMS</title>
    ${commonHead}
</head>
<body class="auth-body">
    ${loginJsp}
    <script src="/js/app.js"></script>
    <script src="/js/demo.js"></script>
</body>
</html>`;
writeRoute('login', loginHtml);

// 7. Generate Register Page
let registerJsp = fs.readFileSync(path.join(webappDir, 'register.jsp'), 'utf8');
registerJsp = registerJsp
    .replace(/<%@.*?%>/g, '')
    .replace(/<c:set.*?\/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/header.jsp" \/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/footer.jsp" \/>/g, '')
    .replace(/<c:if test="\${not empty errorMessage}">[\s\S]*?<\/c:if>/g, '')
    .replace(/\${fullName != null \? fullName : ''}/g, '')
    .replace(/\${email != null \? email : ''}/g, '')
    .replace(/\${pageContext\.request\.contextPath}/g, '');

const registerHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register | Elearn OCMS</title>
    ${commonHead}
</head>
<body class="auth-body">
    ${registerJsp}
    <script src="/js/app.js"></script>
    <script src="/js/demo.js"></script>
</body>
</html>`;
writeRoute('register', registerHtml);

// 8. Generate Courses Page
let coursesJsp = fs.readFileSync(path.join(webappDir, 'courses.jsp'), 'utf8');
coursesJsp = coursesJsp
    .replace(/<%@.*?%>/g, '')
    .replace(/<c:set.*?\/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/header.jsp" \/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/footer.jsp" \/>/g, '')
    .replace(/\${pageContext\.request\.contextPath}/g, '')
    .replace(/\${not empty courses \? fn:length\(courses\) : 0}/g, '6')
    .replace(/<c:choose>[\s\S]*?<c:when test="\${not empty courses}">[\s\S]*?<div class="courses-cards-grid-3">[\s\S]*?<\/div>[\s\S]*?<\/c:when>[\s\S]*?<\/c:choose>/g, `
        <div class="courses-cards-grid-3">
            <div class="course-catalog-card">
                <div class="card-thumb-wrap">
                    <img src="/images/thumb-java.jpg" alt="Full Stack Java Programming" class="card-thumb-img">
                    <div class="card-duration-badge">40 Hours</div>
                </div>
                <div class="card-content-body">
                    <div>
                        <span class="card-badge-cat">Computer Engineering</span>
                        <h2 class="card-course-title">Full Stack Java Programming (FSJP)</h2>
                        <p class="card-instructor-text">Instructor: <strong>Prof. Rajesh Sharma</strong></p>
                    </div>
                    <div>
                        <div class="card-rating-enrolled-row">
                            <span style="display:inline-flex; align-items:center; gap:0.3rem;"><span style="color:#FF5722;">★</span> <strong>4.9</strong> (1.4k)</span>
                            <span style="color:#6b7280; font-size:0.75rem;">128 enrolled</span>
                        </div>
                        <div class="card-button-row">
                            <a href="/login" class="btn-card-enroll">Enroll Now</a>
                            <a href="/login" class="btn-card-details">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="course-catalog-card">
                <div class="card-thumb-wrap">
                    <img src="/images/thumb-webdev.jpg" alt="Modern Web Development" class="card-thumb-img">
                    <div class="card-duration-badge">32 Hours</div>
                </div>
                <div class="card-content-body">
                    <div>
                        <span class="card-badge-cat">Web Development</span>
                        <h2 class="card-course-title">Modern Web Development with CSS3 & JS</h2>
                        <p class="card-instructor-text">Instructor: <strong>Prof. Neha Patel</strong></p>
                    </div>
                    <div>
                        <div class="card-rating-enrolled-row">
                            <span style="display:inline-flex; align-items:center; gap:0.3rem;"><span style="color:#FF5722;">★</span> <strong>4.8</strong> (980)</span>
                            <span style="color:#6b7280; font-size:0.75rem;">95 enrolled</span>
                        </div>
                        <div class="card-button-row">
                            <a href="/login" class="btn-card-enroll">Enroll Now</a>
                            <a href="/login" class="btn-card-details">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="course-catalog-card">
                <div class="card-thumb-wrap">
                    <img src="/images/thumb-datascience.jpg" alt="Database Systems" class="card-thumb-img">
                    <div class="card-duration-badge">36 Hours</div>
                </div>
                <div class="card-content-body">
                    <div>
                        <span class="card-badge-cat">Database Systems</span>
                        <h2 class="card-course-title">Relational Database Systems & MySQL 8.x</h2>
                        <p class="card-instructor-text">Instructor: <strong>Prof. Rajesh Sharma</strong></p>
                    </div>
                    <div>
                        <div class="card-rating-enrolled-row">
                            <span style="display:inline-flex; align-items:center; gap:0.3rem;"><span style="color:#FF5722;">★</span> <strong>4.7</strong> (820)</span>
                            <span style="color:#6b7280; font-size:0.75rem;">84 enrolled</span>
                        </div>
                        <div class="card-button-row">
                            <a href="/login" class="btn-card-enroll">Enroll Now</a>
                            <a href="/login" class="btn-card-details">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `);

const coursesHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Courses Catalog | Elearn OCMS</title>
    ${commonHead}
</head>
<body>
    ${getPublicHeader('courses')}
    <main class="public-main-wrapper">
        ${coursesJsp}
    ${publicFooter}
</body>
</html>`;
writeRoute('courses', coursesHtml);

// 9. Generate Student Dashboard
let studentDash = fs.readFileSync(path.join(webappDir, 'student', 'dashboard.jsp'), 'utf8');
studentDash = studentDash
    .replace(/<%@.*?%>/g, '')
    .replace(/<c:set.*?\/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/header.jsp" \/>/g, '')
    .replace(/<jsp:include page="\/WEB-INF\/includes\/footer.jsp" \/>/g, '')
    .replace(/\${pageContext\.request\.contextPath}/g, '')
    .replace(/\${sessionScope\.userName != null \? sessionScope\.userName : 'Student'}/g, 'Rahul Kumar')
    .replace(/<c:choose>[\s\S]*?<c:when test="\${empty enrollments}">[\s\S]*?<\/c:choose>/g, `
        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:12px; padding:1.5rem; margin-top:1rem;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1rem;">
                <div>
                    <h3 style="font-size:1.1rem; font-weight:700; color:#1e293b;">Full Stack Java Programming (FSJP 2113611)</h3>
                    <p style="font-size:0.85rem; color:#64748b; margin-top:2px;">Instructor: Prof. Rajesh Sharma</p>
                </div>
                <span style="background:#dcfce7; color:#15803d; font-weight:700; font-size:0.8rem; padding:4px 10px; border-radius:20px;">Active</span>
            </div>
            <div style="margin-bottom:0.75rem;">
                <div style="display:flex; justify-content:space-between; font-size:0.85rem; font-weight:600; margin-bottom:4px;">
                    <span>Course Progress</span>
                    <span style="color:#FF5722;">75% Completed</span>
                </div>
                <div style="background:#f1f5f9; height:8px; border-radius:4px; overflow:hidden;">
                    <div style="background:#FF5722; width:75%; height:100%;"></div>
                </div>
            </div>
            <div style="display:flex; gap:0.75rem; margin-top:1rem;">
                <a href="/courses" class="btn-card-enroll" style="padding:6px 14px; font-size:0.85rem;">Continue Lessons</a>
                <a href="/courses" class="btn-card-details" style="padding:6px 14px; font-size:0.85rem;">Take Assessment</a>
            </div>
        </div>
    `);

const studentDashHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Student Dashboard | Elearn OCMS</title>
    ${commonHead}
</head>
<body>
    <div class="app-viewport">
        <div class="app-frame">
            <aside class="app-sidebar">
                <div class="sidebar-brand-wrapper">
                    <a href="/" class="sidebar-brand-link" title="Elearn OCMS">
                        <svg viewBox="0 0 48 48" fill="none" style="width:28px; height:28px;">
                            <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                            <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                        </svg>
                        <span class="sidebar-brand-text">Elearn</span>
                    </a>
                </div>
                <nav class="sidebar-nav-menu">
                    <a href="/student/dashboard" class="sidebar-nav-item active"><span class="nav-text">Dashboard</span></a>
                    <a href="/courses" class="sidebar-nav-item"><span class="nav-text">Browse Courses</span></a>
                    <a href="/login" class="sidebar-nav-item" style="margin-top:auto; color:#ef4444;"><span class="nav-text">Logout</span></a>
                </nav>
            </aside>
            <div class="app-content-wrapper">
                <header class="dashboard-topbar">
                    <div class="topbar-left">
                        <div class="topbar-breadcrumb">Student Portal &nbsp;&gt;&nbsp; <strong>Dashboard</strong></div>
                    </div>
                    <div class="topbar-right">
                        <div class="topbar-user-meta">
                            <span class="topbar-user-name">Rahul Kumar</span>
                            <span class="topbar-user-role">STUDENT</span>
                        </div>
                    </div>
                </header>
                <main class="dashboard-main-body">
                    ${studentDash}
                </main>
            </div>
        </div>
    </div>
    <script src="/js/app.js"></script>
    <script src="/js/demo.js"></script>
</body>
</html>`;
writeRoute('student/dashboard', studentDashHtml);
writeRoute('dashboard', studentDashHtml);

// 10. Generate Admin Dashboard
const adminDashHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard | Elearn OCMS</title>
    ${commonHead}
</head>
<body>
    <div class="app-viewport">
        <div class="app-frame">
            <aside class="app-sidebar">
                <div class="sidebar-brand-wrapper">
                    <a href="/" class="sidebar-brand-link">
                        <svg viewBox="0 0 48 48" fill="none" style="width:28px; height:28px;">
                            <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                            <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                        </svg>
                        <span class="sidebar-brand-text">Elearn</span>
                    </a>
                </div>
                <nav class="sidebar-nav-menu">
                    <a href="/admin/dashboard" class="sidebar-nav-item active"><span class="nav-text">Dashboard</span></a>
                    <a href="/courses" class="sidebar-nav-item"><span class="nav-text">Courses</span></a>
                    <a href="/login" class="sidebar-nav-item" style="color:#ef4444;"><span class="nav-text">Logout</span></a>
                </nav>
            </aside>
            <div class="app-content-wrapper">
                <header class="dashboard-topbar">
                    <div class="topbar-left">
                        <div class="topbar-breadcrumb">Admin Portal &nbsp;&gt;&nbsp; <strong>Dashboard</strong></div>
                    </div>
                    <div class="topbar-right">
                        <div class="topbar-user-meta">
                            <span class="topbar-user-name">System Administrator</span>
                            <span class="topbar-user-role">ADMIN</span>
                        </div>
                    </div>
                </header>
                <main class="dashboard-main-body" style="padding:2rem;">
                    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(220px, 1fr)); gap:1.5rem; margin-bottom:2rem;">
                        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:12px; padding:1.5rem; box-shadow:0 1px 3px rgba(0,0,0,0.05);">
                            <div style="font-size:0.85rem; color:#64748b; font-weight:600;">Total Active Users</div>
                            <div style="font-size:2rem; font-weight:800; color:#1e293b; margin-top:0.5rem;">428</div>
                        </div>
                        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:12px; padding:1.5rem; box-shadow:0 1px 3px rgba(0,0,0,0.05);">
                            <div style="font-size:0.85rem; color:#64748b; font-weight:600;">Total Courses</div>
                            <div style="font-size:2rem; font-weight:800; color:#FF5722; margin-top:0.5rem;">18</div>
                        </div>
                        <div style="background:#fff; border:1px solid #e2e8f0; border-radius:12px; padding:1.5rem; box-shadow:0 1px 3px rgba(0,0,0,0.05);">
                            <div style="font-size:0.85rem; color:#64748b; font-weight:600;">Total Enrollments</div>
                            <div style="font-size:2rem; font-weight:800; color:#10b981; margin-top:0.5rem;">1,280</div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </div>
    <script src="/js/app.js"></script>
    <script src="/js/demo.js"></script>
</body>
</html>`;
writeRoute('admin/dashboard', adminDashHtml);

// 11. Generate Instructor Dashboard
const instructorDashHtml = `<!DOCTYPE html>
<html lang="en">
<head>
    <title>Instructor Dashboard | Elearn OCMS</title>
    ${commonHead}
</head>
<body>
    <div class="app-viewport">
        <div class="app-frame">
            <aside class="app-sidebar">
                <div class="sidebar-brand-wrapper">
                    <a href="/" class="sidebar-brand-link">
                        <svg viewBox="0 0 48 48" fill="none" style="width:28px; height:28px;">
                            <path d="M24 6L2 17L24 28L46 17L24 6Z" fill="#FF5722"/>
                            <path d="M8 20.5V31C8 31 14 36 24 36C34 36 40 31 40 31V20.5L24 29.5L8 20.5Z" fill="#E64A19"/>
                        </svg>
                        <span class="sidebar-brand-text">Elearn</span>
                    </a>
                </div>
                <nav class="sidebar-nav-menu">
                    <a href="/instructor/dashboard" class="sidebar-nav-item active"><span class="nav-text">Dashboard</span></a>
                    <a href="/courses" class="sidebar-nav-item"><span class="nav-text">My Courses</span></a>
                    <a href="/login" class="sidebar-nav-item" style="color:#ef4444;"><span class="nav-text">Logout</span></a>
                </nav>
            </aside>
            <div class="app-content-wrapper">
                <header class="dashboard-topbar">
                    <div class="topbar-left">
                        <div class="topbar-breadcrumb">Instructor Portal &nbsp;&gt;&nbsp; <strong>Dashboard</strong></div>
                    </div>
                    <div class="topbar-right">
                        <div class="topbar-user-meta">
                            <span class="topbar-user-name">Prof. Rajesh Sharma</span>
                            <span class="topbar-user-role">INSTRUCTOR</span>
                        </div>
                    </div>
                </header>
                <main class="dashboard-main-body" style="padding:2rem;">
                    <h2 style="font-size:1.5rem; font-weight:800; color:#1e293b; margin-bottom:1rem;">Welcome, Prof. Rajesh Sharma</h2>
                    <p style="color:#64748b;">Manage course curricula, lesson modules, assessment questions, and grading.</p>
                </main>
            </div>
        </div>
    </div>
    <script src="/js/app.js"></script>
    <script src="/js/demo.js"></script>
</body>
</html>`;
writeRoute('instructor/dashboard', instructorDashHtml);

console.log('[Build] Successfully generated Vercel static bundle in public/ directory!');
