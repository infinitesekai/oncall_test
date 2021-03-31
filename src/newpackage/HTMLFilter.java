package newpackage;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "HTMLFilter")
public class HTMLFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        //get the title and content input by the user
        String title = req.getParameter("title");
        String content = req.getParameter("descriptionInput");

        if(title==null)//if title is not input, set with empty string
            title="";

        //check title and content whether they contain < or >
        if (title.contains("<") || title.contains(">"))
        {
            resp.getWriter().println("Illegal character detected!");
        }
        else if(content.contains("<")||content.contains(">"))
        {
            resp.getWriter().println("Illegal character detected!");
        }
        else {
            chain.doFilter(req, resp);//continue,do chain filter

        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
