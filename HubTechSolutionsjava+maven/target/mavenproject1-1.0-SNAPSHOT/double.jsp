<%@ page import="java.sql.*, com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Double Room Booking</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <script>
        function updatePrice() {
            var total = 0;
            var selectedRooms = document.querySelectorAll('#roomSelect option:checked');
            var numDays = getNumberOfDays();

            selectedRooms.forEach(function(option) {
                total += 150;  // Assuming each room costs $150 per day
            });

            total *= numDays;

            if (!isNaN(total) && total > 0) {
                document.getElementById('totalPrice').textContent = 'Total: $' + total;
                document.getElementById('totalPriceInput').value = total;
            } else {
                document.getElementById('totalPrice').textContent = '';
                document.getElementById('totalPriceInput').value = '';
            }
        }

        function getNumberOfDays() {
            var checkIn = new Date(document.getElementById('checkInDate').value);
            var checkOut = new Date(document.getElementById('checkOutDate').value);
            var diffTime = Math.abs(checkOut - checkIn);
            return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        }

        function submitForm() {
            var selectedRooms = document.querySelectorAll('#roomSelect option:checked');
            var roomIDs = [];
            selectedRooms.forEach(function(option) {
                roomIDs.push(option.value);
            });
            if (roomIDs.length === 0) {
                alert('Please select at least one room.');
                return false;
            }
            document.getElementById('selectedRoomID').value = roomIDs.join(",");
            document.getElementById('bookingForm').submit(); // Submit the form
        }

        function setMinDate() {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById('checkInDate').setAttribute("min", today);
            document.getElementById('checkOutDate').setAttribute("min", today);
        }

        window.onload = function() {
            setMinDate();
        };
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
                        <h1 class="fw-bolder">Multiple Room Booking</h1>
                    </div>
                    <div>
                        <% 
                        DatabaseConnector db = new DatabaseConnector();
                        Connection con = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            con = db.connect();
                            String query = "SELECT RoomID, RoomNumber, Status FROM Room WHERE RoomType = 'double' AND RoomNumber BETWEEN 200 AND 250 ORDER BY RoomNumber";
                            pstmt = con.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            rs = pstmt.executeQuery();
                            %>
                        <div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
                            <% int count = 0;
                            while (rs.next()) {
                                int roomID = rs.getInt("RoomID");
                                int roomNumber = rs.getInt("RoomNumber");
                                String status = rs.getString("Status");
                                String cssClass = status.equals("available") ? "available" : "booked";
                                %>
                                <div class="room-box <%= cssClass %>" style="flex: 0 0 18%; margin: 5px;"><%= roomNumber %></div>
                                <% count++;
                                if (count % 5 == 0 && rs.isLast() == false) { %>
                                    <div style="width: 100%; height: 20px; background-color: #ccc; margin: 20px 0;"></div> <!-- Hallway after every 5 boxes -->
                                <% }
                            }
                            rs.beforeFirst(); %>
                        </div>
                        <label for="roomSelect">Choose rooms:</label>
                        <select id="roomSelect" class="form-control mb-3" multiple size="5" onchange="updatePrice()">
                            <option value="">Select rooms</option>
                            <% while (rs.next()) {
                                int roomID = rs.getInt("RoomID");
                                int roomNumber = rs.getInt("RoomNumber");
                                String status = rs.getString("Status");
                                if (status.equals("available")) { %>
                                    <option value="<%= roomID %>">Room <%= roomNumber %></option>
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
                    <form id="bookingForm" method="POST" action="bookRoom.jsp" onsubmit="submitForm()">
                        <input type="hidden" name="roomType" value="single">
                        <input type="hidden" id="selectedRoomID" name="roomIDs">
                        <input type="hidden" id="selectedRoomNumber" name="roomNumbers">
                        <input type="hidden" id="totalPriceInput" name="totalCost" value="">

                        <div class="mb-3">
                            <label for="checkInDate" class="form-label">Check-In Date</label>
                            <input type="date" class="form-control" id="checkInDate" name="checkInDate" required onchange="updatePrice()">
                        </div>
                        <div class="mb-3">
                            <label for="checkOutDate" the "form-label">Check-Out Date</label>
                            <input type="date" class="form-control" id="checkOutDate" name="checkOutDate" required onchange="updatePrice()">
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
</body>
</html>
