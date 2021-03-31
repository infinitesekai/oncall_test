package newpackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CarpoolServlet")
public class CarpoolServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CarpoolDAO carpoolDAO;


    public void init() {
        //create DAO
        carpoolDAO = new CarpoolDAO();
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
        Post newPost = new Post(title,content,user_id);//create new post

        //inserting new post using DAO
        CarpoolDAO.insert_post(newPost);
        response.sendRedirect("CarpoolService.jsp");//redirect back to same page

        session.setAttribute("post", newPost );
    }
}
