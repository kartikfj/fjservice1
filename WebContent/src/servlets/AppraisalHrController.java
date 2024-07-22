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

import beans.AppraisalHr;
import beans.fjtcouser;
import utils.AppraisalHrDbUtil;

/**
 * Servlet implementation class AppraisalHrController
 */
@WebServlet("/HrAppraisalCalendar.jsp") // AppraisalHrController // changed servlet name to jsp
public class AppraisalHrController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// create a reference to appraisal Hr db util class
	private AppraisalHrDbUtil appraisalHrDbUtil;

	 
	@Override
	public void init() throws ServletException {
		super.init();

		// custom initialization works
		// appraisalHrDbUtil=new AppraisalHrDbUtil(dataSource);
		appraisalHrDbUtil = new AppraisalHrDbUtil();
		try {
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {

		// read the "nufail" parameter from appraisalHrCalendar.jsp
		String theDataFromHr = request.getParameter("fjtco");

		// after reading the parameter route to appropriate method
		if (theDataFromHr == null) {
			theDataFromHr = "list";

		}

		switch (theDataFromHr) {
		case "list":
			// start goal setting for each company
			try {

				listHrAppraisals(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "display":
			try {
				listHrAppraisals(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "modify":
			// start goal setting for each company
			try {
				editHrAppraisals(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "initial":// completed
			// start goal setting for each company
			try {
				goalSettings(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

			break;
		case "midterm":// completed
			// update , based on row , company and emp_id
			System.out.println(theDataFromHr);
			try {
				updateMidTerm(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "final":
			// update , based on row , company and emp_id
			System.out.println(theDataFromHr);
			try {
				updateFinalTerm(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "update":
			// update , based on row , company and emp_id
			System.out.println(theDataFromHr);
			try {
				modifyDates(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		default:
			System.out.println(theDataFromHr);
			try {
				goToAppraisal(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void modifyDates(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// method for updating / changing all ready set set dates from editdates.jsp
		int year = Integer.parseInt(request.getParameter("update_yr"));
		String emp_id = request.getParameter("update_empid");
		String company = request.getParameter("update_cmp");
		String appSdt = request.getParameter("gs_fromdate");
		String appEdt = request.getParameter("gs_todate");
		String appMidSdt = request.getParameter("mid_fromdate");
		String appMidEdt = request.getParameter("mid_todate");
		String finappStd = request.getParameter("fin_fromdate");
		String finappEdt = request.getParameter("fin_todate");
		String modified = request.getParameter("update_empid");

		System.out.println("before " + year + " " + emp_id + " " + company + " " + appSdt + " " + appEdt + " "
				+ appMidSdt + " " + appMidEdt + " " + finappStd + " " + finappEdt + modified);
		// checkEmpty(appSdt,appEdt,appMidSdt,appMidEdt,finappStd,finappEdt);

		System.out.println("after " + year + " " + emp_id + " " + company + " " + appSdt + " " + appEdt + " "
				+ appMidSdt + " " + appMidEdt + "" + " " + finappStd + "hi" + " " + finappEdt + "by" + modified);
		// create a new AppraisalHrObject for modify date list
		AppraisalHr mDates = new AppraisalHr(year, appSdt, appEdt, appMidSdt, appMidEdt, finappStd, finappEdt, emp_id,
				company, modified);
		//
		appraisalHrDbUtil.modifyHrAppraisal(mDates);
		request.setAttribute("MSG", "<div class=\"alert alert-success\">Appraisal Date  for  " + "company: " + company
				+ " - " + year + " is Updated successfully </div> ");
		// goToAppraisal(request,response);
		listHrAppraisals(request, response);

	}

	private void listHrAppraisals(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// get appraisal dates to list from db util
		List<AppraisalHr> theCompanyList = appraisalHrDbUtil.getCompanyList();
		// get appraisal dates to list from db util

		// add dates to the request
		request.setAttribute("COMPANY", theCompanyList);
		// add dates to the request
		List<AppraisalHr> hrDates = appraisalHrDbUtil.getAppraisalDates();
		request.setAttribute("HR_APPRAISAL_LIST", hrDates);

		// send to JSP page (view)
		// request.setAttribute("MSG", "<div class=\"alert alert-success\"> Loaded
		// successfully </div> ");
		// listHrAppraisals(request,response);
		goToAppraisal(request, response);
	}

	private void editHrAppraisals(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// method for retrieving parameter from modify button click
		// appraisalhrCalendar.jsp
		int year = Integer.parseInt(request.getParameter("edit_year"));
		String company = request.getParameter("edit_cmp");
		System.out.println("ajax" + year + " " + company);

		AppraisalHr hrDates = appraisalHrDbUtil.getSelectedAppraisalDates(company, year);

		request.setAttribute("EDIT_DATES", hrDates);

		// send to JSP edit page (view)
		// send to jsp page :update_student_form.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("/editdates.jsp");
		dispatcher.forward(request, response);
	}

	private void updateFinalTerm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int year = Integer.parseInt(request.getParameter("year"));
		String emp_id = request.getParameter("empids");
		String company = request.getParameter("company");
		String finappStd = request.getParameter("fromdate");
		String finappEdt = request.getParameter("todate");
		System.out.println(year + " " + emp_id + " " + company + " " + finappStd + " " + finappEdt);
		// create a new student object
		AppraisalHr theGoalDateSet = new AppraisalHr(finappStd, finappEdt, emp_id, company, null, year);

		// check for the first term appraisal for row before insertion
		if (appraisalHrDbUtil.checkDistinctMdTerm(theGoalDateSet) == null) {

			request.setAttribute("MSG",
					"<b style='color:red;'>The Final Term Appraisal  for the " + "company: " + company + " on " + year
							+ " is Not Created .. Logical Error.. Please Update Mid Term Appraisal Date First  </b> ");
			System.out.println("data not in db");

		} else {
			appraisalHrDbUtil.updateMidtoFinal(theGoalDateSet);
			request.setAttribute("MSG",
					"<div class=\"alert alert-success\">"
							+ "  <strong>Success!</strong> The Final Term Appraisal  for the " + "company: " + company
							+ " on " + year + " is Updated successfully </div> ");
		}

		listHrAppraisals(request, response);

	}

	private void updateMidTerm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int year = Integer.parseInt(request.getParameter("year"));
		String emp_id = request.getParameter("empids");
		String company = request.getParameter("company");
		String appMidSdt = request.getParameter("fromdate");
		String appMidEdt = request.getParameter("todate");
		System.out.println(year + " " + emp_id + " " + company + " " + appMidSdt + " " + appMidEdt);
		// create a new student object
		AppraisalHr theGoalDateSet = new AppraisalHr(appMidSdt, appMidEdt, year, emp_id, company, null);

		// check for the first term appraisal for row before insertion
		if (appraisalHrDbUtil.checkDistinct(theGoalDateSet) == null) {

			request.setAttribute("MSG",
					"<div class=\"alert alert-danger\">The Mid Term Appraisal  for the " + "company: " + company
							+ " on " + year
							+ " is Not Created .. Logical Error..Please Set  Goal Setting Date First  </div> ");
			System.out.println("data not in db");

		} else {
			appraisalHrDbUtil.updateFirsttoMid(theGoalDateSet);
			request.setAttribute("MSG", "<div class=\"alert alert-success\">The Mid Term Appraisal  for the "
					+ "company: " + company + " on " + year + " is Updated successfully </b> ");
		}

		listHrAppraisals(request, response);

	}

	private void goalSettings(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// read student info from form data

		int year = Integer.parseInt(request.getParameter("year"));
		String emp_id = request.getParameter("empids");
		String company = request.getParameter("company");
		String appSdt = request.getParameter("fromdate");
		String appEdt = request.getParameter("todate");
		System.out.println(year + " " + emp_id + " " + company + " " + appSdt + " " + appEdt);
		if (appSdt == "" || appEdt == "") {
			appSdt = null;
			appEdt = null;
		}
		// create a new student object
		AppraisalHr theGoalDateSet = new AppraisalHr(year, appSdt, appEdt, emp_id, company, null);

		// check for the duplicate row before insertion

		String result = appraisalHrDbUtil.checkDistinct(theGoalDateSet);
		System.out.println("controller true :" + result);
		if (result != null) {
			System.out.println("controller true :" + result);
			request.setAttribute("MSG", "<div class=\"alert alert-danger\">Goal Setting  for the company: <strong>"
					+ company + "</strong> on <strong>" + year
					+ "</strong> is Allready created.. Please Create a valid Goal Setting  or Use Modify Button to change date</div>");
			System.out.println("already there");

		} else {
			// add the first term appraisal details to database
			appraisalHrDbUtil.addFirstTermGoals(theGoalDateSet);

			request.setAttribute("MSG", "<div class=\"alert alert-success\">The Goal Setting Dates  for the "
					+ "company: " + company + " on " + year + " is Created Succeffully .. </div> ");

		}

		// goToAppraisal(request,response);
		listHrAppraisals(request, response);

	}

	private void goToAppraisal(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("modify" + response + request);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/appraisalHrCalendar.jsp");
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

	// Custom method

}
