package App;
import Database.*;

public class Controller {
	public Benutzer benutzer = new Benutzer();
	
	public Controller(String seite) {
		System.out.println("StartApp called");
		Datenbank con = new Datenbank();
		
	}
	
	public Benutzer ladeBenutzer(){
		return benutzer;
	};

}
