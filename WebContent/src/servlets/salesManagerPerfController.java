package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.SalesmanPerformance;
import beans.SipJihvSummary;
import beans.SipOutRecvbleReprt;
import beans.fjtcouser;
import utils.SipChartDbUtil;

/**
 * Servlet implementation class salesManagerPerf
 */
@WebServlet("/salesManagerPerf")
public class salesManagerPerfController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipChartDbUtil sipChartDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public salesManagerPerfController() {
		super();
		sipChartDbUtil = new SipChartDbUtil();

		// TODO Auto-generated constructor stub
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String action = request.getParameter("fjtco");// sipChart.jsp and sipDmChart.jsp , both page form
		// submitting "fjtco" as keyword to handle the services
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {

			String sales_eng_Emp_code = fjtuser.getEmp_code();
			if (fjtuser.getRole().equalsIgnoreCase("mg")) {
				// managment
				List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesMgrsListfor_Mg(sales_eng_Emp_code);
				request.setAttribute("SEngLst", theSalesEngList);
			} else {

				if (fjtuser.getSalesDMYn() >= 1) { // SALES Division Manager OR NOT
					// DM USER + SALES CODE
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesMgrsListfor_Dm(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				} else {
					// NORMAL SALES ENGINEER
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil
							.getSalesEngListfor_SalesMgrs(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				}

			}

			if (action == null) {

				action = "salesChart_dafult";
			}

			switch (action) {

			case "list":
				try {
					goToSip(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "salesChart_dafult":

				try {
					String theSalesEngCode = fjtuser.getSales_code();
					getOustndngRcvbleReportforSEng(request, response, theSalesEngCode);
					goToSip(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "sm_perf":// Salesman Performance details
				try {
					getSmPerformanceData(request, response);
				} catch (Exception e) {
					e.printStackTrace();// TODO: handle exception
				}
				break;
			case "se_perf":// Salesman Performance details
				try {

					getSEPerformanceData(request, response);
				} catch (Exception e) {
					e.printStackTrace();// TODO: handle exception
				}
				break;
			default:// defaultly redirecting to jsp page
				try {
					goToSip(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	private void getOustndngRcvbleReportforSEng(HttpServletRequest request, HttpServletResponse response,
			String theSalesEngCode) throws SQLException {
		// this function for retreving sales oustanding recievable based on sales eng
		// code, aging wise
		List<SipOutRecvbleReprt> theReceivableList = sipChartDbUtil.getOutstandingRecievableforSaleEgr(theSalesEngCode);
		request.setAttribute("ORAR", theReceivableList);
	}

	private void getSmPerformanceData(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JsonIOException {
		// Salesman Performance details
		String smCode = request.getParameter("c1");
		// List<SipJihvSummary> theSalesEngList =
		// sipChartDbUtil.getSalesMgrsListfor_Dm(smCode);
		// request.setAttribute("SEngLst", theSalesEngList);
		Map<String, SalesmanPerformance> smMap = sipChartDbUtil.getSalesManagerPerformance(smCode);
		response.setContentType("application/json");
		new Gson().toJson(smMap, response.getWriter());
//		if (smMap.isEmpty()) {
//			System.out.println("in null condi");
//			new Gson().toJson(theSalesEngList, response.getWriter());
//		}
		// request.setAttribute("SM_MAP", smMap);

	}

	private void getSEPerformanceData(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JsonIOException {
		// Salesman Performance details
		String smCode = request.getParameter("c1");
		String segEmplCode = sipChartDbUtil.getEmployeeCodeBySalesCode(smCode);
		Map<String, SalesmanPerformance> smMap = sipChartDbUtil.getSalesEngineerPerformance(smCode, segEmplCode);
		response.setContentType("application/json");
		new Gson().toJson(smMap, response.getWriter());
		// request.setAttribute("SM_MAP", smMap);

	}

	private void goToSip(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		RequestDispatcher dispatcher;
		if (fjtuser.getSalesDMYn() >= 1 || fjtuser.getRole().equalsIgnoreCase("mg")) {
			dispatcher = request.getRequestDispatcher("/salesMagrPerf.jsp");
		} else {
			dispatcher = request.getRequestDispatcher("/salesMagrPerf.jsp");
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
