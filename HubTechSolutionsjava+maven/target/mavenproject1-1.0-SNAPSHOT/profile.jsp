<%@page import="java.sql.*"%>
<%@page import="com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>User Profile</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column">
    <main class="flex-shrink-0">
        <%@ include file="includes/nav.jsp" %>
        <section class="py-5">
            <div class="container px-5">
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="text-center mb-5">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-person-circle"></i></div>
                        <h1 class="fw-bolder">User Profile</h1>
                    </div>
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <% 
                            String username = (String) session.getAttribute("username");
                            if(username == null) {
                                response.sendRedirect("login.jsp");
                                return;
                            }

                            DatabaseConnector db = new DatabaseConnector();
                            Connection con = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            try {
                                con = db.connect();
                                String query = "SELECT UserID, Name, Email, Dob, Address, PhoneNumber FROM Users WHERE Username = ?";
                                pstmt = con.prepareStatement(query);
                                pstmt.setString(1, username);
                                rs = pstmt.executeQuery();

                                if (rs.next()) {
                                    String userID = rs.getString("UserID");
                                    String name = rs.getString("Name");
                                    String email = rs.getString("Email");
                                    String dob = rs.getString("Dob");
                                    String address = rs.getString("Address");
                                    String phone = rs.getString("PhoneNumber");
                                    %>
                                    <form method="POST" action="updateProfile.jsp" class="text-center"> 
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="name" name="name" type="text" placeholder="Name" value="<%= name %>" required />
                                            <label for="name">Name</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="email" name="email" type="email" placeholder="Email" value="<%= email %>" required />
                                            <label for="email">Email</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="dob" name="dob" type="date" placeholder="Date of Birth" value="<%= dob %>" required />
                                            <label for="dob">Date of Birth</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="address" name="address" type="text" placeholder="Address" value="<%= address %>" required />
                                            <label for="address">Address</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="phone" name="phone" type="text" placeholder="Phone Number" value="<%= phone %>" required />
                                            <label for="phone">Phone Number</label>
                                        </div>
                                        <div class="d-grid">
                                            <button class="btn btn-primary btn-lg" type="submit">Update Profile</button>
                                        </div>
                                    </form>
                                    <%
                                    query = "SELECT r.ReservationID, r.RoomID, r.CheckInDate, r.CheckOutDate, r.TotalCost, r.Status, rm.RoomType, rm.RoomNumber, rm.Price FROM Reservation r JOIN Room rm ON r.RoomID = rm.RoomID WHERE r.UserID = ?";
                                    pstmt = con.prepareStatement(query);
                                    pstmt.setString(1, userID);
                                    ResultSet rsReservations = pstmt.executeQuery();
                                    %>
                                    <h2>Reservations</h2>
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Reservation ID</th>
                                                <th>Room Type</th>
                                                <th>Room Number</th>
                                                <th>Check-In</th>
                                                <th>Check-Out</th>
                                                <th>Total Cost</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% while (rsReservations.next()) { %>
                                                <tr>
                                                    <td><%= rsReservations.getString("ReservationID") %></td>
                                                    <td><%= rsReservations.getString("RoomType") %></td>
                                                    <td><%= rsReservations.getString("RoomNumber") %></td>
                                                    <td><%= rsReservations.getString("CheckInDate") %></td>
                                                    <td><%= rsReservations.getString("CheckOutDate") %></td>
                                                    <td>$<%= rsReservations.getDouble("TotalCost") %></td>
                                                    <td><%= rsReservations.getString("Status") %></td>
                                                    <td>
                                                        <% if ("active".equals(rsReservations.getString("Status"))) { %>
                                                            <a href="cart.jsp">Pay Now</a>
                                                        <% } else if ("completed".equals(rsReservations.getString("Status"))) { %>
                                                            <a href="cancel.jsp?reservationID=<%= rsReservations.getString("ReservationID") %>">Cancel Booking</a>
                                                        <% } %>
                                                    </td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                    <% 
                                    rsReservations.close();
                                }
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
                    </div>
                </div>
            </div>
        </section>
    </main>
    <footer>
        <%@ include file="includes/footer.jsp" %>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
