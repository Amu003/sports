package sports.controller;

import sports.services.ProductService;
import sports.model.productModel;
import sports.model.CategoryModel;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;
import java.io.File;
import java.nio.file.Paths;
import javax.servlet.http.Part;

@WebServlet("/insertProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    // Display insert-product.jsp with categories
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CategoryModel> categories = productService.getAllCategoryList();
        request.setAttribute("categories", categories);

        RequestDispatcher rd = request.getRequestDispatcher("admin/insert-product.jsp");
        rd.forward(request, response);
    }

    // Handle product insertion
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        int categoryId = Integer.parseInt(req.getParameter("category"));
        String description = req.getParameter("description");

        int stock = Integer.parseInt(req.getParameter("stock"));
        if (stock < 0) {
            req.setAttribute("errorMessage", "Stock cannot be negative.");
            req.getRequestDispatcher("/admin/insert-product.jsp").forward(req, resp);
            return;
        }

        double price = Double.parseDouble(req.getParameter("price"));
        if (price < 0) {
            req.setAttribute("errorMessage", "Price cannot be negative.");
            req.getRequestDispatcher("/admin/insert-product.jsp").forward(req, resp);
            return;
        }

        String brand = req.getParameter("brand");
        if (brand == null || brand.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Brand is required.");
            req.getRequestDispatcher("/admin/insert-product.jsp").forward(req, resp);
            return;
        }

        String sizes = req.getParameter("sizes");
        if (sizes == null) sizes = "";  // sizes is optional

        // --- Sports-Only Product Check Validation ---
        String[] sportsKeywords = {"cricket", "football", "volleyball", "tennis", "badminton", "racket",
                "shoes", "sports", "boxing", "gloves", "bat", "ball", "jersey", "basketball","chess","board",
                "helmet", "fitness", "gym", "mat", "net", "pads", "skateboard","shoes","accessories", "gears"};

        boolean isSportsProduct = false;
        String lowerName = name.toLowerCase();
        String lowerDesc = description.toLowerCase();

        for (String keyword : sportsKeywords) {
            if (lowerName.contains(keyword) || lowerDesc.contains(keyword)) {
                isSportsProduct = true;
                break;
            }
        }

        if (!isSportsProduct) {
            req.setAttribute("errorMessage", "Product must be related to sports.");
            req.getRequestDispatcher("/admin/insert-product.jsp").forward(req, resp);
            return;
        }
        // --------------------------------------------

        // File upload handling
        Part imagePart = req.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

        // Corrected upload path (relative to web app root)
        String uploadPath = getServletContext().getRealPath("/img/product");

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        imagePart.write(uploadPath + File.separator + fileName);

        // Set product data
        productModel product = new productModel();
        product.setName(name);
        product.setCategory(categoryId);
        product.setDescription(description);
        product.setImage("img/product/" + fileName); // relative path for DB
        product.setPrice(price);
        product.setStock(stock);
        product.setBrand(brand);       // <-- Set brand
        product.setSizes(sizes);       // <-- Set sizes

        // Save to DB
        boolean result = productService.addProduct(product);

        if (result) {
            resp.sendRedirect(req.getContextPath() + "/admin/product-list.jsp");
        } else {
            req.setAttribute("errorMessage", "Product insertion failed!");
            req.getRequestDispatcher("/admin/insert-product.jsp").forward(req, resp);
        }
    }
    }
