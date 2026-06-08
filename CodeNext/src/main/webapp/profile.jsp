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
int userId = (int) userSession.getAttribute("userId");
String userName = (String) userSession.getAttribute("userName");
String userEmail = (String) userSession.getAttribute("userEmail");

// Get user data from database
int totalPoints = 0;
int streak = 0;
int rank = 0;
int quizzesTaken = 0;
int badgesEarned = 0;
int coursesTotal = 0;
String joinedDate = "";

try {
	Connection conn = DBConnection.getConnection();

	// Get user details
	PreparedStatement ps1 = conn
	.prepareStatement("SELECT total_points, streak, joined_date " + "FROM users WHERE id = ?");
	ps1.setInt(1, userId);
	ResultSet rs1 = ps1.executeQuery();
	if (rs1.next()) {
		totalPoints = rs1.getInt("total_points");
		streak = rs1.getInt("streak");
		joinedDate = rs1.getString("joined_date");
	}

	// Get rank — fixed
	PreparedStatement ps2 = conn.prepareStatement(
		"SELECT COUNT(*) + 1 as rank FROM users " +
		"WHERE total_points > (SELECT total_points FROM users WHERE id = ?) " +
		"OR (total_points = (SELECT total_points FROM users WHERE id = ?) AND id < ?)");
	ps2.setInt(1, userId);
	ps2.setInt(2, userId);
	ps2.setInt(3, userId);
	ResultSet rs2 = ps2.executeQuery();
	if (rs2.next())
		rank = rs2.getInt("rank");

	// Get quizzes taken
	PreparedStatement ps3 = conn.prepareStatement("SELECT COUNT(*) FROM quiz_results " + "WHERE user_id = ?");
	ps3.setInt(1, userId);
	ResultSet rs3 = ps3.executeQuery();
	if (rs3.next())
		quizzesTaken = rs3.getInt(1);

	// Get badges earned
	PreparedStatement ps4 = conn.prepareStatement("SELECT COUNT(*) FROM badges WHERE user_id = ?");
	ps4.setInt(1, userId);
	ResultSet rs4 = ps4.executeQuery();
	if (rs4.next())
		badgesEarned = rs4.getInt(1);

	// Get courses started
	PreparedStatement ps5 = conn.prepareStatement("SELECT COUNT(*) FROM user_progress " + "WHERE user_id = ?");
	ps5.setInt(1, userId);
	ResultSet rs5 = ps5.executeQuery();
	if (rs5.next())
		coursesTotal = rs5.getInt(1);

	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}

// Get initials for avatar
String[] nameParts = userName.split(" ");
String initials = "";
for (String part : nameParts) {
	if (!part.isEmpty()) {
		initials += part.charAt(0);
	}
}
if (initials.length() > 2) {
	initials = initials.substring(0, 2);
}
initials = initials.toUpperCase();

