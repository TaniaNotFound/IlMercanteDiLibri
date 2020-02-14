package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;


import beans.LibroBean;
import components.DriverManagerConnectionPool;

public class LibroModel {
	private static final String TAB_NAME = "Libro"; //Nome tabella in DB
	public String db;
	public String username;
	public String password;
	
	public LibroModel(String db, String username, String password) {
		
		this.db = db;
		this.username = username;
		this.password = password;
	}
public LibroModel() {
		this.db="Mercante_Libri";
		this.username = "root";
		this.password = "tania";
	}
	
//Genera query INSERT per salvare un libro appena creato ma non ancora venduto
	public synchronized void doAddLibro(LibroBean libro) throws SQLException {

			Connection connection = null;
			PreparedStatement preparedStatement = null;

			String insertSQL = "INSERT INTO " + LibroModel.TAB_NAME
					+ " VALUES (?, ?, ?, ?, ?,?,?)";

			try {
				connection = DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement = connection.prepareStatement(insertSQL);
				
				preparedStatement.setString(1, libro.getISBN());
				preparedStatement.setString(2, libro.getTitolo());
				preparedStatement.setFloat(3, libro.getPrezzo());
				preparedStatement.setString(4, libro.getAutore());
				preparedStatement.setString(5, libro.getEditore());
				preparedStatement.setString(6, libro.getEdizione());
				preparedStatement.setString(7, libro.getEmail());
				
				System.out.println(preparedStatement.toString());
				
				preparedStatement.executeUpdate();

				//connection.commit();
				connection.setAutoCommit(false);	
				connection.commit();
			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		}
		
//Genera query INSERT per salvare un nuovo elemento all'interno del DB
public synchronized void doSave(LibroBean libro) throws SQLException {

			Connection connection = null;
			PreparedStatement preparedStatement = null;
			
			String insertSQL = "INSERT INTO " + LibroModel.TAB_NAME +
					"(ISBN , Titolo, Prezzo, Autore, Editore, Edizione, Email_Utente)"+ "VALUES (?, ?, ?, ?, ?,?,?)";
			try {
				connection = DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement = connection.prepareStatement(insertSQL);
				
				preparedStatement.setString(1, libro.getISBN());
				preparedStatement.setString(2, libro.getTitolo());
				preparedStatement.setFloat(3,  libro.getPrezzo());
				preparedStatement.setString(4, libro.getAutore());
				preparedStatement.setString(5, libro.getEditore());
				preparedStatement.setString(6, libro.getEdizione());
				preparedStatement.setString(7, libro.getEmail());
				
				System.out.println(preparedStatement.toString());
				
				preparedStatement.executeUpdate();

				connection.commit();
				
			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		}
		
		
//Genera la query per eliminare il libro dalla tabella
public synchronized boolean doDeleteString(String code) 
				throws SQLException {
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			int result = 0;
			String deleteSQL = "DELETE FROM " + LibroModel.TAB_NAME + " WHERE ISBN = ?";

			try {
				connection = DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement = connection.prepareStatement(deleteSQL);
				preparedStatement.setString(1, code);

				result = preparedStatement.executeUpdate();
				connection.commit();
			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
		
			return (result != 0);
			
		}
		
public synchronized List<LibroBean> doRetrieveBookByName(String titolo) throws SQLException {
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			List<LibroBean> collezione= new ArrayList<LibroBean>();
			LibroBean bean = new LibroBean();


			String selectSQL = "SELECT * FROM " + LibroModel.TAB_NAME + " WHERE Titolo = ?";

			try {
				connection = DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement = connection.prepareStatement(selectSQL);
				preparedStatement.setString(1, titolo);

				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {

					bean.setISBN(rs.getString("ISBN"));
					bean.setTitolo(rs.getString("Titolo"));
					bean.setPrezzo(rs.getFloat("Prezzo"));
					bean.setAutore(rs.getString("Autore"));
					bean.setEditore(rs.getString("Editore"));
					bean.setEdizione(rs.getString("Edizione"));
					bean.setEmail(rs.getString("Email_Utente"));
					
					collezione.add(bean);
				
				}

			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			return collezione;
		}
		
public synchronized List<LibroBean> doRetrieveAllBook()throws SQLException {
			
			Connection connection = null;
			PreparedStatement preparedStatement = null;

			List<LibroBean> books = new ArrayList<LibroBean>();

			String selectSQL = "SELECT * FROM " + LibroModel.TAB_NAME;

			try {
				connection = DriverManagerConnectionPool.getConnection(db, username, password);
				preparedStatement = connection.prepareStatement(selectSQL);

				ResultSet rs = preparedStatement.executeQuery();

				while (rs.next()) {
					LibroBean bean = new LibroBean();
					
					bean.setISBN(rs.getString("ISBN"));
					bean.setTitolo(rs.getString("Titolo"));
					bean.setPrezzo(rs.getFloat("Prezzo"));
					bean.setAutore(rs.getString("Autore"));
					bean.setEditore(rs.getString("Editore"));
					bean.setEdizione(rs.getString("Edizione"));
					bean.setEmail(rs.getString("Email_Utente"));
					

					books.add(bean);
				}

			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					DriverManagerConnectionPool.releaseConnection(connection);
				}
			}
			return books;
			
		}


public synchronized Collection<LibroBean> doRetrieveBookByAutore(String autore)throws SQLException {
	
	Connection connection = null;
	PreparedStatement preparedStatement = null;

	Collection<LibroBean> books = new LinkedList<LibroBean>();

	String selectSQL = "SELECT * FROM " + LibroModel.TAB_NAME+ " WHERE Autore= ?";
	try {
		connection = DriverManagerConnectionPool.getConnection(db, username, password);
		preparedStatement = connection.prepareStatement(selectSQL);
		preparedStatement.setString(1, autore);

		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {
			LibroBean bean = new LibroBean();
			bean.setISBN(rs.getString("ISBN"));
			bean.setTitolo(rs.getString("Titolo"));
			bean.setPrezzo(rs.getFloat("Prezzo"));
			bean.setAutore(rs.getString("Autore"));
			bean.setEditore(rs.getString("Editore"));
			bean.setEdizione(rs.getString("Edizione"));
			bean.setEmail(rs.getString("Email_Utente"));
			
			books.add(bean);
		}

	} finally {
		try {
			if (preparedStatement != null)
				preparedStatement.close();
		} finally {
			DriverManagerConnectionPool.releaseConnection(connection);
		}
	}
	return books;
	
}
public synchronized LibroBean doRetrieveBookByKey(String isbn) throws SQLException {
	
	Connection connection = null;
	PreparedStatement preparedStatement = null;

	LibroBean bean= new LibroBean();

	String selectSQL = "SELECT * FROM " + LibroModel.TAB_NAME + " WHERE ISBN = ?";

	try {
		connection = DriverManagerConnectionPool.getConnection(db, username, password);
		preparedStatement = connection.prepareStatement(selectSQL);
		preparedStatement.setString(1, isbn);

		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {
			bean.setISBN(rs.getString("ISBN"));
			bean.setTitolo(rs.getString("Titolo"));
			bean.setPrezzo(rs.getFloat("Prezzo"));
			bean.setAutore(rs.getString("Autore"));
			bean.setEditore(rs.getString("Editore"));
			bean.setEdizione(rs.getString("Edizione"));
			bean.setEmail(rs.getString("Email_Utente"));		
		}

	} finally {
		try {
			if (preparedStatement != null)
				preparedStatement.close();
		} finally {
			DriverManagerConnectionPool.releaseConnection(connection);
		}
	}
	return bean;
}

public synchronized Collection<LibroBean> doRetrieveBookBySearch(String titolo) throws SQLException {
	
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	Collection<LibroBean> collezione= new LinkedList<LibroBean>();
	LibroBean bean = new LibroBean();


	String selectSQL = "SELECT * FROM " + LibroModel.TAB_NAME + " WHERE Titolo LIKE '%"+titolo+"%'";
	try {
		connection = DriverManagerConnectionPool.getConnection(db, username, password);
		preparedStatement = connection.prepareStatement(selectSQL);

		//preparedStatement.setString(1, nome);

		ResultSet rs = preparedStatement.executeQuery();
		while (rs.next()) {
			bean.setISBN(rs.getString("ISBN"));
			bean.setTitolo(rs.getString("Titolo"));
			bean.setPrezzo(rs.getFloat("Prezzo"));
			bean.setAutore(rs.getString("Autore"));
			bean.setEditore(rs.getString("Editore"));
			bean.setEdizione(rs.getString("Edizione"));
			bean.setEmail(rs.getString("Email_Utente"));
			
			
			collezione.add(bean);
			

			bean=new LibroBean();
	
		}

	} finally {
		try {
			if (preparedStatement != null)
				preparedStatement.close();
		} finally {
			DriverManagerConnectionPool.releaseConnection(connection);
		}
	}
	return collezione;
}

public synchronized List<LibroBean> doRetrieveBookByEmail(String email) throws SQLException {
	
	Connection connection = null;
	PreparedStatement preparedStatement = null;
	List<LibroBean> collezione= new ArrayList<LibroBean>();
	


	String selectSQL = "SELECT * FROM " + LibroModel.TAB_NAME + " WHERE Email_Utente = ?";

	try {
		connection = DriverManagerConnectionPool.getConnection(db, username, password);
		preparedStatement = connection.prepareStatement(selectSQL);
		preparedStatement.setString(1, email);

		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {

			LibroBean bean = new LibroBean();
			bean.setISBN(rs.getString("ISBN"));
			bean.setTitolo(rs.getString("Titolo"));
			bean.setPrezzo(rs.getFloat("Prezzo"));
			bean.setAutore(rs.getString("Autore"));
			bean.setEditore(rs.getString("Editore"));
			bean.setEdizione(rs.getString("Edizione"));
			bean.setEmail(rs.getString("Email_Utente"));
			
			collezione.add(bean);
		
		}

	} finally {
		try {
			if (preparedStatement != null)
				preparedStatement.close();
		} finally {
			DriverManagerConnectionPool.releaseConnection(connection);
		}
	}
	
	return collezione;
}

}
