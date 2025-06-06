<%@ page import="java.util.List" %>
<%@ page import="sports.model.CartModel" %>
<%@ page import="sports.database.CartDAO" %>
<%@ page import="sports.model.userModel" %>

<jsp:include page="include/header.jsp" />

<%
    userModel user = (userModel) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CartDAO cartDAO = new CartDAO();
    List<CartModel> cart = cartDAO.getCartByUserId(user.getId());

    double subtotal = 0.0;
%>

<!-- Start Banner Area -->
<section class="banner-area organic-breadcrumb">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Checkout</h1>
                <nav class="d-flex align-items-center">
                    <a href="index.jsp">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="#">Checkout</a>
                </nav>
            </div>
        </div>
    </div>
</section>

<!--================Checkout Area =================-->
<section class="checkout_area section_gap">
    <div class="container">
        <div class="billing_details">
            <div class="row">
                <div class="col-lg-8">
                    <h3>Billing Details</h3>
                    <form class="row contact_form" action="CheckoutController" method="post">
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" name="firstName" placeholder="First name" required>
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" name="lastName" placeholder="Last name" required>
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" name="number" placeholder="Phone number" required>
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="email" class="form-control" name="email" placeholder="Email Address" required>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" name="address" placeholder="Address" required>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" name="city" placeholder="City" required>
                        </div>
                        <div class="col-md-12 form-group">
                            <textarea class="form-control" name="orderNotes" placeholder="Order Notes"></textarea>
                        </div>
	                </div>
	
	                <div class="col-lg-4">
	                    <div class="order_box">
	                        <h2>Your Order</h2>
	                        <ul class="list">
							    <li><a href="#">Product <span>Total</span></a></li>
							    <%
							        if (cart != null && !cart.isEmpty()) {
							            for (CartModel item : cart) {
							                String productName = item.getProduct().getName();
							                int quantity = item.getQuantity();
							                double totalPrice = item.getTotalPrice();
							                subtotal += totalPrice;
							    %>
							    <li>
							        <a href="#">
							            <%= productName %> <span class="middle">x <%= quantity %></span>
							            <span class="last">Rs. <%= totalPrice %></span>
							        </a>
							    </li>
							    <% 
							            }
							        } else {
							    %>
							    <li><a href="#">Cart is empty.</a></li>
							    <% } %>
							</ul>
	
	                        <ul class="list list_2">
	                            <li><a href="#">Subtotal <span>Rs. <%= subtotal %></span></a></li>
	                            <li><a href="#">Shipping <span>Rs. 50</span></a></li>
	                            <li><a href="#">Total <span>Rs. <%= subtotal + 50 %></span></a></li>
	                        </ul>
	
	                        <div class="payment_item">
	                            <h5>Choose payment option</h5>
	                            <select name="paymentMethod" class="form-control" required>
	                                <option disabled selected>Select option</option>
	                                <option value="cod">Cash on delivery</option>
	                                <option value="esewa">Esewa</option>
	                                <option value="card">Stripe</option>
	                            </select>
	                            <br>
	                            <button type="submit" class="primary-btn">Process Payment</button>
	                        </div>
	                    </div>
	                </div>
                </form>  <!-- Form Tag Closure -->
            </div>
        </div>
    </div>
</section>
<!--================End Checkout Area =================-->

<jsp:include page="include/footer.jsp" />
