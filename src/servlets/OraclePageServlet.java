package servlets;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.OraclePage;
import utils.OraclePageDbUtil;

/**
 * Servlet implementation class OraclePageServlet
 */
@WebServlet("/submit")
public class OraclePageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		// Ensure UTF-8 encoding for request data

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// Retrieve data from request parameters or any other source
		String name = request.getParameter("name");
		// String description = request.getParameter("description");

		// Use JavaBean to update the database
		OraclePageDbUtil javaBean = new OraclePageDbUtil();
		List<OraclePage> opObj = javaBean.getData(name);
		request.setAttribute("ORACLEDATA", opObj);
		RequestDispatcher dispatcher;
		try {
			dispatcher = request.getRequestDispatcher("/OraclePage.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			System.out.println("Exceptopm" + e);
		}

	}
}
