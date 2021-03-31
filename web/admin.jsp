
<%@ page import="newpackage.User" %>
<%@ page import="newpackage.Post" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>

<%
    if (session.getAttribute("user_id") == null)
    {
        response.sendRedirect("index.jsp");
    }
    else
    {
        int st = (int)session.getAttribute("user_status");
        if (st != 1)//check user status 1 as admin
        {
            out.write("You are not the manager of the website!");
            return;
        }
    }

    Post post = (Post) session.getAttribute("post");
    User user = (User) session.getAttribute("logUser");
%>

<html>

<head>

    <link rel="styleSheet" href="CSS/dropdown.css">
    <link rel="styleSheet" href="CSS/printing.css">
    <link rel="styleSheet" href="CSS/style.css">
    <link rel="icon" href="logo/logo.ico">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>Admin_Post Management</title>
    <style>
        body {
            margin: 0px;
            border: 0px;
            padding: 0px;
            width: 100%;
            background-color: #e6fff5;
        }



        #header li {
            position: relative;
            bottom: 20px;
            cursor: hand;
            display: inline;
            width: 75px;
            margin: 5px;
            text-align: center;
            vertical-align: center;
            padding: 25px;
            padding-bottom: 30px;
            font-size: 15px;
            font-family: 'Space Grotesk';
            color: #707070;
        }

        .top-font{
            font-family: 'Space Grotesk';
            font-weight: 900;
            font-size: 23px;
            text-align: center;
            vertical-align: middle;
            margin-top:4px;
            padding: 5px;
            color: #1FB6B9;

        }
        .row{
            font-family: 'Space Grotesk';
            font-size: 19px;
            text-align: left;
            padding: 0px;
            color: #707070;
            box-shadow:0px 2px 3px rgba(0, 0, 0, 0.1);
        }
        .row_name
        {
            font-family: 'Space Grotesk';
            font-size: 19px;
            text-align: left;
            padding: 0px;
            color: #707070;
        }

        .buttonDelete{
            background-color: #b70038;
            border: none;
            border-radius: 5px;
            cursor: hand;
            color:white;
            font-family: Space Grotesk;
            font-weight:800;
            font-size:19px;
            left: 20px;
            margin:auto;
            margin-top: 25px;
            padding:9px;
            position: relative;
            text-align:center;
            width:5em;
        }

        .Title-font {
            font-family: 'Space Grotesk';
            font-weight: 900;
            font-size: 42px;
            text-align: left;
            padding: 5px;
            color: #1FB6B9;
        }

        .button_download{
            background-color:#1FB6B9;
            color:white;
            font-family: Space Grotesk;
            font-size:20px;
            margin: 0 auto;
            margin-left:3px;
            padding: 10px;
            text-align:center;
            vertical-align:center;
            width:auto;
            height: 50px;
            border-radius: 5px;
            cursor: hand;
            border:none;
            outline:none;
        }

        .button_download:hover {
            background-color: #707070;
        }

        .user-icon{
            position:relative;
            left:2px;
            margin:5px;
            height:50px;
            width:50px;
            border: #1FB6B9 1px solid;
            border-radius: 50%;
        }



    </style>


</head>

<body>

