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

 
import beans.Regularise_Report;
import beans.SengAttendance;  
import beans.fjtcouser; 
import utils.SEgAttendanceDbUtil; 

/**
 * Servlet implementation class SipUserActivityController
 */
@WebServlet("/SEgAttendance")
public class SEgAttendanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SEgAttendanceDbUtil sEgAttendanceDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		sEgAttendanceDbUtil = new SEgAttendanceDbUtil();

	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null) {
			response.sendRedirect("logout.jsp");

		} else {
			List<SengAttendance> theAppaiseIdList = sEgAttendanceDbUtil.getAllActiveSegDetails();

			request.setAttribute("SUB_NAME_LIST", theAppaiseIdList);

		}
		String theDataFromHr = request.getParameter("fjtco");

		if (theDataFromHr == null) {
			theDataFromHr = "list";

		}

		switch (theDataFromHr) {
		case "list":

			try {
				goToSegAttendancePage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "report":

			try {
				goToDisplayReport(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:

			try {
				goToSegAttendancePage(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private void goToDisplayReport(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// String uid=request.getParameter("uid");
		String startdt = request.getParameter("fromdate");
		String enddt = request.getParameter("todate");
		String[] employee_list = request.getParameterValues("slc");
		if (employee_list.length > 0) {
			String emplList = String.join(",", employee_list);
			// System.out.println("uid "+uid+" dt1 "+startdt+" dt2 "+enddt+" list
			// "+emplList);

			List<Regularise_Report> theRegularisationReportList = sEgAttendanceDbUtil.getregularisationreport(startdt,
					enddt, emplList);

			request.setAttribute("R_R_LIST", theRegularisationReportList);
		} else {
			request.setAttribute("UPDATE_MSG", "<div class=\"alert alert-info\">\r\n"
					+ "  <strong>Info!</strong> Please Complete Selection\r\n" + "</div> ");
		}

		goToSegAttendancePage(request, response);
	}

	private void goToSegAttendancePage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/SEnrsAttendance.jsp");
		dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SEgAttendanceController() {
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
