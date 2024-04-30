<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- adminNav.jsp -->

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
        <a class="navbar-brand" href="index.jsp">HubTech Solutions</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarAdmin">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <a class="nav-link active" href="adminDashboard.jsp">
                        Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminManageUsers.jsp">
                        Manage Users
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminManageReservations.jsp">
                        Manage Reservations
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminManageRooms.jsp">
                        Manage Rooms
                    </a>
                </li>
                <!-- Display username + menu -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-expanded="false">
                            <%= session.getAttribute("adminUsername") %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                            <li><a class="dropdown-item" href="adminDashboard.jsp">Admin View</a></li>                        </ul>
                        </ul>
                    </li>
                    
                    <script>
                        // JavaScript 4 dropdown on hover
                        document.querySelector('.nav-item.dropdown').addEventListener('mouseover', function () {
                            this.querySelector('.dropdown-menu').classList.add('show');
                        });
                        document.querySelector('.nav-item.dropdown').addEventListener('mouseout', function () {
                            this.querySelector('.dropdown-menu').classList.remove('show');
                        });
                    </script>
            </ul>
        </div>
</nav>
