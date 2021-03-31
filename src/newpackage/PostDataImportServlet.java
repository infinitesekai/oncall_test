package newpackage;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@MultipartConfig

@WebServlet(name = "PostDataImportServlet")
public class PostDataImportServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //read XML file uploaded and output as temporary file for parsing later
        InputStream is=request.getPart("restore").getInputStream();
        byte[] buffer=new byte[100*1024*1024];
        int text_file_len=is.read(buffer);
        OutputStream os=new FileOutputStream("D:\\tmp_restore_post.xml") ;
        os.write(buffer,0,text_file_len);

        try {
            // analyse XML file-parsing
            DocumentBuilder builder= DocumentBuilderFactory.newInstance().newDocumentBuilder();
            Document doc=builder.parse(new File("D:\\tmp_restore_post.xml"));
            NodeList list=doc.getElementsByTagName("RequestPost");
            for(int i=0;i<list.getLength();i++)
            {


                //get content in XML
                String post_title=list.item(i).getChildNodes().item(1).getTextContent();
                String content=list.item(i).getChildNodes().item(2).getTextContent();
                String type=list.item(i).getChildNodes().item(3).getTextContent();
                String poster_uid=list.item(i).getChildNodes().item(4).getTextContent();
                String helper_uid=list.item(i).getChildNodes().item(5).getTextContent();
                String status=list.item(i).getChildNodes().item(6).getTextContent();
                String star=list.item(i).getChildNodes().item(7).getTextContent();




                //access database and import data into database
                Class.forName("com.mysql.jdbc.Driver");

                PreparedStatement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456")
                        .prepareStatement
                                ("insert into post(title,content,type,poster_uid,helper_uid,status,creation_date,star)" +
                                        "values(?,?,?,?,?,?,curdate(),?)");

                //insert into database
                stm.setString(1,post_title);
                stm.setString(2,content);
                stm.setString(3,type);
                stm.setString(4,poster_uid);
                stm.setString(5,helper_uid);
                stm.setString(6,status);
                stm.setString(7,star);

                stm.execute();
                ResultSet res=stm.executeQuery();
            }
        }

        catch (Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("admin.jsp");//redirect back to admin page
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
