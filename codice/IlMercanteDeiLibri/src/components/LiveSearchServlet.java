package components;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.StringOrBuilder;


@WebServlet("/LiveSearchServlet")
public class LiveSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    
    public LiveSearchServlet() {
    	super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String s=request.getParameter("val"); //valore inserito nella barra di ricerca

		response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
		
		if(s==null || s.trim().equals("")){
		}
		else {
			String name = s;
			
		out.print("<div id=\"myDropdown\" class=\"dropdown-content\">");
			
			//modificare connection, query, print
			try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/Mercante_Libri";
				String user = "root";
				String psw = "tania";
				Connection con = DriverManager.getConnection(url, user, psw);
				Statement st=con.createStatement();
				String query = "select * from Libro where Titolo LIKE '%" + name + "%'";
			
				ResultSet rs=st.executeQuery(query);
				while(rs.next()){
				
					out.print("<a href='./LibroPage?ISBN=" + rs.getString("ISBN") + "'>" + rs.getString("ISBN")+" - "+rs.getString("Titolo") + "</a>");
				}
				con.close();
				out.print("</div>");
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
