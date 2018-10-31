package App;
import Database.*;

public class StartApp {
	
	public StartApp() {
		System.out.println("StartApp called");
		Connect con = new Connect("synned_music");
	}

}
