<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>
    <% 
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    %>
<%
    // Retrieve form data
    String userID = request.getParameter("userID");
    String roomID = request.getParameter("roomID");
    String checkInDate = request.getParameter("checkInDate");
    String checkOutDate = request.getParameter("checkOutDate");
    String totalCost = request.getParameter("totalCost");
    String status = request.getParameter("status");

    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // SQL query to insert 
    String query = "INSERT INTO Reservation (UserID, RoomID, CheckInDate, CheckOutDate, TotalCost, Status) VALUES (?, ?, ?, ?, ?, ?)";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setInt(1, Integer.parseInt(userID));
        pstmt.setInt(2, Integer.parseInt(roomID));
        pstmt.setDate(3, java.sql.Date.valueOf(checkInDate));
        pstmt.setDate(4, java.sql.Date.valueOf(checkOutDate));
        pstmt.setDouble(5, Double.parseDouble(totalCost));
        pstmt.setString(6, status);
        int result = pstmt.executeUpdate();
        if(result > 0) {
            response.sendRedirect("adminManageReservations.jsp?msg=Reservation added successfully");
        } else {
            response.sendRedirect("adminManageReservations.jsp?msg=Error adding reservation");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("adminManageReservations.jsp?msg=Database error: " + e.getMessage());
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("adminManageReservations.jsp?msg=Invalid input format");
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
