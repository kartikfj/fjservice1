package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
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
import beans.Mkt_SEFollowUp;
import beans.fjtcouser;
import utils.MarketingLeadsDbUtil;
import utils.MktSalesLeadsDbUtil;

/**
 * @author nufail.a
 */
@WebServlet("/SalesLeads")
public class MktSalesLeadsController extends HttpServlet {
 
	private static final long serialVersionUID = 1L;

	private MarketingLeadsDbUtil marketingLeadsDbUtil;
	private MktSalesLeadsDbUtil salesLeadsDbUtil;

	public MktSalesLeadsController() throws ServletException {
		super.init();
		marketingLeadsDbUtil = new MarketingLeadsDbUtil();
		salesLeadsDbUtil = new MktSalesLeadsDbUtil();
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
			String action = request.getParameter("action");
			if (action == null) {
				action = "list";
			}
			switch (action) {
			case "new":
				createNewLead(request, response, empCode, userRole);
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
				listLeads(request, response, empCode, userRole);
				break;
			case "prdctlist":
				getDivisionProductList(request, response);
				break;
			case "stage2Project":
				getStage2ProjectList(request, response);
				break;
			case "vcddtls":
				//System.out.println("INTO CASE");
				getCustomDateSalesLeadDetails(request, response, empCode, userRole);
				break;
			default:
				RequestDispatcher dispatcher = request.getRequestDispatcher("marketing/SalesLeads.jsp");
				dispatcher.forward(request, response);
				break;
			}
		}
	}

	private void getCustomDateSalesLeadDetails(HttpServletRequest request, HttpServletResponse response, String empCode,
			String userRole) throws SQLException, ServletException, IOException {
		// custom date sales lead details

		String fromDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		processLeadRequest(request, response, empCode, userRole, fromDate, toDate);

	}

	private void processLeadRequest(HttpServletRequest request, HttpServletResponse response, String empCode,
			String userRole, String fromDate, String toDate) throws SQLException, ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (userRole.equals("mkt")) {

			List<MktConfig> categoryList = salesLeadsDbUtil.getMarketingTypesConfig("SALESLEADS");
			request.setAttribute("CTL", categoryList);// category type list

			List<ConsultantLeads> divisonList = marketingLeadsDbUtil.getAllDivisionList();
			request.setAttribute("DLFCL", divisonList);

			List<MktSalesLeads> salesEngList = salesLeadsDbUtil.getSalesEngList();
			request.setAttribute("SEL", salesEngList);

			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadDetailsGeneralByLocation(fromDate, toDate, empCode);
			request.setAttribute("LEADLIST", leadList);
		} else if (userRole.equals("mg")) {
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadDetailsGeneral(fromDate, toDate);
			request.setAttribute("LEADLIST", leadList);
		} else if (fjtuser.getSubordinatesDetails() > 0 && !userRole.equals("mkt") && !userRole.equals("mg")) {

			String salesEngineerList = salesLeadsDbUtil.getSalesEngListfor_Dm(empCode);
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadDetailsForDM(empCode, salesEngineerList, fromDate,
					toDate);
			request.setAttribute("LEADLIST", leadList);
		} else {

			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadDetailsForSalesEng(empCode, fromDate, toDate);
			request.setAttribute("LEADLIST", leadList);
		}

		request.setAttribute("defaultStartDate", fromDate);
		request.setAttribute("defaultEndDate", toDate);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/SalesLeads.jsp");
		dispatcher.forward(request, response);
	}

	private void getStage2ProjectList(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// get stage 2 project list
		String projectCode = request.getParameter("cd1");
		// System.out.println("PROJECT CODE "+projectCode);
		List<MktSalesLeads> projectList = salesLeadsDbUtil.getStage2ProjectDetails(projectCode);
		response.setContentType("application/json");
		new Gson().toJson(projectList, response.getWriter());

	}

	private void viewDetails(HttpServletRequest request, HttpServletResponse response, String empCode, String userRole)
			throws SQLException, ServletException, IOException {
		// view the details of particular leads without edit option
		// System.out.println("view");
		int id = Integer.parseInt(request.getParameter("lddi"));
		// System.out.println("ID "+id);
		int process1 = Integer.parseInt(request.getParameter("p1"));
		int process2 = Integer.parseInt(request.getParameter("p2"));
		int process3 = Integer.parseInt(request.getParameter("p3"));
		int process4 = Integer.parseInt(request.getParameter("p4"));
		String saleEng_Emp_Code = request.getParameter("edocpmees");

		if (userRole.equals("mg") || userRole.equals("mkt")) { // System.out.println("1");
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadsForEdit(id);
			request.setAttribute("LEADLIST", leadList);

		} else if ((!userRole.equals("mg") && !userRole.equals("mkt")) && ( saleEng_Emp_Code.equals(empCode) || empCode.equals(salesLeadsDbUtil.checkDMorNot(saleEng_Emp_Code)) )
				&& process1 == 1) {
			// System.out.println("2");
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadsForEdit(id);
			request.setAttribute("LEADLIST", leadList);
		} else {
			// System.out.println("3");
			request.setAttribute("MSG", "You don't have permission to view this leads");
		}

		request.setAttribute("P1", process1);
		request.setAttribute("P2", process2);
		request.setAttribute("P3", process3);
		request.setAttribute("P4", process4);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/ViewSalesLeadsForm.jsp");
		dispatcher.forward(request, response);
	}

	private void getDivisionProductList(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// get procut lsit based on division code
		String division = request.getParameter("cd1");
		List<MktSalesLeads> productList = salesLeadsDbUtil.getProductList(division);
		response.setContentType("application/json");
		new Gson().toJson(productList, response.getWriter());

	}

	private void goToLeads(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		String startDate, toDate;
		int currYear = Calendar.getInstance().get(Calendar.YEAR);
		int currMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
		int currDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		int fetchStartDate = currMonth - 6;
		if (currMonth < 10) {
			if (currMonth >= 7) {
				startDate = "01-0" + fetchStartDate + "-" + currYear;
			} else {
				startDate = "01-01-" + currYear;
			}
			toDate = currDay + "-0" + currMonth + "-" + currYear;
		} else {
			startDate = "01-0" + fetchStartDate + "-" + currYear;
			toDate = currDay + "-" + currMonth + "-" + currYear;
		}

		processLeadRequest(request, response, empployee_Code, userRole, startDate, toDate);

	}

	private void listLeads(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		goToLeads(request, response, empployee_Code, userRole);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// its dealing with edit form
		int id = Integer.parseInt(request.getParameter("lddi"));
		int process1 = Integer.parseInt(request.getParameter("p1"));
		int process2 = Integer.parseInt(request.getParameter("p2"));
		int process3 = Integer.parseInt(request.getParameter("p3"));
		int process4 = Integer.parseInt(request.getParameter("p4"));
		// int processCount= Integer.parseInt(request.getParameter("pCount"));
		String saleEng_Emp_Code = request.getParameter("edocpmees");
		String typeCode = request.getParameter("typeCode");
		// System.out.println("Lead id "+id);
		// System.out.println("P1 "+process1+" p2 "+process2+" p3 "+process3+" p4
		// "+process4);
		// System.out.println("SE EMP CODE "+saleEng_Emp_Code);

		if (!userRole.equals("mg") && userRole.equals("mkt")
				&& ((process1 == 1 && process2 == 1 && (process3 == 1 || process3 == 2) && process4 == 0)
						|| (process1 == 1 && process2 == 2 && process3 == 0 && process4 == 0))) {
			// close lead edit
			// System.out.println("close lead ");
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadsForEdit(id);
			request.setAttribute("LEADLIST", leadList);

		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && saleEng_Emp_Code.equals(empployee_Code)
				&& process1 == 1 && process2 == 0 && process3 == 0 && process4 == 0) {
			// sales engineer acknowledgment p2
			// System.out.println("acknwledgment by se ");
			List<MktConfig> acknowledgmentList = salesLeadsDbUtil.getAcknowledgmentLists(typeCode, 2);
			request.setAttribute("ACKLIST", acknowledgmentList);
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadsForEdit(id);
			request.setAttribute("LEADLIST", leadList);
		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && saleEng_Emp_Code.equals(empployee_Code)
				&& process1 == 1 && process2 == 1 && (process3 == 0 || process3 == 3) && process4 == 0) {
			// sales engineer lead edit p3
			// System.out.println("follow up sales engineer ");
			List<MktConfig> acknowledgmentList = salesLeadsDbUtil.getAcknowledgmentLists(typeCode, 3);
			request.setAttribute("ACKLIST", acknowledgmentList);
			List<MktSalesLeads> leadList = salesLeadsDbUtil.getLeadsForEdit(id);
			request.setAttribute("LEADLIST", leadList);
			List<Mkt_SEFollowUp> sefpDetails = salesLeadsDbUtil.getSalesEngineerFollowUpAckStageWiseDetails(id);
			request.setAttribute("SEFPDTLS", sefpDetails);

		} else {

			request.setAttribute("MSG", "You don't have permission to edit this leads");
		}

		request.setAttribute("P1", process1);
		request.setAttribute("P2", process2);
		request.setAttribute("P3", process3);
		request.setAttribute("P4", process4);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/marketing/EditSalesLeadsForm.jsp");
		dispatcher.forward(request, response);
	}

	private void deleteLead(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// delete lead, only permmision for mkt user
		String id = request.getParameter("lddi");
		if (userRole.equals("mkt")) {
			salesLeadsDbUtil.deleteLead(id);
			// System.out.println("Successfuly deleted lead "+id+" by "+empployee_Code);
			request.setAttribute("MSG", "Successfully deleted lead");
		} else {
			request.setAttribute("MSG", "You don't have permission to delete   lead");
		}
		goToLeads(request, response, empployee_Code, userRole);
	}

	private void updateLead(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws SQLException, ServletException, IOException {
		// its dealing with update rquest from update form
		int updateStatus = 0;
		double offerValue = 0;
		String id = request.getParameter("lddi");
		int process1 = Integer.parseInt(request.getParameter("p1"));
		int process2 = Integer.parseInt(request.getParameter("p2"));
		int process3 = Integer.parseInt(request.getParameter("p3"));
		int process4 = Integer.parseInt(request.getParameter("p4"));
		// int processCount = Integer.parseInt(request.getParameter("pCount"));
		String leadUnificationCode = request.getParameter("ldCode");
		String leadType = request.getParameter("ldTyp");
		String saleEng_Emp_Code = request.getParameter("edocpmees");
		String saleEngName = request.getParameter("seg");
		String processDescription = request.getParameter("p2ackDesc");

		// System.out.println("P1= "+process1+" P2= "+process2+" P3= "+process3+" P4=
		// "+process4+" "+userRole);

		if (!userRole.equals("mg") && userRole.equals("mkt")
				&& ((process1 == 1 && process2 == 1 && process3 == 1 && process4 == 0)
						|| (process1 == 1 && process2 == 2 && process3 == 0 && process4 == 0)
						|| (process1 == 1 && process2 == 1 && process3 == 2 && process4 == 0))) {
			// proccess 4, but sales engineer not done the follow up, so the lead is not
			// success
			// procees 4 after sales engineer updates with completed status
			// System.out.println("4 ");
			String remarks = request.getParameter("mktRemarks");
			String status = request.getParameter("mktStstus");

			MktSalesLeads followup_Details = new MktSalesLeads(id, leadUnificationCode, saleEng_Emp_Code, saleEngName,
					remarks, status, empployee_Code);
			updateStatus = salesLeadsDbUtil.closeLead(followup_Details);

			if (updateStatus == 1) {
				salesLeadsDbUtil.sendCloseLeadMailToSalesEngineerProcees4(followup_Details, saleEng_Emp_Code, leadType);
				request.setAttribute("MSG", "Lead Closed Successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && saleEng_Emp_Code.equals(empployee_Code)
				&& process1 == 1 && process2 == 0 && process3 == 0 && process4 == 0) {
			// process 2 by sales engineer acknowledgment
			// sales engineer acknowledgment process 2
			// System.out.println("2 ");
			String remarks = request.getParameter("ackRemarks");
			String status = request.getParameter("p2Update");
			// System.out.println("ACK STATUS "+status);
			MktSalesLeads ack_Details = new MktSalesLeads(id, leadUnificationCode, remarks, status, saleEng_Emp_Code,
					saleEngName);
			if (Integer.parseInt(status) == 1) {
				updateStatus = salesLeadsDbUtil.updateSalesEngineerAcknowledgmentTxn(ack_Details, processDescription);
			} else {
				updateStatus = salesLeadsDbUtil.updateSalesEngineerAcknowledgment(ack_Details, processDescription);
			}

			// System.out.println("UPDATE STATUS "+updateStatus);
			if (updateStatus == 1) {
				salesLeadsDbUtil.sendAcknowledgmentMailToMktProcees2(ack_Details, leadType, processDescription, empployee_Code);
				request.setAttribute("MSG", "Lead Acknowledged Successfully");
			} else {
				request.setAttribute("MSG", "Something went wrong, please try again later");
			}

		} else if (!userRole.equals("mg") && !userRole.equals("mkt") && saleEng_Emp_Code.equals(empployee_Code)
				&& process1 == 1 && process2 == 1 && (process3 == 0 || process3 == 3) && process4 == 0) {
			// process 3 after sales engineer acknowledgment
			int newFollowUpStage = 0;
			// System.out.println("process 3 after sales engineer acknowledgment");
			String seremarks = request.getParameter("seremarks");
			String soNumber = request.getParameter("soNum");
			String projectCode = request.getParameter("prjctCode");
			String offerValueParam = request.getParameter("offerval");
			String loi = request.getParameter("loi");
			String lpo = request.getParameter("lpo");
			String status = request.getParameter("p3Update");
			int mailSendYn = Integer.parseInt(request.getParameter("p3FupMailYn"));
			String p3AckDesc = request.getParameter("p3FupAckDesc");
			int lastFollowupSubStage = Integer.parseInt(request.getParameter("lastProccssedFp"));
			int fpProcessId = Integer.parseInt(request.getParameter("processId"));
			int fpProceesStatus = Integer.parseInt(status);
			newFollowUpStage = lastFollowupSubStage + 1;

			// System.out.println(" process 3 update value "+status);
			if (offerValueParam != null && !offerValueParam.isEmpty()) {
				offerValue = Double.parseDouble(offerValueParam);
			}

			MktSalesLeads followup_Details = new MktSalesLeads(id, leadUnificationCode, soNumber, projectCode,
					offerValue, loi, lpo, seremarks, status, saleEng_Emp_Code, saleEngName, p3AckDesc);
			updateStatus = salesLeadsDbUtil.updateSalesEngineerFollowup(followup_Details, newFollowUpStage, fpProcessId,
					fpProceesStatus);

			sendMailToMarketingTeam(request, response, updateStatus, leadType, followup_Details, p3AckDesc, mailSendYn,
					status, fpProceesStatus, newFollowUpStage,empployee_Code );

		} else {
			// System.out.println("4");
			request.setAttribute("MSG", "You don't have permission to edit this leads");
		}
		goToLeads(request, response, empployee_Code, userRole);
	}

	private void sendMailToMarketingTeam(HttpServletRequest request, HttpServletResponse response, int updateStatus,
			String leadType, MktSalesLeads followup_Details, String p3AckDesc, int mailSendYn, String status,
			int fpProceesStatus, int newFollowUpStage, String empployee_Code) {
		// System.out.println("db updateStatus "+updateStatus);
		// System.out.println(" "+fpProceesStatus+" "+newFollowUpStage);
		String processWorkingStatus = "";
		if (updateStatus == 1 && mailSendYn == 1) {
			if (fpProceesStatus == 3 && newFollowUpStage == 1) {
				processWorkingStatus = "UPDATED";
			} else if (fpProceesStatus == 1 && newFollowUpStage == 3) {
				processWorkingStatus = "COMPLETED";
			} else {
				processWorkingStatus = "COMPLETED";
			}
			salesLeadsDbUtil.sendFollowupMailToMktProcees3(followup_Details, leadType, p3AckDesc, processWorkingStatus, empployee_Code);
			request.setAttribute("MSG", "Sales Lead followup Updated Successfully!.");
		} else if (updateStatus == 1 && Integer.parseInt(status) == 2) {
			request.setAttribute("MSG", "Sales Lead Followup Updated Successfully!.");
		} else {
			request.setAttribute("MSG", "Something went wrong, please try again later");
		}

	}

	private void createNewLead(HttpServletRequest request, HttpServletResponse response, String empployee_Code,
			String userRole) throws ServletException, IOException, SQLException {
		// Create new Consultant lead or retrofit lead only have permission for "mkt"
		// users
		// System.out.println("ENTERED TO LOOP ");
		if (userRole.equals("mkt")) {
			// System.out.println("ENTERED TO MKT ");
			int rowCount = 0;
			int successCount = 0;
			String[] leadCode = request.getParameterValues("hidden_lead_code[]");
			String[] leadType = request.getParameterValues("hidden_lead_type[]");
			String[] division = request.getParameterValues("hidden_division[]");
			String[] productLists = request.getParameterValues("hidden_products[]");
			String[] salesEngEmpCode = request.getParameterValues("hidden_segCode[]");
			String[] salesEngName = request.getParameterValues("hidden_segDtls[]");
			String[] projectDetails = request.getParameterValues("hidden_project_details[]");
			String[] contractor = request.getParameterValues("hidden_contractor[]");
			String[] consultant = request.getParameterValues("hidden_consultant[]");
			String[] remarks = request.getParameterValues("hidden_remarks[]");
			String[] leadDesc = request.getParameterValues("hidden_leadType_desc[]");
			String[] noOfProcess = request.getParameterValues("hidden_no_of_process[]");
			String[] quotedDivisions = request.getParameterValues("hidden_qtd_divisions[]");
			String[] stage2ProjectCode = request.getParameterValues("hidden_s2_prjctCode[]");
			if (leadCode == null) {
				// System.out.println("ENTERED TO NULL");
				request.setAttribute("MSG", " Please add lead List");
			} else {
				// System.out.println("ENTERED TO ELSE ");
				List<MktSalesLeads> leadList = new ArrayList<>();
				// System.out.println("length. "+leadCode.length);
				// System.out.println("START");
				for (int i = 0; i < leadCode.length; i++) {
					// System.out.println("ENTERED TO FOR LOOP "+i+" number of process =
					// "+noOfProcess[i]);
					rowCount = rowCount + 1;
					// System.out.println(" lead code "+leadCode[i]);
					leadList.add(new MktSalesLeads(leadCode[i], leadDesc[i], division[i], productLists[i],
							salesEngEmpCode[i], salesEngName[i], projectDetails[i], remarks[i], consultant[i],
							contractor[i], empployee_Code, leadType[i], noOfProcess[i], quotedDivisions[i],
							stage2ProjectCode[i]));
				}
				// System.out.println("END");
				String location = salesLeadsDbUtil.getSalesLocation(empployee_Code);
				if(location != null && !location.isEmpty()) {
				successCount = salesLeadsDbUtil.insertLeads(leadList, location);
				}else {
					successCount = 0;
				}
				// System.out.println("ROW COUNT.- "+rowCount+" Success "+successCount);
				if (successCount == rowCount) {
					// System.out.println("ENTERED TO SUCCES AND ROW OUNT EQUAL");
					Iterator<MktSalesLeads> iterator = leadList.iterator();
					while (iterator.hasNext()) {
						// System.out.println("ENTERED TO SUCCES AND ROW OUNT EQUAL WHILE LOOP ");
						MktSalesLeads theLData = (MktSalesLeads) iterator.next();
						salesLeadsDbUtil.sendMailToSalesEngineerProcees1(theLData, empployee_Code);
						// int mailSendStatus =
						// salesLeadsDbUtil.sendMailToSalesEngineerProcees1(theLData);
						// System.out.println("MARKETING Mail Send Status- P2 "+mailSendStatus);
					}

				} else {
					request.setAttribute("MSG", "Something went wrong, please try again later!");
				}

			}

		} else {
			request.setAttribute("MSG", "Something went wrong, please try again later!");

		}

		goToLeads(request, response, empployee_Code, userRole);
	}

}