// Handle name update
String updateMsg = "";
String newName = request.getParameter("newName");
if (newName != null && !newName.trim().isEmpty()) {
	try {
		Connection connU = DBConnection.getConnection();
		PreparedStatement psU = connU.prepareStatement(
			"UPDATE users SET full_name = ? WHERE id = ?");
		psU.setString(1, newName.trim());
		psU.setInt(2, userId);
		psU.executeUpdate();
		connU.close();
		session.setAttribute("userName", newName.trim());
		userName = newName.trim();
		updateMsg = "success";
	} catch (Exception e) {
		e.printStackTrace();
		updateMsg = "error";
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeNext | My Profile</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="dashboard.css">
<link rel="stylesheet" href="profile.css">
</head>
<body>

	<!-- HEADER -->
	<header class="header">
		<div class="logo">CodeNext</div>
		<div class="header-right">
			<span class="welcome-text"> Hey, <%=userName%>! 👋
			</span> <a href="LogoutServlet" class="logout-btn">Logout</a>
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
				<li><a href="badges.jsp">My Badges</a></li>
				<li><a href="tutorials.jsp">My Courses</a></li>
				<li><a href="quiz.jsp">Take Quiz</a></li>
				<li><a href="leaderboard.jsp">Leaderboard</a></li>
				<li><a href="LogoutServlet" style="color: #ef4444"> Logout</a></li>
			</ul>
		</aside>

		<!-- PROFILE CONTENT -->
		<main class="dash-main">

			<!-- PROFILE CARD -->
			<div class="profile-card">

				<!-- BANNER -->
				<div class="profile-banner">
					<div class="profile-banner-text">&lt;CodeNext/&gt;</div>
				</div>

				<!-- AVATAR & NAME -->
				<div class="profile-top">

					<!-- AVATAR -->
					<div class="profile-avatar">
						<%=initials%>
					</div>

					<div class="profile-info">

						<!-- NAME WITH EDIT BUTTON -->
						<div class="profile-name" style="display:flex;align-items:center;gap:10px">
							<%=userName%>
							<button id="editBtn"
								onclick="document.getElementById('editNameBox').style.display='block';this.style.display='none'"
								style="background:transparent;
								       border:1px solid #00e5a0;
								       color:#00e5a0;
								       padding:3px 10px;
								       border-radius:6px;
								       font-size:12px;
								       cursor:pointer;">
								✏️ Edit
							</button>
						</div>

						<!-- EDIT NAME FORM -->
						<div id="editNameBox" style="display:none; margin-top:10px">
							<form method="post" action="profile.jsp" style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
								<input type="text" name="newName"
									value="<%=userName%>"
									placeholder="Enter new name"
									style="padding:6px 12px;
									       border-radius:6px;
									       border:1px solid #00e5a0;
									       background:#0d1117;
									       color:#fff;
									       font-size:14px;
									       outline:none;" />
								<button type="submit"
									style="background:#00e5a0;
									       color:#000;
									       border:none;
									       padding:6px 14px;
									       border-radius:6px;
									       font-weight:bold;
									       cursor:pointer;
									       font-size:13px;">
									Save
								</button>
								<button type="button"
									onclick="document.getElementById('editNameBox').style.display='none';
									         document.getElementById('editBtn').style.display='inline-block'"
									style="background:transparent;
									       border:1px solid #ef4444;
									       color:#ef4444;
									       padding:6px 14px;
									       border-radius:6px;
									       cursor:pointer;
									       font-size:13px;">
									Cancel
								</button>
							</form>
							<% if(updateMsg.equals("success")) { %>
							<div style="color:#00e5a0;font-size:13px;margin-top:6px">✅ Name updated successfully!</div>
							<% } else if(updateMsg.equals("error")) { %>
							<div style="color:#ef4444;font-size:13px;margin-top:6px">❌ Failed to update. Try again.</div>
							<% } %>
						</div>

						<div class="profile-email">
							<%=userEmail%>
						</div>
						<div class="profile-tags">
							<span class="profile-tag"> 🎓 Fresher </span> <span
								class="profile-tag"> 📅 Joined: <%=joinedDate%>
							</span> <span class="profile-tag"
								style="color: #00e5a0; border-color: rgba(0, 229, 160, 0.3)">
								🔥 <%=streak%> Day Streak
							</span>
						</div>
					</div>

					<div class="profile-rank-badge">
						#<%=rank%>
						<div style="font-size: 11px; color: #64748b; margin-top: 4px">
							Rank</div>
					</div>
				</div>
			</div>

			<!-- STATS GRID -->
			<div class="profile-stats">
				<div class="profile-stat-card">
					<div class="psc-icon">🏆</div>
					<div class="psc-val"><%=totalPoints%></div>
					<div class="psc-label">Total Points</div>
				</div>
				<div class="profile-stat-card">
					<div class="psc-icon">🧠</div>
					<div class="psc-val"><%=quizzesTaken%></div>
					<div class="psc-label">Quizzes Taken</div>
				</div>
				<div class="profile-stat-card">
					<div class="psc-icon">🎖️</div>
					<div class="psc-val"><%=badgesEarned%></div>
					<div class="psc-label">Badges Earned</div>
				</div>
				<div class="profile-stat-card">
					<div class="psc-icon">📚</div>
					<div class="psc-val"><%=coursesTotal%></div>
					<div class="psc-label">Courses Started</div>
				</div>
			</div>

			<!-- BOTTOM GRID -->
			<div class="profile-bottom-grid">

				<!-- QUIZ HISTORY -->
				<div class="profile-section-card">
					<div class="profile-section-title">📊 Recent Quiz History</div>
					<%
					try {
						Connection conn2 = DBConnection.getConnection();
						PreparedStatement psQ = conn2.prepareStatement("SELECT q.score, q.total, q.taken_on, "
						+ "c.title FROM quiz_results q " + "JOIN courses c ON q.course_id = c.id " + "WHERE q.user_id = ? "
						+ "ORDER BY q.taken_on DESC LIMIT 5");
						psQ.setInt(1, userId);
						ResultSet rsQ = psQ.executeQuery();
						boolean hasQuiz = false;
						while (rsQ.next()) {
							hasQuiz = true;
							int score = rsQ.getInt("score");
							int total = rsQ.getInt("total");
							String title = rsQ.getString("title");
							String date = rsQ.getString("taken_on");
							int pct = total > 0 ? (score * 100) / total : 0;
					%>
					<div class="quiz-history-row">
						<div class="qhr-left">
							<div class="qhr-course">
								<%=title%>
								Quiz
							</div>
							<div class="qhr-date">
								<%=date%>
							</div>
						</div>
						<div class="qhr-right">
							<div class="qhr-score">
								<%=score%>/<%=total%>
							</div>
							<div class="qhr-pct <%=pct >= 60 ? "good" : "low"%>">
								<%=pct%>%
							</div>
						</div>
					</div>
					<%
					}
					if (!hasQuiz) {
					%>
					<div class="profile-empty">
						No quizzes taken yet! <a href="quiz.jsp">Take a quiz →</a>
					</div>
					<%
					}
					conn2.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>

				<!-- Certificates -->
				<div class="profile-section-card">
					<div class="profile-section-title">📜 My Certificates</div>
					<%
					try {
						Connection connCert = DBConnection.getConnection();
						PreparedStatement psCert = connCert.prepareStatement("SELECT c.course_id, co.title, c.issued_on "
						+ "FROM certificates c " + "JOIN courses co ON c.course_id = co.id " + "WHERE c.user_id = ?");
						psCert.setInt(1, userId);
						ResultSet rsCert = psCert.executeQuery();
						boolean hasCert = false;
						while (rsCert.next()) {
							hasCert = true;
					%>
					<div class="cert-row">
						<div>
							<div class="cert-course-name">
								<%=rsCert.getString("title")%>
							</div>
							<div class="cert-issued">
								Issued: <%=rsCert.getString("issued_on")%>
							</div>
						</div>
						<a href="certificate.jsp?course_id=<%=rsCert.getInt("course_id")%>"
							class="cert-view-btn"> View Certificate → </a>
					</div>
					<%
					}
					if (!hasCert) {
					%>
					<div class="profile-empty">
						No certificates yet! Complete a course to get your certificate.
						<a href="tutorials.jsp">Start learning →</a>
					</div>
					<%
					}
					connCert.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
				</div>

				<!-- BADGES -->
				<div class="profile-section-card" style="margin-top: 5px">
					<div class="profile-section-title">🎖️ My Badges</div>
					<%
					try {
						Connection conn3 = DBConnection.getConnection();
						PreparedStatement psB = conn3.prepareStatement(
						"SELECT badge_name, earned_on " + "FROM badges WHERE user_id = ? " + "ORDER BY earned_on DESC");
						psB.setInt(1, userId);
						ResultSet rsB = psB.executeQuery();
						boolean hasBadge = false;
						while (rsB.next()) {
							hasBadge = true;
					%>
					<div class="badge-row">
						<span class="badge-pill-profile"> 🎖️ <%=rsB.getString("badge_name")%>
						</span> <span class="badge-date"> <%=rsB.getString("earned_on")%>
						</span>
					</div>
					<%
					}
					if (!hasBadge) {
					%>
					<div class="profile-empty">
						No badges yet! Complete courses to earn badges.
						<a href="tutorials.jsp">Start learning →</a>
					</div>
					<%
					}
					conn3.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>
					<a href="badges.jsp" class="view-all-btn"> View All Badges → </a>
				</div>

			</div>

			<!-- ACCOUNT ACTIONS -->
			<div class="profile-section-card" style="margin-top: 18px">
				<div class="profile-section-title">⚙️ Account Actions</div>
				<div class="profile-actions">
					<a href="dashboard.jsp" class="profile-action-btn">📊 Go to Dashboard</a>
					<a href="quiz.jsp" class="profile-action-btn">🧠 Take a Quiz</a>
					<a href="tutorials.jsp" class="profile-action-btn">📚 View Courses</a>
					<a href="leaderboard.jsp" class="profile-action-btn">🏆 Leaderboard</a>
					<a href="contact.jsp" class="profile-action-btn">📬 Contact Us</a>
					<a href="LogoutServlet" class="profile-action-btn logout">🚪 Logout</a>
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
				<a href="contact.jsp" class="contact-btn"> Send Message </a>
			</div>
		</div>
		<div class="footer-bottom">
			&copy; 2026 CodeNext | <a href="about.jsp">About</a> &nbsp;|&nbsp;
			<a href="contact.jsp">Contact Us</a>
		</div>
	</footer>

</body>
</html>