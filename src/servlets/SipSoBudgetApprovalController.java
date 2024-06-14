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

import beans.SalesOrder_Budget;
import beans.fjtcouser;
import utils.BudgetApprovalMailDbutil;

/**
 * Servlet implementation class SipSoBudgetApprovalController
 */
@WebServlet("/SOBudgetController.jsp")
public class SipSoBudgetApprovalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BudgetApprovalMailDbutil budgetApprovalMailDbutil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SipSoBudgetApprovalController() {
		super();
		budgetApprovalMailDbutil = new BudgetApprovalMailDbutil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		int soBdgApprvAuthentication = 0;
		String approver_Emp_Code = fjtuser.getEmp_code();// employee code of budget approver, check the employee is
															// valid or not
		String approverMailId = fjtuser.getEmailid();// fetch the email id f the approver/employee

		// check the mail id is present in FJPORTAL.FJT_OTHSOB_PGM table
		soBdgApprvAuthentication = budgetApprovalMailDbutil.checkSoBudgetApproverAuthentication(approverMailId);

		if (soBdgApprvAuthentication <= 0 && fjtuser.getSubordinatesDetails() <= 0) {

			// if not present then redirect the page to home (calendar.jsp)
			// the approver details is FJPORTAL.FJT_OTHSOB_PGM handle from this table, if
			// the DM goes to leave ,
			// change the email id of the corresponding so code to new employee
			// in front end all the SO's display for mail id present in
			// FJPORTAL.FJT_OTHSOB_PGM
			// in the DM assign criteria the previous DM can only approve the SO's with
			// their email id present in transaction table (SO_BDG_APPR)

			// System.out.println("entered non authorized user");
			response.sendRedirect("homepage.jsp");
			return;
		} else {
			 

			// Page access only for employee who's mail id in Master table
			// FJPORTAL.FJT_OTHSOB_PGM and DM's also

			String theSipCode = request.getParameter("octjf"); 
			

			if (theSipCode == null) {
				if (fjtuser.getRole().equals("mg")) { // if the User is CEO / GM

					theSipCode = "tnmgmoec";
				}else {
				theSipCode = "bdg_dafult";
				}
			}

			// System.out.println("CODE "+theSipCode+" ROLE:"+fjtuser.getRole());
			switch (theSipCode) {

			case "bdg_dafult":// budget default
				try {
					if (soBdgApprvAuthentication == 1) {
						// if the mail id present in master table FJPORTAL.FJT_OTHSOB_PGM
						getNotUpdatedSoBudgetRequestsFeaturesMaster(request, response, approver_Emp_Code,
								approverMailId);
					} else {
						// if the emaild is not presented in FJPORTAL.FJT_OTHSOB_PGM master table, but
						// the employee is DM, then fetch the
						// all sales order with the email id (ie SO_BDG_APPR table, SOB_DM_EMAIL is
						// present)
						getNotUpdatedSoBudgetRequestsFeaturesTxn(request, response, approver_Emp_Code, approverMailId);
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "evorppa":// approve
				try {
					
					approveSoBudget(request, response, approver_Emp_Code, approverMailId, soBdgApprvAuthentication);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "tcejer":// reject
				try {
					rejectSOBudget(request, response, approver_Emp_Code, approverMailId, soBdgApprvAuthentication);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "tnmgmoec":// Sales Order for CEO
				try {
					getNewSOBudgetApprovalRowsForMngmnt(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToSOBudgetApproveDashboard(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	private void getNewSOBudgetApprovalRowsForMngmnt(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// Then fetch the all Sales order that not approved, from there also fetch the
		// corresponding budget expense of each sales order
		List<SalesOrder_Budget> theNotUpdatedSODtList = budgetApprovalMailDbutil.getNewSOBudgetApprovalRowsForCeo();
		request.setAttribute("NUSOBR", theNotUpdatedSODtList);
		goToSOBudgetApproveDashboard(request, response);

	}

	private void getNotUpdatedSoBudgetRequestsFeaturesMaster(HttpServletRequest request, HttpServletResponse response,
			String approver_Emp_Code, String approverMailId) throws SQLException, ServletException, IOException {

		// first fetch the all "SO CODE" from master table FJPORTAL.FJT_OTHSOB_PGM by
		// email id
		List<SalesOrder_Budget> soBdg_SOCode = budgetApprovalMailDbutil.getSOBudgetSOCode(approverMailId);
		String soBdg_MasterSOCode = soBdgtConvertToString(soBdg_SOCode);

		// Then fetch the all Sales order that not approved, from there also fetch the
		// corresponding budget expense of each sales order
		List<SalesOrder_Budget> theNotUpdatedSODtList = budgetApprovalMailDbutil
				.getNewSOBudgetApprovalRowsMaster(soBdg_MasterSOCode);
		request.setAttribute("NUSOBR", theNotUpdatedSODtList);
		goToSOBudgetApproveDashboard(request, response);

	}

	private String soBdgtConvertToString(List<SalesOrder_Budget> soBdg_SOCode) {
		StringBuilder builder = new StringBuilder();
		// Append all String in StringBuilder to the StringBuilder.
		for (SalesOrder_Budget sbb : soBdg_SOCode) {
			builder.append("'");
			builder.append(sbb.getSo_code());
			builder.append("'");
			builder.append(",");
		}
		// Remove last delimiter with setLength.
		builder.setLength(builder.length() - 1);
		String soBdg_MasterSOCode = builder.toString();
		// System.out.println("nufi "+soBdg_MasterSOCode);
		return soBdg_MasterSOCode;

	}

	private void getNotUpdatedSoBudgetRequestsFeaturesTxn(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code, String mailId) throws ServletException, IOException, SQLException {

		List<SalesOrder_Budget> theNotUpdatedSODtList = budgetApprovalMailDbutil.getNewSOBudgetApprovalRowsTxn(mailId);
		request.setAttribute("NUSOBR", theNotUpdatedSODtList);
		goToSOBudgetApproveDashboard(request, response);
	}

	private void rejectSOBudget(HttpServletRequest request, HttpServletResponse response, String apprvr_Emp_Code,
			String approverMailId, int soBdgApprvAuthentication) throws SQLException, ServletException, IOException {
		String updateRejected = "N";
		int result = -2;// variable for budget rejected status

		String so_id = request.getParameter("diqinu");
		String so_code = request.getParameter("docos");
		String so_number = request.getParameter("umnos");

		// update rejected variable with database updated operation status
		result = budgetApprovalMailDbutil.updateApproveRejectStatus(so_id, apprvr_Emp_Code, updateRejected);
		if (result == 1) {
			// if the so budget sheet rejected successfully, then send reply mail with
			// rejected status to the sales egr: and secretary
			request.setAttribute("MSG", "<b style='color:green;'> SO Budget :" + so_code + "-" + so_number
					+ " is Rejected successfully. Thank You .</b>");
			int rejectResult = budgetApprovalMailDbutil.sendApprovalOrRejectStatusReplyMail(so_id, updateRejected);
			System.out.println("Reply MAIL Rejected SEND status? " + rejectResult);
		} else {

			request.setAttribute("MSG", "<b style='color:red;'> SO Budget :" + so_code + "-" + so_number
					+ " is not Rejected, Please try again later. Thank You .</b>");
		}

		// then check there is any So budget request, then its show
		if (soBdgApprvAuthentication == 1) {
			getNotUpdatedSoBudgetRequestsFeaturesMaster(request, response, apprvr_Emp_Code, approverMailId);
		} else {
			getNotUpdatedSoBudgetRequestsFeaturesTxn(request, response, apprvr_Emp_Code, approverMailId);
		}
	}

	private void approveSoBudget(HttpServletRequest request, HttpServletResponse response, String apprvr_Emp_Code,
			String mailId, int soBdgApprvAuthentication) throws SQLException, ServletException, IOException {
		// System.out.println("mailId "+mailId+" soBdgApprvAuthentication "+soBdgApprvAuthentication);
		String updateApproved = "Y";
		int result = -2;// variable for budget approved status
		String so_id = request.getParameter("diqinu");
		String so_code = request.getParameter("docos");
		String so_number = request.getParameter("umnos");
       
		result = budgetApprovalMailDbutil.updateApproveRejectStatusDashboard(so_id, apprvr_Emp_Code, updateApproved);
		if (result == 1) {
			// if the so budget sheet rejected successfully, then send reply mail with
			// rejected status to the sales egr: and secretary
			request.setAttribute("MSG", "<b style='color:green;'> SO Budget :" + so_code + "-" + so_number
					+ " is Approved successfully. Thank You .</b>");
			int aaproveResult = budgetApprovalMailDbutil.sendApprovalOrRejectStatusReplyMail(so_id, updateApproved);
			System.out.println("Reply Mail Approve SEND status? " + aaproveResult);

		} else {

			request.setAttribute("MSG", "<b style='color:red;'> SO Budget :" + so_code + "-" + so_number
					+ " is not Approved, Please try again later. Thank You .</b>");
		}

		// then check there is any So budget request, then its show
		if (soBdgApprvAuthentication == 1) {
			getNotUpdatedSoBudgetRequestsFeaturesMaster(request, response, apprvr_Emp_Code, mailId);
		} else {
			getNotUpdatedSoBudgetRequestsFeaturesTxn(request, response, apprvr_Emp_Code, mailId);
		}

	}

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

	private void goToSOBudgetApproveDashboard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/SoBdgApprvlPrtl.jsp");
		dispatcher.forward(request, response);

	}
}
