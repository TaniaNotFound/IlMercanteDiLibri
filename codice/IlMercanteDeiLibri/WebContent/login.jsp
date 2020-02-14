<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.lang.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="descrizione" content="Il Mercante di Libri">
<meta name=" autore" content="Tania Stanescu">
<meta name=" autore" content="Michela Scarpone">
<meta name=" autore" content="Giorgia Abbate">

<meta name="viewport" content="width-device-width, initial-scale-1.0">


<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">


<title>Login</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body style="background-image: url(img/libri.png)">
	<%
	String url = (String) request.getParameter("link"); //riceve il link della pagina che lo ha chiamato
	session.setAttribute("link", url);
%>
	<!-- Navbar mini-piccola -->
	<div class="navbar">

		<div id="main_menu">
			<label class="toggle" for="toggle">&#9776;</label>
			<!-- simbolo menu (3 linee orizzontali) -->
			<input class="toggle" id="toggle" type="checkbox">
			<nav>
				<ul id="menu">
					<!-- HOME -->
					<li class="current"><a href="index.jsp"><img
							src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
				</ul>
			</nav>

		</div>
	</div>

	<!-- 	<p>Richiesta login ricevuto da <%=url %></p>  -->
	<h2 align="center" style="text-align: center; color: #ffcc00fa;
    text-shadow: 6px 4px 5px darkRed; font-size:65px" >
     <mark style="background-color: #ffcc0054;border-radius: 20px;color: #ffcc00;">
		Login </mark>	</h2>

	<div class="divContorno" style="background-color: darkRed">
		<div id="contenitore">

			<%
	try {
	
		String username = (String) session.getAttribute("name");
		if(username!=null) {
%>
			<p>
				Utente
				<%=username %>
				già connesso!
			</p>
			<p>
				<a href="logout.jsp?link=<%=url %>">Logout</a>
			</p>
			<%
		} else {
%>

			<div id="leftLogin">
				<form action="./AdminLogin" method="POST">
					<table align="center" style="width: 300px; height: 250px">
						<caption class="tabTitle" style="color: white;">Admin</caption>
						<tr>
							<td colspan=2 style="color: white;">Username:</td>
						</tr>
						<tr>
							<td colspan=2><input type="text"
								placeholder="Enter username" name="Username" required
								style="width: 100%; height: 100%; border-radius:30px"></td>
						</tr>
						<tr>
							<td colspan=2 style="color: white;">Password</td>
						</tr>
						<tr>
							<td colspan=2><input type="password"
								placeholder="Enter password" name="Password" required
								style="width: 100%; height: 100%;border-radius:30px"></td>
						</tr>
						<tr></tr>
						<tr>
							<td class="buttonTd"><input type="submit" value="Accedi"
								style="width: 50%; height: 100%; border-radius:30px;background-color:  #ffeb99;"></td>
						</tr>
					</table>
				</form>
			</div>

			<div id="rightLogin">
				<form action="./ClientLogin" method="POST">
					<table align="center" style="width: 300px; height: 250px">
						<caption class="tabTitle" style="color: white;">Utente</caption>
						<tr>
							<td colspan=2 style="color: white;">Email:</td>
						</tr>
						<tr>
							<td colspan=2><input type="text"
								placeholder="Enter username" name="usernameCliente" required
								style="width: 100%; height: 100%;border-radius:30px"></td>
						</tr>
						<tr>
							<td colspan=2 style="color: white;">Password</td>
						</tr>
						<tr>
							<td colspan=2><input type="password"
								placeholder="Enter password" name="PswCliente" required
								style="width: 100%; height: 100%;border-radius:30px"></td>
						</tr>
						<tr></tr>
						<tr>
							<td class="buttonTd"><input type="submit" value="Accedi"
								style="width: 100%; height: 100%;border-radius:30px;background-color: #ffeb99;"></td>
								
							<td class="buttonTd"><input type="button" value="Registrati"
								onclick="top.location.href = 'newCliente.jsp'"
								style="width: 100%; height: 100%;border-radius:30px;background-color:   #ffeb99;"></td>
						</tr>
					</table>
				</form>
			</div>
			<%			
		}
	} catch(NullPointerException e) {
%>
			<p>Error in page.</p>
			<%	
	}
%>

		</div>
	</div>
		<hr>

	<p style="color: grey; text-align: center;">Copyright © 2020 Il
		Mercante di Libri. All rights reserved.</p>
</body>
</html>