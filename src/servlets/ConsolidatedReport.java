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

import com.google.gson.Gson;

import beans.SipBooking;
import beans.SipDmListForManagementDashboard;
import beans.fjtcouser;
import utils.ConsolidatedReportDbUtil;
import utils.SipMainDivisionChartDbUtil;

/**
 * Servlet implementation class ConsolidatedReport
 */
@WebServlet("/ConsolidatedReport")
public class ConsolidatedReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ConsolidatedReportDbUtil consolidatedReportDbUtil;
	private SipMainDivisionChartDbUtil sipMainDivChartDbUtil;

	public ConsolidatedReport() {
		super();
		consolidatedReportDbUtil = new ConsolidatedReportDbUtil();
		sipMainDivChartDbUtil = new SipMainDivisionChartDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {
			String sales_eng_Emp_code = null;
			String dvCode = null;
			// ALL SALES ENGINEER
			String theDataFromHr = request.getParameter("fjtco");
			if (fjtuser.getRole().equalsIgnoreCase("mg") || fjtuser.getEmp_code().equalsIgnoreCase("E001977")) {
				getDMsListFormangmentDashboard(request, response);
				// goToSipMainDivision(request, response);
			}
			int iYear = 0;
			if (theDataFromHr == null) {
				theDataFromHr = "dueDafult";
				String year = request.getParameter("syear");
				sales_eng_Emp_code = request.getParameter("dmCode");
				dvCode = request.getParameter("divisionCode");
				if (year == null || year.isEmpty()) {
					Calendar cal = Calendar.getInstance();
					iYear = cal.get(Calendar.YEAR);
				} else {
					iYear = Integer.parseInt(year);
				}
				if (sales_eng_Emp_code == null || sales_eng_Emp_code.isEmpty()) {
					sales_eng_Emp_code = fjtuser.getEmp_code();
				}

			} else if (theDataFromHr.equals("dmfsltdmd")) {
				theDataFromHr = "dueDafult";
				String year = request.getParameter("syear");
				sales_eng_Emp_code = request.getParameter("dmCode");
				dvCode = request.getParameter("divisionCode");

				if (year == null || year.isEmpty()) {
					Calendar cal = Calendar.getInstance();
					iYear = cal.get(Calendar.YEAR);
				} else {
					iYear = Integer.parseInt(year);
				}
				if (sales_eng_Emp_code == null || sales_eng_Emp_code.isEmpty()) {
					sales_eng_Emp_code = fjtuser.getEmp_code();
				}

			} else if (theDataFromHr.equals("divisiondtls")) {
				theDataFromHr = "loadDivision";
				String year = request.getParameter("syear");
				sales_eng_Emp_code = request.getParameter("dmCode");
				dvCode = request.getParameter("divisionCode");

				if (year == null || year.isEmpty()) {
					Calendar cal = Calendar.getInstance();
					iYear = cal.get(Calendar.YEAR);
				} else {
					iYear = Integer.parseInt(year);
				}
				if (sales_eng_Emp_code == null || sales_eng_Emp_code.isEmpty()) {
					sales_eng_Emp_code = fjtuser.getEmp_code();
				}

			}
			request.setAttribute("DFLTDMCODE", sales_eng_Emp_code);
			request.setAttribute("DFLTDVCODE", dvCode);
			switch (theDataFromHr) {

			case "dueDafult":
				// getDefaultDivisionTitle(request, response, sales_eng_Emp_code);
				List<SipBooking> divisionList = getAllDivisionForUser(request, response, sales_eng_Emp_code);
				// if (divisionList.size() > 1) {
				for (SipBooking division : divisionList) {
					dvCode = division.getDivision();// getFinancialSummary(request, response, sales_eng_Emp_code,
													// iYear, division.get);
					break;
				}
				// }
				getFinancialSummary(request, response, sales_eng_Emp_code, iYear, dvCode);
				goToConsolidatedReport(request, response, iYear, dvCode);
				break;
			case "loadDivision":
				// getDefaultDivisionTitle(request, response, sales_eng_Emp_code);
				getAllDivisionForUser(request, response, sales_eng_Emp_code);
				getFinancialSummary(request, response, sales_eng_Emp_code, iYear, dvCode);
				goToConsolidatedReport(request, response, iYear, dvCode);
				break;
			case "getReqDet":
				getRequestedDetailsSummary(request, response, sales_eng_Emp_code);
				break;

			}
		}
	}

	private void getFinancialSummary(HttpServletRequest request, HttpServletResponse response, String theDmCode,
			int iYear, String dvCode) throws SQLException, IOException {
		// String theDmCode = request.getParameter("d2");

		List<SipBooking> wccapsummary = consolidatedReportDbUtil.workingCapitalSummary(theDmCode, iYear, dvCode);
		request.setAttribute("WCCAPSUM", wccapsummary);
		List<SipBooking> fbsummary = consolidatedReportDbUtil.fundsBlockedSummary(theDmCode, iYear, dvCode);
		request.setAttribute("FUNDSBLOCKEDSUM", fbsummary);
		List<SipBooking> financialPositionsummary = consolidatedReportDbUtil.financialPositionSummary(theDmCode, iYear,
				dvCode);
		request.setAttribute("FINPOSSUM", financialPositionsummary);
	}

	private void getDefaultDivisionTitle(HttpServletRequest request, HttpServletResponse response, String theDmCode)
			throws SQLException {
		// System.out.println("DM EMP CODE controller 4: "+theDmCode);
		String defaultDivision = sipMainDivChartDbUtil.getDeafultDivisionNameforDm(theDmCode);
		request.setAttribute("DIVDEFTITL", defaultDivision);// divTitle
	}

	private List<SipBooking> getAllDivisionForUser(HttpServletRequest request, HttpServletResponse response,
			String theDmCode) throws SQLException {
		System.out.println("getAllDivisionForUser " + theDmCode);
		List<SipBooking> divisions = consolidatedReportDbUtil.getAllDivisionsForUser(theDmCode);
		request.setAttribute("DIVLISTS", divisions);// divTitle
		return divisions;
	}

	private void getDMsListFormangmentDashboard(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		List<SipDmListForManagementDashboard> theDmsList = sipMainDivChartDbUtil.getDMListfor_Mg();
		request.setAttribute("DmsLstFMgmnt", theDmsList);

	}

	private void getRequestedDetailsSummary(HttpServletRequest request, HttpServletResponse response,
			String sales_Egr_Code) throws SQLException, ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser == null) {
			response.sendRedirect("logout.jsp");
		} else {
			int iYear = 0;

			String scat = request.getParameter("scat");
			String year = request.getParameter("syear");
			String theDmCode = request.getParameter("dmcode");
			if (year == null || year.isEmpty()) {
				Calendar cal = Calendar.getInstance();
				iYear = cal.get(Calendar.YEAR);
			} else {
				iYear = Integer.parseInt(year);
			}
			List<SipBooking> workingcapitalsummary = consolidatedReportDbUtil.getRequestedDetailsSummary(iYear, scat);
			response.setContentType("application/json");
			new Gson().toJson(workingcapitalsummary, response.getWriter());
		}

	}

	private void goToConsolidatedReport(HttpServletRequest request, HttpServletResponse response, int iYear,
			String dvCode) throws ServletException, IOException {
		request.setAttribute("selected_Year", iYear);
		request.setAttribute("selected_Division", dvCode);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/consolidatedReport.jsp");
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
