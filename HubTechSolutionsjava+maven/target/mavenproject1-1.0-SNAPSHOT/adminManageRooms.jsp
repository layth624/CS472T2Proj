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

    // Fetch room data from the database
    List<Map<String, String>> rooms = new ArrayList<>();
    String query = "SELECT RoomID, RoomType, Price, Status, FloorLocation, RoomNumber FROM Room";
    try (PreparedStatement pstmt = conn.prepareStatement(query);
         ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
            Map<String, String> room = new HashMap<>();
            room.put("RoomID", rs.getString("RoomID"));
            room.put("RoomType", rs.getString("RoomType"));
            room.put("Price", rs.getString("Price"));
            room.put("Status", rs.getString("Status"));
            room.put("FloorLocation", rs.getString("FloorLocation"));
            room.put("RoomNumber", rs.getString("RoomNumber"));
            rooms.add(room);
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
    <title>Manage Rooms</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
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
</head>
<body>
    <header>
        <%@ include file="includes/adminNav.jsp" %>
    </header>
    <h1>Manage Rooms</h1>
    <h2>Add Room</h2>
    <form method="post" action="adminAddRoom.jsp">
        <label for="roomType">Room Type:</label>
        <select id="roomType" name="roomType" required>
            <option value="single">Single</option>
            <option value="double">Double</option>
            <option value="suite">Suite</option>
        </select><br>
        <label for="price">Price:</label>
        <input type="text" id="price" name="price" required><br>
        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="available">Available</option>
            <option value="booked">Booked</option>
        </select><br>
        <label for="floorLocation">Floor Location:</label>
        <select id="floorLocation" name="floorLocation" required>
            <option value="1st Floor">1st Floor</option>
            <option value="2nd Floor">2nd Floor</option>
            <option value="3rd Floor">3rd Floor</option>
        </select><br>
        <label for="roomNumber">Room Number:</label>
        <input type="text" id="roomNumber" name="roomNumber" required><br>

        <input type="submit" value="Add Room">
    </form>
    <hr>
    <h2>Rooms</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Room ID</th>
                <th>Room Type</th>
                <th>Price</th>
                <th>Status</th>
                <th>Floor Location</th>
                <th>Room Number</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Map<String, String> room : rooms) { %>
                <tr>
                    <td><%= room.get("RoomID") %></td>
                    <td><%= room.get("RoomType") %></td>
                    <td>$<%= room.get("Price") %></td>
                    <td><%= room.get("Status") %></td>
                    <td><%= room.get("FloorLocation") %></td>
                    <td><%= room.get("RoomNumber") %></td>
                    <td>
                        <form method="post" action="adminUpdateRoom.jsp">
                            <input type="hidden" name="roomID" value="<%= room.get("RoomID") %>">
                            <input type="submit" value="Update">
                        </form>
                        <form method="post" action="adminRemoveRoom.jsp">
                            <input type="hidden" name="roomID" value="<%= room.get("RoomID") %>">
                            <input type="submit" value="Remove">
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
