<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.codenext.db.DBConnection"%>

<%
// Check if user is logged in
HttpSession userSession = request.getSession(false);
if (userSession == null || userSession.getAttribute("userId") == null) {
	response.sendRedirect("login.jsp");
	return;
}

// Get user details from session
int userId = (int) userSession.getAttribute("userId");
String userName = (String) userSession.getAttribute("userName");
String userEmail = (String) userSession.getAttribute("userEmail");

// Get stats from database
int totalPoints = 0;
int badgesEarned = 0;
int quizzesTaken = 0;
int rank = 0;

try {
	Connection conn = DBConnection.getConnection();

	// Get total points
	PreparedStatement ps1 = conn.prepareStatement("SELECT total_points FROM users WHERE id = ?");
	ps1.setInt(1, userId);
	ResultSet rs1 = ps1.executeQuery();
	if (rs1.next())
		totalPoints = rs1.getInt("total_points");

	// Get badges count
	PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM badges WHERE user_id = ?");
	ps2.setInt(1, userId);
	ResultSet rs2 = ps2.executeQuery();
	if (rs2.next())
		badgesEarned = rs2.getInt(1);

	// Get quizzes taken
	PreparedStatement ps3 = conn.prepareStatement("SELECT COUNT(*) FROM quiz_results WHERE user_id = ?");
	ps3.setInt(1, userId);
	ResultSet rs3 = ps3.executeQuery();
	if (rs3.next())
		quizzesTaken = rs3.getInt(1);

	// Get rank
	PreparedStatement ps4 = conn.prepareStatement("SELECT COUNT(*) + 1 as rank FROM users "
	+ "WHERE total_points > (SELECT total_points FROM users WHERE id = ?)");
	ps4.setInt(1, userId);
	ResultSet rs4 = ps4.executeQuery();
	if (rs4.next())
		rank = rs4.getInt("rank");

	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeNext | Dashboard</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="dashboard.css">
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
		<a href="index.jsp">Home</a> <a href="dashboard.jsp" class="active">Dashboard</a>
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
				<li><a href="profile.jsp">My Profile</a></li>
				<li><a href="badges.jsp">My Badges</a></li>
				<li><a href="tutorials.jsp">My Courses</a></li>
				<li><a href="quiz.jsp">Take Quiz</a></li>
				<li><a href="leaderboard.jsp">Leaderboard</a></li>
				<li><a href="LogoutServlet" style="color: #ef4444">
						Logout</a></li>
			</ul>
		</aside>

		<!-- DASHBOARD CONTENT -->
		<main class="dash-main">

			<!-- WELCOME BANNER -->
			<div class="dash-banner">
				<div>
					<div class="dash-banner-title">
						Welcome back,
						<%=userName%>! 🚀
					</div>
					<div class="dash-banner-sub">Keep learning and climbing the leaderboard!</div>
				</div>
				<div class="dash-banner-icon">{ }</div>
			</div>

			<!-- STATS ROW -->
			<div class="stats-row">
				<div class="stat-card">
					<div class="stat-icon">🏆</div>
					<div class="stat-val"><%=totalPoints%></div>
					<div class="stat-label">Total Points</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">📊</div>
					<div class="stat-val">
						#<%=rank%></div>
					<div class="stat-label">Your Rank</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">🧠</div>
					<div class="stat-val"><%=quizzesTaken%></div>
					<div class="stat-label">Quizzes Taken</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon">🎖️</div>
					<div class="stat-val"><%=badgesEarned%></div>
					<div class="stat-label">Badges Earned</div>
				</div>
			</div>

			<!-- GRID -->
			<div class="dash-grid">

				<!-- COURSES -->
				<div class="dash-card">
					<div class="dash-card-title">📚 My Courses</div>
					<div class="course-item">
						<div class="course-info">
							<span class="course-name">HTML</span> <span class="course-pct">100%</span>
						</div>
						<div class="prog-bar">
							<div class="prog-fill" style="width: 100%"></div>
						</div>
					</div>
					<div class="course-item">
						<div class="course-info">
							<span class="course-name">CSS</span> <span class="course-pct">75%</span>
						</div>
						<div class="prog-bar">
							<div class="prog-fill" style="width: 75%; background: #22c55e"></div>
						</div>
					</div>
					<div class="course-item">
						<div class="course-info">
							<span class="course-name">JavaScript</span> <span
								class="course-pct">40%</span>
						</div>
						<div class="prog-bar">
							<div class="prog-fill" style="width: 40%; background: #f59e0b"></div>
						</div>
					</div>
					<div class="course-item">
						<div class="course-info">
							<span class="course-name">Python</span> <span class="course-pct">20%</span>
						</div>
						<div class="prog-bar">
							<div class="prog-fill" style="width: 20%; background: #7c3aed"></div>
						</div>
					</div>
					<div class="course-item">
						<div class="course-info">
							<span class="course-name">Java</span> <span class="course-pct">0%</span>
						</div>
						<div class="prog-bar">
							<div class="prog-fill" style="width: 0%"></div>
						</div>
					</div>
					<a href="tutorials.jsp" class="view-all-btn"> View All Courses
						→ </a>
				</div>

				<!-- LEADERBOARD -->
				<div class="dash-card">
					<div class="dash-card-title">🏆 Leaderboard</div>
					<%
					try {
						Connection conn2 = DBConnection.getConnection();
						PreparedStatement lbStmt = conn2
						.prepareStatement("SELECT full_name, total_points FROM users " + "ORDER BY total_points DESC LIMIT 5");
						ResultSet lbRs = lbStmt.executeQuery();
						int lbRank = 1;
						String[] medals = { "🥇", "🥈", "🥉", "4", "5" };
						while (lbRs.next()) {
							String lbName = lbRs.getString("full_name");
							int lbPoints = lbRs.getInt("total_points");
							boolean isMe = lbName.equals(userName);
					%>
					<div class="lb-row <%=isMe ? "lb-me" : ""%>">
						<span class="lb-medal"><%=medals[lbRank - 1]%></span> <span
							class="lb-name"><%=lbName%><%=isMe ? " (You)" : ""%></span> <span
							class="lb-pts"><%=lbPoints%> pts</span>
					</div>
					<%
					lbRank++;
					}
					conn2.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
					<a href="leaderboard.jsp" class="view-all-btn"> View Full
						Leaderboard → </a>
				</div>

			</div>

			<!-- BADGES ROW -->
			<div class="dash-card" style="margin-top: 18px">
				<div class="dash-card-title">🎖️ My Badges</div>
				<%
				int badgeCount = 0;
				try {
					Connection conn3 = DBConnection.getConnection();
					PreparedStatement bStmt = conn3.prepareStatement("SELECT badge_name FROM badges WHERE user_id = ?");
					bStmt.setInt(1, userId);
					ResultSet bRs = bStmt.executeQuery();
					while (bRs.next()) {
						badgeCount++;
				%>
				<span class="badge-pill"><%=bRs.getString("badge_name")%></span>
				<%
				}
				conn3.close();
				} catch (Exception e) {
				e.printStackTrace();
				}
				if (badgeCount == 0) {
				%>
				<p class="no-data">No badges yet — complete courses and quizzes
					to earn them! 🎯</p>
				<%
				}
				%>
				<a href="badges.jsp" class="view-all-btn" style="margin-top: 12px">
					View All Badges → </a>
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