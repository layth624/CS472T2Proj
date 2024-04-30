<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<% 
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
   
    // Establish a database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Fetch reservation data from the database
    List<Map<String, String>> reservations = new ArrayList<>();
    String query = "SELECT ReservationID, UserID, RoomID, CheckInDate, CheckOutDate, TotalCost, Status FROM Reservation";
    try (PreparedStatement pstmt = conn.prepareStatement(query);
         ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
            Map<String, String> reservation = new HashMap<>();
            reservation.put("ReservationID", rs.getString("ReservationID"));
            reservation.put("UserID", rs.getString("UserID"));
            reservation.put("RoomID", rs.getString("RoomID"));
            reservation.put("CheckInDate", rs.getString("CheckInDate"));
            reservation.put("CheckOutDate", rs.getString("CheckOutDate"));
            reservation.put("TotalCost", rs.getString("TotalCost"));
            reservation.put("Status", rs.getString("Status"));
            reservations.add(reservation);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        conn.close();
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reservations</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
    <style>
        table {
            width: 100%; 
            border-collapse: collapse; 
        }
        th, td {
            padding: 8px; 
            border: 1px solid #ccc; 
        }
        th {
            background-color: #f4f4f4; 
        }
    </style>

<body>
    <header>
        <%@ include file="includes/adminNav.jsp" %> <!-- Navigation bar specific to admin -->
    </header>
    <h1>Manage Reservations</h1>

    <!-- Form to Add New Reservation -->
    <h2>Add New Reservation</h2>
    <form method="post" action="adminAddReservation.jsp">
        <label for="userID">User ID:</label>
        <input type="text" id="userID" name="userID" required><br>
        <label for="roomID">Room ID:</label>
        <input type="text" id="roomID" name="roomID" required><br>
        <label for="checkInDate">Check-In Date:</label>
        <input type="date" id="checkInDate" name="checkInDate" required><br>
        <label for="checkOutDate">Check-Out Date:</label>
        <input type="date" id="checkOutDate" name="checkOutDate" required><br>
        <label for="totalCost">Total Cost:</label>
        <input type="number" id="totalCost" name="totalCost" required><br>
        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="active">Active</option>
            <option value="cancelled">Cancelled</option>
            <option value="completed">Completed</option>
        </select><br>
        <input type="submit" value="Add Reservation">
    </form>

    <!-- Existing Reservations Table -->
    <h2>Existing Reservations</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Reservation ID</th>
                <th>User ID</th>
                <th>Room ID</th>
                <th>Check-In Date</th>
                <th>Check-Out Date</th>
                <th>Total Cost</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Map<String, String> reservation : reservations) { %>
                <tr>
                    <td><%= reservation.get("ReservationID") %></td>
                    <td><%= reservation.get("UserID") %></td>
                    <td><%= reservation.get("RoomID") %></td>
                    <td><%= reservation.get("CheckInDate") %></td>
                    <td><%= reservation.get("CheckOutDate") %></td>
                    <td>$<%= reservation.get("TotalCost") %></td>
                    <td><%= reservation.get("Status") %></td>
                    <td>
                        <form method="post" action="adminUpdateReservation.jsp">
                            <input type="hidden" name="reservationID" value="<%= reservation.get("ReservationID") %>">
                            <input type="submit" value="Update">
                        </form>
                        <form method="post" action="adminRemoveReservation.jsp">
                            <input type="hidden" name="reservationID" value="<%= reservation.get("ReservationID") %>">
                            <input type="submit" value="Cancel">
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
