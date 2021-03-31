package newpackage;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

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

            //get email and password input
            String logemail = request.getParameter("email");
            String logpass = request.getParameter("password");


            //connect to database
            UserDatabase db =  new UserDatabase(ConnectionPro.getConnection());
            User user = db.login(logemail, logpass);//user login at UserDatabase




            if(user!=null){ //successful user login
                HttpSession session = request.getSession();//current session of request
                //set user attribute
                session.setAttribute("logUser", user);
                session.setAttribute("user_id",user.id );
                session.setAttribute("user_fname",user.first_name );
                session.setAttribute("user_lname",user.last_name );
                session.setAttribute("user_studentid",user.studentID );
                session.setAttribute("user_mobile",user.mobile );
                session.setAttribute("profile_pic", user.image);
                session.setAttribute("user_status",user.user_status);

                     if (user.user_status==3) //check with status 3, forbidden user cannot access to website
                {
                    out.println("You are now forbidden! Please contact the manager at admin@oncall.com to unlock!");

                }

               else{
                        //create cookie for the login user
                         Cookie c_status= new Cookie("c_user_status", String.valueOf(user.id)); //cookie reference with id
                         System.out.println(c_status.getValue());
                         c_status.setMaxAge(3*60);
                         response.addCookie(c_status);
                         response.sendRedirect("homePage.jsp");//redirect to home page
                     }

            }else{
                out.println("Failed Login! Please try again!");

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