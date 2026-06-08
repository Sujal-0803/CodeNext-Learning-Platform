<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.codenext.db.DBConnection" %>
<%
    HttpSession userSession = request.getSession(false);
    if(userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Prevent direct URL access
    if(request.getAttribute("score") == null) {
        response.sendRedirect("quiz.jsp");
        return;
    }

    String userName  = (String) userSession.getAttribute("userName");
    int userId       = (int) userSession.getAttribute("userId");
    int score        = (int) request.getAttribute("score");
    int total        = (int) request.getAttribute("total");
    int bonus        = (int) request.getAttribute("bonus");
    int totalScore   = (int) request.getAttribute("totalScore");
    int courseId     = (int) request.getAttribute("courseId");
    int percentage   = total > 0 ? (score * 100) / total : 0;
    boolean passed   = percentage >= 60;

    // Get latest badge earned
    String newBadge = "";
    try {
        Connection connB = DBConnection.getConnection();
        PreparedStatement psB = connB.prepareStatement(
            "SELECT badge_name FROM badges " +
            "WHERE user_id = ? " +
            "ORDER BY earned_on DESC LIMIT 1");
        psB.setInt(1, userId);
        ResultSet rsB = psB.executeQuery();
        if(rsB.next()) {
            newBadge = rsB.getString("badge_name");
        }
        connB.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CodeNext | Quiz Result</title>
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

    <div class="result-wrapper">
        <div class="result-card">

            <div class="result-emoji">
                <%= percentage == 100 ? "🏆" :
                    percentage >= 60  ? "🎯" : "💪" %>
            </div>

            <div class="result-title">
                <%= percentage == 100 ? "Perfect Score!" :
                    percentage >= 60  ? "Good Job!" :
                                        "Keep Practicing!" %>
            </div>

            <div class="result-score">
                <%= score %> / <%= total %>
            </div>

            <div class="result-pct">
                <%= percentage %>% Correct
            </div>

            <div class="result-stats">
                <div class="result-stat">
                    <div class="rs-val"><%= score %></div>
                    <div class="rs-label">Score</div>
                </div>
                <div class="result-stat">
                    <div class="rs-val" style="color:#f59e0b">
                        +<%= bonus %>
                    </div>
                    <div class="rs-label">Bonus</div>
                </div>
                <div class="result-stat">
                    <div class="rs-val" style="color:#00e5a0">
                        +<%= totalScore %>
                    </div>
                    <div class="rs-label">Total Pts</div>
                </div>
            </div>

            <%-- ── BADGE EARNED SECTION ── --%>
            <% if(!newBadge.isEmpty()) { %>
            <div class="result-badge-earned">
                🎖️ New Badge Earned:
                <strong><%= newBadge %></strong>
            </div>
            <% } %>

            <div class="result-actions">
                <% if(passed) { %>
                    <a href="leaderboard.jsp"
                       class="result-btn-outline">
                        View Leaderboard →
                    </a>
                    <a href="certificate.jsp?course_id=<%= courseId %>"
                       class="result-btn">
                        Get Certificate 📜
                    </a>
                <% } else { %>
                    <a href="quiz.jsp"
                       class="result-btn-outline">
                        Try Again
                    </a>
                    <a href="leaderboard.jsp"
                       class="result-btn">
                        View Leaderboard →
                    </a>
                <% } %>
            </div>

        </div>
    </div>

</body>
</html>