package beans;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.OrdineModel;


public class OrdineBean {
		int Codice;
		float Totale;
		String Utente_Email;
		List <Acquistabile> arrayLibri;
	
    
    public OrdineBean() {
    	Codice = 0;
    	Totale=0;
    	Utente_Email= "";
    	arrayLibri= new ArrayList<Acquistabile>();
    }
    
    public int getCodice() {
    	return Codice;
    	
    }
    public void setCodice(int codice) {
    	this.Codice=codice;
    }
    
   /* public int assegnaCodice() throws SQLException {
    	//modificare la riga seguente
   	OrdineModel model =new OrdineModel("Mercante_Libri", "root", "tania");
    	return model.assegnaCodice();
    	}*/
    
    public String getEmailUtente() {
    	return Utente_Email;
    }
    
    public void setEmailUtente( String emailUtente) {
    	this.Utente_Email=emailUtente;
    }

    public float getPrezzo() {
    	return Totale;
    }
    
    public ArrayList<Acquistabile> getLibriOrdine(){
    	return (ArrayList<Acquistabile>) arrayLibri;
    }
    
    public void addLibro(Acquistabile libro) {
    	arrayLibri.add(libro);
    	Totale+=libro.getPrezzo();
    }

    public void removeAll() {
    	for(int i=0;i<arrayLibri.size();i++) {
    		arrayLibri.remove(i);
    	}
    	Totale=0;
    }
    
    public String toString() {
    	return "OrdineBean Codice=" + Codice + "Email Utente=" + Utente_Email +"Prezzo="+Totale+ "Array="+arrayLibri.toString();
    }
    
    public void setArray(List<Acquistabile> array) {
    	arrayLibri=array;
    	if(arrayLibri!=null)
    	for(int i=0;i<arrayLibri.size();i++) {
    		Totale=arrayLibri.get(i).getPrezzo();
    	}
}
    
    
    
    
    
    public void deleteBook (Acquistabile libro) {
    	for(int i=0;i<arrayLibri.size();i++) {
    		if(arrayLibri.get(i).getISBN()==libro.getISBN()) {
    			Totale-=arrayLibri.get(i).getPrezzo();
    			arrayLibri.remove(i);
    		}
    	}
    }
}