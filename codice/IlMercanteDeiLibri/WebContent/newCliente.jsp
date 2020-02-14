<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="descrizione" content="Il Mercante di Libri">
<meta name=" autore" content="Abbate Giorgia">
<meta name=" autore" content="Michela Scarpone">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<script src="javaScript/validaRegistrazione.js"></script>
<script src="WebContent/javaScript/validaRegistrazione.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<title>Registrazione</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body>
	<%  
	try {
		String urlRet = request.getRequestURL().toString();
		String username = (String) session.getAttribute("name");
		
	%>
	<!-- Navbar piccola -->
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
					<%
	if(username!=null) {
%>
					<li style="float: right;"><a id="log">Benvenuto <%=username%></a></li>
					<li style="float: right;"><a id="log"
						href="logout.jsp?link=<%=urlRet %>"> Logout </a></li>
					<%
	} 
%>
				</ul>
			</nav>

		</div>


	</div>



	<h2 align="center" style="color: darkred">Registrati</h2>

	<div class="divContorno" style="background-color: darkred">
		<div id="contenitore">
			<form action="./AddCliente" method="post"  id="f1">
				<table align="center" style="width: 350px; height: 350px">

					<tr>
						
						<td colspan=2 style="color: white; text-align: right;">Nome:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text" placeholder="Enter name"
							id="nome"
							name="nome" required maxlength="30"
							style="width: 180%; height: 120%; border-radius: 30px"></td>
					</tr>
				
					<tr>
						<td colspan=2 style="color: white; text-align: right;">Cognome:</td>
					</tr>
					
					<tr>
						<td colspan=2><input type="text" placeholder="Enter surname"
						id="cognome"
							name="cognome" required maxlength="30"
							style="width: 180%; height: 120%; border-radius: 30px">
						</td>
					</tr>

					<tr>
						<td colspan=2 style="color: white; text-align: right;">Email:</td>
					</tr>
				
					<tr>
						<td colspan=2><input type="text" placeholder="Enter email"
							name="email" required maxlength="45"
							id="email"
							style="width: 180%; height: 120%; border-radius: 30px">
						</td>
					</tr>

					<tr>
						<td colspan=2 style="color: white;text-align: right;">Password:</td>
					</tr>
					
					<tr>
						<td colspan=2><input type="password"
							placeholder="Enter password" name="password"
							id="password"
							 required maxlength="45" style="width: 180%; height: 120%; border-radius: 30px">
						</td>
					</tr>
					
					<tr>
						<td colspan=2 style="color: white;">Via:</td>
						<td colspan=2 style="color: white; text-align: center;">Nr Civico:</td>
					</tr>
					
					<tr>
						<td colspan=2><input type="text" placeholder="Enter via"
							name="via" required maxlength="20"
							id="via"
							style="width: 120%; height: 120%; border-radius: 30px"></td>
						
						<td colspan=2><input type="number" placeholder="Enter nrCivico"
							id="nrCivico"
							name="nrCivico" 
							style="width: 50%; height: 120%; border-radius: 30px"></td>
					</tr>
					
					<tr> </tr>
					<tr> </tr>
					<tr>
						<td colspan=2 style="color: white;">Città:</td>
						<td colspan=2 style="color: white;">CAP:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text" placeholder="Enter città"
							name="citta" required maxlength="45"
							id="citta"
							style="width: 120%; height: 120%; border-radius: 30px"></td>
								
						<td colspan=2><input type="number" placeholder="Enter CAP"
							name="cap" 
							id="cap"
							style="width: 50%; height: 120%; border-radius: 30px"></td>
					</tr>
			
					
					<tr></tr>
					
					<tr>
						<td class="buttonTd"><input type="submit" value="Invia"
							style="width: 50%; height: 100%; border-radius: 30px;position: relative; bottom:-5px; left:70px" ></td>
					</tr>
				</table>
			</form>

			<% 
	} catch(NullPointerException e) {
		e.printStackTrace();
		}
%>

		</div>
	</div>
	
	<hr>

	<p style="color: grey; text-align: center;">Copyright © 2020 Il
		Mercante di Libri. All rights reserved.</p>
</body>
</html>