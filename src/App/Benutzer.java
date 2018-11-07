package App;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Database.Datenbank;

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
	
	//Variablen für Datenbankabfragen
	private Datenbank db = new Datenbank();
	private Login login = new Login();
	private PreparedStatement ps;
	private Connection con = db.getConnect();
	private ResultSet rs;
	
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
	
	//Sperrt einen Benutzer
	public void sperren(int id){
		
	}
	
	//Aktualisiert die Benutzerdaten
	public void datenAendern(int id, String bn, String vorname, String nachname, String email){
		
		//Führt Datenmanipulation aus: aendereBenutzerdaten()
		try {
			ps = con.prepareStatement("CALL aendereBenutzerdaten(?, ?, ?, ?, ?)");
			ps.setInt(1, id);
			ps.setString(2, bn);
			ps.setString(3, vorname);
			ps.setString(4, nachname);
			ps.setString(5, email);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//Registriert einen neuen Benutzer
	public void registrieren(String benutzername, String passwort, String email, String vorname, String nachname, String profilbildurl){
		
		//Führt Datenmanipulation aus: register()
		try {
			ps = con.prepareStatement("CALL register(?, ?, ?, ?, ?)");
			ps.setString(1, benutzername);
			ps.setString(2, vorname);
			ps.setString(3, nachname);
			ps.setString(4, email);
			ps.setString(5, "-");
			ps.executeUpdate();
			
			//Lädt den neu registrierten Benutzer aus der Datenbank
			ps = con.prepareStatement("CALL loadBenutzer(?)");
			ps.setString(1, benutzername);
			rs = ps.executeQuery();
			
			
			if(rs.next()){
				try{
					//Setzt die Id des neuen Benutzers
					setId(rs.getInt("id_benutzer"));
					
					//Fügt das verschlüsselte Passwort ein
					ps = con.prepareStatement("CALL registerPasswort(?, ?)");
					ps.setInt(1, getId());
					ps.setString(2, login.getHashedPasswort(getId()+passwort));//Passwort verschlüsselt mit ID und Passworttext
					ps.executeUpdate();
					
				}catch(NumberFormatException e){
					e.printStackTrace();
				}	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}
	
	
	
}
