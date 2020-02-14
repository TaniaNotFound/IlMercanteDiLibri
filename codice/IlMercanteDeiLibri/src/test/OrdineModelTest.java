package test;

import beans.OrdineBean;
import model.LibroModel;
import model.OrdineModel;
import beans.LibroBean;
import components.*;

import static org.junit.Assert.assertTrue;

import java.sql.SQLException;


import org.junit.BeforeClass;
import org.junit.Test;


	public class OrdineModelTest {
	  private static OrdineModel classUnderTest;
	  private static OrdineBean bean;
	  private static LibroBean bean2;
	  private static LibroModel classUnderTest2;
	  private static Cart cart;
	  
	  @BeforeClass
	  public static void setUp() throws SQLException {
	    try {
	      classUnderTest = new OrdineModel("", "", "");
	      classUnderTest2 = new LibroModel("", "", "");
	    } catch(Exception e) {
	      e.printStackTrace();
	    }finally {
	      classUnderTest = new OrdineModel("Mercante_Libri","root","root");
	      classUnderTest2 = new LibroModel("Mercante_Libri", "root", "root");
	    }
	  }
	  
	  @Test
	  public synchronized void testDoSave() throws SQLException{
	    //inserimento coi dati
	  bean=new OrdineBean();
	  bean2= new LibroBean();
	  cart=new Cart();
	 
	    bean2.setISBN("1111111111111");
	    bean2.setTitolo("Libro");
	    bean2.setAutore("Autore");
	    bean2.setPrezzo(0);
	    bean2.setEmail("gioneve00@hotmail.it");
	    classUnderTest2.doAddLibro(bean2);
	    bean.setCodice(1);
	    bean.setEmailUtente("gioneve00@hotmail.it");
	    bean.addLibro(bean2);
	    bean.getLibriOrdine();
	    bean.getPrezzo();
	    bean.toString();
	    cart.addBook(bean2);
	    
	    boolean ok = false;
	    try{
		classUnderTest.doSave(cart, bean.getEmailUtente());
	      ok = true;
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	    classUnderTest2.doDeleteString(bean2.getISBN());
	    cart.deleteBook(bean2);
	    bean.deleteBook(bean2);
	    assertTrue(ok);
	  }
	  @Test
	  public synchronized void lastCod() throws SQLException{
	    //inserimento coi dati
	  bean=new OrdineBean();
	  bean2= new LibroBean();
	  cart=new Cart();
	 
	    bean2.setISBN("1111111111111");
	    bean2.setTitolo("Libro");
	    bean2.setAutore("Autore");
	    bean2.setPrezzo(5);
	    bean2.setEmail("gioneve00@hotmail.it");
	    classUnderTest2.doAddLibro(bean2);
	    bean.setCodice(3);
	    bean.setEmailUtente("gioneve00@hotmail.it");
	    cart.addBook(bean2);
	    classUnderTest.doSave(cart, bean.getEmailUtente());
	    boolean ok = false;
	    try{
	    	classUnderTest.lastCod();
	      ok = true;
	    }catch(Exception e){
	      e.printStackTrace();
	    }
	    classUnderTest2.doDeleteString(bean2.getISBN());
	    cart.deleteAll();
	    bean.removeAll();
	    assertTrue(ok);
	  }
	
	}