<%@ page import="java.sql.*"%>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%
String adminUsername = request.getParameter("username");
String adminPassword = request.getParameter("password");
boolean loginSuccess = false;

DatabaseConnector db = new DatabaseConnector();
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    con = db.connect();
    String query = "SELECT AdminPassword FROM Admin WHERE AdminUsername = ?";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, adminUsername);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        String storedPassword = rs.getString("AdminPassword");
        loginSuccess = BCrypt.checkpw(adminPassword, storedPassword);
    }

    // After verifying admin credentials
    if(loginSuccess) {
        session.setAttribute("adminUsername", adminUsername); 
        response.sendRedirect("adminDashboard.jsp");
    } else {
        response.sendRedirect("adminLogin.jsp?error=true");
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
