<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    // Retrieve form data
    String roomType = request.getParameter("roomType");
    String price = request.getParameter("price");
    String status = request.getParameter("status");
    String floorLocation = request.getParameter("floorLocation");
    String roomNumber = request.getParameter("roomNumber");

    // Establish database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // SQL query to insert
    String query = "INSERT INTO Room (RoomType, Price, Status, FloorLocation, RoomNumber) VALUES (?, ?, ?, ?, ?)";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, roomType);
        pstmt.setDouble(2, Double.parseDouble(price)); // Ensure price is a valid double
        pstmt.setString(3, status);
        pstmt.setString(4, floorLocation);
        pstmt.setString(5, roomNumber);
        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.sendRedirect("adminManageRooms.jsp?msg=Room added successfully");
        } else {
            response.sendRedirect("adminManageRooms.jsp?msg=Error adding room");
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("adminManageRooms.jsp?msg=Invalid price format");
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
