package sports.controller;

import sports.database.DbConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Model class to hold order data
class OrderView {
    private int orderId;
    private String customerName;
    private String productName;
    private int quantity;
    private double totalPrice;
    private Date orderDate;

    // Constructor
    public OrderView(int orderId, String customerName, String productName, int quantity, double totalPrice, Date orderDate) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.productName = productName;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
    }

    // Getters
    public int getOrderId() { return orderId; }
    public String getCustomerName() { return customerName; }
    public String getProductName() { return productName; }
    public int getQuantity() { return quantity; }
    public double getTotalPrice() { return totalPrice; }
    public Date getOrderDate() { return orderDate; }
}

@WebServlet("/order-list")
public class OrderListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<OrderView> orders = new ArrayList<>();

        String sql = "SELECT o.id AS order_id, CONCAT(o.first_name, ' ', o.last_name) AS customer_name, " +
                "p.name AS product_name, oi.quantity, oi.price, o.order_date " +
                "FROM orders o " +
                "JOIN order_items oi ON o.id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.id " +
                "ORDER BY o.order_date DESC";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderView order = new OrderView(
                        rs.getInt("order_id"),
                        rs.getString("customer_name"),
                        rs.getString("product_name"),
                        rs.getInt("quantity"),
                        rs.getDouble("price"),
                        rs.getDate("order_date")
                );
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("all-orders.jsp").forward(request, response);
    }
}
