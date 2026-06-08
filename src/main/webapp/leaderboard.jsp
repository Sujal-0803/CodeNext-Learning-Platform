<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.codenext.db.DBConnection"%>

<%
HttpSession userSession = request.getSession(false);
if (userSession == null || userSession.getAttribute("userId") == null) {
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
<title>CodeNext | Leaderboard</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="dashboard.css">
<link rel="stylesheet" href="leaderboard.css">
</head>
<body>

	<!-- HEADER -->
	<header class="header">
		<div class="logo">CodeNext</div>
		<div class="header-right">
			<span class="welcome-text">Hey, <%=userName%>! 👋
			</span> <a href="LogoutServlet" class="logout-btn">Logout</a>
		</div>
	</header>

	<!-- NAVBAR -->
	<nav class="menubar">
		<a href="index.jsp">Home</a> <a href="dashboard.jsp">Dashboard</a> <a
			href="tutorials.jsp">Tutorials</a> <a href="quiz.jsp">Quiz</a> <a
			href="leaderboard.jsp" class="active">Leaderboard</a>
	</nav>

	<!-- MAIN LAYOUT -->
	<div class="dash-layout">

		<!-- SIDEBAR -->
		<aside class="sidebar">
			<h2>Quick Links</h2>
			<ul>
				<li><a href="dashboard.jsp">Dashboard</a></li>
				<li><a href="profile.jsp">My Profile</a></li>
				<li><a href="badges.jsp">My Badges</a></li>
				<li><a href="tutorials.jsp">Tutorials</a></li>
				<li><a href="quiz.jsp">Take Quiz</a></li>
			</ul>
		</aside>

		<!-- LEADERBOARD CONTENT -->
		<main class="dash-main">

			<!-- PAGE HEADER -->
			<div class="page-header">
				<div>
					<div class="page-title">🏆 Leaderboard</div>
					<div class="page-sub">Top learners this month — keep learning
						to climb up!</div>
				</div>
				<div class="page-badge">Updated Live</div>
			</div>

			<!-- TOP 3 PODIUM -->
			<div class="podium-row">
				<%
				try {
					Connection conn = DBConnection.getConnection();
					PreparedStatement ps = conn
					.prepareStatement("SELECT full_name, total_points FROM users " + "ORDER BY total_points DESC LIMIT 3");
					ResultSet rs = ps.executeQuery();
					String[] medals = { "🥇", "🥈", "🥉" };
					String[] heights = { "podium-1", "podium-2", "podium-3" };
					int podiumRank = 1;
					String[] names = { "", "", "" };
					int[] points = { 0, 0, 0 };
					while (rs.next()) {
						names[podiumRank - 1] = rs.getString("full_name");
						points[podiumRank - 1] = rs.getInt("total_points");
						podiumRank++;
					}
					conn.close();
				%>
				<!-- 2nd Place -->
				<div class="podium-item">
					<div class="podium-name"><%=names[1].isEmpty() ? "---" : names[1]%></div>
					<div class="podium-pts"><%=points[1]%>
						pts
					</div>
					<div class="podium-block podium-2">🥈</div>
					<div class="podium-rank">2nd</div>
				</div>
				<!-- 1st Place -->
				<div class="podium-item">
					<div class="podium-name" style="color: #00e5a0"><%=names[0].isEmpty() ? "---" : names[0]%></div>
					<div class="podium-pts" style="color: #00e5a0"><%=points[0]%>
						pts
					</div>
					<div class="podium-block podium-1">🥇</div>
					<div class="podium-rank">1st</div>
				</div>
				<!-- 3rd Place -->
				<div class="podium-item">
					<div class="podium-name"><%=names[2].isEmpty() ? "---" : names[2]%></div>
					<div class="podium-pts"><%=points[2]%>
						pts
					</div>
					<div class="podium-block podium-3">🥉</div>
					<div class="podium-rank">3rd</div>
				</div>
				<%
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>
			</div>

			<!-- FULL LEADERBOARD TABLE -->
			<div class="lb-table">
				<div class="lb-table-header">
					<span>Rank</span> <span>Student</span> <span>Quizzes</span> <span>Points</span>
				</div>
				<%
				try {
					Connection conn2 = DBConnection.getConnection();
					PreparedStatement ps2 = conn2.prepareStatement("SELECT u.id, u.full_name, u.total_points, "
					+ "COUNT(q.id) as quiz_count " + "FROM users u " + "LEFT JOIN quiz_results q ON u.id = q.user_id "
					+ "GROUP BY u.id " + "ORDER BY u.total_points DESC");
					ResultSet rs2 = ps2.executeQuery();
					int tableRank = 1;
					String[] rankEmoji = { "🥇", "🥈", "🥉" };
					while (rs2.next()) {
						String lbName = rs2.getString("full_name");
						int lbPts = rs2.getInt("total_points");
						int lbQuiz = rs2.getInt("quiz_count");
						boolean isMe = rs2.getInt("id") == userId;
						String rankDisp = tableRank <= 3 ? rankEmoji[tableRank - 1] : String.valueOf(tableRank);
				%>
				<div class="lb-table-row <%=isMe ? "lb-table-me" : ""%>">
					<span class="lb-rank-num"><%=rankDisp%></span> <span
						class="lb-uname"> <%=lbName%><%=isMe ? " 👈 You" : ""%>
					</span> <span class="lb-quiz-count"><%=lbQuiz%></span> <span
						class="lb-points"><%=lbPts%> pts</span>
				</div>
				<%
				tableRank++;
				}
				conn2.close();
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>
			</div>

			<!-- HOW TO EARN POINTS -->
			<div class="points-guide">
				<div class="points-guide-title">💡 How to Earn Points</div>
				<div class="points-guide-grid">
					<div class="points-item">
						<span class="points-icon">🧠</span> <span class="points-label">Complete
							a Quiz</span> <span class="points-val">+20 pts</span>
					</div>
					<div class="points-item">
						<span class="points-icon">📚</span> <span class="points-label">Finish
							a Course</span> <span class="points-val">+100 pts</span>
					</div>
					<div class="points-item">
						<span class="points-icon">🔥</span> <span class="points-label">7
							Day Streak</span> <span class="points-val">+50 pts</span>
					</div>
					<div class="points-item">
						<span class="points-icon">🎯</span> <span class="points-label">Score
							100% Quiz</span> <span class="points-val">+30 pts</span>
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
			&copy; 2026 CodeNext | <a href="about.jsp">About</a> &nbsp;|&nbsp; <a
				href="contact.jsp">Contact Us</a>
		</div>
	</footer>

</body>
</html>