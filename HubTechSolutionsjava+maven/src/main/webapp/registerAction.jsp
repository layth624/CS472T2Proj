<%@page import="java.sql.*"%>
<%@page import="com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>

<%
String name = request.getParameter("name");
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");
String dob = request.getParameter("dob");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String userRegistered = "";

if(name != null && username != null && email != null && password != null && dob != null && address != null && phone != null) {
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt()); // Hashing the password
    DatabaseConnector db = new DatabaseConnector();
    try {
        Connection con = db.connect();
        String query = "INSERT INTO Users (Name, Username, Email, Password, Dob, Address, PhoneNumber) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, username);
        pstmt.setString(3, email);
        pstmt.setString(4, hashedPassword);
        pstmt.setString(5, dob);
        pstmt.setString(6, address);
        pstmt.setString(7, phone);
        
        int result = pstmt.executeUpdate();
        if(result > 0) {
            userRegistered = "Registration Successful! You will be redirected shortly.";
        } else {
            userRegistered = "Registration Failed!";
        }
    } catch(Exception e) {
        userRegistered = "Error during registration: " + e.getMessage();
        e.printStackTrace();
    }
}
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="2;URL='index.jsp'"> 
    <title>Registration Status</title>
</head>
<body>
    <h1>Registration Status</h1>
    <p><%= userRegistered %></p>
</body>
</html>
