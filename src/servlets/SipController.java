package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.CustomerVisit;
import beans.SalesmanPerformance;
import beans.SipBilling;
import beans.SipBillingStage4Summery;
import beans.SipBooking;
import beans.SipBookingBillingDetails;
import beans.SipChartDivDmJobToStage3Dtls;
import beans.SipDStage2LostSummary;
import beans.SipDivStage2LostDetails;
import beans.SipDivisionOutstandingRecivablesDtls;
import beans.SipJihDues;
import beans.SipJihvDetails;
import beans.SipJihvSummary;
import beans.SipLayer4_Pdc_On_Hand;
import beans.SipLayer4_Pdc_Re_Entry;
import beans.SipOutRecvbleReprt;
import beans.SipOutsRecvbleCustWise_Layer3Details;
import beans.SipWeeklyReport;
import beans.Stage1Details;
import beans.Stage3Details;
import beans.Stage4Details;
import beans.Stage5Details;
import beans.fjtcouser;
import utils.SipChartDbUtil;
import utils.SipDivisionChartLayer3DbUtil;
import utils.SipDivisionChartLayer4DbUtil;

/**
 * Servlet implementation class sip.. its for handling sales engineer sales
 * performance for both sales engineer login and dm login
 */
@WebServlet("/sip")
public class SipController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SipChartDbUtil sipChartDbUtil;

	private SipDivisionChartLayer3DbUtil sipDivChartLayer3DbUtil;
	private SipDivisionChartLayer4DbUtil sipDivChartLayer4DbUtil;

	@Override
	public void init() throws ServletException {
		super.init();
		sipChartDbUtil = new SipChartDbUtil();
		sipDivChartLayer3DbUtil = new SipDivisionChartLayer3DbUtil();
		sipDivChartLayer4DbUtil = new SipDivisionChartLayer4DbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String action = request.getParameter("fjtco");// sipChart.jsp and sipDmChart.jsp , both page form
		// submitting "fjtco" as keyword to handle the services
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			// only access for users who have sales code
			response.sendRedirect("logout.jsp");
		} else {

			String sales_eng_Emp_code = fjtuser.getEmp_code();
			if (fjtuser.getRole().equalsIgnoreCase("mg")) {
				// managment
				List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesEngListfor_Mg(sales_eng_Emp_code);
				request.setAttribute("SEngLst", theSalesEngList);
			} else {

				if (fjtuser.getSalesDMYn() >= 1) { // SALES Division Manager OR NOT
					// DM USER + SALES CODE
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil.getSalesEngListfor_Dm(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				} else {
					// NORMAL SALES ENGINEER
					List<SipJihvSummary> theSalesEngList = sipChartDbUtil
							.getSalesEngListfor_NormalSalesEgr(sales_eng_Emp_code);
					request.setAttribute("SEngLst", theSalesEngList);
				}

			}
			checkSalesMgrPerfTabisAllowed(request, response, sales_eng_Emp_code);
			if (action == null) {
				// blocked to errors, 30/06/2022
				// if (fjtuser.getSubordinatesDetails() <= 0) {
				sipChartDbUtil.insertDashboardUserHistory(fjtuser.getEmp_code(), fjtuser.getUname(),
						fjtuser.getSales_code(), fjtuser.getEmp_com_code(), fjtuser.getEmp_divn_code(),
						fjtuser.getRole());
				// }
				action = "salesChart_dafult";
			}

			switch (action) {

			case "list":
				try {
					goToSip(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "gs2pdforrcv":// get stage 2 project details for regularisation and customer visit
				try {
					getProjectListForstCustVisitFollowUp(request, response, fjtuser.getEmp_code());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "salesChart":

				try {

					String theSalesEngCode = request.getParameter("scode");
					String theSalesEngName = request.getParameter("salesEngName");
					if (theSalesEngCode.isEmpty() || theSalesEngCode == null) {
						theSalesEngCode = fjtuser.getSales_code();

					}
					String segEmplCode = sipChartDbUtil.getEmployeeCodeBySalesCode(theSalesEngCode);
					String theYear = request.getParameter("syear");
					// getStage3_4Summary(request,response,theSalesEngCode);//stage 3 and 4 summary
					// not calling here because to reduce the time
					getS2S3S4WeeklySalesSummery(request, response, theSalesEngCode, theYear);
					getWeeklyCustomerVisitTarget(request, response, segEmplCode);
					getYrlyCustomerVisitSummary(request, response, segEmplCode, theYear);
					getOustndngRcvbleReportforSEng(request, response, theSalesEngCode);
					getYtmPerfomanceBookingBilling(request, response, theSalesEngCode, theYear);
					getBillingStage4Summery(request, response, theSalesEngCode, theYear);
					getStage2LostSummaryforSM(request, response, theSalesEngCode);
					getJihLostAnalysis(request, response, theSalesEngCode, theYear);
					getJobinHandVolume(request, response, theSalesEngCode, theYear, theSalesEngName);

				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "salesChart_dafult":

				try {
					String theYear = Calendar.getInstance().get(Calendar.YEAR) + "";
					String theSalesEngCode = fjtuser.getSales_code();
					String theSalesEngName = fjtuser.getUname();
					String segEmplCode = sipChartDbUtil.getEmployeeCodeBySalesCode(theSalesEngCode);

					getWeeklyCustomerVisitTarget(request, response, segEmplCode);
					getS2S3S4WeeklySalesSummery(request, response, theSalesEngCode, theYear);
					// getStage3_4Summary(request,response,theSalesEngCode);//stage 3 and 4 summary
					// not calling here because to reduce the time
					getYrlyCustomerVisitSummary(request, response, segEmplCode, theYear);
					getOustndngRcvbleReportforSEng(request, response, theSalesEngCode);
					getYtmPerfomanceBookingBilling(request, response, theSalesEngCode, theYear);
					getBillingStage4Summery(request, response, theSalesEngCode, theYear);
					getStage2LostSummaryforSM(request, response, theSalesEngCode);
					getJihLostAnalysis(request, response, theSalesEngCode, theYear);
					getJobinHandVolume(request, response, theSalesEngCode, theYear, theSalesEngName);

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
			case "s1_dt":
				try {// handling stage 1 details
					getStage1_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s2_dt":
				try {// handling jihv aging wise details
					getStage2Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s3_dt":
				try {// handling stage 3 details
					getStage3_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s4_dt":
				try {// handling stage 4 details
					getStage4_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s5_dt":
				try {// handling stage 4 details
					getStage5_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "aging_dt":
				try {// handling jihv aging wise details
					getAgingDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "s34_sum":
				try {// handling stage 1, stage 3 and stage 4 summary
					getStage1_4Summary(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "bkm_dt":
				try {// handling booking details
					getBookingDetailsYtm(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "blm_dt":
				try {// handling billing details
					getBillingDetailsYtm(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "blngs4_dt":
				try {// handling billing s4 details
					getBillingS4DetailsYear2onth(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "slbvcr":
				try {// handling recievable aging wise details
					getOustndngRcvbleRecievableAgingDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "tsolhij":
				try {// Handling stage 2 lost aging wise details
					getStage2LostAgingDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "3sdvmboj":
				try {// handling job moved from stage 2 to stage 3 details for current date to
						// previous week starting date
					getJobMovedToStage3(request, response);
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
			case "seicplfcv":// sales engineer indpendent project list for customer visit
				try {// ------PROJECT LIST FOR CUSTOMER VISIT----------------------------
					getProjectLists(request, response, fjtuser.getSales_code());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "sm_perf":// Salesman Performance details
				try {

					getSmPerformanceData(request, response);
				} catch (Exception e) {
					e.printStackTrace();// TODO: handle exception
				}
				break;
			case "cvDoSegfcYrmth":
				try {// Customer visit details of sales engineer for a custom month and year
					getCustomeVisitailsofSegForMonth(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "jihlstGrphDtls":
				try {// jih Lost details pie graph
					getJihLostDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "followupforreminders":// get stage 2 project details for Reminders and customer visit
				try {
					getProjectListForstReminderFollowUp(request, response, fjtuser.getEmp_code());
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:// defaultly redirecting to jsp page
				try {
					goToSip(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}

	private void getWeeklyCustomerVisitTarget(HttpServletRequest request, HttpServletResponse response,
			String segEmplCode) throws SQLException {
		// SALES CUSTOMER WEEKLY TARGET
		int weeklyTarget = sipChartDbUtil.weeklySalesTarget(segEmplCode);
		request.setAttribute("WKLYTRGT", weeklyTarget + "");
	}

	private void getProjectListForstCustVisitFollowUp(HttpServletRequest request, HttpServletResponse response,
			String empCode) throws JsonIOException, IOException, SQLException, ServletException {

		List<CustomerVisit> details = sipChartDbUtil.getSalesEngineerStage2ProjectListForCustVisit(empCode);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());
	}

	private void getJihLostDetails(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		// Salesman Performance details
		String lostType = request.getParameter("lstyp");
		String smCode = request.getParameter("seg");
		String selyear = request.getParameter("selyear");
		List<SipJihDues> details = sipChartDbUtil.getSEJihLostQtnDetails(lostType, smCode, selyear);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());

	}

	private void getJihLostAnalysis(HttpServletRequest request, HttpServletResponse response, String theSalesEngCode,
			String theYear) {
		List<SipJihDues> theJihLost = null;
		try {
			theJihLost = sipChartDbUtil.getJihLostDetails(theSalesEngCode, theYear);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("JIHLA", theJihLost);

	}

	private void getYrlyCustomerVisitSummary(HttpServletRequest request, HttpServletResponse response,
			String segEmplCode, String theYear) throws SQLException {
		// SALES CUSTOMER YRLY CUSTOMER VISIT SUMMARY
		List<CustomerVisit> theCvCount = sipChartDbUtil.getSalesEngineerCustoVisitCounts(segEmplCode, theYear);
		request.setAttribute("SEYRLYCVS", theCvCount);
	}

	private void getSmPerformanceData(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, JsonIOException {
		// Salesman Performance details
		String smCode = request.getParameter("c1");
		String sYear = request.getParameter("c2");
		String segEmplCode = sipChartDbUtil.getEmployeeCodeBySalesCode(smCode);
		Map<String, SalesmanPerformance> smMap = sipChartDbUtil.getSmPerformance(smCode, sYear, segEmplCode);
		response.setContentType("application/json");
		new Gson().toJson(smMap, response.getWriter());
		request.setAttribute("SM_MAP", smMap);

	}

	private void getCustomeVisitailsofSegForMonth(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String saleEngCode = request.getParameter("cvSeg");
		String year = request.getParameter("cvYr");
		String month = request.getParameter("cvMth");
		String segEmplCode = sipChartDbUtil.getEmployeeCodeBySalesCode(saleEngCode);
		List<CustomerVisit> theCVstDetails = sipChartDbUtil.getSegCustomerVisitDetails(segEmplCode, year, month);
		response.setContentType("application/json");
		new Gson().toJson(theCVstDetails, response.getWriter());
	}

	private void getProjectLists(HttpServletRequest request, HttpServletResponse response, String saleEngCode)
			throws JsonIOException, IOException, SQLException {
		List<CustomerVisit> theProjectList = sipChartDbUtil.getSalesEngineerProjectListForCustVisit(saleEngCode);
		response.setContentType("application/json");
		new Gson().toJson(theProjectList, response.getWriter());
	}

	private void getStage2Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// Stage 2 details for sales engineer
		String smCode = request.getParameter("d1");
		List<SipJihvDetails> theAgingDtList = sipChartDbUtil.getStage2DetailsForSalesEngineer(smCode);
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
		String sales_code = request.getParameter("seg");
		HashMap<String, List<SipOutsRecvbleCustWise_Layer3Details>> theOnAcctDtList = sipDivChartLayer3DbUtil
				.getOustRecvblOnAccntDataDetails(customer_Code, sales_code, "SEG");

		response.setContentType("application/json");
		new Gson().toJson(theOnAcctDtList, response.getWriter());
	}

	private void getBillingS4DetailsYear2onth(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("scmbl");
		String aging = request.getParameter("bl1");
		String year = request.getParameter("bl2");
		if (aging.equals("YTD")) {// if user click the Ytd bar in graph
			List<SipBookingBillingDetails> theBokkingDtList = sipChartDbUtil.billingS4DetailsYtd(smCode, year);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		} else {// user click monthly bar
			List<SipBookingBillingDetails> theBillingDtList = sipChartDbUtil.billingS4DetailsYtm(smCode, aging, year);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter());
		}
	}

	private void getJobMovedToStage3(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		List<SipChartDivDmJobToStage3Dtls> theJobMovedList = sipChartDbUtil.getStage2ToStage3Details();
		response.setContentType("application/json");
		new Gson().toJson(theJobMovedList, response.getWriter());
	}

	private void getOustndngRcvbleRecievableAgingDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("edoces");
		String aging = request.getParameter("aging");
		List<SipDivisionOutstandingRecivablesDtls> theReceivableAgingDtList = sipChartDbUtil
				.getOutstandingRecievableAgingDetailsforSaleEgr(smCode, aging);
		response.setContentType("application/json");
		new Gson().toJson(theReceivableAgingDtList, response.getWriter());

	}

	private void getOustndngRcvbleReportforSEng(HttpServletRequest request, HttpServletResponse response,
			String theSalesEngCode) throws SQLException {
		// this function for retreving sales oustanding recievable based on sales eng
		// code, aging wise
		List<SipOutRecvbleReprt> theReceivableList = sipChartDbUtil.getOutstandingRecievableforSaleEgr(theSalesEngCode);
		request.setAttribute("ORAR", theReceivableList);
	}

	private void getBookingDetailsYtm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("seCode");// sales egr code for monthly booking
		String aging = request.getParameter("agng");
		String year = request.getParameter("slctdYr");
		String currentYear = request.getParameter("curYear");
		if (aging.equals("YTD")) {// if user click the Ytd bar in graph
			List<SipBookingBillingDetails> theBokkingDtList = sipChartDbUtil.bookingDetailsYtd(smCode, year,
					currentYear);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		} else {// user click monthly bar
			List<SipBookingBillingDetails> theBokkingDtList = sipChartDbUtil.bookingDetailsYtm(smCode, aging, year);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		}

	}

	private void getBillingDetailsYtm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("seCode");
		String aging = request.getParameter("agng");
		String year = request.getParameter("slctdYr");
		String currentYear = request.getParameter("curYear");
		if (aging.equals("YTD")) {// if user click the Ytd bar in graph
			List<SipBookingBillingDetails> theBokkingDtList = sipChartDbUtil.billingDetailsYtd(smCode, year,
					currentYear);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		} else {// user click monthly bar
			List<SipBookingBillingDetails> theBillingDtList = sipChartDbUtil.billingDetailsYtm(smCode, aging, year);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter());
		}

	}

	private void getStage3_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("sd1");// sales engineer code
		List<Stage3Details> theStage3DtList = sipChartDbUtil.stage3SummaryDetails(smCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage3DtList, response.getWriter());
	}

	private void getStage1_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// TENDER DETAILS
		String smCode = request.getParameter("d1");
		List<Stage1Details> theStage4DtList = sipChartDbUtil.stage1SummaryDetails(smCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());
	}

	private void getStage4_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("sd1");
		List<Stage4Details> theStage4DtList = sipChartDbUtil.stage4SummaryDetails(smCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());
	}

	private void getStage5_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String smCode = request.getParameter("sd1");
		List<Stage5Details> theStage5DtList = sipChartDbUtil.stage5SummaryDetails(smCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage5DtList, response.getWriter());
	}

	private void getAgingDetails(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, ServletException {
		String smCode = request.getParameter("seCode");
		String agingCode = request.getParameter("agng");
		List<SipJihvDetails> theAgingDtList = sipChartDbUtil.getJihvAgingDetails(smCode, agingCode);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getStage1_4Summary(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		String theYear = Calendar.getInstance().get(Calendar.YEAR) + "";
		String SalesEngCode = request.getParameter("sm1");
		long s3Sum = sipChartDbUtil.stage3Summary(SalesEngCode);
		long s4Sum = sipChartDbUtil.stage4Summary(SalesEngCode);
		long s1Sum = sipChartDbUtil.stage1Summary(SalesEngCode);
		long s5Sum = sipChartDbUtil.stage5Summary(SalesEngCode, theYear);
		String output = s1Sum + "," + s3Sum + "," + s4Sum + "," + s5Sum;
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(output);
	}

	private void getYtmPerfomanceBookingBilling(HttpServletRequest request, HttpServletResponse response,
			String SalesEngCode, String theYear) throws SQLException, ServletException, IOException {
		List<SipBooking> theYtmBookingList = sipChartDbUtil.getYtmBooking(SalesEngCode, theYear);
		request.setAttribute("YTM_BOOK", theYtmBookingList);
		List<SipBilling> theYtmBillingList = sipChartDbUtil.getYtmBilling(SalesEngCode, theYear);
		request.setAttribute("YTM_BILL", theYtmBillingList);

		// billing summary for last 3 years in ytd format
		List<SipBilling> theBilling3YrsList = sipChartDbUtil.getBillingforLast3Years(SalesEngCode, theYear);
		request.setAttribute("BSFLTY", theBilling3YrsList); // Billing Summary For Last Three Years
	}

	private void getBillingStage4Summery(HttpServletRequest request, HttpServletResponse response, String SalesEngCode,
			String theYear) throws SQLException, ServletException, IOException {
		List<SipBillingStage4Summery> theYtdBillingS4List = sipChartDbUtil.getYtdBillingStage4Summery(SalesEngCode,
				theYear);
		request.setAttribute("BILLS4_SUMM", theYtdBillingS4List);

	}

	private void getS2S3S4WeeklySalesSummery(HttpServletRequest request, HttpServletResponse response,
			String SalesEngCode, String theYear) throws SQLException, ServletException, IOException {
		List<SipWeeklyReport> sipS2S3S4S5WeeklyReport = sipChartDbUtil.getS2S3S4WeeklySalesSummery(SalesEngCode,
				theYear);
		request.setAttribute("S2S3S4S5_SUMM", sipS2S3S4S5WeeklyReport);

	}

	private void getJobinHandVolume(HttpServletRequest request, HttpServletResponse response, String SalesEngCode,
			String theYear, String theSalesEngName) throws SQLException, ServletException, IOException {
		List<SipJihvSummary> theVolumeList = sipChartDbUtil.getJobInHandVolumeSummary(SalesEngCode);
		request.setAttribute("selected_salesman_code", SalesEngCode);
		request.setAttribute("selected_Year", theYear);
		request.setAttribute("selected_salesman_name", theSalesEngName);
		request.setAttribute("JIHV", theVolumeList);
		goToSip(request, response);
	}

	private void getStage2LostSummaryforSM(HttpServletRequest request, HttpServletResponse response,
			String sales_Egr_Code) throws SQLException, ServletException, IOException {
		List<SipDStage2LostSummary> theVolumeList = sipChartDbUtil.getStage2LostCountforSalesEgr(sales_Egr_Code);
		request.setAttribute("JIHVLOST", theVolumeList);
	}

	private void getStage2LostAgingDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String aging = request.getParameter("avfad");// aging value for stage jih lost aging details
		if (aging.equals("0")) {
			aging = "0-3Mths";
		} else if (aging.equals("1")) {
			aging = "3-6Mths";
		} else {
			aging = ">6Mths";
		}
		String sm_code = request.getParameter("edocms");// salesman code value for aging details
		List<SipDivStage2LostDetails> theAgingDtList = sipChartDbUtil.getStage2LostAging_Details_Division(sm_code,
				aging);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void checkSalesMgrPerfTabisAllowed(HttpServletRequest request, HttpServletResponse response, String dmCode)
			throws SQLException {
		String result = sipChartDbUtil.checkSalesMgrPerfTabisAllowed(dmCode);
		request.getSession().setAttribute("isAllowed", result);

	}

	private void goToSip(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		RequestDispatcher dispatcher;
		if (fjtuser.getSalesDMYn() >= 1 || fjtuser.getRole().equalsIgnoreCase("mg")) {
			dispatcher = request.getRequestDispatcher("/sipchartDm.jsp");
		} else {
			dispatcher = request.getRequestDispatcher("/sipchart.jsp");
		}
		dispatcher.forward(request, response);

	}

	private void getProjectListForstReminderFollowUp(HttpServletRequest request, HttpServletResponse response,
			String empCode) throws JsonIOException, IOException, SQLException, ServletException {

		List<CustomerVisit> details = sipChartDbUtil.getSalesEngineerStage2ProjectListForReminders(empCode);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());
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
