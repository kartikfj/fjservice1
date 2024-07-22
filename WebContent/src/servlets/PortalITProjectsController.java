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

import com.google.gson.Gson;

import beans.PortalITProjects;
import beans.fjtcouser;
import utils.PortalITProjectsDbUtil;

/**
 * Servlet implementation class PortalITProjectsController
 */
@WebServlet("/PortalITProjects")
public class PortalITProjectsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PortalITProjectsDbUtil portalITProjectsDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PortalITProjectsController() {
		super();
		portalITProjectsDbUtil = new PortalITProjectsDbUtil();
		// TODO Auto-generated constructor stub
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String emp_code = fjtuser.getEmp_code();

			String requestType = request.getParameter("action");

			if (requestType == null) {
				requestType = "task_dafult";
			}
			switch (requestType) {

			case "task_dafult":
				try {
					List<PortalITProjects> itReqLists = portalITProjectsDbUtil.displayDefaultItProjects();
					request.setAttribute("ITREQLIST", itReqLists);
					RequestDispatcher dispatcher = request.getRequestDispatcher("/newFeatureRequest.jsp");
					dispatcher.forward(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "export":
				try {
					List<PortalITProjects> itreqExports = portalITProjectsDbUtil.displayDefaultItProjects();
					response.setContentType("application/json");
					new Gson().toJson(itreqExports, response.getWriter());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "updatedbyit":
				try {
					portalITProjectsDbUtil.updateProjectRequestByIT();
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			default:
				try {// displayDefaultMonthTasks(request,response,emp_code,curr_year);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		}
	}

	/*
	 * private void displayDefaultItProjects(HttpServletRequest request,
	 * HttpServletResponse response, String empCode) throws IOException,
	 * ServletException, SQLException { int successVal = 0; if
	 * (!division.equalsIgnoreCase("FN") && !division.equalsIgnoreCase("LG")) {
	 * String id = request.getParameter("podd0"); int containers =
	 * Integer.parseInt(request.getParameter("podd1")); String exFactDate =
	 * request.getParameter("podd2"); String contact =
	 * request.getParameter("podd3"); String location =
	 * request.getParameter("podd4"); String remarks =
	 * request.getParameter("podd5");
	 * 
	 * String poNumber = request.getParameter("podd6"); String poDate =
	 * request.getParameter("podd7"); String supplier =
	 * request.getParameter("podd8"); String shipmentTerm =
	 * request.getParameter("podd9"); String shipmentMode =
	 * request.getParameter("podd10"); String finalDestination =
	 * request.getParameter("podd11");
	 * 
	 * int actionType = Integer.parseInt(request.getParameter("podd12")); String
	 * reExport = request.getParameter("podd13"); String reference =
	 * request.getParameter("podl4"); if (reExport.equalsIgnoreCase("true") &&
	 * reExport.length() == 4) { reExport = "Y"; } else { reExport = "N"; } if (id
	 * != null && exFactDate != null && contact != null && location != null &&
	 * !id.isEmpty() && !exFactDate.isEmpty() && !contact.isEmpty() &&
	 * !location.isEmpty()) { Logistic poDetails = new Logistic(id, shipmentTerm,
	 * shipmentMode, containers, exFactDate, contact, location, remarks, empCode,
	 * empName, poNumber, poDate, supplier, finalDestination, reExport); if
	 * (actionType == 0 || actionType == 1) { successVal =
	 * logisticDashboardDbUtil.updatePODetailsByDivision(poDetails); }
	 * 
	 * if (successVal == 1) {
	 * logisticDashboardDbUtil.sendmailToLogisticTeam(poDetails, emailId,
	 * actionType, reference); } } else { successVal = 40; // logistic team already
	 * take action or entry restricted } } else { successVal = 0; // update not
	 * success } response.setContentType("text/html;charset=UTF-8");
	 * response.getWriter().write("" + successVal); }
	 * 
	 * private void updateDivisionPoDetails(HttpServletRequest request,
	 * HttpServletResponse response, String empCode, String division, String
	 * emailId, String empName) throws IOException, ServletException, SQLException {
	 * int successVal = 0; if (!division.equalsIgnoreCase("FN") &&
	 * !division.equalsIgnoreCase("LG")) { String id =
	 * request.getParameter("podd0"); int containers =
	 * Integer.parseInt(request.getParameter("podd1")); String exFactDate =
	 * request.getParameter("podd2"); String contact =
	 * request.getParameter("podd3"); String location =
	 * request.getParameter("podd4"); String remarks =
	 * request.getParameter("podd5");
	 * 
	 * String poNumber = request.getParameter("podd6"); String poDate =
	 * request.getParameter("podd7"); String supplier =
	 * request.getParameter("podd8"); String shipmentTerm =
	 * request.getParameter("podd9"); String shipmentMode =
	 * request.getParameter("podd10"); String finalDestination =
	 * request.getParameter("podd11");
	 * 
	 * int actionType = Integer.parseInt(request.getParameter("podd12")); String
	 * reExport = request.getParameter("podd13"); String reference =
	 * request.getParameter("podl4"); if (reExport.equalsIgnoreCase("true") &&
	 * reExport.length() == 4) { reExport = "Y"; } else { reExport = "N"; } if (id
	 * != null && exFactDate != null && contact != null && location != null &&
	 * !id.isEmpty() && !exFactDate.isEmpty() && !contact.isEmpty() &&
	 * !location.isEmpty()) { Logistic poDetails = new Logistic(id, shipmentTerm,
	 * shipmentMode, containers, exFactDate, contact, location, remarks, empCode,
	 * empName, poNumber, poDate, supplier, finalDestination, reExport); if
	 * (actionType == 0 || actionType == 1) { successVal =
	 * logisticDashboardDbUtil.updatePODetailsByDivision(poDetails); }
	 * 
	 * if (successVal == 1) {
	 * logisticDashboardDbUtil.sendmailToLogisticTeam(poDetails, emailId,
	 * actionType, reference); } } else { successVal = 40; // logistic team already
	 * take action or entry restricted } } else { successVal = 0; // update not
	 * success } response.setContentType("text/html;charset=UTF-8");
	 * response.getWriter().write("" + successVal);
	 * 
	 * }
	 */

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
