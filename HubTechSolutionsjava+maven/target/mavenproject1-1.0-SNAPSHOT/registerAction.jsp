<%-- 
    Document   : registerAction
    Created on : Apr 11, 2024, 12:37:37 PM
    Author     : layth
--%>
<%--
String name = request.getParameter("name");
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password"); // Remember, storing passwords as plain text is not secure
String dob = request.getParameter("dob");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String userRegistered = null;

if(name != null && username != null && email != null && password != null && dob != null && address != null && phone != null) {
    try {
        Connection con = Database.getConnection();
        String query = "INSERT INTO users (Name, Username, Email, Password, Dob, Address, PhoneNumber) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, username);
        pstmt.setString(3, email);
        pstmt.setString(4, password); // Consider hashing the password before inserting it into the database
        pstmt.setString(5, dob);
        pstmt.setString(6, address);
        pstmt.setString(7, phone);
        
        int result = pstmt.executeUpdate();
        if(result > 0) {
            userRegistered = "Registration Successful!";
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
}
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
