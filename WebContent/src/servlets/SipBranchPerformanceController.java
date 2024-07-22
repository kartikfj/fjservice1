package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import beans.CustomerVisit;
import beans.SipBilling;
import beans.SipBooking;
import beans.SipBookingBillingDetails;
import beans.SipBranchPerformance;
import beans.SipBranchSubDivisionLevelBookingBilling;
import beans.SipDStage2LostSummary;
import beans.SipDivStage2LostDetails; 
import beans.SipJihvDetails;
import beans.SipJihvSummary;
import beans.SipMainDivisionBillingSummaryYtm;
import beans.SipMainDivisionBookingSummaryYtm;
import beans.fjtcouser;
import utils.SipBranchPerformanceDbUtil; 

/**
 * Servlet implementation class SipBranchPerformanceController
 */
@WebServlet("/SipBranchPerformance")
public class SipBranchPerformanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SipBranchPerformanceDbUtil sipBranchPerformanceDbUtil;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SipBranchPerformanceController() {
        super();
        // TODO Auto-generated constructor stub
        sipBranchPerformanceDbUtil = new SipBranchPerformanceDbUtil();
    }
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
		fjtcouser fjtuser = (fjtcouser) request.getSession().getAttribute("fjtuser");
		String branchManagerCode = fjtuser.getEmp_code();
		if(fjtuser.getEmp_code() == null || fjtuser.getSales_code() == null) {
			response.sendRedirect("logout.jsp");
		}else if(fjtuser.getRole().equalsIgnoreCase("gm") || fjtuser.getRole().equalsIgnoreCase("mg")){
			List<SipBranchPerformance> branches = null;
			if(fjtuser.getRole().equalsIgnoreCase("gm")){
			  branches = sipBranchPerformanceDbUtil.checkTheBranchManagerPermission(branchManagerCode);
			}else if(fjtuser.getRole().equalsIgnoreCase("mg")) {
				branches = sipBranchPerformanceDbUtil.checkTheBranchManagerPermissionForMangment(); 
			} else {branches = null;}
			 if( branches.size() > 0) {
				 String theSipCode = request.getParameter("fjtco");
				 if (theSipCode == null)  theSipCode = "sales_dafult";  
				 switch(theSipCode) {
				 case "sales_dafult":
					 goToView(request, response, branchManagerCode, branches, fjtuser.getRole());
					 break;
				 case "salesChart": 
						try { 
                           String companyCode = request.getParameter("scompany"); 
							if (companyCode.isEmpty() || companyCode == null) {  
								
							}else { 
							int year = Integer.parseInt(request.getParameter("syear")); 
							 List<SipBranchPerformance> salesCodes = sipBranchPerformanceDbUtil.getSalesEngineersCodesForBranchManager(companyCode, year); 
							 StringBuilder builder = new StringBuilder();

							 for (SipBranchPerformance list : salesCodes)
							 {
							     builder.append("'"+list.getSalesCode()+"',");
							 }
							 String salesCodesString =  builder.deleteCharAt( builder.length() -1 ).toString(); 
							 if(fjtuser.getRole().equalsIgnoreCase("mg")) {
						    	  branchManagerCode = sipBranchPerformanceDbUtil.getBranchManagerCodeByCompany(companyCode); 
						      }
							 
							// getCustomerVisitSummary(request, response,  branchManagerCode, salesCodesString, year, companyCode); 
							 //getBookingSummary(request, response, branchManagerCode, salesCodesString, year, companyCode );
						    // getBillingSummary(request, response, branchManagerCode, salesCodesString, year, companyCode);
						     getJobinHandVolume(request, response, branchManagerCode, salesCodesString, year, companyCode);
						     getStage2LostSummaryforBranch(request, response, branchManagerCode, salesCodesString, year, companyCode); 
						     
						
						     getYtmDivisionLevelBillingSummery(request, response, branchManagerCode);
							 getYtmDivisionLevelBookingSummery(request, response, branchManagerCode);
							 request.setAttribute("BRANCHES", branches);
							 request.setAttribute("selected_Year", year);
							 request.setAttribute("selected_segs", salesCodesString);
							 request.setAttribute("selected_company_code", companyCode);
						     goToSipBranchPerformance(request, response);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						break;
				 case "aging_dt":
						try {// handling jihv aging wise details
							getJIHDetails(request, response);
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
				case "tsolhij":
					try {// Handling stage 2 lost aging wise details
						getStage2LostAgingDetails(request, response);
					} catch (Exception e) {
						e.printStackTrace();
					}
					break;
				case "cvDoSegfcYrmth":
					try {// Customer visit details of sales engineer for a custom month and year
						getCustomeVisitailsofSegForMonth(request, response);
					} catch (Exception e) {
						e.printStackTrace();
					}
					break;
				case "bkngAging":
					try {
						// booking details for month to YTD
						getSubDivisionBookingDetailsYtm(request, response);
					} catch (Exception e) {
						e.printStackTrace();
					}
					break;
				case "blngAging":
					try {
						// Billing details for month to YTD
						getSubDivisionBillingDetailsYtm(request, response);
					} catch (Exception e) {
						e.printStackTrace();
					}
					break;
				 default :
					 goToView(request, response, branchManagerCode, branches, fjtuser.getRole());
					 break;
				 }
			 }else {response.sendRedirect("homepage.jsp");}
			 
		    
		}else{
			response.sendRedirect("homepage.jsp");
		}
	}
	

	private void getSubDivisionBillingDetailsYtm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String division = request.getParameter("division");  
		int agingCode = Integer.parseInt(request.getParameter("agng")); 
		int year = Integer.parseInt(request.getParameter("slctdYr"));  
			List<SipBranchSubDivisionLevelBookingBilling> theBillingDtList = sipBranchPerformanceDbUtil.getSubDivisionBillingDetailsForYTD(division, agingCode, year);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter()); 

	}
	private void getSubDivisionBookingDetailsYtm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String division = request.getParameter("division");  
		int agingCode = Integer.parseInt(request.getParameter("agng")); 
		int year = Integer.parseInt(request.getParameter("slctdYr")); 
			List<SipBranchSubDivisionLevelBookingBilling> theBillingDtList = sipBranchPerformanceDbUtil.getSubDivisionBilookingDetailsForYTD(division, agingCode, year);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter()); 

	}
	private void getYtmDivisionLevelBillingSummery(HttpServletRequest request, HttpServletResponse response,
			String branchManagerCode) throws SQLException, ServletException, IOException { 
		List<SipMainDivisionBillingSummaryYtm> theYtmBillingList = sipBranchPerformanceDbUtil
				.getYtmBillingSummaryForAllDivision(branchManagerCode);
		request.setAttribute("YTM_BLNG_AD", theYtmBillingList);// ytm billing summary for all division

	}

	private void getYtmDivisionLevelBookingSummery(HttpServletRequest request, HttpServletResponse response,
			String branchManagerCode) throws SQLException, ServletException, IOException {
		List<SipMainDivisionBookingSummaryYtm> theYtmBillingList = sipBranchPerformanceDbUtil
				.getYtmBookingSummaryForAllDivision(branchManagerCode);
		request.setAttribute("YTM_BKNG_AD", theYtmBillingList);// ytm booking summary for all division

	}
	private void getBookingDetailsYtm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String salesCodesString = request.getParameter("secodes"); 
		String companyCode = request.getParameter("compCode");
		String agingCode = request.getParameter("agng");
		String year = request.getParameter("slctdYr"); 
		if (agingCode.equals("YTD")) {// if user click the Ytd bar in graph
			List<SipBookingBillingDetails> theBokkingDtList = sipBranchPerformanceDbUtil.bookingDetailsYtd(companyCode, year, salesCodesString);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		} else {// user click monthly bar
			List<SipBookingBillingDetails> theBokkingDtList = sipBranchPerformanceDbUtil.bookingDetailsYtm(companyCode, agingCode, year, salesCodesString);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		}

	}

	private void getBillingDetailsYtm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, JsonIOException, IOException {
		String salesCodesString = request.getParameter("secodes"); 
		String companyCode = request.getParameter("compCode");
		String agingCode = request.getParameter("agng"); 
		String year = request.getParameter("slctdYr"); 
		if (agingCode.equals("YTD")) {// if user click the Ytd bar in graph
			List<SipBookingBillingDetails> theBokkingDtList = sipBranchPerformanceDbUtil.billingDetailsYtd(companyCode, year, salesCodesString);
			response.setContentType("application/json");
			new Gson().toJson(theBokkingDtList, response.getWriter());
		} else {// user click monthly bar
			List<SipBookingBillingDetails> theBillingDtList = sipBranchPerformanceDbUtil.billingDetailsYtm(companyCode, agingCode, year, salesCodesString);
			response.setContentType("application/json");
			new Gson().toJson(theBillingDtList, response.getWriter());
		}

	}
	private void goToView(HttpServletRequest request, HttpServletResponse response, String branchManagerCode, List<SipBranchPerformance> branches, String userRole) throws SQLException, ServletException, IOException {
		 int year = Calendar.getInstance().get(Calendar.YEAR);
		 List<SipBranchPerformance> salesCodes = sipBranchPerformanceDbUtil.getSalesEngineersCodesForBranchManager(branches.get(0).getCompanyCode(), year); 
		 StringBuilder builder = new StringBuilder();
          
		 for (SipBranchPerformance list : salesCodes)
		 {
		     builder.append("'"+list.getSalesCode()+"',");
		 }
		 String salesCodesString =  builder.deleteCharAt( builder.length() -1 ).toString(); 
		 if(userRole.equalsIgnoreCase("mg")) {
	    	  branchManagerCode = sipBranchPerformanceDbUtil.getBranchManagerCodeByCompany(branches.get(0).getCompanyCode()); 
	      }
	
		 
		// getBookingSummary(request, response, branchManagerCode, salesCodesString, year, branches.get(0).getCompanyCode());
	    // getBillingSummary(request, response, branchManagerCode, salesCodesString, year, branches.get(0).getCompanyCode());
	     getJobinHandVolume(request, response, branchManagerCode, salesCodesString, year, branches.get(0).getCompanyCode());
	     getStage2LostSummaryforBranch(request, response, branchManagerCode, salesCodesString, year, branches.get(0).getCompanyCode());
	    // getCustomerVisitSummary(request, response,  branchManagerCode, salesCodesString, year, branches.get(0).getCompanyCode());
	     getYtmDivisionLevelBillingSummery(request, response, branchManagerCode);
		 getYtmDivisionLevelBookingSummery(request, response, branchManagerCode);
		 request.setAttribute("BRANCHES", branches);
		 request.setAttribute("selected_Year", year);
		 request.setAttribute("selected_segs", salesCodesString);
		 request.setAttribute("selected_company_code", branches.get(0).getCompanyCode());
	     goToSipBranchPerformance(request, response);
	    
	}
    private void getJobinHandVolume(HttpServletRequest request, HttpServletResponse response, String branchManagerCode,
			String salesCodesString, int year, String companyCode) throws SQLException {
    	List<SipJihvSummary> theVolumeList = sipBranchPerformanceDbUtil.getJobInHandVolumeSummary(salesCodesString, companyCode);  
		request.setAttribute("JIHV", theVolumeList);
		
	}

	private void getJIHDetails(HttpServletRequest request, HttpServletResponse response) 		throws IOException, SQLException, ServletException {
		String salesCodesString = request.getParameter("secodes"); 
		String companyCode = request.getParameter("compCode");
		String agingCode = request.getParameter("agng");
		List<SipJihvDetails> theAgingDtList = sipBranchPerformanceDbUtil.getJihvAgingDetails(salesCodesString, companyCode, agingCode);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
		
	}
	private void getCustomeVisitailsofSegForMonth(HttpServletRequest request, HttpServletResponse response) throws JsonIOException, IOException, SQLException {
		String salesCodesString = request.getParameter("secodes");
		String year = request.getParameter("cvYr");
		String month = request.getParameter("cvMth");  
		List<CustomerVisit> theCVstDetails = sipBranchPerformanceDbUtil.getSegCustomerVisitDetails(salesCodesString, year, month); 
		response.setContentType("application/json");
		new Gson().toJson(theCVstDetails, response.getWriter());
		
	}
    private void getStage2LostSummaryforBranch(HttpServletRequest request, HttpServletResponse response, String branchManagerCode,
			String salesCodesString, int year, String companyCode)  throws SQLException, ServletException, IOException {
		List<SipDStage2LostSummary> theVolumeList = sipBranchPerformanceDbUtil.getStage2LostCountforBranch(salesCodesString, companyCode);
		request.setAttribute("JIHVLOST", theVolumeList);
	}
 
	private void getStage2LostAgingDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonIOException, IOException {
		String aging = request.getParameter("agng");// aging value for stage jih lost aging details
		if (aging.equals("0")) {
			aging = "0-3Mths";
		} else if (aging.equals("1")) {
			aging = "3-6Mths";
		} else {
			aging = ">6Mths";
		}
		String salesCodesString = request.getParameter("secodes"); 
		String companyCode = request.getParameter("compCode"); 
		List<SipDivStage2LostDetails> theAgingDtList = sipBranchPerformanceDbUtil.getStage2LostAging_Details_Division(salesCodesString,
				aging, companyCode);
		response.setContentType("application/json");
		new Gson().toJson(theAgingDtList, response.getWriter());
	}
	private void getCustomerVisitSummary(HttpServletRequest request, HttpServletResponse response, String branchManagerCode, String salesCodesString, int year, String companyCode) throws SQLException {
		 List<CustomerVisit> theCvCount = sipBranchPerformanceDbUtil.getSalesEngineerCustoVisitCounts(salesCodesString, year, companyCode); 
			request.setAttribute("SEYRLYCVS", theCvCount); 
    
	}
	private void getBillingSummary(HttpServletRequest request, HttpServletResponse response, String branchManagerCode, String salesCodes, int year, String company_code) throws SQLException {
		List<SipBilling> theYtmBillingList = sipBranchPerformanceDbUtil.getYtmBilling(branchManagerCode, year, salesCodes, company_code);
		request.setAttribute("YTM_BILL", theYtmBillingList);
		
	}
	private void getBookingSummary(HttpServletRequest request, HttpServletResponse response, String branchManagerCode, String salesCodes, int year, String company_code) throws SQLException {
		// TODO Auto-generated method stub
		List<SipBooking> theYtmBookingList = sipBranchPerformanceDbUtil.getYtmBooking(branchManagerCode, year, salesCodes, company_code);
		request.setAttribute("YTM_BOOK", theYtmBookingList);
	}
	private void goToSipBranchPerformance(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher;
		dispatcher = request.getRequestDispatcher("/sipBranchPerform.jsp");
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
