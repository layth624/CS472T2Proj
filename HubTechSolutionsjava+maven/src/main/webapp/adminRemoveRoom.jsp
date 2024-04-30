<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    String roomID = request.getParameter("roomID");

    // Establish database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Check for associated reservations
    String queryCheck = "SELECT COUNT(*) AS count FROM RoomReservation WHERE RoomID = ?";
    try (PreparedStatement pstmtCheck = conn.prepareStatement(queryCheck)) {
        pstmtCheck.setString(1, roomID);
        ResultSet rs = pstmtCheck.executeQuery();
        if (rs.next() && rs.getInt("count") > 0) {
            response.sendRedirect("adminManageRooms.jsp?msg=Cannot delete room with existing reservations");
            return;
        }
    } catch (SQLException e) {
        response.sendRedirect("adminManageRooms.jsp?msg=Database error: " + e.getMessage());
        return;
    }

    // Delete the room
    String query = "DELETE FROM Room WHERE RoomID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, roomID);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.sendRedirect("adminManageRooms.jsp?msg=Room deleted successfully");
        } else {
            response.sendRedirect("adminManageRooms.jsp?msg=No room found with the provided ID");
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
