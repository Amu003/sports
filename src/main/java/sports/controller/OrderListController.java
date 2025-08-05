package sports.controller;

import sports.database.OrderDAO;
import sports.model.OrderModel;
import sports.model.OrderItemModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/order-list")
public class OrderListController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDAO orderDAO = new OrderDAO();

        // 1. Get all orders (order-level info)
        List<OrderModel> orders = orderDAO.getAllOrders();

        // 2. Get all order items grouped by order ID
        Map<Integer, List<OrderItemModel>> orderItemsMap = orderDAO.getOrderItemsGroupedByOrderId();

        // 3. Set as request attributes
        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsMap", orderItemsMap);

        // 4. Forward to JSP
        request.getRequestDispatcher("/admin/all-order.jsp").forward(request, response);
        
        
    }
}
