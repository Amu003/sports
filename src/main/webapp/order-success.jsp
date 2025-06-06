<jsp:include page="include/header.jsp" />

<section class="order-success">
    <div class="container">
        <h2>Order Confirmation</h2>
        <p>Thank you for your order! Your order has been successfully placed.</p>
        <h4>Order Details:</h4>
        <p>Order ID: ${orderId}</p>
        <p>Total: ${totalAmount}</p>
        <p>Shipping Address: ${shippingAddress}</p>

        <h4>Items:</h4>
        <ul>
            <c:forEach var="item" items="${orderItems}">
                <li>${item.name} x ${item.quantity} - $${item.totalPrice}</li>
            </c:forEach>
        </ul>
    </div>
</section>

<jsp:include page="include/footer.jsp" />
