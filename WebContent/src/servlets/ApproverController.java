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

import beans.Achievements;
import beans.Appraisal;
import beans.AppraisalEmpDtlsforApprover;
import beans.Appraisal_Email_Status;
import beans.Approver;
import beans.Overview;
import beans.fjtcouser;
import utils.AppraisalDbUtil;
import utils.ApproverDbUtil;
import utils.EmailConfigDbUtil;

/**
 * Servlet implementation class ApproverController
 */
@WebServlet("/ApproverForm.jsp") // ApproverController
public class ApproverController extends HttpServlet {
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
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {
			// Object value = request.getSession().getAttribute("fjtcouser"); //retrieve one
			// servlet (fjtcousercontrol.java) session attributes in another servlet

			String appr_com_code = fjtuser.getEmp_code();

			List<Approver> theAppaiseIdList = approverDbUtil.getSubordinatesDetails(appr_com_code);
			List<Approver> theYearList = approverDbUtil.getYear();
			request.setAttribute("SUB_NAME_LIST", theAppaiseIdList);
			request.setAttribute("SUB_DATE_LIST", theYearList);

			request.setAttribute("selected_Year", request.getParameter("syr"));
			request.setAttribute("selected_Emp", request.getParameter("sid"));

		}

		String theDataFromHr = request.getParameter("fjtco");

		if (theDataFromHr == null) {
			theDataFromHr = "list";

		}

