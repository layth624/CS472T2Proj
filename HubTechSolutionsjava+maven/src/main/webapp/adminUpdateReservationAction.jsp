<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    response.setContentType("text/html;charset=UTF-8");
    String reservationID = request.getParameter("reservationID");
    String roomID = request.getParameter("roomID");
    String checkInDate = request.getParameter("checkInDate");
    String checkOutDate = request.getParameter("checkOutDate");
    String totalCost = request.getParameter("totalCost"); 
    String status = request.getParameter("status");

    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    String updateQuery = "UPDATE Reservation SET RoomID = ?, CheckInDate = ?, CheckOutDate = ?, TotalCost = ?, Status = ? WHERE ReservationID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
        pstmt.setString(1, roomID);
        pstmt.setDate(2, java.sql.Date.valueOf(checkInDate));
        pstmt.setDate(3, java.sql.Date.valueOf(checkOutDate));
        pstmt.setDouble(4, Double.parseDouble(totalCost)); 
        pstmt.setString(5, status);
        pstmt.setString(6, reservationID);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<p>Update successful. <a href='adminManageReservations.jsp'>Return to reservations</a></p>");
        } else {
            out.println("<p>Failed to update the reservation.</p>");
        }
    } catch (NumberFormatException e) {
        out.println("<p>Error in formatting the total cost. Please enter a valid number.</p>");
    } catch (SQLException e) {
        out.println("<p>Database error: " + e.getMessage() + "</p>");
    } finally {
        conn.close();
    }
%>

<html>
<head>
    <title>Update Reservation Result</title>
</head>
</html>
