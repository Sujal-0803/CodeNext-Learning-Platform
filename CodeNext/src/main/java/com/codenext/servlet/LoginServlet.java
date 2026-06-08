package com.codenext.servlet;

import com.codenext.db.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	// ← ADD THIS METHOD
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	// ← YOUR EXISTING METHOD
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			Connection conn = DBConnection.getConnection();

			String sql = "SELECT * FROM users WHERE email = ? " + "AND password = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("userId", rs.getInt("id"));
				session.setAttribute("userName", rs.getString("full_name"));
				session.setAttribute("userEmail", rs.getString("email"));

				conn.close();
				response.sendRedirect("dashboard.jsp");

			} else {
				conn.close();
				request.setAttribute("error", "Invalid email or password. Try again!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Something went wrong: " + e.getMessage());
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}