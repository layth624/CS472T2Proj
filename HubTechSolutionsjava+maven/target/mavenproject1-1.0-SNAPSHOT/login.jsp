<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Login to Your Account</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
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
                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-lock-fill"></i></div>
                            <h1 class="fw-bolder">Login to Your Account</h1>
                        </div>
                        <div class="row gx-5 justify-content-center">
                            <div class="col-lg-8 col-xl-6">
                                <form id="loginForm" method="post" action="loginAction.jsp"> 
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="username" name="username" type="text" placeholder="Enter your username" required />
                                        <label for="username">Username</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="password" name="password" type="password" placeholder="Enter your Password" required />
                                        <label for="password">Password</label>
                                    </div>
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">Log In</button>
                                    </div>
                                </form>
                                <div class="text-center mt-4">
                                     <!-- <a href="forgotPassword.jsp">Forgot Password?</a> <!-- Link to password recovery not sure if we need this-->
                                </div>
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
