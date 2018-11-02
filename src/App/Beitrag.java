package App;

import java.sql.Date;

public class Beitrag {
	//Gekapselte Variablen: Informationen zum Beitrag
	private int id;
	private String beschreibung;
	private Date datum;
	private String benutzername;
	private int gemeldet;
	
	//Getter und Setter für Id
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	
	
}
