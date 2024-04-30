<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    response.setContentType("text/html;charset=UTF-8");
    String roomID = request.getParameter("roomID");
    String roomType = request.getParameter("roomType");
    String price = request.getParameter("price");
    String status = request.getParameter("status");
    String floorLocation = request.getParameter("floorLocation");
    String roomNumber = request.getParameter("roomNumber");

    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    String updateQuery = "UPDATE Room SET RoomType = ?, Price = ?, Status = ?, FloorLocation = ?, RoomNumber = ? WHERE RoomID = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
        pstmt.setString(1, roomType);
        pstmt.setDouble(2, Double.parseDouble(price)); 
        pstmt.setString(3, status);
        pstmt.setString(4, floorLocation);
        pstmt.setString(5, roomNumber);
        pstmt.setString(6, roomID);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<p>Update successful. <a href='adminManageRooms.jsp'>Return to rooms</a></p>");
        } else {
            out.println("<p>Failed to update the room.</p>");
        }
    } catch (NumberFormatException e) {
        out.println("<p>Error in formatting the price. Please enter a valid number.</p>");
    } catch (SQLException e) {
        out.println("<p>Database error: " + e.getMessage() + "</p>");
    } finally {
        conn.close();
    }
%>

<html>
<head>
    <title>Update Room Result</title>
</head>
</html>