		switch (theDataFromHr) {
		case "list":
			// start goal setting for each company
			try {
				// System.out.println("before list");
				listUserGoals(request, response);
				// System.out.println("after list");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "notifyMail":

			try {
				System.out.println("notify mail");
				notifyAppraiseeByMail(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "OVR":// add final overview
			try {
				// System.out.println("before add goal");
				createFinalOverView(request, response);
				// System.out.println("after add goal");
			} catch (Exception e) {
				e.printStackTrace();
			}

			break;
		case "aprva":// approver appraise goals of user

			try {
				// System.out.println("approve buuton before");
				approveUserGoals(request, response);
				// System.out.println("approve button after");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "midap":

			// System.out.println("mid appraisal progress before");
			// approver method for updating mid term appraisal
			try {
				// System.out.println("mid appraisal progress before");
				updateUserMidAppraisal(request, response);
				// System.out.println("mid appraisal progress after");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "finap":

			// System.out.println("mid appraisal progress before");
			// approver method for updating mid term appraisal
			try {
				// System.out.println("mid appraisal progress before");
				updateUserFinAppraisal(request, response);
				// System.out.println("mid appraisal progress after");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "dov0":
			// System.out.println("mid appraisal progress before");
			// approver method for updating mid term appraisal
			try {
				// System.out.println("delete overview before");
				deleteOverview(request, response);
				// System.out.println("delete overview after");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "UPDATE_OVR":

			// System.out.println("mid appraisal progress before");
			// approver method for user final overview
			try {
				// System.out.println("update final overview before");
				updateUserFinalOverview(request, response);
				// System.out.println("update final overview after");
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "sltDesrpa":// appraisee details

			try {

				appraiseeDetails(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			// System.out.println(theDataFromHr);
			try {
				goToApproverAppraisal(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void appraiseeDetails(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String apprvaisee_id = request.getParameter("diApr");// Appraisee / Employee IDor Code

		List<AppraisalEmpDtlsforApprover> theAppraiseeDetails = approverDbUtil.getAppraiseeDetails(apprvaisee_id);
		response.setContentType("application/json");
		new Gson().toJson(theAppraiseeDetails, response.getWriter());
	}

	private void notifyAppraiseeByMail(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String year = request.getParameter("ntfy_year");
		String apprvr_name = request.getParameter("ntfy_approver_name");
		String apprvr_id = request.getParameter("ntfy_aprover_id");
		String emp_id = request.getParameter("ntfy_apraisee_id");
		String notify_type = request.getParameter("notify_type");
		// System.out.println("notify type"+notify_type);
		String company = request.getParameter("ntfy_emp_cmp");
		Appraisal_Email_Status mail_Details = new Appraisal_Email_Status(emp_id, year, company, apprvr_id, apprvr_name);

		switch (notify_type) {
		case "gs":
			if (emailConfigDbUtil.NotifyGSMail(mail_Details) == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
						+ "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "<strong>Success!</strong> Goal Setting Review Notification Mail Sent  Successfully. </div>");

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
						+ "<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "<strong>Error!</strong> Error in processing. Try Later. </div>");

			}
			break;
		case "mid":
			if (emailConfigDbUtil.NotifyMidMail(mail_Details) == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Success!</strong> Mid Term  Progress Review  Notification Mail Sent  Successfully. </div>");

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Error!</strong> Error in processing. Try Later. </div>");

			}
			break;

		case "fin":
			if (emailConfigDbUtil.NotifyFinMail(mail_Details) == 1) {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-success alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Success!</strong> Final Term Progress Review Notification Mail Sent  Successfully. </div>");

			} else {
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("<div class=\"alert alert-danger alert-dismissible fade in\" >\r\n"
						+ "			    <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n"
						+ "			    <strong>Error!</strong> Error in processing. Try Later. </div>");

			}
			break;
		default:

		}

	}

	private void deleteOverview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		int overview_id = Integer.parseInt(request.getParameter("dov1"));
		approverDbUtil.deleteOverview(overview_id);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Deleted Successfully.\r\n" + "</div> ");
		String emp_id = request.getParameter("ovuser");
		String year = request.getParameter("ovyr");
		dataToList(request, response, emp_id, year);

	}

	private void updateUserFinAppraisal(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String year = request.getParameter("a0");
		String emp_id = request.getParameter("a2");

		String fin_Prog_A = request.getParameter("faa1");
		String fin_remark = request.getParameter("faa2");
		int goal_id = Integer.parseInt(request.getParameter("faa3"));
		// System.out.println("final_nufail"+fin_Prog_A+fin_remark+goal_id);
		Appraisal theFinProgA = new Appraisal(goal_id, fin_Prog_A, fin_remark);// final progress updation by approver
		approverDbUtil.updateFinProgDetails(theFinProgA);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Mid Term Appraisal details Sucessfully Updated \r\n" + "</div> ");
		dataToList(request, response, emp_id, year);

	}

	private void updateUserMidAppraisal(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String year = request.getParameter("a0");
		String emp_id = request.getParameter("a2");

		String mid_progress = request.getParameter("maa1");
		String mid_remark = request.getParameter("maa2");
		String mid_on_off = request.getParameter("maa3");
		int goal_id = Integer.parseInt(request.getParameter("maa4"));
		// System.out.println(mid_progress+mid_remark+mid_on_off+goal_id);
		Appraisal theMidProgressApprover = new Appraisal(mid_progress, mid_remark, mid_on_off, goal_id);
		approverDbUtil.updateMidProgressDetails(theMidProgressApprover);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Mid Term Appraisal details Sucessfully Updated " + "</div> ");
		dataToList(request, response, emp_id, year);
	}

	private void approveUserGoals(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String year = request.getParameter("a0");
		String approver_id = request.getParameter("a1");
		String emp_id = request.getParameter("a2");

		// for send mail and save mail status db... below to variable for approver to
		// user mail activity
		String approver_name = request.getParameter("mail_approver_name");

		String company = request.getParameter("mail_emp_cmp");
		// System.out.println("a6 ="+approver_name+" a7 ="+company);

		String term_selector = request.getParameter("a3");
		Appraisal_Email_Status mail_Details = new Appraisal_Email_Status(emp_id, year, company, approver_id,
				approver_name);
		if (term_selector.equals("GSA")) {
			approverDbUtil.approveEmployeeGoalSettings(year, approver_id, emp_id);
			emailConfigDbUtil.ApproveGsMail(mail_Details);

			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
					+ "  <strong>Success!</strong> Goal Settings Approved Successfully and Notification Mail Sent to Appraisee"
					+ "</div> ");

		}
		if (term_selector.equals("MTA")) {
			approverDbUtil.approveEmployeeMidTermAppraisal(year, approver_id, emp_id);
			emailConfigDbUtil.ApproveMidMail(mail_Details);
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
					+ "  <strong>Success!</strong> Mid Term Appraisal Progress Approved  Successfully and Notification Mail Sent to Appraisee"
					+ "</div> ");

		}
		if (term_selector.equals("FTA")) {

			approverDbUtil.approveEmployeeFinalTermAppraisal(year, approver_id, emp_id);
			emailConfigDbUtil.ApproveFinMail(mail_Details);
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
					+ "  <strong>Success!</strong> Final Term Appraisal Progress Updated  Successfully and Notification Mail Sent to Appraisee"
					+ "</div> ");

		}
		if (term_selector.equals("FRA")) {
			// System.out.println("before db");
			approverDbUtil.approveEmployeeFinalTermAppraisal(year, approver_id, emp_id);
			emailConfigDbUtil.ApproveFinMail(mail_Details);
			int review_id = Integer.parseInt(request.getParameter("rvw_id"));
			Overview approveOverView = new Overview(review_id, approver_id, "YES");
			approverDbUtil.approveEmployeeFinalReview(approveOverView);

			// System.out.println("after db");

			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
					+ "  <strong>Success!</strong> Final Term Appraisal Progress Approved  Successfully and Notification Mail Sent to Appraisee\r\n"
					+ "</div> ");

		}

		dataToList(request, response, emp_id, year);
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

	private void listUserGoals(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// get appraisal dates to list from db util
		// Object value = request.getSession().getAttribute("fjtcouser"); //retrieve one
		// servlet (fjtcousercontrol.java) session attributes in another servlet

		String year1 = request.getParameter("syr");
		String emp_id = request.getParameter("sid");

		// System.out.println("empid"+emp_id+"year"+year1);
		if (year1 == null || year1.isEmpty() || emp_id == null || emp_id.isEmpty() || year1.equals("0")) {

			goToApproverAppraisal(request, response);
		} else {

			int year = Integer.parseInt(year1);
			// System.out.println("empid"+emp_id+"year"+year);

			dataToList(request, response, emp_id, year + "");

			// send to JSP page (view)
		}

	}

	private void goToApproverAppraisal(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/approver.jsp");
		dispatcher.forward(request, response);

	}

	private void createFinalOverView(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String strength = request.getParameter("ovr1");
		String improvement = request.getParameter("ovr2");
		String rating = request.getParameter("ovr3");
		String promotion = request.getParameter("ovr4");

		// System.out.println("overview text "+strength);

		int year = Calendar.getInstance().get(Calendar.YEAR);
		String year1 = request.getParameter("ovyr");
		if (year1 == null || year1.isEmpty()) {

			year = Calendar.getInstance().get(Calendar.YEAR);

		} else {
			year = Integer.parseInt(year1);

		}
		String emp_id = request.getParameter("ovuser");
		String approver_id = request.getParameter("ovappr");

		Overview theOverviewData = new Overview(0, year, emp_id, approver_id, strength, improvement, rating, promotion,
				"NO");

		// check for the first term appraisal for row before insertion
		if (approverDbUtil.checkOverviewCount(theOverviewData) >= 1) {

			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-info\">\r\n"
					+ "  <strong>Info!</strong> You exceeded Maximum number of Employee Evaluation of " + emp_id
					+ " for Year " + year
					+ " . Please Edit / Update or Delete Excisting Employee Evaluation to continue\r\n" + "</div> ");

			dataToList(request, response, emp_id, year + "");

		} else {
			approverDbUtil.insertOverview(theOverviewData);
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
					+ "  <strong>Success!</strong>  Final Review Created Successfully.\r\n" + "</div> ");

			dataToList(request, response, emp_id, year + "");
		}

		goToApproverAppraisal(request, response);

	}

	private void updateUserFinalOverview(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {

		String strength = request.getParameter("uovr1");
		String improvement = request.getParameter("uovr2");
		String rating = request.getParameter("uovr3");
		String promotion = request.getParameter("uovr4");
		String appr_id = request.getParameter("uovappr");
		String emp_id = request.getParameter("ovuuser");
		int year_tmp = Integer.parseInt(request.getParameter("ovyr"));

		int overvw_id = Integer.parseInt(request.getParameter("uovid"));
		// System.out.println(strength+improvement+rating+promotion+appr_id+overvw_id);
		Overview theUpdateOverviewList = new Overview(overvw_id, appr_id, strength, improvement, rating, promotion);
		approverDbUtil.updateOvrerviewDetails(theUpdateOverviewList);
		request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-success\">\r\n"
				+ "  <strong>Success!</strong> Final Employeee Overview details Sucessfully Updated \r\n" + "</div> ");

		dataToList(request, response, emp_id, year_tmp + "");

	}

	private void dataToList(HttpServletRequest request, HttpServletResponse response, String emp_id, String year1)
			throws SQLException, ServletException, IOException {

		request.setAttribute("curr", appraisalDbUtil.getGoalSettingDate(year1, emp_id));
		request.setAttribute("mid", appraisalDbUtil.getMidTermDate(year1, emp_id));
		request.setAttribute("fin", appraisalDbUtil.getFinalTermDate(year1, emp_id));
		request.setAttribute("approved_details", appraisalDbUtil.getUserApprovedDetails(year1, emp_id));
		request.setAttribute("selected_id", emp_id);
		request.setAttribute("selected_year", year1);
		// System.out.println("dates current="+appraisalDbUtil.getGoalSettingDate(year1,
		// emp_id));

		int year = Integer.parseInt(year1);
		// System.out.println("empid"+emp_id+"year"+year);

		List<Appraisal> employeeGoals = approverDbUtil.getSelectedEmployeeGoals(emp_id, year);
		request.setAttribute("FT_GOAL_LIST", employeeGoals);
		List<Achievements> employeeAchvm = appraisalDbUtil.getEmployeeAchievements(emp_id, year + "");
		request.setAttribute("ACHV", employeeAchvm);
		Overview theOverviewData = approverDbUtil.getEmployeeOverview(emp_id, year + "");
		request.setAttribute("OVERVIEW", theOverviewData);
		goToApproverAppraisal(request, response);
	}

}
