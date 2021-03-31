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
import java.sql.Blob;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@MultipartConfig
@WebServlet(name = "UserDataImportServlet")
public class UserDataImportServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       //read XML file uploaded and output as temporary file for parsing later
        InputStream is=request.getPart("restore").getInputStream();
        byte[] buffer=new byte[100*1024*1024];
        int text_file_len=is.read(buffer);
        OutputStream os=new FileOutputStream("D:\\tmp_restore_user.xml") ;
        os.write(buffer,0,text_file_len);

        try {
            //analyse XML file-parsing
            DocumentBuilder builder= DocumentBuilderFactory.newInstance().newDocumentBuilder();
            Document doc=builder.parse(new File("D:\\tmp_restore_user.xml"));
            NodeList list=doc.getElementsByTagName("User");
            for(int i=0;i<list.getLength();i++)
            {

                //get content in XML file
                String first_name=list.item(i).getChildNodes().item(1).getTextContent();//username is the first child node
                String last_name=list.item(i).getChildNodes().item(2).getTextContent();
                String email=list.item(i).getChildNodes().item(3).getTextContent();
                String mobile=list.item(i).getChildNodes().item(4).getTextContent();
                String student_id=list.item(i).getChildNodes().item(5).getTextContent();
                String password=list.item(i).getChildNodes().item(6).getTextContent();
                String gender=list.item(i).getChildNodes().item(7).getTextContent();
                String user_status=list.item(i).getChildNodes().item(8).getTextContent();
                String description=list.item(i).getChildNodes().item(9).getTextContent();


                //access database
                Class.forName("com.mysql.jdbc.Driver");

                PreparedStatement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456")
                        .prepareStatement
                                ("insert into users(first_name,last_name,email,mobile,student_id,password,gender,image,user_status,description)" +
                                        "values(?,?,?,?,?,?,?,'',?,?)");
                //import data into database

                stm.setString(1,first_name);
                stm.setString(2,last_name);
                stm.setString(3,email);
                stm.setString(4,mobile);
                stm.setString(5,student_id);
                stm.setString(6,password);
                stm.setString(7,gender);
                stm.setString(8, user_status);
                stm.setString(9,description);

                stm.execute();
                ResultSet res=stm.executeQuery();
            }
        }

        catch (Exception e)
        {
            e.printStackTrace();
        }

        response.sendRedirect("user_mng.jsp");//redirect back to admin-user management section
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
