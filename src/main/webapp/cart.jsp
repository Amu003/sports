<%@ page import="java.util.*, sports.model.CartModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    System.out.println("=== CART.JSP Executing ===");

    Object user = session.getAttribute("user");
    System.out.println("User from session: " + user);

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<CartModel> cart = (List<CartModel>) request.getAttribute("cartItems");
    double subtotal = 0;
%>

<jsp:include page="include/header.jsp" />

<!-- Start Banner Area -->
<section class="banner-area organic-breadcrumb">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Shopping Cart</h1>
                <nav class="d-flex align-items-center">
                    <a href="HomeController">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="CartController">Cart</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<!--================Cart Area =================-->
<section class="cart_area">
    <div class="container">
        <div class="cart_inner">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Product</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (cart != null && !cart.isEmpty()) {
                            for (CartModel item : cart) {
                                double totalPrice = item.getTotalPrice();
                                subtotal += totalPrice;
                    %>
                        <tr>
                            <form method="post" action="CartController">
                                <td>
                                    <div class="media">
                                        <div class="d-flex">
                                            <img src="/sports/<%= item.getProduct().getImage() %>" alt="" style="width: 100px; height: 100px;">
                                        </div>
                                        <div class="media-body">
                                            <p><%= item.getProduct().getName() %></p>
                                        </div>
                                    </div>
                                </td>
                                <td><h5>Rs. <%= item.getProduct().getPrice() %></h5></td>
                                <td>
                                    <input type="number"
                                           name="quantities"
                                           value="<%= item.getQuantity() %>"
                                           min="1"
                                           class="form-control quantity-input"
                                           data-price="<%= item.getProduct().getPrice() %>"
                                           style="width:80px;">
                                    <input type="hidden" name="productIds" value="<%= item.getProduct().getId() %>">
                                </td>
                                <td class="line-total">
                                    <h5>Rs. <%= String.format("%.2f", totalPrice) %></h5>
                                </td>
                                <td class="d-flex flex-column gap-1">
                                    <a href="CartController?action=remove&id=<%= item.getProduct().getId() %>" class="btn btn-danger btn-sm mb-1">
                                        <i class="fa fa-trash"></i> Remove
                                    </a>
                                    <button type="submit" name="action" value="update" class="btn btn-warning btn-sm">
                                        <i class="fa fa-refresh"></i> Update
                                    </button>
                                </td>
                            </form>
                        </tr>
                    <%
                            }
                    %>
                        <tr>
                            <td colspan="3"><h5>Subtotal</h5></td>
                            <td><h5 id="subtotal">Rs. <%= String.format("%.2f", subtotal) %></h5></td>
                            <td></td>
                        </tr>
                        <tr class="out_button_area">
                            <td colspan="5">
                                <div class="checkout_btn_inner d-flex align-items-center justify-content-end gap-2">
                                    <a class="gray_btn" href="CategoryProductController">Continue Shopping</a>
                                    <a class="primary-btn" href="checkout.jsp">Proceed to checkout</a>
                                </div>
                            </td>
                        </tr>
                    <%
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="text-center">
                                <h5>Your cart is empty!</h5>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<!--================End Cart Area =================-->

<jsp:include page="include/footer.jsp" />

<!-- ✅ JavaScript for live subtotal and row total update -->
<script>
    function updateCartTotals() {
        let subtotal = 0;

        document.querySelectorAll(".quantity-input").forEach(input => {
            const price = parseFloat(input.dataset.price);
            const quantity = parseInt(input.value);
            const lineTotal = price * quantity;

            const lineTotalCell = input.closest("tr").querySelector(".line-total h5");
            if (lineTotalCell) {
                lineTotalCell.textContent = "Rs. " + lineTotal.toFixed(2);
            }

            subtotal += lineTotal;
        });

        const subtotalElement = document.getElementById("subtotal");
        if (subtotalElement) {
            subtotalElement.textContent = "Rs. " + subtotal.toFixed(2);
        }
    }

    document.querySelectorAll(".quantity-input").forEach(input => {
        input.addEventListener("input", updateCartTotals);
    });
</script>
