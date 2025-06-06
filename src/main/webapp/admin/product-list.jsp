<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import=" java.util.List" %>
<%@ page import="sports.model.productModel" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 95%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .edit-btn {
            padding: 5px 10px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .edit-btn:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>

<h2>Product List</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Image</th>
        <th>Price (Rs.)</th>
        <th>Category ID</th>
        <th>Actions</th> <!-- New Actions Column -->
    </tr>

    <%
    List<productModel> products = (List<productModel>) request.getAttribute("products");
    if (products != null && !products.isEmpty()) {
        for (productModel product : products) {
%>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= product.getDescription() %></td>
            <td><img src="<%= request.getContextPath() + "/" + product.getImage() %>" width="100" height="80" alt="Product Image"></td>


            <td><%= product.getPrice() %></td>
            <td><%= product.getCategory() %></td>
            <td>
    <a href="edit-product.jsp?id=<%= product.getId() %>">
        <button class="edit-btn">Edit</button>
    </a>
    <a href="delete-product?id=<%= product.getId() %>">
        <button class="edit-btn" style="background-color: #e74c3c;">Delete</button>
    </a>
</td>
 <!-- Edit Button -->
      </tr>
<%
        }
    } else {
%>
<tr><td colspan="6">No products found.</td></tr>
<%
    }
%>
</table>

</body>
</html>
