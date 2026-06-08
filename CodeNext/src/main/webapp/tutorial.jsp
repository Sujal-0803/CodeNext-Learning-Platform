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

// Get course parameter
String course = request.getParameter("course");
if (course == null)
	course = "html";

// Set course details based on parameter
String courseTitle = "";
String courseDesc = "";
String courseIcon = "";
String courseColor = "";
int courseId = 1;

switch (course.toLowerCase()) {
	case "html" :
		courseTitle = "HTML";
		courseDesc = "Learn the building blocks of web pages";
		courseIcon = "&#60;/&#62;";
		courseColor = "#ef4444";
		courseId = 1;
		break;
	case "css" :
		courseTitle = "CSS";
		courseDesc = "Style your web pages beautifully";
		courseIcon = "{ }";
		courseColor = "#3b82f6";
		courseId = 2;
		break;
	case "javascript" :
		courseTitle = "JavaScript";
		courseDesc = "Make your websites interactive";
		courseIcon = "JS";
		courseColor = "#f59e0b";
		courseId = 3;
		break;
	case "python" :
		courseTitle = "Python";
		courseDesc = "Learn Python from basics to advanced";
		courseIcon = "Py";
		courseColor = "#7c3aed";
		courseId = 4;
		break;
	case "bootstrap" :
		courseTitle = "Bootstrap";
		courseDesc = "Build responsive websites faster";
		courseIcon = "BS";
		courseColor = "#8b5cf6";
		courseId = 5;
		break;
	case "sql" :
		courseTitle = "SQL & MySQL";
		courseDesc = "Master databases with SQL";
		courseIcon = "SQL";
		courseColor = "#14b8a6";
		courseId = 6;
		break;
	case "java" :
		courseTitle = "Java";
		courseDesc = "Learn Core Java programming";
		courseIcon = "&#9749;";
		courseColor = "#f97316";
		courseId = 7;
		break;
	default :
		courseTitle = "HTML";
		courseIcon = "&#60;/&#62;";
		courseColor = "#ef4444";
		courseId = 1;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeNext | <%=courseTitle%></title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="dashboard.css">
<link rel="stylesheet" href="tutorial.css">
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
		<a href="tutorials.jsp" class="active">Tutorials</a> 
		<a href="quiz.jsp">Quiz</a>
		<a href="leaderboard.jsp">Leaderboard</a>
	</nav>

	<!-- MAIN LAYOUT -->
	<div class="dash-layout">

		<!-- SIDEBAR -->
		<aside class="sidebar">
			<h2>All Courses</h2>
			<ul>
				<li><a href="tutorial.jsp?course=java"
					<%=course.equals("java") ? "class='active'" : ""%>> Java
						Tutorial</a></li>
				<li><a href="tutorial.jsp?course=html"
					<%=course.equals("html") ? "class='active'" : ""%>> HTML
						Tutorial</a></li>
				<li><a href="tutorial.jsp?course=css"
					<%=course.equals("css") ? "class='active'" : ""%>> CSS Tutorial</a></li>
				<li><a href="tutorial.jsp?course=javascript"
					<%=course.equals("javascript") ? "class='active'" : ""%>>
						JavaScript Tutorial</a></li>
				<li><a href="tutorial.jsp?course=bootstrap"
					<%=course.equals("bootstrap") ? "class='active'" : ""%>>
						Bootstrap Tutorial</a></li>
				<li><a href="tutorial.jsp?course=python"
					<%=course.equals("python") ? "class='active'" : ""%>> Python
						Tutorial</a></li>
				<li><a href="tutorial.jsp?course=sql"
					<%=course.equals("sql") ? "class='active'" : ""%>> SQL & MySQL</a></li>
			</ul>
		</aside>

		<!-- TUTORIAL CONTENT -->
		<main class="dash-main">

			<!-- COURSE HEADER -->
			<div class="tut-course-header"
				style="border-color:<%=courseColor%>20">
				<div class="tut-course-icon" style="color:<%=courseColor%>">
					<%=courseIcon%>
				</div>
				<div class="tut-course-info">
					<div class="tut-course-title">
						<%=courseTitle%>
					</div>
					<div class="tut-course-desc">
						<%=courseDesc%>
					</div>
					<div class="tut-course-meta">
						<span class="tut-meta-item"> 📖 Multiple Chapters </span> <span
							class="tut-meta-item"> 🎯 Beginner Friendly </span> <span
							class="tut-meta-item"> 🆓 Free Course </span>
					</div>
				</div>
				<a href="quiz.jsp?course_id=<%=courseId%>" class="tut-quiz-btn"
					style="background:<%=courseColor%>20;
                          color:<%=courseColor%>;
                          border-color:<%=courseColor%>40">
					Take Quiz → </a>
			</div>

			<!-- TUTORIAL CHAPTERS -->
			<div class="tut-layout">

				<!-- CHAPTERS LIST -->
				<div class="tut-chapters">
					<div class="tut-chapters-title">📚 Chapters</div>

					<%-- HTML Chapters --%>
					<%
					if (course.equals("html")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">
							Introduction to HTML </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">HTML
							Tags</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title"> HTML
							Attributes </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title">HTML
							Forms</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">HTML
							Tables</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title">HTML
							Links</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch7')">
						<span class="ch-num">07</span> <span class="ch-title">HTML
							Images</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch8')">
						<span class="ch-num">08</span> <span class="ch-title">HTML
							Lists</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch9')">
						<span class="ch-num">09</span> <span class="ch-title">HTML5
							Elements</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch10')">
						<span class="ch-num">10</span> <span class="ch-title"> HTML
							Best Practices </span>
					</div>
					<%
					}
					%>

					<%-- CSS Chapters --%>
					<%
					if (course.equals("css")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">
							Introduction to CSS </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">CSS
							Selectors</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title">CSS
							Box Model</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title">CSS
							Flexbox</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">CSS
							Grid</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title"> CSS
							Animations </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch7')">
						<span class="ch-num">07</span> <span class="ch-title"> CSS
							Responsive Design </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch8')">
						<span class="ch-num">08</span> <span class="ch-title"> CSS
							Best Practices </span>
					</div>
					<%
					}
					%>

					<%-- JavaScript Chapters --%>
					<%
					if (course.equals("javascript")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">Intro
							to JS</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">
							Variables & Data Types </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title">Functions</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title">
							Arrays & Objects </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">DOM
							Manipulation</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title">Events</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch7')">
						<span class="ch-num">07</span> <span class="ch-title"> ES6+
							Features </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch8')">
						<span class="ch-num">08</span> <span class="ch-title">
							Async JavaScript </span>
					</div>
					<%
					}
					%>

					<%-- Python Chapters --%>
					<%
					if (course.equals("python")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">
							Introduction to Python </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">
							Variables & Data Types </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title">
							Control Flow </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title">Functions</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">
							Lists & Tuples </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title">
							Dictionaries & Sets </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch7')">
						<span class="ch-num">07</span> <span class="ch-title">OOP
							in Python</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch8')">
						<span class="ch-num">08</span> <span class="ch-title"> File
							Handling </span>
					</div>
					<%
					}
					%>

					<%-- Java Chapters --%>
					<%
					if (course.equals("java")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">
							Introduction to Java </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">
							Variables & Data Types </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title">
							Control Statements </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title"> OOP
							Concepts </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">
							Inheritance </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title">
							Exception Handling </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch7')">
						<span class="ch-num">07</span> <span class="ch-title">Collections</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch8')">
						<span class="ch-num">08</span> <span class="ch-title">JDBC</span>
					</div>
					<%
					}
					%>

					<%-- Bootstrap Chapters --%>
					<%
					if (course.equals("bootstrap")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">
							Introduction to Bootstrap </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">Grid
							System</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title">Components</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title">
							Bootstrap Forms </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">
							Bootstrap Navbar </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title">Utilities</span>
					</div>
					<%
					}
					%>

					<%-- SQL Chapters --%>
					<%
					if (course.equals("sql")) {
					%>
					<div class="chapter-item active-chapter"
						onclick="showChapter('ch1')">
						<span class="ch-num">01</span> <span class="ch-title">
							Introduction to SQL </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch2')">
						<span class="ch-num">02</span> <span class="ch-title">
							CREATE & INSERT </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch3')">
						<span class="ch-num">03</span> <span class="ch-title">SELECT
							Queries</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch4')">
						<span class="ch-num">04</span> <span class="ch-title">
							WHERE & Filters </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch5')">
						<span class="ch-num">05</span> <span class="ch-title">JOIN
							Queries</span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch6')">
						<span class="ch-num">06</span> <span class="ch-title">
							Aggregate Functions </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch7')">
						<span class="ch-num">07</span> <span class="ch-title">
							UPDATE & DELETE </span>
					</div>
					<div class="chapter-item" onclick="showChapter('ch8')">
						<span class="ch-num">08</span> <span class="ch-title">
							MySQL with Java </span>
					</div>
					<%
					}
					%>

				</div>

				<!-- CHAPTER CONTENT -->
				<div class="tut-content">

					<!-- Chapter 1 — shown by default -->
					<div id="ch1" class="chapter-content active-content">
						<div class="ch-content-title">Chapter 01 — Introduction</div>
						<div class="ch-content-body">

							<div class="ch-section">
								<div class="ch-section-title">
									📌 What is
									<%=courseTitle%>?
								</div>
								<div class="ch-section-text">
									<%
									if (course.equals("html")) {
									%>
									HTML stands for HyperText Markup Language. It is the standard
									language used to create and structure content on the web. Every
									webpage you visit is built using HTML. HTML uses elements
									represented by tags to define different parts of a webpage.
									<%
									} else if (course.equals("css")) {
									%>
									CSS stands for Cascading Style Sheets. It is used to style and
									layout web pages — for example, to change the font, color,
									size, and spacing of your content. CSS makes your HTML look
									beautiful!
									<%
									} else if (course.equals("javascript")) {
									%>
									JavaScript is a lightweight, interpreted programming language
									that runs in the browser. It makes web pages interactive and
									dynamic. JavaScript is one of the core technologies of the
									World Wide Web.
									<%
									} else if (course.equals("python")) {
									%>
									Python is a high-level, general-purpose programming language
									known for its simple and readable syntax. It is widely used in
									web development, data science, AI, and automation.
									<%
									} else if (course.equals("java")) {
									%>
									Java is a high-level, class-based, object-oriented programming
									language. It follows the principle of "Write Once, Run
									Anywhere" (WORA). Java is widely used in enterprise
									applications, Android development, and web development.
									<%
									} else if (course.equals("bootstrap")) {
									%>
									Bootstrap is a free and open-source CSS framework used to build
									responsive and mobile-first websites quickly. It provides
									ready-made components like buttons, navbars, cards and grids.
									<%
									} else if (course.equals("sql")) {
									%>
									SQL stands for Structured Query Language. It is used to
									communicate with databases. SQL allows you to create, read,
									update and delete data in a relational database like MySQL,
									PostgreSQL, or SQLite.
									<%
									}
									%>
								</div>
							</div>

							<div class="ch-section">
								<div class="ch-section-title">
									💡 Why Learn
									<%=courseTitle%>?
								</div>
								<div class="ch-section-text">
									<%
									if (course.equals("html")) {
									%>
									HTML is the foundation of web development. Without HTML there
									is no webpage. Every web developer must know HTML. It is easy
									to learn and is the first step toward becoming a web developer.
									<%
									} else if (course.equals("css")) {
									%>
									Without CSS all websites would look plain and unstyled. CSS
									gives you the power to create beautiful, professional-looking
									websites. It is essential for any frontend developer.
									<%
									} else if (course.equals("javascript")) {
									%>
									JavaScript brings websites to life! Without JS, websites are
									just static pages. JS enables animations, form validations, API
									calls, and interactive UIs. It is the most popular programming
									language.
									<%
									} else if (course.equals("python")) {
									%>
									Python is the most beginner-friendly language. It is used in
									almost every field — web development, AI, data science,
									automation, and scripting. Python developers are highly in
									demand!
									<%
									} else if (course.equals("java")) {
									%>
									Java powers billions of devices worldwide. It is used for
									enterprise applications, Android apps, web backends, and more.
									Java knowledge opens doors to many high-paying job
									opportunities!
									<%
									} else if (course.equals("bootstrap")) {
									%>
									Bootstrap saves you hours of CSS work. With Bootstrap you can
									build professional responsive websites in minutes. It is used
									by millions of developers worldwide and by major companies!
									<%
									} else if (course.equals("sql")) {
									%>
									Every application needs a database. SQL is the universal
									language for talking to databases. Whether you are a backend
									developer, data analyst, or DBA — SQL is a must-have skill!
									<%
									}
									%>
								</div>
							</div>

							<div class="ch-section">
								<div class="ch-section-title">✏️ Your First Code</div>
								<div class="ch-code-block">
									<%
									if (course.equals("html")) {
									%>
									<pre>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
    &lt;title&gt;My First Page&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;h1&gt;Hello, World!&lt;/h1&gt;
    &lt;p&gt;Welcome to HTML!&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
									<%
									} else if (course.equals("css")) {
									%>
									<pre>
body {
    background-color: #0d1117;
    color: #00e5a0;
    font-family: monospace;
}

h1 {
    font-size: 32px;
    text-align: center;
}
</pre>
									<%
									} else if (course.equals("javascript")) {
									%>
									<pre>
// Variables
let name = "CodeNext";
const version = 1;

// Function
function greet(name) {
    return "Hello, " + name + "!";
}

// Output
console.log(greet(name));
</pre>
									<%
									} else if (course.equals("python")) {
									%>
									<pre>
# Your first Python program
name = "CodeNext"
print("Hello,", name)

# Function
def greet(name):
    return f"Welcome to {name}!"

print(greet("Python"))
</pre>
									<%
									} else if (course.equals("java")) {
									%>
									<pre>
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        System.out.println("Welcome to Java!");
    }
}
</pre>
									<%
									} else if (course.equals("bootstrap")) {
									%>
									<pre>
&lt;!-- Bootstrap CDN --&gt;
&lt;link href="https://cdn.jsdelivr.net/
npm/bootstrap@5.3.0/dist/css/
bootstrap.min.css" rel="stylesheet"&gt;

&lt;!-- Bootstrap Button --&gt;
&lt;button class="btn btn-primary"&gt;
    Click Me!
&lt;/button&gt;
</pre>
									<%
									} else if (course.equals("sql")) {
									%>
									<pre>
-- Create a database
CREATE DATABASE mydb;

-- Use the database
USE mydb;

-- Create a table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);
</pre>
									<%
									}
									%>
								</div>
							</div>

						</div>

						<!-- NAVIGATION BUTTONS -->
						<div class="ch-nav-btns">
							<div></div>
							<button class="ch-next-btn" onclick="showChapter('ch2')">
								Next Chapter →</button>
						</div>
					</div>

					<!-- Chapter 2 -->
					<div id="ch2" class="chapter-content">
						<div class="ch-content-title">Chapter 02</div>
						<div class="ch-content-body">
							<div class="ch-section">
								<div class="ch-section-title">📌 Chapter 2 Content</div>
								<div class="ch-section-text">
									This chapter covers the next important concepts of
									<%=courseTitle%>. Keep learning and practicing!
								</div>
							</div>
							<div class="ch-section">
								<div class="ch-section-title">🧠 Key Points</div>
								<div class="ch-section-text">
									• Practice every day<br> • Build small projects<br> •
									Take the quiz after each chapter<br> • Check leaderboard
									to track progress
								</div>
							</div>
						</div>
						<div class="ch-nav-btns">
							<button class="ch-prev-btn" onclick="showChapter('ch1')">
								← Previous</button>
							<button class="ch-next-btn" onclick="showChapter('ch3')">
								Next Chapter →</button>
						</div>
					</div>

					<!-- Chapter 3 onwards — generic -->
					<%
					for (int i = 3; i <= 10; i++) {
					%>
					<div id="ch<%=i%>" class="chapter-content">
						<div class="ch-content-title">
							Chapter 0<%=i%>
						</div>
						<div class="ch-content-body">
							<div class="ch-section">
								<div class="ch-section-title">
									📌 Chapter
									<%=i%>
									Content
								</div>
								<div class="ch-section-text">
									Continue learning
									<%=courseTitle%>
									— Chapter
									<%=i%>
									content covers advanced topics. Practice the examples and take
									the quiz to earn points!
								</div>
							</div>
							<div class="ch-section">
								<div class="ch-section-title">💡 Pro Tip</div>
								<div class="ch-section-text">The best way to learn
									programming is by doing! Try to write code every day and build
									real projects.</div>
							</div>
						</div>
						<div class="ch-nav-btns">
							<button class="ch-prev-btn" onclick="showChapter('ch<%=i - 1%>')">
								← Previous</button>
							<%
							if (i < 10) {
							%>
							<button class="ch-next-btn" onclick="showChapter('ch<%=i + 1%>')">
								Next Chapter →</button>
							<%
							} else {
							%>
							<div style="display:flex;gap:10px">
								<a href="quiz.jsp?course_id=<%=courseId%>"
								   class="ch-next-btn"
								   style="background:transparent;
								          color:#00e5a0;
								          border:1px solid #00e5a0">
									Take Quiz →
								</a>
								<a href="certificate.jsp?course_id=<%=courseId%>"
								   class="ch-next-btn">
									Get Certificate 📜
								</a>
							</div>
							<%
							}
							%>
						</div>
					</div>
					<%
					}
					%>

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

	<script>
        function showChapter(id) {
            // Hide all chapters
            document.querySelectorAll('.chapter-content')
                .forEach(c => c.classList.remove('active-content'));

            // Remove active from all chapter items
            document.querySelectorAll('.chapter-item')
                .forEach(c => c.classList.remove('active-chapter'));

            // Show selected chapter
            document.getElementById(id)
                .classList.add('active-content');

            // Get chapter number
            const num = parseInt(id.replace('ch',''));

            // Highlight active chapter in list
            document.querySelectorAll('.chapter-item')
                [num-1].classList.add('active-chapter');

            // Scroll to top of content
            document.querySelector('.tut-content')
                .scrollTop = 0;
        }
    </script>

</body>
</html>