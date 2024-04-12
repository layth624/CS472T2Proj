<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    // (page is currently not working)
    <% 
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String roomNumber = request.getParameter("roomNumber");
    String checkInDate = request.getParameter("checkInDate");
    String checkOutDate = request.getParameter("checkOutDate");
    String roomType = request.getParameter("roomType");

    DatabaseConnector db = new DatabaseConnector();
    Connection con = null;
    PreparedStatement pstmt = null;
    boolean bookingSuccess = false;

    try {
        con = db.connect();
        con.setAutoCommit(false); // Start transaction

        // Update room status
        String sqlUpdateRoom = "UPDATE Room SET Status = 'booked' WHERE RoomNumber = ? AND Status = 'available'";
        pstmt = con.prepareStatement(sqlUpdateRoom);
        pstmt.setString(1, roomNumber);
        int updatedRows = pstmt.executeUpdate();

        if(updatedRows > 0) {
            // Insert into reservations table
            String sqlInsertReservation = "INSERT INTO Reservation (UserID, RoomNumber, CheckInDate, CheckOutDate, Status) VALUES ((SELECT UserID FROM Users WHERE Username = ?), ?, ?, ?, 'confirmed')";
            pstmt = con.prepareStatement(sqlInsertReservation);
            pstmt.setString(1, username);
            pstmt.setString(2, roomNumber);
            pstmt.setString(3, checkInDate);
            pstmt.setString(4, checkOutDate);
            pstmt.executeUpdate();

            con.commit(); // Commit transaction
            bookingSuccess = true;
        } else {
            con.rollback(); // Rollback transaction if room is not available
        }
    } catch (SQLException e) {
        out.println("Booking Error: " + e.getMessage());
        try {
            if(con != null) con.rollback(); // Rollback on other SQL exceptions
        } catch(SQLException se) {
            out.println("Rollback Error: " + se.getMessage());
        }
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    if (bookingSuccess) {
        %>
        <h1>Booking Successful!</h1>
        <p>Your booking for room number <%= roomNumber %> has been confirmed for dates <%= checkInDate %> to <%= checkOutDate %>.</p>
        <a href="profile.jsp">Go to My Profile</a>
        <% 
    } else {
        %>
        <h1>Booking Failed</h1>
        <p>The room is no longer available or an error occurred. Please try again.</p>
        <a href="single.jsp">Back to Booking</a>
        <%
    }
    %>
</body>
</html>
