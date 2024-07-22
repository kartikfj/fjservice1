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

import beans.Approver;
import beans.Regularise_Report;
import beans.fjtcouser;
import utils.RegulariseReportDbUtil;

/**
 * Servlet implementation class Leave_Report_Controller
 */
@WebServlet("/Leave_Report")
public class Leave_Report_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// create a reference to appraisal self appraisal db util class

	private RegulariseReportDbUtil regulariseReportDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		regulariseReportDbUtil = new RegulariseReportDbUtil();
		try {
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");

		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {
			// Object value = request.getSession().getAttribute("fjtcouser"); //retrieve one
			// servlet (fjtcousercontrol.java) session attributes in another servlet

			String appr_com_code = fjtuser.getEmp_code();

			List<Approver> theAppaiseIdList = regulariseReportDbUtil.getSubordinatesDetails(appr_com_code);

			request.setAttribute("SUB_NAME_LIST", theAppaiseIdList);

		}
		String theDataFromHr = request.getParameter("fjtco");

		if (theDataFromHr == null) {
			theDataFromHr = "list";

		}

		switch (theDataFromHr) {
		case "list":

			try {
				goToRegularisePage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "sc_report":

			try {
				goToSickCasualReport(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:

			try {
				goToRegularisePage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void goToSickCasualReport(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// String uid=request.getParameter("uid");
		String startdt = request.getParameter("fromdate");
		String enddt = request.getParameter("todate");		
		String[] employee_list = request.getParameterValues("slc");
		String[] leave_type_list = request.getParameterValues("leavtlst");
		if (employee_list.length > 0) {
			String emplList = String.join(",", employee_list);
			String lvTypeList = String.join(",", leave_type_list);
			// System.out.println("uid "+uid+" dt1 "+startdt+" dt2 "+enddt+" list
			// "+emplList);

			List<Regularise_Report> theLeaveReportList = regulariseReportDbUtil.getSickCasualLeavereport(startdt, enddt,
					emplList, lvTypeList);

			request.setAttribute("STFLRH", startdt);// start date for Leave report history
			request.setAttribute("ETFLRH", enddt);// enddate for Leave report history
			request.setAttribute("CS_LV_LIST", theLeaveReportList);

		} else {
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-info\">\r\n"
					+ "  <strong>Info!</strong> Please Complete Selection\r\n" + "</div> ");
		}

		goToRegularisePage(request, response);
	}

	private void goToRegularisePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/leave_report.jsp");
		dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Leave_Report_Controller() {
		super();
		// TODO Auto-generated constructor stub
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