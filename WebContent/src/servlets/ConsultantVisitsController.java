package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import beans.ConsultantLeads;
import beans.ConsultantVisits;
import beans.MktSalesLeads;
import beans.fjtcouser;
import utils.MarketingLeadsDbUtil;

/**
 * Servlet implementation class ConsultantVisits
 */
@WebServlet("/ConsultantVisits")
public class ConsultantVisitsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MarketingLeadsDbUtil marketingLeadsDbUtil;

	public ConsultantVisitsController() throws ServletException {
		super.init();
		marketingLeadsDbUtil = new MarketingLeadsDbUtil();
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
			String userRole = fjtuser.getRole();
			String theDataFromHr = request.getParameter("octjf");
			if (theDataFromHr == null) {
				theDataFromHr = "list";
			}
			switch (theDataFromHr) {
			case "list":
				try {
					goToConsultantLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lctlmftc": // change tab from marketing leads to consultant leads
				try {
					// System.out.println("consultant entered");
					goToConsultantLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "cnclfpad": // create new consultant leads for product & division
				try {
					// System.out.println("consultant entered");
					createNewConsultantLeads(request, response, emp_code, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "sbcnfpdw": // search by consultant name for product division wise
				try {
					serachProductforConsultant(request, response, emp_code, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "dlcav": // view all consultant leads details
				try {
					// System.out.println("consultant debug : entered to vie all switch");
					// viewAllConsultantLeadsDetails(request,response);
					viewAllConsultantLeadsDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "unclfpad": // update new consultant leads for product & division
				try {
					// System.out.println("consultant debug : entered to update block");

					updateConsultantLdsDetails(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "dsclfpad": // delete selected consultant leads for product & division
				try {
					deleteSelectedConsultantLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "consultantType":
				getConsultantType(request, response);
				break;
			default:
				try {
					goToConsultantLeads(request, response, userRole);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void goToConsultantLeads(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws SQLException, ServletException, IOException {
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		List<ConsultantLeads> consultantList = marketingLeadsDbUtil.getAllConsultantList();
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("CLFCL", consultantList);
		String message = "";

		// if (userRole.equals("mkt") || userRole.equals("mg")) {

		List<ConsultantVisits> consultntLdsDtls = marketingLeadsDbUtil.getAllConsultantVisitDetails(currYear);

		request.setAttribute("VACLD", consultntLdsDtls); // view all consultant leads

		if (consultntLdsDtls == null || consultntLdsDtls.isEmpty()) {
			message = "No consultant visit details";
		}
		/*
		 * } else { fjtcouser fjtuser = (fjtcouser)
		 * request.getSession().getAttribute("fjtuser"); String companyCode =
		 * fjtuser.getEmp_com_code(); String divnCode = fjtuser.getEmp_divn_code();
		 * List<ConsultantLeads> consultntLdsDtls = marketingLeadsDbUtil
		 * .getAllConsultantLeadsDetailsForSalesEng(currYear, companyCode, divnCode);
		 * request.setAttribute("VACLD", consultntLdsDtls);// view all consultant leads
		 * for sales engineer
		 * 
		 * if (consultntLdsDtls == null || consultntLdsDtls.isEmpty()) { message =
		 * "No consultant leads  details ."; } }
		 */
		if (consultntLdsDtls == null || consultntLdsDtls.isEmpty()) {
			message = "No consultant leads  details .";
		}
		request.setAttribute("SWORD", message);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantVisits.jsp");
		dispatcher.forward(request, response);

	}

	private void deleteSelectedConsultantLeads(HttpServletRequest request, HttpServletResponse response,
			String userRole) throws IOException, SQLException, ServletException {
		String cid = request.getParameter("dd1");
		marketingLeadsDbUtil.deleteUpdateConsultantLeads(cid);
		goToConsultantLeads(request, response, userRole);

	}

	private void getConsultantType(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// get consultantType based on selected consultant
		String consultant = request.getParameter("cd1");
		MktSalesLeads consultType = marketingLeadsDbUtil.getConsultantType(consultant);
		response.setContentType("application/json");
		new Gson().toJson(consultType, response.getWriter());

	}

	private void updateConsultantLdsDetails(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws IOException, SQLException, ServletException {
		String products = "";
		String remark = request.getParameter("ud2");
		String status = request.getParameter("ud1");
		String id = request.getParameter("ud3");
		String contactDetails = request.getParameter("ud4");
		String eoa = request.getParameter("ud6");
		String[] product_lists = request.getParameterValues("ud5");
		if (product_lists.length > 0) {
			products = String.join(",", product_lists);
		}
		System.out.println("ID : " + id + " status : " + status);

		ConsultantLeads updatedtls = new ConsultantLeads(id, status, remark, contactDetails, products, "", eoa);
		marketingLeadsDbUtil.editUpdateConsultantLeads(updatedtls);

		goToConsultantLeads(request, response, userRole);
	}

	private void viewAllConsultantLeadsDetails(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, ServletException {
		// System.out.println("consultant debug : entered to vie all function");
		String currYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		List<ConsultantLeads> consultntLdsDtls = marketingLeadsDbUtil.getAllConsultantLeadsDetails(currYear);
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();

		String message = "";

		if (consultntLdsDtls == null || consultntLdsDtls.isEmpty()) {
			message = "No consultant leads  details .";

		}

		request.setAttribute("SWORD", message);

		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("VACLD", consultntLdsDtls);// view all consultant leads
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantVisits.jsp");
		dispatcher.forward(request, response);

	}

	private void serachProductforConsultant(HttpServletRequest request, HttpServletResponse response, String emp_code,
			String userRole) throws SQLException, ServletException, IOException {
		String search_word = request.getParameter("srch-term");
		String year = Calendar.getInstance().get(Calendar.YEAR) + "";
		List<ConsultantLeads> searchDtls = marketingLeadsDbUtil.getSerachResultConsultantleads(search_word, year);
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		String message = "";

		if (searchDtls == null || searchDtls.isEmpty()) {
			message = "Search results for '<b><i>" + search_word + "</i></b>' not found.";

		}

		request.setAttribute("SWORD", message);
		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("VACLD", searchDtls);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantVisits.jsp");
		dispatcher.forward(request, response);
	}

	private void createNewConsultantLeads(HttpServletRequest request, HttpServletResponse response,
			String employee_Code, String userRole) throws IOException, SQLException, ServletException, ParseException {
		String products = "";
		String consult_name = request.getParameter("newConsltnt");
		String reasontovisit = request.getParameter("reasontovisit");
		String selectedDate = request.getParameter("datepicker-13");
		String personDetails = request.getParameter("personDetails");
		String noofattendees = request.getParameter("noofattendees");
		String division = request.getParameter("newDiv");
		String consultantType = request.getParameter("consultantType");
		String[] product_lists = request.getParameterValues("newProduct");
		if (product_lists != null && product_lists.length > 0) {
			products = String.join(",", product_lists);
		}
		int attendeescount = 0;
		if (noofattendees != null) {
			attendeescount = Integer.parseInt(noofattendees);
		}
		String meetingNotes = request.getParameter("meetingNotes");
		String year = Calendar.getInstance().get(Calendar.YEAR) + "";
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt = formatter.parse(selectedDate);
		Date selectedSqlDate = new Date(dt.getTime());

		ConsultantVisits consultant_Visits_Dtls = new ConsultantVisits(consult_name, reasontovisit, selectedSqlDate,
				attendeescount, personDetails, meetingNotes, employee_Code, division, products, consultantType);
		int successVal = marketingLeadsDbUtil.createnewConsultantVisits(consultant_Visits_Dtls);
		if (successVal == 1) {
			request.setAttribute("MSG", "New Consultant Visits  Created  Successfully.");
		} else if (successVal == -1) {
			request.setAttribute("MSG", "The record already exists with same Consultant,Date and Reason for visit");
		} else {
			request.setAttribute("MSG", "New Consultant Visits is Not Created, Please try again.");
		}

		goToConsultantLeads(request, response, userRole);
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
