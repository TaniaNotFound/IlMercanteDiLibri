package beans;

public class ClienteBean {
String Email;
String Nome;
String Cognome;
String Password;
int nr_Civico;
String Via;
String Città;
int CAP;



public ClienteBean() {
	Email = "";
	Nome = "";
	Cognome = "";
	Password = "";
	nr_Civico=0;
	Via="";
	Città="";
	CAP=0;
}

public int getNr_Civico() {
	return nr_Civico;
}

public void setNr_Civico(int nr_Civico) {
	this.nr_Civico = nr_Civico;
}

public String getVia() {
	return Via;
}

public void setVia(String via) {
	Via = via;
}

public String getCittà() {
	return Città;
}

public void setCittà(String città) {
	Città = città;
}

public int getCAP() {
	return CAP;
}

public void setCAP(int cap) {
	CAP = cap;
}

public String getUsername() {
	return Email;
}
public void setUsername(String user) {
	this.Email=user;
}
public String getNome() {
	return Nome;
}
public void setNome(String nome) {
	this.Nome=nome;
}
public String getCognome() {
	return Cognome;
}
public void setCognome(String cognome) {
	this.Cognome=cognome;
}
public String getPassword() {
	return Password;
}
public void setPassword(String psw) {
	this.Password=psw;
}
public String toString() {
	return "ClienteBean[Username=" + Email + ", Nome=" + Nome + ", Cognome=" + Cognome + ", Password=" 
			+ Password + ", via"+ Via+
			", nrCivico= "+ nr_Civico+", Città= "+Città+"CAP="+CAP+"]";	
	
}
}