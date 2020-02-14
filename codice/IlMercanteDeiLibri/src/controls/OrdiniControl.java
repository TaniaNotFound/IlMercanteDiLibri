package controls;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.OrdineBean;
import components.Cart;
import model.OrdineModel;


@WebServlet("/OrdiniControl")
public class OrdiniControl extends HttpServlet {
	private static final long serialVersionUID = 1L;


	static boolean isDataSource = true;
	int i=0;
	
	static String db = "Mercante_Libri";
	static String username = "root";
	static String password = "tania";

	static OrdineModel model= new OrdineModel(db, username, password);


    public OrdiniControl() {
    	 super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cart cart=(Cart)request.getSession().getAttribute("cart");
		String email= (String) request.getSession().getAttribute("usernameCliente");
		
		
		if(cart==null) {
			cart=new Cart();
			request.getSession().setAttribute("cart", cart);

		}
		
		String action=request.getParameter("action");
		String page = request.getParameter("page");
		
		try {
			if(action!=null) {
				if(action.equalsIgnoreCase("compra")) {
					if(cart!=null) {
					model.doSave(cart,email); //SALVA L'ORDINE NEL DB
					
					}
					request.removeAttribute("Ordine");
					cart.deleteAll();
					
					response.sendRedirect("./acquisto.jsp?ordine="+cart);
					
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}		
		
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
