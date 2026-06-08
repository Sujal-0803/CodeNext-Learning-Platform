package com.codenext.servlet;

import com.codenext.db.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {
        response.sendRedirect("quiz.jsp");
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int userId   = (int) session.getAttribute("userId");
        int courseId = Integer.parseInt(
                           request.getParameter("course_id"));

        String[] qIds = request.getParameterValues("q_ids");

        int score = 0;
        int total = qIds != null ? qIds.length : 0;

        if(qIds != null) {
            for(String qId : qIds) {
                String userAnswer =
                    request.getParameter("answer_" + qId);
                String correctAnswer =
                    request.getParameter("correct_" + qId);
                if(userAnswer != null &&
                   userAnswer.equals(correctAnswer)) {
                    score += 20;
                }
            }
        }

        // Bonus for perfect score
        int bonus      = (score == total * 20) ? 30 : 0;
        int totalScore = score + bonus;

        try {
            Connection conn = DBConnection.getConnection();

            // ── Save quiz result ──
            PreparedStatement ps1 = conn.prepareStatement(
                "INSERT INTO quiz_results " +
                "(user_id, course_id, score, total) " +
                "VALUES (?, ?, ?, ?)");
            ps1.setInt(1, userId);
            ps1.setInt(2, courseId);
            ps1.setInt(3, score);
            ps1.setInt(4, total * 20);
            ps1.executeUpdate();

            // ── Update user total points ──
            PreparedStatement ps2 = conn.prepareStatement(
                "UPDATE users SET total_points = " +
                "total_points + ? WHERE id = ?");
            ps2.setInt(1, totalScore);
            ps2.setInt(2, userId);
            ps2.executeUpdate();

            // ── Award badges ──
            awardBadges(conn, userId, courseId,
                        score, total * 20);

            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("score",      score);
        request.setAttribute("total",      total * 20);
        request.setAttribute("bonus",      bonus);
        request.setAttribute("totalScore", totalScore);
        request.setAttribute("courseId",   courseId);
        request.getRequestDispatcher("quizresult.jsp")
               .forward(request, response);
    }

    // ── Badge Awarding Method ──
    private void awardBadges(Connection conn,
                             int userId,
                             int courseId,
                             int score,
                             int total) throws Exception {

        // Award Quiz Star badge for 100% score
        if(score == total) {
            awardBadge(conn, userId, "Quiz Star");
        }

        // Award course badge based on course
        String courseBadge = "";
        switch(courseId) {
            case 1: courseBadge = "HTML Master";    break;
            case 2: courseBadge = "CSS Pro";        break;
            case 3: courseBadge = "JS Ninja";       break;
            case 4: courseBadge = "Python Expert";  break;
            case 5: courseBadge = "Bootstrap Pro";  break;
            case 6: courseBadge = "SQL Master";     break;
            case 7: courseBadge = "Java Guru";      break;
        }

        // Award course badge if score >= 60%
        int percentage = total > 0 ?
                         (score * 100) / total : 0;
        if(percentage >= 60 && !courseBadge.isEmpty()) {
            awardBadge(conn, userId, courseBadge);
        }

        // Check total quizzes for Fast Learner badge
        PreparedStatement psCount = conn.prepareStatement(
            "SELECT COUNT(*) FROM quiz_results " +
            "WHERE user_id = ?");
        psCount.setInt(1, userId);
        ResultSet rsCount = psCount.executeQuery();
        if(rsCount.next() && rsCount.getInt(1) >= 5) {
            awardBadge(conn, userId, "Fast Learner");
        }

        // Check rank for Top 3 badge
        PreparedStatement psRank = conn.prepareStatement(
            "SELECT COUNT(*) + 1 as rank FROM users " +
            "WHERE total_points > " +
            "(SELECT total_points FROM users WHERE id = ?)");
        psRank.setInt(1, userId);
        ResultSet rsRank = psRank.executeQuery();
        if(rsRank.next() && rsRank.getInt("rank") <= 3) {
            awardBadge(conn, userId, "Top 3 Rank");
        }
    }

    // ── Award single badge if not already earned ──
    private void awardBadge(Connection conn,
                            int userId,
                            String badgeName) throws Exception {

        // Check if badge already exists
        PreparedStatement psCheck = conn.prepareStatement(
            "SELECT id FROM badges " +
            "WHERE user_id = ? AND badge_name = ?");
        psCheck.setInt(1, userId);
        psCheck.setString(2, badgeName);
        ResultSet rsCheck = psCheck.executeQuery();

        // Only insert if not already earned
        if(!rsCheck.next()) {
            PreparedStatement psInsert = conn.prepareStatement(
                "INSERT INTO badges (user_id, badge_name) " +
                "VALUES (?, ?)");
            psInsert.setInt(1, userId);
            psInsert.setString(2, badgeName);
            psInsert.executeUpdate();
        }
    }
}