<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    // Retrieve form data
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phoneNumber");
    String dob = request.getParameter("dob");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Establish database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Insert new user into the database
    String query = "INSERT INTO Users (Name, Address, Email, PhoneNumber, Dob, Username, Password) VALUES (?, ?, ?, ?, ?, ?, ?)";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, name);
        pstmt.setString(2, address);
        pstmt.setString(3, email);
        pstmt.setString(4, phoneNumber);
        pstmt.setString(5, dob);
        pstmt.setString(6, username);
        pstmt.setString(7, password);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Close the database connection
    conn.close();

    // Redirect back to adminManageUsers.jsp after adding the user
    response.sendRedirect("adminManageUsers.jsp");
%>
