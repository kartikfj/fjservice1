package servlets;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DownloadQueries
 */
@WebServlet("/DownloadQueries")
public class DownloadQueries extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fileName = request.getParameter("fileName");
		System.out.println("" + fileName);
		File file = new File("D://QUERIES/" + fileName);

		InputStream input = new FileInputStream(file);
		if (fileName.endsWith("xlsx")) {
			response.setHeader("Content-Type", "application/octet-stream");
		} else if (fileName.endsWith("pdf")) {
			response.setHeader("Content-Type", "application/pdf");
		} else if (fileName.endsWith("docx")) {
			response.setHeader("Content-Type", "application/msword");
		} else if (fileName.endsWith("doc")) {
			response.setHeader("Content-Type", "application/msword");
		} else {
			throw new RuntimeException("File type not found in downloadQueries");
		}

		response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
		System.out.println("file name " + file.getName());
		OutputStream osh = response.getOutputStream();
		DataInputStream disObj = null;
		try {
			disObj = new DataInputStream(input);
			int nlength = 0;
			byte[] bbuf = new byte[1024];
			while ((disObj != null) && ((nlength = disObj.read(bbuf)) != -1)) {
				osh.write(bbuf, 0, nlength);
			}
			osh.flush();
		} catch (Exception e) {
			System.out.println("Exception in DownloadServlet " + e);
		} finally {
			if (input != null) {
				input.close();
			}

			if (osh != null) {
				osh.close();
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