<div style="padding-left:30px;padding-right:50px;height:70px; background-color:white;box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1), 0 2px 2px 0 rgba(0, 0, 0, 0.1);">
    <div id="header" style="float:right;position:relative;bottom:10px; ">
        <li><a href="homePage.jsp" style="text-decoration: none">Home</a> </li>
        <li class="dropdown">
            <button class="dropdown_btn" >Services <i class="fa fa-caret-down"></i></button>
            <div class="dd-content">
                <a href="Cleaning.jsp">Cleaning</a>
                <a href="PrintingService.jsp">Printing</a>
                <a href="ErrandService.jsp">Errands</a>
                <a href="CarpoolService.jsp">Carpool</a>
            </div>
        </li>
        <li><a href="mission.jsp" style="text-decoration: none">Mission</a></li>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection header_conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
            Statement header_stm=header_conn.createStatement();
            String sql_notif;
            sql_notif ="select count(notif_id) as sum_notif from (\n" +
                    "(select notif_id from notif join post on post.post_id=notif.post_id where status=1 and notif.poster_uid="+session.getAttribute("user_id")+")\n" +
                    "union\n" +
                    "(select notif_id from notif join post on post.post_id=notif.post_id where status=2 and notif.poster_uid="+session.getAttribute("user_id")+")\n" +
                    "union\n" +
                    "(select notif_id from notif join post on post.post_id=notif.post_id where status=3 and notif.helper_uid="+session.getAttribute("user_id")+")\n" +
                    ") as T";
            ResultSet rs_notif=header_stm.executeQuery(sql_notif);

        %>
        <li><a href="notif.jsp" style="text-decoration: none">Notification
            <%if (rs_notif.next()) { %>
            [ <%=rs_notif.getString("sum_notif")%> ]
            <% } %>
        </a></li>

        <li><a href="admin.jsp" style="text-decoration: none">Admin</a></li>

        <li class="dropdown">
            <button class="dropdown_btn" > <img src="Photo/User.svg" style="position:relative;top:15px;right:10px;height:43px;width:43px;padding-top:10px;cursor:hand; "  /> <i class="fa fa-caret-down"></i></button>
            <div class="dd-content">
                <% String sql_name;
                    sql_name = "select first_name from users where id="+ session.getAttribute("user_id");
                    ResultSet rs_name=header_stm.executeQuery(sql_name);
                    if (rs_name.next()) {
                %>
                <a href="profile.jsp?user_id=<%= session.getAttribute("user_id")%>">
                    <%=rs_name.getString("first_name")%>
                </a>
                <%}%>
                <a href="LogoutServlet">Logout</a>
            </div>
        </li>
    </div>

    <a href="homePage.jsp">
    <div style="padding:10px;">
        <img src="logo/logo.svg" style="padding-right:5px;padding-bottom:15px;height:50px;width:50px" />
        <img src="logo/logo name.svg" style="padding-bottom:5px;height:60px;width:60px" />
    </div>
    </a>
</div>

<div style="margin:10px;">
    <table width="100%" cellpadding="3px">
        <tr>
            <td width="1%">
                <img src="./Photo/admin.svg" style="position:relative;left:50px;height:60px;width:60px;padding-top:10px;padding-left:20px; "  />
            </td>

            <td class="Title-font" width="99%" style="padding-top:15px;padding-left:70px;">
                Admin
            </td>
        </tr>
    </table>
</div>


