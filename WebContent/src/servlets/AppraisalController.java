package servlets;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Achievements;
import beans.Appraisal;
import beans.Appraisal_Email_Status;
import beans.Approver;
import beans.Overview;
import beans.fjtcouser;
import utils.AppraisalDbUtil;
import utils.ApproverDbUtil;
import utils.EmailConfigDbUtil;

/**
 * Servlet implementation class AppraisalController
 */
@WebServlet("/AppraisalForm.jsp")
public class AppraisalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// create a reference to appraisal self appraisal db util class
	private AppraisalDbUtil appraisalDbUtil;
	private ApproverDbUtil approverDbUtil;
	private EmailConfigDbUtil emailConfigDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		appraisalDbUtil = new AppraisalDbUtil();
		approverDbUtil = new ApproverDbUtil();
		emailConfigDbUtil = new EmailConfigDbUtil();
		try {
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		request.setCharacterEncoding("UTF-8"); // this for character encoding , handle special characters
		response.setCharacterEncoding("UTF-8");// this for character encoding , handle special characters
		fjtcouser emp_id = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (emp_id.getEmp_code() == null || emp_id.getEmp_code().isEmpty()) {
			response.sendRedirect("logout.jsp");
		} else {

			String emp_com_code = emp_id.getEmp_code();

			request.setAttribute("EMP_PROFILE", appraisalDbUtil.getUserProfileDetails(emp_com_code));

			List<Approver> theYearList = approverDbUtil.getYear();
			request.setAttribute("SUB_DATE_LIST", theYearList);
			String year = Calendar.getInstance().get(Calendar.YEAR) + "";
			String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
			if (request.getParameter("syr") != null) {
				year = request.getParameter("syr");

				if (Integer.parseInt(year) > Integer.parseInt(currYear)) {
					request.setAttribute("GSY", "YES");// check the goal setting year is higher than current year or not
				} else {
					request.setAttribute("GSY", "NO");
				}

				request.setAttribute("curr", appraisalDbUtil.getGoalSettingDate(year + "", emp_com_code));
				request.setAttribute("mid", appraisalDbUtil.getMidTermDate(year + "", emp_com_code));
				request.setAttribute("fin", appraisalDbUtil.getFinalTermDate(year + "", emp_com_code));
				request.setAttribute("approved_details",
						appraisalDbUtil.getUserApprovedDetails(year + "", emp_com_code));
				request.setAttribute("prvs_completed_appraisal_report",
						appraisalDbUtil.getPrvsAppraisalRprt(year + "", emp_com_code));

			}

			// System.out.println("dates
			// current="+appraisalDbUtil.getGoalSettingDate("2018", emp_com_code));
		}
		// System.out.println(request.getAttribute("fjtcouser"));

		String theDataFromHr = request.getParameter("fjtco");

		// System.out.println(emp_id+"fjtco = "+theDataFromHr);

		// after reading the parameter route to appropriate method
		if (theDataFromHr == null) {
			theDataFromHr = "list";

		}

		switch (theDataFromHr) {
		case "list":
			// start goal setting for each company
			try {
				// System.out.println("before list");
				listGoals(request, response);// previously this is mail function
				// goToSelfAppraisal(request,response);
				// System.out.println("after list");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "sendMail":
			// start goal setting for each company
			try {
				// System.out.println("before list");
				sendMail(request, response);
				// System.out.println("sennnnn");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "AD":// add goal
			try {
				// System.out.println("before add goal");

				createFtemGoals(request, response);
				// System.out.println("after add goal");
			} catch (Exception e) {
				e.printStackTrace();
			}

			break;

		case "t2":// delete goal
			// System.out.println(theDataFromHr+"delete");
			try {
				deleteGoal(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "da0":// delete achievment
			// System.out.println(theDataFromHr+"delete");
			try {
				deleteAchievements(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "final":
			// update , based on row , company and emp_id
			// System.out.println(theDataFromHr);
			try {// updateFinalTerm(request,response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "UPDATE":
			// update , based on row , company and emp_id
			// System.out.println(theDataFromHr);
			try {
				modifyGoals(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "uachv":// update submit button name finau

			// System.out.println(theDataFromHr);
			try {
				updateAchievment(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "mpau":// update submit button name finau

			// System.out.println(theDataFromHr);
			try {
				updateMidProgAppr(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "finau":// update submit button name

			// System.out.println(theDataFromHr);
			try {
				updateFinProgAppr(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "ACH":// add goal
			try {
				// System.out.println("before add achievement");
				createAchievements(request, response);
				// System.out.println("after add achievement");
			} catch (Exception e) {
				e.printStackTrace();
			}

			break;
		default:
			// System.out.println(theDataFromHr);
			try {// goToAppraisal(request,response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void sendMail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// System.out.println("send mail");
		String submit_type = request.getParameter("submit_type");
		// System.out.println("submit type: "+submit_type);
		String emp_code = request.getParameter("sm_emp_id");
		String emp_div = request.getParameter("sm_div");
		String emp_dept = request.getParameter("sm_dept");
		String emp_name = request.getParameter("sm_ename");
		String appr_mail_id = request.getParameter("sm_apr_mail");
		String company = request.getParameter("sm_campany");
		String emp_location = request.getParameter("sm_location");
		String emp_job_title = request.getParameter("sm_job_ttl");
		String year = request.getParameter("sm_year");

		switch (submit_type) {

		case "gs":
			// System.out.println("submit type: checking"+submit_type);
			Appraisal_Email_Status mail_Details = new Appraisal_Email_Status(emp_code, year, company, emp_name);

			String gsEndDt = emailConfigDbUtil.checkGoalSettingEnddate(year, company);
			// System.out.println("goal setng end date cntrler"+gsEndDt);
			if (emailConfigDbUtil.check_count(mail_Details) == 0) {

				if (emailConfigDbUtil.submitGsMail(mail_Details, appr_mail_id, emp_name, emp_div, emp_dept,
						emp_location, emp_job_title, gsEndDt) == 1) {
					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
							+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
							+ "			    <strong>Success!</strong> Mail Sent to Approver Successfully. </div>");

				} else {
					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
							+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
							+ "			    <strong>Error!</strong> Error in processing. Try Later. </div>");

				}

			} else {
				int chV = 0;
				chV = emailConfigDbUtil.updateSubmitGsMail(mail_Details, appr_mail_id, emp_name, emp_div, emp_dept,
						emp_location, emp_job_title, gsEndDt);
				if (chV == 1) {

					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
							+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
							+ "			    <strong>Success!</strong> Mail Sent to Approver Successfully. </div>");

				} else {
					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
							+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
							+ "			    <strong>Error!</strong> Error in processing. Try Later. </div>");

				}

			}
			break;
		case "mid":
			// System.out.println("submit type: checking"+submit_type);
			Appraisal_Email_Status mail_Details1 = new Appraisal_Email_Status(emp_code, year, company);
			String midEndDt = emailConfigDbUtil.midTermEnddate(year, company);
			if (emailConfigDbUtil.submitMidMail(mail_Details1, appr_mail_id, emp_name, emp_div, emp_dept, emp_location,
					emp_job_title, midEndDt) == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Success!</strong> Mail Sent to Approver Successfully. </div>");

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Error!</strong> Error in processing. Try Later. </div>");

			}
			break;
		case "fin":
			// System.out.println("submit type: checking"+submit_type);
			Appraisal_Email_Status mail_Details2 = new Appraisal_Email_Status(emp_code, year, company);
			String finEndDt = emailConfigDbUtil.finalTermEnddate(year, company);
			if (emailConfigDbUtil.submitFinMail(mail_Details2, appr_mail_id, emp_name, emp_div, emp_dept, emp_location,
					emp_job_title, finEndDt) == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Success!</strong> Mail Sent to Approver Successfully. </div>");

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Error!</strong> Error in processing. Try Later. </div>");

			}
			break;
		default:
			try {
				goToSelfAppraisal(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void updateAchievment(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int achvmnt_id = Integer.parseInt(request.getParameter("ua2"));
		String achv_data = request.getParameter("ua1");
		// System.out.println("achievment update"+achvmnt_id+" "+achv_data);

		Achievements editAchievements = new Achievements(achvmnt_id, achv_data);
		appraisalDbUtil.updateAchvmtDb(editAchievements);

		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Achievment Updated Successfully.\r\n" + "</div> ");
		listGoals(request, response);

	}

	private void createAchievements(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String achievement = request.getParameter("achvt");

		// System.out.println("Achievement text "+achievement);

		int year = Calendar.getInstance().get(Calendar.YEAR);
		String year1 = request.getParameter("sat3");
		if (year1 == null || year1.isEmpty()) {

			year = Calendar.getInstance().get(Calendar.YEAR);

		} else {
			year = Integer.parseInt(year1);

		}
		String emp_id = request.getParameter("sat1");
		String approver_id = request.getParameter("sat2");

		Achievements theAchievementData = new Achievements(0, year, emp_id, approver_id, achievement);

		// check for the first term appraisal for row before insertion
		if (appraisalDbUtil.checkAchievementCount(theAchievementData) >= 3) {

			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-info\">\r\n"
					+ "  <strong>Info!</strong> You exceeded Maximum number of Achievements for this Year " + year
					+ ". Please Edit / Update or Delete Excisting Achievments to continue\r\n" + "</div> ");
			request.setAttribute("ACHV_COUNT", appraisalDbUtil.checkAchievementCount(theAchievementData));

			List<Achievements> employeeGoals = appraisalDbUtil.getEmployeeAchievements(emp_id, year + "");
			request.setAttribute("ACHV", employeeGoals);

		} else {
			appraisalDbUtil.insertAchievements(theAchievementData);
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
					+ "  <strong>Success!</strong> Created New Achievement Successfully.\r\n" + "</div> ");
			request.setAttribute("ACHV", appraisalDbUtil.checkAchievementCount(theAchievementData));

			List<Achievements> employeeGoals = appraisalDbUtil.getEmployeeAchievements(emp_id, year + "");
			request.setAttribute("ACHV", employeeGoals);
		}

		listGoals(request, response);

	}

	private void updateMidProgAppr(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int goal_id = Integer.parseInt(request.getParameter("eu1"));
		String mdprogress = request.getParameter("eumid");
		// System.out.println("mid Progress Self"+goal_id+" "+mdprogress);

		Appraisal editMidProgAppr = new Appraisal(goal_id, mdprogress);
		appraisalDbUtil.updateMidProgAppraisal(editMidProgAppr);

		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Mid Term progress Appraisal Updated Successfully.\r\n" + "</div> ");
		listGoals(request, response);

	}

	private void updateFinProgAppr(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String finprogress = request.getParameter("fua1");
		int goal_id = Integer.parseInt(request.getParameter("fua2"));
		// System.out.println("Final Progress Self"+goal_id+" "+finprogress);

		Appraisal editMidProgAppr = new Appraisal(finprogress, goal_id);
		appraisalDbUtil.updateFinProgAppraisal(editMidProgAppr);

		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong>Fin Term progress Appraisal Updated Successfully.\r\n" + "</div> ");
		listGoals(request, response);

	}

	private void deleteGoal(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int goal_id = Integer.parseInt(request.getParameter("dg1"));
		appraisalDbUtil.deleteFtGoal(goal_id);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Deleted Successfully.\r\n" + "</div> ");
		listGoals(request, response);

	}

	private void deleteAchievements(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int achv_id = Integer.parseInt(request.getParameter("da1"));
		appraisalDbUtil.deleteDbAchv(achv_id);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Deleted Successfully.\r\n" + "</div> ");
		listGoals(request, response);

	}

	private void modifyGoals(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {

		int goal_id = Integer.parseInt(request.getParameter("eu1"));
		String goal = request.getParameter("eug");
		String target = request.getParameter("eut");
		String measure = request.getParameter("eum");

		System.out.println("n0 " + goal + " Yes " + URLEncoder.encode(goal, "UTF-8"));
		Appraisal editAppraisal = new Appraisal(goal_id, goal, measure, target);
		appraisalDbUtil.updateFtGoal(editAppraisal);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Goal Settings Updated Successfully.\r\n" + "</div> ");
		listGoals(request, response);

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
			// TODO Auto-generated catch block
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

	// Custom methods

	public void createFtemGoals(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			// System.out.println("Processing goals");
			fjtcouser fjuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			String emp_id = fjuser.getEmp_code();
			String gs_type = request.getParameter("optradio");
			int year = Calendar.getInstance().get(Calendar.YEAR);
			if (Integer.parseInt(request.getParameter("syr")) > year) {
				year = Integer.parseInt(request.getParameter("syr"));
			}
			String goal = request.getParameter("goal");
			String target = request.getParameter("target"); // response
			String measure = request.getParameter("measure");
			String approver_id = request.getParameter("apid");

			Appraisal theGsData = new Appraisal(0, year, emp_id, approver_id, gs_type, goal, measure, target);
			// check for the first term appraisal for row before insertion
			if (appraisalDbUtil.checkGoalCount(theGsData) >= 5) {
				request.setAttribute("UPDATE_MSG",
						"<div class=\"alert alert-info\">\r\n"
								+ "<strong>Info!</strong> You exceeded maximum number of " + gs_type
								+ "goal settings for Year " + year + ". Please edit / update or delete excisting "
								+ gs_type + "  goals to continue\r\n" + "</div> ");
				request.setAttribute("GOAL_COUNT", appraisalDbUtil.checkGoalCount(theGsData));
				listGoals(request, response);
			} else {
				appraisalDbUtil.insetAppraisal(theGsData);
				request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
						+ "  <strong>Success!</strong> Created New Goal Settings Successfully.\r\n" + "</div> ");
				request.setAttribute("GOAL_COUNT", appraisalDbUtil.checkGoalCount(theGsData));
				listGoals(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("Error occured in processing request.");
		} finally {
		}

	}

	private void listGoals(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {

		fjtcouser emp_id = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String uid = emp_id.getEmp_code();

		String year = Calendar.getInstance().get(Calendar.YEAR) + "";
		if (request.getParameter("syr") != null) {
			year = request.getParameter("syr");
		}
		// System.out.println(uid);

		List<Appraisal> employeeGoals = appraisalDbUtil.getEmployeeGoals(uid, year);
		List<Achievements> employeeAchvm = appraisalDbUtil.getEmployeeAchievements(uid, year);
		request.setAttribute("ACHV", employeeAchvm);
		Overview theOverviewData = approverDbUtil.getEmployeeOverview(uid, year);
		request.setAttribute("OVERVIEW", theOverviewData);

		// add goal list to the request
		request.setAttribute("FT_GOAL_LIST", employeeGoals);

		// send to JSP page (view)
		goToSelfAppraisal(request, response);

	}

	private void goToSelfAppraisal(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("selected_Year", request.getParameter("syr"));
		RequestDispatcher dispatcher = request.getRequestDispatcher("/appraisal.jsp");
		dispatcher.forward(request, response);

	}

}
