<%@ page import="sports.model.productModel" %>
<%
    productModel product = (productModel) request.getAttribute("product");
    if (product == null) {
        out.println("Product not found.");
        return;
    }
    int productId = product.getId();
%>
<div class="single-product">
    <img class="img-fluid" src="/sports/<%= product.getImage() %>" alt="">
    <div class="product-details">
        <h6><%= product.getName() %></h6>
        <div class="price">
            <h6>Rs <%= product.getPrice() %></h6>
        </div>
        <div class="prd-bottom">
            <form action="CategoryProductController" method="post">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <input type="hidden" name="action" value="addToBag">
                <button type="submit" class="social-info">
                    <span class="ti-bag"></span>
                    <p class="hover-text">add to bag</p>
                </button>
            </form>
            <div class="social-info popup-button" onclick="openPopup('<%= productId %>')">
                <span class="lnr lnr-move"></span>
                <p class="hover-text">view more</p>
            </div>
        </div>
    </div>
</div>

<div class="product-popup-box">
    <div class="popup-box">
        <span class="close">
            <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M17 17L1 1M17 1L1 17" stroke="#0C5D7A" stroke-width="2" stroke-linecap="round"></path>
            </svg>
        </span>
        <div class="content-wrap">
            <div class="left-content">
                <div class="img-holder">
                    <img decoding="async" class="img-cover" src="/sports/<%= product.getImage() %>" alt="">
                </div>
            </div>
            <div class="right-content">
                <div class="content">
                    <div class="main-title">
                        <h2 class="title"><%= product.getName() %></h2>
                    </div>
                    <div class="product-details p-m-0">
                        <p><%= product.getDescription() %></p>
                    </div>
                    <form action="CategoryProductController" method="post">
                        <div class="quantity-info mb-5">
                            <label for="quantity">Quantity:</label>
                            <div class="quantity-wrapper">
                                <div class="quantity-info">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <input type="hidden" name="action" value="addToCart">
                                    <button type="button" class="qty-btn qty-minus">-</button>
                                    <input type="number" name="quantity" class="quantity-input" value="1" min="1">
                                    <button type="button" class="qty-btn qty-plus">+</button>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="primary-btn">Add To Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>