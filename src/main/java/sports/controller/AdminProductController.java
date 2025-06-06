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
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
maxFileSize = 1024 * 1024 * 5,    // 5MB
maxRequestSize = 1024 * 1024 * 10) // 10MB
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
        double price = Double.parseDouble(req.getParameter("price"));
        
    	if (price < 0) {
            req.setAttribute("error", "Price cannot be negative.");
            req.getRequestDispatcher("insertProduct.jsp").forward(req, resp);
            return;
        }

        // File upload handling
        Part imagePart = req.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "webapp/img/product";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        imagePart.write(uploadPath + File.separator + fileName);

        // Set product data
        productModel product = new productModel();
        product.setName(name);
        product.setCategory(categoryId);
        product.setDescription(description);
        product.setImage("webapp/img/product/" + fileName); // save relative path to image folder
        product.setPrice(price);

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
