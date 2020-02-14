
<%@page import="beans.Acquistabile"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="components.Cart, beans.OrdineBean, beans.LibroBean,beans.Acquistabile, java.util.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<%
String nome = (String) session.getAttribute("name"); //prendo nome utente
OrdineBean ordine=(OrdineBean) session.getAttribute("Ordine");
String usernameCliente = (String) session.getAttribute("usernameCliente");
String admin = (String) session.getAttribute("Username");


if(usernameCliente == null) 
	usernameCliente = "amministratore";
String url = "http://localhost:8080/IlMercanteDeiLibri/index.jsp"; //la stringa url porterÃ  all'index
Cart cart = (Cart) session.getAttribute("cart"); //prendo un carrello dalla sessione
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="description" content="Il Mercante di Libri">
<meta name=" author" content="Giorgia Abbate">
<meta name=" author" content="Michela Scarpone">
<meta name=" author" content="Tania Stanescu">


<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title>Carrello</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body style="background-image: url(img/libri.png)">

	<%
	int isAdmin = 0; //variabile usata per tener traccia di admin loggato
	int isUtente = 0; //variabile usata per tener traccia di negozio loggato
	try { //prende una o l'altra variabile (non potranno essere prese entrambe - 1 login)
		isAdmin = (int) session.getAttribute("adminIn");  
		isUtente = (int) session.getAttribute("clienteIn"); 
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

					<!-- CATALOGO -->
					<li class="has_children"><a href="./AllBooksList" id="log" >Catalogo</a>

				<%
				if (admin != null) {
			%>
					<li style="float: right;"><a  id="log"> Benvenuto
							<%=admin%></a></li>
					<li style="float: right;"><a href="logout.jsp?link=<%=url%>" id="log"> Logout </a></li>
				
				
			<% 	}
						else if (usernameCliente != null) {
			%>
					<li style="float: right;"><a href="./vetrina.jsp" id="log">Benvenuto <%=nome%></a></li>
					<li style="float: right;"><a id="log" href="logout.jsp?link=<%=url%>">
							Logout </a></li>
					<%
				} else  {
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

	<h2 align="center" style="text-align: center; color: #ffcc00fa;
    text-shadow: 6px 4px 5px darkRed; font-size:65px"> 
    	<mark style="background-color: #ffcc0054;border-radius: 20px;color: #ffcc00;">Carrello</mark></h2>

	<% 
	float totalPrice = 0; 
	int libro = 0;
	
	if(isUtente == 1) //cliente connesso
	{
 %>
	<p>
		Utente
		<%=nome %>
		connesso.
	</p>
	<!-- QUI VA TUTTO IL CODICE DEL CARRELLO -->
	<div class="divContorno">

		<div id="contenitore">
			<% 	
		if(cart!= null) { //e' presente un carrello nella sessione
			
%>

			<%
		List<Acquistabile> librocart = cart.getBooks(); 	//prendi i libri già  presenti nel carrello
		   for(Acquistabile beancart: librocart) { //per ogni libro ricevuto nel carrello
			   	if(beancart instanceof LibroBean){
			   		System.out.println(beancart.toString());
			   Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA
			   
%>
			<table width="100%" id="tabBigPage">
				<tr>
					<td rowspan="5" align="center" width="20%">
						<!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA --> <img
						src="img/<%= beancart.getTitolo() %>.jpg" width="100px"
						height="100px" alt="Foto">
					</td>
					<td align="left"><%= beancart.getTitolo() %></td>

					<td rowspan="5" align ="left" style="text-align: center; vertical-align: middle;"
						width="20%">
						
							ISBN Libro:<%=beancart.getISBN() %></td>
								<%
							    float prezzo = beancart.getPrezzo();
							    
							%>
	
					<td align="center">&euro;<%=formatter.format("%.2f", prezzo) %></td>
					<td>	<a
						href="./LibroControl?action=deleteC&isbn=<%=beancart.getISBN()%>&page=cart&ordine=<%=ordine%>">
							<img src="img/cestino.png" alt="Rimuovi dal carrello"
							id="cartDel"
							style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;">
					</a>
					</td>
					
					
				</tr>

			
				<%  
    
    formatter.close();
    totalPrice += prezzo;
%>
			</table>



			<table width="100%" id="tabSmallPage">
				<tr>
					<td align="center" width="20%">
						<!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA --> <img
						src="img/<%=beancart.getTitolo()%>.jpg" width="100px"
						height="100px" alt="Foto">
					</td>
				</tr>
				<tr>
					<td><%= beancart.getTitolo() %></td>
					

					<%
    float prezzo2 = beancart.getPrezzo();
    Formatter formatter2 = new Formatter();

%>
					

				</tr> 
				<tr>
					<td>&euro;<%=formatter2.format("%.2f", prezzo2) %></td>
					<td style="text-align: center; vertical-align: middle;" width="20%">
						<p>
							ISBN Libro:
							<%=beancart.getISBN() %></p> <a
						href="./LibroControl?action=deleteC&isbn=<%=beancart.getISBN()%>&page=cart&ordine=<%=ordine%>">
							<img src="img/cestino.png" alt="Rimuovi dal carrello"
							id="cartDel"
							style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;">
					</a>
					</td>
				</tr>
			</table>
			<hr />
			<%
      libro++;
      formatter2.close();
      }
       }
%>

			<%
			if(libro==0) {
%>
			<p>Nessun libro nel carrello.</p>
			<%				
			}
			else { //se e presente almeno un articolo nel carrello
			
%>
			<a href="./LibroControl?action=deleteAll&page=cart&ordine<%=ordine%>"><img
				src="img/cestino.png" alt="Rimuovi tutto" id="cartDelAll"
				style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>
			<a href="./OrdiniControl?action=compra&page=cart&ordine=<%=ordine%>"><img
				src="img/soldi.png" alt="Compra" id="cartDelAll"
				style="heigth: 50px; width: 50px; border: 3px solid #f49723; border-radius: 20px 20px 20px 20px;"></a>

			<%				
			}

		}
		else {
%>
			<p>Nessun libro nel carrello.</p>
			<% 
		}
%>
		</div>
	</div>
	<%
	if(libro>0) {
	Formatter formatter = new Formatter();
%>
	<div align="left">
		<h3>
			Totale:
			<%=formatter.format("%.2f", totalPrice) %>&euro;
		</h3>
	</div>
	<%
		formatter.close();
		}
	}
	
	else {
%>
	<p>Per accedere al carrello devi essere connesso con un account
		Cliente.</p>
	<p>
		<a href="login.jsp?link=<%=url %>">Clicca qui</a> per loggarti.
	</p>
	<%
	}
%>
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

	<p style="color: grey; text-align: center;">Copyright 2020 Il
		Mercante di Libri. All rights reserved.</p>
</body>
</html>