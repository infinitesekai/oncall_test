package newpackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "ErrandServlet")
public class ErrandServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ErrandsDAO errandsDAO;


    public void init() {
        //create new DAO
        errandsDAO = new ErrandsDAO();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            insert_post(request, response);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

    private void insert_post(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{

        HttpSession session = request.getSession();


        //get user input
        String title = request.getParameter("title");
        String content = request.getParameter("descriptionInput");
        int user_id= (int) session.getAttribute("user_id");//current user id

        Post newPost = new Post(title,content,user_id);//new post container

        //inserting new post using DAO
        ErrandsDAO.insert_post(newPost);
        response.sendRedirect("ErrandService.jsp");//redirect back to same page

        session.setAttribute("post", newPost );
    }
}
