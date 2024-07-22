package servlets;

import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.ArrayList;
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
import com.google.gson.reflect.TypeToken;

import beans.CustomerVisit;
import beans.DailyTask;
import beans.fjtcouser;
import utils.DailyTaskDbUtil;
import utils.SipChartDbUtil;

/**
 * Servlet implementation class CustomerVisitPlannerController
 */
@WebServlet("/CustomerVisitPlanner")
public class CustomerVisitPlannerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DailyTaskDbUtil dailyTaskDbUtil;
	private SipChartDbUtil sipChartDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomerVisitPlannerController() {
		super();
		dailyTaskDbUtil = new DailyTaskDbUtil();
		sipChartDbUtil = new SipChartDbUtil();
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
			String curr_year = Calendar.getInstance().get(Calendar.YEAR) + "";

			if (fjtuser.getSubordinatelist() != null) {
				List<DailyTask> theSubordinatesList = dailyTaskDbUtil.getSubordinatesDetails(emp_code);
				request.setAttribute("SUB_EMP_LIST", theSubordinatesList);
			}
			String theDataFromUsr = request.getParameter("fjtco");
			if (theDataFromUsr == null) {
				theDataFromUsr = "task_dafult";
			}

			switch (theDataFromUsr) {

			case "task_dafult":
				try {
					displayDefaultMonthTasks(request, response, emp_code, curr_year);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "gs2pdforrcv":// get stage 2 project details for regularisation and customer visit
				try {
					getProjectListForstCustVisitFollowUp(request, response, fjtuser.getEmp_code());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "tnveetrc":// create event or task

				try {
					String salesCode = null;

					if (fjtuser.getSales_code() != null) {
						salesCode = fjtuser.getSales_code();
					}
					createnewVisitPlanner(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "tnvetld":// create event or task

				try {

					// deleteTask(request,response,emp_code,curr_year);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "yampfltsncp":// new task list for selected month and year

				try {
					displaySelectedMonthCustomerVisits(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "tnveetdpu":// update event or task

				try {

					updateExistingCustomerVisitPlanner(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "itmarkvisited":// complete emplyees daily task report for single day
				try {
					int result = markCustomerVisitasVisited(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "remindersfortheday":// get stage 2 project details for regularisation and customer visit
				try {
					getRemindersFortheDay(request, response, fjtuser.getEmp_code());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					displayDefaultMonthTasks(request, response, emp_code, curr_year);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		}
	}

	private void displayDefaultMonthTasks(HttpServletRequest request, HttpServletResponse response, String emp_code,
			String curr_year) throws ServletException, IOException, SQLException {
		String sales_man_code = "";
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1;
		List<DailyTask> resultList = new ArrayList<DailyTask>();
		// List<DailyTask> thetaskList =
		// dailyTaskDbUtil.getEmployeeTaskforCurrentMonth(emp_code, curr_year, month);
		// resultList.addAll(thetaskList);

		DailyTask userSalesStatus = dailyTaskDbUtil.getSalesStausWithCode(emp_code);
		if (userSalesStatus.getSalesVisitStstus().equalsIgnoreCase("y") && userSalesStatus.getSalesCode() != null) {
			sales_man_code = userSalesStatus.getSalesCode();
			if (sales_man_code != null && sales_man_code != "") {
				resultList.addAll(
						dailyTaskDbUtil.getCustomerVisitPlannerDetails(curr_year, month, emp_code, sales_man_code));
			}

		}

		request.setAttribute("EMPTSKLIST", resultList);
		goToDailyTask(request, response);

	}

	private void goToDailyTask(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher("/customerVisitPlanner.jsp");
		dispatcher.forward(request, response);

	}

	private void getProjectListForstCustVisitFollowUp(HttpServletRequest request, HttpServletResponse response,
			String empCode) throws JsonIOException, IOException, SQLException, ServletException {

		List<CustomerVisit> details = sipChartDbUtil.getSalesEngineerStage2ProjectListForCustVisit(empCode);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());
	}

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

	private void updateExistingCustomerVisitPlanner(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {
		String taskId = request.getParameter("utd1");
		if (taskId == null) {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("Refresh the page, Then try to delete.");

		} else {
			String fromTime = request.getParameter("utd1");// update task type
			String endTime = request.getParameter("utd2");// update task description
			String descrptn = request.getParameter("utd3");// update task description
			String genProject = request.getParameter("utd4");// update task start time
			String sysId = request.getParameter("utd5");// update task description

			int sysid = 0; //

			if (sysId != null) {
				sysid = Integer.parseInt(sysId);
			}

			DailyTask task_Details = new DailyTask(fromTime, endTime, descrptn, genProject, sysid);

			int successVal = dailyTaskDbUtil.updateCustomerVisitPlannerDetails(task_Details);
			if (successVal == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("" + successVal);

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("" + successVal);

			}
		}

	}

	private int markCustomerVisitasVisited(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {
		String sysId = request.getParameter("utd1");
		int successVal = -2;

		if (sysId == null) {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("Refresh the page, Then try to delete.");

		} else {
			int systemId = Integer.parseInt(request.getParameter("utd1"));

			successVal = dailyTaskDbUtil.selectCustomerVisitPlannerDetails(systemId);
			if (successVal == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("" + successVal);
				return successVal;

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("" + successVal);
				return successVal;

			}
		}
		return successVal;

	}

	public int createnewVisitPlanner(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String custVstDetails = request.getParameter("utd1");
		Gson gson = new Gson();
		Type type = new TypeToken<List<CustomerVisit>>() {
		}.getType();
		List<CustomerVisit> visitList = gson.fromJson(custVstDetails, type);
		int visitCount = visitList.size();
		return 1;

	}

	private void displaySelectedMonthCustomerVisits(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		String sales_man_code = "";
		List<DailyTask> resultList = new ArrayList<DailyTask>();
		String emp_code = request.getParameter("td3");
		String curr_year = request.getParameter("td1");
		int month = Integer.parseInt(request.getParameter("td2"));
		DailyTask userSalesStatus = dailyTaskDbUtil.getSalesStausWithCode(emp_code);
		if (userSalesStatus.getSalesVisitStstus().equalsIgnoreCase("y") && userSalesStatus.getSalesCode() != null) {
			sales_man_code = userSalesStatus.getSalesCode();
			if (sales_man_code != null && sales_man_code != "") {
				resultList.addAll(
						dailyTaskDbUtil.getEmployeeCustVisitsCurrentMonth(curr_year, month, emp_code, sales_man_code));
			}
		}
		response.setContentType("application/json");
		new Gson().toJson(resultList, response.getWriter());
	}

	private void getRemindersFortheDay(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws JsonIOException, IOException, SQLException, ServletException {
		String theDate = request.getParameter("theDate");
		List<CustomerVisit> details = sipChartDbUtil.getRemindersFortheDay(empCode, theDate);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());
	}

}
