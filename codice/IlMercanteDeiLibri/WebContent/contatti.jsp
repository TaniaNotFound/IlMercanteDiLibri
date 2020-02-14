<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="description" content="Il Mercante di Libri">
<meta name=" author" content="Michela Scarpone">
<meta name=" author" content="Tania Stanescu">
<meta name=" author" content="Giorgia Abbate">



<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">

<title>Contatti</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body style="background-image: url(img/libri.png)">


	<%
	String url = request.getRequestURL().toString();
	String name = (String) session.getAttribute("name");
	String emailUtente = (String) session.getAttribute("emailUtente");
	String admin = (String) session.getAttribute("Username");

	int isAdmin = 0;
	int isUtente = 0;
	if(name!=null) {

	try {
		isAdmin = (int) session.getAttribute("adminIn");  
		isUtente = (int) session.getAttribute("clienteIn"); 
	}
	catch(Exception e){
		;
	}
%>


	<%
			if(emailUtente!=null) {
%>
	<!-- 		<p>ID cliente: <%=emailUtente %></p>  -->
	<% 
			}
		}
	
%>
	<!-- Navbar grande -->
	<div class="navbar">

		<div id="main_menu">
			<label class="toggle" for="toggle">&#9776;</label>
			<!-- simbolo del menu (3 linee orizzontali) -->
			<input class="toggle" id="toggle" type="checkbox">
			<nav>
				<ul id="menu">
					<!-- HOME -->
					<li class="current"><a href="index.jsp"><img
							src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
							<!-- CATALOGO -->
					<li class="has_children"><a id="log" href="./AllBooksList">
							Catalogo</a></li>
							
						<%
			
					if (admin != null) {
				%>
					<li style="float: right;"><a id="log"> Benvenuto
							<%=admin%></a></li>
					<li style="float: right;"><a href="logout.jsp?link=<%=url%>" id="log"> Logout </a></li>
				
			<%}
					else if (name != null) {
			%>
					<li style="float: right;"><a href="./vetrina.jsp" id="log">Benvenuto <%=name%></a></li>
					<li style="float: right;"><a id="log"href="logout.jsp?link=<%=url%>">
							Logout </a></li>
					<%
				} else {
			%>
					<li style="float: right;"><a id="log" href="login.jsp?link=<%=url%>">
							Login </a></li>
					<%
				}
			%>
					<li style="float: right;"><a href="CartPage.jsp"><img
							src="img/empty-cart-light.png" alt="Carrello" class="icon"
							id="cartHome"></a></li>



				</ul>
			</nav>
		</div>

	</div>

	<br />
	
	<h1 style="text-align: center; color: #ffcc00fa;
    text-shadow: 6px 4px 5px darkRed; font-size:65px" >
     <mark style="background-color: #ffcc0054;border-radius: 20px;color: #ffcc00;">Contatti </mark></h1>
     
	<div class="divContorno" style="box-shadow: 0px 0px 20px 9px darkred;">
		<div id="contenitore">

			<h2 style="color: darkred">Michela Scarpone</h2>
			<p>
				Mail studenti: <a>m.scarpone@studenti.unisa.it</a>
			</p>


			<h2 style="color: darkred">Tania Stanescu</h2>
			<p>
				Mail studenti: <a>t.stanescu@studenti.unisa.it</a>
			</p>

			<h2 style="color: darkred">Giorgia Abbate</h2>
			<p>
				Mail studenti: <a>g.abbate3@studenti.unisa.it</a>
			</p>

		</div>
	</div>

	<!-- Footer -->

	<footer id="footer">
		<hr>

		<div id="info_menu">
			<p>
				<a href="perConoscerci.jsp">Per conoscerci</a>
			</p>
			<p>
				<a href="contatti.jsp">Contatti</a>
			</p>
			<%
		if(isAdmin == 1) { //Admin connesso. Passa a pannello controllo admin
%>
			<p id="right_side" align="right">
				<a href="adminPage.jsp">Zona Riservata</a>
			</p>
			<%
		} else if(isUtente == 1) { //Cliente connesso.
%>
			<p id="right_side" align="right">
				<a href="adminPage.jsp?link=<%=url %>">Zona Riservata</a>
			</p>
			<%
		} else { //nessuno connesso. Porta alla pagina di login
%>
			<p id="right_side" align="right">
				<a href="adminPage.jsp?link=<%=url %>">Zona Riservata</a>
			</p>
			<%
		}
%>
		</div>

	</footer>

	<hr>

	<p style="color: grey; text-align: center;">Copyright © 2020 Il
		Mercante di Libri. All rights reserved.</p>

</body>
</html>