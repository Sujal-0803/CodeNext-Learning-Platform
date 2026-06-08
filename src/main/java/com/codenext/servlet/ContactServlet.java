package com.codenext.servlet;

import com.codenext.db.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {
        response.sendRedirect("contact.jsp");
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        // Get form data
        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Get logged in user id
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("userId");

        try {
            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO contact_messages " +
                "(user_id, name, email, subject, message) " +
                "VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1,    userId);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, subject);
            ps.setString(5, message);
            ps.executeUpdate();

            conn.close();

            request.setAttribute("success",
                "Message sent successfully! " +
                "We will reply within 24 hours.");
            request.getRequestDispatcher("contact.jsp")
                   .forward(request, response);

        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error",
                "Something went wrong. Please try again!");
            request.getRequestDispatcher("contact.jsp")
                   .forward(request, response);
        }
    }
}