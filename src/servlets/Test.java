package servlets;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/testServlet")
public class Test extends HttpServlet {

	public static void main(String[] args) {
		// String url =
		// "http://localhost:8080/FJPORTAL_DEV/MEDICALINSURANCE/GN_Plus_Member_s_Access_UAE_October_2022_CAT_A.xlsx";

		try {

//			Calendar current = Calendar.getInstance();
//			current.add(Calendar.DATE, 30);
//			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//			Date resultdate = new Date(current.getTimeInMillis());
//			String dueudate = df.format(resultdate);

//			System.out.println(dueudate);
			// downloadUsingNIO(url,
			// "/Users/webdev/GN_Plus_Member_s_Access_UAE_October_2022_CAT_A.xslx");

			// downloadUsingStream(url,
			// "/Users/webdev/GN_Plus_Member_s_Access_UAE_October_2022_CAT_A.xslx");

			int y = 2022;
			String s = "1/1/" + y;
			System.out.println(s);
			Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
			// java.util.Date utilDate = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(date1.getTime());

			System.out.println(date1 + "\t" + sqlDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void downloadUsingStream(String urlStr, String file) throws IOException {
		URL url = new URL(urlStr);
		BufferedInputStream bis = new BufferedInputStream(url.openStream());
		FileOutputStream fis = new FileOutputStream(file);
		byte[] buffer = new byte[1024];
		int count = 0;
		while ((count = bis.read(buffer, 0, 1024)) != -1) {
			fis.write(buffer, 0, count);
		}
		fis.close();
		bis.close();
	}

	private static void downloadUsingNIO(String urlStr, String file) throws IOException {
		URL url = new URL(urlStr);
		ReadableByteChannel rbc = Channels.newChannel(url.openStream());
		FileOutputStream fos = new FileOutputStream(file);
		fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
		fos.close();
		rbc.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fileName = request.getParameter("fileName");
		File file = new File("D://MEDICALINSURANCE/" + fileName);
		InputStream input = new FileInputStream(file);
		System.out.println(file);
		// InputStream is=new FileInputStream(file);
		/*
		 * response.setHeader("Content-Type","application/octet-stream");
		 * response.setHeader("Content-Disposition","attachment; filename=" +
		 * file.getName()); System.out.println("ffff "+file.getName());
		 */
		OutputStream osh = response.getOutputStream();
		DataInputStream disObj = null;
		try {

			System.out.println("ff " + file.getName());
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-Disposition", "attachment; filename=" + file);
			System.out.println("ff " + file.getName());
			FileInputStream fileInputStream = new FileInputStream(file);

			int i;
			while ((i = fileInputStream.read()) != -1) {
				osh.write(i);
			}
			fileInputStream.close();
			osh.close();

		} catch (Exception e) {
		} finally {
			if (input != null) {
				input.close();
			}

			if (osh != null) {
				osh.close();
			}
		}
	}

}
