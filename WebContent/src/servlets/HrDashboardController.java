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

import beans.HREmployeeSalary;
import beans.HrDashbaord;
import beans.HrDashbaordEmployeeCompleteDetails;
import beans.HrDashboardLeaveDetails;
import beans.HrDashboardLeaveHistory;
import beans.fjtcouser;
import utils.HrDashbaordDbUtil;

/**
 * Servlet implementation class HrDashboardController
 */
@WebServlet(name = "HrDashboard", urlPatterns = { "/HrDashboard" })
public class HrDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HrDashbaordDbUtil hrDashbaordDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HrDashboardController() {
		super();
		// TODO Auto-generated constructor stub
		hrDashbaordDbUtil = new HrDashbaordDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null || fjtuser.getEmp_code().length() < 7 || fjtuser.getEmp_code().length() > 7
				|| fjtuser.getEmp_code().isEmpty()) {
			response.sendRedirect("logout.jsp");
		} else if (!fjtuser.getRole().equalsIgnoreCase("hrmgr") && !fjtuser.getEmp_code().equalsIgnoreCase("E000001")
				&& !fjtuser.getEmp_code().equalsIgnoreCase("E000063")) {
			response.sendRedirect("homepage.jsp");
		} else {
			// String userRole = fjtuser.getRole();
			String empCode = "";
			String requestType = request.getParameter("action");
			String selectedUser = request.getParameter("selectedUser");
			if (selectedUser == null || selectedUser.isEmpty() || selectedUser.equalsIgnoreCase("")
					|| selectedUser.length() < 7 || selectedUser.length() > 7) {
				empCode = fjtuser.getEmp_code();
			} else {
				empCode = selectedUser;
			}
			if (requestType == null) {
				requestType = "def";
			}
			switch (requestType) {
			case "def":
				try {
					goToView(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "profile":
				try {
					getEmployeeProfile(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "leaveDtls":
				try {
					getEmployeeLeaveDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "leaveHistory":
				try {
					getEmployeeLeaveHistory(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "salaryRevision":
				try {
					getEmployeeSalaryRevisionHistory(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToView(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void goToView(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException {

		try {
			List<HrDashbaordEmployeeCompleteDetails> employeeCompleteDetails = hrDashbaordDbUtil
					.employeeCompleteDetails();
			request.setAttribute("COMPLTEMPDTLS", employeeCompleteDetails);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/hr/dashboard.jsp");
		dispatcher.forward(request, response);

	}

	private void getEmployeeProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String empCode = request.getParameter("hr0");
		HrDashbaord userProfile = hrDashbaordDbUtil.employeeUserProfile(empCode);
		response.setContentType("application/json");
		new Gson().toJson(userProfile, response.getWriter());
	}

	private void getEmployeeLeaveDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String empCode = request.getParameter("hr0");
		List<HrDashboardLeaveDetails> employeeLeaveDetails = hrDashbaordDbUtil.employeeleaveDetails(empCode);
		response.setContentType("application/json");
		new Gson().toJson(employeeLeaveDetails, response.getWriter());
	}

	private void getEmployeeLeaveHistory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String empCode = request.getParameter("hr0");

		List<HrDashboardLeaveHistory> employeeLeaveHistory = hrDashbaordDbUtil.employeeleaveHistory(empCode);
		response.setContentType("application/json");
		new Gson().toJson(employeeLeaveHistory, response.getWriter());
	}

	private void getEmployeeSalaryRevisionHistory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String empCode = request.getParameter("hr0");
		List<HREmployeeSalary> employeeSalaryHistory = hrDashbaordDbUtil.employeeSalaryHistory(empCode);
		response.setContentType("application/json");
		new Gson().toJson(employeeSalaryHistory, response.getWriter());
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
