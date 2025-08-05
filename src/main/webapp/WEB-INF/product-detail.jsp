<%@ page import="sports.model.productModel" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    productModel product = (productModel) request.getAttribute("product");
    if (product == null) {
        out.println("Product not found.");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= product.getName() %> - Product Details</title>
</head>
<body>

    <div class="product-container">
        <img src="/sports/<%= product.getImage() %>" alt="<%= product.getName() %>" width="300">
        <h2><%= product.getName() %></h2>
        <p><%= product.getDescription() %></p>
        <h3>Rs <%= product.getPrice() %></h3>

        <form action="CategoryProductController" method="post">
            <input type="hidden" name="productId" value="<%= product.getId() %>">
            <input type="hidden" name="action" value="addToCart">
            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" value="1" min="1">
            <button type="submit">Add to Cart</button>
        </form>
    </div>

</body>
</html>
