<%@ page import="newpackage.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>

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
  <link rel="icon" href="./logo/logo.ico">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>

  <title>Mission</title>
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
      text-align: left;
      padding: 5px;
      color: #1FB6B9;
    }
	
	.top-font{
	font-family: 'Space Grotesk';
      font-weight: 900;
      font-size: 30px;
      text-align: left;
	  vertical-align: middle;
	  margin-top:4px;
      padding: 5px;
      color: #1FB6B9;
	
	}
	
	.title-icon{
	align-items:left;
	position:relative;
	left:10px;
	top:5px;
	margin-bottom:5px;
	padding:5px;
	padding-right:10px;
	height:40px;
	width:40px; 
	}
	
	.row{
	font-family: 'Space Grotesk';
    font-size: 20px;
    text-align: left;
    padding: 0px;
    color: #707070;
	box-shadow:0px 2px 3px rgba(0, 0, 0, 0.1);
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
	
	.name{
	font-family: 'Space Grotesk';
    font-size: 18px;
    text-align: center;
    padding: 5px;
    color: #707070;
	}
	
	
	.button_cancel{
		background-color:#707070;
		color:white; 
		font-family: Space Grotesk;
		font-size:20px;
		margin: 0 auto;
		margin-left:3px;
		padding: 10px;
		text-align:center;
		vertical-align:center;		
		width:7em; 
		height: 50px;
		border-radius: 5px;
		cursor: hand;
		border:none;
		outline:none;
	}
	
	.button_cancel:hover {
		background-color: #95999a;

	}
	
	
    .button_complete{
		background-color:#1FB6B9;
		color:white; 
		font-family: Space Grotesk;
		font-size:20px;
		margin: 0 auto;
		padding:10px; 
		text-align:center;  
		vertical-align:center;
		width:7em; 
		height: 50px;
		border-radius: 5px;
		cursor: hand;
		border:none;
		outline:none;
	}
	
	.button_complete:hover {
		background-color:#95999a;
	}


	.fas:hover {
		transform: rotate(-15deg) scale(1.3);

		color:#efa910 !important;
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
			<img src="./Photo/task.svg" style="position:relative;left:50px;height:80px;width:80px;padding-top:10px;padding-left:20px; "  />
			</td>
			
			<td class="Title-font" width="99%" style="padding-top:15px;padding-left:70px;">
                Missions
			</td>
		</tr>
	</table>
  </div>
  
  
  <div style="margin:50px auto;width:85%; box-shadow:0px 4px 5px rgba(0, 0, 0, 0.1);"	>
	<table width="100%" style="text-align:left;background-color:white;" cellpadding="3px">

		<tr style="background-color:#F8F8F8;">
				<td style="display:inline-block;padding:10px">
					<img class="title-icon" src="./Photo/system_pending_line.png"  />
				</td>
				
				<td style="display:inline-block;padding:10px">
					<div class="top-font"> 
					Pending Missions </div>
				</td>
				
				
			</tr>
	</table>
	
	<table width="100%" style="text-align:left;background-color:white;" cellpadding="5px">

		<%--status=1 mean accepted mission by someone--%>

		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/oncall", "root","123456");
			Statement stm=conn.createStatement();
			String sql;
			sql = "select post_id,first_name,type,title,creation_date,image,id from post\n" +
					"join users on post.poster_uid=users.id\n" +
					"where status=1 and helper_uid="+ session.getAttribute("user_id");
			ResultSet rs=stm.executeQuery(sql);
			while (rs.next())
			{

		%>


		<tr class="row" width="100%">
			<td width="10%">
				<div>
				<div style="padding-left:25px;">
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
				
				<div class="name" >
				<%=rs.getString("first_name")%>
				</div>
				</div>
			</td>
			
			
			<td width="40%"><%=rs.getString("title")%></td>
			
			<td width="10%" style="text-align:center;"><%=rs.getString("type")%></td>
			
			<td width="10%" style="text-align:center;"><%=rs.getString("creation_date")%></td>
			
			<td width="15%">

				<form action="CancelServlet" method="post">

					<a href="CancelServlet?post_id=<%=rs.getString("post_id")%>" style="text-decoration: none;">
						<div>
							<input onclick="this.value='Cancelled'" type="button" value="Cancel" class="button_cancel" />
						</div></a>
				</form>
			</td>
			
			<td width="15%" >
				<form action="CompleteServlet" method="post">

					<a href="CompleteServlet?post_id=<%=rs.getString("post_id")%>" style="text-decoration: none;">
						<div >
							<input onclick="this.value='Completed'" type="button" value="Complete" class="button_complete" />
						</div></a>
				</form>
			</td>



		</tr>

		<%
			}
		%>
	
	</table>
  </div>
  
  
  
  <div style="margin:100px auto;width:85%; box-shadow:0px 4px 5px rgba(0, 0, 0, 0.1);"	>
	<table width="100%" style="text-align:left" cellpadding="3px">
		<tr style="background-color:#F8F8F8;">
				<td style="display:inline-block;padding:10px">
					<img class="title-icon" src="./Photo/complete.png"  />
				</td>
				
				<td style="display:inline-block;padding:10px">
					<div class="top-font"> 
					Completed Missions </div>
				</td>
				
				
			</tr>
	</table>
	
	<table width="100%" style="text-align:left;background-color: white;" cellpadding="3px">
		<%--status=2 mean completed mission by someone--%>
		<%

			String sql_1;
			sql_1 = "(select first_name,type,title,creation_date,image,status,star,id from post\n" +
					"\t\t\t\t\tjoin users on post.poster_uid=users.id\n" +
					"\t\t\t\t\twhere status=2 and helper_uid="+session.getAttribute("user_id")+")\n" +
					"                    union (select first_name,type,title,creation_date,image,status,star,id from post\n" +
					"\t\t\t\t\tjoin users on post.poster_uid=users.id\n" +
					"\t\t\t\t\twhere status=3 and helper_uid="+session.getAttribute("user_id")+");";
			ResultSet rs1=stm.executeQuery(sql_1);
			while (rs1.next())
			{

		%>
			
		<tr class="row" width="100%">
			<td width="10%">
				<div>
				<div style="padding-left:25px;">
					<%
						Blob imageBlob= rs1.getBlob("image");
						byte[] imageBytes=imageBlob.getBytes(1, (int)imageBlob.length());
						if(imageBlob.length()==0){%>
					<a href="UserProfileServlet?user_id=<%=rs1.getString("id")%>">
					<img class="user-icon" src="Photo/User.png" style="border: none">
					</a>
					<%}else{

						String encodedImage= Base64.getEncoder().encodeToString(imageBytes);%>

					<a href="UserProfileServlet?user_id=<%=rs1.getString("id")%>">
					<img class="user-icon" src="<%="data:image/jpg;base64,"+encodedImage%>" alt="user img">
					</a>
					<%}%>
				</div>
				
				<div class="name" >
				<%=rs1.getString("first_name")%>
				</div>
				</div>
			</td>
			
			
			<td width="40%"><%=rs1.getString("title")%></td>
			
			<td width="10%" style="text-align:center;"><%=rs1.getString("type")%></td>
			
			<td width="10%" style="text-align:center;"><%=rs1.getString("creation_date")%></td>
			
			<td width="30%" style="text-align: center;">

				<%
					if (rs1.getString("status").equals("2")){%>
				No feedback yet
				<% }else if (rs1.getString("status").equals("3")){ %>
				<i style="font-size:36px;color:#efa910" class="fas">&#xf005;</i> x <%=rs1.getString("star")%>
				<% } %>

			</td>
			

		</tr>

			<%
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