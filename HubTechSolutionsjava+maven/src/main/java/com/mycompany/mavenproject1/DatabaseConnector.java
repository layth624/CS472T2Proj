package com.mycompany.mavenproject1;

import java.sql.*;

public class DatabaseConnector {
    private static final String url = "jdbc:mysql://sql3.freemysqlhosting.net:3306/sql3694994";
    private static final String user = "sql3694994";
    private static final String password = "2kWe65rRuQ";

    // Method to establish a database connection
    public Connection connect() throws SQLException, ClassNotFoundException {
        // Explicitly loading the MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }

    public String fetchAdminData() {
        StringBuilder builder = new StringBuilder();
        try (Connection conn = connect()) {
            String sql = "SELECT * FROM Admin";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    int AdminID = rs.getInt("AdminID");
                    String Name = rs.getString("Name");
                    builder.append("ID: ").append(AdminID).append(", Name: ").append(Name).append("<br>");
                }
            }
        } catch (SQLException e) {
            builder.append("Error executing query: ").append(e.getMessage());
        } catch (ClassNotFoundException e) {
            builder.append("Driver not found: ").append(e.getMessage());
        }
        return builder.toString();
    }
}
