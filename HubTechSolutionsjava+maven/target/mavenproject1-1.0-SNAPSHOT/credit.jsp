<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Stripe Payment</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Stripe JavaScript SDK -->
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body>
    <main class="container">
        <h1 class="mt-5">Stripe Payment Integration</h1>
        <p>Please click the Stripe button below to proceed with your payment.</p>

        <!-- Stripe button container -->
        <div id="stripe-button-container"></div>

        <!-- Back button -->
        <a href="cart.jsp" class="btn btn-secondary mt-3">Back to Profile</a>

        <!-- Stripe JavaScript -->
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
                        var stripe = Stripe('YOUR_PUBLIC_KEY');
                        var elements = stripe.elements();
                        var style = {
                            base: {
                                color: "#32325d",
                                fontFamily: 'Arial, sans-serif',
                                fontSmoothing: "antialiased",
                                fontSize: "16px",
                                "::placeholder": {
                                    color: "#aab7c4"
                                }
                            },
                            invalid: {
                                fontFamily: 'Arial, sans-serif',
                                color: "#fa755a",
                                iconColor: "#fa755a"
                            }
                        };
                        var card = elements.create('card', {style: style});
                        card.mount('#card-element');
                        // Handle form submission
                        var form = document.getElementById('payment-form');
                        form.addEventListener('submit', function(event) {
                            event.preventDefault();
                            stripe.createPaymentMethod({
                                type: 'card',
                                card: card,
                            }).then(function(result) {
                                if (result.error) {
                                    console.log(result.error.message);
                                } else {
                                    fetch('YOUR_CHARGE_ENDPOINT', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/json'
                                        },
                                        body: JSON.stringify({
                                            reservationID: reservationID,
                                            paymentMethod: result.paymentMethod.id
                                        })
                                    })
                                    .then(response => response.json())
                                    .then(data => {
                                        alert('Payment successful!');
                                        // Redirect the user to a confirmation page
                                        window.location.href = "confirmation.jsp";
                                    })
                                    .catch(error => console.error('Error:', error));
                                }
                            });
                        });
                    })
                    .catch(error => console.error('Error:', error));
            }

            // Call the function to get the total cost dynamically
            getTotalCost();
        </script>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
