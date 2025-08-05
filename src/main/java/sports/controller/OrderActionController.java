package sports.controller;

import sports.database.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/OrderActionController")
public class OrderActionController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect("order-list");  // Redirect if action missing
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        boolean success = false;

        switch (action) {
            case "deleteItem":
                String orderItemIdStr = req.getParameter("orderItemId");
                if (orderItemIdStr != null) {
                    try {
                        int orderItemId = Integer.parseInt(orderItemIdStr);
                        success = orderDAO.deleteOrderItem(orderItemId);
                    } catch (NumberFormatException e) {
                        // ignore or log
                    }
                }
                break;

            case "deliver":
                String orderItemIdForDeliverStr = req.getParameter("orderItemId");
                if (orderItemIdForDeliverStr != null) {
                    try {
                        int orderItemId = Integer.parseInt(orderItemIdForDeliverStr);
                        success = orderDAO.markOrderItemDelivered(orderItemId);
                    } catch (NumberFormatException e) {
                        // ignore or log
                    }
                }
                break;

            default:
                // Unknown action, optionally handle or ignore
                break;
        }

        HttpSession session = req.getSession();
        if (success) {
            session.setAttribute("orderActionSuccess", "Operation successful.");
        } else {
            session.setAttribute("orderActionError", "Operation failed.");
        }

        resp.sendRedirect("order-list");
    }
}
