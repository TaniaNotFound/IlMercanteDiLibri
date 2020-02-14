package components;

import java.util.ArrayList;
import java.util.List;
import beans.Acquistabile;
import beans.LibroBean;

public class Cart {
	private List<Acquistabile> libro;
	
	public Cart() {
		libro = new ArrayList<Acquistabile>();
	}
	
	public void addBook(Acquistabile libro) {
		if(!this.libro.contains(libro))
		this.libro.add(libro); 
	}
	

	public void deleteBook(Acquistabile book) {
		if(this.libro.contains(book))
			this.libro.remove(book);
		}
 	
	
	public void deleteAll() {
		libro.clear();
	}
	

	public List<Acquistabile> getBooks() {
		return  libro;
	}
	
}
