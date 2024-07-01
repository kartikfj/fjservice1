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

import beans.ConsultantLeads;
import beans.fjtcouser;
import utils.MarketingLeadsDbUtil;

/**
 * @author nufail.a Servlet implementation class MarketingLeadsController
 *         Renamed to "Consultant Approval Status"
 */
@WebServlet("/ConsultantLeads")
public class MktConsultantLeads extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MarketingLeadsDbUtil marketingLeadsDbUtil;

	public MktConsultantLeads() throws ServletException {
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
		List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
		List<ConsultantLeads> consultantList = marketingLeadsDbUtil.getAllConsultantList();
		request.setAttribute("DLFCL", divisonList);
		request.setAttribute("CLFCL", consultantList);
		String message = "";

		// if (userRole.equals("mkt") || userRole.equals("mg")) {

		List<ConsultantLeads> consultntLdsDtls = marketingLeadsDbUtil.getAllConsultantLeadsDetails(currYear);

		request.setAttribute("VACLD", consultntLdsDtls); // view all consultant leads

		if (consultntLdsDtls == null || consultntLdsDtls.isEmpty()) {
			message = "No New consultant leads  details from last 2 weeks .";
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

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantLeads.jsp");
		dispatcher.forward(request, response);

	}

	private void deleteSelectedConsultantLeads(HttpServletRequest request, HttpServletResponse response,
			String userRole) throws IOException, SQLException, ServletException {
		String cid = request.getParameter("dd1");
		marketingLeadsDbUtil.deleteUpdateConsultantLeads(cid);
		goToConsultantLeads(request, response, userRole);

	}

	private void updateConsultantLdsDetails(HttpServletRequest request, HttpServletResponse response, String userRole)
			throws IOException, SQLException, ServletException {
		String products = "";
		String remark = request.getParameter("ud2");
		String status = request.getParameter("ud1");
		String id = request.getParameter("ud3");
		String contactDetails = request.getParameter("ud4");
		String[] product_lists = request.getParameterValues("ud5");
		if (product_lists.length > 0) {
			products = String.join(",", product_lists);
		}
		System.out.println("ID : " + id + " status : " + status);

		ConsultantLeads updatedtls = new ConsultantLeads(id, status, remark, contactDetails, products, "");
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantLeads.jsp");
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

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ConsultantLeads.jsp");
		dispatcher.forward(request, response);
	}

	private void createNewConsultantLeads(HttpServletRequest request, HttpServletResponse response,
			String employee_Code, String userRole) throws IOException, SQLException, ServletException {
		String products = "";
		String consult_name = request.getParameter("newConsltnt");
		// String product = request.getParameter("newProduct");
		String[] product_lists = request.getParameterValues("newProduct");
		if (product_lists.length > 0) {
			products = String.join(",", product_lists);
		}
		String remark = request.getParameter("newConsRmrk");
		String status = request.getParameter("newstatus");
		String div = request.getParameter("newDiv");
		String consultantDetails = request.getParameter("newConsDetails");
		String isUpdateByBDM = request.getParameter("bybdmyorno");
		String isUpdateByEVM = request.getParameter("bybdmyorno1");
		String consultantType = request.getParameter("consultantType");
		String year = Calendar.getInstance().get(Calendar.YEAR) + "";

		ConsultantLeads consultant_Leads_Dtls = new ConsultantLeads(consult_name, products, status, div, remark, year,
				employee_Code, consultantDetails, isUpdateByBDM, isUpdateByBDM, consultantType);
		int successVal = marketingLeadsDbUtil.createnewConsultantLeads(consultant_Leads_Dtls);
		if (successVal == 1) {
			request.setAttribute("MSG", "New Consultant Leads  Created  Successfully.");
		} else {
			request.setAttribute("MSG", "New Consultant Leads is Not Created, Please try again.");
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
