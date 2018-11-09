package App;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Database.Datenbank;

public class Login {
	
	//Variablen f�r Datenbankabfragen
	private Datenbank db = new Datenbank();
	private PreparedStatement ps;
	private Connection con;
	private ResultSet rs;
	
	//Gekapselte Variablen: Logininformationen
	private String username = null;
	private String password = null;
	private Integer id2;
	private Boolean logged = false;
	private int rolle;
	
	//Konstruktor 1: F�r Login
	public Login(String benutzername, String passwort){
		con = db.getConnect();//Verbindet mit Datenbank
		setLogged(checkValidUser(benutzername, passwort));//�berpr�ft Benutzerdaten und Passwort
		
	}
	
	//Konstruktor 2: Lediglich f�r Funktionsaufruf
	public Login(){
		
	}
	
	//�berpr�ft Benutzerdaten und Passwort
	private Boolean checkValidUser(String benutzername, String passwort){
		try {
			///L�dt Benutzer aus Datenbank
			ps = con.prepareStatement("CALL loadBenutzer(?)");
			ps.setString(1, benutzername);
			rs = ps.executeQuery();
			
			//Setzt die Variablen mit den ermittelten Benutzerdaten
			if(rs.next()){
				id2 = rs.getInt("id_benutzer");
				username = rs.getString("benutzername");
				password = rs.getString("passwort");
				rolle = rs.getInt("fs_benutzerrolle");
				
				System.out.println("BN: "+username);
			}
			
			if(password.equals(getHashedPasswort(id2+passwort))){
				return true;
			}
		
		} catch (SQLException e) {
			
		}
		return false;
	}
	
	//Verschl�sselt das Passwort
	public String getHashedPasswort(String passwort){
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5"); //Einwegverschl�sselungsart ausw�hlen
			byte[] array = md5.digest(passwort.getBytes());//Wandelt das eingegebene Passwort in Bytes um
			StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < array.length; ++i) {
	          sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3)); //Wandelt jedes Zeichen in HEX um
	        }
	        return sb.toString();
		} catch (NoSuchAlgorithmException e) {
		}
		return null;
	}
	
	//Getter und Seter f�r Logged
	public void setLogged(Boolean b){
		this.logged = b;
	}
	
	public Boolean getLogged(){
		return logged;
	}
	
	//Getter f�r Id
	public int getId(){
		return id2;
	}
	
	//Getter f�r Benutzerrolle
	public int getRolle(){
		return rolle;
	}
	
	
}
