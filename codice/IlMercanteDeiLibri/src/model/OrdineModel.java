package model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import beans.OrdineBean;
import beans.LibroBean;
import components.Cart;
import components.DriverManagerConnectionPool;

public class OrdineModel {
	private static final String TAB_NAME="Ordine";
	public String db;
	public String username;
	public String password;
	
	
	public OrdineModel(String db, String username, String password) {
		this.db=db;
		this.username=username;
		this.password=password;
	}
	public synchronized int lastCod() throws SQLException {
		Connection connection= null;
		PreparedStatement preparedStatement=null;
		String query= "Select MAX(Codice) as max from Ordine";
		int code = 0;
		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(query);
		ResultSet rs= preparedStatement.executeQuery();
			while(rs.next()) {
				code=rs.getInt("max");
				//System.out.println("Codici fino ad ora: "+array[i]);
				
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		
		return code+1;
	}
	
	//Genera query INSERT per salvare un nuovo elemento all'interno del DB
	public synchronized void doSave(Cart ordine, String Email) throws SQLException{
		if(ordine!=null) {
		Connection connection= null;
		PreparedStatement preparedStatement=null;
		
		float totale =0;
		for(int i=0 ; i<ordine.getBooks().size();i++) {
			totale += ordine.getBooks().get(i).getPrezzo();
			
		}
		
		
		
		String insertSQL="INSERT INTO "+OrdineModel.TAB_NAME+" VALUES (?, ?, ?);";
		int code = lastCod();
		try {
			connection= DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement=connection.prepareStatement(insertSQL);
			preparedStatement.setInt(1, code); 
			preparedStatement.setString(3, Email); 
			preparedStatement.setFloat(2, totale);
			
			preparedStatement.executeUpdate();
			
			connection.setAutoCommit(false);	

			connection.commit();
		}finally { 
			try {
				if(preparedStatement != null)
					preparedStatement.close();
		} finally {
			DriverManagerConnectionPool.releaseConnection(connection);
		}
			
	}
		
		}else {
		}
}
	
/*
	//Genera query DELETE per eliminare la riga identificata da 'code' all'interno del DB
	public synchronized boolean doDeleteInt(int code) 
			throws SQLException {
		
		Connection connection2 = null;
		PreparedStatement preparedStatement2 = null;

		int result = 0;

		String deleteSQL2 = "DELETE FROM Contiene WHERE CodiceOrdine = ?";

		try {
			connection2 = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement2 = connection2.prepareStatement(deleteSQL2);
			preparedStatement2.setInt(1, code);

			result = preparedStatement2.executeUpdate();
			connection2.commit();
		} finally {
			try {
				if (preparedStatement2 != null)
					preparedStatement2.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection2);
			}
		}
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String deleteSQL = "DELETE FROM " +OrdineModel.TAB_NAME + " WHERE codice = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

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
	
	public synchronized int assegnaCodice() throws SQLException {

		Connection connection= null;
		PreparedStatement preparedStatement=null;
		int i=1;
		
		int[] array = new int[100];
		String query="SELECT codice FROM ordine ";
		try {
			connection = DriverManagerConnectionPool.getConnection(db, username, password);
			preparedStatement = connection.prepareStatement(query);
		ResultSet rs= preparedStatement.executeQuery();
			while(rs.next()) {
				array[i]=rs.getInt("codice");
				//System.out.println("Codici fino ad ora: "+array[i]);
				i++;
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}	for(int j=0;j<array.length;j++) {
			//System.out.println(array[j]);
		}
		
		for(int j=1;j<array.length;j++) {
			if(array[j]==0) {
				return j;
			}
		}
		
		return 0;
	}
	*/
}