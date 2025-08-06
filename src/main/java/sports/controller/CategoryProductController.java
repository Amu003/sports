package sports.controller;

import sports.model.productModel;
import sports.model.CartModel;
import sports.model.CategoryModel;
import sports.model.userModel; // Make sure this exists and contains getId()
import sports.database.CategoryDAO;
import sports.database.ProductDAO;
import sports.database.CartDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CategoryProductController")
public class CategoryProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;
    private ProductDAO productDAO;
    private CartDAO cartDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
        productDAO = new ProductDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CategoryModel> categories = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categories);

        String categoryId = request.getParameter("categoryId");
        List<productModel> products;

        if (categoryId != null && !categoryId.isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                products = productDAO.getProductsByCategory(catId); // pass int here
            } catch (NumberFormatException e) {
                products = productDAO.getAllProducts(); // fallback if parsing fails
            }
        } else {
            products = productDAO.getAllProducts();
        }


        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("category.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Correctly extract userId from UserModel object
        int userId = ((userModel) user).getId();

        // Initialize session cart
        @SuppressWarnings("unchecked")
        List<CartModel> cart = (List<CartModel>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("addToBag".equals(action) || "addToCart".equals(action)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                String quantityParam = req.getParameter("quantity");
                int quantity = (quantityParam == null || quantityParam.isEmpty()) ? 1 : Integer.parseInt(quantityParam);

                productModel product = productDAO.getProductById(productId);

                if (product == null) {
                    resp.sendRedirect("product.jsp?id=" + productId + "&error=" + 
                        java.net.URLEncoder.encode("Product not found.", "UTF-8"));
                    return;
                }

                if (product.getStock() < quantity) {
                    String msg = "Sorry, only " + product.getStock() + " item(s) in stock.";
                    resp.sendRedirect("product.jsp?id=" + productId + "&error=" + 
                        java.net.URLEncoder.encode(msg, "UTF-8"));
                    return;
                }

                if (quantity <= 0) {
                    resp.sendRedirect("product.jsp?id=" + productId + "&error=" + 
                        java.net.URLEncoder.encode("Invalid quantity.", "UTF-8"));
                    return;
                }

                // Update session cart
                boolean found = false;
                for (CartModel item : cart) {
                    if (item.getProduct().getId() == productId) {
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartModel(product, quantity));
                }

                // Save to database
                cartDAO.saveCartItem(userId, product, quantity);

                // Redirect accordingly
                resp.sendRedirect("CartController");

            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid product ID or quantity.");
                req.getRequestDispatcher("errorPage.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Invalid action.");
            req.getRequestDispatcher("errorPage.jsp").forward(req, resp);
        }
    }
}
