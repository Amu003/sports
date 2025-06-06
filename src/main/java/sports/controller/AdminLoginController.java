package sports.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sports.database.AdminDAO;
import sports.model.AdminModel;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class LoginController
 */
@WebServlet("/AdminLoginController")
public class AdminLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO AdminDAO;

    @Override
    public void init() throws ServletException {
        AdminDAO = new AdminDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        AdminModel admin = AdminDAO.loginAdmin(email, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminName", admin.getName());
            response.sendRedirect(request.getContextPath() + "/admin/admin.jsp");

        } else {
        	request.setAttribute("msg", "Invalid admin credentials");
        	request.getRequestDispatcher("/admin/Admin_login.jsp").forward(request, response);


        }
    }
}