package sports.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

import sports.model.productModel;
import sports.database.ProductDAO;
import sports.util.TFIDFSimilarity;

@WebServlet("/ProductDetailController")
public class ProductDetailController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(idStr);
            ProductDAO dao = new ProductDAO();

            productModel product = dao.getProductById(productId);
            if (product == null) {
                request.setAttribute("error", "Product not found.");
                request.getRequestDispatcher("product-detail.jsp").forward(request, response);
                return;
            }

            // Load all products
            List<productModel> allProducts = dao.getAllProducts();

            // Prepare descriptions for TF-IDF
            Map<Integer, String> productDescriptions = new HashMap<>();
            for (productModel p : allProducts) {
                productDescriptions.put(p.getId(), p.getDescription());
            }

            // TF-IDF Similarity
            TFIDFSimilarity tfidf = new TFIDFSimilarity();
            List<Integer> similarIds = tfidf.getSimilarProducts(productId, productDescriptions);

            // Load similar products
            List<productModel> relatedProducts = new ArrayList<>();
            for (int pid : similarIds) {
                productModel similarProduct = dao.getProductById(pid);
                if (similarProduct != null) {
                    relatedProducts.add(similarProduct);
                }
            }

            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);
            request.getRequestDispatcher("product-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
}
