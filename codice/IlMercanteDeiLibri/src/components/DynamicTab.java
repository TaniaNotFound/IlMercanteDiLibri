package components;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DynamicTab")
public class DynamicTab extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static String url = "jdbc:mysql://localhost:3306/Mercante_Libri";
	static String user = "root"; //DA CAMBIARE
	static String psw = "tania";//DA CAMBIARE
	
    public DynamicTab() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection con;
		Statement st;

		int columnCount = 0;
		ResultSetMetaData metaData = null;
		ResultSet rs = null;
		
		String tab = request.getParameter("tab");
		
		try {
			//SELEZIONO IL DRIVER DI COMUNICAZIONE
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			//Istanzio una connessione col DB con le credenziali
			con = DriverManager.getConnection(url, user, psw);
			System.out.println("Connessione eseguita.");
			
			//preparo l'oggetto per l'istruzione SQL
			st = con.createStatement();
				String query = null;
				
				if(tab.equals("Libro")==true || tab.equals("Utente")==true)
					query="SELECT * FROM "+ tab;
			
				rs = st.executeQuery(query);	
			
			metaData = rs.getMetaData();
			columnCount = metaData.getColumnCount();
			System.out.println("Numero colonne: " + columnCount);

		}
		catch(Exception e)
		{
			System.out.println("[DynamicTab.java - lettura tabella] ERROR: " + e);
		}
		
		try {
			request.removeAttribute("colNum");
			request.setAttribute("colNum", columnCount);
			request.removeAttribute("rsMetaData");
			request.setAttribute("rsMetaData", metaData);
			request.removeAttribute("rs");
			request.setAttribute("rs", rs);
			request.removeAttribute("tab");
			request.setAttribute("tab", tab);

		}
		catch(Exception e) {
			System.out.println("[DynamicTab.java - aggiunta in request] ERROR: " + e);
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/DynamicTable.jsp");
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
