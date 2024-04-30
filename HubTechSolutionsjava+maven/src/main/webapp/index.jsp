<%-- 
    Document   : index
    Created on : Apr 4, 2024, 9:07:20 PM
    Author     : layth
--%>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>HubTech Solutions</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/icon.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body class="d-flex flex-column h-100">
        <main class="flex-shrink-0">
            <!-- Nav-->
            <%@ include file="includes/nav.jsp" %>
            <!-- Header-->
            <header class="bg-dark py-5">
                <div class="container px-5">
                    <div class="row gx-5 align-items-center justify-content-center">
                        <div class="col-lg-8 col-xl-7 col-xxl-6">
                            <div class="my-5 text-center text-xl-start">
                                <img src="assets/icon.png" alt="..." height = "200 px" width="200 px"/>
                                <h1 class="display-5 fw-bolder text-white mb-2">HubTech Solutions</h1>
                                <p class="lead fw-normal text-white-50 mb-4">Renovating the way you book your hotel rooms</p>
                                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                                    <a class="btn btn-primary btn-lg px-4 me-sm-3" href="#options">Get Started</a>
                                    <a class="btn btn-outline-light btn-lg px-4" href="#features">Learn More</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="assets/hotel.jpg" alt="..." /></div>
                    </div>
                </div>
            </header>
            <!-- Quote Old section-->
            <!-- Blog preview section-->
            <section class="py-5" id="options">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <div class="text-center">
                                <h2 class="fw-bolder">Book a room</h2>
                                <p class="lead fw-normal text-muted mb-5">Select the type of room you are picking.</p>
                            </div>
                        </div>
                    </div>
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <a href = "single.jsp"><img class="card-img-top" src="assets/single.png" alt="..." /></a>
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">100 a day</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="single.jsp"><h5 class="card-title mb-3">Single room</h5></a>
                                    <p class="card-text mb-0">Welcome to our cozy haven, perfect for the solo traveler seeking comfort and convenience. Our single room is a snug retreat featuring a plush, queen-sized bed enveloped in luxurious linens. The room is equipped with modern amenities, including high-speed Wi-Fi, a flat-screen TV with international channels, and a minibar stocked with refreshments. <br><br> The sleek, private bathroom offers a rainfall shower, fluffy towels, and complimentary toiletries to enhance your stay. Designed with the individual guest in mind, this room combines functionality with serenity, making it an ideal space to unwind after a day of exploration.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <a href = "double.jsp"><img class="card-img-top" src="assets/double.png" alt="..." /></a>
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">150 a day</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="double.jsp"><h5 class="card-title mb-3">Double room</h5></a>
                                    <p class="card-text mb-0">Embark on a memorable journey with a companion and immerse yourselves in the comfort of our double room. This room boasts two sumptuous twin beds or a king-sized bed, tailored to your preference and adorned with crisp, premium bedding. The space is thoughtfully designed with a harmonious blend of elegance and functionality, featuring a work desk, high-speed Wi-Fi, and a flat-screen TV. <br><br> Refresh yourselves in the private bathroom equipped with a refreshing shower, soft towels, and exclusive toiletries. Whether you're here for business or leisure, our double room promises a relaxing and convenient stay for two.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <a href = "suite.jsp"><img class="card-img-top" src="assets/suite.png" alt="..." /></a>
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">250 a day</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="suite.jsp"><h5 class="card-title mb-3">Suite</h5></a>
                                    <p class="card-text mb-0">Step into the epitome of luxury in our spacious suite, where elegance meets unparalleled comfort. This exquisite suite features a separate living area and bedroom, furnished with a king-sized bed draped in the finest linens and a comfortable sofa set in the living room. The suite is outfitted with premium amenities, including two flat-screen TVs, a work desk, high-speed Wi-Fi, and a minibar. <br><br> The lavish bathroom serves as a private spa, offering a large soaking tub, a separate rainfall shower, plush towels, and deluxe toiletries. Floor-to-ceiling windows provide breathtaking views, ensuring an unforgettable experience. Ideal for those desiring extra space and luxury, our suite offers the perfect sanctuary for relaxation and indulgence.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Newsletter old location -->
                    <!-- Features section-->
                    <section class="py-5" id="features">
                        <div class="container px-5 my-5">
                            <div class="row gx-5">
                                <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">What we offer</h2></div>
                                <div class="col-lg-8">
                                    <div class="row gx-5 row-cols-1 row-cols-md-2">
                                        <div class="col mb-5 h-100">
                                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-collection"></i></div>
                                            <h2 class="h5">Unmatched Comfort and Luxury</h2>
                                            <p class="mb-0">Each room showcases plush bedding and top-tier amenities, guaranteeing a supremely comfortable and luxurious stay.</p>
                                        </div>
                                        <div class="col mb-5 h-100">
                                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-building"></i></div>
                                            <h2 class="h5">Prime Location</h2>
                                            <p class="mb-0">Strategically located in the city's heart, our hotel ensures easy access to key attractions and business hubs, ideal for both leisure and corporate guests.</p>
                                        </div>
                                        <div class="col mb-5 mb-md-0 h-100">
                                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-stars"></i></div>
                                            <h2 class="h5">Exceptional Service</h2>
                                            <p class="mb-0">Our team's commitment to excellence is evident in the personalized, attentive service provided to every guest, making each stay memorable.</p>
                                        </div>
                                        <div class="col h-100">
                                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                            <h2 class="h5">Hassle-Free Booking</h2>
                                            <p class="mb-0">With our streamlined booking process, guests can secure their stay quickly and effortlessly, ensuring a seamless experience from start to finish.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </section>
        </main>
        <!-- Footer-->
        <%@ include file="includes/footer.jsp" %>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>

