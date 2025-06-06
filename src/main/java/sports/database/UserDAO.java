package sports.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import sports.model.userModel;
import java.util.List;
import java.sql.Statement;
import java.util.ArrayList;



public class UserDAO {
    public boolean registerUser(userModel user) {
        String sql = "INSERT INTO users (name, email, password) VALUES ( ?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
           
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //for login
    
    public userModel loginUser(String email, String password) {
        userModel user = null;
        try (Connection conn = DbConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new userModel();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
               
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }



//Get all users
    public List<userModel> getAllUsers() {
        List<userModel> users = new ArrayList<>();
        String sql = "SELECT id, name, email FROM users";

        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                userModel user = new userModel();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

       return users;
    }
}

