<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector, java.text.SimpleDateFormat, java.text.ParseException, java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="d-flex flex-column">
    <main class="flex-shrink-0">
        <%@ include file="includes/nav.jsp" %>
        <section class="py-5">
            <div class="container px-5">
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="text-center mb-5">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-card-checklist"></i></div>
                        <% 
                        String username = (String) session.getAttribute("username");
                        if(username == null) {
                            response.sendRedirect("login.jsp");
                            return;
                        }

                        String roomID = request.getParameter("roomID");
                        String roomNumber = request.getParameter("roomNumber");
                        String checkInDate = request.getParameter("checkInDate");
                        String checkOutDate = request.getParameter("checkOutDate");
                        double totalCost = Double.parseDouble(request.getParameter("totalCost")); // Get totalCost from the previous page
                        boolean bookingSuccess = false;
                        Connection con = null;
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Date checkIn = null;
                        Date checkOut = null;

                        try {
                            checkIn = sdf.parse(checkInDate);
                            checkOut = sdf.parse(checkOutDate);
                            if (!checkIn.before(checkOut)) {
                                throw new IllegalArgumentException("Check-out date must be after check-in date.");
                            }

                            DatabaseConnector db = new DatabaseConnector();
                            con = db.connect();
                            con.setAutoCommit(false);

                            int userID = 0;
                            String sqlGetUserID = "SELECT UserID FROM Users WHERE Username = ?";
                            try (PreparedStatement pstmtGetUser = con.prepareStatement(sqlGetUserID)) {
                                pstmtGetUser.setString(1, username);
                                ResultSet rsUser = pstmtGetUser.executeQuery();
                                if (rsUser.next()) {
                                    userID = rsUser.getInt("UserID");
                                } else {
                                    throw new Exception("User not found.");
                                }
                            }

                            String sqlUpdateRoom = "UPDATE Room SET Status = 'booked' WHERE RoomID = ? AND Status = 'available'";
                            try (PreparedStatement pstmt = con.prepareStatement(sqlUpdateRoom)) {
                                pstmt.setString(1, roomID);
                                int updatedRows = pstmt.executeUpdate();

                                if(updatedRows > 0) {
                                    String sqlInsertReservation = "INSERT INTO Reservation (UserID, RoomID, CheckInDate, CheckOutDate, TotalCost, Status) VALUES (?, ?, ?, ?, ?, 'active')";
                                    try (PreparedStatement pstmt2 = con.prepareStatement(sqlInsertReservation)) {
                                        pstmt2.setInt(1, userID);
                                        pstmt2.setString(2, roomID);
                                        pstmt2.setString(3, sdf.format(checkIn));
                                        pstmt2.setString(4, sdf.format(checkOut));
                                        pstmt2.setDouble(5, totalCost);
                                        pstmt2.executeUpdate();
                                    }
                                    con.commit();
                                    bookingSuccess = true;
                                } else {
                                    con.rollback();
                                }
                            }
                        } catch (ParseException e) {
                            out.println("<h1>Date Parsing Error:</h1><p>" + e.getMessage() + "</p>");
                        } catch (Exception e) {
                            out.println("<h1>Booking Error:</h1><p>" + e.getMessage() + "</p>");
                            if (con != null) {
                                try { con.rollback(); } catch(SQLException se) {
                                    out.println("<h1>Rollback Error:</h1><p>" + se.getMessage() + "</p>");
                                }
                            }
                        } finally {
                            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }

                        if (bookingSuccess) {
                            %>
                            <h1>Booking Successful!</h1>
                            <p>Your booking for room number <%= roomNumber %> has been confirmed for dates <%= sdf.format(checkIn) %> to <%= sdf.format(checkOut) %>. Total cost: $<%= totalCost %>. The booking status is now 'active'.</p>
                            <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
<div class="elfsight-app-ec546c74-c0d7-471f-a0ee-5c118540fccf" data-elfsight-app-lazy></div>
                            <a href="profile.jsp" class="btn btn-primary">Go to My Profile</a>
                            <% 
                        } else {
                            %>
                            <h1>Booking Failed</h1>
                            <p>The room is no longer available or an error occurred. Please try again.</p>
                            <a href="index.jsp" class="btn btn-secondary">Back to HomePage</a>
                            <%
                        }
                        %>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
    <script src="js/scripts.js"></script>
</body>
</html>
