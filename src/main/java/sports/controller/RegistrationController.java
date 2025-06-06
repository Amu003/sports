package sports.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import sports.model.userModel;
import sports.database.UserDAO;

@WebServlet("/RegistrationController")
public class RegistrationController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public RegistrationController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Read form inputs
        String name = request.getParameter("name");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
       
       
        // 2. Build User object
        userModel user = new userModel();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
       

        // 3. Delegate to DAO
        UserDAO dao = new UserDAO();
        boolean success = dao.registerUser(user);

        // 4. Redirect based on result
        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("registration.jsp?error=1");
        }
    }
}