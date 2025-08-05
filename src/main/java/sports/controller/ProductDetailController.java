package sports.controller;

import sports.model.productModel;
import sports.database.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProductDetailController")
public class ProductDetailController extends HttpServlet {
	  private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String productIdStr = req.getParameter("id");
        if (productIdStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr);
                productModel product = productDAO.getProductById(productId);

                if (product != null) {
                    req.setAttribute("product", product);
                    req.getRequestDispatcher("product-detail.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect("errorPage.jsp"); // Product not found
                }
            } catch (NumberFormatException e) {
                resp.sendRedirect("errorPage.jsp"); // Invalid ID
            }
        } else {
            resp.sendRedirect("errorPage.jsp"); // Missing ID
        }
    }
}
