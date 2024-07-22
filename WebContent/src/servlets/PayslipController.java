package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Payslip;
import beans.fjtcouser;
import utils.PayslipDbUtil;

/**
 * Servlet implementation class PayslipController
 */
@WebServlet("/Payslip")
public class PayslipController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private PayslipDbUtil payslipDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		payslipDbUtil = new PayslipDbUtil();

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
					getDefaultPayslipReport(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "cust":

				try {
					goToDisplayCustReport(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:

				try {
					goToPayslipPage(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

	}

	private void goToDisplayCustReport(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {

		int month = Integer.parseInt(request.getParameter("smonth"));
		String year = request.getParameter("syear");
		String fpMonth = year + getMonthCorrect(month);
		List<Payslip> thePayslip = payslipDbUtil.getCustomPayslipReportData(empCode, fpMonth);
		String companyName = payslipDbUtil.getCompanyName(empCode, fpMonth);
		request.setAttribute("PAYSLIP", thePayslip);
		request.setAttribute("companyName", companyName);
		if (thePayslip != null) {
			request.setAttribute("NETPAY", getTotalNetPay(thePayslip));
			request.setAttribute("selectedMonth", month);
			request.setAttribute("selectedYr", year);
			request.setAttribute("monthName", new DateFormatSymbols().getMonths()[month - 1]);
		} else {
			request.setAttribute("NETPAY", 0);
			request.setAttribute("selectedMonth", month);
			request.setAttribute("selectedYr", year);
			request.setAttribute("monthName", new DateFormatSymbols().getMonths()[month - 1]);

		}
		goToPayslipPage(request, response);

	}

	private String getMonthCorrect(int month) {
		String monthString = "";
		if (month < 10) {
			monthString = "0" + month;
		} else {
			monthString = "" + month;
		}
		return monthString;

	}

	private void getDefaultPayslipReport(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH);
		int year = cal.get(Calendar.YEAR);
		if (month == 0) {
			month = 11;
			year = year - 1;
		}
		String fpMonth = year + getMonthCorrect(month);
		List<Payslip> thePayslip = payslipDbUtil.getDefaultPayslipReportData(empCode, fpMonth);
		String companyName = payslipDbUtil.getCompanyName(empCode, fpMonth);
		request.setAttribute("PAYSLIP", thePayslip);
		request.setAttribute("companyName", companyName);
		if (thePayslip != null) {
			request.setAttribute("NETPAY", getTotalNetPay(thePayslip));
			request.setAttribute("monthName", new DateFormatSymbols().getMonths()[month - 1]);
		} else {
			request.setAttribute("NETPAY", 0);
			request.setAttribute("monthName", new DateFormatSymbols().getMonths()[month - 1]);

		}
		request.setAttribute("selectedMonth", month);
		request.setAttribute("selectedYr", year);
		goToPayslipPage(request, response);
	}

	private double getTotalNetPay(List<Payslip> thePayslip) {
		double sum = 0;
		Iterator<Payslip> itr = thePayslip.iterator();
		while (itr.hasNext()) {
			Payslip payList = (Payslip) itr.next();
			sum += payList.getAmount();
		}
		return sum;

	}

	private void goToPayslipPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/payslip.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PayslipController() {
		super();
		// TODO Auto-generated constructor stub
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
