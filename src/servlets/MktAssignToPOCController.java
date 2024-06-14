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

import beans.MktAssigntoPOC;
import beans.MktConfig;
import beans.MktSalesLeads;
import beans.MktSupportRequest;
import beans.SipJihvSummary;
import beans.fjtcouser;
import utils.MktSAssigntoPOCDbUtil;
import utils.MktSalesLeadsDbUtil;

@WebServlet("/AssignToPOC")
public class MktAssignToPOCController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private MktSalesLeadsDbUtil salesRetrofitLeadsDbUtil;
	private MktSAssigntoPOCDbUtil assigntoPOCDbUtil;

	public MktAssignToPOCController() throws ServletException {
		super.init();
		salesRetrofitLeadsDbUtil = new MktSalesLeadsDbUtil();
		assigntoPOCDbUtil = new MktSAssigntoPOCDbUtil();
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
			String bdmCode = fjtuser.getSales_code();
			String bdmName = fjtuser.getUname();
			String action = request.getParameter("action");

			if (action == null) {
				action = "list";
			}
			switch (action) {
			case "new":
				createNewSupportRequest(request, response, empCode, userRole, bdmCode, bdmName);
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
				RequestDispatcher dispatcher = request.getRequestDispatcher("marketing/AssigntoPOC.jsp");
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

		if (!userRole.equals("mg") || !userRole.equals("mkt")) {
			// System.out.println("1");
			// marketing team and mangement have permission to view all support requests
			List<MktAssigntoPOC> requestList = assigntoPOCDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);

		} else if ((!userRole.equals("mg") && !userRole.equals("mkt")) && saleEng_Emp_Code.equals(empCode)
				&& process1 == 1) {
			// System.out.println("2");
			// for sales engineer, view permisiion only if the particular request created by
			// them
			List<MktAssigntoPOC> requestList = assigntoPOCDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);
		} else {
			// System.out.println("3");
			request.setAttribute("MSG", "You don't have permission to view this support request");
		}

		request.setAttribute("P1", process1);
		request.setAttribute("P2", process2);
		request.setAttribute("P3", process3);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ViewAssigntoPOCForm.jsp");
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
		System.out.println("goToRequests");
		if (!userRole.equals("mkt") && !userRole.equals("mg")) {
			List<MktAssigntoPOC> requestList = assigntoPOCDbUtil.getSupportRequestDetailsForSalesEng(empployee_Code);
			request.setAttribute("SRLIST", requestList);
		} else if (userRole.equals("mg") || userRole.equals("mkt")) {
			List<MktAssigntoPOC> requestList = assigntoPOCDbUtil.getRequestDetailsGeneral();
			request.setAttribute("SRLIST", requestList);
			List<SipJihvSummary> pocList = assigntoPOCDbUtil.getPOCList();
			request.setAttribute("POCLIST", pocList);
		} else if (fjtuser.getSubordinatesDetails() > 0 && !userRole.equals("mkt") && !userRole.equals("mg")) {
			List<MktConfig> categoryList = assigntoPOCDbUtil.getMarketingTypesConfig("SUPPORTREQUEST");
			request.setAttribute("CTL", categoryList);// category type list

			String salesEngineerList = assigntoPOCDbUtil.getSalesEngListfor_Dm(empployee_Code);
			List<MktSupportRequest> requestList = assigntoPOCDbUtil.getSupportRequestDetailsForDm(empployee_Code,
					salesEngineerList);
			request.setAttribute("SRLIST", requestList);
		} else {
			request.setAttribute("MSG", "You don't have permission to view the support requests");
		}
		System.out.println("after listsssss");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/AssigntoPOC.jsp");
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

		if (!userRole.equals("mg") && !userRole.equals("mkt") && process1 == 1 && process2 == 0 && process3 == 0) {
			// System.out.println("Edit Procees - 2");
			List<MktAssigntoPOC> requestList = assigntoPOCDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);
		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && process1 == 1 && process2 == 1
				&& process3 == 0) { // System.out.println("Edit Procees - 3");
			List<MktAssigntoPOC> leadList = assigntoPOCDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", leadList);

		} else if (!userRole.equals("mg") && userRole.equals("mkt") && process1 == 1 && process2 == 1 && process3 == 1
				&& process4 == 0) {
			// System.out.println("Edit Procees - 4");
			List<MktAssigntoPOC> requestList = assigntoPOCDbUtil.getSupportRequestForMktEdit(id);
			request.setAttribute("SRLIST", requestList);
		} else {
			// System.out.println("Edit Procees - 0");
			request.setAttribute("MSG", "You don't have permission to edit this leads");
		}
		request.setAttribute("P1", process1);
		request.setAttribute("P2", process2);
		request.setAttribute("P3", process3);
		request.setAttribute("P4", process4);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/EditAssigntoPOCForm.jsp");
		dispatcher.forward(request, response);
	}

	private void deleteLead(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// delete lead, only permmision for mkt user
		int deleteStatus = -1;
		String id = request.getParameter("srdi");
		String salesEngEmpVode = request.getParameter("seempcode");
		if (!userRole.equals("mkt") && !userRole.equals("mg") && salesEngEmpVode.equals(empployee_Code)) {
			deleteStatus = assigntoPOCDbUtil.deleteLead(id);
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

		if (!userRole.equals("mg") && !userRole.equals("mkt") && process1 == 1 && process2 == 0 && process3 == 0
				&& process4 == 0) {
			// proccess 2, its updation against sdales engineer request, mkt team can accept
			// or decline the request
			// System.out.println("UPDATE 2");
			String remarksByMkt = request.getParameter("mktAckRemarks");
			MktAssigntoPOC followup_Details = new MktAssigntoPOC(id, requestType, process2Param, empployee_Code,
					remarksByMkt);
			updateStatus = assigntoPOCDbUtil.updateSupportRequestAcceptOrNotProcess2(followup_Details);

			if (updateStatus == 1) {
				assigntoPOCDbUtil.sendMailToSaleEngProccess2(followup_Details, saleEng_Emp_Code);
				request.setAttribute("MSG", "Support Request response updated successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && process1 == 1 && process2 == 1 && process3 == 0
				&& process4 == 0) { // procees 3 , if the marketing team accepted the request, this condition for
									// marketing team
			// System.out.println("UPDATE 3");
			String followUpByMkt = request.getParameter("mktFollowUp");
			String status = request.getParameter("status");
			MktAssigntoPOC followup_Details = new MktAssigntoPOC(id, followUpByMkt);
			updateStatus = assigntoPOCDbUtil.updateMarketingTeamFollowupProcess3(followup_Details, empployee_Code,
					status);

			if (updateStatus == 1) {
				assigntoPOCDbUtil.sendFollowupMailToSalesEngineerProcees3(followup_Details, saleEng_Emp_Code);
				request.setAttribute("MSG", "Lead followup Updated Successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else if (!userRole.equals("mg") && userRole.equals("mkt") && process1 == 1 && process2 == 1 && process3 == 1
				&& process4 == 0 && saleEng_Emp_Code.equals(empployee_Code)) {
			// process 3
			// System.out.println("UPDATE 4");
			String seremarks = request.getParameter("segRemarks");

			MktAssigntoPOC followup_Details = new MktAssigntoPOC(id, seremarks);
			updateStatus = assigntoPOCDbUtil.updateSalesEngineerFollowupProcess4(followup_Details, empployee_Code);
			if (updateStatus == 1) {
				assigntoPOCDbUtil.sendMailToSalesEngineerProcees4(followup_Details, empployee_Code);
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
			String empployee_Code, String userRole, String bdmCode, String bdmName)
			throws ServletException, IOException, SQLException {
		if (userRole.equals("mkt") && bdmCode != null && !bdmCode.isEmpty()) {
			String bdmEmpCode = empployee_Code;
			String bdm_Name = bdmName;
			String seEmpCode = request.getParameter("seEmpCode");
			String seEmpname = request.getParameter("seEmpname");
			String bdmRemarks = request.getParameter("remarks");
			String bdmTaskName = request.getParameter("taskName");
			MktAssigntoPOC request_Details = new MktAssigntoPOC(bdmTaskName, bdmEmpCode, bdm_Name, seEmpCode, seEmpname,
					bdmRemarks);

			MktAssigntoPOC inserStatus = assigntoPOCDbUtil.createNewSupportRequest(request_Details);

			if (inserStatus.getInsertStatus() == 1) {
				assigntoPOCDbUtil.sendMailToMarketingProcees1(request_Details, inserStatus.getLastInsertedRow());
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else {
			request.setAttribute("MSG", "Something went wrong, please try again later");
		}

		goToRequests(request, response, empployee_Code, userRole);
	}
}
