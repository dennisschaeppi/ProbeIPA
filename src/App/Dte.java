package App;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Dte {

	public static void main(String[] args) {

		Date dt = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss");
		String s = dateFormat.format(dt);
		System.out.println(s);

	}

}
