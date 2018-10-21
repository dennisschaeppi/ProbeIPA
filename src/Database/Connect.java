package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class Connect {
	private String server = "localhost";
	private String user = "root";
	private String password = "";
	
	public Connect(String datasource){
		String url = "jdbc:mysql://" + server + "/" + datasource + "?user=" + user + "&password=" + password + "&serverTimezone=UTC";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try {
				Connection connect = DriverManager.getConnection(url);
				//System.out.println(connect.getCatalog());
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
}
