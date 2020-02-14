package adminDatabase;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import model.AdmAccountModel;
import model.ClientModel;

import model.OrdineModel;
import model.LibroModel;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   static String db = "Mercante_Libri";
   static String username = "root";
   static String password = "tania";
    
   public DeleteServlet() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String primaryKey = request.getParameter("primaryKey");
		String table = request.getParameter("table");
		
		System.out.println("Pk= " + primaryKey + ",tabella= " + table + ".");
		boolean result = false ;
			
		switch (table) {
		case "Utente": {
			ClientModel model = new ClientModel(db,username,password);
			System.out.println("Tabella " + table);
			
		try {
				result= model.doDeleteString(primaryKey);
			}
		catch (SQLException e) {
				e.printStackTrace();
			}
		
		break;
		}

		case "Libro": {
			LibroModel model = new LibroModel(db,username,password);
			System.out.println("Tabella" + table);
		try {
		result = model.doDeleteString(primaryKey);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
			break;
		}
		default : {
			System.out.println("Tabella sconosciuta. Impossibile eliminare.");
			break;
		}
	}
		System.out.println("Deleted item [PrimaryKey:" + primaryKey +"] from table " + table +": " + result);
		//Trasferisco sulla pagina di inserimento
		RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/DynamicTab?tab=" + table);
		dispositivo.forward(request, response);
		}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}