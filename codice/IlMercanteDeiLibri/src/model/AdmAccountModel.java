package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

//import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.StringOrBuilder;

import beans.AdminAccountBean;
import components.DriverManagerConnectionPool;



public class AdmAccountModel {
	
	private static final String TAB_NAME="AdminAccount"; 
	public String db;
	public String username;
	public String password;


	public AdmAccountModel(String db, String username, String password) {
		this.db = db;
		this.username = username;
		this.password = password;
	}

	
	//Genera query SELECT per ricevere i dati in base a quella determinata key
	
	public synchronized AdminAccountBean doRetrieveAccountByName(String userIn) throws SQLException {
		Connection con= null;
		PreparedStatement preparedStatement = null;

		AdminAccountBean bean = new AdminAccountBean();
		System.out.println(userIn);

		String selectSQL = "SELECT * FROM " + AdmAccountModel.TAB_NAME +" WHERE Username = ?";
		System.out.println(selectSQL);
		try {
			
			con=DriverManagerConnectionPool.getConnection("jdbc:mysql://localhost:3306/Mercante_Libri", "root", "tania");
			

			preparedStatement = con.prepareStatement(selectSQL);
			preparedStatement.setString(1, userIn);

			ResultSet rs = preparedStatement.executeQuery();
			

			while (rs.next()) {
				bean.setUsername(rs.getString("Username"));
				bean.setPassword(rs.getString("Password")); 
				
			}

		} 
		finally {
			try {
			if(preparedStatement != null)
			preparedStatement.close();
		}
			finally {
				DriverManagerConnectionPool.releaseConnection(con);
			}
		}
		return bean;
	}
	

	
	
	
	
}