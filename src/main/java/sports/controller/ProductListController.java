
package sports.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sports.services.ProductService;
import sports.model.productModel;
import java.util.List;


/**
 * Servlet implementation class ProductListController
 */
@WebServlet("/admin/ProductListController")
public class ProductListController extends HttpServlet {
	 private static final long serialVersionUID = 1L;
    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	 // Fetch all products from the database
        List<productModel> productList = productService.getAllProducts();
        // Set the products as a request attribute
       // req.setAttribute("products", productList);
        // Forward to the admin product list page
       // req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);
        // Check if the user is an admin or a customer
        String path = req.getRequestURI();

        // If the path contains '/admin/', it's for the admin
        if (path.contains("/admin/")) {
            // Admin view: Forward to the admin product list page
            req.setAttribute("products", productList);
            req.getRequestDispatcher("/admin/product-list.jsp").forward(req, resp);
        } else {
            // Customer view: Forward to the category page
            req.setAttribute("products", productList);
            req.getRequestDispatcher("/asset/product.jsp").forward(req, resp);
        }
    }
}
