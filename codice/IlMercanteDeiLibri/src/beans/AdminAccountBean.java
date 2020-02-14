package beans;

public class AdminAccountBean {
	String Username;
	String Password;

	public AdminAccountBean() {

		Username = "";
		Password = "";
		
	}

	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		this.Username=username;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String psw) {
		this.Password=psw;
	}


	public String toString() {
		return "AdminAccountBean [Username=" + Username + ", Password=" + Password + "]";
	}
	}


