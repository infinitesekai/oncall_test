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

@WebServlet(name = "PostDataExportServlet")
public class PostDataExportServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //format XML string and output to print writer for response
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            PreparedStatement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456")
                    .prepareStatement("select  * from post");
            ResultSet res=stm.executeQuery();
            PrintWriter pnt=response.getWriter();//output file to respond
            //print data in XML
            pnt.println("<RequestPosts>");

            while(res.next()) //print all available post
            {
                pnt.println("\t<RequestPost>");
                pnt.println("\t\t<post_id>"+res.getString("post_id")+"</post_id>");
                pnt.println("\t\t<post_title>"+res.getString("title")+"</post_title>");
                pnt.println("\t\t<content>"+res.getString("content")+"</content>");
                pnt.println("\t\t<type>"+res.getString("type")+"</type>");
                pnt.println("\t\t<poster_uid>"+res.getString("poster_uid")+"</poster_uid>");
                pnt.println("\t\t<helper_uid>"+res.getString("helper_uid")+"</helper_uid>");
                pnt.println("\t\t<status>"+res.getString("status")+"</status>");
                pnt.println("\t\t<creation_date>"+res.getString("creation_date")+"</creation_date>");
                pnt.println("\t\t<star>"+res.getString("star")+"</star>");
                pnt.println("\t</RequestPost>");
            }

            pnt.println("</RequestPosts>");//close the tag
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}
