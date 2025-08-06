package sports.database;

import sports.model.productModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Insert a product into database
    public boolean insertProduct(productModel product) {
        String sql = "INSERT INTO products (name, description, image, price, category_id, stock, brand, sizes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setString(3, product.getImage());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getCategory());
            ps.setInt(6, product.getStock());
            ps.setString(7, product.getBrand());
            ps.setString(8, product.getSizes());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch all products
    public List<productModel> getAllProducts() {
        List<productModel> products = new ArrayList<>();
        String query = "SELECT * FROM products";

        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                productModel product = new productModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getInt("category_id"));
                product.setStock(rs.getInt("stock"));
                product.setBrand(rs.getString("brand"));
                product.setSizes(rs.getString("sizes"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Fetch products by category
    public List<productModel> getProductsByCategory(String category) {
        List<productModel> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE category_id = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                productModel product = new productModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getInt("category_id"));
                product.setStock(rs.getInt("stock"));
                product.setBrand(rs.getString("brand"));
                product.setSizes(rs.getString("sizes"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Fetch all distinct categories
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category_id FROM products";
        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                categories.add(rs.getString("category_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Delete a product
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch a product by ID
    public productModel getProductById(int id) {
        productModel product = null;
        String query = "SELECT * FROM products WHERE id = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new productModel();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                product.setPrice(rs.getDouble("price"));
                product.setCategory(rs.getInt("category_id"));
                product.setStock(rs.getInt("stock"));
                product.setBrand(rs.getString("brand"));
                product.setSizes(rs.getString("sizes"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Update a product
    public boolean updateProduct(productModel product) {
        String sql = "UPDATE products SET name = ?, description = ?, image = ?, price = ?, category_id = ?, stock = ?, brand = ?, sizes = ? WHERE id = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setString(3, product.getImage());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getCategory());
            ps.setInt(6, product.getStock());
            ps.setString(7, product.getBrand());
            ps.setString(8, product.getSizes());
            ps.setInt(9, product.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean reduceStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);  // Ensure stock is not reduced below 0

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
