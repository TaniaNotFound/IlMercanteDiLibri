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

import beans.LibroBean;
import model.LibroModel;

@WebServlet("/AddLibro")

public class AddLibro extends HttpServlet {
private static final long serialVersionUID = 1L;


static String db = "Mercante_Libri";
static String username = "root";
static String password = "tania";


LibroModel model = new LibroModel(db,username,password);


public AddLibro() {
	super();
}

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

	while(data.hasMoreElements() && correct == true)
	{
	String param = data.nextElement();

	if(param.equals("titolo") || param.equals("autore") || param.equals("editore") || param.equals("edizione"))
	{
	 String value=request.getParameter(param);
	 String alphabeticPattern = "[A-Za-z\\s]+";
	 
	 correct =validateField(value, alphabeticPattern );
	 
	}

	if(param.equals("isbn"))
	{
	 String value=request.getParameter(param);
	 String isbnPattern = "([0-9]){1,13}";
	 
	 correct =validateField(value, isbnPattern );
	 
	}
	if(param.equals("prezzo"))
	{
	 String value=request.getParameter(param);
	 String pricePattern = "[0-9]+[\\.,]{1}[0-9]{2}";
	 
	 correct =validateField(value, pricePattern );
	 
	}

	  }
	
	return correct;
	}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	System.out.println("Errore. This Servlet must be called with POST method.");
	}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	Enumeration<String> data = request.getParameterNames();

	 if(validateData(data, request)) {


	 LibroBean bean = new LibroBean();
	 bean.setISBN(request.getParameter("isbn"));
	 bean.setTitolo(request.getParameter("titolo"));
	 bean.setPrezzo(Float.parseFloat(request.getParameter("prezzo")));
	 bean.setAutore(request.getParameter("autore"));
	 bean.setEditore(request.getParameter("editore"));
	 bean.setEdizione(request.getParameter("edizione"));
	 bean.setEmail((String) request.getSession().getAttribute("usernameCliente"));
try {
	model.doAddLibro(bean);
}
catch (SQLException e) {
	e.printStackTrace();
	System.out.println("[AddLibro.java] Errore: " +e);
	}
RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/index.jsp");
dispositivo.forward(request, response);
 }else {
RequestDispatcher dispositivo = getServletContext().getRequestDispatcher("/LibroError.jsp");
dispositivo.forward(request, response);
}}

}

