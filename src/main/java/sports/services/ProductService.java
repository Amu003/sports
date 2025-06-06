package sports.services;


import sports.model.productModel;
import sports.database.ProductDAO;
import sports.model.CategoryModel;
import sports.database.CategoryDAO;

import java.util.List;

public class ProductService {

    private ProductDAO productDAO;

    public ProductService() {
        productDAO = new ProductDAO();  // Initialize the ProductDAO
    }

    // Method to get all products
    public List<productModel> getAllProducts() {
        return productDAO.getAllProducts();
    }

    // Method to get products by category (optional)
    public List<productModel> getProductsByCategory(String category) {
        return productDAO.getProductsByCategory(category);
    }

    // Method to get all distinct categories from the products table
    public List<String> getAllCategories() {
        return productDAO.getAllCategories();  // Call DAO to get distinct categories
    }

    // Method to add a product (insertion)
    public boolean addProduct(productModel product) {
        return productDAO.insertProduct(product);
    }
    private CategoryDAO categoryDAO = new CategoryDAO();

    public List<CategoryModel> getAllCategoryList() {
       return categoryDAO.getAllCategories();
  }
    public int getCategoryIdByName(String categoryName) {
        return categoryDAO.getCategoryIdByName(categoryName);
    }
    //delete
    public boolean deleteProductById(int id) {
        ProductDAO dao = new ProductDAO();
        return dao.deleteProduct(id);
    }
    // Fetch product by ID
    public productModel getProductById(int id) {
        return productDAO.getProductById(id);
    }

    // Update product information
    public void updateProduct(productModel product) {
        productDAO.updateProduct(product);
    }
}

