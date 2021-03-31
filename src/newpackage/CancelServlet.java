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

@WebServlet(name = "CancelServlet")
public class CancelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();//current session of request
        String post_id = request.getParameter("post_id");//get the post_id of the post to cancel


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
            String sql = "update post set status=0,helper_uid=null where post_id=" +  post_id; //reset the status and helper_uid
            String sql1 = "delete from notif where post_id =" + post_id; //delete post entry from notif table
            //execute SQL statement
            stm.execute(sql);
            stm.execute(sql1);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("mission.jsp");//redirect back to mission page
    }
}
