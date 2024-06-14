package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ConsultantLeads;
import beans.MktDashboard;
import beans.fjtcouser;
import utils.MktDashboardDbUtil;

/**
 * @author nufail.a Servlet implementation class Marketing Dashboard
 */

@WebServlet("/MktDashboard")
public class MktDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MktDashboardDbUtil mktDashboardDbUtil;

	public MktDashboardController() throws ServletException {
		super.init();
		mktDashboardDbUtil = new MktDashboardDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String userRole = fjtuser.getRole();
			String theDataFromHr = request.getParameter("fjtco");
			if (theDataFromHr == null) {
				theDataFromHr = "view";
			}
			switch (theDataFromHr) {
			case "view":
				try {
					goToDashboard(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "vSDiv":// viw single division details for managment
				try {
					getSingoleDivisionDetails(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToDashboard(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void getSingoleDivisionDetails(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws SQLException, ServletException, IOException {
		int currYear = Calendar.getInstance().get(Calendar.YEAR);
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String division = request.getParameter("divn");
		String fromDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");

		if (userRole.equals("mkt") || userRole.equals("mg")) {
			int year = Integer.parseInt(request.getParameter("year"));
			if (!request.getParameter("year").equals("") && request.getParameter("year") != null) {
				currYear = year;
			}
			List<ConsultantLeads> divisonList = mktDashboardDbUtil.getAllDivisionList();
			request.setAttribute("DLFCL", divisonList);
			request.setAttribute("selectedYear", currYear);
			request.setAttribute("selectedDiv", division);
			request.setAttribute("SFO", 1);// show filter option
			if (division.equals("All Division")) {
				request.setAttribute("DBT", "1");// dashboard user type
				List<MktDashboard> leadAnalysis = mktDashboardDbUtil
						.getCompleteDivisionCustDateSalesLeadAnalysis(fromDate, toDate);
				List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil
						.getCompleteDivisionYearlyGeneralDetails(currYear);
				request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
				request.setAttribute("SLDBANLYSIS", leadAnalysis);
			} else {
				request.setAttribute("DBT", "2");// dashboard user type
				List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil
						.getSingleDivisionYearlyGeneralDetails(currYear, division);
				request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
				List<MktDashboard> leadAnalysis = mktDashboardDbUtil
						.getSingleDivisionCustDateSalesLeadAnalysis(fromDate, toDate, division);
				request.setAttribute("SLDBANLYSIS", leadAnalysis);
			}
		} else if (fjtuser.getSubordinatesDetails() > 0 && !userRole.equals("mkt") && !userRole.equals("mg")) {
			String defaultDivision = mktDashboardDbUtil.getDefaultDivision(fjtuser.getEmp_divn_code());
			request.setAttribute("DBT", "2");// dashboard user type
			List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil.getSingleDivisionYearlyGeneralDetails(currYear,
					division);
			request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
			List<MktDashboard> leadAnalysis = mktDashboardDbUtil.getSingleDivisionCustDateSalesLeadAnalysis(fromDate,
					toDate, defaultDivision);
			request.setAttribute("SLDBANLYSIS", leadAnalysis);

		} else {
			String employeeCode = fjtuser.getEmp_code();
			request.setAttribute("DBT", "3");// dashboard type
			List<MktDashboard> leadAnalysis = mktDashboardDbUtil.getSingleEngineerCustDateSalesLeadAnalysis(fromDate,
					toDate, employeeCode);
			List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil.getSalesEngineerYearlyGeneralDetails(currYear,
					employeeCode);
			request.setAttribute("SLDBANLYSIS", leadAnalysis);
			request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
		}
		request.setAttribute("SFO", 1);// show filter option
		request.setAttribute("defaultStartDate", fromDate);
		request.setAttribute("defaultEndDate", toDate);
		request.setAttribute("selectedYear", currYear);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/dashboard.jsp");
		dispatcher.forward(request, response);

	}

	private void goToDashboard(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws SQLException, ServletException, IOException {
		String startDate, toDate;
		int currYear = Calendar.getInstance().get(Calendar.YEAR);
		int currMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
		int currDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		if (currMonth < 10) {
			startDate = "01-01-" + currYear;
			toDate = currDay + "-0" + currMonth + "-" + currYear;
		} else {
			startDate = "01-01-" + currYear;
			toDate = currDay + "-" + currMonth + "-" + currYear;
		}
		// System.out.println("start : "+startDate+" end : "+toDate);
		// List<ConsultantLeads> divisonList=marketingLeadsDbUtil.getAllDivisionList();
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		int sfoValue = 0;
		if (userRole.equals("mkt") || userRole.equals("mg")) {
			sfoValue = 1;
			List<ConsultantLeads> divisonList = mktDashboardDbUtil.getAllDivisionList();
			request.setAttribute("DBT", "1");// dashboard type
			request.setAttribute("DLFCL", divisonList);

			List<MktDashboard> leadAnalysis = mktDashboardDbUtil.getCompleteDivisionCustDateSalesLeadAnalysis(startDate,
					toDate);
			List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil
					.getCompleteDivisionYearlyGeneralDetails(currYear);
			request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
			request.setAttribute("SLDBANLYSIS", leadAnalysis);
			request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
		} else if (fjtuser.getSubordinatesDetails() > 0 && !userRole.equals("mkt") && !userRole.equals("mg")) {
			sfoValue = 1;
			String defaultDivision = mktDashboardDbUtil.getDefaultDivision(fjtuser.getEmp_divn_code());
			request.setAttribute("DBT", "2");// dashboard type
			List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil.getSingleDivisionYearlyGeneralDetails(currYear,
					defaultDivision);
			List<MktDashboard> leadAnalysis = mktDashboardDbUtil.getSingleDivisionCustDateSalesLeadAnalysis(startDate,
					toDate, defaultDivision);
			request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
			request.setAttribute("SLDBANLYSIS", leadAnalysis);
		} else {
			sfoValue = 1;
			String employeeCode = fjtuser.getEmp_code();
			request.setAttribute("DBT", "3");// dashboard type
			List<MktDashboard> leadAnalysis = mktDashboardDbUtil.getSingleEngineerCustDateSalesLeadAnalysis(startDate,
					toDate, employeeCode);
			List<MktDashboard> uniqueLeadAnalysis = mktDashboardDbUtil.getSalesEngineerYearlyGeneralDetails(currYear,
					employeeCode);
			request.setAttribute("SLDBANLYSIS", leadAnalysis);
			request.setAttribute("totalUnqLdCount", uniqueLeadAnalysis);
		}

		request.setAttribute("selectedYear", currYear);
		request.setAttribute("defaultStartDate", startDate);
		request.setAttribute("defaultEndDate", toDate);
		request.setAttribute("SFO", sfoValue);// show filter option
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/dashboard.jsp");
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
