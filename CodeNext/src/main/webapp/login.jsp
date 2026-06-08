<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeNext | Login</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="login.css">
</head>
<body>

    <!-- HEADER -->
    <header class="header">
        <div class="logo">CodeNext</div>
        <div class="header-right">
            <a href="index.jsp" class="login-btn">← Back to Home</a>
        </div>
    </header>

    <!-- LOGIN WRAPPER -->
    <div class="auth-wrapper">

        <!-- LEFT SIDE -->
        <div class="auth-left">
            <div class="auth-brand">
                <h1>&lt;CodeNext/&gt;</h1>
                <p>Your Developer Learning Portal</p>
            </div>
            <div class="auth-features">
                <div class="auth-feature-item">
                    <span class="feature-icon">🚀</span>
                    <span>Learn Java, Python, HTML, CSS & more</span>
                </div>
                <div class="auth-feature-item">
                    <span class="feature-icon">🧠</span>
                    <span>Take quizzes and test your skills</span>
                </div>
                <div class="auth-feature-item">
                    <span class="feature-icon">🏆</span>
                    <span>Compete on leaderboard & earn badges</span>
                </div>
                <div class="auth-feature-item">
                    <span class="feature-icon">📜</span>
                    <span>Get certificates on course completion</span>
                </div>
            </div>
        </div>

        <!-- RIGHT SIDE - FORM -->
        <div class="auth-right">

            <!-- TAB BUTTONS -->
            <div class="auth-tabs">
                <button class="tab-btn active" onclick="showTab('login')">Login</button>
                <button class="tab-btn" onclick="showTab('register')">Register</button>
            </div>

            <!-- ERROR / SUCCESS MESSAGE -->
            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
            %>
            <% if(error != null) { %>
                <div class="auth-msg error"><%= error %></div>
            <% } %>
            <% if(success != null) { %>
                <div class="auth-msg success"><%= success %></div>
            <% } %>

            <!-- LOGIN FORM -->
            <div id="login-form" class="auth-form active">
                <h2 class="form-title">Welcome Back 👋</h2>
                <p class="form-sub">Login to continue your journey</p>

                <form action="LoginServlet" method="post">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email"
                               placeholder="you@email.com" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password"
                               placeholder="••••••••" required>
                    </div>
                    <button type="submit" class="auth-btn">
                        Login →
                    </button>
                </form>

                <p class="form-switch">
                    Don't have an account?
                    <a href="#" onclick="showTab('register')">Register here</a>
                </p>
            </div>

            <!-- REGISTER FORM -->
            <div id="register-form" class="auth-form">
                <h2 class="form-title">Create Account 🎯</h2>
                <p class="form-sub">Join CodeNext and start learning today</p>

                <form action="RegisterServlet" method="post">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="fullname"
                               placeholder="Your full name" required>
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email"
                               placeholder="you@email.com" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password"
                               placeholder="Min 6 characters" required>
                    </div>
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <input type="password" name="confirmpassword"
                               placeholder="Repeat password" required>
                    </div>
                    <button type="submit" class="auth-btn">
                        Create Account →
                    </button>
                </form>

                <p class="form-switch">
                    Already have an account?
                    <a href="#" onclick="showTab('login')">Login here</a>
                </p>
            </div>

        </div>
    </div>

    <script>
        function showTab(tab) {
            // hide all forms
            document.querySelectorAll('.auth-form').forEach(f => {
                f.classList.remove('active');
            });
            // remove active from all tabs
            document.querySelectorAll('.tab-btn').forEach(b => {
                b.classList.remove('active');
            });
            // show selected
            document.getElementById(tab + '-form').classList.add('active');
            // activate button
            event.target.classList.add('active');
        }
    </script>

</body>
</html>