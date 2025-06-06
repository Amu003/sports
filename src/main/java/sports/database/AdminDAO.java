package sports.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import sports.model.AdminModel;

public class AdminDAO {
    /** Returns AdminModel if email/password match, else null */
    public AdminModel loginAdmin(String email, String password) {
        AdminModel admin = null;
        String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new AdminModel();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
