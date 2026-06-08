## 🚀 CodeNext — Developer Learning Platform

   A full-stack web application built with Java, JSP, Servlets, and MySQL for freshers and students to learn programming through structured tutorials, quizzes, and certifications.

## 📖 Overview

   CodeNext provides a structured learning experience through curated courses, coding challenges, project-based learning, and certification tracking. The platform aims to bridge the gap       between learning concepts and applying them in real-world development.

## ✨ Features

   - 🔐 User Authentication — Login, Register, Logout
   - 📚 Tutorials for 7 courses — Java, HTML, CSS, JavaScript, Bootstrap, Python, SQL & MySQL
   - 🧠 Quiz System with timer, difficulty levels and auto-submit
   - 🏆 Leaderboard to track and compare scores with other users
   - 📜 Certificate Generation — unlocked only after scoring 60% or more in quiz
   - 👤 User Profile with quiz history, badges, and certificates
   - ✏️ Edit profile name from profile page
   - 📊 Dashboard with progress and stats
   - 🎖️ Badge System for achievements
   - 🔒 Certificate locked until quiz is passed
  
## 🛠️ Tech Stack
 
   - **Frontend**: HTML5, CSS3, JavaScript, JSP (Java Server Pages)
   - **Backend**: Java, Servlets                     
   - **Database**: JDBC, MySQL                               
   - **Development Tools**: Eclipse IDE, Git & GitHub
   - **Server**:  Apache Tomcat                                   

## 📂 Project Structure            

CodeNext         
│                                                                                                                  
├── src/main/java                                         
│   ├── com.codenext.db                                               
│   └── com.codenext.servlet                                            
│       ├── ContactServlet.java                            
│       ├── LoginServlet.java                              
│       ├── LogoutServlet.java                        
│       ├── QuizServlet.java                       
│       └── RegisterServlet.java                    
│
├── src/main/webapp                                   
│   ├── img                                   
│   │   ├── development.jpg                                 
│   │   ├── team-work.jpg                                     
│   │   └── web-design.jpg                                     
│   │                                                        
│   ├── META-INF                                   
│   ├── WEB-INF                                                   
│   │                                                              
│   ├── about.css                                                    
│   ├── about.jsp                                                
│   ├── badges.css                                                     
│   ├── badges.jsp                                                           
│   ├── certificate.css                                                   
│   ├── certificate.jsp                                                
│   ├── contact.css                                                 
│   ├── contact.jsp                                                    
│   ├── dashboard.css                                                 
│   ├── dashboard.jsp                                                    
│   ├── index.jsp                                                  
│   ├── leaderboard.css                                          
│   ├── leaderboard.jsp                                           
│   ├── login.jsp                                                     
│   ├── profile.css                                              
│   ├── profile.jsp                                                
│   ├── quiz.css                                                      
│   ├── quiz.jsp                                                  
│   ├── quizresult.jsp                                                 
│   ├── register.jsp                                                          
│   ├── style.css                                                                 
│   ├── tutorial.css                                                    
│   ├── tutorial.jsp                                          
│   └── tutorials.jsp                                             
│                                                                    
├── Libraries                                                         
├── Referenced Libraries                                                        
└── build                                                           

## 🗄️ Database Tables

| Table | Description |
|------------------|--------------------------------------|
| users | User accounts, points, streak |
| courses | Course list with titles |
| quiz_questions | Questions with 4 options and difficulty |
| quiz_results | User quiz attempts, score, total |
| certificates | Issued certificates per user per course |
| badges | Badges earned by users |
| user_progress | Course progress tracking |
| contact_messages | Messages sent by users to admin |

## ⚙️ Setup Instructions

###  1. Clone the repository
  ```bash
   git clone https://github.com/Sujal-0803/CodeNext-Learning-Platform.git
   ```

### 2. Create the database

```sql
CREATE DATABASE codenext_db;
USE codenext_db;
```

### 3. Configure database connection

Open `src/com/codenext/db/DBConnection.java` and update:

```java
String url  = "jdbc:mysql://localhost:3306/codenext_db";
String user = "your_mysql_username";
String pass = "your_mysql_password";
```

### 4. Deploy on Tomcat

- Import project in Eclipse or IntelliJ IDEA                                                          
- Add Apache Tomcat 10+ server                                                                 
- Build and run the project    
   

## 🎯 Project Objectives

- Provide a centralized learning platform for developers.                 
- Encourage hands-on practice through coding challenges.                
- Help users follow structured learning roadmaps.               
- Enable project-based skill development.             
- Track learning progress efficiently.               

## 🚀 Future Enhancements

- Online Code Compiler.       
- Discussion Forum.                 
- AI-Powered Learning Recommendations.               
- Gamification & Badges.                 
- Course Video Integration.                       
- Mentor & Community Support.                
- Dark Mode.                

## 👨‍💻 Developer

 **Sujal Maru**

Passionate Java Full Stack Developer focused on building practical web applications and continuously learning new technologies.

- 📧 dev.sujalmaru@gmail.com
- 📞 +91 79728 91795
- 📍 Pune, Maharashtra, India
  
## 📄 License

This project is open source and free to use for learning and portfolio purposes.



> Built with by Sujal Maru | CodeNext 2026
