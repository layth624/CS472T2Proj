<%@page import="java.sql.*"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.mycompany.mavenproject1.DatabaseConnector"%>

<%
String name = request.getParameter("name");
String adminUsername = request.getParameter("adminUsername");
String adminPassword = request.getParameter("adminPassword");
String role = request.getParameter("role");
String registrationStatus = "";

if(name != null && adminUsername != null && adminPassword != null && role != null) {
    String hashedPassword = BCrypt.hashpw(adminPassword, BCrypt.gensalt()); // Hashing the password
    DatabaseConnector db = new DatabaseConnector();
    try {
        Connection con = db.connect();
        String query = "INSERT INTO Admin (Name, AdminUsername, AdminPassword, Role) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, adminUsername);
        pstmt.setString(3, hashedPassword);
        pstmt.setString(4, role);
        
        int result = pstmt.executeUpdate();
        if(result > 0) {
            registrationStatus = "Admin Registration Successful! You will be redirected shortly.";
        } else {
            registrationStatus = "Admin Registration Failed!";
        }
    } catch(Exception e) {
        registrationStatus = "Error during admin registration: " + e.getMessage();
        e.printStackTrace();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="2;URL='adminRegistration.jsp'"> 
    <title>Admin Registration Status</title>
</head>
<body>
    <h1>Admin Registration Status</h1>
    <p><%= registrationStatus %></p>
</body>
</html>
