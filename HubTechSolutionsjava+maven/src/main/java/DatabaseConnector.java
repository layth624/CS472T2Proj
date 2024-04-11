import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


    public class DatabaseConnector {
    public static void main(String[] args) {
        String url = "jdbc:mysql://sql3.freemysqlhosting.net:3306/sql3694994?zeroDateTimeBehavior=CONVERT_TO_NULL";
        String user = "sql3694994";
        String password = "2kWe65rRuQ";

try (Connection conn = DriverManager.getConnection(url, user, password)) {
            System.out.println("Connected to the database successfully");
            
            // Execute SQL query to select all rows from the 'admin' table
            
            String sql = "SELECT * FROM Admin";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                
                // Iterate through the result set and print each row
                while (rs.next()) {
                    // Assuming 'admin' table has columns 'id', 'name'. Modify according to your table structure.
                    int AdminID = rs.getInt("AdminID");
                    String Name = rs.getString("Name");
                    // Print or process the data as needed
                    System.out.println("ID: " + AdminID + ", Name: " + Name);
                }
                
            } catch (SQLException e) {
                System.out.println("Error executing query");
                e.printStackTrace();
            }
            
            
        } catch (SQLException e) {
            System.out.println("Error connecting to the database");
            e.printStackTrace();
        }
    }
}