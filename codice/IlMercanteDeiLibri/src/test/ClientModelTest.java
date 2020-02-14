package test;

import static org.junit.Assert.*;
import java.sql.SQLException;
import org.junit.BeforeClass;
import org.junit.Test;

import beans.ClienteBean;
import model.ClientModel;

public class ClientModelTest {
	private static ClientModel classUnderTest;
	  private static ClienteBean bean;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		try {
		      classUnderTest = new ClientModel("", "", "");
		    } catch(Exception e) {
		      e.printStackTrace();
		    }finally {
		      classUnderTest = new ClientModel("Mercante_Libri","root","root");
		    }
	}

	@Test
	public synchronized void testDoSave() throws SQLException{

	    //inserimento coi dati
	    bean = new ClienteBean();
	    bean.setUsername("Raffaella@email.it");
	    bean.setPassword("Rono");
	    bean.setCognome("gatto");
	    bean.setNome("Raffa");
	    bean.setCAP(9343);
	    bean.setVia("via dei mille");
	    bean.setCittà("Napoli");
	    bean.setNr_Civico(3);
	    bean.toString();
	    boolean ok = false;
	    try{
	      classUnderTest.doSave(bean);
	      ok = true;
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	    classUnderTest.doDeleteString(bean.getUsername());
	    
	    assertTrue(ok);
	  }
	
	 @Test
	 public synchronized void testDoDeleteString() throws SQLException{
		    System.out.println("doDeleteString");

		    //inserimento coi dati
		   bean=new ClienteBean();
		   bean.setUsername("Raffa@email.it");
		   classUnderTest.doSave(bean);
		    
		    
		    boolean ok = false;
		    try{
		      classUnderTest.doDeleteString(bean.getUsername());
		      ok = true;
		    }catch(Exception e){
		      e.printStackTrace();
		    }

		    assertTrue(ok);
		  }
	  @Test
	 public synchronized void testDoRetrieveClientByName() throws SQLException {
	    bean = new ClienteBean();

	    boolean ok = false;

	    bean.setUsername("Raffaella@email.it");
	   classUnderTest.doSave(bean);
	    try {
	      classUnderTest.doRetrieveClientByName(bean.getUsername());
	      ok = true;
	    } catch (Exception e) {
	  	  e.printStackTrace();
	    }
	    classUnderTest.doDeleteString(bean.getUsername());
	    assertTrue(ok);
	  }
	  @Test
	 public  synchronized void testDoRetrieveAllClient() throws SQLException {
	    bean = new ClienteBean();

	    boolean ok = false;
	    bean.setUsername("Raffaella@email.it");
	  bean.setNome("raffaella");
	  bean.setCognome("gatto");

	   classUnderTest.doSave(bean);
	    try {
	      classUnderTest.doRetrieveAllClient();
	      ok = true;
	    } catch (Exception e) {
	  	  e.printStackTrace();
	    }

	    assertTrue(ok);
	    classUnderTest.doDeleteString(bean.getUsername());
	    
	  }
}
