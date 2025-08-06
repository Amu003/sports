<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="sports.model.productModel" %>

<jsp:include page="include/header.jsp" />

<%
    String error = request.getParameter("error");
    productModel product = (productModel) request.getAttribute("product");
    List<productModel> relatedProducts = (List<productModel>) request.getAttribute("relatedProducts");
    if (product == null) {
        out.println("<div class='error-container'><h3>Product not found.</h3></div>");
        return;
    }
%>


<style>


    .single-product-details {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 40px;
        margin-bottom: 60px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .product-image {
        position: relative;
        background: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px;
    }

    .product-image img {
        max-width: 100%;
        max-height: 500px;
        object-fit: contain;
        border-radius: 8px;
        transition: transform 0.3s ease;
    }

    .product-image img:hover {
        transform: scale(1.05);
    }

    .single-product-details .product-details {
        padding: 40px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .product-title {
        font-size: 2.5rem;
        font-weight: 700;
        color: #2c3e50;
        margin-bottom: 10px;
        line-height: 1.2;
    }

    .product-price {
        font-size: 2rem;
        font-weight: 600;
        color: #e74c3c;
        margin-bottom: 20px;
    }

    .product-info {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
        margin-bottom: 20px;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 5px;
        align-items: start;
    }

    .info-label {
        font-weight: 600;
        color: #7f8c8d;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .info-value {
        font-size: 1.1rem;
        color: #2c3e50;
        font-weight: 500;
    }

    .stock-badge {
        display: inline-block;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .in-stock {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .out-of-stock {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .product-description {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        border-left: 4px solid #ff6c00;
        margin: 20px 0;
    }

    .description-title {
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 10px;
        font-size: 1.1rem;
    }

    .description-text {
        line-height: 1.6;
        color: #555;
    }

    .error-message {
        background: #f8d7da;
        color: #721c24;
        padding: 12px 16px;
        border-radius: 6px;
        border: 1px solid #f5c6cb;
        margin-bottom: 20px;
        font-weight: 500;
    }

    .add-to-cart-form {
        background: #f8f9fa;
        padding: 25px;
        border-radius: 8px;
        border: 1px solid #e9ecef;
    }

    .quantity-section {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 20px;
    }

    .quantity-label {
        font-weight: 600;
        color: #2c3e50;
        min-width: 80px;
    }

    .quantity-input {
        width: 80px;
        padding: 10px;
        border: 2px solid #e9ecef;
        border-radius: 6px;
        font-size: 1rem;
        text-align: center;
        transition: border-color 0.3s ease;
    }

    .quantity-input:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
    }

    .add-to-cart-btn {
        width: 100%;
        padding: 15px 30px;
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .add-to-cart-btn:hover:not(:disabled) {
        background: linear-gradient(135deg, #0056b3, #004085);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3);
    }

    .add-to-cart-btn:disabled {
        background: #6c757d;
        cursor: not-allowed;
        transform: none;
        box-shadow: none;
    }

    .section-divider {
        height: 2px;
        background: linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
        margin: 60px 0 40px 0;
        border: none;
    }

    .related-products-title {
        font-size: 2rem;
        font-weight: 700;
        color: #2c3e50;
        margin-bottom: 30px;
        text-align: center;
        position: relative;
    }

    .related-products-title::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background: #ff6c00;
        border-radius: 2px;
    }

    .related-products-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 30px;
        margin-bottom: 40px;
    }

    .no-products {
        text-align: center;
        color: #6c757d;
        font-style: italic;
        padding: 40px;
        background: #f8f9fa;
        border-radius: 8px;
    }

    .error-container {
        text-align: center;
        padding: 60px 20px;
        background: #f8f9fa;
        border-radius: 12px;
        margin: 40px 0;
    }

    .error-container h3 {
        color: #e74c3c;
        font-size: 1.5rem;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .single-product {
            grid-template-columns: 1fr;
            gap: 0;
        }

        .product-image {
            padding: 20px;
        }

        .product-details {
            padding: 30px 20px;
        }

        .product-title {
            font-size: 2rem;
        }

        .product-price {
            font-size: 1.5rem;
        }

        .product-info {
            grid-template-columns: 1fr;
        }

        .quantity-section {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }

        .related-products-grid {
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
    }

    @media (max-width: 480px) {
        .container {
            padding: 10px;
        }

        .product-title {
            font-size: 1.5rem;
        }

        .add-to-cart-form {
            padding: 20px;
        }
    }
</style>


<section class="banner-area organic-breadcrumb">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Products</h1>
                <nav class="d-flex align-items-center">
                    <a href="/">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="/products">Products<span class="lnr lnr-arrow-right"></span></a>
                    <span> <%= product.getName() %></span>
                </nav>
            </div>
        </div>
    </div>
</section>

<div class="container">

    <div class="single-product-details">
        <div class="product-image">
            <img src="/sports/<%= product.getImage() %>" alt="<%= product.getName() %>">
        </div>
        
        <div class="product-details">
            <h1 class="product-title"><%= product.getName() %></h1>
            <div class="product-price">Rs <%= product.getPrice() %></div>
            
            <div class="product-info">
                <div class="info-item">
                    <span class="info-label">Brand</span>
                    <span class="info-value"><%= product.getBrand() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Size</span>
                    <span class="info-value"><%= product.getSizes() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Stock Status</span>
                    <span class="stock-badge <%= product.getStock() > 0 ? "in-stock" : "out-of-stock" %>">
                        <%= product.getStock() > 0 ? product.getStock() + " in stock" : "Out of Stock" %>
                    </span>
                </div>
            </div>

            <div class="product-description">
                <div class="description-title">Product Description</div>
                <div class="description-text"><%= product.getDescription() %></div>
            </div>

            <% if (error != null && !error.isEmpty()) { %>
                <div class="error-message"><%= error %></div>
            <% } %>

            <form action="CategoryProductController" method="post" class="add-to-cart-form">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <input type="hidden" name="action" value="addToCart">
                
                <div class="quantity-section">
                    <label for="quantity" class="quantity-label">Quantity:</label>
                    <input type="number" 
                           name="quantity" 
                           id="quantity"
                           class="quantity-input"
                           value="1" 
                           min="1" 
                           max="<%= product.getStock() %>"
                           <%= product.getStock() <= 0 ? "disabled" : "" %>>
                </div>
                
                <button type="submit" 
                        class="primary-btn"
                        <%= product.getStock() <= 0 ? "disabled" : "" %>>
                    <%= product.getStock() > 0 ? "Add to Cart" : "Out of Stock" %>
                </button>
            </form>
        </div>
    </div>

    <!-- Related Products Section -->
    <hr class="section-divider">
    <h3 class="related-products-title">Related Products</h3>
    
    <div class="row">
        <%
            if (relatedProducts != null && !relatedProducts.isEmpty()) {
                for (productModel p : relatedProducts) {
                    request.setAttribute("product", p);
        %>
        <div class="col-lg-4 col-md-6">
            <jsp:include page="asset/product.jsp" />
        </div>
        <%
                }
            } else {
        %>
        <div class="no-products">
            <p>No related products found.</p>
        </div>
        <% } %>
    </div>
</div>

<jsp:include page="include/footer.jsp" />