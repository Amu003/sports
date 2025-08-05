<html>
<head><title>Pay with eSewa</title></head>
<body>
    <h2>Make a Payment with eSewa</h2>
    <form method="POST" action="EsewaInitServlet">
        <label>Amount:</label><input type="text" name="amount" value="1000"><br>
        <label>Order ID:</label><input type="text" name="orderId" value="ORD123456"><br>
        <input type="submit" value="Pay Now">
    </form>
</body>
</html>
