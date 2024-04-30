<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    // Retrieve room ID from the form
    String roomID = request.getParameter("roomID");

    // Establish database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Delete the room from the database
    String query = "DELETE FROM Room WHERE RoomID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, roomID);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.sendRedirect("adminManageRooms.jsp?msg=Room deleted successfully");
        } else {
            response.sendRedirect("adminManageRooms.jsp?msg=No room found with the provided ID or deletion failed");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("adminManageRooms.jsp?msg=Database error: " + e.getMessage());
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>
