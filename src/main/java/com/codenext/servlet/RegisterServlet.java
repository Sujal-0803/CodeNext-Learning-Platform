package com.codenext.servlet;

import com.codenext.db.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    // ← ADD THIS METHOD
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    // ← YOUR EXISTING METHOD
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String fullname        = request.getParameter("fullname");
        String email           = request.getParameter("email");
        String password        = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");

        if (!password.equals(confirmpassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();

            String checkSql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("error",
                    "Email already registered! Please login.");
                request.getRequestDispatcher("login.jsp")
                       .forward(request, response);
                return;
            }

            String sql = "INSERT INTO users (full_name, email, password) " +
                         "VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.executeUpdate();

            conn.close();

            request.setAttribute("success",
                "Account created successfully! Please login.");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error",
                "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }
}