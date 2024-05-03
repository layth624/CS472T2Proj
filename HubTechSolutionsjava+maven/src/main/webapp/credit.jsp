<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Confirm Credit Card Payment</title>
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
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-credit-card"></i></div>
                        <h1 class="fw-bolder">Enter Credit Card Details</h1>
                        <% 
                        String username = (String) session.getAttribute("username");
                        if(username == null) {
                            response.sendRedirect("login.jsp");
                            return;
                        }
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
                        <p>Please enter your credit card information to pay $<%= amount %>.</p>
                    </div>
                    <form method="post">
                        <input type="hidden" name="reservationID" value="<%= reservationID %>">
                        <div class="form-floating mb-3">
                            <input class="form-control" id="cardNumber" name="cardNumber" type="text" placeholder="Card Number" required />
                            <label for="cardNumber">Card Number</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input class="form-control" id="expiration" name="expiration" type="text" placeholder="MM/YYYY" required />
                            <label for="expiration">Expiration (MM/YYYY)</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input class="form-control" id="cvc" name="cvc" type="number" placeholder="CVC" required />
                            <label for="cvc">CVC</label>
                        </div>
                        <div class="text-center">
                            <button type="submit" name="confirm" value="YES" class="btn btn-success">Confirm Payment</button>
                            <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                    <% 
                    if ("YES".equals(request.getParameter("confirm"))) {
                        try {
                            con = db.connect(); // Ensure a fresh connection is established if needed
                            con.setAutoCommit(false);
                            String sqlInsertPayment = "INSERT INTO Payment (ReservationID, Amount, Date, PaymentMethod, Status) VALUES (?, ?, CURRENT_TIMESTAMP, 'credit card', 'pending')";
                            pstmt = con.prepareStatement(sqlInsertPayment, Statement.RETURN_GENERATED_KEYS);
                            pstmt.setString(1, reservationID);
                            pstmt.setDouble(2, amount);
                            int paymentResult = pstmt.executeUpdate();
                            long paymentID = 0;
                            ResultSet generatedKeys = pstmt.getGeneratedKeys();
                            if (paymentResult > 0 && generatedKeys.next()) {
                                paymentID = generatedKeys.getLong(1); // Retrieve generated PaymentID
                                generatedKeys.close();
                                pstmt.close();

                                String cardNumber = request.getParameter("cardNumber");
                                String expiration = request.getParameter("expiration");
                                int cvc = Integer.parseInt(request.getParameter("cvc"));
                                String sqlInsertCard = "INSERT INTO Card (PaymentID, CardNumber, Expiration, CVC) VALUES (?, ?, ?, ?)";
                                pstmt = con.prepareStatement(sqlInsertCard);
                                pstmt.setLong(1, paymentID);
                                pstmt.setString(2, cardNumber);
                                pstmt.setString(3, expiration);
                                pstmt.setInt(4, cvc);
                                if (pstmt.executeUpdate() > 0) {
                                    pstmt.close();
                                    String sqlUpdateReservation = "UPDATE Reservation SET Status = 'completed' WHERE ReservationID = ?";
                                    pstmt = con.prepareStatement(sqlUpdateReservation);
                                    pstmt.setString(1, reservationID);
                                    if (pstmt.executeUpdate() > 0) {
                                        con.commit();
                                        response.sendRedirect("sendEmail.jsp?paymentID=" + paymentID); // Redirect with PaymentID
                                    } else {
                                        con.rollback();
                                    }
                                } else {
                                    con.rollback();
                                }
                            } else {
                                con.rollback();
                            }
                        } catch (SQLException e) {
                            out.println("<p>Error: " + e.getMessage() + "</p>");
                            e.printStackTrace();
                            if (con != null) try { con.rollback(); } catch (SQLException ex) {}
                        } finally {
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
                            if (con != null) try { con.close(); } catch (SQLException ex) {}
                        }
                    }
                    %>


                </div>
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
