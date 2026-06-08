package com.codenext.db;

import java.sql.*;

public class DBConnection {

    // ← THIS is what servlet calls
    public static Connection getConnection() throws Exception {

        com.mysql.cj.jdbc.Driver d = new com.mysql.cj.jdbc.Driver();
        DriverManager.registerDriver(d);

        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/codenext_db",
            "root",
            "Root@1234"  // ← your MySQL password
        );

        return conn;
    }
}