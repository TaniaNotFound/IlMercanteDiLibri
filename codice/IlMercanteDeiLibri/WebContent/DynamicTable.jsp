<%@page import="java.sql.*"%>
<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<%
	/* Attributi della tabella */
  int colNumb = (int) request.getAttribute("colNum");
  ResultSetMetaData metaData = (ResultSetMetaData) request.getAttribute("rsMetaData");
  ResultSet rs = (ResultSet) request.getAttribute("rs");
  String tab = (String) request.getAttribute("tab");
  String usernameC = (String) request.getAttribute("username");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="description" content="Il Mercante di Libri">
<meta name=" author" content="Giorgia Abbate">
<meta name=" author" content="Michela Scarpone">
<meta name=" author" content="Tania Stanescu">


<link rel="stylesheet" type="text/css" href="css/page_style.css">
<link rel="stylesheet" type="text/css" href="css/footer.css">
<link rel="stylesheet" href="css/slides.css" type="text/css">
<link rel="stylesheet" href="css/divStyle.css" type="text/css">
<link rel="stylesheet" href="css/tabControlPanel.css" type="text/css">

<meta name="viewport" content="width-device-width, initial-scale-1.0">


<style>
@media screen and (max-width: 920px) { <%
	if (tab.equals ("Libro ")) { %>
		td: nth-of-type(1):before{ content:"ISBN:";
	}
	td:nth-of-type(2):before {
		content: "Titolo:";
	}
	td:nth-of-type(4):before {
		content: "Prezzo:";
	}
	td:nth-of-type(5):before {
		content: "Autore:";
	}
	td:nth-of-type(3):before {
		content: "Edizione:";
	}
	td:nth-of-type(6):before {
		content: "Editore:";
	}
	<%
}

else if (tab.equals ("AdminAccount ")) { %>
	td: nth-of-type(1):before{ content:"Username:";
}

td:nth-of-type(2):before {
	content: "Password:";
}

<%
}
else if (tab.equals ("Utente ")) { %>
	td: nth-of-type(1):before{ content:"Username:";
}

td:nth-of-type(2):before {
	content: "Nome:";
}

td:nth-of-type(3):before {
	content: "Cognome:";
}

td:nth-of-type(4):before {
	content: "Password:";
}

<%
}
else if (tab.equals ("Ordine ")) { %>
	td: nth-of-type(1):before{ content:"Codice:";
}

td:nth-of-type(2):before {
	content: "Email:";
}

td:nth-of-type(3):before {
	content: "Totale:";
}
<%
}
%>
</style>


<title>Tabella <%=tab %></title>
<link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body>

	<%
  String url = request.getRequestURL().toString();
  String name = (String) session.getAttribute("Username");
  String usernameCliente = (String) session.getAttribute("usernameCliente");
  
  int isAdmin = 0;
  int isCliente = 0;
  if(name!=null) {

  try {
    
    isAdmin = (int) session.getAttribute("adminIn");  
    isCliente = (int) session.getAttribute("clienteIn");
    System.out.println(isAdmin);

  }
  catch(Exception e){
    ;
  }
    
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
  		if(name!=null) {
	%>
					<li style="float: right;"><a  href="./vetrina.jsp" id="log">Benvenuto <%=name%></a></li>
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
%>
	<% if(isAdmin==1){ %>
	<a href="adminPage.jsp">Torna al pannello di controllo
		amministratore.</a>

	<h2 align="center">
		Tabella
		<%= tab%></h2>
	<table align="center" class="tabConPan">

		<% 

	
String primaryKey="";
int numData = 0;
if(tab.equals("Utente")){ %>
		<tr class="tabConPan">
		<tr>
			<th>Username</th>
			<th>Nome</th>
			<th>Cognome</th>
			<th>Password</th>
			<th>Via</th>
			<th>Nr Civico</th>
			<th>CAP</th>
			<th>Città</th>						
			<th>Delete</th>
		</tr>
		<%}  

if(tab.equals("Libro")){ %>
		<tr class="tabConPan">
		<tr>
			<th>ISBN</th>
			<th>Titolo</th>
			<th>Prezzo</th>
			<th>Autore</th>
			<th>Editore</th>
			<th>Edizione</th>
			<th>Email</th>
			<th>Delete</th>

		</tr>
		<%}  
 if(tab.equals("AdminAccount")){ %>
		<tr class="tabConPan">
		<tr>
			<th>Username</th>
			<th>Password</th>
			<th>Delete</th>

		</tr>
		<%}   if(tab.equals("Ordine")){ %>
		<tr class="tabConPan">
		<tr>
			<th>Codice</th>
			<th>Email</th>
			<th>Totale</th>
			<th>libri</th>
			<th>Delete</th>

		</tr>
		<%
}
while(rs.next())
{
 %>
		<tr class="tabConPan">


			<%
	
         for(int i = 1; i<=colNumb;i++) {
          if(i==1) {
            primaryKey=rs.getString(i);
          }
         
          
%>
			<td class="tabConPan"><%=rs.getString(i)%></td>

			<%         	  
          }


          
%>
			<td class="tabConPan"><a
				href="./DeleteServlet?table=<%=tab%>&primaryKey=<%=primaryKey%>">ELIMINA</a></td>
		</tr>
		<% 
    numData++;
%>
		<%
}
%>
	</table>

	<p>
		Occurrency number:
		<%=numData %></p>
	<% } else {%>
	<h2>ADMIN DISCONNESSO!</h2>
	<p>
		Torna alla <a href="index.jsp">home</a> per loggarti.
	</p>
	<%} %>
</body>
</html>