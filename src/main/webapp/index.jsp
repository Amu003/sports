<%@ page import="java.util.List" %>
<%@ page import="sports.model.productModel" %>
<%@ page import="sports.model.userModel" %>

<jsp:include page="include/header.jsp" />

<%
    userModel user = (userModel) session.getAttribute("user");
    String sessionId = session.getId();
%>

<!-- Hidden debug info -->
<div class="d-none">
    <p>INDEX PAGE - Session ID: <%= sessionId %></p>
    <p>User: <%= (user != null) ? user.getName() : "null" %></p>
</div>

<!-- ===== Banner Area ===== -->	
<section class="banner-area">
    <div class="container">
        <div class="row fullscreen align-items-center justify-content-start">
            <div class="col-lg-12">
                <div class="active-banner-slider owl-carousel">
                    <div class="row single-slide align-items-center d-flex">
                        <div class="col-lg-5 col-md-6">
                            <div class="banner-content">
                                <h1>Players! New Nike <br>Is Here</h1>
                                <p>VISIT DEEPER TO GET COOL GEARS </p>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div class="banner-img">
                                <img class="img-fluid" src="img/banner/banner-img.png" alt="">
                            </div>
                        </div>
                    </div>
                   
                        <div class="col-lg-7">
                            <div class="banner-img">
                                <img class="img-fluid" src="img/banner/banner-img.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

<!-- ===== Features Area ===== -->
<section class="features-area section_gap">
    <div class="container">
        <div class="row features-inner">
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon"><img src="img/features/f-icon1.png" alt=""></div>
                    <h6>Free Delivery</h6>
                    <p>Free shipping under 2km range</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon"><img src="img/features/f-icon2.png" alt=""></div>
                    <h6>Return Policy</h6>
                    <p>Just Call us and Convince </p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon"><img src="img/features/f-icon3.png" alt=""></div>
                    <h6>24/7 Support</h6>
                    <p>Joke haina ni</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon"><img src="img/features/f-icon4.png" alt=""></div>
                    <h6>Secure Payment</h6>
                    <p>Your payment is safe with us</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== Static Category Area ===== -->
<section class="category-area">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-12">
                <div class="row">
                    <div class="col-lg-8 col-md-8">
                        <div class="single-deal">
                            <div class="overlay"></div>
                            <img class="img-fluid w-100" src="img/category/c1.jpg" alt="">
                            <div class="deal-details"><h6 class="deal-title">Sneaker for Sports</h6></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4">
                        <div class="single-deal">
                            <div class="overlay"></div>
                            <img class="img-fluid w-100" src="img/category/c2.jpg" alt="">
                            <div class="deal-details"><h6 class="deal-title">Street Style Shoes</h6></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4">
                        <div class="single-deal">
                            <div class="overlay"></div>
                            <img class="img-fluid w-100" src="img/category/c3.jpg" alt="">
                            <div class="deal-details"><h6 class="deal-title">Couple Accessories</h6></div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-8">
                        <div class="single-deal">
                            <div class="overlay"></div>
                            <img class="img-fluid w-100" src="img/category/c4.jpg" alt="">
                            <div class="deal-details"><h6 class="deal-title">Fitness Gear</h6></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Side image -->
            <div class="col-lg-4 col-md-6">
                <div class="single-deal">
                    <div class="overlay"></div>
                    <img class="img-fluid w-100" src="img/banner/img1.webp" alt="">
                    <div class="deal-details"><h6 class="deal-title">Special Edition</h6></div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== Latest Products ===== -->
<section class="section_gap">
    <div class="container">
        <div class="section-title text-center">
            <h1>All Product</h1>
            <p>Go to Category based on your game.</p>
        </div>
        <div class="row">
            <%
                List<productModel> products = (List<productModel>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (productModel product : products) {
                        request.setAttribute("product", product);
            %>
            <div class="col-lg-4 col-md-6">
                <jsp:include page="asset/product.jsp" />
            </div>
            <%  } 
                } else { %>
                <div class="col-lg-12 text-center">
                    <p>No products available.</p>
                </div>
            <% } %>
        </div>
    </div>
</section>

<!-- ===== Recommended Products (Content-Based) ===== -->
<% 
    List<productModel> recommendedProducts = (List<productModel>) request.getAttribute("recommendedProducts");
    if (recommendedProducts != null && !recommendedProducts.isEmpty()) { 
%>
<section class="section_gap">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center">
                <div class="section-title">
                    <h1>Recommended For You</h1>
                    <p>Based on your cart activity</p>
                </div>
            </div>
        </div>
        <div class="row">
            <% for (productModel product : recommendedProducts) {
                   request.setAttribute("product", product); %>
                <div class="col-lg-4 col-md-6">
                    <jsp:include page="asset/product.jsp" />
                </div>
            <% } %>
        </div>
    </div>
</section>
<% } %>


<!-- ===== Footer ===== -->
<jsp:include page="include/footer.jsp" />
