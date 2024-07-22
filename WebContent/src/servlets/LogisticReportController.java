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

import beans.Logistic;
import beans.fjtcouser;
import utils.LogisticDashboardDbUtil;

/**
 * @author nufail.a Servlet implementation class FJ LOGISTIC IMPORT POs handling
 */

@WebServlet("/LogisticReportController")
public class LogisticReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LogisticDashboardDbUtil logisticDashboardDbUtil;

	public LogisticReportController() throws ServletException {
		super.init();
		logisticDashboardDbUtil = new LogisticDashboardDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String userRole = fjtuser.getRole();
			String employeeCode = fjtuser.getEmp_code();
			String division = fjtuser.getEmp_divn_code();
			// String empname = fjtuser.getUname();
			String requestType = request.getParameter("action");

			// System.out.println(division);
			if (requestType == null) {
				requestType = "def";
			}
			switch (requestType) {
			case "def":
				try {
					checkUserLogisticPortalPermission(request, response, employeeCode, division, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			default:
				try {
					checkUserLogisticPortalPermission(request, response, employeeCode, division, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	// 1. Check the User Permission to access FJ Logistic Portal -- only for
	// 'authorised divisionn user', all finance user and all logistic user..
	private void checkUserLogisticPortalPermission(HttpServletRequest request, HttpServletResponse response,
			String empCode, String division, String userRole) throws IOException, ServletException {
		try {

			if (division.equalsIgnoreCase("FN") || division.equalsIgnoreCase("LG") || division.equalsIgnoreCase("KSALG")
					|| userRole.equalsIgnoreCase("mg")) {
				// System.out.println("FN LG MG");
				getPODetails(request, response, "ALL", division, empCode);
			} else {
				response.sendRedirect("homepage.jsp");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("logout.jsp");
		} finally {
			// response.sendRedirect("logout.jsp");

		}
	}

	// 4. COMPLETE DETAILS OF A SINGLE SERVICE REQUEST
	private void getPODetails(HttpServletRequest request, HttpServletResponse response, String txnCode, String divnCode,
			String empCode) throws SQLException, ServletException, IOException {
		List<Logistic> poLists = null;

		switch (txnCode) {
		case "ALL":
			try {
				poLists = logisticDashboardDbUtil.getCompletePODetails(divnCode);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "DM":
			try {
				poLists = logisticDashboardDbUtil.getPODetailsforTXNCodeForDM(empCode);
				request.setAttribute("lgPermission", "view");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			try {
				poLists = logisticDashboardDbUtil.getPODetailsforTXNCode(empCode);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("POLST", poLists);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/logistic/reports.jsp");
		dispatcher.forward(request, response);

	}

	@Override
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

	@Override
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
