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

import beans.SipWeeklyReport;
import beans.fjtcouser;
import utils.SipChartDbUtil;
import utils.SipWeeklyReportDbUtil;

/**
 * Servlet implementation class sip.. its for handling sales engineer sales
 * performance for both sales engineer login and dm login
 */
@WebServlet("/sipWeeklyReport")
public class SipWeeklyReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SipWeeklyReportDbUtil sipWeeklyReportDbUtil;
	private SipChartDbUtil sipChartDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		sipWeeklyReportDbUtil = new SipWeeklyReportDbUtil();
		sipChartDbUtil = new SipChartDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {
			String emp_code = fjtuser.getEmp_code();
			String theDataFromHr = request.getParameter("action");
			if (theDataFromHr == null) {
				theDataFromHr = "list";
			}
			switch (theDataFromHr) {

			case "list":
				try {
					goToDefaultView(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "DV":
				try {
					if (fjtuser.getRole().equalsIgnoreCase("mg")) {
						getYTDWeeklySalesReportForMG(request, response);

					} else {

						if (fjtuser.getSalesDMYn() == 1) {
							getYTDWeeklySalesReportForDM(request, response, emp_code);
						} else {
							// NORMAL SALES ENGINEER
							getYTDWeeklySalesReportForSEG(request, response, emp_code);

						}

					}
					goToView(request, response);
				} catch (Exception e) {

				}
				break;
			case "SE":
				try {
					String salesman_code = fjtuser.getSales_code();
					if (fjtuser.getRole().equalsIgnoreCase("mg")) {
						getYTDWeeklySalesReportForMG(request, response, salesman_code);
					} else {

						if (fjtuser.getSalesDMYn() >= 1) { // SALES Division Manager OR NOT
							// DM USER + SALES CODE
							getYTDWeeklySalesReportForDMs(request, response, emp_code);
						} else {
							// NORMAL SALES ENGINEER
							// List<SipJihvSummary> theSalesEngList = sipChartDbUtil
							// .getSalesEngListfor_NormalSalesEgr(emp_code);
							// request.setAttribute("SEngLst", theSalesEngList);
							getYTDWeeklySalesReportForSEG(request, response, emp_code);
						}

					}
					goToSegView(request, response);
				} catch (Exception e) {

				}
				break;
			default:
				try {
					goToView(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

	}

	private void getYTDWeeklySalesReportForMG(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		List<SipWeeklyReport> theReport = sipWeeklyReportDbUtil.getWeeklyReportForMg();
		request.setAttribute("YTDSWR", theReport); // Year to date sales weekly report
		request.setAttribute("defCategory", 1); // TO UDERSTANT Salesman wise or Division wise analysyy, if 1- division
												// , 2- seg
		// goToView(request, response);
	}

	private void getYTDWeeklySalesReportForDM(HttpServletRequest request, HttpServletResponse response, String emp_code)
			throws SQLException, ServletException, IOException {
		List<SipWeeklyReport> theReport = sipWeeklyReportDbUtil.getWeeklyReportForDM(emp_code);
		request.setAttribute("YTDSWR", theReport); // Year to date sales weekly report
		request.setAttribute("defCategory", 1); // TO UDERSTANT Salesman wise or Division wise analysyy, if 1- division
												// , 2- seg
		// goToView(request, response);
	}

	private void getYTDWeeklySalesReportForSEG(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws SQLException, ServletException, IOException {

		// List<SipJihvSummary> theSalesEngList =
		// sipChartDbUtil.getSalesEngListfor_NormalSalesEgr(smCode);
		// request.setAttribute("SEngLst", theSalesEngList);
		List<SipWeeklyReport> theReport = sipWeeklyReportDbUtil.getWeeklyReportForSalesEngineer(empCode);
		request.setAttribute("YTDSWR", theReport); // Year to date sales weekly report
		request.setAttribute("defCategory", 2); // TO UDERSTANT Salesman wise or Division wise analysyy, if 1- division
												// , 2- seg
		// goToView(request, response);
	}

	private void getYTDWeeklySalesReportForDMs(HttpServletRequest request, HttpServletResponse response, String smCode)
			throws SQLException, ServletException, IOException {

		// List<SipJihvSummary> theSalesEngList =
		// sipChartDbUtil.getSalesEngListfor_NormalSalesEgr(smCode);
		// request.setAttribute("SEngLst", theSalesEngList);
		List<SipWeeklyReport> theReport = sipWeeklyReportDbUtil.getWeeklyReportForSalesEngineerForDMs(smCode);
		request.setAttribute("YTDSWR", theReport); // Year to date sales weekly report
		request.setAttribute("defCategory", 2); // TO UDERSTANT Salesman wise or Division wise analysyy, if 1- division
												// , 2- seg
		// goToView(request, response);
	}

	private void getYTDWeeklySalesReportForMG(HttpServletRequest request, HttpServletResponse response, String smCode)
			throws SQLException, ServletException, IOException {

		// List<SipJihvSummary> theSalesEngList =
		// sipChartDbUtil.getSalesEngListfor_NormalSalesEgr(smCode);
		// request.setAttribute("SEngLst", theSalesEngList);
		List<SipWeeklyReport> theReport = sipWeeklyReportDbUtil.getWeeklyReportForSalesEngineerForManagement(smCode);
		request.setAttribute("YTDSWR", theReport); // Year to date sales weekly report
		request.setAttribute("defCategory", 2); // TO UDERSTANT Salesman wise or Division wise analysyy, if 1- division
												// , 2- seg
		// goToView(request, response);
	}

	private void goToSegView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		RequestDispatcher dispatcher;
		if (fjtuser.getSalesDMYn() >= 1 || fjtuser.getRole().equalsIgnoreCase("mg")) {
			dispatcher = request.getRequestDispatcher("/sales/weeklyReportForSeg.jsp");
		} else {
			dispatcher = request.getRequestDispatcher("/sales/weeklyReport.jsp");
		}
		dispatcher.forward(request, response);

	}

	private void goToDefaultView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sales/weeklyReportHomePage.jsp");
		dispatcher.forward(request, response);

	}

	private void goToView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		RequestDispatcher dispatcher;
		if (fjtuser.getSubordinatesDetails() > 0) {
			dispatcher = request.getRequestDispatcher("/sales/weeklyReport.jsp");
		} else {
			dispatcher = request.getRequestDispatcher("/sales/weeklyReport.jsp");
		}
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
