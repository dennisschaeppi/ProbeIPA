package App;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.print.attribute.standard.DateTimeAtCompleted;

import Database.Datenbank;

public class Beitrag {
	//Gekapselte Variablen: Informationen zum Beitrag
	private int id;
	private String titel;
	private String beschreibung;
	private Date datum;
	private String benutzername;
	private int gemeldet;
	
	//Variablen für Datenbankabfragen
	private Datenbank db = new Datenbank();
	private PreparedStatement ps;
	private Connection con;
	private ResultSet rs;
	
	//Konstruktor
	public Beitrag(Connection con){
		this.con = con;
	}
	
	//Getter und Setter für Id
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	//Getter und Setter für titel
		public String getTitel() {
			return titel;
		}
		public void setTitel(String titel) {
			this.titel = titel;
		}
	
	//Getter und Setter für Beschreibung
	public String getBeschreibung() {
		return beschreibung;
	}
	public void setBeschreibung(String beschreibung) {
		this.beschreibung = beschreibung;
	}
	
	//Getter und Setter für Datum
	public Date getDatum() {
		return datum;
	}
	public void setDatum(Date datum) {
		this.datum = datum;
	}
	
	//Getter und Setter für Benutzername
	public String getBenutzername() {
		return benutzername;
	}
	public void setBenutzername(String benutzername) {
		this.benutzername = benutzername;
	}
	
	//Getter und Setter für Gemeldet
	public int getGemeldet() {
		return gemeldet;
	}
	
	public void setGemeldet(int gemeldet) {
		this.gemeldet = gemeldet;
	}
	
	//Schreibt einen Kommentar
	public void schreibeKommentar(int beitrag, int benutzer, String text){
		//Aktuelles Datum ermitteln
		Calendar cal = new GregorianCalendar();
		java.util.Date dt = cal.getTime();
		Date sdt = new Date(dt.getTime());
		
		//Führt Datenmanipulation aus: schreibeKommentar()
		try {
			ps = con.prepareStatement("CALL schreibeKommentar(?, ?, ?, ?)");
			ps.setInt(1, beitrag);
			ps.setInt(2, benutzer);
			ps.setString(3, text);
			ps.setDate(4, sdt);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//Erstellt einen neuen Beitrag
	public void neu(String titel, String beschreibung, Date datum, int benutzer){
		
		//Führt Datenmanipulation aus: erstelleBeitrag()
		try {
			ps = con.prepareStatement("CALL erstelleBeitrag(?, ?, ?, ?)");
			ps.setString(1, titel);
			ps.setString(2,beschreibung);
			ps.setDate(3, datum);
			ps.setInt(4, benutzer);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
