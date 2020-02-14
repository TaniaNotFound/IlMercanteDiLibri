<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="beans.LibroBean, beans.Acquistabile, java.util.*, beans.*"%>

<!DOCTYPE html>
<html>
<head>

<%
Collection<?> books = (Collection<?>) request.getAttribute("bookList");
String emailUtente = (String) session.getAttribute("usernameCliente");

if(emailUtente == null)
	emailUtente = "0";
%>

<meta charset="UTF-8">
<meta name="descrizione" content="Il Mercante di Libri">
<meta name=" autore" content="Tania Stanescu">
<meta name=" autore" content="Michela Scarpone">
<meta name=" autore" content="Giorgia Abbate">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title>Lista Libri</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body style="background-image: url(img/libri.png)">
	<%
	String url = "http://localhost:8080/IlMercanteDeiLibri/index.jsp"; //la stringa url porterà all'index
	String name = (String) session.getAttribute("name"); //riceve il nome dell'utente dalla sessione
	String admin = (String) session.getAttribute("Username");
	String searchKey = (String) request.getAttribute("search");
	
	int isAdmin = 0; //variabile usata per tener traccia di admin loggato
	int isUtente = 0;
	try {  
		isAdmin = (int) session.getAttribute("adminIn");
		isUtente = (int) session.getAttribute("clientIn"); 
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
							src="img/logo.png" alt="Home" class="icon" id="home"></a></li>
					<!-- CATALOGO -->
					<li class="has_children"><a id="log" href="./AllBooksList"> Catalogo</a></li>
					
			<%
				if (admin != null) {
			%>
					<li style="float: right;"><a id="log"> Benvenuto <%=admin%></a></li>
					<li style="float: right;"><a href="logout.jsp?link=<%=url%>" id="log"> Logout </a></li>
				
				
			<%}
				else if (name != null) {
			%>
					<li style="float: right;"><a href="./vetrina.jsp" id="log">Benvenuto
							<%=name%></a></li>
					<li style="float: right;"><a href="logout.jsp?link=<%=url%>"
						id="log"> Logout </a></li>
					<%
				} else {
			%>
					<li style="float: right;"><a href="login.jsp?link=<%=url%>"
						id="log"> Login </a></li>
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



	<h1 style="text-align: center; color: #ffcc00fa;
    text-shadow: 6px 4px 5px darkRed; font-size:65px" >
     <mark style="background-color: #ffcc0054;border-radius: 20px;color: #ffcc00;">Lista Libri </mark></h1>
	<%
	

	if(searchKey!=null && !searchKey.equals("")) {
%>
	<h4>
		Chiave ricerca:
		<%=searchKey %></h4>
	<%
	}
	String returnCarrello = "";
	String servletToCall = "";
	
		servletToCall = "./AllBooksList";
		returnCarrello = "tutti";
	
	
%>
	<!-- FORM BARRA RICERCA -->
	<form action="<%=servletToCall %>" method="get">
		<input type="hidden" name="id" value="<%=emailUtente%>"> <input
			type="text" name="search" placeholder="Search.." 
			style=" width: 285px;
		    height: 45px;
		    border-radius: 30px;"> 
   	 	
   	 	<input type="submit" 
   	 		style="height: 45px;
		    border-radius: 30px;
		    background-color: lemonchiffon;">
	</form>

	<br />
	<br />
	<div class="divContorno">
		<div id="contenitore">
			<%
		if (books != null && books.size() != 0) {
			Iterator<?> it = books.iterator();
			while (it.hasNext()) {
				Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA
				LibroBean bean = (LibroBean) it.next();
				float prezzo = bean.getPrezzo();
%>
			<table width="100%" id="tabBigPage">
				<tr>
					<td rowspan="5" align="center" width="20%">
						<!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA --> <img
						src="img/<%=bean.getTitolo()%>.jpg" width="120px" height="150px" style="border-radius:20px"
						alt="Foto <%=bean.getTitolo() %>">
					</td>

					<td align="left"><a style="text-decoration: none; color: darkred; font-size: x-large;"
						href="./LibroPage?isbn=<%=bean.getISBN() %>"><%= bean.getTitolo() %></a></td>
					<%  
      if(isUtente!=0) {
%>
					<!-- SEZIONE AGGIUNTA CARRELLO -->
					<td rowspan="5" style="text-align: center; vertical-align: middle;"
						width="20%">
						<p>
							Codice Libro:
							<%=bean.getISBN() %></p> <a
						href="./LibroControl?action=addC&isbn=<%=bean.getISBN()%>&page=cart&usernameCliente=<%=emailUtente%>"><img
							src="img/empty-cart-light.png" alt="Aggiungi al carrello"
							width="50px" height="50px"
							style="border: 3px solid #f49723; border-radius: 30px 30px 30px 30px;"></a>
					</td>
					<%      
      }
%>
				</tr>
				<tr align="left">
					<td><%= bean.getAutore()%></td>
				</tr>
				
				
					
				<tr align="right">
					<td style="color: green;">&euro;<%=formatter.format("%.2f", prezzo)%></td>
				</tr>
				<%

      formatter.close();
%>
			</table>

			<table width="100%" id="tabSmallPage">
				<tr>
					<td align="center" width="20%">
						<!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA --> <img
						src="img/<%=bean.getTitolo()%>.jpg" width="100px" height="100px"  style="border-radius:20px"
						alt="Foto <%=bean.getTitolo()%>">
					</td>
				</tr>
				<tr>
					<td><a style="text-decoration: none; color:darkRed" href="./LibroPage?isbn=<%=bean.getISBN()%>"><%= bean.getTitolo() %></a></td>
				</tr>
				<tr>
					<td><%= bean.getAutore() %></td>
				</tr>
				<tr>
					<%
		Formatter formatter2 = new Formatter();
%>

					<td>&euro;<%=formatter2.format("%.2f", prezzo) %></td>

				</tr>
				<tr>

					<!-- SEZIONE AGGIUNTA CARRELLO -->
					<td style="text-align: center; vertical-align: middle;" width="20%">
						<p>
							Codice Libro:
							<%=bean.getISBN() %></p>
						<div id="imgContainer">
							<a
								href="./LibroControl?action=addC&isbn=<%=bean.getISBN()%>&page=cart&emailUtente=<%=emailUtente%>"><img
								src="img/empty-cart-light.png" alt="Aggiungi al carrello"
								width="50px" height="50px"
								style="border: 3px solid #f49723; border-radius: 30px 30px 30px 30px;"></a>
						</div>
					</td>

				</tr>
			</table>
			<hr />
			<%			
			formatter2.close();
			
			}
		}
		else {
%>
			<table>
				<tr>
					<td>Non ci sono libri da mostrare.</td>
				</tr>
			</table>
			<%
		}
%>
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
		} else if(isUtente == 1) { //cliente connesso
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