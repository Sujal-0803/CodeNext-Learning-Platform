<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeNext | About Us</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="dashboard.css">
<link rel="stylesheet" href="about.css">
</head>
<body>

	<!-- HEADER -->
	<header class="header">
		<div class="logo">CodeNext</div>
		<div class="header-right">
			<%
			HttpSession checkSession = request.getSession(false);
			if (checkSession != null && checkSession.getAttribute("userId") != null) {
			%>
			<span class="welcome-text"> Hey, <%=checkSession.getAttribute("userName")%>!
				👋
			</span> <a href="LogoutServlet" class="logout-btn">Logout</a>
			<%
			} else {
			%>
			<a href="login.jsp" class="login-btn">Login</a>
			<%
			}
			%>
		</div>
	</header>

	<!-- NAVBAR -->
	<nav class="menubar">
		<a href="index.jsp">Home</a> <a href="dashboard.jsp">Dashboard</a> <a
			href="tutorials.jsp">Tutorials</a> <a href="quiz.jsp">Quiz</a> <a
			href="leaderboard.jsp">Leaderboard</a>
	</nav>

	<div class="about-full">
		<main class="about-main">

			<!-- ABOUT CONTENT -->
			<main class="dash-main">

				<!-- HERO SECTION -->
				<div class="about-hero">
					<div class="about-hero-text">
						<div class="about-hero-title">&lt;CodeNext/&gt;</div>
						<div class="about-hero-sub">A Developer Learning Portal
							built for freshers and students who want to grow their coding
							skills.</div>
						<%
						HttpSession checkSession2 = request.getSession(false);
						if (checkSession2 != null && checkSession2.getAttribute("userId") != null) {
						%>
						<a href="dashboard.jsp" class="about-hero-btn"> Go to
							Dashboard → </a>
						<%
						} else {
						%>
						<a href="login.jsp" class="about-hero-btn"> Start Learning
							Today → </a>
						<%
						}
						%>

					</div>
					<div class="about-hero-code">
						<div class="code-block">
							<span class="code-line"> <span class="code-keyword">public
									class</span> <span class="code-class"> Developer</span> {
							</span> <span class="code-line"> &nbsp;&nbsp;<span
								class="code-keyword">String</span> name = <span
								class="code-string">"You"</span>;
							</span> <span class="code-line"> &nbsp;&nbsp;<span
								class="code-keyword">String</span> goal = <span
								class="code-string">"Learn & Grow"</span>;
							</span> <span class="code-line"> &nbsp;&nbsp;<span
								class="code-keyword">void</span> <span class="code-method">start</span>()
								{
							</span> <span class="code-line">
								&nbsp;&nbsp;&nbsp;&nbsp;CodeNext.<span class="code-method">enroll</span>();
							</span> <span class="code-line"> &nbsp;&nbsp;} </span> <span
								class="code-line">}</span>
						</div>
					</div>
				</div>

				<!-- STATS ROW -->
				<div class="about-stats">
					<div class="about-stat">
						<div class="about-stat-val">7+</div>
						<div class="about-stat-label">Courses</div>
					</div>
					<div class="about-stat">
						<div class="about-stat-val">150+</div>
						<div class="about-stat-label">Quiz Questions</div>
					</div>
					<div class="about-stat">
						<div class="about-stat-val">12</div>
						<div class="about-stat-label">Badges</div>
					</div>
					<div class="about-stat">
						<div class="about-stat-val">100%</div>
						<div class="about-stat-label">Free</div>
					</div>
				</div>

				<!-- WHAT WE OFFER -->
				<div class="about-section-title">🚀 What We Offer</div>
				<div class="about-features">
					<div class="about-feature-card">
						<div class="about-feature-icon">📚</div>
						<div class="about-feature-title">7 Courses</div>
						<div class="about-feature-desc">Learn Java, Python, HTML,
							CSS, JavaScript, Bootstrap and SQL with structured chapters.</div>
					</div>
					<div class="about-feature-card">
						<div class="about-feature-icon">🧠</div>
						<div class="about-feature-title">Quizzes</div>
						<div class="about-feature-desc">Test your knowledge with
							Easy, Medium and Hard questions. Earn points for every correct
							answer!</div>
					</div>
					<div class="about-feature-card">
						<div class="about-feature-icon">🏆</div>
						<div class="about-feature-title">Leaderboard</div>
						<div class="about-feature-desc">Compete with other learners.
							Climb the leaderboard by scoring high in quizzes!</div>
					</div>
					<div class="about-feature-card">
						<div class="about-feature-icon">🎖️</div>
						<div class="about-feature-title">Badges</div>
						<div class="about-feature-desc">Earn badges by completing
							courses, scoring 100% and maintaining daily streaks!</div>
					</div>
					<div class="about-feature-card">
						<div class="about-feature-icon">📜</div>
						<div class="about-feature-title">Certificates</div>
						<div class="about-feature-desc">Complete any course and get
							a certificate to showcase your skills!</div>
					</div>
					<div class="about-feature-card">
						<div class="about-feature-icon">🔒</div>
						<div class="about-feature-title">Secure</div>
						<div class="about-feature-desc">Your data is safe with us.
							Secure login system with session management.</div>
					</div>
				</div>

				<!-- TECH STACK -->
				<div class="about-section-title">🛠️ Built With</div>
				<div class="about-tech">
					<div class="tech-item">
						<div class="tech-icon" style="color: #ef4444">&#60;/&#62;</div>
						<div class="tech-name">HTML</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #3b82f6">{ }</div>
						<div class="tech-name">CSS</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #f59e0b">JS</div>
						<div class="tech-name">JavaScript</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #f97316">☕</div>
						<div class="tech-name">Java</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #00e5a0">JSP</div>
						<div class="tech-name">JSP</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #94a3b8">SRV</div>
						<div class="tech-name">Servlets</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #00758f">SQL</div>
						<div class="tech-name">MySQL</div>
					</div>
					<div class="tech-item">
						<div class="tech-icon" style="color: #ef4444">🐱</div>
						<div class="tech-name">Tomcat</div>
					</div>
				</div>

				<!-- DEVELOPER SECTION -->
				<div class="about-section-title">👨‍💻 About the Developer</div>
				<div class="about-dev-card">
					<div class="about-dev-avatar">SM</div>
					<div class="about-dev-info">
						<div class="about-dev-name">Sujal Maru</div>
						<div class="about-dev-role">Full Stack Java Developer ·
							Fresher</div>
						<div class="about-dev-desc">Built CodeNext,a full stack web
							application using Java,JSP,Servlets,JDBC and MySQL,featuring user
							authentication,dynamic data rendering and a responsive UI with
							HTML,CSS and JavaScript.</div>
						<div class="about-dev-links">
							<a href="mailto:dev.sujalmaru@gmail.com" class="dev-link"> 📧 dev.sujalmaru@gmail.com </a> 
							<a href="https://www.linkedin.com/in/sujalmaru0803/" class="dev-link"> 💼 LinkedIn </a> 
							<a href="https://github.com/Sujal-0803" class="dev-link"> 🐙 GitHub </a>
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
				<a href="contact.jsp" class="contact-btn"> Send Message </a>
			</div>
		</div>
		<div class="footer-bottom">
			&copy; 2026 CodeNext | <a href="about.jsp">About</a> &nbsp;|&nbsp; <a
				href="contact.jsp">Contact Us</a>
		</div>
	</footer>

</body>
</html>