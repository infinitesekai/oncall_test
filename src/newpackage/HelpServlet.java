package newpackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet(name = "HelpServlet")
public class HelpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();//current session of request
        String post_id = request.getParameter("post_id");//post_id of the post to be helped

        int user_id=  (int)session.getAttribute("user_id");//get user_id-the current user which is the helepr

        String poster_uid=request.getParameter("poster_uid");//get id of the post owner

        if (session.getAttribute("user_id") == null)//check wiith user login
        {
            response.sendRedirect("Login.jsp");
            return;
        }


       //check if user want to help themselves
        if(user_id == Integer.parseInt(poster_uid))
        {
            PrintWriter out = response.getWriter();
            out.write("You need helpers! Please help others!");
            return;
        }


        try
        {   //connect to database and format SQL statement
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456");
            Statement stm = conn.createStatement();
            String sql = "update post set status=1,helper_uid=" + user_id + " where post_id=" +  post_id;//update status 1 as helped and update the id of the helper of the post_id
            String sql_1="insert into notif (post_id,poster_uid,helper_uid) values (" + post_id + "," + poster_uid + ","+ user_id+")"; //insert post_id,id of post owner,id of helper into notif table

            //execute SQL statement
            stm.execute(sql);
            stm.execute(sql_1);

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }


                        response.sendRedirect("mission.jsp");//redirect back to mission page


        }


}

