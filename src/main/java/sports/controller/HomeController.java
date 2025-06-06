package sports.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sports.database.ProductDAO;
import sports.model.productModel;
import sports.services.ProductService;

/**
 * Servlet implementation class HomeController
 */


@SuppressWarnings("serial")
@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<productModel> products = productDAO.getAllProducts();
        request.setAttribute("products", products);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
