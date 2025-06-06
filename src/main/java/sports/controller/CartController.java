package sports.controller;

import sports.model.CartModel;
import sports.model.userModel;
import sports.database.CartDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle GET request - Show cart or remove item
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

        // Show updated cart
        List<CartModel> cartItems = new CartDAO().getCartByUserId(userId);
        req.setAttribute("cartItems", cartItems);
        RequestDispatcher dispatcher = req.getRequestDispatcher("cart.jsp");
        dispatcher.forward(req, resp);
    }

    // Handle POST request - Update cart quantities
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
                for (int i = 0; i < productIds.length; i++) {
                    try {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);

                        cartDAO.updateQuantity(userId, productId, quantity);

                    } catch (NumberFormatException e) {
                        e.printStackTrace(); // Bad input
                    }
                }
            }

            resp.sendRedirect("CartController");
        }
    }
}
	