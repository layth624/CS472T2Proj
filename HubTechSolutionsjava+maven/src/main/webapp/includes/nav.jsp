<%-- 
    Document   : nav
    Created on : Apr 4, 2024, 8:26:37 PM
    Author     : layth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- nav.jsp -->
            <!-- Navigation-->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container px-5">
                    <a class="navbar-brand" href="index.jsp">HubTech Solutions</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                            <!-- <li class="nav-item"><a class="nav-link" href="about.html">About</a></li> -->
                            <!-- <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li> -->
                            <!-- <li class="nav-item"><a class="nav-link" href="pricing.html">Pricing</a></li> -->
                            <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                            <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                            <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
                            <% if(session != null && session.getAttribute("username") != null) { %>
                                <!-- Logout Link -->
                                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                            <% } else { %>
                                <!-- Display something else if user not logged in -->
                            <% } %>
                            <!-- <li class="nav-item"><a class="nav-link" href="faq.html">FAQ</a></li> -->
                            <!--
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Blog</a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                    <li><a class="dropdown-item" href="blog-home.html">Blog Home</a></li>
                                    <li><a class="dropdown-item" href="blog-post.html">Blog Post</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Portfolio</a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
                                    <li><a class="dropdown-item" href="portfolio-overview.html">Portfolio Overview</a></li>
                                    <li><a class="dropdown-item" href="portfolio-item.html">Portfolio Item</a></li>
                                </ul>
                            </li>
                            -->
                        </ul>
                    </div>
                </div>
            </nav>
