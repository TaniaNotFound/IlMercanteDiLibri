<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="beans.LibroBean, beans.Acquistabile, java.util.*, beans.*,
     model.LibroModel"%>
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

<meta name="viewport" content="width-device-width, initial-scale-1.0">

<title>Vetrina</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<%


String emailUtente = (String) session.getAttribute("usernameCliente");
LibroModel libri= new LibroModel();
Collection<?> books = (Collection<?>) libri.doRetrieveBookByEmail(emailUtente);
if(emailUtente == null)
	emailUtente = "0";
%>

<body style="background-image: url(img/libri.png)">

	<%	String url = "http://localhost:8080/IlMercanteDeiLibri/index.jsp"; //la stringa url porterà all'index
	String name = (String) session.getAttribute("name"); //riceve il nome dell'utente dalla sessione
	
	int isAdmin = 0; //variabile usata per tener traccia di admin loggato
	int isUtente = 0;

	try {
		isAdmin = (int) session.getAttribute("adminIn");  
		isUtente = (int) session.getAttribute("clienteIn"); 
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
			try {
				System.out.println(isUtente);
				if(isUtente == 1) { //accesso alla pagina con account utente
					System.out.println(90);
			%>
	<h2 align="center" style="text-align: center; color: #ffcc00fa;
    text-shadow: 6px 4px 5px darkRed; font-size:65px" >
     <mark style="background-color: #ffcc0054;border-radius: 20px;color: #ffcc00;">
		Vetrina di <%=name %> </mark>	</h2>


			<div class="divContorno">
				<div id="contenitore">
					<%
		if (books != null && books.size()!=0) {
			Iterator<?> it = books.iterator();
			while (it.hasNext()) {
				Formatter formatter = new Formatter(); //UTILIZZATO PER POTER STAMPARE SEMPRE 2 DECIMALI DOPO LA VIRGOLA
				LibroBean bean = (LibroBean) it.next();
				float prezzo = bean.getPrezzo();
					
				System.out.println(bean.getTitolo());
				
				
%>
					<table width="100%" id="tabBigPage">
						<tr>
							<td rowspan="5" align="center" width="20%" >
								<!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA --> <img
								src="img/<%=bean.getTitolo()%>.jpg" width="120px" height="150px"
								style="border-radius: 20px"
								alt="Foto <%=bean.getTitolo() %>">
							</td>

							<td align="right"><a style="color: darkRed;text-decoration: none"
								href="./LibroPage?isbn=<%=bean.getISBN() %>"><%=bean.getTitolo() %></a></td>
					</table>

					<table width="100%" id="tabSmallPage">
						<tr>
							<td align="center" width="20%">
								<!-- SEZIONE SELEZIONE IMMAGINE DI ANTEPRIMA --> <img
								src="img/<%=bean.getTitolo()%>.jpg" width="100px" height="100px"
								
								alt="Foto <%=bean.getTitolo()%>">
							</td>
						</tr>
						<tr>
							<td><a style="text-decoration: none" href="./LibroPage?isbn=<%=bean.getISBN()%>"><%= bean.getTitolo() %></a></td>
						</tr>
						<tr>
							<td><%=bean.getAutore() %></td>
						</tr>

					</table>
					<% } %>
					
				</div>
				
				<%
			
			}
			%>
			<input type="button" value="Aggiungi Libro"
						onclick="top.location.href = 'newLibro.jsp'"
						style="width: 20%; height: 100%; border-radius: 20px;background-color: #ffcc0040;
						" >
					<% 
				}	else if(isUtente==0){
				%>
				<h2>ACCESSO NON AUTORIZZATO!</h2>
				<p>
					Non sei autorizzato ad entrare in questa pagina. Torna alla <a
						href="index.jsp">home</a> per loggarti.
				</p>
				<% 
				}
				
			}	 catch(NullPointerException e) {
%>
				
				<p>.</p>
				<h2>ACCESSO NON AUTORIZZATO!</h2>
				<p>
					Non sei autorizzato ad entrare in questa pagina. Torna alla <a
						href="index.jsp">home</a> per loggarti.
				</p>
				<%
	}
			
%>
			
</body>
</html>