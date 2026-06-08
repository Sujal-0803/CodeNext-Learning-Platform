<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.codenext.db.DBConnection" %>

<%
    HttpSession userSession = request.getSession(false);
    if(userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) userSession.getAttribute("userName");
    int userId = (int) userSession.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeNext | Tutorials</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="tutorials.css">
</head>
<body>

    <header class="header">
        <div class="logo">CodeNext</div>
        <div class="header-right">
            <span class="welcome-text">Hey, <%= userName %>! 👋</span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </header>

    <nav class="menubar">
        <a href="index.jsp">Home</a>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="tutorials.jsp" class="active">Tutorials</a>
        <a href="quiz.jsp">Quiz</a>
        <a href="leaderboard.jsp">Leaderboard</a>
    </nav>

    <div class="dash-layout">

        <aside class="sidebar">
            <h2>Courses</h2>
            <ul>
                <li><a href="tutorial.jsp?course=java">Java Tutorial</a></li>
                <li><a href="tutorial.jsp?course=html">HTML Tutorial</a></li>
                <li><a href="tutorial.jsp?course=css">CSS Tutorial</a></li>
                <li><a href="tutorial.jsp?course=javascript">JavaScript Tutorial</a></li>
                <li><a href="tutorial.jsp?course=bootstrap">Bootstrap Tutorial</a></li>
                <li><a href="tutorial.jsp?course=python">Python Tutorial</a></li>
                <li><a href="tutorial.jsp?course=sql">SQL & MySQL</a></li>
            </ul>
        </aside>

        <main class="dash-main">

            <div class="page-header">
                <div>
                    <div class="page-title">All Tutorials 📚</div>
                    <div class="page-sub">Pick a course and start learning today!</div>
                </div>
                <div class="page-badge">7 Courses Available</div>
            </div>

            <div class="tut-grid">

                <!-- 1. JAVA -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=java'">
                    <div class="tut-card-top" style="background:rgba(239,68,68,0.08);border-color:rgba(239,68,68,0.15)">
                        <div class="tut-icon" style="color:#f97316">☕</div>
                        <span class="tut-level intermediate">Intermediate</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">Java</div>
                        <div class="tut-desc">Learn Core Java programming — OOP, collections, JDBC and more.</div>
                        <div class="tut-meta">
                            <span>📖 18 Chapters</span>
                            <span>⏱ 8 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:0%"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status notstarted">○ Not Started</span>
                            <a href="tutorial.jsp?course=java" class="tut-btn">Start →</a>
                        </div>
                    </div>
                </div>

                <!-- 2. HTML -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=html'">
                    <div class="tut-card-top" style="background:rgba(239,68,68,0.1);border-color:rgba(239,68,68,0.2)">
                        <div class="tut-icon" style="color:#ef4444">&#60;/&#62;</div>
                        <span class="tut-level beginner">Beginner</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">HTML</div>
                        <div class="tut-desc">Learn the building blocks of web pages with HTML tags and structure.</div>
                        <div class="tut-meta">
                            <span>📖 12 Chapters</span>
                            <span>⏱ 4 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:100%"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status done">✓ Completed</span>
                            <a href="tutorial.jsp?course=html" class="tut-btn">Review →</a>
                        </div>
                    </div>
                </div>

                <!-- 3. CSS -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=css'">
                    <div class="tut-card-top" style="background:rgba(59,130,246,0.1);border-color:rgba(59,130,246,0.2)">
                        <div class="tut-icon" style="color:#3b82f6">{ }</div>
                        <span class="tut-level beginner">Beginner</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">CSS</div>
                        <div class="tut-desc">Style your web pages with colors, layouts, animations and more.</div>
                        <div class="tut-meta">
                            <span>📖 10 Chapters</span>
                            <span>⏱ 3 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:75%;background:#3b82f6"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status inprogress">↗ In Progress</span>
                            <a href="tutorial.jsp?course=css" class="tut-btn">Continue →</a>
                        </div>
                    </div>
                </div>

                <!-- 4. JAVASCRIPT -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=javascript'">
                    <div class="tut-card-top" style="background:rgba(245,158,11,0.1);border-color:rgba(245,158,11,0.2)">
                        <div class="tut-icon" style="color:#f59e0b">JS</div>
                        <span class="tut-level intermediate">Intermediate</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">JavaScript</div>
                        <div class="tut-desc">Make your websites interactive with JavaScript programming.</div>
                        <div class="tut-meta">
                            <span>📖 15 Chapters</span>
                            <span>⏱ 6 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:40%;background:#f59e0b"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status inprogress">↗ In Progress</span>
                            <a href="tutorial.jsp?course=javascript" class="tut-btn">Continue →</a>
                        </div>
                    </div>
                </div>

                <!-- 5. BOOTSTRAP -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=bootstrap'">
                    <div class="tut-card-top" style="background:rgba(139,92,246,0.1);border-color:rgba(139,92,246,0.2)">
                        <div class="tut-icon" style="color:#8b5cf6">BS</div>
                        <span class="tut-level intermediate">Intermediate</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">Bootstrap</div>
                        <div class="tut-desc">Build responsive websites faster with Bootstrap framework.</div>
                        <div class="tut-meta">
                            <span>📖 8 Chapters</span>
                            <span>⏱ 3 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:0%"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status notstarted">○ Not Started</span>
                            <a href="tutorial.jsp?course=bootstrap" class="tut-btn">Start →</a>
                        </div>
                    </div>
                </div>

                <!-- 6. PYTHON -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=python'">
                    <div class="tut-card-top" style="background:rgba(124,58,237,0.1);border-color:rgba(124,58,237,0.2)">
                        <div class="tut-icon" style="color:#7c3aed">Py</div>
                        <span class="tut-level beginner">Beginner</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">Python</div>
                        <div class="tut-desc">Learn Python programming from basics to advanced concepts.</div>
                        <div class="tut-meta">
                            <span>📖 14 Chapters</span>
                            <span>⏱ 5 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:20%;background:#7c3aed"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status inprogress">↗ In Progress</span>
                            <a href="tutorial.jsp?course=python" class="tut-btn">Continue →</a>
                        </div>
                    </div>
                </div>

                <!-- 7. SQL & MYSQL -->
                <div class="tut-card" onclick="location.href='tutorial.jsp?course=sql'">
                    <div class="tut-card-top" style="background:rgba(20,184,166,0.1);border-color:rgba(20,184,166,0.2)">
                        <div class="tut-icon" style="color:#14b8a6">SQL</div>
                        <span class="tut-level intermediate">Intermediate</span>
                    </div>
                    <div class="tut-card-body">
                        <div class="tut-title">SQL & MySQL</div>
                        <div class="tut-desc">Master database concepts with SQL queries and MySQL.</div>
                        <div class="tut-meta">
                            <span>📖 8 Chapters</span>
                            <span>⏱ 3 Hours</span>
                        </div>
                        <div class="prog-bar" style="margin-top:10px">
                            <div class="prog-fill" style="width:0%"></div>
                        </div>
                        <div class="tut-footer">
                            <span class="tut-status notstarted">○ Not Started</span>
                            <a href="tutorial.jsp?course=sql" class="tut-btn">Start →</a>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <footer class="footer">
        <div class="footer-top">
            <div class="footer-brand">
                <h3>CodeNext</h3>
                <p>A Developer Learning Portal for freshers and students.</p>
                <div class="footer-social">
                    <a href="https://github.com/Sujal-0803">🐙 GitHub</a>
                    <a href="https://www.linkedin.com/in/sujalmaru0803/">💼 LinkedIn</a>
                    <a href="https://www.instagram.com/sujalll._24">📸 Instagram</a>
                </div>
            </div>
            <div class="footer-links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="contact.jsp">Contact Us</a></li>
                </ul>
            </div>
            <div class="footer-contact">
                <h4>Contact Us</h4>
                <p>📧 dev.sujalmaru@gmail.com</p>
                <p>📞 +91 79728 91795</p>
                <p>📍 Pune, Maharashtra, India</p>
                <a href="contact.jsp" class="contact-btn">Send Message</a>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 CodeNext |
            <a href="about.jsp">About</a> &nbsp;|&nbsp;
            <a href="contact.jsp">Contact Us</a>
        </div>
    </footer>

</body>
</html>