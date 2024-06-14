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

import beans.SalesManForecast;
import beans.SipJihvSummary;
import beans.fjtcouser;
import utils.SipChartDbUtil;

/**
 * Servlet implementation class SalesManForecastController
 */
@WebServlet("/SalesManForecast")
public class SalesManForecastController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipChartDbUtil sipChartDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SalesManForecastController() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init() throws ServletException {
		super.init();
		sipChartDbUtil = new SipChartDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String action = request.getParameter("fjtco");// sipChart.jsp and sipDmChart.jsp , both page form
		// submitting "fjtco" as keyword to handle the services
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {
			Calendar calendar = Calendar.getInstance();
			int weekNumber = calendar.get(Calendar.WEEK_OF_YEAR) + 1;
			String weekNo = Integer.toString(weekNumber);
			if (weekNumber < 10)
				weekNo = "0" + weekNo;
			System.out.println("weekNumber== " + weekNo);
			String sales_eng_Emp_code = fjtuser.getEmp_code();
			if (fjtuser.getRole().equalsIgnoreCase("mg")) {
				// managment
				List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesEngListfor_Mg(sales_eng_Emp_code);
				request.setAttribute("SEngLst", theSalesEngList);
			} else {

				if (fjtuser.getSalesDMYn() >= 1) { // SALES Division Manager OR NOT
					// DM USER + SALES CODE
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesEngListfor_Dm(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				} else {
					// NORMAL SALES ENGINEER
					List<SalesManForecast> theSalesEngList = sipChartDbUtil
							.getSalesEngListfor_NormalSalesEgrWithForecastDetails(sales_eng_Emp_code, weekNo);
					request.setAttribute("SEngLst", theSalesEngList);
				}

			}

			if (action == null) {
				action = "salesChart_dafult";
			}

			switch (action) {

			case "list":
				try {
					goToSalesmanForecast(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "saveSalesForecastDetails":

				try {
					String compCode = fjtuser.getEmp_com_code();
					String divnCode = fjtuser.getEmp_divn_code();
					updateSalesManForecastDetails(request, response, compCode, divnCode);

				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:// defaultly redirecting to jsp page
				try {
					goToSalesmanForecast(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	private void updateSalesManForecastDetails(HttpServletRequest request, HttpServletResponse response,
			String compCode, String divnCode) throws IOException, ServletException, SQLException {
		String theSalesEngCode = request.getParameter("podd0");
		String weekNo = request.getParameter("podd1");
		String s3Forecast = request.getParameter("podd2");
		String s4Forecast = request.getParameter("podd3");
		String s5Forecast = request.getParameter("podd4");
		int status = 0;
		System.out.println("forecast params == " + s3Forecast + " ," + s4Forecast + " ," + s5Forecast + " ,"
				+ theSalesEngCode + " ," + weekNo);
		String recordExists = sipChartDbUtil.checkIfRecordExists(theSalesEngCode, weekNo);
		if (recordExists.equalsIgnoreCase("Yes")) {
			status = sipChartDbUtil.updateSaleForecast(theSalesEngCode, weekNo, s3Forecast, s4Forecast, s5Forecast);
		} else {
			status = sipChartDbUtil.insertSaleForecast(theSalesEngCode, weekNo, s3Forecast, s4Forecast, s5Forecast,
					compCode, divnCode);
		}
		System.out.println("status== " + status);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("" + status);

	}

	private void goToSalesmanForecast(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		RequestDispatcher dispatcher;
		if (fjtuser.getSalesDMYn() >= 1 || fjtuser.getRole().equalsIgnoreCase("mg")) {
			dispatcher = request.getRequestDispatcher("/sipchartDm.jsp");
		} else {
			dispatcher = request.getRequestDispatcher("/salesmanForecast.jsp");
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
