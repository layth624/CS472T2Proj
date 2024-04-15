<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Payment Portal</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="d-flex flex-column">
    <main class="flex-shrink-0">
        <%@ include file="includes/nav.jsp" %>
        <section class="py-5">
            <div class="container px-5">
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="text-center mb-5">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
                            <i class="bi bi-cart3"></i>
                        </div>
                        <h1 class="fw-bolder">Your Cart</h1>
                        <p class="lead">Review and pay for your active reservations.</p>
                    </div>
                    <% 
                    String username = (String) session.getAttribute("username");
                    if(username == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }

                    DatabaseConnector db = new DatabaseConnector();
                    Connection con = db.connect();
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        String query = "SELECT r.ReservationID, r.RoomID, r.CheckInDate, r.CheckOutDate, r.TotalCost, r.Status, rm.RoomNumber FROM Reservation r JOIN Room rm ON r.RoomID = rm.RoomID JOIN Users u ON r.UserID = u.UserID WHERE u.Username = ? AND r.Status = 'active'";
                        pstmt = con.prepareStatement(query);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();

                        if (!rs.isBeforeFirst() ) {    
                            out.println("<h4>No active reservations found.</h4>");
                        } else {
                            %>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Reservation ID</th>
                                        <th>Room Number</th>
                                        <th>Check-In Date</th>
                                        <th>Check-Out Date</th>
                                        <th>Total Cost</th>
                                        <th>Payment Method</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% while (rs.next()) { %>
                                    <tr>
                                        <td><%= rs.getString("ReservationID") %></td>
                                        <td><%= rs.getString("RoomNumber") %></td>
                                        <td><%= rs.getString("CheckInDate") %></td>
                                        <td><%= rs.getString("CheckOutDate") %></td>
                                        <td>$<%= rs.getDouble("TotalCost") %></td>
                                        <td>
                                            <select id="paymentMethod<%= rs.getString("ReservationID") %>" class="form-control" onchange="handlePaymentMethod('<%= rs.getString("ReservationID") %>')">
                                                <option value="">Choose...</option>
                                                <option value="Credit Card">Credit Card</option>
                                                <option value="PayPal">PayPal</option>
                                                <option value="Bank Transfer">Bank Transfer</option>
                                                <option value="Cash">Cash</option>
                                            </select>
                                        </td>
                                        <td><button class="btn btn-primary" onclick="submitPayment('<%= rs.getString("ReservationID") %>')">Pay Now</button></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
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
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
    <script src="js/scripts.js"></script>
    <script>
        function handlePaymentMethod(reservationID) {
            var paymentMethod = document.getElementById('paymentMethod' + reservationID).value;
            if (paymentMethod === 'Cash') {
                console.log('Please prepare to pay at the front desk upon your arrival.');
            }
        }

        function submitPayment(reservationID) {
            var paymentMethod = document.getElementById('paymentMethod' + reservationID).value;
            if (!paymentMethod) {
                alert('Please select a payment method.');
                return;
            }
            // Implement redirection later
            console.log('Proceeding to payment gateway...');
        }
    </script>
</body>
</html>
