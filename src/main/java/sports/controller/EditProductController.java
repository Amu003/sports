package sports.controller;

import sports.model.productModel;
import sports.services.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/update-product")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class EditProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get basic product details
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));

        // NEW: Get stock, brand, sizes
        int stock = Integer.parseInt(request.getParameter("stock"));
        String brand = request.getParameter("brand");
        String sizes = request.getParameter("sizes");

        // Handle image upload
        Part imagePart = request.getPart("image");
        String fileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = request.getServletContext().getRealPath("/img/product");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            imagePart.write(uploadPath + File.separator + fileName);
        }

        // Get existing product
        ProductService service = new ProductService();
        productModel product = service.getProductById(id);

        // Update fields
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategory(categoryId);
        product.setStock(stock); // ✅ update stock
        product.setBrand(brand); // ✅ update brand
        product.setSizes(sizes); // ✅ update sizes

        if (fileName != null) {
            product.setImage("img/product/" + fileName); // ✅ updated image
        }

        // Save update
        service.updateProduct(product);

        // Redirect to product list
        response.sendRedirect("admin/ProductListController");
    }
}
