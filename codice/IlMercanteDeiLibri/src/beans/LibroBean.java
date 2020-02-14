package beans;
import java.io.Serializable;

public class LibroBean implements Serializable,Acquistabile {
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((Autore == null) ? 0 : Autore.hashCode());
		result = prime * result + ((Editore == null) ? 0 : Editore.hashCode());
		result = prime * result + ((Edizione == null) ? 0 : Edizione.hashCode());
		result = prime * result + ((Email == null) ? 0 : Email.hashCode());
		result = prime * result + ((ISBN == null) ? 0 : ISBN.hashCode());
		result = prime * result + Float.floatToIntBits(Prezzo);
		result = prime * result + ((Titolo == null) ? 0 : Titolo.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LibroBean other = (LibroBean) obj;
		if (Autore == null) {
			if (other.Autore != null)
				return false;
		} else if (!Autore.equals(other.Autore))
			return false;
		if (Editore == null) {
			if (other.Editore != null)
				return false;
		} else if (!Editore.equals(other.Editore))
			return false;
		if (Edizione == null) {
			if (other.Edizione != null)
				return false;
		} else if (!Edizione.equals(other.Edizione))
			return false;
		if (Email == null) {
			if (other.Email != null)
				return false;
		} else if (!Email.equals(other.Email))
			return false;
		if (ISBN == null) {
			if (other.ISBN != null)
				return false;
		} else if (!ISBN.equals(other.ISBN))
			return false;
		if (Float.floatToIntBits(Prezzo) != Float.floatToIntBits(other.Prezzo))
			return false;
		if (Titolo == null) {
			if (other.Titolo != null)
				return false;
		} else if (!Titolo.equals(other.Titolo))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "LibroBean ISBN= " + ISBN + ", Titolo=" + Titolo + ", Prezzo=" + Prezzo + ", Autore=" + Autore
				+ ", Editore=" + Editore + ", Edizione=" + Edizione + ", Email=" + Email ;
	}

	private static final long serialVersionUID = 1L;
	
	String ISBN;
	String Titolo;
	float Prezzo;
	String Autore;
	String Editore;
	String Edizione;
	String Email;
	
	public LibroBean(){
		ISBN="";
		Titolo="";
		Prezzo=0;
		Autore="";
		Editore="";
		Edizione="";
		Email="";
	}

	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}

	public String getTitolo() {
		return Titolo;
	}

	public void setTitolo(String titolo) {
		Titolo = titolo;
	}

	public float getPrezzo() {
		return Prezzo;
	}

	public void setPrezzo(float prezzo) {
		this.Prezzo = prezzo;
	}

	public String getAutore() {
		return Autore;
	}

	public void setAutore(String autore) {
		Autore = autore;
	}

	public String getEditore() {
		return Editore;
	}

	public void setEditore(String editore) {
		Editore = editore;
	}

	public String getEdizione() {
		return Edizione;
	}

	public void setEdizione(String edizione) {
		Edizione = edizione;
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}

