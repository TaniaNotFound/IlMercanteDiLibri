package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import beans.*;
import components.*;

public class ClientModel{

	private static final String TAB_NAME = "Utente"; //Nome tabella in DB
	public String db;
	public String username;
	public String password;
	
	public ClientModel(String db, String username, String password) {
	
		this.db = db;
		this.username = username;
		this.password = password;
	}
	
	//Genera query INSERT per salvare un nuovo elemento all'interno del DB
	public synchronized int doSave(ClienteBean cliente) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ClienteBean cb = new ClienteBean();
		String selectSQL = "SELECT * FROM Utente WHERE Email = ?";
		
		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, cliente.getUsername());
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) {
				cb.setUsername(rs.getString("Email"));
				System.out.println(rs.getString("Email"));
				
		} }finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		System.out.println(cb.getUsername());
		if(cb.getUsername()=="") {
		Connection connection2 = null;
		PreparedStatement preparedStatement2 = null;

		String insertSQL = "INSERT INTO Utente (Email, Password, Nome, Cognome, Via, Nr_Civico, CAP, Città) VALUES (?, ?, ?, ?,?,?,?,?)";

		try {
			connection2 = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement2 = connection2.prepareStatement(insertSQL);
			preparedStatement2.setString(1, cliente.getUsername());
			preparedStatement2.setString(2, cliente.getPassword());
			preparedStatement2.setString(3, cliente.getNome());
			preparedStatement2.setString(4, cliente.getCognome());
			preparedStatement2.setString(5, cliente.getVia());
			preparedStatement2.setLong(6, cliente.getNr_Civico());
			preparedStatement2.setLong(7, cliente.getCAP());
			preparedStatement2.setString(8, cliente.getCittà());
			
			System.out.println(preparedStatement2.toString());
			
			preparedStatement2.executeUpdate();
			connection2.setAutoCommit(false);	
			connection2.commit();
			return 1;
		} finally {
			try {
				if (preparedStatement2 != null)
					preparedStatement2.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection2);
			}
		}
		}
		else {
			return 0;
		}
	}


	//Genera query DELETE per eliminare la riga identificata da 'code' all'interno del DB
	public synchronized boolean doDeleteString(String code) 
			throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ClientModel.TAB_NAME + " WHERE Email = ?";

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

	//Genera query SELECT per ricevere i dati in base a quella determinata key
	
	public synchronized ClienteBean doRetrieveClientByName(String user) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ClienteBean bean = new ClienteBean();

		String selectSQL = "SELECT * FROM " + ClientModel.TAB_NAME + " WHERE Email = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, user);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setUsername(rs.getString("Email"));
				bean.setNome(rs.getString("Nome"));
				bean.setCognome(rs.getString("Cognome"));
				bean.setPassword(rs.getString("Password"));

				
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

	//genera query SELECT * per prendere tutte le righe dal DB in un certo ordine 

	public synchronized Collection<ClienteBean> doRetrieveAllClient() throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ClienteBean> books = new LinkedList<ClienteBean>();

		String selectSQL = "SELECT * FROM " + ClientModel.TAB_NAME;
		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ClienteBean bean = new ClienteBean();
				bean.setUsername(rs.getString("Email"));
				bean.setNome(rs.getString("Nome"));
				bean.setCognome(rs.getString("Cognome"));
				
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



}
