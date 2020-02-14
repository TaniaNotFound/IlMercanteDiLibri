package clientDatabase;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



//import adminDatabase.RequestDispatcher;
import beans.ClienteBean;
import model.ClientModel;

@WebServlet("/AddCliente")
public class AddCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static String db ="Mercante_Libri";
	static String username= "root";
	static String password = "tania";
	int verifica;
    
	ClientModel model = new ClientModel(db, username, password);
    public AddCliente() {
    	super();
    }
    
    //Validazione lato server
    private boolean MissingData(String x)
    {
     if (x == null || x.equals("")) 
      return false;
     else
      return true;
    }
    
    private boolean validateField(String x, String pattern)
    {
     if (Pattern.matches(pattern, x) && MissingData(x))
         return true;
       else
         return false;
    }
    
    private boolean validateData(Enumeration<String> data, HttpServletRequest request)
    {
    	Boolean correct = true;
   
    	while(data.hasMoreElements() && correct == true){
    		String param = data.nextElement();
  
    		if(param.equals("nome") || param.equals("cognome") || param.equals("via") || param.equals("città"))
    		{
    			/*aggiungere lunghezze???*/
    			String value=request.getParameter(param);
    			String alphabeticPattern = "[A-Za-z\\s]+";
     
    			correct =validateField(value, alphabeticPattern );
    			
    		}
    		if(param.equals("password"))
    		{
		     String value=request.getParameter(param);
		     String passwordPattern = "([A-Za-z0-9]){8,16}";
		     
		     correct =validateField(value, passwordPattern );
		    
		    }
    		if(param.equals("email"))
		    {
		     String value=request.getParameter(param);
		     String emailPattern = "\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+";
		     
		     correct =validateField(value, emailPattern );
		  

		    }
    
		    if(param.equals("nrCivico"))
		    {
		     String value=request.getParameter(param);
		     String civicoPattern = "([0-9]){1,3}";
		     
		     correct =validateField(value, civicoPattern );
		   

		    }
		    if(param.equals("cap"))
		    {
		     String value=request.getParameter(param);
		     String zipPattern = "([0-9]){5}";
		     
		     correct =validateField(value, zipPattern );
		    

		    }
		   }
    	
  return correct;
  
    }
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(("[AddCliente.java] Error. This Servlet must be called with POST method."));;
	}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Enumeration<String> data = request.getParameterNames();
	    System.out.println(java.util.Arrays.asList(data));
		  
		  if(validateData(data, request)) {

		
		  ClienteBean bean = new ClienteBean();

		  bean.setUsername(request.getParameter("email"));
		  bean.setNome(request.getParameter("nome"));
		  bean.setCognome(request.getParameter("cognome"));
		  bean.setPassword(request.getParameter("password"));
		  bean.setCAP(Integer.parseInt(request.getParameter("cap")));
		  bean.setCittà(request.getParameter("citta"));
		  bean.setNr_Civico(Integer.parseInt(request.getParameter("nrCivico")));
		  bean.setVia(request.getParameter("via"));
		  
		 
		
		
	try {
		verifica=model.doSave(bean);
		System.out.println("verifica"+verifica);
		}
	catch (SQLException e) {
		e.printStackTrace();
		System.out.println("[AddCliente.java] Errore: " + e );

		}
	
	if(verifica==1) {
	RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/newCliente.jsp");
	dispositivo.forward(request, response);
	}
 }else{
		response.sendRedirect(request.getContextPath() + "/loginFail.jsp");
	}
	
	}

}
