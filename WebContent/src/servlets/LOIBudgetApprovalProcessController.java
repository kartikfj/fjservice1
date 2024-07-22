package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.LOIBudgetApprovalMailDbutil;

/**
 * Servlet implementation class LOIBudgetApprovalProcessController
 */
@WebServlet(name = "LOIProcess", urlPatterns = { "/LOIProcess" })
public class LOIBudgetApprovalProcessController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LOIBudgetApprovalMailDbutil loibudgetApprovalMailDbutil;

	/**
	 * @throws ServletException
	 * @see HttpServlet#HttpServlet()
	 */
	public LOIBudgetApprovalProcessController() throws ServletException {
		super();

		try {
			loibudgetApprovalMailDbutil = new LOIBudgetApprovalMailDbutil();

		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// This servlet for handling approval and rejection request from DM Mail (From
		// inside Mail)
		String so_created_dt = request.getParameter("ctjfdiu");
		String so_id = request.getParameter("gjfissb");
		String approver = request.getParameter("revorppa");
		String operation_type = request.getParameter("pt");

		if (!approver.equals("null") && !so_created_dt.equals("null") && !operation_type.equals("null")) {
			int requsetSOStatus = 0;

			// check so_id is present or not
			requsetSOStatus = loibudgetApprovalMailDbutil.soStatus(so_id);

			System.out.println("SO BUDGET STATUS of APPLICATION : " + requsetSOStatus);
			if (requsetSOStatus >= 1) {
				// System.out.println("Enter in to loop");
				// check the request for approve or reject
				switch (operation_type) {
				case "1":
					String updateApproved = "Y";
					int result = -2;
					// update approved status is Y, ie Budget is Accepted
					result = loibudgetApprovalMailDbutil.updateApproveRejectStatus(so_id, approver, updateApproved);
					// System.out.println("UPDATE RESULT "+result);
					if (result == 1) {
						int aaproveResult = loibudgetApprovalMailDbutil.sendApprovalOrRejectStatusReplyMail(so_id,
								updateApproved);
						System.out.println("Reply Mail Approve SEND Status : ? = " + aaproveResult);
						request.setAttribute("MSG",
								"<b style='color:green;'> LOI Budget is Approved successfully. Thank You .</b>"
										+ "<footer>Copyright © FJ-Group</footer>");
					}
					goToBDAORView(request, response);
					break;
				case "2":
					String updateRejected = "N";
					// Update approve status is N, ie Budget is Rejected
					result = loibudgetApprovalMailDbutil.updateApproveRejectStatus(so_id, approver, updateRejected);
					// System.out.println("UPDATE RESULT "+result);
					if (result == 1) {
						int rejectResult = loibudgetApprovalMailDbutil.sendApprovalOrRejectStatusReplyMail(so_id,
								updateRejected);
						System.out.println("Reply MAIL Rejected SEND? " + rejectResult);
						request.setAttribute("MSG",
								"<b style='color:green;'> LOI Budget is Rejected Successfully. Thank You .</b>"
										+ "<footer>Copyright © FJ-Group</footer>");
					}

					goToBDAORView(request, response);
					break;
				default:
					request.setAttribute("MSG",
							"<b style='color:red;'>Could not find the application for particular request or its allready approved or rejected .Check if it is cancelled.</b>"
									+ "<footer>Copyright © FJ-Group</footer>");
					goToBDAORView(request, response);
					break;
				}
			} else {
				System.out.println(
						"Could not find the application for particular request or its allready approved or rejected. Please Check again .");
				request.setAttribute("MSG",
						"<b style='color:red;'>Could not find the application for particular request or its allready approved or rejected. Please Check again.</b>"
								+ "<footer>Copyright © FJ-Group</footer>");
				goToBDAORView(request, response);

			}

		}

	}

	private void goToBDAORView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // Budget Approval Or Reject View
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bdgaor.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			if (request.getParameterMap().containsKey("ctjfdiu") && request.getParameterMap().containsKey("gjfissb")
					&& request.getParameterMap().containsKey("revorppa")
					&& request.getParameterMap().containsKey("pt")) {
				processRequest(request, response);
			} else {

				request.setAttribute("MSG",
						"<center><b style='color:red;'>404 Not Found.</b>"
								+ "<span><br/>This link  is unavailable.</span>" + "<div id='infolist'><ul>"
								+ "<li>Not a Valid Link.</li>" + "<li>Please try a valid  URL.</li>" + "</ul><div>"
								+ "<footer>" + "Copyright © FJ-Group" + "</footer></center>");
				goToBDAORView(request, response);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			processRequest(request, response);
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
	}

}
