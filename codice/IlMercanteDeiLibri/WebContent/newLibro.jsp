<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="description" content="Il Mercante di Libri">
<meta name=" author" content="Giorgia Abbate">
<meta name=" author" content="Michela Scarpone">
<meta name=" author" content="Tania Stenescu">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="WebContent/javaScript/validaLibro.js"></script>

<title>Aggiungi nuovo Libro</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body style="background-image: url(img/libri.png)">

	<%  
	try {
		String urlRet = request.getRequestURL().toString();
		String username = (String) session.getAttribute("username");
		
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


	<h2 style="text-align: center; color: #ffcc00fa;
    text-shadow: 6px 4px 5px darkRed; font-size:65px" >
     <mark style="background-color: #ffcc0054;border-radius: 20px;color: #ffcc00;">Aggiungi nuovo libro </mark></h2>

	<div class="divContorno">
		<div id="contenitore">
			<form action="./AddLibro" method="post" id="f1">
				<table align="center" style="width: 300px; height: 250px">
					<tr>
						<td colspan=2>ISBN:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text" placeholder="Inserisci ISBN"
							name="isbn" required maxlength="13"
							id="isbn" 
							style="width: 100%; height: 120%;border-radius:20px"><span id="error2"></span></td>
					</tr>
					<tr>
						<td colspan=2>Titolo:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text"
							placeholder="Inserisci Titolo" name="titolo"
							id="titolo"
							 required maxlength="40"
							 style="width: 100%; height: 120%;border-radius:20px"><span id="error1"></span></td>
					</tr>
					<tr>
						<td colspan=2>Prezzo: (eu.cent)</td>
					</tr>
					<tr>
						<td colspan=2><input type="number" step="0.01" min="0.01"
							placeholder="Enter price" name="prezzo" id ="prezzo" required
							style="width: 100%; height: 120%;border-radius:20px"><span id="error3"></span></td>
					</tr>
					<tr>
						<td colspan=2>Autore:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text"
							placeholder="Inserisci Autore " name="autore" maxlength="20"
							id="autore"
							style="width: 100%; height: 120%;border-radius:20px"><span id="error4"></span></td>
					</tr>
					<tr>
						<td colspan=2>Editore:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text"
							placeholder="Inserisci Editore" name="editore" maxlength="20"
							id="editore"
							style="width: 100%; height: 120%;border-radius:20px"><span id="error6"></span></td>
					</tr>
					<tr>
						<td colspan=2>Edizione:</td>
					</tr>
					<tr>
						<td colspan=2><input type="text"
							placeholder="Inserisci Edizione" name="edizione" maxlength="20"
							id="edizione"
							style="width: 100%; height: 120%;border-radius:20px"><span id="error5"></span></td>
					</tr>
					<tr>
						<td class="buttonTd"><input type="submit"
							value="Aggiungi Libro" style="width: 100%; height: 100%; border-radius:20px"></td>
						<td class="buttonTd"><input type="reset"
							style="width: 100%; height: 100%;border-radius:20px"></td>
					</tr>
				</table>
			</form>
			<%
		
	} catch(NullPointerException e) {
	
		e.printStackTrace(); }

%>
		</div>
	</div>

</body>
</html>