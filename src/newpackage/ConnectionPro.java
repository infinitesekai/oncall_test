package newpackage;
import java.sql.*;


public class ConnectionPro {
    private static Connection con;

    public static Connection getConnection(){
        try{
            Class.forName("com.mysql.jdbc.Driver");//database connection
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall","root","123456");

        }catch(Exception e){
            e.printStackTrace();
        }
        return con;
    }
}
