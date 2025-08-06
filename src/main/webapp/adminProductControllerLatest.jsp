<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
package sports.controller;

import sports.services.ProductService;
import sports.model.productModel;
import sports.model.CategoryModel;
import sports.model.ProductVariantModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.io.File;
import java.nio.file.Paths;
import javax.servlet.http.Part;
import java.sql.SQLException;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<CategoryModel> categories = productService.getAllCategoryList();
        request.setAttribute("categories", categories);
        RequestDispatcher rd = request.getRequestDispatcher("admin/insert-product.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String categoryParam = req.getParameter("category");
        String description = req.getParameter("description");
        String brand = req.getParameter("brand");

        // Validate mandatory fields
        if (brand == null || brand.trim().isEmpty()) {
            setErrorAndReturn(req, resp, "Brand is required.");
            return;
        }

        if (name == null || name.trim().isEmpty()) {
            setErrorAndReturn(req, resp, "Name is required.");
            return;
        }

        if (categoryParam == null || categoryParam.trim().isEmpty()) {
            setErrorAndReturn(req, resp, "Category is required.");
            return;
        }

        if (description == null || description.trim().isEmpty()) {
            setErrorAndReturn(req, resp, "Description is required.");
            return;
        }

        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryParam);
        } catch (NumberFormatException e) {
            setErrorAndReturn(req, resp, "Category must be a valid number.");
            return;
        }

        String[] sizes = req.getParameterValues("sizes[]");
        String[] prices = req.getParameterValues("prices[]");
        String[] stocks = req.getParameterValues("stocks[]");

        // Validate arrays presence and equal length
        if (sizes == null || prices == null || stocks == null
            || sizes.length == 0 || prices.length == 0 || stocks.length == 0
            || sizes.length != prices.length || sizes.length != stocks.length) {
            setErrorAndReturn(req, resp, "Sizes, prices, and stocks must be provided properly.");
            return;
        }

        String[] sportsKeywords = {"cricket", "football", "volleyball", "tennis", "badminton", "racket",
                "shoes", "sports", "boxing", "gloves", "bat", "ball", "jersey", "basketball", "chess", "board",
                "helmet", "fitness", "gym", "mat", "net", "pads", "skateboard", "accessories", "gears"};

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
            setErrorAndReturn(req, resp, "Product must be related to sports.");
            return;
        }

        Part imagePart = req.getPart("image");
        String fileName = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/img/product");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            imagePart.write(uploadPath + File.separator + fileName);
        } else {
            setErrorAndReturn(req, resp, "Product image is required.");
            return;
        }

        productModel product = new productModel();
        product.setName(name);
        product.setCategory(categoryId);
        product.setDescription(description);
        product.setBrand(brand);
        product.setImage("img/product/" + fileName);

        int productId = productService.addProductAndReturnId(product);

        if (productId > 0) {
            List<ProductVariantModel> variantList = new ArrayList<>();
            for (int i = 0; i < sizes.length; i++) {
                try {
                    ProductVariantModel variant = new ProductVariantModel();
                    variant.setProductId(productId);
                    variant.setSize(sizes[i]);
                    double variantPrice = Double.parseDouble(prices[i]);
                    int variantStock = Integer.parseInt(stocks[i]);

                    if (variantPrice < 0) {
                        setErrorAndReturn(req, resp, "Price cannot be negative at variant index " + i);
                        return;
                    }
                    if (variantStock < 0) {
                        setErrorAndReturn(req, resp, "Stock cannot be negative at variant index " + i);
                        return;
                    }

                    variant.setPrice(variantPrice);
                    variant.setStock(variantStock);
                    variantList.add(variant);
                } catch (NumberFormatException e) {
                    setErrorAndReturn(req, resp, "Invalid price or stock format at variant index " + i);
                    return;
                }
            }
            try {
                productService.addProductVariants(variantList);
                resp.sendRedirect(req.getContextPath() + "/admin/product-list.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                setErrorAndReturn(req, resp, "Error while inserting product variants: " + e.getMessage());
            }
        } else {
            setErrorAndReturn(req, resp, "Product insertion failed!");
        }
    }

    private void setErrorAndReturn(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        List<CategoryModel> categories = productService.getAllCategoryList();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/admin/insert-product").forward(req, resp);
    }
}
