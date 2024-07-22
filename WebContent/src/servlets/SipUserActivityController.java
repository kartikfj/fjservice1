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
import com.google.gson.JsonIOException;

import beans.SipJihvSummary;
import beans.SipUserActivity;
import beans.fjtcouser;
import utils.SipChartDbUtil;
import utils.SipUserActivityDbUtil;

/**
 * Servlet implementation class SipUserActivityController
 */
@WebServlet("/SipUserActivity")
public class SipUserActivityController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SipChartDbUtil sipChartDbUtil;

	private SipUserActivityDbUtil sipUserActivityDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		sipChartDbUtil = new SipChartDbUtil();
		sipUserActivityDbUtil = new SipUserActivityDbUtil();

	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String sales_eng_Emp_code = fjtuser.getEmp_code();
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {

			if (fjtuser.getSales_code().equals("MG001") || fjtuser.getSales_code().equals("MG002")) {
				// fetch the all sales engineers list if the user is raffel (MG001) or Azzam
				// (MG002)
				// List<SipJihvSummary> theSalesEngList =
				// sipChartDbUtil.getSalesEngListfor_Mg(sales_eng_Emp_code);
				List<SipJihvSummary> theSalesEngList = sipUserActivityDbUtil.getSalesEngListfor_Mg(sales_eng_Emp_code);
				request.setAttribute("SEngLst", theSalesEngList);
			} else {

				if (fjtuser.getSubordinatesDetails() > 0) {
					// DM USER + SALES CODE
					List<SipJihvSummary> theSalesEngList = sipUserActivityDbUtil
							.getSalesEngListfor_Dm(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				} else {
					// NORMAL SALES ENGINEER
					List<SipJihvSummary> theSalesEngList = sipUserActivityDbUtil
							.getSalesEngListfor_NormalSalesEgr(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				}

			}

		}

		String theDataFromHr = request.getParameter("octjf");
		if (theDataFromHr == null) {
			theDataFromHr = "salesChart_dafult";
		}

		switch (theDataFromHr) {

		case "salesChart_dafult":

			try {
				Calendar cal = Calendar.getInstance();
				int iMonth = cal.get(Calendar.MONTH) + 1;
				request.setAttribute("SLCTEDMTH", getMonthByMonthChar(iMonth));
				List<SipUserActivity> theActivityList = sipUserActivityDbUtil
						.getDeafultMonthUserActivity(sales_eng_Emp_code);
				request.setAttribute("DBUAH", theActivityList);// dashboard user activity history
				goToUserActivity(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "sltdauwm":// month wise user actvity details
			try {
				getMonthWiseUserACtivityDetails(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		default:// defaultly redirecting to jsp page
			try {
				goToUserActivity(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void getMonthWiseUserACtivityDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {

		String theEmpCode = request.getParameter("edoCpme");
		String iMonth = request.getParameter("htmcust");
		int custMonth = getMonthByMonthValue(iMonth);

		List<SipUserActivity> theUserActivityList = sipUserActivityDbUtil.getCustomeMonthUserActivity(theEmpCode,
				custMonth);
		response.setContentType("application/json");
		new Gson().toJson(theUserActivityList, response.getWriter());
	}

	private int getMonthByMonthValue(String iMonth) {

		int curr_month_val = 1;
		switch (iMonth) {
		case "Jan":
			curr_month_val = 1;
			break;
		case "Feb":
			curr_month_val = 2;
			break;
		case "Mar":
			curr_month_val = 3;
			break;
		case "Apr":
			curr_month_val = 4;
			break;
		case "May":
			curr_month_val = 5;
			break;
		case "Jun":
			curr_month_val = 6;
			break;
		case "Jul":
			curr_month_val = 7;
			break;
		case "Aug":
			curr_month_val = 8;
			break;
		case "Sep":
			curr_month_val = 9;
			break;
		case "Oct":
			curr_month_val = 10;
			break;
		case "Nov":
			curr_month_val = 11;
			break;
		case "Dec":
			curr_month_val = 12;
			break;
		default:
			curr_month_val = 1;
			break;
		}
		return curr_month_val;
	}

	private String getMonthByMonthChar(int iMonth) {
		String curr_month_name = "Jan";
		switch (iMonth) {
		case 1:
			curr_month_name = "Jan";
			break;
		case 2:
			curr_month_name = "Feb";
			break;
		case 3:
			curr_month_name = "Mar";
			break;
		case 4:
			curr_month_name = "Apr";
			break;
		case 5:
			curr_month_name = "May";
			break;
		case 6:
			curr_month_name = "Jun";
			break;
		case 7:
			curr_month_name = "Jul";
			break;
		case 8:
			curr_month_name = "Aug";
			break;
		case 9:
			curr_month_name = "Sep";
			break;
		case 10:
			curr_month_name = "Oct";
			break;
		case 11:
			curr_month_name = "Nov";
			break;
		case 12:
			curr_month_name = "Dec";
			break;

		}
		return curr_month_name;
	}

	private void goToUserActivity(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher;
		dispatcher = request.getRequestDispatcher("/sipUserActivity.jsp");
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
