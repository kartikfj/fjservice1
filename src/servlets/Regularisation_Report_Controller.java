// 
// Decompiled by Procyon v0.5.36
// 

package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Approver;
import beans.Regularise_Report;
import beans.fjtcouser;
import utils.ApproverDbUtil;
import utils.RegulariseReportDbUtil;

@WebServlet({ "/Regularisation_Report" })
public class Regularisation_Report_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ApproverDbUtil approverDbUtil;
	private RegulariseReportDbUtil regulariseReportDbUtil;

	public void init() throws ServletException {
		super.init();
		this.approverDbUtil = new ApproverDbUtil();
		this.regulariseReportDbUtil = new RegulariseReportDbUtil();
	}

	protected void processRequest(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		final fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			final String appr_com_code = fjtuser.getEmp_code();
			final List<Approver> theAppaiseIdList = (List<Approver>) this.approverDbUtil
					.getSubordinatesDetails(appr_com_code);
			request.setAttribute("SUB_NAME_LIST", (Object) theAppaiseIdList);
		}
		String theDataFromHr = request.getParameter("fjtco");
		if (theDataFromHr == null) {
			theDataFromHr = "list";
		}
		final String s;
		switch (s = theDataFromHr) {
		case "report": {
			try {
				this.goToDisplayReport(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		}
		case "list": {
			try {
				this.goToRegularisePage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		}
		default:
			break;
		}
		try {
			this.goToRegularisePage(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void goToDisplayReport(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		final String startdt = request.getParameter("fromdate");
		final String enddt = request.getParameter("todate");
		final String[] employee_list = request.getParameterValues("slc");
		if (employee_list.length > 0) {
			final String emplList = String.join(",", (CharSequence[]) employee_list);
			final List<Regularise_Report> theRegularisationReportList = (List<Regularise_Report>) this.regulariseReportDbUtil
					.getregularisationreport(startdt, enddt, emplList);
			request.setAttribute("R_R_LIST", (Object) theRegularisationReportList);
			request.setAttribute("STFLRH", startdt);// start date for Leave report history
			request.setAttribute("ETFLRH", enddt);// enddate for Leave report history
		} else {
			request.setAttribute("UPDATE_MSG",
					(Object) "<div class=\"alert alert-info\">\r\n  <strong>Info!</strong> Please Complete Selection\r\n</div> ");
		}
		this.goToRegularisePage(request, response);
	}

	private void goToRegularisePage(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException {
		final RequestDispatcher dispatcher = request.getRequestDispatcher("/regularisation_report.jsp");
		dispatcher.forward((ServletRequest) request, (ServletResponse) response);
	}

	protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException {
		try {
			final fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				response.sendRedirect("logout.jsp");
			} else {
				this.processRequest(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException {
		try {
			final fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
			if (fjtuser == null) {
				response.sendRedirect("logout.jsp");
			} else {
				this.processRequest(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
