<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>

<html>
<head>
  <title>$Title$</title>
</head>
<body>
<table cellpadding="5px">

    <%

     if(session.getAttribute("user_id")!=null)
       {
         response.sendRedirect("CookiesServlet");
       }

      else
        response.sendRedirect("Login.jsp");


  %>

</body>
</html>