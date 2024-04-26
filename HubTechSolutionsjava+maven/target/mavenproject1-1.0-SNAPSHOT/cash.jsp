<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Confirm Payment</title>
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
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-cash"></i></div>
                        <h1 class="fw-bolder">Confirm Payment</h1>
                        <% 
                        String reservationID = request.getParameter("reservationID");
                        double amount = 0; 
                        DatabaseConnector db = new DatabaseConnector();
                        Connection con = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            con = db.connect();
                            String query = "SELECT TotalCost FROM Reservation WHERE ReservationID = ?";
                            pstmt = con.prepareStatement(query);
                            pstmt.setString(1, reservationID);
                            rs = pstmt.executeQuery();
                            if (rs.next()) {
                                amount = rs.getDouble("TotalCost");
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
                        <p>Please confirm if you want to pay $<%= amount %> in cash. If you select cash, you will need to pay upfront at the front desk.</p>
                    </div>
                    <form method="post">
                        <input type="hidden" name="reservationID" value="<%= reservationID %>">
                        <div class="text-center">
                            <button type="submit" name="confirm" value="YES" class="btn btn-success">Yes, pay in cash</button>
                            <a href="profile.jsp" class="btn btn-secondary">No, cancel</a>
                        </div>
                    </form>
                    <% 
                    if ("YES".equals(request.getParameter("confirm"))) {
                        con = null;
                        pstmt = null;
                        try {
                            con = db.connect();
                            con.setAutoCommit(false);
                            String sqlUpdatePayment = "INSERT INTO Payment (ReservationID, Amount, Date, PaymentMethod, Status) VALUES (?, ?, CURRENT_TIMESTAMP, 'cash', 'completed')";
                            pstmt = con.prepareStatement(sqlUpdatePayment);
                            pstmt.setString(1, reservationID);
                            pstmt.setDouble(2, amount); 
                            int res = pstmt.executeUpdate();
                            if (res > 0) {
                                String sqlUpdateReservation = "UPDATE Reservation SET Status = 'completed' WHERE ReservationID = ?";
                                pstmt = con.prepareStatement(sqlUpdateReservation);
                                pstmt.setString(1, reservationID);
                                pstmt.executeUpdate();
                                con.commit();
                            } else {
                                con.rollback();
                            }
                        } catch (SQLException e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                        } finally {
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                            if (con != null) try { con.close(); } catch (SQLException ex) {}
                        }
                        response.sendRedirect("profile.jsp");
                    }
                    %>
                </div>
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
