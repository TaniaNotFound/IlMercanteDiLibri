<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="components.Cart, beans.OrdineBean, beans.LibroBean, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<%
String name = (String) session.getAttribute("name"); //prendo nome utente
OrdineBean ordine=(OrdineBean) session.getAttribute("ordine");
String emailUtente = (String) session.getAttribute("emailUtente"); //prendo emailUtente
if(emailUtente == null) //se email utente = null lo imposto a 0 per visualizzazione default
	emailUtente= "0";
String url = "http://localhost:8080/IlMercanteDeiLibri/index.jsp"; //la stringa url porterà all'index

Cart cart = (Cart) session.getAttribute("cart"); //prendo un carrello dalla sessione
%>
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

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title>Acquisto Effettuato</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body>

	<%
	int isAdmin = 0; //variabile usata per tener traccia di admin loggato
	int isUtente = 0; //variabile usata per tener traccia di utente loggato
	
	try { //prende una o l'altra variabile (non potranno essere prese entrambe - 1 login)
		isAdmin = (int) session.getAttribute("adminIn");  
		isUtente = (int) session.getAttribute("utenteIn"); 
	}
	catch(Exception e){
		;
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
							src="img/logo.png" alt="Home" class="icon" id="home" style=></a></li>


			<%
				if (name != null) {
			%>
					<li style="float: right;"><a id="log">Benvenuto <%=name%></a></li>
					<li style="float: right;"><a  id="log" href="logout.jsp?link=<%=url%>">
							Logout </a></li>
					<%
				} else {
			%>
					<li style="float: right;"><a  id="log" href="login.jsp?link=<%=url%>">
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
	<%
	if(ordine!=null){
	
		float prezzo=ordine.getPrezzo();
	 Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA
	
	
	%>

	<h1 align="center">Ordine effettuato con successo</h1>
	<h3 align="right">
		Totale pagato: &euro;<%=formatter.format("%.2f", prezzo) %></h3>
	<% formatter.close();
		session.removeAttribute("ordine");
	%>
	<p>
		<a href="index.jsp">CLICCA QUI</a> per continuare con i tuoi acquisti
	</p>
	<%}
	else{
%>
	<h2>UTENTE DISCONNESSO!</h2>
	<p>
		Torna alla <a href="index.jsp">home</a> per loggarti.
	</p>

	<% 		
	}
	%>
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
		} else if(isUtente == 1) { //Utente connesso.
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

	<p style="color: grey; text-align: center;">Copyright 2020 Il
		Mercante di Libri. All rights reserved.</p>
</body>
</html>