<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.codenext.db.DBConnection" %>

<%
    HttpSession userSession = request.getSession(false);
    if(userSession == null ||
       userSession.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int    userId   = (int)    userSession.getAttribute("userId");
    String userName = (String) userSession.getAttribute("userName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeNext | My Badges</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="badges.css">
</head>
<body>

    <!-- HEADER -->
    <header class="header">
        <div class="logo">CodeNext</div>
        <div class="header-right">
            <span class="welcome-text">
                Hey, <%= userName %>! 👋
            </span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </header>

    <!-- NAVBAR -->
    <nav class="menubar">
        <a href="index.jsp">Home</a>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="tutorials.jsp">Tutorials</a>
        <a href="quiz.jsp">Quiz</a>
        <a href="leaderboard.jsp">Leaderboard</a>
    </nav>

    <!-- MAIN LAYOUT -->
    <div class="dash-layout">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <h2>My Account</h2>
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="profile.jsp">My Profile</a></li>
                <li><a href="tutorials.jsp">My Courses</a></li>
                <li><a href="quiz.jsp">Take Quiz</a></li>
                <li><a href="leaderboard.jsp">Leaderboard</a></li>
                <li><a href="LogoutServlet" style="color: #ef4444">
						Logout</a></li>
            </ul>
        </aside>

        <!-- BADGES CONTENT -->
        <main class="dash-main">

            <!-- PAGE HEADER -->
            <div class="page-header">
                <div>
                    <div class="page-title">🎖️ My Badges</div>
                    <div class="page-sub">
                        Earn badges by completing courses
                        and scoring high in quizzes!
                    </div>
                </div>
                <%
                int earnedCount = 0;
                try {
                    Connection connCount =
                        DBConnection.getConnection();
                    PreparedStatement psCount =
                        connCount.prepareStatement(
                        "SELECT COUNT(*) FROM badges " +
                        "WHERE user_id = ?");
                    psCount.setInt(1, userId);
                    ResultSet rsCount = psCount.executeQuery();
                    if(rsCount.next()) {
                        earnedCount = rsCount.getInt(1);
                    }
                    connCount.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
                %>
                <div class="page-badge">
                    <%= earnedCount %> Earned
                </div>
            </div>

            <!-- EARNED BADGES -->
            <div class="badges-section-title">
                ✅ Earned Badges
            </div>

            <%
            boolean hasEarned = false;
            try {
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT badge_name, earned_on " +
                    "FROM badges WHERE user_id = ? " +
                    "ORDER BY earned_on DESC");
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
            %>
            <div class="badges-grid">
            <%
                while(rs.next()) {
                    hasEarned = true;
                    String badgeName = rs.getString("badge_name");
                    String earnedOn  = rs.getString("earned_on");

                    // Pick icon based on badge name
                    String icon = "🎖️";
                    String color = "#00e5a0";
                    String borderColor =
                        "rgba(0,229,160,0.3)";
                    String bgColor =
                        "rgba(0,229,160,0.08)";

                    if(badgeName.contains("HTML")) {
                        icon = "🌐"; color = "#ef4444";
                        borderColor = "rgba(239,68,68,0.3)";
                        bgColor = "rgba(239,68,68,0.08)";
                    } else if(badgeName.contains("CSS")) {
                        icon = "🎨"; color = "#3b82f6";
                        borderColor = "rgba(59,130,246,0.3)";
                        bgColor = "rgba(59,130,246,0.08)";
                    } else if(badgeName.contains("JavaScript")
                           || badgeName.contains("JS")) {
                        icon = "⚡"; color = "#f59e0b";
                        borderColor = "rgba(245,158,11,0.3)";
                        bgColor = "rgba(245,158,11,0.08)";
                    } else if(badgeName.contains("Python")) {
                        icon = "🐍"; color = "#7c3aed";
                        borderColor = "rgba(124,58,237,0.3)";
                        bgColor = "rgba(124,58,237,0.08)";
                    } else if(badgeName.contains("Java")) {
                        icon = "☕"; color = "#f97316";
                        borderColor = "rgba(249,115,22,0.3)";
                        bgColor = "rgba(249,115,22,0.08)";
                    } else if(badgeName.contains("SQL")) {
                        icon = "🗄️"; color = "#14b8a6";
                        borderColor = "rgba(20,184,166,0.3)";
                        bgColor = "rgba(20,184,166,0.08)";
                    } else if(badgeName.contains("Streak")) {
                        icon = "🔥"; color = "#ef4444";
                        borderColor = "rgba(239,68,68,0.3)";
                        bgColor = "rgba(239,68,68,0.08)";
                    } else if(badgeName.contains("Quiz")
                           || badgeName.contains("Perfect")) {
                        icon = "🏆"; color = "#f59e0b";
                        borderColor = "rgba(245,158,11,0.3)";
                        bgColor = "rgba(245,158,11,0.08)";
                    } else if(badgeName.contains("Fast")) {
                        icon = "🚀"; color = "#00e5a0";
                        borderColor = "rgba(0,229,160,0.3)";
                        bgColor = "rgba(0,229,160,0.08)";
                    }
            %>
                <div class="badge-card earned">
                    <div class="badge-card-icon"
                         style="background:<%= bgColor %>;
                                border-color:<%= borderColor %>;
                                color:<%= color %>">
                        <%= icon %>
                    </div>
                    <div class="badge-card-name">
                        <%= badgeName %>
                    </div>
                    <div class="badge-card-date">
                        Earned: <%= earnedOn %>
                    </div>
                    <div class="badge-card-status earned-tag">
                        ✓ Earned
                    </div>
                </div>
            <%
                }
                conn.close();
            } catch(Exception e) {
                e.printStackTrace();
            }

            if(!hasEarned) {
            %>
                <div class="badges-empty">
                    No badges earned yet! 😔
                    Complete courses and take quizzes
                    to earn your first badge!
                    <br><br>
                    <a href="tutorials.jsp"
                       class="badges-start-btn">
                        Start Learning →
                    </a>
                </div>
            <%
            }
            %>
            </div>

            <!-- ALL AVAILABLE BADGES -->
            <div class="badges-section-title"
                 style="margin-top:28px">
                🔒 All Available Badges
            </div>
            <div class="badges-grid">

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(239,68,68,0.08);
                                border-color:rgba(239,68,68,0.2);
                                color:#ef4444">🌐</div>
                    <div class="badge-card-name">HTML Master</div>
                    <div class="badge-card-date">
                        Complete HTML course
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(59,130,246,0.08);
                                border-color:rgba(59,130,246,0.2);
                                color:#3b82f6">🎨</div>
                    <div class="badge-card-name">CSS Pro</div>
                    <div class="badge-card-date">
                        Complete CSS course
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(245,158,11,0.08);
                                border-color:rgba(245,158,11,0.2);
                                color:#f59e0b">⚡</div>
                    <div class="badge-card-name">JS Ninja</div>
                    <div class="badge-card-date">
                        Complete JavaScript course
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(124,58,237,0.08);
                                border-color:rgba(124,58,237,0.2);
                                color:#7c3aed">🐍</div>
                    <div class="badge-card-name">
                        Python Expert
                    </div>
                    <div class="badge-card-date">
                        Complete Python course
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(249,115,22,0.08);
                                border-color:rgba(249,115,22,0.2);
                                color:#f97316">☕</div>
                    <div class="badge-card-name">Java Guru</div>
                    <div class="badge-card-date">
                        Complete Java course
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(20,184,166,0.08);
                                border-color:rgba(20,184,166,0.2);
                                color:#14b8a6">🗄️</div>
                    <div class="badge-card-name">SQL Master</div>
                    <div class="badge-card-date">
                        Complete SQL course
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(239,68,68,0.08);
                                border-color:rgba(239,68,68,0.2);
                                color:#ef4444">🔥</div>
                    <div class="badge-card-name">
                        7 Day Streak
                    </div>
                    <div class="badge-card-date">
                        Login 7 days in a row
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(245,158,11,0.08);
                                border-color:rgba(245,158,11,0.2);
                                color:#f59e0b">🏆</div>
                    <div class="badge-card-name">Quiz Star</div>
                    <div class="badge-card-date">
                        Score 100% on any quiz
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(0,229,160,0.08);
                                border-color:rgba(0,229,160,0.2);
                                color:#00e5a0">🚀</div>
                    <div class="badge-card-name">
                        Fast Learner
                    </div>
                    <div class="badge-card-date">
                        Complete a course in 3 days
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(0,229,160,0.08);
                                border-color:rgba(0,229,160,0.2);
                                color:#00e5a0">🎯</div>
                    <div class="badge-card-name">
                        Top 3 Rank
                    </div>
                    <div class="badge-card-date">
                        Reach top 3 on leaderboard
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(0,229,160,0.08);
                                border-color:rgba(0,229,160,0.2);
                                color:#00e5a0">💻</div>
                    <div class="badge-card-name">
                        First Code
                    </div>
                    <div class="badge-card-date">
                        Complete your first chapter
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

                <div class="badge-card locked">
                    <div class="badge-card-icon"
                         style="background:rgba(0,229,160,0.08);
                                border-color:rgba(0,229,160,0.2);
                                color:#00e5a0">⭐</div>
                    <div class="badge-card-name">
                        All Rounder
                    </div>
                    <div class="badge-card-date">
                        Complete all 7 courses
                    </div>
                    <div class="badge-card-status locked-tag">
                        🔒 Locked
                    </div>
                </div>

            </div>

            <!-- HOW TO EARN -->
            <div class="badges-how-card">
                <div class="badges-how-title">
                    💡 How to Earn Badges
                </div>
                <div class="badges-how-grid">
                    <div class="badges-how-item">
                        <span>📚 Complete a course</span>
                        <span style="color:#00e5a0">
                            → Course Badge
                        </span>
                    </div>
                    <div class="badges-how-item">
                        <span>🏆 Score 100% in quiz</span>
                        <span style="color:#f59e0b">
                            → Quiz Star Badge
                        </span>
                    </div>
                    <div class="badges-how-item">
                        <span>🔥 Login 7 days in a row</span>
                        <span style="color:#ef4444">
                            → Streak Badge
                        </span>
                    </div>
                    <div class="badges-how-item">
                        <span>🎯 Reach top 3 rank</span>
                        <span style="color:#00e5a0">
                            → Top 3 Badge
                        </span>
                    </div>
                </div>
            </div>

        </main>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <div class="footer-top">
            <div class="footer-brand">
                <h3>CodeNext</h3>
                <p>A Developer Learning Portal
                   for freshers and students.</p>
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
                <a href="contact.jsp" class="contact-btn">
                    Send Message
                </a>
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