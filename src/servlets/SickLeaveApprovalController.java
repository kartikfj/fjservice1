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

import beans.LeaveApplication;
import beans.fjtcouser;

/**
 * Servlet implementation class SickLeaveApprovalController
 */
@WebServlet("/SickLeaveApproval")
public class SickLeaveApprovalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SickLeaveApprovalController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init() throws ServletException {
		super.init();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {
			String empCode = fjtuser.getEmp_code();
			String theDataFromHr = request.getParameter("fjtco");

			if (theDataFromHr == null) {
				theDataFromHr = "view";

			}

			switch (theDataFromHr) {
			case "view":

				try {
					getSickLeaveRequests(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			default:

				try {
					getSickLeaveRequests(request, response, empCode);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

	}

	private void getSickLeaveRequests(HttpServletRequest request, HttpServletResponse response, String empCode)
			throws ServletException, IOException, SQLException {
		try {
			beans.LeaveApplication lv = new beans.LeaveApplication();
			List<LeaveApplication> sicklvReq = lv.getSickLeaveRequest();
			request.setAttribute("SICKLEAVEREQ", sicklvReq);
			goToSickLeaveApprovalPage(request, response);
		} catch (Exception e) {
			System.out.println("Exception in getSickLeaveRequests" + e);
		}

	}

	private void goToSickLeaveApprovalPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sickleaveapproval.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
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
