package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.HrLeaveCancellation;
import beans.fjtcouser;
import utils.HrLeaveCancellationDbUtil;

/**
 * Servlet implementation class HrLeaveCancellationController
 */
@WebServlet("/LeaveCancellation")
public class HrLeaveCancellationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private HrLeaveCancellationDbUtil hrLeaveCancellationDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HrLeaveCancellationController() {
		super();
		// TODO Auto-generated constructor stub
		hrLeaveCancellationDbUtil = new HrLeaveCancellationDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null
				|| !(fjtuser.getRole().equalsIgnoreCase("hr") || fjtuser.getRole().equalsIgnoreCase("hrmgr"))) {
			System.out.println("FAILED " + fjtuser.getEmp_code() + " role: " + fjtuser.getRole());
			response.sendRedirect("logout.jsp");
		} else {
			System.out.println("PASS " + fjtuser.getEmp_code() + " role: " + fjtuser.getRole());
			String theDataFromHr = request.getParameter("action");
			if (theDataFromHr == null) {
				theDataFromHr = "view";
			}
			switch (theDataFromHr) {
			case "view":
				try {
					goToView(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "getLeaveDetails":
				try {
					getDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "delete":
				try {
					deleteLeaveTxn(request, response, fjtuser.getEmp_code());
				} catch (Exception e) {
					e.printStackTrace();
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

	private void deleteLeaveTxn(HttpServletRequest request, HttpServletResponse response, String hrEmpCode)
			throws SQLException, ParseException, ServletException, IOException {
		int orclDeleteStatus = 0;
		int mysqlDeleteStatus = 0;
		String empCode = request.getParameter("empCode");
		String startdt = request.getParameter("strtDt");
		String enddt = request.getParameter("toDt");
		String mysqlId = request.getParameter("id_my_01");
		String leaveType = request.getParameter("lvType");
		String fjportalId = request.getParameter("id_fj_02");
		String payrollId = request.getParameter("id_pr_03");

		String leaveCategory = request.getParameter("lvCatg");
		String reason = request.getParameter("reason");
		System.out.println("mysqlId==" + mysqlId + "fjportalId==" + fjportalId + "payrollId===" + payrollId);
		int lvType = Integer.parseInt(leaveType);
		if (lvType == 1) {
			orclDeleteStatus = hrLeaveCancellationDbUtil.deleteOrclLeaveDeatilsLWP(fjportalId, payrollId);
		} else if (lvType == 2) {
			System.out.println("lvType==" + lvType);
			orclDeleteStatus = hrLeaveCancellationDbUtil.deleteOrclLeaveDeatilsNonLWP(fjportalId, payrollId);
		} else {
			request.setAttribute("MSG",
					"<b style=\"color:#ff5722;\" >Something went wrong!, Please try gain later</b>");
		}

		System.out.println("ORCL DB DELETE FINAL STATUS = " + orclDeleteStatus);
		if (orclDeleteStatus == 2) {
			HrLeaveCancellation leaveDetails = new HrLeaveCancellation(empCode, leaveCategory, reason, startdt, enddt);
			mysqlDeleteStatus = hrLeaveCancellationDbUtil.deleteMysqlLeaveDetails(hrEmpCode, mysqlId, fjportalId,
					payrollId, leaveDetails);
			System.out.println("Mysql delete status = " + mysqlDeleteStatus);
		}

		if (orclDeleteStatus == 2 && mysqlDeleteStatus == 2) {
			request.setAttribute("MSG", "<b style=\"color:green;\" >Deleted leave details for  Employee : " + empCode
					+ " & Leave date : " + startdt + " - " + enddt + " successfully. </b>");
		} else {
			request.setAttribute("MSG",
					"<b style=\"color:#ff5722;\" >Something went wrong!, Please try gain later</b>");
		}

		goToView(request, response);
	}

	private void getDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException, ParseException {
		String empCode = request.getParameter("empCode");
		String startdt = request.getParameter("fromdate");
		String enddt = request.getParameter("todate");
		int lvType = Integer.parseInt(request.getParameter("leaveCat"));
		int fjportalDataStatus = 0;
		int payrollDataStstus = 0;
		// System.out.println("LEAVE TYPE : "+lvType);
		if (lvType == 1) {
			fjportalDataStatus = hrLeaveCancellationDbUtil.checkFjPortalLwpLeaveAvailability(empCode, startdt, enddt);// check
																														// the
																														// particular
																														// LWP
																														// leave
																														// available
																														// in
																														// FJPORTAL
																														// instance
			payrollDataStstus = hrLeaveCancellationDbUtil.checkPayrollLwpLeaveAvailability(empCode, startdt, enddt);// check
																													// the
																													// particular
																													// LWP
																													// leave
																													// available
																													// in
																													// PAYROLL
																													// instance
			// System.out.println("RESULT LWP FJPrtl = "+fjportalDataStatus+" : Payrl =
			// "+payrollDataStstus);
		} else if (lvType == 2) {
			fjportalDataStatus = hrLeaveCancellationDbUtil.checkFjPortalNonLwpLeaveAvailability(empCode, startdt,
					enddt);// check the particular non LWP leave available in FJPORTAL instance
			payrollDataStstus = hrLeaveCancellationDbUtil.checkPayrollNonLwpLeaveAvailability(empCode, startdt, enddt);// check
																														// the
																														// particular
																														// non
																														// LWP
																														// leave
																														// available
																														// in
																														// PAYROLL
																														// instance
			// System.out.println("RESULT NON LWP FJPrtl = "+fjportalDataStatus+" : Payrl =
			// "+payrollDataStstus);
		} else {
			request.setAttribute("MSG", "<b style=\"color:#ff5722;\" >Please select proper leave type\"</b>");
		}

		if (fjportalDataStatus == 1 && payrollDataStstus == 1) {
			request.setAttribute("typ", lvType);
			request.setAttribute("dateStart", startdt);
			request.setAttribute("dateTo", enddt);
			request.setAttribute("empCd", empCode);
			List<HrLeaveCancellation> leaveList = hrLeaveCancellationDbUtil.checkLeavDetailsAvailableOrNot(startdt,
					enddt, empCode);

			System.out.println("FJPORTL ID " + hrLeaveCancellationDbUtil.getFjportalId());
			System.out.println("PAYROLL ID " + hrLeaveCancellationDbUtil.getPayrollId());
			System.out.println("MYSQL ID " + hrLeaveCancellationDbUtil.getMysqlPrlId());

			request.setAttribute("dijf", hrLeaveCancellationDbUtil.getFjportalId());// orion fjportal instance leave id
			request.setAttribute("dirp", hrLeaveCancellationDbUtil.getPayrollId());// orion payroll leave id
			request.setAttribute("dipym", hrLeaveCancellationDbUtil.getMysqlPrlId());// fj portal mysql id
			request.setAttribute("LV_DTLS", leaveList);
		} else {

			request.setAttribute("MSG", "<b style=\"color:blue;\" >No leave data in ORION for Employee : " + empCode
					+ "  & Leave date :  " + startdt + " - " + enddt + "</b>");
		}

		goToView(request, response);

	}

	private void goToView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher("/leavecancellation.jsp");
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
