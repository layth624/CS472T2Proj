<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Single Room Booking</title>
    <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <script>
        function updatePrice() {
            var selectBox = document.getElementById('roomSelect');
            var selectedValue = selectBox.value;
            if (selectedValue !== '') {
                document.getElementById('totalPrice').textContent = 'Total: $100';
            } else {
                document.getElementById('totalPrice').textContent = '';
            }
        }
    </script>
</head>
<body class="d-flex flex-column">
    <% 
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>
    <main class="flex-shrink-0">
        <%@ include file="includes/nav.jsp" %>
        <section class="py-5">
            <div class="container px-5">
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="text-center mb-5">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-house-door"></i></div>
                        <h1 class="fw-bolder">Single Room Booking</h1>
                        <img src="assets/single.png" alt="Single Room" style="width: 400px; height: 300px;">
                    </div>
                    <div>
                        <% 
                        DatabaseConnector db = new DatabaseConnector();
                        Connection con = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            con = db.connect();
                            String query = "SELECT RoomNumber, Status FROM Room WHERE RoomType = 'single' AND RoomNumber BETWEEN 100 AND 115 ORDER BY RoomNumber";
                            pstmt = con.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            rs = pstmt.executeQuery();
                            %>
                            <div>
                                <% while (rs.next()) {
                                    int roomNumber = rs.getInt("RoomNumber");
                                    String status = rs.getString("Status");
                                    String cssClass = status.equals("available") ? "available" : "booked";
                                    %>
                                    <div class="room-box <%= cssClass %>"><%= roomNumber %></div>
                                    <%
                                }
                                rs.beforeFirst(); // Reset ResultSet 
                                %>
                            </div>
                            <label for="roomSelect">Choose a room:</label>
                            <select id="roomSelect" name="roomNumber" class="form-control mb-3" onchange="updatePrice()">
                                <option value="">Select a room</option>
                                <% while (rs.next()) {
                                    String status = rs.getString("Status");
                                    int roomNumber = rs.getInt("RoomNumber");
                                    if (status.equals("available")) { %>
                                        <option value="<%= roomNumber %>">Room <%= roomNumber %></option>
                                    <% }
                                } %>
                            </select>
                            <%
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                        %>
                    </div>
                    <form method="POST" action="bookRoom.jsp">
                        <input type="hidden" name="roomType" value="single">
                        <div class="mb-3">
                            <label for="checkInDate" class="form-label">Check-In Date</label>
                            <input type="date" class="form-control" id="checkInDate" name="checkInDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="checkOutDate" class="form-label">Check-Out Date</label>
                            <input type="date" class="form-control" id="checkOutDate" name="checkOutDate" required>
                        </div>
                        <div class="text-center mb-3">
                            <strong id="totalPrice"></strong>
                        </div>
                        <button type="submit" class="btn btn-primary">Book Now</button>
                    </form>
                </div>
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
