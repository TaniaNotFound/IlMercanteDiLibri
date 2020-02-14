package components;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LibroModel;


@WebServlet("/LibroPage")
public class LibroPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	static String db = "Mercante_Libri";
	static String username = "root";
	static String password = "tania";
	
	LibroModel model = new LibroModel(db, username, password);
	
   
    public LibroPage() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String isbn = request.getParameter("isbn");
		System.out.println("ISBN: " + isbn);
		
		request.removeAttribute("libroPage");
		
		try {
			request.setAttribute("libroPage", model.doRetrieveBookByKey(isbn));
		} catch (SQLException e) {
			
			e.printStackTrace();
			System.out.println("[LibroPage.java - setAttribute libro] ERROR: " + e.getMessage());
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/LibroPage.jsp");
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}