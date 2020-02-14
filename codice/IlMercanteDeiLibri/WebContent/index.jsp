
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="beans.LibroBean, beans.Acquistabile, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<meta name="description" content="Il Mercante di Libri">
<meta name="author" content="Michela Giovanna Scarpone">
<meta name="author" content="Tania Stanescu">
<meta name="author" content="Giorgia Abbate">

<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<link rel="stylesheet" type="text/css" href="css/dropdownSearch.css">

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">

<script>
	//Ricerca Live homepage
	var request = new XMLHttpRequest(); //crea una XMLRequest
	function sendInfo() {
		var v = document.vinform.search.value; //legge il valore del textbox 'search' nel form 'vinform' 
		var url = "./LiveSearchServlet?val=" + v; //crea un url da inviare alla pagina contenente il valore letto dal form

		try {
			request.onreadystatechange = getInfo; 
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}

	function getInfo() {
		if (request.readyState == 4) { //se la richiesta è conclusa
			var val = request.responseText;
			document.getElementById('amit').innerHTML = val;
		}
	}
</script>


<title>Il Mercante di Libri</title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>

<body >
	<%
		String url = request.getRequestURL().toString();
		String name = (String) session.getAttribute("Username");
		String usernameCliente = (String) session.getAttribute("usernameCliente");
		String nome= (String) session.getAttribute("name");



		int isAdmin = 0;
		int isCliente = 0;
		if (name != null) {
	
		try {
				isAdmin = (int) session.getAttribute("adminIn");
				isCliente = (int) session.getAttribute("ClienteIn");
			} catch (Exception e) {
				;
			}
		}
	%>


	

	<div id="header" align="center">
		<img src="img/titolo.png" alt="Titolo" width="11%" height="7%" padding="5px">
	</div>

	<!-- Navbar -->
	<div class="navbar">
		<div id="main_menu">
			<nav>
				<ul id="menu">
					<!-- HOME -->
					<li class="current"><a href="index.jsp"> <img alt="Home"
							src="img/homeicona.png" width="70px" height="70px">
					</a>
					<!-- CATALOGO -->
					<li class="catalogo">
						<a href="./AllBooksList?"
							class="icon" id="log" style="float:left;">Catalogo</a> 
						
					</li>

					<%
				if (name != null) {
			%>
					<li style="float: right;"><a id="log"> Benvenuto
							<%=name%></a></li>
					<li style="float: right;"><a href="logout.jsp?link=<%=url%>" id="log"> Logout </a></li>

					<% } else if(usernameCliente!=null){ %>
					<li style="float: right;"><a
						href="./vetrina.jsp" id="log"> Benvenuto <%=nome%></a></li>
					<li style="float: right;"><a href="logout.jsp?link=<%=url%>"id="log"> Logout </a></li>

					<%
				} else {
			%>
					<li style="float: right;"><a href="login.jsp?link=<%=url%>"id="log"> Login </a></li>
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
	<!-- end navbar  -->


	<div class="dropdown-padre">
		<div class="dropdown" style="background-image:url(img/libri.png)">
			<form name="vinform" action="AllBooksList" method="get">
				<label>Cerca il tuo libro</label><br>
				<div class="container h-100">
					<div class="d-flex justify-content-center h-100">
						<div class="searchbar">
							<input class="search_input" type="text" name="search"
								onkeyup="sendInfo()"  placeholder="Titolo..."> <button type="submit"
								class="search_icon"><i class="fas fa-search"></i></button>
								
						</div>
						
					</div>
					
				</div>
			
			</form>	
					<span id="amit"	style="position: relative;  left: 40%;"> </span>
		</div>
	</div>


	

	<!-- Footer -->

	<footer id="footer" style="font-family: times new roman;">
		<hr>

		<div id="info_menu">
			<p>
				<a href="perConoscerci.jsp">Per conoscerci</a>
			</p>
			<p>
				<a href="contatti.jsp">Contatti</a>
			</p>
			<%
			if (isAdmin == 1) { //Admin connesso. Passa a pannello controllo admin
		%>
			<p id="right_side" align="right">
				<a href="adminPage.jsp">Zona Riservata</a>
			</p>
			<%
			} else if (isCliente == 1) { 
		%>
			<p id="right_side" align="right">
				<a href="adminPage.jsp?link=<%=url%>">Zona Riservata</a>
			</p>
			<%
			} else { //nessuno connesso. Porta alla pagina di login
		%>
			<p id="right_side" align="right">
				<a href="adminPage.jsp?link=<%=url%>">Zona Riservata</a>
			</p>
			<%
			}
		%>
		</div>

	</footer>

	<hr>

	<p style="color: grey; text-align: center; font-family: new Times roman">Copyright © 2020 Il
		Mercante di Libri. All rights reserved.</p>


</body>
</html>