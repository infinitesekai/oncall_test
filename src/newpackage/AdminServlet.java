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

@WebServlet(name = "AdminServlet")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();//current session of  the request
        if (session.getAttribute("user_id") == null) //check user login
        {
            response.sendRedirect("Login.jsp");//redirect to login if not logged in
            return;
        }
        else
        {
            int st = (int)session.getAttribute("user_status");
            if (st != 1) //check with user status 1 as admin
                return;
        }


        String post_id = request.getParameter("post_id");//get post_id to be deleted
        try
        {
            //connect to database and format SQL statement
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456");
            Statement stm = conn.createStatement();
            String sql = "delete from post where post_id=" +  post_id;//delete the post from database according to post_id

            stm.execute(sql);//execute SQL statement
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("admin.jsp");//redirect back to admin page

    }
}

