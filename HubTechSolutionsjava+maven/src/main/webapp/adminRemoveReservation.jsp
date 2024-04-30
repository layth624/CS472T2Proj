<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>


<%
    String reservationID = request.getParameter("reservationID");

    // Establish database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Check for associated payments
    String queryCheck = "SELECT COUNT(*) AS count FROM Payment WHERE ReservationID = ?";
    try (PreparedStatement pstmtCheck = conn.prepareStatement(queryCheck)) {
        pstmtCheck.setString(1, reservationID);
        ResultSet rs = pstmtCheck.executeQuery();
        if (rs.next() && rs.getInt("count") > 0) {
            response.sendRedirect("adminManageReservations.jsp?msg=Cannot delete reservation with existing payments");
            return;
        }
    } catch (SQLException e) {
        response.sendRedirect("adminManageReservations.jsp?msg=Database error: " + e.getMessage());
        return;
    }

    // Delete the reservation
    String query = "DELETE FROM Reservation WHERE ReservationID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, reservationID);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.sendRedirect("adminManageReservations.jsp?msg=Reservation deleted successfully");
        } else {
            response.sendRedirect("adminManageReservations.jsp?msg=No reservation found with the provided ID");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("adminManageReservations.jsp?msg=Database error: " + e.getMessage());
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
