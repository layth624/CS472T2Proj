<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    String reservationID = request.getParameter("reservationID");
    if (reservationID == null || reservationID.isEmpty()) {
        out.println("No Reservation ID provided.");
        return;
    }

    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();
    Map<String, String> reservation = new HashMap<>();

    String query = "SELECT * FROM Reservation WHERE ReservationID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, reservationID);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            reservation.put("ReservationID", rs.getString("ReservationID"));
            reservation.put("UserID", rs.getString("UserID"));
            reservation.put("RoomID", rs.getString("RoomID"));
            reservation.put("CheckInDate", rs.getString("CheckInDate"));
            reservation.put("CheckOutDate", rs.getString("CheckOutDate"));
            reservation.put("TotalCost", rs.getString("TotalCost"));
            reservation.put("Status", rs.getString("Status"));
        } else {
            out.println("No reservation found with the given ID.");
            return;
        }
    } catch (SQLException e) {
        out.println("Database error: " + e.getMessage());
        return;
    } finally {
        conn.close();
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Reservation</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <h1>Update Reservation</h1>
    <form action="adminUpdateReservationAction.jsp" method="post">
        <input type="hidden" name="reservationID" value="<%= reservation.get("ReservationID") %>">
        
        <label for="roomID">Room ID:</label>
        <input type="text" id="roomID" name="roomID" value="<%= reservation.get("RoomID") %>" required><br>

        <label for="checkInDate">Check-In Date:</label>
        <input type="date" id="checkInDate" name="checkInDate" value="<%= reservation.get("CheckInDate") %>" required><br>

        <label for="checkOutDate">Check-Out Date:</label>
        <input type="date" id="checkOutDate" name="checkOutDate" value="<%= reservation.get("CheckOutDate") %>" required><br>

        <label for="totalCost">Total Cost:</label>
        <input type="number" id="totalCost" name="totalCost" value="<%= reservation.get("TotalCost") %>" required><br>

        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="active" <%= "active".equals(reservation.get("Status")) ? "selected" : "" %>>Active</option>
            <option value="cancelled" <%= "cancelled".equals(reservation.get("Status")) ? "selected" : "" %>>Cancelled</option>
            <option value="completed" <%= "completed".equals(reservation.get("Status")) ? "selected" : "" %>>Completed</option>
        </select><br>

        <input type="submit" value="Save Changes">
    </form>
</body>
</html>
