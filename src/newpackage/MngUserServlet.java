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

@WebServlet(name = "MngUserServlet")
public class MngUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();//current session of request
        if (session.getAttribute("user_id")  == null)//check user login
        {
            response.sendRedirect("Login.jsp");
            return;
        }
        else
        {
            int st = (int)session.getAttribute("user_status");
            if (st != 1)//check user status 1 as admin
                return;
        }

        String id = request.getParameter("id"); //get id of the user
        String action = request.getParameter("action");//get the action to be performed

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456");
            Statement stm = conn.createStatement();
            String sql = "update users set user_status = " + action + " where id = " + id + "";//update user status of the user
            stm.execute(sql);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("user_mng.jsp");//redirect back to admin page-user management section

    }
}
