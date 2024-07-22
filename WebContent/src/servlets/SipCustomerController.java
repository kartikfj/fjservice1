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
import com.google.gson.Gson;
import com.google.gson.JsonIOException; 

import beans.SipCustomer;
import beans.SipCustomerPaymentTermHistory;
import beans.SipDivJihvSummary;
import beans.SipDivPdcOnHand; 
import beans.SipLCSignaturePending;
import beans.fjtcouser;
import utils.SipChartCustomerDbUtil;
import utils.SipDivisionChartDbUtil;

/**
 * Servlet implementation class SipCustomerController
 */

@WebServlet("/sipCustomer")
public class SipCustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SipChartCustomerDbUtil sipChartCustomerDbUtil;
	private SipDivisionChartDbUtil sipDivChartDbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		sipChartCustomerDbUtil = new SipChartCustomerDbUtil();
		sipDivChartDbUtil = new SipDivisionChartDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String dm_Emp_Code = fjtuser.getEmp_code();
		List<SipDivJihvSummary> theDivisionList = sipDivChartDbUtil.getDivisionListforDM(dm_Emp_Code);
		request.setAttribute("DIVLST", theDivisionList);
		String theSipCode = request.getParameter("octjf");// fjtco...for handling which service is needed to be display
															// in front view
		if (theSipCode == null) {
			theSipCode = "sip_default";
		}
		switch (theSipCode) {

		case "sip_default":
			try {
				defaultCustomerView(request, response, dm_Emp_Code);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "dtlspscl":// Lc signature pending details
			try {
				getCustomerLCSignaturePndgDivisionWise(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "dtlspacl":// Lc acceptance details
			try {
				getCustomerLCAcceptanceDivisionWise(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "dtlscdp":// PDC Details details
			try {
				getCustomerPDCDetails(request, response, dm_Emp_Code);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "pbobohatpwc":// Customer wise Payment terms and History of Bounced or bad payment
			try {
				getCustomerPaymentTermsndHistory(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "tsltcjrp2s":// stage 2 project lists
			try {
				getCustomerProjectListAcrossAllDivision(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			try {
				goToSipCustomer(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void getCustomerPDCDetails(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws SQLException, JsonIOException, IOException {
		List<SipDivPdcOnHand> thePDCList = sipChartCustomerDbUtil.getPdcOnHand(dm_Emp_Code);
		response.setContentType("application/json");
		new Gson().toJson(thePDCList, response.getWriter());

	}
 
	private void getCustomerPaymentTermsndHistory(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {

		List<SipCustomerPaymentTermHistory> theLCPList = sipChartCustomerDbUtil.getCustomerPaymentTermsHistory();
		response.setContentType("application/json");
		new Gson().toJson(theLCPList, response.getWriter());

	}

	private void defaultCustomerView(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws ServletException, IOException, SQLException {

		// List<SipJihvSummary>
		// theSalesEngList=sipChartCustomerDbUtil.getSalesEngListfor_Dm(dm_Emp_Code);
		// request.setAttribute("SEngLst", theSalesEngList);
		// getCustomerVisitDetails(request,response);
		// getCustomerProjectListAcrossAllDivision(request,response);
		goToSipCustomer(request, response);
	}

	private void getCustomerLCAcceptanceDivisionWise(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String[] division_list = request.getParameterValues("nsvDdtcls");

		if (division_list.length > 0) {
			String divisionList = String.join(",", division_list);
			System.out.println("div list  " + divisionList);
			List<SipLCSignaturePending> theLCPList = sipChartCustomerDbUtil.getLCAcceptancePending(divisionList);
			response.setContentType("application/json");
			new Gson().toJson(theLCPList, response.getWriter());

		} else {

			response.setContentType("application/json");
			new Gson().toJson("Please select division", response.getWriter());
		}
	}

	private void getCustomerLCSignaturePndgDivisionWise(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {

		String[] division_list = request.getParameterValues("nsvDdtcls");
		System.out.println("div list  " + division_list);
		if (division_list.length > 0) {
			String divisionList = String.join(",", division_list);
			List<SipLCSignaturePending> theLCPList = sipChartCustomerDbUtil.getLcSignaturePending(divisionList);
			response.setContentType("application/json");
			new Gson().toJson(theLCPList, response.getWriter());

		} else {

			response.setContentType("application/json");
			new Gson().toJson("Please select division", response.getWriter());
		}

	}

	private void getCustomerProjectListAcrossAllDivision(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		List<SipCustomer> theAProjectDtlsList = sipChartCustomerDbUtil.getCustomerWiseProjectList();
		response.setContentType("application/json");
		new Gson().toJson(theAProjectDtlsList, response.getWriter());
	}

	private void goToSipCustomer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sipCustomer.jsp");
		dispatcher.forward(request, response);
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
