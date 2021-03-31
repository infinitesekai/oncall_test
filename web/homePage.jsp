<%@ page import="newpackage.User" %>
<%@ page import="newpackage.Post" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>

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
  <script src='https://kit.fontawesome.com/a076d05399.js'></script>
  <title>On Call Home Page</title>
  <style>
    body {
      margin: 0px;
      border: 0px;
      padding: 0px;
      width:100%;
      background-color: #F8F8F8;;
    }



    #header li {
      position: relative;
      bottom: 20px;
      cursor: hand;
      display: inline;
      width: 70px;
      margin: 10px;
      text-align: center;
      vertical-align: center;
      padding: 25px;
      padding-bottom: 10px;
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

    .Services_box {
      width: 167px;
      height: 167px;
      box-shadow: 0px 4px 5px #888888;
      border-radius: 5px;
      cursor: hand;
      background-color: white;
    }

    .Services_font {
      color: #707070;
      text-align: center;
      font-size: 15px;
      font-family: 'Space Grotesk'
    }

    .Services_box:hover {
      background-color: #DDDDDD;
    }

    .fas:hover {
      transform: rotate(-15deg) scale(1.3);

    }

    .header_desc{
      width: 80%;
      position: relative;
      margin: 0;
      padding: 0px;
    }
    .header_stable{
      margin: 0;
      text-align: left;
      text-shadow: 1px 1px 1px rgba(255,255,255,0.8);
    }
    .header_stable span{
      color: #444;
      white-space: nowrap;
      font-size: 25px;
      font-weight: normal;
    }
    .word_animate{
      display: inline;
      text-indent: 10px;
    }
    .word_animate span{
      position: absolute;
      opacity: 0;
      overflow: hidden;
      color: #ccc;
    }

    .word_animate1 span{
      animation: animation1 15s linear infinite 0s;
    }
    .word_animate2 span{
      animation: animation2 15s linear infinite 0s;
    }
    .word_animate span:nth-child(2) {
      animation-delay: 3s;
      color: #647d8f;
    }
    .word_animate span:nth-child(3) {
      animation-delay: 6s;
      color: #545974;
    }
    .word_animate span:nth-child(4) {
      animation-delay: 9s;
      color: #7a6b9d;
    }
    .word_animate span:nth-child(5) {
      animation-delay: 12s;
      color: #8d6b9d;
    }
    .word_animate span:nth-child(6) {
      animation-delay: 15s;
      color: #9b6b9d;
    }

    @keyframes animation1 {
      0% { opacity: 1; animation-timing-function: ease-in; height: 0px; }
      8% { opacity: 1; height: 60px; }
      19% { opacity: 1; height: 60px; }
      25% { opacity: 0; height: 60px; }
      100% { opacity: 0; }
    }

    @keyframes animation2 {
      0% { opacity: 1; animation-timing-function: ease-in; width: 0px; }
      10% { opacity: 0.3; width: 0px; }
      20% { opacity: 1; width: 100%; }
      27% { opacity: 0; width: 100%; }
      100% { opacity: 0; }
    }
    /*number animation*/

    .num_animate{
      display: inline;
      text-indent: 10px;
    }
    .num_animate span{
      position: absolute;
      opacity: 0;
      overflow: hidden;
      color: #ccc;
    }

    .num_animate1 span{
      animation: num_animation1 10s linear infinite 0s;
    }
    .num_animate span:nth-child(2) {
      animation-delay: 1s;
      color: #789799;
    }
    .num_animate span:nth-child(3) {
      animation-delay: 2s;
      color: #789799;
    }
    .num_animate span:nth-child(4) {
      animation-delay: 3s;
      color: #6c8c8e;
    }
    .num_animate span:nth-child(5) {
      animation-delay:4s;
      color: #6c8c8e;
    }
    .num_animate span:nth-child(6) {
      animation-delay: 5s;
      color: #658486;
    }
    .num_animate span:nth-child(7) {
      animation-delay: 6s;
      color: #658486;
    }
    .num_animate span:nth-child(8) {
      animation-delay: 7s;
      color: #617f80;
    }
    .num_animate span:nth-child(9) {
      animation-delay: 8s;
      color: #617f80;
    }
    .num_animate span:nth-child(10) {
      animation-delay: 9s;
      color: #5d787a;
    }


    @keyframes num_animation1 {
      0% { opacity: 1; animation-timing-function: ease-in; height: 0px; }
      10% { opacity:  0; height: 60px; }
      20% { opacity:  0; height: 60px; }
      30% { opacity:  0; height: 60px; }
      40% { opacity: 0; height: 60px; }
      50% { opacity: 0; height: 60px; }
      60% { opacity: 0; height: 60px; }
      70% { opacity: 0; height: 60px; }
      80% { opacity: 0; height: 60px; }
      90% { opacity: 0; height: 60px; }
      100% { opacity: 0; }
    }

  </style>
