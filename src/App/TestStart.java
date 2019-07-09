package App;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

import com.siemens.ch.ts.iltis.pg.external.ProgRuntime;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.TabFolder;
import org.eclipse.swt.widgets.TabItem;

public class TestStart {
	private static String[] tabs = {"UIA", "USERT", "USERI"};
	
	public static void main(String[] args) {
		//ProgRuntime prt = new ProgRuntime();
		//prt.runBatch("rundll32 SHELL32.DLL,ShellExec_RunDLL \"C:\\Program Files (x86)\\Java\\jre1.8.0_202\\bin\\javaw.exe\" -jar D:\\git\\sch-iltis-pg-tools-java\\bin\\jar\\FileVergleichAlle.jar 2");
		Display fenster = new Display();
		Shell shell = new Shell(fenster);
		shell.setLayout(null);
		shell.setImage(new Image(fenster, "D:\\git\\sch-iltis-pg-tools-java\\bin\\com\\siemens\\ch\\ts\\iltis\\pg\\icon\\PH31.gif"));
		
		TabFolder tabFolder = new TabFolder(shell, SWT.NONE);
		tabFolder.setBounds(23, 27, 237, 126);
		
		for(int i=0; i<TestStart.tabs.length; i++) {
			TabItem newTab = new TabItem(tabFolder, SWT.NONE);
			newTab.setText(TestStart.tabs[i]);
		}
		
		Button datei = new Button(shell, SWT.NONE);
		datei.setText("Datei...");
		datei.setBounds(23, 170, 150, 50);
		datei.addListener(SWT.Selection, new Listener() {
			
			@Override
			public void handleEvent(Event arg0) {
				FileDialog fd = new FileDialog(shell, SWT.NONE);
				fd.setFilterExtensions(new String[] {"*.txt", "*.TXT"});
				fd.open();
				System.out.println(fd.getFilterPath()+"\\"+fd.getFileName());
				
			}
		});
		
		
		
		shell.open();
		
		while(!shell.isDisposed()) {
			if(!fenster.readAndDispatch()) {
				fenster.sleep();
			}
		}
		
		shell.dispose();
		
	}
}
