<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- adminNav.jsp -->

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
        <a class="navbar-brand" href="index.jsp">HubTech Solutions</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarAdmin">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="adminDashboard.jsp">Dashboard</a>
                </li>
                <% 
                String role = (String) session.getAttribute("adminRole"); // Corrected session attribute name
                if (role != null) {
                    if (role.equals("user management") || role.equals("all")) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="adminManageUsers.jsp">Manage Users</a>
                </li>
                <% }
                    if (role.equals("booking management") || role.equals("all")) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="adminManageReservations.jsp">Manage Reservations</a>
                </li>
                <% }
                    if (role.equals("room management") || role.equals("all")) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="adminManageRooms.jsp">Manage Rooms</a>
                </li>
                <% }
                } %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-expanded="false">
                        <%= session.getAttribute("adminUsername") %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                        <li><a class="dropdown-item" href="adminDashboard.jsp">Admin View</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <script>
        // JavaScript for dropdown on hover
        document.querySelectorAll('.nav-item.dropdown').forEach(function(element) {
            element.addEventListener('mouseover', function () {
                this.querySelector('.dropdown-menu').classList.add('show');
            });
            element.addEventListener('mouseout', function () {
                this.querySelector('.dropdown-menu').classList.remove('show');
            });
        });
    </script>
</nav>
