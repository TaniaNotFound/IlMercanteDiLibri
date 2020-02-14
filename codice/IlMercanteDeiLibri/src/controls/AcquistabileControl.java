package controls;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Acquistabile;


import beans.OrdineBean;
import beans.LibroBean;
import components.Cart;

import model.LibroModel;


@WebServlet("/AcquistabileControl")
public class AcquistabileControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public int i=0;
       
	static boolean isDataSource = true;
	static String db = "Mercante_Libri";
	static String username = "root";
	static String password = "tania";
	
	static LibroModel model = new LibroModel(db, username, password);
   
	
    public AcquistabileControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usernameCliente=(String) request.getSession().getAttribute("usernameCliente");
		//OrdineBean ordine= (OrdineBean) request.getSession().getAttribute("ordine");
		i++;
		
		//Prende un oggetto di tipo carrello dalla sessione. Se non è presente, lo crea e lo aggiunge alla sessione
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		/*
		if(ordine==null) {
			ordine= new OrdineBean();
			request.getSession().setAttribute("ordine", ordine);
		}
		*/
		//Riceve il parametro per capire quale azione effettuare
		String action = request.getParameter("action");
		//Riceve la pagina che ha aggiunto l'articolo al carrello per poterci tornare
		String page = request.getParameter("page");
		
		System.out.println("Aggiunto in pagina: " + page);
		//ordine.setCodice(i);
		
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("addC")) {
					String codice = request.getParameter("codice");
					System.out.println("Provo ad aggiungere il prodotto Codice: " + codice);
					int justAdded=0;
					List<Acquistabile> inCart = cart.getBooks();
					
					if(inCart.size()>0) {
						System.out.println("Sono presenti " + inCart.size() + " elementi nel carrello.");
						for(int i=0; i<inCart.size(); i++){
							if(codice==inCart.get(i).getISBN()) {
								justAdded = 1;
							}
						}
					}
					if(justAdded == 0) {
	
						Acquistabile libro = null;
							if(libro instanceof LibroBean) 
								model.doRetrieveBookByKey(codice);
							
							
						libro.toString();
						cart.addBook(libro);
						//ordine.addLibro(libro);
						//ordine.setEmailUtente(usernameCliente);
						System.out.println("Aggiunto al carrello oggetto " + codice + ".");
					}
					else
						System.out.println("Elemento gia nel carrello.");
					
				} else if (action.equalsIgnoreCase("deleteC")) {
					String cod = request.getParameter("codice");
					cart.deleteBook(model.doRetrieveBookByKey(cod));
					//ordine.deleteBook(model.doRetrieveBookByKey(cod));
				}
				else if (action.equalsIgnoreCase("deleteAll")) {
					cart.deleteAll();
					//ordine.setArray(null);
				}
			}	
		
		} catch (SQLException e) {
			System.out.println("[AcquistabileControl - action] Error:" + e.getMessage());
		}

		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);
		//request.setAttribute("ordine", ordine);
		//request.getSession().setAttribute("ordine", ordine);
		
/*
		if(page.equals("cart")) {
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CartPage.jsp");
		dispatcher.forward(request, response);
		}
		else if(page.equals("tutti")) {
			
			
			response.sendRedirect("./AllBooksList?");
		}*/
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
