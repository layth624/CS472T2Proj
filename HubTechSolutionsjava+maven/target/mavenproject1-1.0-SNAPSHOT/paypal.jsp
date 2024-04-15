<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PayPal Payment</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="css/styles.css" rel="stylesheet" />
    <!--  PayPal JavaScript SDK -->
    <script src="https://www.paypal.com/sdk/js?client-id=YOUR_CLIENT_ID"></script>
</head>
<body>
    <main class="container">
        <h1 class="mt-5">PayPal Payment Integration</h1>
        <p>Please click the PayPal button below to proceed with your payment.</p>

        <!-- PayPal button  -->
        <div id="paypal-button-container"></div>

        <script>
            paypal.Buttons({
                createOrder: function(data, actions) {
                    return actions.order.create({
                        purchase_units: [{
                            amount: {
                                value: '50.00' // adjust dynamically
                            }
                        }]
                    });
                },
                onApprove: function(data, actions) {
                    return actions.order.capture().then(function(details) {
                        alert('Transaction completed by ' + details.payer.name.given_name + '!');
                        // redirect the user to a confirmation page
                        window.location.href = "confirmation.jsp";
                    });
                }
            }).render('#paypal-button-container');
        </script>
    </main>

    <footer class="footer mt-auto py-3">
        <div class="container">
            <span class="text-muted">Place sticky footer content here.</span>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
