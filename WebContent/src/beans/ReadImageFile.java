package beans;

import java.io.File;
import java.net.URI;

public class ReadImageFile {
	
	public File readFile(String path) {
		 File f = new File(path);
		 System.out.println("javass  dddd "+f.exists());
		 File f1 =null;
		 try {
			 f1 = new File(new URI("file:////fjtco-ho-svr-03/HR-emp_photo/E000001.jpg"));
		 }catch(Exception e) {}
		 
		 return f1;
	}

}
