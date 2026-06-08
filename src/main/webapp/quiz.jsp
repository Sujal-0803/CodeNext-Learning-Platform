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

    String courseIdStr = request.getParameter("course_id");
    int selectedCourse = courseIdStr != null ? Integer.parseInt(courseIdStr) : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeNext | Quiz</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="quiz.css">
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
        <a href="tutorials.jsp">Tutorials</a>
        <a href="quiz.jsp" class="active">Quiz</a>
        <a href="leaderboard.jsp">Leaderboard</a>
    </nav>

    <div class="dash-layout">

        <!-- SIDEBAR — Java, HTML, CSS, JavaScript, Python, SQL -->
        <aside class="sidebar">
            <h2>Quiz Topics</h2>
            <ul>
                <li><a href="quiz.jsp?course_id=7">Java Quiz</a></li>
                <li><a href="quiz.jsp?course_id=1">HTML Quiz</a></li>
                <li><a href="quiz.jsp?course_id=2">CSS Quiz</a></li>
                <li><a href="quiz.jsp?course_id=3">JavaScript Quiz</a></li>
                <li><a href="quiz.jsp?course_id=5">Bootstrap Quiz</a></li>
                <li><a href="quiz.jsp?course_id=4">Python Quiz</a></li>
                <li><a href="quiz.jsp?course_id=8">SQL & MySQL Quiz</a></li>
            </ul>
        </aside>

        <main class="dash-main">

        <% if(selectedCourse == 0) { %>

            <div class="page-header">
                <div>
                    <div class="page-title">🧠 Quiz Center</div>
                    <div class="page-sub">Test your knowledge and earn points!</div>
                </div>
                <div class="page-badge">7 Quiz Topics</div>
            </div>

            <!-- QUIZ CARDS — Java, HTML, CSS, JavaScript, Python, SQL -->
            <div class="quiz-select-grid">

                <!-- 1. JAVA -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=7'">
                    <div class="qs-icon" style="color:#f97316">☕</div>
                    <div class="qs-title">Java Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>

                <!-- 2. HTML -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=1'">
                    <div class="qs-icon" style="color:#ef4444">&#60;/&#62;</div>
                    <div class="qs-title">HTML Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>

                <!-- 3. CSS -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=2'">
                    <div class="qs-icon" style="color:#3b82f6">{ }</div>
                    <div class="qs-title">CSS Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>

                <!-- 4. JAVASCRIPT -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=3'">
                    <div class="qs-icon" style="color:#f59e0b">JS</div>
                    <div class="qs-title">JavaScript Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>
                
                <!-- 5. BOOTSTRAP -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=5'">
                    <div class="qs-icon" style="color:#8b5cf6">BS</div>
                    <div class="qs-title">Bootstrap Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>

                <!-- 6. PYTHON -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=4'">
                    <div class="qs-icon" style="color:#7c3aed">Py</div>
                    <div class="qs-title">Python Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>

                <!-- 7. SQL & MYSQL -->
                <div class="quiz-select-card" onclick="location.href='quiz.jsp?course_id=6'">
                    <div class="qs-icon" style="color:#14b8a6">SQL</div>
                    <div class="qs-title">SQL & MySQL Quiz</div>
                    <div class="qs-meta">15 Questions · Easy + Medium + Hard</div>
                    <div class="qs-btn">Start Quiz →</div>
                </div>

            </div>

            <!-- POINTS INFO -->
            <div class="quiz-info-box">
                <div class="quiz-info-title">🎯 How Points Work</div>
                <div class="quiz-info-grid">
                    <div class="quiz-info-item">
                        <span>✅ Correct Answer</span>
                        <span style="color:#00e5a0">+20 pts</span>
                    </div>
                    <div class="quiz-info-item">
                        <span>❌ Wrong Answer</span>
                        <span style="color:#ef4444">+0 pts</span>
                    </div>
                    <div class="quiz-info-item">
                        <span>🏆 Perfect Score</span>
                        <span style="color:#f59e0b">+30 bonus pts</span>
                    </div>
                    <div class="quiz-info-item">
                        <span>⏱ Timer</span>
                        <span style="color:#94a3b8">30 sec/question</span>
                    </div>
                </div>
            </div>

        <% } else { %>

            <%
            String courseTitle = "";
            try {
                Connection connTitle = DBConnection.getConnection();
                PreparedStatement psTitle = connTitle.prepareStatement(
                    "SELECT title FROM courses WHERE id = ?");
                psTitle.setInt(1, selectedCourse);
                ResultSet rsTitle = psTitle.executeQuery();
                if(rsTitle.next()) {
                    courseTitle = rsTitle.getString("title");
                }
                connTitle.close();
            } catch(Exception e) { e.printStackTrace(); }
            %>

            <div class="page-header">
                <div>
                    <div class="page-title">🧠 <%= courseTitle %> Quiz</div>
                    <div class="page-sub">Answer all questions — 5 Easy + 5 Medium + 5 Hard!</div>
                </div>
                <div class="quiz-timer-box">
                    <span id="timer">07:30</span>
                </div>
            </div>

            <form action="QuizServlet" method="post" id="quizForm">
                <input type="hidden" name="course_id" value="<%= selectedCourse %>">

            <%
            int qNum = 1;
            try {
                Connection connQ = DBConnection.getConnection();

                PreparedStatement psEasy = connQ.prepareStatement(
                    "SELECT * FROM quiz_questions " +
                    "WHERE course_id = ? AND difficulty = 'Easy' " +
                    "ORDER BY RAND() LIMIT 5");
                psEasy.setInt(1, selectedCourse);
                ResultSet rsEasy = psEasy.executeQuery();

                PreparedStatement psMed = connQ.prepareStatement(
                    "SELECT * FROM quiz_questions " +
                    "WHERE course_id = ? AND difficulty = 'Medium' " +
                    "ORDER BY RAND() LIMIT 5");
                psMed.setInt(1, selectedCourse);
                ResultSet rsMed = psMed.executeQuery();

                PreparedStatement psHard = connQ.prepareStatement(
                    "SELECT * FROM quiz_questions " +
                    "WHERE course_id = ? AND difficulty = 'Hard' " +
                    "ORDER BY RAND() LIMIT 5");
                psHard.setInt(1, selectedCourse);
                ResultSet rsHard = psHard.executeQuery();

                ResultSet[] allResults = {rsEasy, rsMed, rsHard};
                String[] sections = {
                    "🟢 Easy Questions",
                    "🟡 Medium Questions",
                    "🔴 Hard Questions"
                };
                int sectionIndex = 0;

                for(ResultSet rsQ : allResults) {
            %>
                <div class="quiz-section-header"><%= sections[sectionIndex] %></div>
            <%
                    while(rsQ.next()) {
                        int qId = rsQ.getInt("id");
                        String diff = rsQ.getString("difficulty");
            %>
                <div class="quiz-question-card">
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px">
                        <div class="quiz-q-num">Question <%= qNum %> of 15</div>
                        <span class="diff-badge diff-<%= diff.toLowerCase() %>"><%= diff %></span>
                    </div>
                    <div class="quiz-q-text"><%= rsQ.getString("question") %></div>
                    <input type="hidden" name="correct_<%= qId %>" value="<%= rsQ.getString("correct_answer") %>">
                    <div class="quiz-options">
                        <label class="quiz-opt">
                            <input type="radio" name="answer_<%= qId %>" value="A">
                            A. <%= rsQ.getString("option_a") %>
                        </label>
                        <label class="quiz-opt">
                            <input type="radio" name="answer_<%= qId %>" value="B">
                            B. <%= rsQ.getString("option_b") %>
                        </label>
                        <label class="quiz-opt">
                            <input type="radio" name="answer_<%= qId %>" value="C">
                            C. <%= rsQ.getString("option_c") %>
                        </label>
                        <label class="quiz-opt">
                            <input type="radio" name="answer_<%= qId %>" value="D">
                            D. <%= rsQ.getString("option_d") %>
                        </label>
                    </div>
                    <input type="hidden" name="q_ids" value="<%= qId %>">
                </div>
            <%
                        qNum++;
                    }
                    sectionIndex++;
                }
                connQ.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
            %>

            <div style="text-align:right;margin-top:20px">
                <button type="submit" class="quiz-submit-btn">Submit Quiz →</button>
            </div>
            </form>

        <% } %>
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

    <script>
        let timeLeft = 450;
        const timerEl = document.getElementById('timer');
        if(timerEl) {
            const interval = setInterval(() => {
                timeLeft--;
                const m = String(Math.floor(timeLeft/60)).padStart(2,'0');
                const s = String(timeLeft % 60).padStart(2,'0');
                timerEl.textContent = m + ':' + s;
                if(timeLeft <= 60) {
                    timerEl.style.color = '#ef4444';
                }
                if(timeLeft <= 0) {
                    clearInterval(interval);
                    document.getElementById('quizForm').submit();
                }
            }, 1000);
        }
    </script>

</body>
</html>