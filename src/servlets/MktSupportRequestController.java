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
import com.google.gson.JsonIOException;

import beans.ConsultantLeads;
import beans.MktConfig;
import beans.MktSalesLeads;
import beans.MktSupportRequest;
import beans.fjtcouser;
import utils.MarketingLeadsDbUtil;
import utils.MktSalesLeadsDbUtil;
import utils.MktSupportRequestDbUtil;

@WebServlet("/SupportRequest")
public class MktSupportRequestController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MarketingLeadsDbUtil marketingLeadsDbUtil;
	private MktSalesLeadsDbUtil salesRetrofitLeadsDbUtil;
	private MktSupportRequestDbUtil supportRequestDbUtil;

	public MktSupportRequestController() throws ServletException {
		super.init();
		marketingLeadsDbUtil = new MarketingLeadsDbUtil();
		salesRetrofitLeadsDbUtil = new MktSalesLeadsDbUtil();
		supportRequestDbUtil = new MktSupportRequestDbUtil();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			fjtcouser fjtuser = (fjtcouser) req.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				resp.sendRedirect("logout.jsp");
			} else {
				processRequest(req, resp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			fjtcouser fjtuser = (fjtcouser) req.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				resp.sendRedirect("logout.jsp");
			} else {
				processRequest(req, resp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
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
			// System.out.println(request.getServletPath());
			String empCode = fjtuser.getEmp_code();
			String userRole = fjtuser.getRole();
			String seCode = fjtuser.getSales_code();
			String seName = fjtuser.getUname();
			String action = request.getParameter("action");

			if (action == null) {
				action = "list";
			}
			switch (action) {
			case "new":
				createNewSupportRequest(request, response, empCode, userRole, seCode, seName);
				break;
			case "update":
				updateLead(request, response, empCode, userRole);
				break;
			case "delete":
				deleteLead(request, response, empCode, userRole);
				break;
			case "edit":
				showEditForm(request, response, empCode, userRole);
				break;
			case "view":
				viewDetails(request, response, empCode, userRole);
				break;
			case "list":
				listRequests(request, response, empCode, userRole);
				break;
			case "prdctlist":
				getDivisionProductList(request, response);
				break;
			default:
				RequestDispatcher dispatcher = request.getRequestDispatcher("marketing/SupportRequest.jsp");
				dispatcher.forward(request, response);
				break;
			}
		}
	}

	private void viewDetails(HttpServletRequest request, HttpServletResponse response, String empCode, String userRole)
			throws SQLException, ServletException, IOException {
		// view the details of particular leads without edit option
		// System.out.println("view");
		int id = Integer.parseInt(request.getParameter("srdi"));
		// System.out.println("ID "+id);
		int process1 = Integer.parseInt(request.getParameter("p1"));
		int process2 = Integer.parseInt(request.getParameter("p2"));
		int process3 = Integer.parseInt(request.getParameter("p3"));
		String saleEng_Emp_Code = request.getParameter("edocpmees");

		if (userRole.equals("mg") || userRole.equals("mkt")) {
			// System.out.println("1");
			// marketing team and mangement have permission to view all support requests
			List<MktSupportRequest> requestList = supportRequestDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);

		} else if ((!userRole.equals("mg") && !userRole.equals("mkt")) && saleEng_Emp_Code.equals(empCode)
				&& process1 == 1) {
			// System.out.println("2");
			// for sales engineer, view permisiion only if the particular request created by
			// them
			List<MktSupportRequest> requestList = supportRequestDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);
		} else {
			// System.out.println("3");
			request.setAttribute("MSG", "You don't have permission to view this support request");
		}

		request.setAttribute("P1", process1);
		request.setAttribute("P2", process2);
		request.setAttribute("P3", process3);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ViewSupportRequestForm.jsp");
		dispatcher.forward(request, response);
	}

	private void getDivisionProductList(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// get procut lsit based on division code
		String division = request.getParameter("cd1");
		List<MktSalesLeads> productList = salesRetrofitLeadsDbUtil.getProductList(division);
		response.setContentType("application/json");
		new Gson().toJson(productList, response.getWriter());

	}

	private void goToRequests(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (!userRole.equals("mkt") && !userRole.equals("mg") && fjtuser.getSubordinatesDetails() == 0) {
			List<MktConfig> categoryList = supportRequestDbUtil.getMarketingTypesConfig("SUPPORTREQUEST");
			request.setAttribute("CTL", categoryList);// category type list
			List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
			request.setAttribute("DLFCL", divisonList);
			List<MktSupportRequest> requestList = supportRequestDbUtil
					.getSupportRequestDetailsForSalesEng(empployee_Code);
			request.setAttribute("SRLIST", requestList);
		} else if (userRole.equals("mg") || userRole.equals("mkt")) {
			List<MktSupportRequest> requestList = supportRequestDbUtil.getRequestDetailsGeneral();
			request.setAttribute("SRLIST", requestList);
		} else if (fjtuser.getSubordinatesDetails() > 0 && !userRole.equals("mkt") && !userRole.equals("mg")) {
			List<MktConfig> categoryList = supportRequestDbUtil.getMarketingTypesConfig("SUPPORTREQUEST");
			request.setAttribute("CTL", categoryList);// category type list
			List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
			request.setAttribute("DLFCL", divisonList);
			String salesEngineerList = supportRequestDbUtil.getSalesEngListfor_Dm(empployee_Code);
			List<MktSupportRequest> requestList = supportRequestDbUtil.getSupportRequestDetailsForDm(empployee_Code,
					salesEngineerList);
			request.setAttribute("SRLIST", requestList);
		} else {
			request.setAttribute("MSG", "You don't have permission to view the support requests");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/SupportRequest.jsp");
		dispatcher.forward(request, response);

	}

	private void listRequests(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		goToRequests(request, response, empployee_Code, userRole);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// its dealing with edit form
		int id = Integer.parseInt(request.getParameter("srdi"));
		int process1 = Integer.parseInt(request.getParameter("p1"));
		int process2 = Integer.parseInt(request.getParameter("p2"));
		int process3 = Integer.parseInt(request.getParameter("p3"));
		int process4 = Integer.parseInt(request.getParameter("p4"));
		String saleEng_Emp_Code = request.getParameter("edocpmees");
		if (!userRole.equals("mg") && userRole.equals("mkt") && process1 == 1 && process2 == 0 && process3 == 0) {
			// System.out.println("Edit Procees - 2");
			List<MktSupportRequest> requestList = supportRequestDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);
		} else if (!userRole.equals("mg") && userRole.equals("mkt") && process1 == 1 && process2 == 1
				&& process3 == 0) { // System.out.println("Edit Procees - 3");
			List<MktSupportRequest> leadList = supportRequestDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", leadList);

		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && saleEng_Emp_Code.equals(empployee_Code)
				&& process1 == 1 && process2 == 1 && process3 == 1 && process4 == 0) {
			// System.out.println("Edit Procees - 4");
			List<MktSupportRequest> requestList = supportRequestDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);
		} else {
			// System.out.println("Edit Procees - 0");
			request.setAttribute("MSG", "You don't have permission to edit this leads");
		}
		request.setAttribute("P1", process1);
		request.setAttribute("P2", process2);
		request.setAttribute("P3", process3);
		request.setAttribute("P4", process4);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/EditSupportRequestForm.jsp");
		dispatcher.forward(request, response);
	}

	private void deleteLead(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// delete lead, only permmision for mkt user
		int deleteStatus = -1;
		String id = request.getParameter("srdi");
		String salesEngEmpVode = request.getParameter("seempcode");
		if (!userRole.equals("mkt") && !userRole.equals("mg") && salesEngEmpVode.equals(empployee_Code)) {
			deleteStatus = supportRequestDbUtil.deleteLead(id);
			if (deleteStatus == 1) {
				request.setAttribute("MSG", "Successfully deleted lead FJMSR" + id);
			} else {
				request.setAttribute("MSG", "DB Error. Please try again later");
			}

		} else {
			request.setAttribute("MSG", "You don't have permission to delete   leads FJMSR" + id);
		}
		goToRequests(request, response, empployee_Code, userRole);
	}

	private void updateLead(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws SQLException, ServletException, IOException {
		// its dealing with update rquest from update form
		int updateStatus = 0;
		String id = request.getParameter("srdi");
		String process2Param = request.getParameter("p2Update");
		int process1 = Integer.parseInt(request.getParameter("p1"));
		int process2 = Integer.parseInt(request.getParameter("p2"));
		int process3 = Integer.parseInt(request.getParameter("p3"));
		int process4 = Integer.parseInt(request.getParameter("p4"));

		String requestType = request.getParameter("srTyp");
		String saleEng_Emp_Code = request.getParameter("edocpmees");

		if (!userRole.equals("mg") && userRole.equals("mkt") && process1 == 1 && process2 == 0 && process3 == 0
				&& process4 == 0) {
			// proccess 2, its updation against sdales engineer request, mkt team can accept
			// or decline the request
			// System.out.println("UPDATE 2");
			String remarksByMkt = request.getParameter("mktAckRemarks");
			MktSupportRequest followup_Details = new MktSupportRequest(id, requestType, process2Param, empployee_Code,
					remarksByMkt);
			updateStatus = supportRequestDbUtil.updateSupportRequestAcceptOrNotProcess2(followup_Details);

			if (updateStatus == 1) {
				supportRequestDbUtil.sendMailToSaleEngProccess2(followup_Details, saleEng_Emp_Code);
				request.setAttribute("MSG", "Support Request response updated successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else if (!userRole.equals("mg") && userRole.equals("mkt") && process1 == 1 && process2 == 1 && process3 == 0
				&& process4 == 0) { // procees 3 , if the marketing team accepted the request, this condition for
									// marketing team
			// System.out.println("UPDATE 3");
			String followUpByMkt = request.getParameter("mktFollowUp");
			String status = request.getParameter("status");
			MktSupportRequest followup_Details = new MktSupportRequest(id, requestType, followUpByMkt);
			updateStatus = supportRequestDbUtil.updateMarketingTeamFollowupProcess3(followup_Details, empployee_Code,
					status);

			if (updateStatus == 1) {
				supportRequestDbUtil.sendFollowupMailToSalesEngineerProcees3(followup_Details, saleEng_Emp_Code);
				request.setAttribute("MSG", "Lead followup Updated Successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && saleEng_Emp_Code.equals(empployee_Code)
				&& process1 == 1 && process2 == 1 && process3 == 1 && process4 == 0) {
			// process 3
			// System.out.println("UPDATE 4");
			String seremarks = request.getParameter("segRemarks");

			MktSupportRequest followup_Details = new MktSupportRequest(id, seremarks);
			updateStatus = supportRequestDbUtil.updateSalesEngineerFollowupProcess4(followup_Details, saleEng_Emp_Code);
			if (updateStatus == 1) {
				supportRequestDbUtil.sendMailToSalesEngineerProcees4(followup_Details, empployee_Code);
				request.setAttribute("MSG", "Lead followup Updated Successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else {
			// System.out.println("UPDATE none");
			request.setAttribute("MSG", "You don't have permission to edit this leads");
		}

		goToRequests(request, response, empployee_Code, userRole);

	}

	private void createNewSupportRequest(HttpServletRequest request, HttpServletResponse response,
			String empployee_Code, String userRole, String seCode, String seName)
			throws ServletException, IOException, SQLException {
		// Create new Consultant lead or retrofit lead only have permission for "mkt"
		// users

		String products = "";
		double offerValue = 0.0;

		if (!userRole.equals("mkt") && seCode != null && !seCode.isEmpty() && !userRole.equals("mg")) {
			String division = request.getParameter("divn");
			String salesEngEmpCode = empployee_Code;
			String salesEngName = seCode + "- " + seName;
			String type = request.getParameter("typ");
			// System.out.println("type "+type);
			String[] product_lists = request.getParameterValues("prodct");
			if (product_lists.length > 0) {
				products = String.join(", ", product_lists);
			}
			System.out.println("offer val " + request.getParameter("offerval"));
			if (request.getParameter("offerval") != null && request.getParameter("offerval") != "") {
				offerValue = Double.parseDouble(request.getParameter("offerval"));
			}
			String contractor = request.getParameter("contractor");
			String consultant = request.getParameter("consultant");
			String projectDetails = request.getParameter("prjctDtls");
			String seRemarks = request.getParameter("remarks");

			MktSupportRequest request_Details = new MktSupportRequest(type, division, products, consultant, contractor,
					offerValue, projectDetails, seRemarks, salesEngEmpCode, salesEngName);

			MktSupportRequest inserStatus = supportRequestDbUtil.createNewSupportRequest(request_Details);

			if (inserStatus.getInsertStatus() == 1) {
				supportRequestDbUtil.sendMailToMarketingProcees1(request_Details, inserStatus.getLastInsertedRow());
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else {
			request.setAttribute("MSG", "Something went wrong, please try again later");
		}

		goToRequests(request, response, empployee_Code, userRole);
	}
}
