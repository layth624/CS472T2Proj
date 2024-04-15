<%@ page import="java.sql.*"%>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");
boolean loginSuccess = false;

DatabaseConnector db = new DatabaseConnector();
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    con = db.connect();
    String query = "SELECT Password FROM Users WHERE Username = ?";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, username);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        String storedPassword = rs.getString("Password");
        loginSuccess = BCrypt.checkpw(password, storedPassword);
    }

    // After verifying user credentials
    if(loginSuccess) {
        session.setAttribute("username", username); 
        response.sendRedirect("index.jsp"); 
    } else {
        response.sendRedirect("login.jsp?error=true");
    }

} catch (Exception e) {
    out.println("Error: " + e.getMessage());
    e.printStackTrace();
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
