package App;

public class Benutzer {
	//Gekapselte Variablen: Benutzerinformationen
	private int id;
	private String benutzername;
	private String vorname;
	private String nachname;
	private String email;
	private String passwort;
	private String benutzerrolle;
	private int gesperrt;
	private String profilbildurl;
	
	//Getter und Setter für Id
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	//Getter und Setter für Benutzername
	public String getBenutzername() {
		return benutzername;
	}
	public void setBenutzername(String benutzername) {
		this.benutzername = benutzername;
	}
	
	//Getter und Setter für Vorname
	public String getVorname() {
		return vorname;
	}
	public void setVorname(String vorname) {
		this.vorname = vorname;
	}
	
	//Getter und Setter für Nachname
	public String getNachname() {
		return nachname;
	}
	public void setNachname(String nachname) {
		this.nachname = nachname;
	}
	
	//Getter und Setter für Email
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	//Getter und Setter für Passwort
	public String getPasswort() {
		return passwort;
	}
	public void setPasswort(String passwort) {
		this.passwort = passwort;
	}
	
	//Getter und Setter für Benutzerrolle
	public String getBenutzerrolle() {
		return benutzerrolle;
	}
	public void setBenutzerrolle(String benutzerrolle) {
		this.benutzerrolle = benutzerrolle;
	}
	
	//Getter und Setter für Gesperrt
	public int getGesperrt() {
		return gesperrt;
	}
	public void setGesperrt(int gesperrt) {
		this.gesperrt = gesperrt;
	}
	
	//Getter und Setter für Profilbild URL
	public String getProfilbildurl() {
		return profilbildurl;
	}
	public void setProfilbildurl(String profilbildurl) {
		this.profilbildurl = profilbildurl;
	}
	
	public void sperren(int id){
		
	}
	
	public void registrieren(String benutzername, String passwort, String email, String vorname, String nachname, String profilildurl){
		
	}
	
	
	
}
