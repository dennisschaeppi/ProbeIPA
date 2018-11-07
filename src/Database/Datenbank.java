package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class Datenbank {
	//Zugangsdaten für Datenbank
	private String server = "localhost";
	private String user = "root";
	private String password = "";
	private String datasource = "probeipa_sozialesnetzwerk";
	private Connection connect;
	
	public Datenbank(){
		//URL zum Verbinden zu MySQL
		String url = "jdbc:mysql://" + server + "/" + datasource + "?user=" + user + "&password=" + password + "&serverTimezone=UTC";
		try {
			//JDBC-Treiber laden
			Class.forName("com.mysql.cj.jdbc.Driver");
			try {
				//Verbindung aufbauen
				connect = DriverManager.getConnection(url);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	
	//Verbindung aufbauen
	public Connection getConnect(){
		return this.connect;
	}
}
