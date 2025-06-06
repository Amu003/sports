package sports.database;

import java.sql.*;
import java.util.List;
import sports.model.CartModel;

public class OrderDAO {

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
            // Get database connection
            conn = DbConnection.getConnection();
            conn.setAutoCommit(false); // Start a transaction

            // Insert the order into the orders table
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

            // Calculate the total amount for the order
            double totalAmount = 0;
            for (CartModel item : cartItems) {
                totalAmount += item.getTotalPrice();
            }
            psOrder.setDouble(10, totalAmount);

            // Execute the order insert
            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return -1; // Return -1 to indicate failure
            }

            // Get the generated order ID
            rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert order items into the order_items table
            String orderItemsSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            psItems = conn.prepareStatement(orderItemsSql);
            for (CartModel item : cartItems) {
                psItems.setInt(1, orderId);
                psItems.setInt(2, item.getProduct().getId());
                psItems.setInt(3, item.getQuantity());
                psItems.setDouble(4, item.getTotalPrice());
                psItems.addBatch(); // Add the item to batch
            }

            // Execute the batch insert
            int[] batchResults = psItems.executeBatch();
            boolean success = true;
            for (int result : batchResults) {
                if (result == Statement.EXECUTE_FAILED) {
                    success = false;
                    break;
                }
            }

            // If batch insertion failed, rollback transaction
            if (!success) {
                conn.rollback();
                return -1; // Return -1 to indicate failure
            }

            // Commit transaction if everything was successful
            conn.commit();
            return orderId; // Return the generated order ID

        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback if error occurs
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            // Close resources in the finally block to avoid potential resource leaks
            try {
                if (rs != null) rs.close();
                if (psOrder != null) psOrder.close();
                if (psItems != null) psItems.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto commit to true after transaction
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return -1; // Return -1 to indicate failure
    }
}
