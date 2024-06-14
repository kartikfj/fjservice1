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

@WebServlet("/LogisticPOController")
public class LogisticImportPOController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LogisticDashboardDbUtil logisticDashboardDbUtil;

	public LogisticImportPOController() throws ServletException {
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
			String empname = fjtuser.getUname();
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
			case "updudea":// update division user data entry action
				try {
					String emailId = fjtuser.getEmailid();
					updateDivisionPoDetails(request, response, employeeCode, division, emailId, empname);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "upfudea":// update finance user data entry action
				try {
					updateFinancePoDetails(request, response, employeeCode, division);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "upludea":// update logistic user data entry action
				try {
					updateLogisticPoDetails(request, response, employeeCode, division, empname);
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

			if (division.equalsIgnoreCase("FN") || division.equalsIgnoreCase("LG") || userRole.equalsIgnoreCase("mg")) {
				// System.out.println("FN LG MG");
				getPODetails(request, response, "ALL", division, empCode);
			} else if (logisticDashboardDbUtil.checkDMLogisticDashbaordAccess(empCode)) {
				// System.out.println("DM");
				getPODetails(request, response, "DM", division, empCode);
			} else {
				// System.out.println("DIVN");
				Logistic permissionData = logisticDashboardDbUtil.getDivsionEmployeeAccessStatus(empCode);
				int permissionFlag = permissionData.getUserPermission();
				if (permissionFlag == 1) {
					getPODetails(request, response, permissionData.getTxnCode(), division, empCode);
				} else {
					response.sendRedirect("homepage.jsp");
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("logout.jsp");
		} finally {
			// response.sendRedirect("logout.jsp");

		}
	}

	// 2. update division user details.
	private void updateDivisionPoDetails(HttpServletRequest request, HttpServletResponse response, String empCode,
			String division, String emailId, String empName) throws IOException, ServletException, SQLException {
		int successVal = 0;
		if (!division.equalsIgnoreCase("FN") && !division.equalsIgnoreCase("LG")) {
			String id = request.getParameter("podd0");
			int containers = Integer.parseInt(request.getParameter("podd1"));
			String exFactDate = request.getParameter("podd2");
			String contact = request.getParameter("podd3");
			String location = request.getParameter("podd4");
			String remarks = request.getParameter("podd5");

			String poNumber = request.getParameter("podd6");
			String poDate = request.getParameter("podd7");
			String supplier = request.getParameter("podd8");
			String shipmentTerm = request.getParameter("podd9");
			String shipmentMode = request.getParameter("podd10");
			String finalDestination = request.getParameter("podd11");
			request.setAttribute("selectedVal", shipmentTerm);
			int actionType = Integer.parseInt(request.getParameter("podd12"));
			String reExport = request.getParameter("podd13");
			String reference = request.getParameter("podl4");
			String candFETADate = request.getParameter("podd15");
			if (reExport.equalsIgnoreCase("true") && reExport.length() == 4) {
				reExport = "Y";
			} else {
				reExport = "N";
			}
			if (id != null && exFactDate != null && contact != null && location != null && !id.isEmpty()
					&& !exFactDate.isEmpty() && !contact.isEmpty() && !location.isEmpty()) {
				Logistic poDetails = new Logistic(id, shipmentTerm, shipmentMode, containers, exFactDate, contact,
						location, remarks, empCode, empName, poNumber, poDate, supplier, finalDestination, reExport,
						candFETADate);
				if (actionType == 0 || actionType == 1) {
					successVal = logisticDashboardDbUtil.updatePODetailsByDivision(poDetails);
				}

				if (successVal == 1) {
					logisticDashboardDbUtil.sendmailToLogisticTeam(poDetails, emailId, actionType, reference);
				}
			} else {
				successVal = 40; // logistic team already take action or entry restricted
			}
		} else {
			successVal = 0; // update not success
		}

		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("" + successVal);

	}

	// 3. update finance user details.
	private void updateFinancePoDetails(HttpServletRequest request, HttpServletResponse response, String empCode,
			String division) throws IOException, ServletException, SQLException {
		int successVal = 0;
		if (division.equalsIgnoreCase("FN")) {
			String id = request.getParameter("podf0");
			String status = request.getParameter("podf1");
			String remarks = request.getParameter("podf2");
			Logistic poDetails = new Logistic(id, status, remarks, empCode);
			successVal = logisticDashboardDbUtil.updatePODetailsByFinance(poDetails);
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("" + successVal);
		} else {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("" + successVal);
		}

	}

	// 4. update logistic user details.
	private void updateLogisticPoDetails(HttpServletRequest request, HttpServletResponse response, String empCode,
			String division, String logEmpName) throws IOException, ServletException, SQLException {
		int successVal = 0;
		if (division.equalsIgnoreCase("LG")) {
			String id = request.getParameter("podl0");
			String expTimeDeparture = request.getParameter("podl1");
			String expTimeArrival = request.getParameter("podl2");
			String remarks = request.getParameter("podl3");
			String reference = request.getParameter("podl4");
			String poNumber = request.getParameter("podl5");
			String divnEmpCode = request.getParameter("podl6");
			String divnEmpName = request.getParameter("podl7");
			String shipDocStatus = request.getParameter("podl8");
			String deliveryStatus = request.getParameter("podl9");
			Logistic poDetails = new Logistic(id, expTimeDeparture, expTimeArrival, remarks, empCode, reference,
					logEmpName, poNumber, divnEmpCode, divnEmpName, shipDocStatus, deliveryStatus);
			if (!divnEmpCode.isEmpty() && divnEmpCode != null && divnEmpCode != "" && divnEmpCode.length() == 7) {
				successVal = logisticDashboardDbUtil.updatePODetailsByLogistic(poDetails);
			}

			if (successVal == 1) {
				logisticDashboardDbUtil.sendMailToDivisionTeam(poDetails);
			}
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("" + successVal);
		} else {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("" + successVal);
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("/logistic/importPO.jsp");
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
