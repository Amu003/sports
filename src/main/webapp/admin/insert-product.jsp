<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="sports.model.CategoryModel" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Product</title>
    <style>
        form {
            width: 500px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        input, textarea, select {
            width: 100%;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Add New Product</h2>

<form action="insertProduct" method="post" enctype="multipart/form-data">

    <label>Product Name:</label>
    <input type="text" name="name" required>

    <label>Description:</label>
    <textarea name="description" rows="5" required></textarea>

    <label>Image:</label>
    <input type="file" name="image" required>

    <label>Price:</label>
    <input type="number" name="price" step="0.01" required>
    
     <label>Stock Quantity:</label>
<input type="number" name="stock" min="0" required>
<label>Brand:</label>
<input type="text" name="brand" required />

<label>Sizes (optional):</label>
<input type="text" name="sizes" placeholder="e.g., 40,41,42 or SH, LH" />



    <label>Category:</label>
    <select name="category">
   
   
    
<%
    List<sports.model.CategoryModel> catList = (List<sports.model.CategoryModel>) request.getAttribute("categories");
    if (catList != null) {
        for (sports.model.CategoryModel cat : catList) {
%>
    <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
<%
        }
    }
%>
</select>



    <input type="submit" value="Add Product">
</form>
<% String error = (String) request.getAttribute("errorMessage");
   if (error != null) { %>
    <p style="color: red; text-align: center;"><%= error %></p>
<% } %>

</body>
</html>

