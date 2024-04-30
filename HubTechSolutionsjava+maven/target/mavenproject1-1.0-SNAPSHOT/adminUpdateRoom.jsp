<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    String roomID = request.getParameter("roomID");
    if (roomID == null || roomID.isEmpty()) {
        out.println("No Room ID provided.");
        return;
    }

    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();
    Map<String, String> room = new HashMap<>();

    String query = "SELECT * FROM Room WHERE RoomID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, roomID);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            room.put("RoomID", rs.getString("RoomID"));
            room.put("RoomType", rs.getString("RoomType"));
            room.put("Price", rs.getString("Price"));
            room.put("Status", rs.getString("Status"));
            room.put("FloorLocation", rs.getString("FloorLocation"));
            room.put("RoomNumber", rs.getString("RoomNumber"));
        } else {
            out.println("No room found with the given ID.");
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
    <title>Update Room</title>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <h1>Update Room</h1>
    <form action="adminUpdateRoomAction.jsp" method="post">
        <input type="hidden" name="roomID" value="<%= room.get("RoomID") %>">
        
        <label for="roomType">Room Type:</label>
        <select id="roomType" name="roomType" required>
            <option value="single" <%= "single".equals(room.get("RoomType")) ? "selected" : "" %>>Single</option>
            <option value="double" <%= "double".equals(room.get("RoomType")) ? "selected" : "" %>>Double</option>
            <option value="suite" <%= "suite".equals(room.get("RoomType")) ? "selected" : "" %>>Suite</option>
        </select><br>

        <label for="price">Price:</label>
        <input type="text" id="price" name="price" value="<%= room.get("Price") %>" required><br>

        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="available" <%= "available".equals(room.get("Status")) ? "selected" : "" %>>Available</option>
            <option value="booked" <%= "booked".equals(room.get("Status")) ? "selected" : "" %>>Booked</option>
        </select><br>

        <label for="floorLocation">Floor Location:</label>
        <input type="text" id="floorLocation" name="floorLocation" value="<%= room.get("FloorLocation") %>" required><br>

        <label for="roomNumber">Room Number:</label>
        <input type="text" id="roomNumber" name="roomNumber" value="<%= room.get("RoomNumber") %>" required><br>

        <input type="submit" value="Save Changes">
    </form>
</body>
</html>
