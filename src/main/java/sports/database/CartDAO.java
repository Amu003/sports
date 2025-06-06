package sports.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sports.model.CartModel;
import sports.model.productModel;

public class CartDAO {

    // Save the cart item (product) for the user
    public boolean saveCartItem(int userId, productModel product, int quantity) {
        boolean success = false;
        String query = "INSERT INTO cart(user_id, product_id, quantity) VALUES (?, ?, ?)";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, product.getId());
            ps.setInt(3, quantity);

            success = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace(); // Handle error gracefully in production
        }

        return success;
    }

    // Get the cart items for the user based on userId
    public List<CartModel> getCartByUserId(int userId) {
        List<CartModel> cartItems = new ArrayList<>();
        String query = "SELECT p.*, c.quantity FROM cart c INNER JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                productModel product = new productModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getInt("category_id"));

                int quantity = rs.getInt("quantity");

                CartModel cartItem = new CartModel(product, quantity);
                cartItems.add(cartItem);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception
        }

        return cartItems;
    }

    // Update the quantity of a specific product for a user
    public void updateQuantity(int userId, int productId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);  // Set the new quantity
            ps.setInt(2, userId);    // Set the userId
            ps.setInt(3, productId); // Set the productId

            ps.executeUpdate();  // Execute the update

        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exception
        }
    }
    public void removeFromCart(int userId, int productId) {
        String query = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