</head>

<body>

<div style="padding-left:30px;padding-right:50px;height:70px; background-color:white;box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1), 0 2px 2px 0 rgba(0, 0, 0, 0.1);">
  <div id="header" style="float:right;position:relative;bottom:10px; ">
    <li>Home</li>
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

<div
        style="width:fit;position:relative;top:1.5px;padding-right:30px;height:350px; background-color:white;box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1), 0 2px 2px 0 rgba(0, 0, 0, 0.1);">
  <table width="100%">
    <tr>
      <td width="65%">
        <table width="100%">
          <tr>
            <td
                    style="font-weight:900;text-align:left;font-size:32px;padding-top:10px;padding-left:50px;font-family:'Space Grotesk';color:#1FB6B9">
              Dear XMUMians,
              Your personal assistance is here!<br>
              On Call <div class="num_animate num_animate1" style="display: inline">
              <span> <b>1</b></span>
              <span> <b>10</b></span>
              <span> <b>20</b></span>
              <span> <b>30</b></span>
              <span> <b>31</b></span>
              <span> <b>32</b></span>
              <span> <b>33</b></span>
              <span> <b>34</b></span>
              <span> <b>35</b></span>
              <span> <b>36</b></span>
            </div>
              <div style="transform:translateX(70%); display:inline-block;"> hours </div>

            </td>
          </tr>

          <tr>
            <td
                    style="text-align:left;font-size:20px;padding-left:50px;font-family:'Space Grotesk';color:#707070">
              On Call is an assistance provider platform for XMUM students<br>
              We aim to connect on-campus students who need assistance and those students who are willing to help.<br>
              <section class="header_desc">
                <h2 class="header_stable">
                  <span>If you are </span>

                  <div class="word_animate word_animate1">
                    <span>in need, </span>
                    <span>lovely, </span>
                    <span>bored, </span>
                    <span>lazy, </span>
                    <span>gloomy, </span>
                  </div>
                  <br />
                  <div class="word_animate word_animate2">
                    <span> post your <b>requests </b> here!<br></span>
                    <span> show your <b>love</b> here!<br></span>
                    <span> kindly lend your <b>helping hand</b> here!<br></span>
                    <span> find your <b>guardian</b> here!<br></span>
                    <span> seek your <b>companion</b> here!<br></span>
                  </div>
                </h2>
              </section>

            </td>
          </tr>
        </table>
      </td>

      <td width="35%">
        <img src="Photo/people_wave.png"
             style="position:relative;left:80px;bottom:5px;padding-right:15px;padding-top:25px;width:80%;height:65%" />
      </td>

    <tr>

  </table>
</div>


<div style=" background-color: #e6fff5; margin:0 auto; margin-right:0px; box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1), 0 2px 2px 0 rgba(0, 0, 0, 0.1); height:350px;text-align:center;">
  <div class="Title-font" style="padding-top:25px;margin:0px auto; display:inline-block; text-align:center;">
    <b>Services</b>
  </div>


    <table width="100%" cellpadding="30px">
      <tr>
        <td width="25%">
          <a href="Cleaning.jsp" style="text-decoration: none;">
            <div style="margin:5px auto; width: 85%; text-align:center; padding:10px;">
            <div class="Services_box">
            <div style="margin:10px auto; text-align:center; padding:5px;">
              <img src="Photo/clean.svg" style="height:90px; width:90px;">
            </div>

            <div class="Services_font">
              Cleaning
            </div>
          </div>
          </div>
          </a>
        </td>

        <td width="25%">
          <a href="PrintingService.jsp" style="text-decoration: none;"> <div class="Services_box">
            <div style="margin:10px auto; text-align:center; padding:5px;">
              <img src="Photo/print.svg" style="height:90px; width:90px;">
            </div>

            <div class="Services_font">
              Printing
            </div>
          </div></a>
        </td>

        <td width="25%">
          <a href="ErrandService.jsp" style="text-decoration: none;"><div class="Services_box">
            <div style="margin:10px auto; text-align:center; padding:5px;">
              <img src="Photo/errands.svg" style="height:90px; width:90px;">
            </div>

            <div class="Services_font">
              Errands
            </div>
          </div></a>
        </td>

        <td width="25%">
          <a href="CarpoolService.jsp" style="text-decoration: none;"><div class="Services_box">
            <div style="margin:10px auto; text-align:center; padding:5px;">
              <img src="Photo/car.svg" style="height:90px; width:90px;">
            </div>

            <div class="Services_font">
              Carpool
            </div>
          </div></a>
        </td>
      </tr>
    </table>
  </div>

