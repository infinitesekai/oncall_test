<%@ page import="newpackage.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Base64" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

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
  <link rel="styleSheet" href="./CSS/dropdown.css">
  <link rel="icon" href="logo/logo.ico">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Profile</title>
  <style>
    body {
      margin: 0px;
      border: 0px;
      padding: 0px;
	  width:100%;
        background-color:  #e6fff5;
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
      padding: 20px;
      padding-bottom: 30px;
      font-size: 15px;
      font-family: 'Space Grotesk';
      color: #707070;
    }



   .Profile_word
	{
		font-family:'Space Grotesk' ;
		font-size: 15px;
		color: #707070;

	}
	.myRequest_box
		{
			width:	600px;
			height:	160px;
			box-shadow: 0px 4px 5px #888888;
			border-radius: 5px;
			margin: 30px auto;
			background-color: #F8F8F8;
		}
	.logo_box
	{
			width:	60px;
			height:	60px;
			box-shadow: 0px 4px 5px #888888;
			border-radius: 10px;
			margin: 5px auto;
			background-color: white;
			cursor: hand;
	}

	 .postsWord{
		padding-top:25px;
		color:#1FB6B9 ;
		font-family: Space Grotesk;
		margin-left:100px;
		font-size: 30px;
		text-align: left;
	}

    .profile_image{
        display: block;
        height: 8em;
        margin-left: auto;
        margin-right: auto;
        width: 8em;
        border: #1FB6B9 3px solid;
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



<div style="margin: 50px auto; width: 500px">
    <table width="100%">
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn1= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
            Statement stm1=conn1.createStatement();
            String sql1;
            sql1 = "select * from users where users.id="+ request.getParameter("user_id");
            ResultSet rs1=stm1.executeQuery(sql1);


            if (rs1.next())
            {

        %>

        <tr width="100%" style="margin: auto">
            <%
                Blob imageBlob= rs1.getBlob("image");
                byte[] imageBytes=imageBlob.getBytes(1, (int)imageBlob.length());
                if(imageBlob.length()==0){%>

            <img class="profile_image" src="Photo/User.png" alt="user img" style="border: none"><br/>
            <%}else{

                String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

            <img class="profile_image" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img"><br/>
            <%}%>
        </tr>
                <tr width="100%">
                <td width="50%">
                <table>

                <tr width="100%">

                    <div style="transform:translateX(50%);margin-left: auto;margin-right: auto;display: inline-block; width: 200px;font-family:'Space Grotesk' ; " >
                        <form action="EditProfilePicServlet" method="post" enctype="multipart/form-data" style="margin: 0 auto" >
                            Change Photo: <br/>
                            <input type="file" name="image" style="margin:5px;" /> <br/>
                            <input type="submit" style="margin:5px;color:white;background-color: #1FB6B9;cursor:hand;border:1px solid black;"/>
                        </form>
                    </div>
                 </tr>

                <tr>
                </table>
                </td>

                <td width="50%" style="vertical-align: bottom;">
                    <div style="transform:translateX(30%);margin:10px; margin-right: 5px; font-family:'Space Grotesk' ; font-size: 1em; font-weight: 900; color: #1FB6B9; cursor: hand; text-decoration: none" >
                        <a href="editProfile.jsp" style="text-decoration: none">
                            <img src= "Photo/edit.svg" alt="Edit Profile" style="width: 22px; height: 22px; vertical-align: text-bottom;"/>
                            Edit Profile
                        </a>
                    </div>
                </td>

                </tr>


            <tr width="100%" >
                <table width="100%" style="text-align: center;">
                    <tr>
                        <td style="font-family:'Space Grotesk' ; font-size: 1.7em; font-weight: 900; color: #1FB6B9;"> <%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%></td>
                    </tr>

                    <tr>
                        <td>
                            <div class="Profile_word" style="font-weight: 900; display: inline-block;font-size: 1.3em;">
                                Gender:
                            </div>

                            <div class= "Profile_word" style="margin-left: 2px; display: inline-block;font-size: 1.3em;">
                                <%=rs1.getString("gender")%>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="Profile_word" style="font-weight: 900; display: inline-block;font-size: 1.3em;">
                                Student ID:
                            </div>

                            <div class= "Profile_word" style="margin-left: 2px; display: inline-block;font-size: 1.3em;">
                                <%=rs1.getString("student_id")%>
                            </div>
                        </td>

                    </tr>

                    <tr>
                        <td>
                            <div class="Profile_word" style="font-weight: 900; display: inline-block;font-size: 1.3em;">
                                Contact No:
                            </div>

                            <div class= "Profile_word" style="margin-left: 2px; display: inline-block;font-size: 1.3em;">
                                <%=rs1.getString("mobile")%>
                            </div>
                        </td>
                        </tr>
                    <tr>
                        <td>
                            <div class= "Profile_word" style="margin-left: 2px; display: inline-block;font-size: 1.3em;">
                                <%
                                    if(rs1.getString("description")==null){
                                %>
                                    Hey there! i'm using On Call! [Default]
                                <%
                                }else{

                                out.print(rs1.getString("description"));}
                                %>
                            </div>
                        </td>
                    </tr>

                </table>


            </tr>



        <% }
            %>


    </table>


  </div>

<div class= "myRequest_box" style="margin: 20px auto;">
    <div>

        <table width="100%">
            <tr>
                <td>
                    <div style="margin:10px; margin-right: 5px; font-family:'Space Grotesk' ; font-size: 1.1em; font-weight: 900; color: #1FB6B9;">

                        <img src= "Photo/post.svg"  style="width: 22px; height: 22px; vertical-align: text-bottom;"/>
                        My Request

                    </div>

                </td>

            </tr>
        </table>

    </div>

    <div style="margin:3px auto; width: 350px;">
        <table width="100%">
            <tr>
                <td width="50%">
                    <div class="logo_box">
                        <div>
                           <a href="myrequest.jsp#to_be_completed">
                            <img src="Photo/system_pending_line.png" alt="My Request" style="width:50px; height:50px; padding: 4.5px;"/>
                           </a>
                        </div>

                    </div>
                    <div class="Profile_word" style="padding: 5px; text-align:center;">
                        To Complete

                    </div>


                </td>

                <td width="50%">
                    <div class="logo_box">
                        <div>
                            <a href="myrequest.jsp#completed">
                            <img src="Photo/complete (1).svg" alt="Completed" style="width:50px; height:50px; padding: 4.5px;"/>
                            </a>
                        </div>

                    </div>
                    <div class="Profile_word" style="padding: 5px; text-align:center;">
                        Request Completed

                    </div>
                </td>
            </tr>

        </table>
    </div>


</div>


<div class="requestBg" >
    <div>
        <div class="postsWord"><b>All Posts</b></div>
        <table class="tableStyle" cellpadding="55px" width="100%">

            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
                Statement stm=conn.createStatement();
                String sql;
                sql = "select post_id,first_name,title,content,type,poster_uid,users.id as user_id,image from post join users on post.poster_uid=users.id where post.poster_uid="+ request.getParameter("user_id");
                ResultSet rs=stm.executeQuery(sql);
                while (rs.next())
                {


            %>
            <tr>
                <td class="table" width="33.33%" style="padding:20px;">

                    <div class="request" style="width:320px">
                        <div>
                            <%
                                Blob imageBlob= rs.getBlob("image");
                                byte[] imageBytes=imageBlob.getBytes(1, (int)imageBlob.length());
                                if(imageBlob.length()==0){%>

                            <img class="image" src="Photo/User.png" alt="user img" style="border: none">
                            <%}else{

                                String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

                            <img class="image" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
                            <%}%>
                        </div>
                        <div class="name">
                            <b><%=rs.getString("first_name")%></b>
                        </div>
                        <div class="title">
                            <b><%=rs.getString("title")%></b>
                        </div>
                        <a href="postDetail.jsp?post_id=<%=rs.getString("post_id")%>">
                            <div>
                                <input type="button" value="View" class="button" style="left:100px;" />
                            </div>
                        </a>
                        <div>
                            <form action="DeletePostServlet" method="post">

                                <a href="DeletePostServlet?post_id=<%=rs.getString("post_id")%>">
                                    <div>
                                        <input onclick="this.value='Deleted'" type="button" value="Delete" class="button helpButton" style="left:100px;" />
                                    </div>
                                </a>
                            </form>
                        </div>


                    </div>
                </td>

                <%if(rs.next())
                {%>
                <td class="table" width="33.33%" style="padding:20px;">
                    <div class="request" style="width: 320px">
                        <div>
                            <%

                                if(imageBlob.length()==0){%>

                            <img class="image" src="Photo/User.png" alt="user img" style="border: none">
                            <%}else{

                                String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

                            <img class="image" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
                            <%}%>
                        </div>
                        <div class="name">
                            <b><%=rs.getString("first_name")%></b>
                        </div>
                        <div class="title">
                            <%=rs.getString("title")%>
                        </div>
                        <a href="postDetail.jsp?post_id=<%=rs.getString("post_id")%>">
                            <div>
                                <input type="button" value="View" class="button" style="left:100px;" />
                            </div>
                        </a>
                        <div>
                            <form action="DeletePostServlet" method="post">

                                <a href="DeletePostServlet?post_id=<%=rs.getString("post_id")%>">
                                    <div>
                                        <input onclick="this.value='Deleted'" type="button" value="Delete" class="button helpButton" style="left:100px;" />
                                    </div>
                                </a>
                            </form>
                        </div>


                    </div>
                </td>
                <%}%>


                <%if(rs.next())
                {%>
                <td class="table" width="33.33%" style="padding:20px;">
                    <div class="request" style="width:320px">
                        <div>
                            <%

                                if(imageBlob.length()==0){%>

                            <img class="image" src="Photo/User.png" alt="user img" style="border: none">
                            <%}else{

                                String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

                            <img class="image" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
                            <%}%>
                        </div>
                        <div class="name">
                            <b><%=rs.getString("first_name")%></b>
                        </div>
                        <div class="title">
                            <%=rs.getString("title")%>
                        </div>
                        <a href="postDetail.jsp?post_id=<%=rs.getString("post_id")%>">
                            <div>
                                <input type="button" value="View" class="button" style="left:100px;" />
                            </div>
                        </a>
                        <div>
                            <form action="DeletePostServlet" method="post">

                                <a href="DeletePostServlet?post_id=<%=rs.getString("post_id")%>">
                                    <div>
                                        <input onclick="this.value='Deleted'" type="button" value="Delete" class="button helpButton" style="left:100px;" />
                                    </div>
                                </a>
                            </form>
                        </div>

                    </div>
                </td>
                <%}%>
            </tr>

            <%
                }
            %>

        </table>
    </div>

</div>
</div>

<!--footer-->

   <div
    style="line-height:25px;margin-top:0px;font-weight:900;text-align:center;font-family:'Space Grotesk';font-size:20px;background-color:#1FB6B9;padding:15px; color:white;">
    Copyright 2020, Xiamen University Malaysia<br />
    On Call Development Team
  </div>
</body>

</html>