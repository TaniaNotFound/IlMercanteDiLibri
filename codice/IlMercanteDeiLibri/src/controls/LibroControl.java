package controls;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;
import beans.*;
import components.Cart;

@WebServlet("/LibroControl")
public class LibroControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static boolean isDataSource = true;
	static String db = "Mercante_Libri";
	static String username = "root"; 
	static String password = "tania"; 
	
	static LibroModel model = new LibroModel(db, username, password);
	
	//SI OCCUPA DELL'AGGIUNTA, ELIMINAZIONE E ELIMINAZIONE TOTALE DAL CARRELLO
    public LibroControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String usernameCliente=(String) request.getSession().getAttribute("usernameCliente");
		OrdineBean ordine= (OrdineBean) request.getSession().getAttribute("ordine");
	
		
		//Prende un oggetto di tipo carrello dalla sessione. Se non e presente, lo crea e lo aggiunge alla sessione
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		if(ordine==null) {
			ordine= new OrdineBean();
			request.getSession().setAttribute("ordine", ordine);
		}
		
		//Riceve il parametro per capire quale azione effettuare
		String action = request.getParameter("action");
		//Riceve la pagina che ha aggiunto l'articolo al carrello per poterci tornare
		String page = request.getParameter("page");
		
		System.out.println("Aggiunto in pagina: " + page);
	
		
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("addC")) {
					String codice =request.getParameter("isbn");
					System.out.println("Provo ad aggiungere il prodotto Isbn: " + codice);
					LibroBean lib = model.doRetrieveBookByKey(codice);
					lib.toString();
					cart.addBook(lib);
					ordine.addLibro(lib);
					System.out.println(lib.toString());
					ordine.setEmailUtente(usernameCliente); //SI PRENDE L'USERNAME DALLA SESSIONE PER CONTINUARE L'ACQUISTO
					System.out.println("Aggiunto al carrello oggetto " + codice + ".");
					
				} else if (action.equalsIgnoreCase("deleteC")) {
				
					String cod = request.getParameter("isbn");
					System.out.println("il codice del prodotto da el e: " + cod);
					cart.deleteBook(model.doRetrieveBookByKey(cod));
					ordine.deleteBook(model.doRetrieveBookByKey(cod));
				}
				else if (action.equalsIgnoreCase("deleteAll")) {
					cart.deleteAll();
					System.out.println("Eliminato tutto dal carrello");
					ordine.removeAll();
					
				}
			}			
		} catch (SQLException e) {
			System.out.println("[LibroControl - action] Error:" + e.getMessage());
		}

		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);
		request.removeAttribute("ordine");
		request.setAttribute("ordine", ordine);
		request.getSession().setAttribute("ordine", ordine);
		
		if(page.equals("cart")) {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CartPage.jsp");
			dispatcher.forward(request, response);
			}
			else if(page.equals("tutti")) {
				response.sendRedirect("./AllBooksList");
			}
			
		}
					
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
