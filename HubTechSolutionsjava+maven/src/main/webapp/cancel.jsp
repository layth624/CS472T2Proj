<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Cancel Reservation</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="d-flex flex-column">
    <main class="flex-shrink-0">
        <%@ include file="includes/nav.jsp" %>
        <section class="py-5">
            <div class="container px-5">
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="text-center mb-5">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-x-circle"></i></div>
                        <h1 class="fw-bolder">Cancel Reservation</h1>
                        <% 
                        String reservationID = request.getParameter("reservationID");
                        DatabaseConnector db = new DatabaseConnector();
                        Connection con = db.connect();
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            String query = "SELECT r.CheckInDate, r.CheckOutDate, rm.RoomNumber FROM Reservation r JOIN Room rm ON r.RoomID = rm.RoomID WHERE r.ReservationID = ?";
                            pstmt = con.prepareStatement(query);
                            pstmt.setString(1, reservationID);
                            rs = pstmt.executeQuery();
                            if (rs.next()) {
                                String roomNumber = rs.getString("RoomNumber");
                                String checkInDate = rs.getString("CheckInDate");
                                String checkOutDate = rs.getString("CheckOutDate");
                                %>
                                <p>Are you sure you want to cancel your reservation for Room <%= roomNumber %>, booked from <%= checkInDate %> to <%= checkOutDate %>?</p>
                                <% 
                            }
                        } catch (SQLException e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                            if (con != null) try { con.close(); } catch (SQLException ex) {}
                        }
                        %>
                    </div>
                    <% 
                    if ("YES".equals(request.getParameter("confirm"))) {
                        try {
                            con = db.connect();
                            con.setAutoCommit(false);
                            String sqlUpdateReservation = "UPDATE Reservation SET Status = 'cancelled' WHERE ReservationID = ?";
                            pstmt = con.prepareStatement(sqlUpdateReservation);
                            pstmt.setString(1, reservationID);
                            int resUpdate = pstmt.executeUpdate();

                            if (resUpdate > 0) {
                                String sqlUpdateRoom = "UPDATE Room SET Status = 'available' WHERE RoomID = (SELECT RoomID FROM Reservation WHERE ReservationID = ?)";
                                pstmt = con.prepareStatement(sqlUpdateRoom);
                                pstmt.setString(1, reservationID);
                                int roomUpdate = pstmt.executeUpdate();

                                if (roomUpdate > 0) {
                                    con.commit();
                                } else {
                                    con.rollback();
                                }
                            } else {
                                con.rollback();
                            }
                        } catch (SQLException e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                            if (con != null) try { con.rollback(); } catch(SQLException se) {}
                            e.printStackTrace();
                        } finally {
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                            if (con != null) try { con.close(); } catch (SQLException ex) {}
                        }
                        response.sendRedirect("profile.jsp");
                        return;
                    } else if ("NO".equals(request.getParameter("confirm"))) {
                        response.sendRedirect("profile.jsp");
                        return;
                    }
                    %>
                    <form method="post">
                        <input type="hidden" name="reservationID" value="<%= reservationID %>">
                        <div class="text-center">
                            <button type="submit" name="confirm" value="YES" class="btn btn-danger">Yes, cancel it</button>
                            <button type="submit" name="confirm" value="NO" class="btn btn-secondary">No, keep it</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
