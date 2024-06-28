package servlets;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/testServlet")
public class Test extends HttpServlet {

	// For testing purposes only; not used in servlet context
	public static void main(String[] args) {
		try {
			int y = 2022;
			LocalDate date1 = LocalDate.of(y, 1, 1);
			System.out.println(date1);
			java.sql.Date sqlDate = java.sql.Date.valueOf(date1);
			System.out.println(date1 + "\t" + sqlDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Method to download file using traditional IO streams
	private static void downloadUsingStream(String urlStr, String file) throws IOException {
		URL url = new URL(urlStr);
		try (BufferedInputStream bis = new BufferedInputStream(url.openStream());
				FileOutputStream fos = new FileOutputStream(file)) {
			byte[] buffer = new byte[1024];
			int count;
			while ((count = bis.read(buffer, 0, 1024)) != -1) {
				fos.write(buffer, 0, count);
			}
		}
	}

	// Method to download file using NIO (Non-blocking IO)
	private static void downloadUsingNIO(String urlStr, String file) throws IOException {
		URL url = new URL(urlStr);
		try (ReadableByteChannel rbc = Channels.newChannel(url.openStream());
				FileOutputStream fos = new FileOutputStream(file)) {
			fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
		}
	}

	// Handles POST requests for file download
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Extracting and validating file name parameter
		String fileName = request.getParameter("fileName");
		if (fileName == null || !fileName.matches("[\\w\\-.]+")) {
			throw new ServletException("Invalid file name.");
		}

		// Constructing the file path
		File file = new File("D://MEDICALINSURANCE/", fileName);

		// Ensure the file exists before proceeding
		if (!file.exists() || !file.isFile()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
			return;
		}

		// Setting up response headers and streams for file download
		try (InputStream input = new FileInputStream(file); OutputStream osh = response.getOutputStream()) {

			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());

			// Transferring file content to the response output stream
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = input.read(buffer)) != -1) {
				osh.write(buffer, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace(); // Log the exception for debugging
		}
	}
}
