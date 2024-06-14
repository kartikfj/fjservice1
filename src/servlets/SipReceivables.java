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

import beans.SipDivPdcOnHand;
import beans.SipOutRecvbleReprt;
import beans.fjtcouser;
import utils.SipReceivablesDbUtil;

/**
 * Servlet implementation class SipReceivables
 */
@WebServlet("/Receivables")
public class SipReceivables extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipReceivablesDbUtil sipReceivablesDbUtil;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SipReceivables() {
		super();
		sipReceivablesDbUtil = new SipReceivablesDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null || fjtuser.getSubordinatesDetails() == 0) {
			response.sendRedirect("logout.jsp");
		} else {
			String dm_Emp_Code = fjtuser.getEmp_code();
			String theSipCode = request.getParameter("octjf");// fjtco...for handling which service is needed to be
																// display in front view
			if (theSipCode == null) {
				theSipCode = "sip_dafult";
			}
			switch (theSipCode) {

			case "sip_dafult":// division oustanding recievble report default display
				try {

					getAllFeatures(request, response, dm_Emp_Code);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			default:

				try {
					goToSip(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void getAllFeatures(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws SQLException, ServletException, IOException {

		getReceivableReport(request, response, dm_Emp_Code);// outstndng rcvble report for division
		getPDCReport(request, response, dm_Emp_Code);
		goToSip(request, response);
	}

	private void getReceivableReport(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws SQLException {
		// this function for retreving sales oustanding recievable based on dm code a
		// division under him
		List<SipOutRecvbleReprt> theReceivableList = sipReceivablesDbUtil
				.getOustndngReceivableReportforDivision(dm_Emp_Code);
		request.setAttribute("DORAR", theReceivableList);

	}

	private void getPDCReport(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws SQLException {
		// this function for retreving sales oustanding recievable based on dm code a
		// division under him
		// String divList = sipReceivablesDbUtil.getDivisionListforDM(dm_Emp_Code);
		// divList = divList.substring(0, divList.length() - 1);
		// System.out.println("output : "+divList);
		List<SipDivPdcOnHand> thepdcHandList = sipReceivablesDbUtil.getPdcOnHand(dm_Emp_Code);
		request.setAttribute("PDCHAND", thepdcHandList);

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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

	private void goToSip(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sipReceivables.jsp");
		dispatcher.forward(request, response);

	}

}
