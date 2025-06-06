package sports.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import sports.model.*;
import sports.database.*;

@WebServlet("/CheckoutController")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        userModel user = (userModel) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<CartModel> cart = (List<CartModel>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            req.setAttribute("error", "Your cart is empty.");
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
            return;
        }

        // Get order details from the form
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String phone = req.getParameter("number");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String orderNotes = req.getParameter("orderNotes");
        String paymentMethod = req.getParameter("paymentMethod");

        // Validate form fields
        if (firstName == null || lastName == null || phone == null || email == null || address == null || city == null || paymentMethod == null) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
            return;
        }

        // Calculate total amount
        double totalAmount = 0;
        for (CartModel item : cart) {
            totalAmount += item.getTotalPrice();
        }

        try {
            // Save order to the database
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.saveOrder(user.getId(), cart, firstName, lastName, address, city, phone, email, paymentMethod, orderNotes);

            if (orderId == -1) {
                req.setAttribute("error", "There was a problem processing your order. Please try again.");
                req.getRequestDispatcher("checkout.jsp").forward(req, resp);
                return;
            }

            // Clear cart after successful order
            session.removeAttribute("cart");

            // Set confirmation message
            String successMessage = "Your order has been placed successfully. Your order ID is: " + orderId + ". Total Amount: " + totalAmount;

            // Set attributes for success message
            req.setAttribute("successMessage", successMessage);
            req.setAttribute("paymentMethod", paymentMethod);
            req.setAttribute("address", address);
            req.setAttribute("phone", phone);

            // Directly print success message (instead of forwarding to a new page)
            resp.setContentType("text/html");
            resp.getWriter().println("<html><body>");
            resp.getWriter().println("<h2>" + successMessage + "</h2>");
            resp.getWriter().println("<p>Thank you for your purchase!</p>");
            resp.getWriter().println("<a href='index.jsp'>Go back to home page</a>");
            resp.getWriter().println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();  // Log error (You may want to log this in a log file)
            req.setAttribute("error", "Something went wrong while processing your order. Please try again.");
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
        }
    }
}
