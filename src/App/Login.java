package App;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Database.Datenbank;

public class Login {
	private Datenbank db = new Datenbank();
	private PreparedStatement ps;
	private Connection con;
	private ResultSet rs;
	
	private String username = null;
	private String password = null;
	private Integer id2;
	private Boolean logged = false;
	
	
	public Login(String benutzername, String passwort){
		System.out.println(benutzername + "---" + getHashedPasswort(1+passwort));
		con = db.getConnect();
		setLogged(checkValidUser(benutzername, passwort));
		
		
		System.out.println(benutzername + "---" + getHashedPasswort(passwort));	
	}
	
	
	private Boolean checkValidUser(String benutzername, String passwort){
		try {
			ps = con.prepareStatement("CALL loadBenutzer(?)");
			ps.setString(1, benutzername);
			rs = ps.executeQuery();
			
			
			if(rs.next()){
				id2 = rs.getInt("id_benutzer");
				username = rs.getString("benutzername");
				password = rs.getString("passwort");
				System.out.println("BN: "+username);
			}
			
			if(password.equals(getHashedPasswort(id2+passwort))){
				return true;
			}
		
		} catch (SQLException e) {
			
		}
		return false;
	}
	
	public void login(Benutzer benutzer){
		
	}
	
	public void logout(Benutzer benutzer){
		
	}
	
	public String getHashedPasswort(String passwort){
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			byte[] array = md5.digest(passwort.getBytes());
			StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < array.length; ++i) {
	          sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));
	        }
	        return sb.toString();
		} catch (NoSuchAlgorithmException e) {
		}
		return null;
	}
	
	public void setLogged(Boolean b){
		this.logged = b;
	}
	
	public Boolean getLogged(){
		return logged;
	}
	
}
