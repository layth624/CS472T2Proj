<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile Update</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <% 
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String dob = request.getParameter("dob");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        DatabaseConnector db = new DatabaseConnector();
        con = db.connect();
        con.setAutoCommit(false);

        String query = "UPDATE Users SET Name=?, Email=?, Dob=?, Address=?, PhoneNumber=? WHERE Username=?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, dob);
        pstmt.setString(4, address);
        pstmt.setString(5, phone);
        pstmt.setString(6, username);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            con.commit();
            out.println("<p>Profile updated successfully.</p>");
            response.sendRedirect("profile.jsp"); // Redirect to the profile page
        } else {
            con.rollback();
            out.println("<p>Failed to update profile. Please try again.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        if (con != null) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                out.println("<p>Error during rollback: " + ex.getMessage() + "</p>");
            }
        }
    } finally {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    %>
</body>
</html>
