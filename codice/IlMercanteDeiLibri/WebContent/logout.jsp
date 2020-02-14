<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
String url = (String) request.getParameter("link");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta http-equiv="Refresh" content="5;url=index.jsp">

<meta name="descrizione" content="Il Mercante di Libri">
<meta name=" autore" content="Tania Stanescu">
<meta name=" autore" content="Michela Scarpone">
<meta name=" autore" content="Giorgia Abbate">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">


<title>Logout</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">

</head>
<body>
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


	<%
 
	session.invalidate(); //Invalidando la sessione, le altre pagine non vedono l'account collegato.

	%>
	<br />
	<div class="divContorno">
		<div id="contenitore">
			<p>Disconnessione. Verrai reindirizzato alla pagina home in 5
				secondi.</p>
		</div>
	</div>
	<%


%>

</body>
</html>