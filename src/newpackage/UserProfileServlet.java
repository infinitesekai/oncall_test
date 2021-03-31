package newpackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;

@WebServlet(name = "UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int user_id= Integer.parseInt(request.getParameter("user_id")); //get user_id of the user to be visited
        HttpSession session = request.getSession();//current session of request
        int self_user_id= (int) session.getAttribute("user_id");//get the user_id of current user
        if(self_user_id == user_id) { //check if user visit own profile
            //go to the profile of current user
            response.sendRedirect("profile.jsp?user_id=" + request.getSession().getAttribute("user_id"));
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("othersProfile.jsp"); //go to other profile
            rd.forward(request, response);
        }
    }
}
