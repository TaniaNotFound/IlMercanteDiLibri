package list;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LibroModel;


@WebServlet("/AllBooksList") 
public class AllBooksList extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	static String db = "Mercante_Libri";
	static String username = "root";
	static String password = "tania";
	
	LibroModel model = new LibroModel(db, username, password);
	
    
    public AllBooksList() {
        super();
        
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String titolo = request.getParameter("titolo");
		String search = request.getParameter("search");
		
		if(titolo!=null && !titolo.equals("")) { //invia una specifica variabile in modo da gestire l'eventuale ordinamento
		
			request.setAttribute("titolo", titolo);
			
			}
		
		if(search!=null && !search.equals(""))
			request.setAttribute("search", search);
		
			request.removeAttribute("bookList");
		try {
				
				if(titolo!=null) {
					request.setAttribute("bookList", model.doRetrieveBookByName(titolo));}
				
				else if(search!=null) {
					request.setAttribute("bookList", model.doRetrieveBookBySearch(search));
				}
				else
				request.setAttribute("bookList", model.doRetrieveAllBook());
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			System.out.println("[AllBooksList.java - setAttribute bookList] ERROR: " + e);
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/bookList.jsp");

		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}