<div  style="margin:50px auto;width:85%; box-shadow:0px 4px 5px rgba(0, 0, 0, 0.1);border-radius: 1em;">
    <table width="100%" style="text-align:center;background-color:white; " cellpadding="3px">

        <tr style="background-color:#F8F8F8;">
            <td width="50%" bgcolor=" #1FB6B9"style="padding:10px;">
                <a href="admin.jsp" style="text-decoration: none;"><div class="top-font" style="color: white">
                    Post Management </div></a>
            </td>

            <td width="50%"  style="padding:10px;">
                <a href="user_mng.jsp" style="text-decoration: none;"><div class="top-font">
                    User Management </div></a>
            </td>


        </tr>
    </table>

    <table width="100%" style="text-align:center;background-color:white; " cellpadding="3px">
    <tr class="row" width="100%">
        <td width="50%">

            <a href="PostDataExportServlet" style="text-decoration: none;">
                <div>
                    <input type="button" value="Download Post Backup Data" class="button_download" />
                </div></a>

        </td>

        <td width="50%">

            <div style="margin-left: auto;margin-right: auto;display: inline-block;font-family:'Space Grotesk';font-size: 1em; " >


                <form action="PostDataImportServlet" enctype="multipart/form-data" method="post">
                    Upload Posts Data Restore: <input type="file" name="restore"/>
                    <input type="submit" style="margin:5px;color:white;background-color: #1FB6B9;cursor:hand;border:1px solid black;"/>
                </form>
            </div>
        </td>
    </tr>
    </table>

    <table width="100%" style="text-align:left;background-color:white;" cellpadding="3px">


        <tr bgcolor="#6e8f91" style="color: white">
            <td width="15%"> <div class="top-font" style="color: white"> User </div> </td>
            <td width="15%"><div class="top-font " style="color: white"> Creation Date </div> </td>
            <td width="20%"><div class="top-font" style="color: white"> Title </div> </td>
            <td width="38%"><div class="top-font" style="color: white"> Content </div> </td>
            <td width="12%"><div class="top-font "style="color: white" > Operations </div> </td>
        </tr>

        <%
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root", "123456").createStatement();
            String sql =
                    "select * \n" +
                            "from users, post\n" +
                            "where poster_uid = users.id;";
            ResultSet rs = stm.executeQuery(sql);

            int cnt = 0;
            while(rs.next())
            {
                if (cnt % 2 == 0)
                {
        %>
        <tr class="row" width="100%">
            <td style="text-align: center;">
                <div style="padding-left:25px;display:inline-block;">
                    <%
                        Blob imageBlob= rs.getBlob("image");
                        byte[] imageBytes=imageBlob.getBytes(1, (int)imageBlob.length());
                        if(imageBlob.length()==0){%>

                    <a href="UserProfileServlet?user_id=<%=rs.getString("id")%>">
                        <img class="user-icon" src="Photo/User.png" style="border: none">
                    </a>
                    <%}else{

                        String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>
                    <a href="UserProfileServlet?user_id=<%=rs.getString("id")%>">
                        <img class="user-icon" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
                    </a>
                    <%}%>
                </div>

                <a class="row_name" style="text-decoration: none" href="profile.jsp?user_id=<%=rs.getString("id")%>">
                    <div style="display:inline-block;position:relative;bottom:20px;"><%=rs.getString("first_name")%></div></a>
            </td>
            <td style="text-align: center;">
                <%=rs.getString("creation_date")%>
            </td>
            <td style="text-align: center;">
                <%=rs.getString("title")%>
            </td>
            <td>
                <%=rs.getString("content")%>
            </td>
            <td>
                <form action="AdminServlet" method="post">

                    <a href="AdminServlet?post_id=<%=rs.getString("post_id")%>" style="text-decoration: none;">
                        <div>
                            <input onclick="this.value='Delete'" type="button" value="Delete" class="buttonDelete helpButton"/>
                        </div>
                    </a>
                </form>
            </td>
        </tr>
        <%
        }
        else
        {
        %>
        <tr  class="row" style="background-color:#ccc;">
            <td style="text-align: center;">
                <div style="padding-left:25px;display:inline-block;">
                    <%
                        Blob imageBlob= rs.getBlob("image");
                        byte[] imageBytes=imageBlob.getBytes(1, (int)imageBlob.length());
                        if(imageBlob.length()==0){%>

                    <a href="UserProfileServlet?user_id=<%=rs.getString("id")%>">
                        <img class="user-icon" src="Photo/User.png" style="border: none">
                    </a>
                    <%}else{

                        String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>
                    <a href="UserProfileServlet?user_id=<%=rs.getString("id")%>">
                        <img class="user-icon" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
                    </a>
                    <%}%>
                </div>

                <a class="row_name" style="text-decoration: none" href="profile.jsp?user_id=<%=rs.getString("id")%>">
                    <div style="display:inline-block;position:relative;bottom:20px;"><%=rs.getString("first_name")%></div></a>
            </td>
            <td style="text-align: center;">
                <%=rs.getString("creation_date")%>
            </td>
            <td style="text-align: center;">
                <%=rs.getString("title")%>
            </td>
            <td>
                <%=rs.getString("content")%>
            </td>
            <td>
                <form action="AdminServlet" method="post">

                    <a href="AdminServlet?post_id=<%=rs.getString("post_id")%>" style="text-decoration: none;">
                        <div>
                            <input onclick="this.value='Delete'" type="button" value="Delete" class="buttonDelete helpButton"/>
                        </div>
                    </a>
                </form>
            </td>
        </tr>
        <%
                }
                ++cnt;
            }
        %>
    </table>
</div>


<!--footer-->

<div
        style="line-height:25px;margin-top:0px;font-weight:900;text-align:center;font-family:'Space Grotesk';font-size:20px;background-color:#1FB6B9;padding:15px; color:white;">
    Copyright 2020, Xiamen University Malaysia<br />
    On Call Development Team
</div>
</body>
</html>

