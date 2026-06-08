<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeNext | Developer Learning Portal</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

    <!-- HEADER -->
    <header class="header">
        <div class="logo">CodeNext</div>
        <div class="header-right">
            <a href="login.jsp" class="login-btn">Login</a>
        </div>
    </header>

    <!-- NAVBAR -->
    <nav class="menubar">
        <a href="index.jsp" class="active">Home</a>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="tutorials.jsp">Tutorials</a>
        <a href="quiz.jsp">Quiz</a>
        <a href="leaderboard.jsp">Leaderboard</a>
    </nav>

    <!-- MAIN CONTAINER -->
    <div class="container">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <h2>Sidebar Menu</h2>
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

        <!-- MAIN CONTENT -->
        <main class="content">

            <!-- CARD 1 -->
            <div class="box">
                <img src="img/web-design.jpg" alt="Web Design">
                <div class="box-content">
                    <h3>Web Design</h3>
                    <p>Learn modern website design using HTML and CSS with responsive layouts.</p>
                </div>
            </div>

            <!-- CARD 2 -->
            <div class="box">
                <img src="img/development.jpg" alt="Development">
                <div class="box-content">
                    <h3>Development</h3>
                    <p>Build professional websites and improve frontend development skills.</p>
                </div>
            </div>

            <!-- CARD 3 -->
            <div class="box">
                <img src="img/team-work.jpg" alt="Team Work">
                <div class="box-content">
                    <h3>Team Work</h3>
                    <p>Collaborate with teams and create innovative web solutions for users.</p>
                </div>
            </div>
            
            <!-- JOIN NOW SECTION -->
            <div class="join-section">
                <h2>Start Your Learning Journey Today! 🚀</h2>
                <p>Join CodeNext and learn Java, Python, HTML, CSS and more</p>
                <a href="login.jsp" class="join-btn">Join Now — It's Free!</a>
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
            &copy; 2026 CodeNext |
            <a href="about.jsp">About</a> &nbsp;|&nbsp;
            <a href="contact.jsp">Contact Us</a>
        </div>
    </footer>

</body>
</html>