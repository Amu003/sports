<%@ page import="java.util.*,sports.controller.OrderListController" %>
<%@ page contentType="text/html; charset=UTF-8" %><%@ page import="sports.model.OrderItemView" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Orders</title>
    <style>
        /* same CSS as before */
    </style>
</head>
<body>

<h2>All Orders</h2>

<table>
    <tr>
        <th>Order ID</th>
        <th>Customer Name</th>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Total Price (Rs.)</th>
        <th>Order Date</th>
    </tr>

    <%
    List<OrderItemView> orders = (List<OrderItemView>) request.getAttribute("orders");
    if (orders != null) {
        for (OrderItemView order : orders) {
%>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getCustomerName() %></td>
            <td><%= order.getProductName() %></td>
            <td><%= order.getQuantity() %></td>
            <td><%= order.getTotalPrice() %></td>
            <td><%= order.getOrderDate() %></td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="6">No orders found.</td></tr>
    <%
        }
    %>
</table>

</body>
</html>
