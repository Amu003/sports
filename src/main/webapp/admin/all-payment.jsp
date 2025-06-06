<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>All Payments</title>
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
        tr:hover {
            background-color: #f1f1f1;
        }
        .status-paid {
            color: green;
        }
        .status-failed {
            color: red;
        }
    </style>
</head>
<body>

<h2>All Payments</h2>

<table>
    <tr>
        <th>Payment ID</th>
        <th>Order ID</th>
        <th>Payment Method</th>
        <th>Amount (Rs.)</th>
        <th>Payment Date</th>
        <th>Status</th>
    </tr>
    
    <!-- Static Dummy Payments -->
    <tr>
        <td>2001</td>
        <td>1001</td>
        <td>Credit Card</td>
        <td>7000</td>
        <td>2025-04-01</td>
        <td class="status-paid">Paid</td>
    </tr>
    
    <tr>
        <td>2002</td>
        <td>1002</td>
        <td>Debit Card</td>
        <td>2500</td>
        <td>2025-03-20</td>
        <td class="status-paid">Paid</td>
    </tr>
    
    <tr>
        <td>2003</td>
        <td>1003</td>
        <td>Net Banking</td>
        <td>7500</td>
        <td>2025-02-28</td>
        <td class="status-failed">Failed</td>
    </tr>

</table>

</body>
</html>
