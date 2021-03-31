<%@ page import="newpackage.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="newpackage.Post" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("user_id") == null)
    {
        response.sendRedirect("index.jsp");
    }

    Post post = (Post) session.getAttribute("post");
    User user = (User) session.getAttribute("logUser");
%>
<html>

<head>
  <link rel="styleSheet" href="CSS/style.css">
  <link rel="styleSheet" href="CSS/dropdown.css">
  <link rel="icon" href="./logo/logo.ico">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Edit Profile</title>
  <style>
    body {
      margin: 0px;
      border: 0px;
      padding: 0px;
	  width:100%;
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
      padding: 20px;
      padding-bottom: 30px;
      font-size: 15px;
      font-family: 'Space Grotesk';
      color: #707070;
    }

    .Title-font {
      font-family: 'Space Grotesk';
      font-weight: 900;
      font-size: 42px;
      text-align: center;
      padding: 5px;
      color: #1FB6B9;
    }



    .box_form
    {
    width:	500px;
	height:	auto;
    max-height: 800px;
	box-shadow: 0px 4px 5px #888888;
    border-radius: 5px;
    margin: 30px auto;
    background-color: white;
    }

          




    .button_register{
        background-color:#1FB6B9;
        color:white;
        font-family: Space Grotesk;
        font-weight:800;
        font-size:1.2em;
        margin: 10px auto;
        padding:10px;
        text-align:center;
        width:100%;
        height: 40px;
        border-radius: 5px;
        border: none;
        cursor: hand;
    }
    .button_register:hover {
        background-color: #707070;
    }

    input[type=text]
    {
        background-color: #F0EDED; 
        height:40px; 
        width: 422px;
        padding: 10px; 
        border:none;
        font-size: 15px;
        font-family: 'Space Grotesk';
        color: #707070;
                
    }

    input[type=password]
    {
        background-color: #F0EDED;
        height:40px;
        width: 422px;
        padding: 10px;
        border:none;
        font-size: 15px;
        font-family: 'Space Grotesk';
        color: #707070;

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

<div style="margin: 0 auto; width: 1000px;">
    <div class="box_form" >
        <div style="padding: 30px; padding-bottom: 5px; font-weight: 900; font-family:'Space Grotesk'; color: #1FB6B9; font-size: 1.5em;">
            <b>Edit Profile</b>
        </div>

        <div style="margin-left:30px ;width:85%; border-bottom: 2px solid #707070; ">

        </div>

        <form action="EditProfileServlet" method="post" enctype="multipart/form-data">
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
                Statement stm=conn.createStatement();
                String sql;
                sql = "select * from users where users.id="+ session.getAttribute("user_id");
                ResultSet rs=stm.executeQuery(sql);
                while (rs.next())
                {   Blob imageBlob= rs.getBlob("image");
                    byte[] imageBytes=imageBlob.getBytes(1, (int)imageBlob.length());
                    String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

            <div style="margin: 0 auto; width:490px; margin-bottom: 2px;">
                <div style="display: inline-block;">
                    <input type="text" name="first_name" value="<%=rs.getString("first_name")%> " placeholder="First name"
                           style="background-color: #F0EDED;
                        height:40px;
                        width: 200px;
                        margin: 30px ;
                        margin-right: 20px;
                        margin-bottom: 5px;
                        padding: 10px;
                        border:none;
                        font-size: 15px;
                        font-family: 'Space Grotesk';
                        color: #707070;
                    "/>
                </div>

                <div style="display: inline-block;">
                    <input type="text" name="last_name" value="<%=rs.getString("last_name")%>" placeholder="Last name"
                           style="background-color: #F0EDED;
                        height:40px;
                        width: 200px;
                        padding: 10px;
                        border:none;
                        font-size: 15px;
                        font-family: 'Space Grotesk';
                        color: #707070;
                        margin-bottom: 5px;
                    "/>
                </div>

            </div>

            <div style="margin:0 auto; width: 490px;">
                <table width="100%" cellpadding="5px">
                    <tr>
                        <td>
                            <div style="margin: 24px; margin-top: 1px; margin-bottom: 5px;">
                                <input type="text" name="email" value="<%=rs.getString("email")%>" placeholder="E-mail address"/>
                            </div>

                        </td>

                    </tr>
                    <td>
                        <div style="margin: 24px; margin-top: 1px; margin-bottom: 5px;">
                            <input type="text" pattern="[0-9]*" name="mobile" value="<%=rs.getString("mobile")%>" placeholder="Mobile number"/>
                        </div>

                    </td>

                    <tr>
                        <td>
                            <div style="margin: 24px; margin-top: 1px; margin-bottom: 5px;">
                                <input type="text" name="studentID" value="<%=rs.getString("student_id")%>" placeholder="Student ID"/>
                            </div>
                        </td>

                    </tr>

                    <tr>
                        <td>
                            <div  style="margin: 24px; margin-top: 1px; margin-bottom: 5px;font-family: 'Space Grotesk' ;color: #707070;">
                                <label for="seeAnotherField">Do You Want To Change Your Password?</label>
                                <select  id="seeAnotherField">
                                    <option  value="no">No</option>
                                    <option  value="yes">Yes</option>

                                </select>

                            </div>
                        </td>
                    </tr>

                    <tr id="otherFieldDiv">
                        <td>
                            <div style="margin: 24px; margin-top: 1px; margin-bottom: 5px;font-family: 'Space Grotesk' ;color: #707070;" >
                                <label for="otherField">You Can Change Your Password Now.</label>

                                <input id="otherField" value="<%=rs.getString("password")%>" type="password" name="password" placeholder="Password"/>

                            </div>
                        </td>
                    </tr>

                    <tr id="otherFieldDiv1">
                        <td>
                            <div style="margin: 24px; margin-top: 1px; margin-bottom: 5px;">
                                <input id="otherField1" type="password" name="rePass" placeholder="Retype password"/>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div style="margin: 24px; margin-top: 1px; margin-bottom: 5px;">
                                <input type="text" name="descriptionInput" placeholder="Describe yourself" value="<%=rs.getString("description")%>" style="height: auto"/>
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <div style="margin: 24px; margin-top: 1px; margin-bottom: 1px; font-size:1em; font-family: 'Space Grotesk' ;color: #707070;">
                                Gender
                            </div>

                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div style="margin: 19px; margin-top: 1px; margin-bottom: 5px;">
                                <table width="100%" cellpadding="5px" >
                                    <tr style="margin: 0 auto;">
                                        <c:set var="gender" value="<%=user.getGender()%>"/>
                                        <td width="33.3%">
                                            <input type="radio" id="male" name="gender" value="male"  <c:if test="${gender=='male'}">checked</c:if>>
                                            <label for="male" style="font-size: 20px; font-family: 'Space Grotesk' ;color: #707070;">Male</label>
                                        </td>

                                        <td  width="33.4%">
                                            <input type="radio" id="female" name="gender" value="female"  <c:if test="${gender=='female'}">checked</c:if>>
                                            <label for="female" style="font-size: 20px; font-family: 'Space Grotesk' ;color: #707070;">Female</label>
                                        </td>

                                        <td  width="33.3%">
                                            <input type="radio" id="other" name="gender" value="other"  <c:if test="${gender=='other'}">checked</c:if>>
                                            <label for="other" style="font-size: 20px; font-family: 'Space Grotesk' ;color: #707070;">Other</label>
                                        </td>



                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>


                </table>
                <%
                    }
                %>
            </div>

            <div style="margin: 0px auto; width: 120px;">
                <button class="button_register">
                    Update
                </button>
            </div>

        </form>




    </div>


</div>



  

  <!--footer-->

  <div
    style="line-height:25px;margin-top:0px;font-weight:900;text-align:center;font-family:'Space Grotesk';font-size:20px;background-color:#1FB6B9;padding:15px; color:white;">
    Copyright 2020, Xiamen University Malaysia<br/>
    On Call Development Team
  </div>
</body>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
<script src="JS/Password.js"></script>

</html>