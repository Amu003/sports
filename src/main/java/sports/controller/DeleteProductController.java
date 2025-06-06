package sports.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sports.services.*;

/**
 * Servlet implementation class DeleteProductController
 */
@WebServlet("/admin/delete-product")
public class DeleteProductController extends HttpServlet {
	 private static final long serialVersionUID = 1L;
    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        productService.deleteProductById(id);
        resp.sendRedirect("ProductListController"); // Refresh product list
    }
}
