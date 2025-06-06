<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Category</title>
    <style>
        form {
            width: 400px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        input {
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

<h2 style="text-align:center;">Add New Category</h2>

<form action="../addCategory" method="post">

    <label>Category Name:</label>
    <input type="text" name="name" required>

    <input type="submit" value="Add Category">
</form>

<!-- Show success or error message -->
<div style="text-align:center; margin-top:20px;">
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (successMessage != null) {
    %>
            <p style="color: green;"><%= successMessage %></p>
    <%
        } else if (errorMessage != null) {
    %>
            <p style="color: red;"><%= errorMessage %></p>
    <%
        }
    %>
</div>

</body>
</html>
