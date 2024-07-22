package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.SalaryCertificate;
import beans.fjtcouser;
import utils.ExperienceCertificateDbUtil;
import utils.SalaryCertificateDbUtil;

/**
 * Servlet implementation class ExperienceCertificateController
 */
@WebServlet("/ExperienceCertificate")
public class ExperienceCertificateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ExperienceCertificateDbUtil experienceCertificateDbUtil;
	private SalaryCertificateDbUtil salaryCertificateDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ExperienceCertificateController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init() throws ServletException {
		super.init();
		experienceCertificateDbUtil = new ExperienceCertificateDbUtil();
		salaryCertificateDbUtil = new SalaryCertificateDbUtil();

	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {
			String theDataFromHr = request.getParameter("fjtco");
			System.out.println("theDataFromHr==" + theDataFromHr);
			if (theDataFromHr == null) {
				theDataFromHr = "view";
			}
			String empCode = fjtuser.getEmp_code();
			switch (theDataFromHr) {
			case "view":

				try {
					getExperienceCertificate(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "hr":

				try {
					getExperienceCertificateForHR(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:

				try {
					goToExperienceCertificatePage(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

	}

	private void getExperienceCertificate(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {
		SalaryCertificate theSalaryInfo = salaryCertificateDbUtil.getSalaryCertificateData(empCode);
		request.setAttribute("SALARYINFO", theSalaryInfo);
		goToExperienceCertificatePage(request, response);

	}

	private void getExperienceCertificateForHR(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {
		List<SalaryCertificate> theEmpDetails = salaryCertificateDbUtil.getSalaryCertificateDataForHr();
		request.setAttribute("empDetails", theEmpDetails);
		goToExperienceCertificatePageForHR(request, response);

	}

	private void goToExperienceCertificatePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/experienceCertificate.jsp");
		dispatcher.forward(request, response);
	}

	private void goToExperienceCertificatePageForHR(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/experienceCert.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
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
