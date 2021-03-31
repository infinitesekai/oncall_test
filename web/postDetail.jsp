
<%@ page import="java.sql.*" %>
<%@ page import="newpackage.User" %>

<%
    if (session.getAttribute("user_id") == null)
    {
        response.sendRedirect("index.jsp");
    }

    User user = (User) session.getAttribute("logUser");
%>
<html>
<head>
    <link rel="styleSheet" href="./CSS/style.css">
    <link rel="stylesheet" href="./CSS/printing.css">
    <link rel="styleSheet" href="./CSS/dropdown.css">
    <link rel="icon" href="logo/logo.ico">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk&display=swap" rel="stylesheet">
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <title>Post Details</title>
    <style>
        .detailBg{

            position: relative;
            border-radius: 5px;
            box-shadow:0px 4px 5px #707070;
            left: 19em;
            width:50em;
            min-height: 20px;
            background-color: white;
            top:5em;
            box-sizing: border-box;
        }
        .detailHeader{
            padding: 16px;
            background-color: white;
            color: #1FB6B9;
            border-radius: 5px;
            height: 10%;
            text-align: center;
            font-family: Space Grotesk;
            font-size: 40px;
            font-weight: bold;
            word-wrap: anywhere;
        }
        .detailContent
        {
           font-size: 23px;
            color: #707070;
        }
        .detailDescript{
            color: #707070;
            font-family: Space Grotesk;
            font-size: 20px;
            margin-left: 20px;
            min-height: 80px;
            flex-wrap: wrap;
            box-sizing: border-box;
            padding: 2px 16px 20px 16px;
            width: 38em;
            text-align: justify;
        }
    </style>

</head>
<body>
<!--the post details-->
    <!--the post content-->
    <div class="detailBg" >
<%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
        Statement stm=conn.createStatement();
        String sql;
        sql = "(select  poster_uid as owner_id, helper_uid as user_id,post_id, title, content, type, creation_date, u1.first_name as poster_first, u1.last_name as poster_last, u2.first_name as helper_first, u2.last_name as helper_last, status, star\n" +
                "                from post as p1, users as u1, users as u2\n" +
                "                where p1.poster_uid = u1.id and p1.helper_uid = u2.id and post_id="+ request.getParameter("post_id") +")\n" +
                "                union\n" +
                "(select  poster_uid as owner_id, helper_uid as user_id, post_id, title, content, type, creation_date, first_name, last_name, null, null, status, star\n" +
                "                from post join users on poster_uid=users.id where post_id="+request.getParameter("post_id")+");";
        ResultSet rs=stm.executeQuery(sql);


        if (rs.next())
        {
            %>
        <a href="profile.jsp?user_id=<%= session.getAttribute("user_id")%>">
            <span class="close" style="position: relative; right: 30px; top: 10px">&times;</span>
        </a>

        <div class="detailHeader">
            <%=rs.getString("title")%>
        </div>

        <div class="detailDescript" >
            <table width="100%">
                <tr >
                    <td width="35%" ><div style="text-align: right; color: #444444; font-weight: bold;" class="detailContent">type: </div></td>
                    <td width="65%" ><div class="detailContent"><%=rs.getString("type")%> </div></td>
                </tr>
                <tr>
                    <td width="35%"><div style="text-align: right; color: #444444; font-weight: bold;" class="detailContent">Date: </div></td>
                    <td width="65%"> <div class="detailContent"> <%=rs.getString("creation_date")%></div></td>
                </tr>

                <tr>
                    <td width="35%"><div style="text-align: right; color: #444444; font-weight: bold;" class="detailContent"> Requested by: </div> </td>
                    <td width="65%"><div class="detailContent">
                        <a style="color: #707070; text-decoration: none;" href="UserProfileServlet?user_id=<%=rs.getString("owner_id")%>">
                        <%=rs.getString("poster_first")%> <%=rs.getString("poster_last")%> </div> </td>
                </a>
                </tr>

                <tr >
                    <td width="35%" style="vertical-align: top;"><div style="text-align: right; color: #444444; font-weight: bold;" class="detailContent"> Content: </div></td>
                    <td width="65%"><div class="detailContent" style="border-radius: 15px"> <%=rs.getString("content")%> </div> </td>
                </tr>

                <tr>
                    <td width="35%"><div style="text-align: right; color: #444444; font-weight: bold;" class="detailContent"> Status:</div></td>
                    <td width="65%"><div class="detailContent">
                        <%

                        switch(rs.getInt("status"))
                        {
                            case 0:
                                out.write("Posted | Waiting");
                                break;
                            case 1:
                                out.write("Accepted");
                                break;
                            case 2:
                                out.write("Completed");
                                break;
                            case 3:
                                out.write("Rated");
                                break;
                        }
                        %>
                    </div>
                    </td>
                </tr>

                <tr>
                    <td width="35%"><div style="text-align: right; color: #444444; font-weight: bold; " class="detailContent"> Accepted by Helper: </div> </td>
                    <td width="65%"><div class="detailContent">

                        <% if(rs.getString("helper_first")==null){
                            out.print("Anonymous");}
                        else{%>
                        <a style="color: #707070; text-decoration: none;" href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                        <%=rs.getString("helper_first")%> <%=rs.getString("helper_last")%>
                        </a>
                        <%
                            }
                        %>

                    </div>
                    </td>

                </tr>

                <tr>
                    <td width="35%"><div style="text-align: right; color: #444444; font-weight: bold;" class="detailContent">Rating:</div></td>
                    <td width="65%"><div class="detailContent">
                        <i style="font-size:36px;color:#efa910" class="fas">&#xf005;</i> x <%=rs.getString("star")%>
                    </div>
                    </td>
                </tr>
            </table>
        </div>
        <%
            }
        %>
    </div>

</body>
</html>
