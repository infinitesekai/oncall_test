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

@WebServlet(name = "CompleteServlet")
public class CompleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();//current session of request
        String post_id = request.getParameter("post_id");//get post_id of the post to be completed


        if (session.getAttribute("user_id")  == null)//check with user login
        {
            response.sendRedirect("Login.jsp");
            return;
        }


        try
        {
            //connect to database, format SQL statement
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456");
            Statement stm = conn.createStatement();
            String sql = "update post set status=2 where post_id=" +  post_id;//update the status to 2 as completed according to the post_id

            stm.execute(sql);//execute SQL statement
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("mission.jsp");//redirect back to mission page

    }
}
