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

    // Get course parameter
    String courseIdStr = request.getParameter("course_id");
    int courseId = courseIdStr != null ? Integer.parseInt(courseIdStr.trim()) : 0;

    if(courseId == 0) {
        response.sendRedirect("profile.jsp");
        return;
    }

    // Get course title
    String courseTitle = "";
    String certNo      = "";
    String issuedOn    = "";
    boolean quizPassed = false;
    int userScore      = 0;
    int userTotal      = 0;

    try {
        Connection conn = DBConnection.getConnection();

        // Get course title
        PreparedStatement ps1 = conn.prepareStatement(
            "SELECT title FROM courses WHERE id = ?");
        ps1.setInt(1, courseId);
        ResultSet rs1 = ps1.executeQuery();
        if(rs1.next()) courseTitle = rs1.getString("title");

        // Check quiz result — get best attempt
        PreparedStatement psq = conn.prepareStatement(
            "SELECT score, total FROM quiz_results " +
            "WHERE user_id = ? AND course_id = ? " +
            "ORDER BY (score * 100 / total) DESC LIMIT 1");
        psq.setInt(1, userId);
        psq.setInt(2, courseId);
        ResultSet rsq = psq.executeQuery();
        if(rsq.next()) {
            userScore = rsq.getInt("score");
            userTotal = rsq.getInt("total");
            if(userTotal > 0) {
                double percent = (userScore * 100.0) / userTotal;
                if(percent >= 60) quizPassed = true;
            }
        }

        // Only generate certificate if quiz passed
        if(quizPassed) {
            // Check if certificate exists
            PreparedStatement ps2 = conn.prepareStatement(
                "SELECT * FROM certificates " +
                "WHERE user_id = ? AND course_id = ?");
            ps2.setInt(1, userId);
            ps2.setInt(2, courseId);
            ResultSet rs2 = ps2.executeQuery();

            if(rs2.next()) {
                certNo    = rs2.getString("certificate_no");
                issuedOn  = rs2.getString("issued_on");
            } else {
                certNo = "CN-" + userId + "-" +
                         courseId + "-" +
                         System.currentTimeMillis();

                PreparedStatement ps3 = conn.prepareStatement(
                    "INSERT INTO certificates " +
                    "(user_id, course_id, certificate_no) " +
                    "VALUES (?, ?, ?)");
                ps3.setInt(1, userId);
                ps3.setInt(2, courseId);
                ps3.setString(3, certNo);
                ps3.executeUpdate();

                PreparedStatement ps4 = conn.prepareStatement(
                    "SELECT issued_on FROM certificates " +
                    "WHERE certificate_no = ?");
                ps4.setString(1, certNo);
                ResultSet rs4 = ps4.executeQuery();
                if(rs4.next()) issuedOn = rs4.getString("issued_on");
            }
        }

        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeNext | Certificate</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="certificate.css">
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>

    <!-- HEADER -->
    <header class="header">
        <div class="logo">CodeNext</div>
        <div class="header-right">
            <span class="welcome-text">
                Hey, <%= userName %>! 👋
            </span>
            <a href="LogoutServlet" class="logout-btn">
                Logout
            </a>
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

    <!-- CERTIFICATE PAGE -->
    <div class="cert-page">

        <!-- BACK BUTTON -->
        <div class="cert-back">
            <a href="profile.jsp" class="cert-back-btn">
                ← Back to Profile
            </a>
            <% if(quizPassed) { %>
            <button onclick="window.print()"
                    class="cert-print-btn">
                🖨️ Print Certificate
            </button>
            <% } %>
        </div>

        <% if(quizPassed) { %>

        <!-- CERTIFICATE CARD -->
        <div class="cert-card" id="certCard">

            <!-- TOP BORDER DESIGN -->
            <div class="cert-top-border"></div>

            <!-- HEADER -->
            <div class="cert-header">
                <div class="cert-logo">
                    &lt;CodeNext/&gt;
                </div>
                <div class="cert-subtitle">
                    Developer Learning Portal
                </div>
            </div>

            <!-- CERTIFICATE TITLE -->
            <div class="cert-title">
                Certificate of Completion
            </div>

            <!-- BODY -->
            <div class="cert-body">
                <div class="cert-presented">
                    This is to certify that
                </div>
                <div class="cert-name">
                    <%= userName %>
                </div>
                <div class="cert-presented">
                    has successfully completed the course
                </div>
                <div class="cert-course">
                    <%= courseTitle %>
                </div>
                <div class="cert-presented">
                    on the CodeNext Developer Learning Portal
                </div>
            </div>

            <!-- FOOTER -->
            <div class="cert-footer">
                <div class="cert-footer-left">
                    <div class="cert-sign-line"></div>
                    <div class="cert-sign-name">Sujal Maru</div>
                    <div class="cert-sign-role">
                        Developer, CodeNext
                    </div>
                </div>
                <div class="cert-footer-center">
                    <div class="cert-seal">CN</div>
                    <div class="cert-seal-text">
                        Verified
                    </div>
                </div>
                <div class="cert-footer-right">
                    <div class="cert-no">
                        Certificate No: <%= certNo %>
                    </div>
                    <div class="cert-date">
                        Issued: <%= issuedOn %>
                    </div>
                </div>
            </div>

            <!-- BOTTOM BORDER -->
            <div class="cert-bottom-border"></div>

        </div>

        <% } else { %>

        <!-- LOCKED MESSAGE -->
        <div style="text-align:center; padding: 60px 20px;">
            <div style="font-size: 80px;">🔒</div>
            <h2 style="color:#fff; margin: 20px 0 10px;">Certificate Locked</h2>
            <p style="color:#aaa; font-size:16px; margin-bottom: 10px;">
                You need to pass the <strong style="color:#00e5a0"><%= courseTitle %></strong> quiz with at least <strong style="color:#00e5a0">60%</strong> to unlock your certificate.
            </p>
            <% if(userTotal > 0) { %>
            <p style="color:#ef4444; font-size:15px; margin-bottom: 30px;">
                Your best score: <strong><%= userScore %> / <%= userTotal %></strong>
                &nbsp;(<%= (userScore * 100 / userTotal) %>%)
            </p>
            <% } else { %>
            <p style="color:#ef4444; font-size:15px; margin-bottom: 30px;">
                You have not attempted the quiz yet.
            </p>
            <% } %>
            <a href="quiz.jsp?course_id=<%= courseId %>"
               style="display:inline-block;
                      background:#00e5a0;
                      color:#000;
                      padding:12px 30px;
                      border-radius:8px;
                      font-weight:bold;
                      text-decoration:none;
                      font-size:15px;">
                Take Quiz Now →
            </a>
        </div>

        <% } %>

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