</div>
<!--Part of Latest Request -->
<div style="margin:0 auto;margin-top:0.2em;box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1), 0 2px 5px 0 rgba(0, 0, 0, 0.1); ">
  <div>
    <div class="requestWord"><b>Latest Requests</b></div>
    <table class="tableStyle" cellpadding="55px" width="100%">

      <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
        Statement stm=conn.createStatement();
        String sql;
        sql = "select post_id,first_name,title,content,type,poster_uid,users.id as user_id,image,creation_date from post \n" +
                "join users on post.poster_uid=users.id where status=0 order by post_id desc limit 3;";
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
              <a href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                <img class="image" src="Photo/User.png" alt="user img" style="border: none">
              </a>
              <%}else{

                String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

              <a href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                <img class="image" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
              </a>
              <%}%>
            </div>
            <div class="name">
              <b><%=rs.getString("first_name")%></b>
            </div>
            <div class="title">
              <b><%=rs.getString("title")%></b>
            </div>
            <div class=" description" spellcheck="true" >
              <%=rs.getString("content")%>
            </div>
            <div class="name" style="text-align: center;" >
              <%=rs.getString("creation_date")%>
            </div>
            <form action="HelpServlet" method="post">

              <a href="HelpServlet?post_id=<%=rs.getString("post_id")%>&poster_uid=<%=rs.getString("poster_uid")%>" style="text-decoration: none;">
                <div class="button helpButton" style="left:1px;">

                  <b>Help</b>

                </div></a>
            </form>


          </div>
        </td>

        <%if(rs.next())
        {%>
        <td class="table" width="33.33%" style="padding:20px;">

          <div class="request" style="width:320px">
            <div>
              <%
                Blob imageBlob2= rs.getBlob("image");
                byte[] imageBytes2=imageBlob2.getBytes(1, (int)imageBlob2.length());
                if(imageBlob2.length()==0){%>

              <a href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                <img class="image" src="Photo/User.png" alt="user img" style="border: none">
              </a>
              <%}else{

                String encodedImage2= Base64.getEncoder().encodeToString(imageBytes2);%>

              <a href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                <img class="image" src="<%="data:image/jpg;base64,"+encodedImage2%>" alt="user img">
              </a>
              <%}%>
            </div>
            <div class="name">
              <b><%=rs.getString("first_name")%></b>
            </div>
            <div class="title">
              <b><%=rs.getString("title")%></b>
            </div>
            <div class=" description" spellcheck="true" >
              <%=rs.getString("content")%>
            </div>
            <div class="name" style="text-align: center;" >
              <%=rs.getString("creation_date")%>
            </div>
            <form action="HelpServlet" method="post">

              <a href="HelpServlet?post_id=<%=rs.getString("post_id")%>&poster_uid=<%=rs.getString("poster_uid")%>" style="text-decoration: none;">
                <div class="button helpButton" style="left:1px;">

                  <b>Help</b>

                </div></a>
            </form>


          </div>
        </td>
        <%}%>


        <%if(rs.next())
        {%>
        <td class="table" width="33.33%" style="padding:20px;">

          <div class="request" style="width:320px">
            <div>
              <%
                Blob imageBlob3= rs.getBlob("image");
                byte[] imageBytes3=imageBlob3.getBytes(1, (int)imageBlob3.length());
                if(imageBlob3.length()==0){%>

              <a href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                <img class="image" src="Photo/User.png" alt="user img" style="border: none">
              </a>
              <%}else{

                String encodedImage3= Base64.getEncoder().encodeToString(imageBytes3);%>

              <a href="UserProfileServlet?user_id=<%=rs.getString("user_id")%>">
                <img class="image" src="<%="data:image/jpg;base64,"+encodedImage3%>" alt="user img">
              </a>
              <%}%>
            </div>
            <div class="name">
              <b><%=rs.getString("first_name")%></b>
            </div>
            <div class="title">
              <b><%=rs.getString("title")%></b>
            </div>
            <div class=" description" spellcheck="true" >
              <%=rs.getString("content")%>
            </div>
            <div class="name" style="text-align: center;" >
              <%=rs.getString("creation_date")%>
            </div>
            <form action="HelpServlet" method="post">

              <a href="HelpServlet?post_id=<%=rs.getString("post_id")%>&poster_uid=<%=rs.getString("poster_uid")%>" style="text-decoration: none;">
                <div class="button helpButton" style="left:1px;">

                  <b>Help</b>

                </div></a>
            </form>

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


<!--highest rate helper-->

<div  style="margin:0 auto; margin-top:0.2em;box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.1), 0 2px 2px 0 rgba(0, 0, 0, 0.1);background-color: #e6fff5;">
  <div>
    <div class="requestWord"><b>Honour Board of Helpers</b></div>
    <table class="tableStyle" cellpadding="55px" width="100%">

      <%

        String sql_1;
        sql_1 = "select first_name,last_name,users.id as user_id,round(avg(star),2) as avg_star, image from post \n" +
                "join users on helper_uid=users.id where status =3 \n" +
                "group by user_id order by avg_star desc limit 3;";
        ResultSet rs1=stm.executeQuery(sql_1);
        while (rs1.next())
        {

      %>
      <tr>
        <td class="table" width="33.33%" style="padding:20px;">

          <div class="request" style="width:320px">
            <div>
              <%
                Blob imageBlob4= rs1.getBlob("image");
                byte[] imageBytes4=imageBlob4.getBytes(1, (int)imageBlob4.length());
                if(imageBlob4.length()==0){%>

              <a href="UserProfileServlet?user_id=<%=rs1.getString("user_id")%>">
                <img class="image" src="Photo/User.png" alt="user img" style="border: none">
              </a>
              <%}else{

                String encodedImage4= Base64.getEncoder().encodeToString(imageBytes4);%>

              <a href="UserProfileServlet?user_id=<%=rs1.getString("user_id")%>">
                <img class="image" src="<%="data:image/jpg;base64,"+encodedImage4%>" alt="user img">
              </a>
              <%}%>
            </div>
            <div class="name">
              <b><%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%> </b>
            </div>
            <div class="name">
            <i style="font-size:36px;color:#efa910" class="fas">&#xf005;</i> x <%=rs1.getString("avg_star")%> Rating
            </div>

          </div>
        </td>

        <%if(rs1.next())
        {%>
        <td class="table" width="33.33%" style="padding:20px;">

          <div class="request" style="width:320px">
            <div>
              <%
                Blob imageBlob5= rs1.getBlob("image");
                byte[] imageBytes5=imageBlob5.getBytes(1, (int)imageBlob5.length());
                if(imageBlob5.length()==0){%>

              <a href="UserProfileServlet?user_id=<%=rs1.getString("user_id")%>">
                <img class="image" src="Photo/User.png" alt="user img" style="border: none">
              </a>
              <%}else{

                String encodedImage5= Base64.getEncoder().encodeToString(imageBytes5);%>

              <a href="UserProfileServlet?user_id=<%=rs1.getString("user_id")%>">
                <img class="image" src="<%="data:image/jpg;base64,"+encodedImage5%>" alt="user img">
              </a>
              <%}%>
            </div>
            <div class="name">
              <b><%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%> </b>
            </div>
            <div class="name">
              <i style="font-size:36px;color:#efa910" class="fas">&#xf005;</i> x <%=rs1.getString("avg_star")%> Rating
            </div>

          </div>
        </td>
        <%}%>


        <%if(rs1.next())
        {%>
        <td class="table" width="33.33%" style="padding:20px;">

          <div class="request" style="width:320px">
            <div>
              <%
                Blob imageBlob6= rs1.getBlob("image");
                byte[] imageBytes6=imageBlob6.getBytes(1, (int)imageBlob6.length());
                if(imageBlob6.length()==0){%>

              <a href="UserProfileServlet?user_id=<%=rs1.getString("user_id")%>">
                <img class="image" src="Photo/User.png" alt="user img" style="border: none">
              </a>
              <%}else{

                String encodedImage6= Base64.getEncoder().encodeToString(imageBytes6);%>

              <a href="UserProfileServlet?user_id=<%=rs1.getString("user_id")%>">
                <img class="image" src="<%="data:image/jpg;base64,"+encodedImage6%>" alt="user img">
              </a>
              <%}%>
            </div>
            <div class="name">
              <b><%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%> </b>
            </div>
            <div class="name">
              <i style="font-size:36px;color:#efa910" class="fas">&#xf005;</i> x <%=rs1.getString("avg_star")%> Rating
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


<!--footer-->

<div
        style="line-height:25px;margin-top:0px;font-weight:900;text-align:center;font-family:'Space Grotesk';font-size:20px;background-color:#1FB6B9;padding:15px; color:white;">
  Copyright 2020, Xiamen University Malaysia<br/>
  On Call Development Team
</div>
</body>

</html>