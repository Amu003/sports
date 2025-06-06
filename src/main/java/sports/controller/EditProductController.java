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
    fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
    maxFileSize = 1024 * 1024 * 10,        // 10MB
    maxRequestSize = 1024 * 1024 * 50      // 50MB
)
public class EditProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String IMAGE_UPLOAD_DIR = "webapp/img/product";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get parameters
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));

        // File handling
        Part imagePart = request.getPart("image");
        String fileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

            String appPath = request.getServletContext().getRealPath("");
            String savePath = appPath + File.separator + IMAGE_UPLOAD_DIR;

            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }

            imagePart.write(savePath + File.separator + fileName);
        }

        // Get existing product from DB
        ProductService service = new ProductService();
        productModel product = service.getProductById(id);

        // Update fields
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategory(categoryId);

        if (fileName != null) {
            product.setImage(IMAGE_UPLOAD_DIR + "/" + fileName); // Set full relative path
        }

        // Update in DB
        service.updateProduct(product);

        // Redirect to product list
        response.sendRedirect("admin/ProductListController");
    }
}
