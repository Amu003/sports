package sports.database;

import sports.model.CartModel;
import sports.model.OrderItemModel;
import sports.model.OrderModel;

import java.sql.*;
import java.util.*;

public class OrderDAO {

    // Save order and order items (your existing method)
    public int saveOrder(int userId, List<CartModel> cartItems, String firstName, String lastName,
                         String address, String city, String phone, String email,
                         String paymentMethod, String orderNotes) {

        String orderSql = "INSERT INTO orders (user_id, first_name, last_name, address, city, phone, email, payment_method, order_notes, total_amount) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItems = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false);

            // Insert order
            psOrder = conn.prepareStatement(orderSql, PreparedStatement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setString(2, firstName);
            psOrder.setString(3, lastName);
            psOrder.setString(4, address);
            psOrder.setString(5, city);
            psOrder.setString(6, phone);
            psOrder.setString(7, email);
            psOrder.setString(8, paymentMethod);
            psOrder.setString(9, orderNotes);

            double totalAmount = 0;
            for (CartModel item : cartItems) {
                totalAmount += item.getTotalPrice();
            }
            psOrder.setDouble(10, totalAmount);

            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return -1;
            }

            rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert order items
            String orderItemsSql = "INSERT INTO order_items (order_id, product_id, quantity, price, product_name, product_image, delivered) VALUES (?, ?, ?, ?, ?, ?, ?)";
            psItems = conn.prepareStatement(orderItemsSql);

            for (CartModel item : cartItems) {
                psItems.setInt(1, orderId);
                psItems.setInt(2, item.getProduct().getId());
                psItems.setInt(3, item.getQuantity());
                psItems.setDouble(4, item.getTotalPrice());
                psItems.setString(5, item.getProduct().getName());   // product name
                psItems.setString(6, item.getProduct().getImage());  // product image filename or URL
                psItems.setString(7, "no");                           // default delivered status is 'no'
                psItems.addBatch();
            }
            int[] batchResults = psItems.executeBatch();
            boolean success = true;
            for (int result : batchResults) {
                if (result == Statement.EXECUTE_FAILED) {
                    success = false;
                    break;
                }
            }

            if (!success) {
                conn.rollback();
                return -1;
            }

            conn.commit();
            return orderId;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (psOrder != null) psOrder.close();
                if (psItems != null) psItems.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return -1;
    }

    // Fetch all orders (order-level info)
    public List<OrderModel> getAllOrders() {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setFirstName(rs.getString("first_name"));
                order.setLastName(rs.getString("last_name"));
                order.setAddress(rs.getString("address"));
                order.setCity(rs.getString("city"));
                order.setPhone(rs.getString("phone"));
                order.setEmail(rs.getString("email"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setOrderNotes(rs.getString("order_notes"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderDate(rs.getString("order_date"));

                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Fetch order items grouped by orderId, including delivered status
    public Map<Integer, List<OrderItemModel>> getOrderItemsGroupedByOrderId() {
        Map<Integer, List<OrderItemModel>> orderItemsMap = new HashMap<>();

        String sql = "SELECT id, order_id, product_name, product_image AS image, quantity, price, delivered FROM order_items";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                OrderItemModel item = new OrderItemModel();
                item.setOrderId(orderId);
                item.setId(rs.getInt("id"));

                item.setProductName(rs.getString("product_name"));
                item.setImage(rs.getString("image"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setDelivered(rs.getString("delivered"));

                orderItemsMap.computeIfAbsent(orderId, k -> new ArrayList<>()).add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItemsMap;
    }

    // Delete an order item by ID
    public boolean deleteOrderItem(int orderItemId) {
        String sql = "DELETE FROM order_items WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Mark an order item as delivered
    public boolean markOrderItemDelivered(int orderItemId) {
        String sql = "UPDATE order_items SET delivered = 'yes' WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
