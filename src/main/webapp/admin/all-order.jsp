<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, sports.model.OrderModel, sports.model.OrderItemModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
            color: #2c3e50;
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

        tr:hover {
            background-color: #f1f1f1;
        }

        img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 5px;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
            padding: 6px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .delivered-checkbox {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #28a745
        }
    </style>
</head>
<body>

<h2>All Orders</h2>

<table>
    <tr>
        <th>Product Name</th>
        <th>Image</th>
        <th>Quantity</th>
        <th>Price (Rs.)</th>
        <th>Total Amount</th>
        <th>Customer</th>
        <th>Address</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Order Note</th>
        <th>Order Date</th>
        <th>Delivered</th>
        <th>Actions</th>
    </tr>

<%
    List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");
    Map<Integer, List<OrderItemModel>> orderItemsMap = (Map<Integer, List<OrderItemModel>>) request.getAttribute("orderItemsMap");

    if (orders != null && orderItemsMap != null) {
        for (OrderModel order : orders) {
            List<OrderItemModel> items = orderItemsMap.get(order.getId());
            if (items == null || items.isEmpty()) continue;

            for (OrderItemModel item : items) {
%>
    <tr>
        <td><%= item.getProductName() %></td>
        <td><img src="<%= request.getContextPath() + "/" + item.getImage() %>"  width="100" height="80" alt="Product Image" /></td>
      
        <td><%= item.getQuantity() %></td>
        <td><%= item.getPrice() %></td>
        <td><%= item.getQuantity() * item.getPrice() %></td>
        <td><%= order.getFirstName() + " " + order.getLastName() %></td>
        <td><%= order.getAddress() + ", " + order.getCity() %></td>
        <td><%= order.getEmail() %></td>
        <td><%= order.getPhone() %></td>
        <td><%= order.getOrderNotes() %></td>
        <td><%= order.getOrderDate() %></td>
        <td>
            <form method="post" action="<%= request.getContextPath() %>/OrderActionController">
    <input type="hidden" name="action" value="deliver"/>
    <input type="hidden" name="orderItemId" value="<%= item.getId() %>"/>
    <input type="checkbox" class="delivered-checkbox"
           onchange="this.form.submit();"
           <%= "yes".equalsIgnoreCase(item.getDelivered()) ? "checked disabled" : "" %> />
</form>

        </td>
        <td>
            <form method="post" action="<%= request.getContextPath() %>/OrderActionController" onsubmit="return confirm('Delete this order item?');">
                <input type="hidden" name="orderItemId" value="<%= item.getId() %>"/>
                <input type="hidden" name="orderId" value="<%= order.getId() %>"/>
                <input type="hidden" name="action" value="deleteItem"/>
                <button type="submit" class="delete-btn">Delete</button>
            </form>
        </td>
    </tr>
<%
            }
        }
    } else {
%>
    <tr><td colspan="13">No order data found.</td></tr>
<%
    }
%>
</table>

</body>
</html>
