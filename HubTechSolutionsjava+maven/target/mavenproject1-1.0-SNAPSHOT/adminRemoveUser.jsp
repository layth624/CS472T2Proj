<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    // Retrieve user ID from the form
    String userID = request.getParameter("userID");

    // Establish database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Delete the user from the database
    String query = "DELETE FROM Users WHERE UserID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, userID);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Close the database connection
    conn.close();

    // Redirect back to manageUsers.jsp after removing the user
    response.sendRedirect("manageUsers.jsp");
%>
