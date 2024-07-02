package servlets;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");

		String[] consultantTypes = request.getParameterValues("consultantType11");

		// Log received data to console
		System.out.println("Received Consultant Types:");
		if (consultantTypes != null) {
			for (String type : consultantTypes) {
				System.out.println(type);
			}
		} else {
			System.out.println("No consultant types selected.");
		}

		// Example response - send a simple message back
		String responseData = "Data received by Servlet: "
				+ (consultantTypes != null ? Arrays.toString(consultantTypes) : "No data received");
		System.out.println("Response to send: " + responseData);
		response.getWriter().write(responseData);
	}
}
