package newpackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

@WebServlet(name = "ClearAllNotifServlet")
public class ClearAllNotifServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();//current session of request


        if (session.getAttribute("user_id")  == null)//check with user login
        {
            response.sendRedirect("Login.jsp");
            return;
        }


        try
        {
            //connect to database and format SQL statement
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456");
            Statement stm = conn.createStatement();
            String sql = "delete from notif where poster_uid=" +  session.getAttribute("user_id");//delete record of the user as poster
            String sql_1 = "delete from notif where helper_uid=" +  session.getAttribute("user_id");//delete record of the user as helper

            //execute SQL statement
            stm.execute(sql);
            stm.execute(sql_1 );
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("notif.jsp");//redirect back to notification page
    }
}
