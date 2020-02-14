package test;

import static org.junit.Assert.*;


import java.sql.SQLException;


import org.junit.BeforeClass;
import org.junit.Test;

import beans.AdminAccountBean;
import model.AdmAccountModel;

public class AdmAccountModelTest {
	 private static AdmAccountModel classUnderTest;
	  private static AdminAccountBean bean;
	  
	  @BeforeClass
	  public static void setUpBeforeClass() throws SQLException {
	    try {
	      classUnderTest = new AdmAccountModel("", "", "");
	    } catch(Exception e) {
	      e.printStackTrace();
	    }finally {
	      classUnderTest = new AdmAccountModel("Mercante_Libri","root","root");
	    }
	  }
	@Test
	public synchronized void testDoRetrieveAccountByName() throws SQLException {
		bean = new AdminAccountBean();
	  boolean ok = false;

	  bean.setUsername("Pasqualino");
	  bean.getPassword();
	  bean.toString();
	  try {
	    classUnderTest.doRetrieveAccountByName(bean.getUsername());
	    ok = true;
	  } catch (Exception e) {
		  e.printStackTrace();
	  }

	  assertTrue(ok);
	 
	}

}
