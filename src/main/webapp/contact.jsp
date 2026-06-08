<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- SESSION CHECK - Only logged in users can contact --%>
<%
HttpSession userSession = request.getSession(false);
if (userSession == null || userSession.getAttribute("userId") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String userName = (String) userSession.getAttribute("userName");
String userEmail = (String) userSession.getAttribute("userEmail");
int userId = (int) userSession.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeNext | Contact Us</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="dashboard.css">
<link rel="stylesheet" href="contact.css">
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
		<a href="index.jsp">Home</a> <a href="dashboard.jsp">Dashboard</a> <a
			href="tutorials.jsp">Tutorials</a> <a href="quiz.jsp">Quiz</a> <a
			href="leaderboard.jsp">Leaderboard</a>
	</nav>

	<div class="contact-full">
		<main class="contact-main">

			<!-- CONTACT CONTENT -->
			<main class="dash-main">

				<!-- PAGE HEADER -->
				<div class="page-header">
					<div>
						<div class="page-title">📬 Contact Us</div>
						<div class="page-sub">Have a question? We'd love to hear
							from you!</div>
					</div>
				</div>

				<!-- CONTACT GRID -->
				<div class="contact-grid">

					<!-- LEFT — CONTACT FORM -->
					<div class="contact-form-card">
						<div class="contact-form-title">Send us a Message</div>

						<%
						String successMsg = (String) request.getAttribute("success");
						String errorMsg = (String) request.getAttribute("error");
						%>

						<%
						if (successMsg != null) {
						%>
						<div class="contact-msg success">
							✅
							<%=successMsg%>
						</div>
						<%
						}
						%>

						<%
						if (errorMsg != null) {
						%>
						<div class="contact-msg error">
							❌
							<%=errorMsg%>
						</div>
						<%
						}
						%>

						<form action="ContactServlet" method="post">

							<%-- Auto fill name and email from session --%>
							<div class="contact-form-group">
								<label>Full Name</label> <input type="text" name="name"
									value="<%=userName%>" placeholder="Your full name" required>
							</div>
							<div class="contact-form-group">
								<label>Email Address</label> <input type="email" name="email"
									value="<%=userEmail%>" placeholder="you@email.com" required>
							</div>
							<div class="contact-form-group">
								<label>Subject</label> <input type="text" name="subject"
									placeholder="What is this about?" required>
							</div>
							<div class="contact-form-group">
								<label>Message</label>
								<textarea name="message" rows="5"
									placeholder="Write your message here..." required></textarea>
							</div>
							<button type="submit" class="contact-submit-btn">Send
								Message →</button>
						</form>
					</div>

					<!-- RIGHT — CONTACT INFO -->
					<div class="contact-info-side">

						<div class="contact-info-card">
							<div class="contact-info-icon">📧</div>
							<div>
								<div class="contact-info-label">Email Us</div>
								<div class="contact-info-val">dev.sujalmaru@gmail.com</div>
							</div>
						</div>

						<div class="contact-info-card">
							<div class="contact-info-icon">📞</div>
							<div>
								<div class="contact-info-label">Call Us</div>
								<div class="contact-info-val">+91 79728 91795</div>
							</div>
						</div>

						<div class="contact-info-card">
							<div class="contact-info-icon">📍</div>
							<div>
								<div class="contact-info-label">Location</div>
								<div class="contact-info-val">Pune, Maharashtra, India</div>
							</div>
						</div>

						<div class="contact-info-card">
							<div class="contact-info-icon">⏰</div>
							<div>
								<div class="contact-info-label">Working Hours</div>
								<div class="contact-info-val">Mon - Fri: 9AM to 6PM</div>
							</div>
						</div>

						<!-- SOCIAL LINKS -->
						<div class="contact-social">
							<div class="contact-social-title">Follow Us</div>
							<div class="contact-social-links">
								<a href="https://github.com/Sujal-0803" class="contact-social-btn"> 🐙 GitHub </a> 
								<a href="https://www.instagram.com/sujalll._24" class="contact-social-btn"> 📸 Instagram </a> 
								<a href="https://www.linkedin.com/in/sujalmaru0803/" class="contact-social-btn"> 💼 LinkedIn </a>
							</div>
						</div>

						<!-- FAQ -->
						<div class="contact-faq">
							<div class="contact-faq-title">❓ Quick FAQ</div>
							<div class="faq-item">
								<div class="faq-q">Is CodeNext free?</div>
								<div class="faq-a">Yes! CodeNext is completely free for
									all students.</div>
							</div>
							<div class="faq-item">
								<div class="faq-q">How do I earn badges?</div>
								<div class="faq-a">Complete courses and score high in
									quizzes to earn badges.</div>
							</div>
							<div class="faq-item">
								<div class="faq-q">Can I get a certificate?</div>
								<div class="faq-a">Yes! Complete any course to get your
									certificate.</div>
							</div>
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