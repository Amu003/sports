package sports.database;
import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
	   public static Connection getConnection() {
	        Connection conn = null;
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/sports", "root", "rootroot");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return conn;
	    }
	   public static void main(String[] args) {
		    Connection conn = DbConnection.getConnection();
		    if (conn != null) {
		        System.out.println("✅ Connection successful!");
		    } else {
		        System.out.println("❌ Failed to connect.");
		    }
		}
	  
	}


