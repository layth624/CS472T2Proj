<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet"> <!-- Custom styles for this template -->
</head>
<body>
    <% 
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    %>
    <header>
        <%@ include file="includes/adminNav.jsp" %> <!-- Navigation bar specific to admin -->
    </header>
    <div class="container-fluid">
        <div class="row">
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                </div>
                <form name="menu">
                    <select name="sel" >
                    <option title="User" value="http://www.elbamebel.com/">User's Table</option>
                    <option title="Reservation" value="http://www.e-mebel.ru/">Reservation Table</option>
                    <option title="Rooms" value="http://nn.elbamebel.com/">Rooms' Table</option>
                    </select>
                </form>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">Export Data</button>
                    </div>
                </div>
                <!-- Dashboard content goes here -->
                <h4>Welcome, <%= session.getAttribute("adminUsername") %></h4>
                <p>This is your admin dashboard where you can manage everything!</p>
            </main>
        </div>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
