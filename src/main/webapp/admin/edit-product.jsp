<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sports.model.productModel" %>
<%@ page import="sports.services.ProductService" %>
<%@ page import="sports.model.CategoryModel" %>
<%@ page import="java.util.List" %>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        .form-container {
            width: 60%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group textarea {
            resize: vertical;
        }
        .btn {
            padding: 10px 20px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>

<h2>Edit Product</h2>

<%
    int productId = Integer.parseInt(request.getParameter("id"));
    ProductService productService = new ProductService();
    productModel product = productService.getProductById(productId);
    List<CategoryModel> categories = productService.getAllCategoryList();
%>

<div class="form-container">
 <form action="<%= request.getContextPath() %>/update-product" method="POST" enctype="multipart/form-data">

        <!-- Hidden field for product ID -->
        <input type="hidden" name="id" value="<%= product.getId() %>">

        <div class="form-group">
            <label for="name">Product Name</label>
            <input type="text" id="name" name="name" value="<%= product.getName() %>" required>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" required><%= product.getDescription() %></textarea>
        </div>

        <div class="form-group">
            <label for="price">Price (Rs.)</label>
            <input type="number" id="price" name="price" value="<%= product.getPrice() %>" required>
        </div>

        <div class="form-group">
            <label>Current Image</label><br>
            <img src="/sports/<%= product.getImage() %>" alt="Product Image" width="150" height="150">
        </div>

        <div class="form-group">
            <label for="image">Upload New Image (Optional)</label>
            <input type="file" name="image" id="image">
        </div>
        <div class="form-group">
    <label for="stock">Stock Quantity</label>
    <input type="number" id="stock" name="stock" value="<%= product.getStock() %>" required>
    
    <label>Brand:</label>
<input type="text" name="brand" value="<%= product.getBrand() %>" required />

<label>Sizes (optional):</label>
<input type="text" name="sizes" value="<%= product.getSizes() %>" />
    
</div>
        

        <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="category_id" required>
                <%
                    for (CategoryModel cat : categories) {
                        int catId = cat.getId();
                        String catName = cat.getName();
                %>
                    <option value="<%= catId %>" <%= (product.getCategory() == catId) ? "selected" : "" %>><%= catName %></option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <button type="submit" class="btn">Update Product</button>
        </div>
    </form>
</div>

</body>
</html>
