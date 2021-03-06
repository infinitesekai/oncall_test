package newpackage;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class CookiesServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            //fetch data from login form



            int uid= (int) request.getSession().getAttribute("user_id");


            UserDatabase db =  new UserDatabase(ConnectionPro.getConnection());
            User c_user = db.login_ady(uid);


             if(c_user!=null) { //got cookie
                    HttpSession session = request.getSession();//current session of request
                 //reset the attribute of the user
                    session.setAttribute("logUser", c_user);
                    session.setAttribute("user_id", c_user.id);
                    session.setAttribute("user_fname", c_user.first_name);
                    session.setAttribute("user_lname", c_user.last_name);
                    session.setAttribute("user_studentid", c_user.studentID);
                    session.setAttribute("user_mobile", c_user.mobile);
                    session.setAttribute("profile_pic", c_user.image);
                    session.setAttribute("user_status", c_user.user_status);

                    //create cookie
                    Cookie c_status= new Cookie("c_user_status", String.valueOf(c_user.id));//user id reference as cookie
                    System.out.println(c_status.getValue());//print the cookie-id value in console
                    c_status.setMaxAge(3*60);//expiration of cookie
                    response.addCookie(c_status);//add cookie

                    response.sendRedirect("homePage.jsp");//redirect to homepage with cookie

            }else{
                response.sendRedirect("Login.jsp");//login if no cookie

            }

            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}