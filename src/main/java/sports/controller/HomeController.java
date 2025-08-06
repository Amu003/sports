package sports.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import sports.database.CartDAO;
import sports.database.ProductDAO;
import sports.model.CartModel;
import sports.model.productModel;
import sports.model.userModel;

@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    private CartDAO cartDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        userModel user = (userModel) session.getAttribute("user");

        // Get all products for "Latest Products" section
        List<productModel> allProducts = productDAO.getAllProducts();
        request.setAttribute("products", allProducts);

        List<productModel> recommendedProducts = new ArrayList<>();

        if (user != null) {
            // Get all items in user's cart
            List<CartModel> cartItems = cartDAO.getCartByUserId(user.getId());

            Set<Integer> cartProductIds = new HashSet<>();
            Map<Integer, Integer> categoryCount = new HashMap<>();

            for (CartModel item : cartItems) {
                int productId = item.getProduct().getId();
                int categoryId = item.getProduct().getCategory();

                cartProductIds.add(productId);
                categoryCount.put(categoryId, categoryCount.getOrDefault(categoryId, 0) + 1);
            }

            // Sort category IDs by frequency (highest first)
            List<Integer> topCategories = new ArrayList<>(categoryCount.keySet());
            topCategories.sort((a, b) -> categoryCount.get(b) - categoryCount.get(a)); // descending

            int maxCategories = Math.min(3, topCategories.size()); // top 3 categories only

            for (int i = 0; i < maxCategories; i++) {
                int categoryId = topCategories.get(i);
                List<productModel> categoryProducts = productDAO.getProductsByCategory(categoryId);


                int count = 0;
                for (productModel product : categoryProducts) {
                    if (!cartProductIds.contains(product.getId()) && !recommendedProducts.contains(product)) {
                        recommendedProducts.add(product);
                        count++;
                    }

                    if (count >= 2 || recommendedProducts.size() >= 6) {
                        break; // 2 per category, max 6 total
                    }
                }

                if (recommendedProducts.size() >= 6) {
                    break; // global limit
                }
            }
        }

        request.setAttribute("recommendedProducts", recommendedProducts);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
