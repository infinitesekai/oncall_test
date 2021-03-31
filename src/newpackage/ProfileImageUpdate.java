package newpackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

@MultipartConfig

@WebServlet(name = "ProfileImageUpdate")
public class ProfileImageUpdate extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InputStream is=
                request.getPart("image").getInputStream();
        byte[] buffer = new byte[100*1024*1024];
        int len_image= is.read(buffer);
        String path= request.getSession().getServletContext().getRealPath("/"+request.getSession().getAttribute("user_id")+".png");
        OutputStream os= new FileOutputStream(path);
        os.write(buffer,0,len_image);
        os.flush();
        os.close();

        response.sendRedirect("profile.jsp?id=" + request.getSession().getAttribute("user_id"));

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





    }
}
