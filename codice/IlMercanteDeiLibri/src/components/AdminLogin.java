package components;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import beans.AdminAccountBean;
import model.AdmAccountModel;


@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	static String db = "Mercante_Libri";
	static String username = "root"; 
	static String password = "tania";
	
	static AdmAccountModel model = new AdmAccountModel(db,username,password);
       
  
    public AdminLogin() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Error. This servlet must be called with POST method.");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userForm=request.getParameter("Username");  
        String passForm=request.getParameter("Password");  
		System.out.println("Username: " + userForm + ", Password: " + passForm);
        
		
        AdminAccountBean account = new AdminAccountBean();
        HttpSession session=request.getSession();
        int isAdminIn = 0; //Questa variabile a 0 serve per prevenire l'accesso non autorizzato alla pagina dopo il login
        int isClientIn = 0;
        session.setAttribute("adminIn", isAdminIn); //salvo la variabile nella session per leggerla dalle pagine autorizzate
        session.setAttribute("ClientIn", isClientIn);
        String linkReind = (String) session.getAttribute("link"); //ci riporta alla home
        System.out.println(linkReind);
		try {
			
			request.removeAttribute("accounts");
			account = model.doRetrieveAccountByName(userForm);
			request.setAttribute("accounts", account);
			
		} catch(SQLException e) {
			System.out.println("[AdminLogin.java] Error: " + e);
		}
		
		if(account.getUsername().equals(userForm) && account.getPassword().equals(passForm)) { //username e password corrispondono
			
			 
	        session.setAttribute("Username", userForm); //salvo il nome dell'admin nella sessione
	        isAdminIn = 1; //metto il bit di controllo admin a 1 per l'accesso autorizzato
	        session.setAttribute("adminIn", isAdminIn); //inserisco il bit nella session per leggerlo dalle page autorizzate
			
			
	        response.sendRedirect(linkReind);
		}
		else { //username o psw o entrambi errati
			response.sendRedirect(request.getContextPath() + "/loginFail.jsp"); //vado sulla pagina di errore login
		}
		
	
	}

}
