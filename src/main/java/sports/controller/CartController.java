package sports.controller;

import sports.model.CartModel;
import sports.model.userModel;
import sports.database.CartDAO;
import sports.database.ProductDAO;
import sports.model.productModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Object userObj = session.getAttribute("user");

        if (userObj == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        userModel user = (userModel) userObj;
        int userId = user.getId();

        String action = req.getParameter("action");

        if ("remove".equals(action)) {
            try {
                int productId = Integer.parseInt(req.getParameter("id"));
                CartDAO cartDAO = new CartDAO();
                cartDAO.removeFromCart(userId, productId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        List<CartModel> cartItems = new CartDAO().getCartByUserId(userId);
        req.setAttribute("cartItems", cartItems);
        RequestDispatcher dispatcher = req.getRequestDispatcher("cart.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Object userObj = session.getAttribute("user");

        if (userObj == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        userModel user = (userModel) userObj;
        int userId = user.getId();
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            String[] productIds = req.getParameterValues("productIds");
            String[] quantities = req.getParameterValues("quantities");

            if (productIds != null && quantities != null) {
                CartDAO cartDAO = new CartDAO();
                ProductDAO productDAO = new ProductDAO();

                StringBuilder errorMessage = new StringBuilder();

                for (int i = 0; i < productIds.length; i++) {
                    try {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);

                        productModel product = productDAO.getProductById(productId);
                        int stock = product.getStock();

                        if (quantity <= stock && quantity > 0) {
                            cartDAO.updateQuantity(userId, productId, quantity);
                        } else {
                            errorMessage.append("Product '")
                                        .append(product.getName())
                                        .append("' has only ")
                                        .append(stock)
                                        .append(" in stock.<br>");
                        }

                    } catch (NumberFormatException e) {
                        e.printStackTrace(); // Handle bad input
                    }
                }

                if (errorMessage.length() > 0) {
                    req.setAttribute("error", errorMessage.toString());
                    List<CartModel> cartItems = cartDAO.getCartByUserId(userId);
                    req.setAttribute("cartItems", cartItems);
                    req.getRequestDispatcher("cart.jsp").forward(req, resp);
                    return;
                }
            }

            resp.sendRedirect("CartController");
        }
    }
}
