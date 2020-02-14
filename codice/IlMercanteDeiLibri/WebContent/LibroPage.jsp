<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="beans.LibroBean, beans.OrdineBean, beans.Acquistabile, java.util.*, beans.*"%>
<!DOCTYPE html>
<html>
<%
	OrdineBean ordine=(OrdineBean)request.getAttribute("ordine");
	LibroBean bean = (LibroBean) request.getAttribute("libroPage");
	int isAdmin = 0; //variabile usata per tener traccia di admin loggato
	int isCliente = 0;
	try {
		isAdmin = (int) session.getAttribute("adminIn");
		isCliente = (int) session.getAttribute("clienteIn"); 
	}
	catch(Exception e){
		;
	}
	
	String usernameCliente = (String) session.getAttribute("usernameCliente");
	if(usernameCliente == null)
		usernameCliente = "0";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="description" content="Il Mercante di Libri">
<meta name=" author" content="Michela Scarpone">
<meta name=" author" content="Tania Stanescu">
<meta name=" author" content="Abbate Giorgia">


<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title><%=bean.getTitolo()%></title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body style="background-image: url(img/libri.png)">

	<%
	String url = "http://localhost:8080/MercanteDiLibri/index.jsp"; //la stringa url porterà all'index
	String name = (String) session.getAttribute("name"); //riceve il nome dell'utente dalla sessione
	String admin = (String) session.getAttribute("Username");// admin
	String searchKey = (String) request.getAttribute("search");
	
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
							src="img/logo.png" alt="Home" class="icon" id="home" style="border-radius:20px"></a></li>


					<%
				if (name != null) {
			%>
					<li style="float: right;"><a href="./vetrina.jsp" id="log">Benvenuto <%=name%></a></li>
					<li style="float: right;"><a id="log" href="logout.jsp?link=<%=url%>">
							Logout </a></li>
							
				
					<%}
					else if (admin != null) {
			%>
					<li style="float: right;"><a href="./vetrina.jsp" id="log">Benvenuto <%=admin%></a></li>
					<li style="float: right;"><a id="log" href="logout.jsp?link=<%=url%>">
							Logout </a></li>
					<%
					
				} else {
			%>
					<li style="float: right;"><a id="log"  href="login.jsp?link=<%=url%>">
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
	<div class="divContorno">
		<div id="contenitore">
			<%		
		Formatter formatter = new Formatter();
		float prezzo = bean.getPrezzo();
		System.out.println(prezzo);
%>

			<!-- TABELLA MOSTRATA SU SCHERMI GRANDI -->
			<table width="100%" id="tabBigPage">
				<tr>
					<td rowspan="4" align="center" width="50%"><img style=" border-radius: 15px;;"
					
						src="img/<%=bean.getTitolo()%>.jpg" width="200px" height="250px"
						alt="Foto libro"></td>
					<td align="center" style="color:darkRed"><h1><%=bean.getTitolo() %></h1>
						<hr /></td>
				</tr>

				<tr align="left">
					<td><h3>
							<%= bean.getAutore() %></h3>
						<hr /></td>
				</tr>
					<tr align="left">
					<td><h4>
							 ISBN:
							<%= bean.getISBN() %></h4>
						<hr /></td>
						
				</tr>

				<tr align="right">
					<td><h3 style="color:green">
							&euro;
							<%=formatter.format("%.2f", prezzo) %></h3>
						<hr /></td>
				</tr>
			
				<%
      if(isCliente!=0) { //loggato con cliente, mostra il tasto Add to Cart
%>
				<!-- SEZIONE AGGIUNTA CARRELLO -->
				<tr>
					<td></td>
					<td colspan="2" align="center"><a
						href="./LibroControl?action=addC&isbn=<%=bean.getISBN()%>&page=cart&usernameCliente=<%=usernameCliente%>&ordine=<%=ordine%>"><img
							src="img/empty-cart-light.png" width="110px" height="100px"
							alt="Aggiungi al carrello" id="cart"
							style="border: 3px solid #449e4f; border-radius: 30px 30px 30px 30px;"></a>


					</td>
				</tr>
				<%      
        }
      
      formatter.close();
%>
			</table>


			<!-- TABELLA MOSTRATA NELLA PAGINA PICCOLA -->
			<table width="100%" id="tabSmallPage">
				<tr>
					<td width="50%"><img src="img/<%=bean.getTitolo()   %>.jpg"
						alt="Foto prodotto" width="150px" height="180px"></td>
				</tr>
				<tr>
					<td>
						<h1 style="color:darkRed"><%=bean.getTitolo() %></h1>
						<hr />
					</td>
				</tr>
				<tr>
					<td>
						<h3><%=bean.getAutore() %></h3>
						<hr />
					</td>
				</tr>

				<%
		Formatter formatter2 = new Formatter();
		
%>

				<tr>
					<td><h3 style="color:green">
							&euro;<%=formatter2.format("%.2f", prezzo) %></h3>
						<hr /></td>
				</tr>
				<tr>
					<td>
						<h4>
							Codice Libro:
							<%= bean.getISBN() %></h4>
						<hr />
					</td>
				</tr>
				<%
	if(isCliente!=0) { //loggato con cliente, mostra il tasto Add to Cart
%>
				<!-- SEZIONE AGGIUNTA CARRELLO -->
				<tr>
					<td colspan="2" align="center"><a
						href="./LibroControl?action=addC&id=<%=bean.getISBN()%>&page=cart&usernameCliente=<%=usernameCliente%>&ordine=<%=ordine%>"><img
							src="img/empty-cart-light.png" alt="Aggiungi al carrello"
							width="50px" height="50px"
							style="border: 3px solid #f49723; border-radius: 30px 30px 30px 30px;"></a>
					</td>
				</tr>
				<%			
				}
			formatter2.close();
%>

			</table>

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
		} else if(isCliente == 1) { //negozio connesso. Passa a pannello controllo negozio
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