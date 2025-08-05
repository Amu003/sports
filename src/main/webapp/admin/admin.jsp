<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #2c3e50;
            float: left;
            padding-top: 20px;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 15px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #34495e;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
        }
        iframe {
            width: 100%;
            height: 90vh;
            border: none;
        }
    </style>
</head>
<body>

<div class="sidebar">


    <a href="../HomeController" target="contentFrame">Your Site</a>
    <%-- <a href="dashboard-content.jsp" target="contentFrame">Dashboard Home</a> --%>
   <a href="../insertProduct" target="contentFrame">Insert Product</a>

    
    
   <a href="insert-category.jsp" target="contentFrame">Insert Category</a>

    
    
    <a href="../userList" target="contentFrame">User List</a> <!-- Fixed typo cntentFrame to contentFrame -->
    <a href="ProductListController" target="contentFrame">Product List</a>
    <a href="../order-list" target="contentFrame">All Orders</a>

    <a href="all-payment.jsp" target="contentFrame">All Payments</a>
</div>

<div class="content">
    
    <p>Select an option from the sidebar to manage the application.</p>
     <iframe name="contentFrame"></iframe>
</div>

</body>
</html>
