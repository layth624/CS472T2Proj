<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PayPal Payment</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- PayPal JavaScript SDK -->
    <script src="https://www.paypal.com/sdk/js?client-id=YOUR_CLIENT_ID"></script>
</head>
<body>
    <main class="container">
        <h1 class="mt-5">PayPal Payment Integration</h1>
        <p>Please click the PayPal button below to proceed with your payment.</p>

        <!-- PayPal button container -->
        <div id="paypal-button-container"></div>

        <!-- Back button -->
        <a href="cart.jsp" class="btn btn-secondary mt-3">Back to Profile</a>

        <!-- PayPal JavaScript -->
        <script>
            // Function to get the total cost
            function getTotalCost() {
                // Retrieve reservationID
                const urlParams = new URLSearchParams(window.location.search);
                const reservationID = urlParams.get('reservationID');
                // Replace 'YOUR_API_ENDPOINT' with the actual
                fetch('YOUR_API_ENDPOINT?reservationID=' + reservationID)
                    .then(response => response.json())
                    .then(data => {
                        // Set the total cost dynamically
                        paypal.Buttons({
                            createOrder: function(data, actions) {
                                return actions.order.create({
                                    purchase_units: [{
                                        amount: {
                                            value: data.totalCost
                                        }
                                    }]
                                });
                            },
                            onApprove: function(data, actions) {
                                return actions.order.capture().then(function(details) {
                                    alert('Transaction completed by ' + details.payer.name.given_name + '!');
                                    // Redirect the user to a confirmation page
                                    window.location.href = "confirmation.jsp";
                                });
                            }
                        }).render('#paypal-button-container');
                    })
                    .catch(error => console.error('Error:', error));
            }
            getTotalCost();
        </script>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
