package sports.controller;

import sports.database.CategoryDAO;
import sports.model.CategoryModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/addCategory")
public class CategoryInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
           
            String name = request.getParameter("name");

            CategoryModel category = new CategoryModel();
            category.setName(name);

            CategoryDAO categoryDAO = new CategoryDAO();
            boolean success = categoryDAO.insertCategory(category);

            if (success) {
                request.setAttribute("successMessage", "Category added successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to add category.");
            }
            // Always forward back to insert-category.jsp to show the message
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/insert-category.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/insert-category.jsp");
            dispatcher.forward(request, response);
        }
    }
}
