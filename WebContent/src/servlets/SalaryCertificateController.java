package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.SalaryCertificate;
import beans.fjtcouser;
import utils.SalaryCertificateDbUtil;

/**
 * Servlet implementation class SalaryCertificateController
 */
@WebServlet("/SalaryCertificate")
public class SalaryCertificateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SalaryCertificateDbUtil salaryCertificateDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SalaryCertificateController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init() throws ServletException {
		super.init();
		salaryCertificateDbUtil = new SalaryCertificateDbUtil();

	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {
			String empCode = fjtuser.getEmp_code();
			String theDataFromHr = request.getParameter("fjtco");

			if (theDataFromHr == null) {
				theDataFromHr = "view";

			}

			switch (theDataFromHr) {
			case "view":

				try {
					getSalaryCertificate(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			default:

				try {
					goToSalaryCertificatePage(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

	}

	private void getSalaryCertificate(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {
		SalaryCertificate theSalaryInfo = salaryCertificateDbUtil.getSalaryCertificateData(empCode);
		request.setAttribute("SALARYINFO", theSalaryInfo);
		goToSalaryCertificatePage(request, response);

	}

	private void goToSalaryCertificatePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/salarycertificate.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				response.sendRedirect("logout.jsp");
			} else {
				processRequest(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				response.sendRedirect("logout.jsp");
			} else {
				processRequest(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
