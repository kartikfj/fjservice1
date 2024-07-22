package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LeaveProcess
 * 
 * @author nufail.a
 */
@WebServlet("/LeaveProcess")
public class LeaveProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			/*  */
			// System.out.println("Processing Leave request");
			String unqid = request.getParameter("ocjtfdinu");
			String empcode = request.getParameter("edocmpe");
			String approver = request.getParameter("revorppa");
			String act = request.getParameter("dpsroe"); // response
			String typea = request.getParameter("ntac");
			String lvtype = request.getParameter("epyt");
			String stage = request.getParameter("egats");
			String lvbal = request.getParameter("lvbal");
			// String totDays = request.getParameter("totdys");

			float lvbalance = -1;
			// float totalDays = -1;

			if (lvbal != null)
				lvbalance = Float.parseFloat(lvbal);

			// if (totDays != null)
			// totalDays = Float.parseFloat(totDays);

			out.println("<html> <body align='centre'> ");
			if (unqid != null || empcode != null || act != null || approver != null && typea != null) {

				long tp = Long.parseLong(unqid);
				int status = 0;
				if (act.equals("7")) {
					status = 4;
					// System.out.println("approval received");
				} else if (act.equals("6")) {
					// System.out.println("authorisation received");
					status = 2;
				} else if (act.equals("5")) {
					// System.out.println("rejection received");
					status = 3;
				}
				if (typea.equalsIgnoreCase("grulae")) {
					if (lvtype == null || stage == null) {
						out.println("Error data received. Your response to application cannot be processed.");
					} else {

						beans.LeaveApplication lv = new beans.LeaveApplication();
						lv.setEmp_code(empcode);
						lv.setApprover(approver);
						lv.setLeavebalance(lvbalance);
						// lv.setTotaldays(totalDays);
						int procstatus = lv.processApplicationApproval(tp, status, lvtype, stage);

						if (procstatus == 1 && (status == 2 || status == 4)) {
							out.print("The approval of application is completed. </body></html>");
						} else if (procstatus == 1 && status == 3) {
							out.print("The rejection of application is completed. </body></html>");
						} else if (procstatus == -1) {
							out.print(
									"The application is already processed. Your response is discarded. </body></html>");
						} else if (procstatus == 0) {
							out.print("Could not find the application.Check if it is cancelled.");
						} else if (procstatus == -2) {
							out.print("Error in processing. Try again after some time.");
						} else if (procstatus == -3) {
							out.print(
									"Not a viable application. Not enough balance or other applications in the same timespan.");
						} else if (procstatus == -4 && (status == 4 || status == 3)) {
							out.print(
									"Your response is processed but failed to send notification mail to the applied employee. Please notify manually.");
						} else if (procstatus == -4 && (status == 2)) {
							out.print("Failed to send email. Please contact IT department");
						}
					}
				} else if (typea.equalsIgnoreCase("hsacne")) { // encash
					beans.LeaveEncashment len = new beans.LeaveEncashment();
					len.setEmp_code(empcode);
					len.setApprover_id(approver);
					int procstatus = len.processApplicationApproval(tp, status);

					if (procstatus == 1 && status == 4) {
						out.print("The approval of application is completed. </body></html>");
					} else if (procstatus == 1 && status == 3) {
						out.print("The rejection of application is completed. </body></html>");
					} else if (procstatus == -1) {
						out.print("The application is already processed. Your response is discarded. </body></html>");
					} else if (procstatus == 0) {
						out.print("Could not find the application.");
					} else if (procstatus == -2) {
						out.print("Error in processing.");
					} else if (procstatus == -3) {
						out.print(
								"Not a viable application. Not enough balance or other applications in the same timespan.");
					} else if (procstatus == -4 && (status == 4 || status == 3)) {
						out.print(
								"Your response is processed but failed to send notification mail to the applied employee. Please notify manually.");
					}
				} else if (typea.equalsIgnoreCase("raluger")) {

					beans.Regularisation regn = new beans.Regularisation();
					regn.setEmp_code(empcode);
					regn.setApprover_id(approver);
					int procstatus = regn.processApplicationApproval(tp, status);
					if (procstatus == 1 && status == 4) {
						out.print("The approval of application is completed. </body></html>");
					} else if (procstatus == 1 && status == 3) {
						out.print("The rejection of application is completed. </body></html>");
					} else if (procstatus == -1) {
						out.print("The application is already processed. Your response is discarded. </body></html>");
					}

					else if (procstatus == 0) {
						out.print("Could not find the application.");
					} else if (procstatus == -2) {
						out.print("Error in processing.");
					} else if (procstatus == -3) {
						out.print("Not a viable application.");
					}

				} else if (typea.equalsIgnoreCase("rpiubnst")) {// Businesstrip leave application approve
					int reqid = 0;
					if (request.getParameter("reqid") != null && !request.getParameter("reqid").isEmpty()) {
						reqid = Integer.parseInt(request.getParameter("reqid"));
					}
					System.out.println("generated Id== " + reqid);
					beans.BusinessTripLVApplication bsntrip = new beans.BusinessTripLVApplication();
					bsntrip.setEmp_code(empcode);
					bsntrip.setApprover_eid(approver);
					bsntrip.setReq_id(reqid);
					int procstatus = bsntrip.processBusinesstripApplicationApproval(tp, status);
					if (procstatus == 1 && status == 4) {
						out.print("The approval of application is completed. </body></html>");
					} else if (procstatus == 1 && status == 3) {
						out.print("The rejection of application is completed. </body></html>");
					} else if (procstatus == -1) {
						out.print("The application is already processed. Your response is discarded. </body></html>");
					}

					else if (procstatus == 0) {
						out.print("Could not find the application.");
					} else if (procstatus == -2) {
						out.print("Error in processing.");
					} else if (procstatus == -3) {
						out.print("Not a viable application.");
					}

				}
			} else {
				out.println("Error data received. Your response to application cannot be processed.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error occured in processing request.");
		} finally {
			out.close();
		}
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
	// + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request  servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException      if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
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
		processRequest(request, response);
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

}
