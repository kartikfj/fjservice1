package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.SipJihDues;
import beans.fjtcouser;
import utils.SipJihDuesDbUtil;

/**
 * Servlet implementation class SipQtnLost.. its for handling sales engineer jih
 * details to mark as lost
 */
@WebServlet("/SipJihDues")
public class SipJihDueController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipJihDuesDbUtil sipJihDuesDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		sipJihDuesDbUtil = new SipJihDuesDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {
			String sales_eng_Emp_code = fjtuser.getEmp_code();
			// ALL SALES ENGINEER
			String theDataFromHr = request.getParameter("fjtco");
			if (theDataFromHr == null) {
				theDataFromHr = "dueDafult";
			}
			switch (theDataFromHr) {

			case "list":
				try {
					goToJihDue(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "dueDafult":
				getStage2LostSummaryforSE(request, response, sales_eng_Emp_code);
				break;
			case "lost":
				updateQtnToLost(request, response, sales_eng_Emp_code, fjtuser);
				break;
			case "updateStg3":
				updateQtnToHold(request, response, sales_eng_Emp_code);
				break;
			case "updatePODate":
				updatePODate(request, response, sales_eng_Emp_code);
				break;
			case "updateINVDate":
				updateINVDate(request, response, sales_eng_Emp_code);
				break;
			case "export":
				getDatatoExport(request, response, sales_eng_Emp_code);
				break;
			default:
				try {
					goToJihDue(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void updateQtnToLost(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code,
			fjtcouser fjtuser) throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String reason = request.getParameter("rsn");
		String remarkType = request.getParameter("rtyp");
		String statuschange = request.getParameter("tstuas");
		int status = sipJihDuesDbUtil.updateJIHDeQtnStatus(sysId, reason, sales_Egr_Code, remarkType, statuschange,
				fjtuser);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateQtnToHold(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String loiDateStr = request.getParameter("loidate");
		String loiAmount = request.getParameter("loiamt");
		int loiamount = 0;
		if (loiAmount != null) {
			loiamount = Integer.parseInt(loiAmount);
		}
		String remarkType = request.getParameter("rtyp");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(loiDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateQtnToHold" + ex);
		}

		int status = sipJihDuesDbUtil.updateJIHDeQtnStatusToHold(sysId, sqlDate, sales_Egr_Code, remarkType, loiamount);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void getStage2LostSummaryforSE(HttpServletRequest request, HttpServletResponse response,
			String sales_Egr_Code) throws SQLException, ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		List<SipJihDues> theDueList = null;
		if (fjtuser.getRole().equalsIgnoreCase("mg")) {
			theDueList = sipJihDuesDbUtil.getJihDueDetailsForSalesEngForMG();
		} else {
			theDueList = sipJihDuesDbUtil.getJihDueDetailsForSalesEng(sales_Egr_Code);
		}
		List<SipJihDues> remarkType = sipJihDuesDbUtil.getRemarksTypes();
		List<SipJihDues> holdRemarkType = sipJihDuesDbUtil.getHoldRemarksTypes();
		request.setAttribute("JIHDUES", theDueList);
		request.setAttribute("RTYP", remarkType);
		request.setAttribute("HRTYP", holdRemarkType);
		goToJihDue(request, response);
	}

	private void getDatatoExport(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		List<SipJihDues> theDueList = null;
		if (fjtuser.getRole().equalsIgnoreCase("mg")) {
			theDueList = sipJihDuesDbUtil.getJihDueDetailsForSalesEngForMG();
		} else {
			theDueList = sipJihDuesDbUtil.getJihDueDetailsForSalesEng(sales_Egr_Code);
		}
		response.setContentType("application/json");
		new Gson().toJson(theDueList, response.getWriter());
	}

	private void goToJihDue(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/SipJihDues.jsp");
		dispatcher.forward(request, response);

	}

	private void updatePODate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String loiDateStr = request.getParameter("podate");

		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(loiDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateQtnToHold" + ex);
		}

		int status = sipJihDuesDbUtil.updatePODate(sysId, sqlDate, sales_Egr_Code);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

	}

	private void updateINVDate(HttpServletRequest request, HttpServletResponse response, String sales_Egr_Code)
			throws SQLException, ServletException, IOException {
		String sysId = request.getParameter("qtn");
		String invDateStr = request.getParameter("invdate");

		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date loiDate;
		java.util.Date dt;
		java.sql.Date sqlDate = null;
		try {
			dt = formatter.parse(invDateStr);
			loiDate = new Date(dt.getTime());
			sqlDate = new java.sql.Date(loiDate.getTime());
		} catch (ParseException ex) {
			System.out.println("updateQtnToHold" + ex);
		}

		int status = sipJihDuesDbUtil.updateINVDate(sysId, sqlDate, sales_Egr_Code);

		response.setContentType("application/json");
		new Gson().toJson(status, response.getWriter());

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
