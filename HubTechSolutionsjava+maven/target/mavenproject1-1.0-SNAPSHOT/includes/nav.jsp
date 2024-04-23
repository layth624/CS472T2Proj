<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- nav.jsp -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
        <a class="navbar-brand" href="index.jsp">HubTech Solutions</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                <!-- Hidden list menus 
                <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
                
                <li class="nav-item"><a class="nav-link" href="pricing.html">Pricing</a></li>
                <li class="nav-item"><a class="nav-link" href="faq.html">FAQ</a></li>
                -->
                <% if(session != null && session.getAttribute("username") != null) { %>
                    <!-- Display username + menu -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" aria-expanded="false">
                            <%= session.getAttribute("username") %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
                            <li><a class="dropdown-item" href="cart.jsp">Cart</a></li>
                            <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
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
                <% } else { %>
                    <!-- toggle register + login option -->
                    <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="adminLogin.jsp"> Admin Login</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
