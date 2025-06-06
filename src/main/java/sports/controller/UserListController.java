package sports.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import sports.database.UserDAO;
import sports.model.userModel;



@WebServlet("/userList")
public class UserListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	

        UserDAO userDAO = new UserDAO();
        List<userModel> users = userDAO.getAllUsers(); // We'll create this method below
        
        request.setAttribute("userList", users);
        request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
    }
    
}
