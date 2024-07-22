package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
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

import beans.SipBilling;
import beans.SipBooking;
import beans.SipBookingBillingDetails;
import beans.SipDStage2LostSummary;
import beans.SipDivStage2LostDetails;
import beans.SipDivisionOutstandingRecivablesDtls;
import beans.SipDmListForManagementDashboard;
import beans.SipForecastSalesOrderDelivery;
import beans.SipJihDues;
import beans.SipJihvDetails;
import beans.SipJihvSummary;
import beans.SipLayer4_Pdc_On_Hand;
import beans.SipLayer4_Pdc_Re_Entry;
import beans.SipMainDivisionBillingSummaryYtm;
import beans.SipMainDivisionBookingSummaryYtm;
import beans.SipOutRecvbleReprt;
import beans.SipOutsRecvbleCustWise_Layer3Details;
import beans.SipSalesEngWeeklyBookningReport;
import beans.Stage1Details;
import beans.Stage3Details;
import beans.Stage4Details;
import beans.fjtcouser;
import utils.SipDivisionChartLayer3DbUtil;
import utils.SipDivisionChartLayer4DbUtil;
import utils.SipMainDivisionChartDbUtil;

/**
 * Servlet implementation class SipChartMainDivisionController
 */
@WebServlet("/sipMainDivision")
public class SipChartMainDivisionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipMainDivisionChartDbUtil sipMainDivChartDbUtil;
	private SipDivisionChartLayer3DbUtil sipDivChartLayer3DbUtil;
	private SipDivisionChartLayer4DbUtil sipDivChartLayer4DbUtil;

	public SipChartMainDivisionController() {
		super();
		sipMainDivChartDbUtil = new SipMainDivisionChartDbUtil();
		sipDivChartLayer3DbUtil = new SipDivisionChartLayer3DbUtil();
		sipDivChartLayer4DbUtil = new SipDivisionChartLayer4DbUtil();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			response.sendRedirect("logout.jsp");
		} else {
			String mangmntDashbrdActvtdYN = "N";
			String theSipCode = request.getParameter("fjtco");
			if (fjtuser.getRole().equalsIgnoreCase("mg") && theSipCode == null) {
				getDMsListFormangmentDashboard(request, response);
				// goToSipMainDivision(request, response);
			}
			// System.out.println("DEBG SIP CODE :"+request.getParameter("dmCodemgmnt"));
			String theDmCode = fjtuser.getEmp_code();
			// System.out.println("DM EMP CODE controller 1: "+theDmCode);
			if (theSipCode == null) {
				theSipCode = "salesChart_dafult";
			} else if (theSipCode.equals("dmfsltdmd")) {// This if condition is for handling Managment dashbaod
				getDMsListFormangmentDashboard(request, response);
				mangmntDashbrdActvtdYN = "Y";
				theSipCode = "salesChart_dafult";

				theDmCode = request.getParameter("dmCodemgmnt");

			}
			request.setAttribute("DFLTDMCODE", theDmCode);
			switch (theSipCode) {

			case "salesChart_dafult":
				try {

					getDefaultDivisionTitle(request, response, theDmCode);
					getJobinHandVolume(request, response, theDmCode);
					getYtmBookingBillingSummery(request, response, theDmCode);
					getOustndngRcvbleReportforMainDivn(request, response, theDmCode);
					getSalesEngnrsWeekWiseBookngforMainDivn(request, response, theDmCode);
					getYtmDivisionLevelBillingSummery(request, response, theDmCode);
					getYtmDivisionLevelBookingSummery(request, response, theDmCode);
					getForcastStage4DeliveryDateWiseSummary(request, response, theDmCode);
					getTopTenCustomersDetails(request, response, theDmCode);
					getStage2LostSummaryDefault(request, response, theDmCode);
					getJihLostAnalysis(request, response, theDmCode);
					request.setAttribute("MGMNTDBACTVORNOT", mangmntDashbrdActvtdYN);// for checking mangment dashboard
																						// active or not

					goToSipMainDivision(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;

			case "fcastDetls":// Detail for Forecast from sales order delivery date
				try {
					getForcastStage4DeliveryDateWiseDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "fcastStg3Detls":// Detail for Forecast from sales order delivery date
				try {
					getForcastStage3DeliveryDateWiseDetails(request, response);
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
			case "aging_dt":
				try {

					getAgingDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "stage2_dt":
				try {
					getStage2Details(request, response);
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
					// System.out.println("s4_dt");
					getStage5_Details(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "bkm_dt":
				try {
					// booking details for month to YTD
					getBookingDetailsforMonthAndYtd(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "blm_dt":
				try {
					// Billing details for month to YTD
					getBillingDetailsforMonthAndYtd(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "slbvcr":
				try {// handling recievable aging wise details for sub division
					getOustndngRcvbleRecievableAgingDetailsforMainDvn(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "frbwym":
				try {// handling weekly booking report for month and year wise filtration
					getSalesEngnrsWeekWiseBookngforMainDivnYrMthFltr(request, response);
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
			case "tdvhij":// jihv /stage2 qtn lost deatils by aging and division code
				try {
					getStage2LostAgingDetails(request, response);
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
			case "custmerDetails":// Detail for Forecast from sales order delivery date
				try {
					getCustomerDetails(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			default:
				try {
					goToSipMainDivision(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				break;
			}
		}

	}

	private void getJihLostDetails(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		// Salesman Performance details
		String lostType = request.getParameter("lstyp");
		String dmCode = request.getParameter("dmCode");

		List<SipJihDues> details = sipMainDivChartDbUtil.getSEJihLostQtnDetails(lostType, dmCode);
		response.setContentType("application/json");
		new Gson().toJson(details, response.getWriter());

	}

	private void getJihLostAnalysis(HttpServletRequest request, HttpServletResponse response, String theDmCode) {
		List<SipJihDues> theJihLost = null;
		try {
			theJihLost = sipMainDivChartDbUtil.getJihLostDetails(theDmCode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("JIHLA", theJihLost);

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
		List<SipDivStage2LostDetails> theAgingDtList = sipMainDivChartDbUtil
				.getStage2LostAging_Details_Division(dm_Emp_Code, aging);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}

	private void getStage2LostSummaryDefault(HttpServletRequest request, HttpServletResponse response,
			String dm_Emp_Code) throws SQLException, ServletException, IOException {
		List<SipDStage2LostSummary> theVolumeList = sipMainDivChartDbUtil
				.getStage2LostCountforDivisionDeafault(dm_Emp_Code);
		request.setAttribute("JIHVLOST", theVolumeList);
	}

	private void getForcastStage4DeliveryDateWiseSummary(HttpServletRequest request, HttpServletResponse response,
			String theDmCode) throws SQLException {
		// Summary for Forecast from sales order delivery date
		List<SipForecastSalesOrderDelivery> theSummaryList = sipMainDivChartDbUtil
				.getForecastSalesOrderDeliveryDateWiseSummary(theDmCode);
		request.setAttribute("FSSDDWV", theSummaryList); // forecsat stage4 summary delivery date wise values
	}

	private void getTopTenCustomersDetails(HttpServletRequest request, HttpServletResponse response, String theDmCode)
			throws SQLException {
		// Summary for top ten customer details
		List<SipForecastSalesOrderDelivery> theSummaryList = sipMainDivChartDbUtil.getTopTenCustomersDetails(theDmCode);
		request.setAttribute("TTCD", theSummaryList);
	}

	private void getCustomerDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// Detail of top ten customers
		String theDmCode = request.getParameter("d1");
		String theCustomerCode = request.getParameter("d2");
		List<SipBookingBillingDetails> theDetailsList = sipMainDivChartDbUtil.getDetailsofSelCust(theDmCode,
				theCustomerCode);

		response.setContentType("application/json");
		new Gson().toJson(theDetailsList, response.getWriter());
	}

	private void getForcastStage4DeliveryDateWiseDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// Detail for Forecast from sales order delivery date
		String theDmCode = request.getParameter("d1");
		List<SipForecastSalesOrderDelivery> theDetailsList = sipMainDivChartDbUtil
				.getForecastSalesOrderDeliveryDateWiseDetails(theDmCode);

		response.setContentType("application/json");
		new Gson().toJson(theDetailsList, response.getWriter());
	}

	private void getForcastStage3DeliveryDateWiseDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// Detail for Forecast from sales order delivery date
		String theDmCode = request.getParameter("d1");
		List<SipForecastSalesOrderDelivery> theDetailsList = sipMainDivChartDbUtil
				.getForecastStg3SalesOrderDeliveryDateWiseDetails(theDmCode);

		response.setContentType("application/json");
		new Gson().toJson(theDetailsList, response.getWriter());
	}

	private void getStage2Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// TStage2 details for division
		String theDmCode = request.getParameter("d1");
		List<SipJihvDetails> theAgingDtList = sipMainDivChartDbUtil.getStage2DetailsForDivision(theDmCode);
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
				.getOustRecvblOnAccntDataDetails(customer_Code, divName, "DIVN");
		response.setContentType("application/json");
		new Gson().toJson(theOnAcctDtList, response.getWriter());
	}

	private void getDMsListFormangmentDashboard(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		List<SipDmListForManagementDashboard> theDmsList = sipMainDivChartDbUtil.getDMListfor_Mg();
		request.setAttribute("DmsLstFMgmnt", theDmsList);

	}

	private void getSalesEngnrsWeekWiseBookngforMainDivnYrMthFltr(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, JsonIOException, IOException {
		// DM LEVEL - SALESMANWISE WEEKLY BOOKING MONTh and year wise Filter

		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		if (fjtuser == null) {
			response.sendRedirect("logout.jsp");
		} else {
			int iYear = 0;

			String month = request.getParameter("smonth");
			String year = request.getParameter("syear");
			String theDmCode = request.getParameter("d2");
			if (year == null || year.isEmpty()) {

				Calendar cal = Calendar.getInstance();
				// int iMonth = cal.get(Calendar.MONTH)+1;
				iYear = cal.get(Calendar.YEAR);
				// month = getMonthByMonthValue(iMonth);

			} else {

				iYear = Integer.parseInt(year);
			}

			List<SipSalesEngWeeklyBookningReport> theWeeklyBookingList = sipMainDivChartDbUtil
					.getWeekWiseBookingForsalesEngrsDataforDMs(theDmCode, iYear, month);
			// request.setAttribute("WWBFSE", theWeeklyBookingList);//week wise booking for
			// sales engineers
			// request.setAttribute("MNTH_TXT", month);

			response.setContentType("application/json");
			new Gson().toJson(theWeeklyBookingList, response.getWriter());

		}
	}

	private void getSalesEngnrsWeekWiseBookngforMainDivn(HttpServletRequest request, HttpServletResponse response,
			String theDmCode) throws SQLException {
		// DM LEVEL - SALESMAN WISE WEEKLY BOOKING
		// String theDmCode=request.getParameter("edoCmd");
		Calendar cal = Calendar.getInstance();
		int iMonth = cal.get(Calendar.MONTH) + 1;
		int iYear = cal.get(Calendar.YEAR);
		String month = getMonthByMonthValue(iMonth);
		// System.out.println("Month : "+month+" Year:"+iYear);

		List<SipSalesEngWeeklyBookningReport> theWeeklyBookingList = sipMainDivChartDbUtil
				.getWeekWiseBookingForsalesEngrsDataforDMs(theDmCode, iYear, month);
		request.setAttribute("WWBFSE", theWeeklyBookingList);// week wise booking for sales engineers
		request.setAttribute("MNTH_TXT", month);
	}

	private String getMonthByMonthValue(int iMonth) {
		String curr_month_name = "Jan";
		switch (iMonth) {
		case 1:
			curr_month_name = "Jan";
			break;
		case 2:
			curr_month_name = "Feb";
			break;
		case 3:
			curr_month_name = "Mar";
			break;
		case 4:
			curr_month_name = "Apr";
			break;
		case 5:
			curr_month_name = "May";
			break;
		case 6:
			curr_month_name = "Jun";
			break;
		case 7:
			curr_month_name = "Jul";
			break;
		case 8:
			curr_month_name = "Aug";
			break;
		case 9:
			curr_month_name = "Sep";
			break;
		case 10:
			curr_month_name = "Oct";
			break;
		case 11:
			curr_month_name = "Nov";
			break;
		case 12:
			curr_month_name = "Dec";
			break;

		}
		return curr_month_name;
	}

	private void getOustndngRcvbleRecievableAgingDetailsforMainDvn(HttpServletRequest request,
			HttpServletResponse response) throws JsonIOException, IOException, SQLException {
		// this function for retreving Main division / DM LEVEL oustanding recievable
		// Aging Details Report by passing dm employee code code and aging value.
		String theDmCode = request.getParameter("edoCmd");
		String aging = request.getParameter("aging");
		List<SipDivisionOutstandingRecivablesDtls> theReceivableAgingDtList = sipMainDivChartDbUtil
				.getOutstandingRecievableAgingDetailsforMainDivn(theDmCode, aging);
		response.setContentType("application/json");
		new Gson().toJson(theReceivableAgingDtList, response.getWriter());

	}

	private void getOustndngRcvbleReportforMainDivn(HttpServletRequest request, HttpServletResponse response,
			String theDmCode) throws SQLException {
		// this function for retreving Main division / DM< LEVEL oustanding recievable
		// summary based on dm employee code code, aging wise
		List<SipOutRecvbleReprt> theReceivableList = sipMainDivChartDbUtil
				.getOutstandingRecievableforMainDivn(theDmCode);
		request.setAttribute("ORAR", theReceivableList);

	}

	private void getBillingDetailsforMonthAndYtd(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String aging = request.getParameter("bl1");
		String year = request.getParameter("bl2");
		String theDmCode = request.getParameter("d2");
		if (aging.equals("YTD")) {
			List<SipBookingBillingDetails> theBillingDtList = sipMainDivChartDbUtil.billingDetailsYtd(theDmCode, year);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter());
		} else {
			List<SipBookingBillingDetails> theBillingDtList = sipMainDivChartDbUtil.billingDetailsforMonth(theDmCode,
					aging, year);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter());
		}

	}

	private void getBookingDetailsforMonthAndYtd(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {

		String aging = request.getParameter("bk1");
		String year = request.getParameter("bk2");
		String theDmCode = request.getParameter("d2");
		if (aging.equals("YTD")) {
			List<SipBookingBillingDetails> theBokkingDtList = sipMainDivChartDbUtil.bookingDetailsYtd(theDmCode, year);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		} else {
			List<SipBookingBillingDetails> theBokkingDtList = sipMainDivChartDbUtil.bookingDetailsforMonth(theDmCode,
					aging, year);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		}

	}

	private void getStage1_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		// TENDER DETAILS
		String dmCode = request.getParameter("d1");
		List<Stage1Details> theStage4DtList = sipMainDivChartDbUtil.stage1SummaryDetails(dmCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());
	}

	private void getStage4_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String theDmCode = request.getParameter("d2");
		List<Stage4Details> theStage4DtList = sipMainDivChartDbUtil.stage4SummaryDetails(theDmCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage4DtList, response.getWriter());

	}

	private void getStage5_Details(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String theDmCode = request.getParameter("d2");
		List<SipBookingBillingDetails> theStage5DtList = sipMainDivChartDbUtil.stage5SummaryDetails(theDmCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage5DtList, response.getWriter());

	}

	private void getStage3_Details(HttpServletRequest request, HttpServletResponse response)
			throws JsonIOException, IOException, SQLException {
		String theDmCode = request.getParameter("d2");
		List<Stage3Details> theStage3DtList = sipMainDivChartDbUtil.stage3SummaryDetails(theDmCode);
		response.setContentType("application/json");
		new Gson().toJson(theStage3DtList, response.getWriter());

	}

	private void getStage1_4Summary(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException {
		String theDmCode = request.getParameter("d2");
		long s3Sum = sipMainDivChartDbUtil.stage3Summary(theDmCode);
		long s4Sum = sipMainDivChartDbUtil.stage4Summary(theDmCode);
		long s1Sum = sipMainDivChartDbUtil.stage1Summary(theDmCode);
		long s5Sum = sipMainDivChartDbUtil.stage5Summary(theDmCode);
		String output = s1Sum + "," + s3Sum + "," + s4Sum + "," + s5Sum;
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(output);

	}

	private void getDefaultDivisionTitle(HttpServletRequest request, HttpServletResponse response, String theDmCode)
			throws SQLException {
		// System.out.println("DM EMP CODE controller 4: "+theDmCode);
		String defaultDivision = sipMainDivChartDbUtil.getDeafultDivisionNameforDm(theDmCode);
		request.setAttribute("DIVDEFTITL", defaultDivision);// divTitle
	}

	private void getYtmDivisionLevelBillingSummery(HttpServletRequest request, HttpServletResponse response,
			String theDmCode) throws SQLException, ServletException, IOException {
		List<SipMainDivisionBillingSummaryYtm> theYtmBillingList = sipMainDivChartDbUtil
				.getYtmBillingSummaryForAllDivision(theDmCode);
		request.setAttribute("YTM_BLNG_AD", theYtmBillingList);// ytm billing summary for all division

	}

	private void getYtmDivisionLevelBookingSummery(HttpServletRequest request, HttpServletResponse response,
			String theDmCode) throws SQLException, ServletException, IOException {
		List<SipMainDivisionBookingSummaryYtm> theYtmBillingList = sipMainDivChartDbUtil
				.getYtmBookingSummaryForAllDivision(theDmCode);
		request.setAttribute("YTM_BKNG_AD", theYtmBillingList);// ytm booking summary for all division

	}

	private void getYtmBookingBillingSummery(HttpServletRequest request, HttpServletResponse response, String theDmCode)
			throws SQLException, ServletException, IOException {
		List<SipBooking> theYtmBookingList = sipMainDivChartDbUtil.getYtmBooking(theDmCode);
		request.setAttribute("YTM_BOOK", theYtmBookingList);
		List<SipBilling> theYtmBillingList = sipMainDivChartDbUtil.getYtmBilling(theDmCode);
		request.setAttribute("YTM_BILL", theYtmBillingList);

	}

	private void getAgingDetails(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String agingCode = request.getParameter("d1");
		String theDmCode = request.getParameter("d2");
		List<SipJihvDetails> theAgingDtList = sipMainDivChartDbUtil.getJihvAgingDetails(theDmCode, agingCode);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());

	}

	private void getJobinHandVolume(HttpServletRequest request, HttpServletResponse response, String theDmCode)
			throws SQLException, ServletException, IOException {
		List<SipJihvSummary> theVolumeList = sipMainDivChartDbUtil.getJobInHandVolume(theDmCode);
		request.setAttribute("JIHV", theVolumeList);

	}

	private void goToSipMainDivision(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher;
		dispatcher = request.getRequestDispatcher("/SipChartMainDivision.jsp");
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
