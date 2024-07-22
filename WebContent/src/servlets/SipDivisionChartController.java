package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.SipDStage2LostSummary;
import beans.SipDivBillingSummary;
import beans.SipDivBookingSummary;
import beans.SipDivEnquirtToQtnAnalysis;
import beans.SipDivEnquirtToQtnLayer2Details;
import beans.SipDivEnquirtToQtnLayer3Details;
import beans.SipDivForecast;
import beans.SipDivForecastPercAccuracyDetails;
import beans.SipDivJihvSummary;
import beans.SipDivLoiToOrderLayer2Details;
import beans.SipDivLoiToSoAnalysis;
import beans.SipDivLoiToSoLayer3Details;
import beans.SipDivOrderToInvcLayer2Details;
import beans.SipDivQtnToLoiLayer2Details;
import beans.SipDivQtnToLoiLayer3Details;
import beans.SipDivQuotationToLoiAnalysis;
import beans.SipDivSoToInvoiceAnalysis;
import beans.SipDivSoToInvoiceLayer3Details;
import beans.SipDivStage2LostDetails;
import beans.SipDivisionOutstandingRecivablesDtls;
import beans.SipDmListForManagementDashboard;
import beans.SipJihvDetails;
import beans.SipLayer2SubDivisionLevelBillingDetailsYTD;
import beans.SipLayer2SubDivisionLevelBookingDetailsYTD;
import beans.SipLayer4_Pdc_On_Hand;
import beans.SipLayer4_Pdc_Re_Entry;
import beans.SipOutRecvbleReprt;
import beans.SipOutsRecvbleCustWise_Layer3Details;
import beans.Stage1Details;
import beans.Stage3Details;
import beans.Stage4Details;
import beans.fjtcouser;
import utils.SipChartDbUtil;
import utils.SipDivisionChartDbUtil;
import utils.SipDivisionChartLayer2DbUtil;
import utils.SipDivisionChartLayer3DbUtil;
import utils.SipDivisionChartLayer4DbUtil;
import utils.SipMainDivisionChartDbUtil;

/**
 * Servlet implementation class SipDivisionChartController, for managing fjtco
 * Division JIHV, Booking, Billing, stage 3, stage 4, Stock Report
 */
