<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="descrizione" content="Il Mercante di Libri">
<meta name=" autore" content="Tania Stanescu">
<meta name=" autore" content="Michela Scarpone">
<meta name=" autore" content="Giorgia Abbate">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<link rel="stylesheet" href="css/tables.css" type="text/css">

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title>Admin Page</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body>

	<%
	String url = request.getRequestURL().toString(); //url di provenienza home
	String name = (String) session.getAttribute("Username");
	String usernameCliente = (String) session.getAttribute("usernameCliente");
	String action="visualizza";
	
	int isAdmin = 0;
	int isUtente = 0;
	if(name!=null) {
	
	try {
		isAdmin = (int) session.getAttribute("adminIn");  
		isUtente = (int) session.getAttribute("utenteIn"); 
	}
	catch(Exception e){
		;
	}
		
%>

	<!-- Navbar -->
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
	if(name!=null) {
%>
					<li style="float: right;"><a id="log">Benvenuto <%=name%></a></li>
					<li style="float: right;"><a id="log" href="logout.jsp?link=<%=url %>">
							Logout </a></li>
					<%
	} 
%>
				</ul>
			</nav>

		</div>


	</div>

	<%  
	} 
	try {

		String username = (String) session.getAttribute("Username");
		if(isAdmin == 1) { //accesso alla pagina con account amministratore
			
%>
	<h1 align="center">Pagina Amministratore</h1>

	<br />
	<br />

	<div class="divContorno" style="box-shadow: 0px 0px 20px 9px darkred;">
		<div id="contenitore">

			<table width="100%" class="adminTable">
				<tr class="adminTable">
					<td width="50%" class="adminTable">

						<fieldset style="padding: 30px; color:darkRed; border-radius: 30px">
							<legend style="font-weight: bold">Gestione cliente</legend>
							<p>
								<a href="./DynamicTab?tab=Utente&action=<%=action%>">Visualizza
									e gestisci lista clienti.</a>
							</p>

						</fieldset>
					</td>
				</tr>
				<tr class="adminTable">
					<td width="50%" class="adminTable">
						<fieldset style="padding: 30px; color:darkRed;border-radius: 30px">
							<legend style="font-weight: bold">Gestione Catalogo</legend>
							<p>
								<a href="./DynamicTab?tab=Libro&action=<%=action%>">Visualizza
									e gestisci lista catalogo.</a>
							</p>

						</fieldset>
					</td>
			</table>



			<%
		}
		else if(isUtente == 1) { //accesso alla pagina con account locale
%>
			<h2>ACCESSO NON AUTORIZZATO!</h2>
			<p>
				Questa pagina è riservata solo ad account administrator. Torna alla
				<a href="index.jsp">home</a> per loggarti.
			</p>
			<%			
		}
		else if(isAdmin == 0) { //isAdmin sarà = 0 quando nessun account è al momento collegato
		%>
			<h2>ACCESSO NON AUTORIZZATO!</h2>
			<p>
				Non sei autorizzato ad entrare in questa pagina. Torna alla <a
					href="index.jsp">home</a> per loggarti.
			</p>

			<%
		}
	} catch(NullPointerException e) {
%>
			<!-- 	<p><%=e %></p> -->
			<p>.</p>
			<h2>ACCESSO NON AUTORIZZATO!</h2>
			<p>
				Non sei autorizzato ad entrare in questa pagina. Torna alla <a
					href="index.jsp">home</a> per loggarti.
			</p>
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