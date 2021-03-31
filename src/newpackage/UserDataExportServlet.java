package newpackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "UserDataExportServlet")
public class UserDataExportServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //format XML string and output to print writer for response
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            PreparedStatement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "abc123")
                    .prepareStatement("select  * from users");
            ResultSet res=stm.executeQuery();
            PrintWriter pnt=response.getWriter();//output file to respond
            //print data in XML
            pnt.println("<Users>");

            while(res.next())   //print all available user data
            {
                pnt.println("\t<User>");
                pnt.println("\t\t<first_name>"+res.getString("first_name")+"</first_name>");
                pnt.println("\t\t<last_name>"+res.getString("last_name")+"</last_name>");
                pnt.println("\t\t<email>"+res.getString("email")+"</email>");
               pnt.println("\t\t<mobile>"+res.getString("mobile")+"</mobile>");
               pnt.println("\t\t<student_id>"+res.getString("student_id")+"</student_id>");
                pnt.println("\t\t<password>"+res.getString("password")+"</password>");
               pnt.println("\t\t<gender>"+res.getString("gender")+"</gender>");
               pnt.println("\t\t<image>"+res.getString("image")+"</image>");
               pnt.println("\t\t<user_status>"+res.getString("user_status")+"</user_status>");
               pnt.println("\t\t<description>"+res.getString("description")+"</description>");
               pnt.println("\t</User>");
            }

            pnt.println("</Users>");//close the tag
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}