@WebServlet("/sipDivision") // SipDivisionChartController
public class SipDivisionChartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipDivisionChartDbUtil sipDivChartDbUtil;
	private SipDivisionChartLayer2DbUtil sipDivChartLayer2DbUtil;
	private SipDivisionChartLayer3DbUtil sipDivChartLayer3DbUtil;
	private SipDivisionChartLayer4DbUtil sipDivChartLayer4DbUtil;
	private SipMainDivisionChartDbUtil sipMainDivChartDbUtil;// for management dashboard
	private SipChartDbUtil sipChartDbUtil;// user db activity

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SipDivisionChartController() {
		super();
		sipDivChartDbUtil = new SipDivisionChartDbUtil();
		sipDivChartLayer2DbUtil = new SipDivisionChartLayer2DbUtil();
		sipDivChartLayer3DbUtil = new SipDivisionChartLayer3DbUtil();
		sipDivChartLayer4DbUtil = new SipDivisionChartLayer4DbUtil();
		sipMainDivChartDbUtil = new SipMainDivisionChartDbUtil();// for management dashboard
		sipChartDbUtil = new SipChartDbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		System.out.println("SECODE " + fjtuser.getSales_code());
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String dm_Emp_Code = fjtuser.getEmp_code();
			String theSipCode = request.getParameter("octjf");// fjtco...for handling which service is needed to be
																// display in front view
			// System.out.println("first sip code "+theSipCode);
			if (fjtuser.getRole().equalsIgnoreCase("mg") && theSipCode == null) {
				// ie sales engineer code is mG001 , ie president logged in , check the default
				// sip code , if it null just show the fetch the sales mangers list only
				getDMsListFormangmentDashboard(request, response);
				// getAllFeatures(request,response,dm_Emp_Code);
			}

			if (theSipCode == null) {
				sipChartDbUtil.insertDashboardUserHistory(fjtuser.getEmp_code(), fjtuser.getUname(),
						fjtuser.getSales_code(), fjtuser.getEmp_com_code(), fjtuser.getEmp_divn_code(),
						fjtuser.getRole());
				theSipCode = "sip_dafult";
				dm_Emp_Code = fjtuser.getEmp_code();
			} else if (theSipCode.equals("dmfsltdmd")) {// This if condition is for handling Managment dashbaod
				sipChartDbUtil.insertDashboardUserHistory(fjtuser.getEmp_code(), fjtuser.getUname(),
						fjtuser.getSales_code(), fjtuser.getEmp_com_code(), fjtuser.getEmp_divn_code(),
						fjtuser.getRole());
				getDMsListFormangmentDashboard(request, response);
				theSipCode = "sip_dafult";
				dm_Emp_Code = request.getParameter("dmCodemgmnt");

			}
			checkSalesMgrPerfTabisAllowed(request, response, dm_Emp_Code);
			request.setAttribute("DFLTDMCODE", dm_Emp_Code);

			// System.out.println("DM CODE"+dm_Emp_Code);

			switch (theSipCode) {
			case "sip_dafult":// job in hand volume summary default display
				try {
					getAllFeatures(request, response, dm_Emp_Code);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lyer2BlngDtls":// YTD Billing details second layer on dm ,div code and year details wise
				try {
					getBillingDetailsYtd(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "3lyrtnccano":// Outstanding Recievable third layer on account customer code wise details
				try {
					getOnAccountCustWiseDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "tdvhij":// jihv /stage2 qtn lost deatils by aging and division code
				try {
					getStage2LostAgingDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "rtlfvid":// jihv /stage2 qtn lost deatils by aging and qtn code
				try {
					getDivWiseFeatures(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "etqyrwsedtls":// enquiry to quotation year wise details by dm code, division and year
				try {
					getEnqToQtnDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "qtnToLoiyrwsedtls":// quotation to LOI year wise details by dm code, division and year
				try {
					getQtntoLoiDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "loiToSoiyrwsedtls":// quotation to LOI year wise details by dm code, division and year
				try {
					getLoitoSoDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "soToInvoiceyrwsedtls":// quotation to LOI year wise details by dm code, division and year
				try {
					getSotoIvoiceDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "etqmonthwsedtls":// enquiry to quotation month wise details by month, dm code, division and year
				try {
					getEnqToQtnMonthDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "qtnmonthwsedtls": // quotation to loi month wise details by month, dm code, division and year
				try {
					getQtnToLoiMonthDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "ordermonthwsedtls": // loi to order month wise details by month, dm code, division and year
				try {
					getLoiToOrderMonthDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "invcmonthwsedtls": // order to invoicing month wise details by month, dm code, division and year
				try {
					getOrderToLInvcMonthDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "slbvcr":
				try {// handling recievable aging wise details for sub division
					getOustndngRcvbleRecievableAgingDetailsforSubDvn(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "wccsltdhop":// pdc on hand details customer code wise
				try {// ------PDC's On Hand----------------------------
					getPdcOnHandDetailsCustCodeWise(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "wccsltdrep":// pdc reentry details cust code wise
				try {// ------PDC's Re-Entry----------------------------
					getReEntryHandDetailsCustCodeWise(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lyer2BookingDtls":// YTD Billing details second layer on dm ,div code and year details wise
				try {
					getBookingDetailsYtd(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s34_sum":
				try {
					getStage1_4Summary(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s1_dt":
				try {// handling stage 4 details
					getStage1_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s2_dt":
				try {
					getStage2Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s3_dt":
				try {
					// System.out.println("s3_dt");
					getStage3_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s4_dt":
				try {
					// System.out.println("s4_dt");
					getStage4_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s5_dt":
				try {
					getStage5_Details(request, response);
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

	private void getBillingDetailsYtd(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		// ------Sub Division Level Billing Details----------------------------
		String dm_Emp_Code = request.getParameter("dmCode");
		String year_temp = request.getParameter("yrVal");
		String division = request.getParameter("subDivn");
		List<SipLayer2SubDivisionLevelBillingDetailsYTD> theAgingDtList = sipDivChartLayer2DbUtil
				.getSubDivisionBillingDetailsForYTD(dm_Emp_Code, division, year_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getBookingDetailsYtd(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		// ------Sub Division Level Booking Details----------------------------
		String dm_Emp_Code = request.getParameter("dmCode");
		String year_temp = request.getParameter("yrVal");
		String division = request.getParameter("subDivn");
		List<SipLayer2SubDivisionLevelBookingDetailsYTD> theAgingDtList = sipDivChartLayer2DbUtil
				.getSubDivisionBookingDetailsForYTD(dm_Emp_Code, division, year_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getReEntryHandDetailsCustCodeWise(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		// ------PDC's Re-Entry----------------------------
		String customer_Code = request.getParameter("ccerp");
		List<SipLayer4_Pdc_Re_Entry> theOnAcctDtList = sipDivChartLayer4DbUtil
				.getPpdReEntryCustWiseDetails(customer_Code);

		response.setContentType("application/json");
		new Gson().toJson(theOnAcctDtList, response.getWriter());
	}

	private void getPdcOnHandDetailsCustCodeWise(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		// ------PDC's On Hand----------------------------
		String customer_Code = request.getParameter("cchop");
		List<SipLayer4_Pdc_On_Hand> theOnAcctDtList = sipDivChartLayer4DbUtil
				.getPpdOnHandCustWiseDetails(customer_Code);

		response.setContentType("application/json");
		new Gson().toJson(theOnAcctDtList, response.getWriter());
	}

	private void getOnAccountCustWiseDetails(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String customer_Code = request.getParameter("oacc");
		String divName = request.getParameter("divName");
		HashMap<String, List<SipOutsRecvbleCustWise_Layer3Details>> theOnAcctDtList = sipDivChartLayer3DbUtil
				.getOustRecvblOnAccntDataDetails(customer_Code, divName, "SUBDIVN");

		response.setContentType("application/json");
		new Gson().toJson(theOnAcctDtList, response.getWriter());
	}

	private void getDMsListFormangmentDashboard(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		List<SipDmListForManagementDashboard> theDmsList = sipMainDivChartDbUtil.getDMListfor_Mg();
		request.setAttribute("DmsLstFMgmnt", theDmsList);

	}

	private void checkSalesMgrPerfTabisAllowed(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws SQLException {
		String result = sipMainDivChartDbUtil.checkSalesMgrPerfTabisAllowed(dmCode);
		request.getSession().setAttribute("isAllowed", result);

	}

	private void getDivWiseFeatures(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		// this function fetching data based on division

		String dm_Emp_Code = request.getParameter("d2");
		String div_name = request.getParameter("tslvid");// division name
		request.setAttribute("selected_division", div_name);
		request.setAttribute("DIVDEFTITL", div_name);// divTitle
		getBookingSummaryDefault(request, response, dm_Emp_Code, div_name);
		getBookingSummaryLastTwoYears(request, response, dm_Emp_Code, div_name);
		getBillingSummaryDefault(request, response, dm_Emp_Code, div_name);
		getBillingSummaryLastTwoYears(request, response, dm_Emp_Code, div_name);
		getStage2LostSummaryDefault(request, response, dm_Emp_Code, div_name);
		getEnquiryToQuotationSummary(request, response, dm_Emp_Code, div_name);
		getQuotationToLoiSummary(request, response, dm_Emp_Code, div_name);
		getLoiToSaleOrderSummary(request, response, dm_Emp_Code, div_name);
		getSaleOrderToInvoiceSummary(request, response, dm_Emp_Code, div_name);
		getForcastInvoice(request, response, dm_Emp_Code, div_name);
		getForcastPerAccuracy(request, response, div_name);
		getOustndngRcvbleReportforSubDivn(request, response, div_name, dm_Emp_Code);
		getDivisions(request, response, dm_Emp_Code);// division list
		request.setAttribute("DFLTDMCODE", dm_Emp_Code);
		getDMsListFormangmentDashboard(request, response);
		getJobinHandVolume(request, response, dm_Emp_Code, div_name);
		goToSip(request, response);
	}

	private void getOustndngRcvbleReportforSubDivn(HttpServletRequest request, HttpServletResponse response,
			String div_code, String dm_Emp_Code) throws SQLException {
		// this function for retreving sub division wise oustanding recievable based on
		// divn code code, aging wise
		List<SipOutRecvbleReprt> theReceivableList = sipDivChartDbUtil.getOutstandingRecievableforSubDivn(div_code,
				dm_Emp_Code);
		request.setAttribute("ORAR", theReceivableList);

	}

	private void getOrderToLInvcMonthDetails(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String month_temp = request.getParameter("monthTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivSoToInvoiceLayer3Details> theAgingDtList = sipDivChartLayer3DbUtil
				.getOrderTOInvoiceMonthDetails(dm_Emp_Code, division, year_temp, month_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getLoiToOrderMonthDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String month_temp = request.getParameter("monthTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivLoiToSoLayer3Details> theAgingDtList = sipDivChartLayer3DbUtil.getLoiToOrderMonthDetails(dm_Emp_Code,
				division, year_temp, month_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getQtnToLoiMonthDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String month_temp = request.getParameter("monthTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivQtnToLoiLayer3Details> theAgingDtList = sipDivChartLayer3DbUtil
				.getQuotationTOLoiMonthDetails(dm_Emp_Code, division, year_temp, month_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getEnqToQtnMonthDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String month_temp = request.getParameter("monthTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivEnquirtToQtnLayer3Details> theAgingDtList = sipDivChartLayer3DbUtil
				.getEnquiryToQuotationMonthDetails(dm_Emp_Code, division, year_temp, month_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getOustndngRcvbleRecievableAgingDetailsforSubDvn(HttpServletRequest request,
			HttpServletResponse response) throws JsonIOException, IOException, SQLException {
		String dm_Emp_Code = request.getParameter("d2");
		String divnCode = request.getParameter("edocnvd");
		String aging = request.getParameter("aging");
		List<SipDivisionOutstandingRecivablesDtls> theReceivableAgingDtList = sipDivChartLayer2DbUtil
				.getOutstandingRecievableAgingDetailsforSubDivn(divnCode, dm_Emp_Code, aging);
		response.setContentType("application/json");
		new Gson().toJson(theReceivableAgingDtList, response.getWriter());

	}

	private void getSotoIvoiceDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivOrderToInvcLayer2Details> theAgingDtList = sipDivChartLayer2DbUtil
				.getOrderToInvoiceYearWiseDetails(dm_Emp_Code, division, year_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getLoitoSoDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivLoiToOrderLayer2Details> theAgingDtList = sipDivChartLayer2DbUtil
				.getLoiToOrderYearWiseDetails(dm_Emp_Code, division, year_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getQtntoLoiDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivQtnToLoiLayer2Details> theAgingDtList = sipDivChartLayer2DbUtil
				.getQtnToLoiYearWiseDetails(dm_Emp_Code, division, year_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getEnqToQtnDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String year_temp = request.getParameter("yearTemp");
		String division = request.getParameter("divenqqtn");
		List<SipDivEnquirtToQtnLayer2Details> theAgingDtList = sipDivChartLayer2DbUtil
				.getEnqToQtnYearWiseDetails(dm_Emp_Code, division, year_temp);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getStage2LostAgingDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String dm_Emp_Code = request.getParameter("d2");
		String aging = request.getParameter("avfad");// aging value for aging details
		if (aging.equals("0")) {
			aging = "0-3Mths";
		} else if (aging.equals("1")) {
			aging = "3-6Mths";
		} else {
			aging = ">6Mths";
		}
		String division_code = request.getParameter("dcvfad");// division code value for aging details
		List<SipDivStage2LostDetails> theAgingDtList = sipDivChartDbUtil
				.getStage2LostAging_Details_Division(dm_Emp_Code, aging, division_code);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getAllFeatures(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws SQLException, ServletException, IOException {
		// String defaultDivision =
		// sipDivChartDbUtil.getDeafultDivisionforDm(dm_Emp_Code);
		// request.setAttribute("DIVDEFTITL", defaultDivision);// divTitle
		// commented all the methods for not displaying default. first they have to
		// select subdivision then load the data.
		// request.setAttribute("selected_division", defaultDivision);
		getDivisions(request, response, dm_Emp_Code);// division list
		// getBookingSummaryDefault(request, response, dm_Emp_Code, defaultDivision);
		// getBookingSummaryLastTwoYears(request, response, dm_Emp_Code,
		// defaultDivision);
		// getBillingSummaryDefault(request, response, dm_Emp_Code, defaultDivision);
		// getBillingSummaryLastTwoYears(request, response, dm_Emp_Code,
		// defaultDivision);
		// getStage2LostSummaryDefault(request, response, dm_Emp_Code, defaultDivision);
		// getEnquiryToQuotationSummary(request, response, dm_Emp_Code,
		// defaultDivision);
		// getQuotationToLoiSummary(request, response, dm_Emp_Code, defaultDivision);
		// getLoiToSaleOrderSummary(request, response, dm_Emp_Code, defaultDivision);
		// getSaleOrderToInvoiceSummary(request, response, dm_Emp_Code,
		// defaultDivision);
		// getForcastInvoice(request, response, dm_Emp_Code, defaultDivision);
		// getForcastPerAccuracy(request, response, defaultDivision);
		// getOustndngRcvbleReportforSubDivn(request, response, defaultDivision,
		// dm_Emp_Code);
		// getJobinHandVolume(request, response, dm_Emp_Code, defaultDivision);
		goToSip(request, response);
	}

	private void getSaleOrderToInvoiceSummary(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code, String division) throws SQLException {
		List<SipDivSoToInvoiceAnalysis> theSoToInvDetails = sipDivChartDbUtil.getSoToInvoiceAnalysis(dm_Emp_Code,
				division);
		request.setAttribute("SOTOINVANALSUM", theSoToInvDetails);// For order to invoice Analysis Summary
	}

	private void getLoiToSaleOrderSummary(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code,
			String division) throws SQLException {
		List<SipDivLoiToSoAnalysis> theLoiToSoDetails = sipDivChartDbUtil.getLoiToSOAnalysis(dm_Emp_Code, division);
		request.setAttribute("LOITOSOANALSUM", theLoiToSoDetails);// For loi to so Analysis Summary
	}

	private void getQuotationToLoiSummary(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code,
			String division) throws SQLException {
		List<SipDivQuotationToLoiAnalysis> theForecastDetails = sipDivChartDbUtil.getQtnToLoiAnalysis(dm_Emp_Code,
				division);
		request.setAttribute("QTNTOLOISUM", theForecastDetails);// For qtn to loi Analysis Summary
	}

	private void getEnquiryToQuotationSummary(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code, String division) throws SQLException {
		List<SipDivEnquirtToQtnAnalysis> theEnqToQtnDetails = sipDivChartDbUtil.getEnqToQtnAnalysis(dm_Emp_Code,
				division);
		request.setAttribute("ENQTOQTNSUM", theEnqToQtnDetails);// For Enq to qtn Analysis Summary
	}

	private void getForcastInvoice(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code,
			String division) throws SQLException {
		List<SipDivForecast> theForecastDetails = sipDivChartDbUtil.getForecastDetails(dm_Emp_Code, division);
		request.setAttribute("FRCSTDTLS", theForecastDetails);// FoRCaSTDeTaiLS
	}

	private void getForcastPerAccuracy(HttpServletRequest request, HttpServletResponse response, String division)
			throws SQLException {
		List<SipDivForecastPercAccuracyDetails> theForecastDetails = sipDivChartDbUtil
				.getForecastAccuracyPercDetails(division);
		request.setAttribute("FRCSPERCACCRCYDTLS", theForecastDetails);// FoRCaSTDeTaiLS
	}

	private void getDivisions(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code)
			throws SQLException {
		List<SipDivJihvSummary> theDivisionList = sipDivChartDbUtil.getDivisionListforDM(dm_Emp_Code);
		request.setAttribute("DIVLST", theDivisionList);
	}

	private void getBookingSummaryDefault(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code,
			String division) throws SQLException {
		List<SipDivBookingSummary> theBookingSumList = sipDivChartDbUtil.getBookingSummary(dm_Emp_Code, division);
		request.setAttribute("BKNGS", theBookingSumList);
	}

	private void getBookingSummaryLastTwoYears(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code, String division) throws SQLException {
		List<SipDivBookingSummary> theBookingSumList = sipDivChartDbUtil.getBookingLastTwoyears(dm_Emp_Code, division);
		request.setAttribute("BKNGS_LTWOYRS", theBookingSumList);
	}

	private void getBillingSummaryDefault(HttpServletRequest request, HttpServletResponse response, String dm_Emp_Code,
			String division) throws SQLException {
		List<SipDivBillingSummary> theBillingSumList = sipDivChartDbUtil.getBillingSummary(dm_Emp_Code, division);
		request.setAttribute("BILLNG", theBillingSumList);
	}

	private void getBillingSummaryLastTwoYears(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code, String division) throws SQLException {
		List<SipDivBillingSummary> theBillingSumList = sipDivChartDbUtil.getBillingLastTwoyears(dm_Emp_Code, division);
		request.setAttribute("BILLNG_LTWOYRS", theBillingSumList);
	}

	private void getStage2LostSummaryDefault(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code, String division) throws SQLException, ServletException, IOException {
		List<SipDStage2LostSummary> theVolumeList = sipDivChartDbUtil.getStage2LostCountforDivisionDeafault(dm_Emp_Code,
				division);
		request.setAttribute("JIHV", theVolumeList);
	}

	private void getJobinHandVolume(HttpServletRequest request, HttpServletResponse response, String theDmCode,
			String defaultDivision) throws SQLException, ServletException, IOException {
		long s4Sum = sipDivChartDbUtil.getJobInHandVolume(theDmCode, defaultDivision);
		request.setAttribute("JIHVD", s4Sum);

	}

	private void getStage1_4Summary(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String theDmCode = request.getParameter("d2");
		String seleDivn = request.getParameter("seleDivn");
		long s3Sum = sipDivChartDbUtil.stage3Summary(theDmCode, seleDivn);
		long s4Sum = sipDivChartDbUtil.stage4Summary(theDmCode, seleDivn);
		long s1Sum = sipDivChartDbUtil.stage1Summary(theDmCode, seleDivn);
		long s5Sum = sipDivChartDbUtil.stage5Summary(theDmCode, seleDivn);
		String output = s1Sum + "," + s3Sum + "," + s4Sum + "," + s5Sum;
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(output);

	}

	private void getStage1_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// TENDER DETAILS
		String dmCode = request.getParameter("d1");
		String seleDivn = request.getParameter("seleDivn");
		List<Stage1Details> theStage4DtList = sipDivChartDbUtil.stage1SummaryDetails(dmCode, seleDivn);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());
	}

	private void getStage2Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// TStage2 details for division
		String theDmCode = request.getParameter("d1");
		String seleDivn = request.getParameter("seleDivn");
		List<SipJihvDetails> theAgingDtList = sipDivChartDbUtil.getStage2DetailsForDivision(theDmCode, seleDivn);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getStage3_Details(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String theDmCode = request.getParameter("d2");
		String seleDivn = request.getParameter("seleDivn");
		List<Stage3Details> theStage3DtList = sipDivChartDbUtil.stage3SummaryDetails(theDmCode, seleDivn);
		response.setContentType("application/json");
		new Gson().toJson(theStage3DtList, response.getWriter());

	}

	private void getStage4_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String theDmCode = request.getParameter("d2");
		String seleDivn = request.getParameter("seleDivn");
		List<Stage4Details> theStage4DtList = sipDivChartDbUtil.stage4SummaryDetails(theDmCode, seleDivn);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());

	}

	private void getStage5_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String theDmCode = request.getParameter("d2");
		String seleDivn = request.getParameter("seleDivn");
		List<SipLayer2SubDivisionLevelBillingDetailsYTD> theStage4DtList = sipDivChartDbUtil
				.stage5SummaryDetails(theDmCode, seleDivn);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());

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
		RequestDispatcher dispatcher = request.getRequestDispatcher("/sipDivisionchart.jsp");
		dispatcher.forward(request, response);

	}

}
