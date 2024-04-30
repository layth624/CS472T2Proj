<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
// admin password
final String ADMIN_PASSWORD = "1234";

// Check if password is correct
String adminAccessKey = request.getParameter("adminAccessKey");
if (adminAccessKey == null || !ADMIN_PASSWORD.equals(adminAccessKey)) {
    response.sendRedirect("adminAccess.jsp"); // Redirect to the password form page
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Admin Registration</title>
    <link rel="icon" type="image/x-icon" href="assets/icon.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column">
    <main class="flex-shrink-0">
        <%@ include file="includes/nav.jsp" %>
        <section class="py-5">
            <div class="container px-5">
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="text-center mb-5">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-person-circle"></i></div>
                        <h1 class="fw-bolder">Register an Admin Account</h1>
                    </div>
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <form id="adminRegistrationForm" method="post" action="adminRegisterAction.jsp">
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="name" name="name" type="text" placeholder="Enter your name..." required />
                                    <label for="name">Full name</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="adminUsername" name="adminUsername" type="text" placeholder="Select your Admin Username" required />
                                    <label for="adminUsername">Admin Username</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input class="form-control" id="adminPassword" name="adminPassword" type="password" placeholder="Select your Admin Password" required />
                                    <label for="adminPassword">Admin Password</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <select class="form-select" id="role" name="role" required>
                                        <option value="room management">Room Management</option>
                                        <option value="booking management">Booking Management</option>
                                        <option value="all">All</option>
                                    </select>
                                    <label for="role">Role</label>
                                </div>
                                
                                <div class="d-grid">
                                    <button class="btn btn-primary btn-lg" type="submit">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <%@ include file="includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>

