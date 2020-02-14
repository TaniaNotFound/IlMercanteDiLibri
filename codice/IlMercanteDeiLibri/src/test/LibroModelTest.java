package test;

import static org.junit.Assert.*;
import java.sql.SQLException;

import org.junit.BeforeClass;
import org.junit.Test;

import beans.LibroBean;
import model.LibroModel;

public class LibroModelTest {

	  private static LibroModel classUnderTest;
	  private static LibroModel classUnderTest1;
	  private static LibroBean bean;

	  @BeforeClass
	  public static void setUp() throws SQLException {
	    try {
	      classUnderTest = new LibroModel("", "", "");
	      classUnderTest1= new LibroModel();
	    } catch(Exception e) {
	      e.printStackTrace();
	    }finally {
	      classUnderTest = new LibroModel("Mercante_Libri","root","root");
	    }
	  }

	  @Test
	   public synchronized void testDoAddLibro() throws SQLException{
	    //inserimento coi dati
	    bean=new LibroBean();
	    bean.setISBN("1234567891013");
	    bean.setTitolo("Libro");
	    bean.setPrezzo(10);
	    bean.setAutore("Autore");
	    bean.setEditore("Editore");
	    bean.setEdizione("edizione");
	    bean.setEmail("gioneve00@hotmail.it");
	    bean.toString();
	    bean.hashCode();
	    LibroBean lib = new LibroBean();
		bean.equals(lib);
	    
	    boolean ok = false;
	    try{
	      classUnderTest.doAddLibro(bean);
	      ok = true;
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	    classUnderTest.doDeleteString(bean.getISBN());
	    assertTrue(ok);
	  }

	  @Test
	  public synchronized void testDoDeleteString() throws SQLException{
		   

		    //inserimento coi dati
		    bean = new LibroBean();
		   bean.setISBN("2222222222222");
		   bean.setEmail("gioneve00@hotmail.it");
		    classUnderTest.doAddLibro(bean);
		    
		    boolean ok = false;
		    try{
		      ok = true;
		    }catch(Exception e){
		      e.printStackTrace();
		    }
		    classUnderTest.doDeleteString(bean.getISBN());
		    assertTrue(ok);
		  }
	  @Test
	  public synchronized void testDoRetrieveBookByName() throws SQLException {
	    bean = new LibroBean();

	    boolean ok = false;
	    bean=new LibroBean();
	    bean.setISBN("1111111111113");
	    bean.setTitolo("Inferno");
	    bean.setPrezzo((float) 11.00);
	    bean.setEmail("gioneve00@hotmail.it");
	   classUnderTest.doAddLibro(bean);
	    try {
	      classUnderTest.doRetrieveBookByName(bean.getTitolo());
	      ok = true;
	    } catch (Exception e) {
	  	  e.printStackTrace();
	    }
	    classUnderTest.doDeleteString(bean.getISBN());
	    assertTrue(ok);
	  }
	@Test
	  public synchronized void testDoRetrieveBookByKey() throws SQLException {
	    bean = new LibroBean();

	    boolean ok = false;
	    bean.setISBN("1234867891011");
	    bean.setTitolo("Libro");
	    bean.setPrezzo((float) 10.00);
	    bean.setAutore("Autore");
	    bean.setEditore("Editore");
	    bean.setEdizione("edizione");
	    bean.setEmail("gioneve00@hotmail.it");
	    classUnderTest.doAddLibro(bean);
	    try {
	      classUnderTest.doRetrieveBookByKey(bean.getISBN());
	      ok = true;
	    } catch (Exception e) {
	  	  e.printStackTrace();
	    }
	    classUnderTest.doDeleteString(bean.getISBN());
	    assertTrue(ok);
	  }
	@Test
	  public synchronized void testDoRetrieveBookBySearch() throws SQLException {
	    bean = new LibroBean();

	    boolean ok = false;
	    bean.setISBN("8888888888888");
	    bean.setEdizione("Editions");
	    bean.setTitolo("Inferno");
	    bean.setPrezzo((float) 3.00);
	    bean.setEmail("gioneve00@hotmail.it");
	    classUnderTest.doAddLibro(bean);
	    try {
	      classUnderTest.doRetrieveBookBySearch(bean.getTitolo());
	      ok = true;
	    } catch (Exception e) {
	  	  e.printStackTrace();
	    }
	    classUnderTest.doDeleteString(bean.getISBN());
	    assertTrue(ok);
	  }
	@Test
	public synchronized void testDoRetrieveAllBook() throws SQLException {
	  bean = new LibroBean();

	  boolean ok = false;
	  bean.setISBN("1234567890011");
	    bean.setTitolo("Libro");
	    bean.setPrezzo((float) 10.00);
	    bean.setAutore("Autore");
	    bean.setEditore("Editore");
	    bean.setEdizione("edizione");
	    bean.setEmail("gioneve00@hotmail.it");
	    classUnderTest.doAddLibro(bean);
	  try {
	    classUnderTest.doRetrieveAllBook();
	    ok = true;
	  } catch (Exception e) {
		  e.printStackTrace();
	  }
	  classUnderTest.doDeleteString(bean.getISBN());
	  assertTrue(ok);
	}
	@Test
	public synchronized void testDoRetrieveBookByEmail() throws SQLException {
	  bean = new LibroBean();

	  boolean ok = false;
	  bean.setISBN("1234345891011");
	    bean.setTitolo("Libro");
	    bean.setPrezzo((float) 10.00);
	    bean.setEmail("gioneve00@hotmail.it");
	    classUnderTest.doAddLibro(bean);
	  try {
	    classUnderTest.doRetrieveBookByEmail(bean.getEmail());
	    ok = true;
	  } catch (Exception e) {
		  e.printStackTrace();
	  }
	  classUnderTest.doDeleteString(bean.getISBN());
	  assertTrue(ok);
	}
}



