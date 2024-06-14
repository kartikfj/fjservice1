package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import beans.CustomerVisit;
import beans.OrclDBConnectionPool;
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

public class SipBranchPerformanceDbUtil {

	public List<SipBranchPerformance> checkTheBranchManagerPermission(String branchManagerCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		List<SipBranchPerformance> companyList = new ArrayList<>();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT COMPANY, ACT_YN FROM FJPORTAL.FJ_SALES_BRANCH_MANGRS "
					+ " WHERE GM_CODE = ? AND ACT_YN = ?  ORDER BY COMPANY ASC";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, branchManagerCode);
			myStmt.setString(2, "Y");
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String activeYN = myRes.getString(2);
				SipBranchPerformance tempCompanyList = new SipBranchPerformance(company, activeYN);
				companyList.add(tempCompanyList);
			}
			return companyList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	private void close(Statement myStmt, ResultSet myRes) {
		try {
			if (myRes != null) {
				myRes.close();
			}
			if (myStmt != null) {
				myStmt.close();
			}
		} catch (Exception exc) {
			exc.printStackTrace();
		}
	}

	public List<SipBooking> getYtmBooking(String branchManagerCode, int year, String salesCodes, String company_code)
			throws SQLException {
		List<SipBooking> bookingList = new ArrayList<>();// booking list for an year.. in yera to date
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SMT_YEAR, MTH_TRGT, TOT_TRGT, YTD_TRGT, JAN_A, FEB_A, MAR_A, APR_A, MAY_A, JUN_A, JUL_A, AUG_A, SEP_A, OCT_A, NOV_A, DEC_A, YR_TOT_A   "
					+ "FROM (  (  "
					+ "SELECT SMT_YEAR  , ROUND(NVL(SUM(JAN_T),0)) \"MTH_TRGT\", ROUND(NVL(SUM(YR_TOT_T),0)) \"TOT_TRGT\",  ROUND(NVL(SUM(YTD_TARG),0)) \"YTD_TRGT\"   "
					+ " FROM (  "
					+ " SELECT  SMT_CODE,  SMT_YEAR, JAN_T, YR_TOT_T, ROUND(NVL(YR_TOT_T,0)/365*(TO_DATE(SYSDATE,'DD/MM/RRRR') -TO_DATE(TRUNC(SYSDATE,'RRRR'))),0)YTD_TARG    "
					+ " FROM FJT_SM_BKNG_TRG_ACT_SUMM_TBL WHERE SMT_CODE IN (" + salesCodes + ")  AND SMT_YEAR= ?  "
					+ " ) Ts  " + " GROUP BY SMT_YEAR  " + ") )T1  " + "LEFT JOIN  " + "(  "
					+ "SELECT YEAR, ROUND(NVL(SUM(JAN_A),0)) \"JAN_A\", ROUND(NVL(SUM(FEB_A),0)) \"FEB_A\", ROUND(NVL(SUM(MAR_A),0)) \"MAR_A\", ROUND(NVL(SUM(APR_A),0)) \"APR_A\",    "
					+ " ROUND(NVL(SUM(MAY_A),0)) \"MAY_A\", ROUND(NVL(SUM(JUN_A),0)) \"JUN_A\", ROUND(NVL(SUM(JUL_A),0)) \"JUL_A\", ROUND(NVL(SUM(AUG_A),0)) \"AUG_A\", ROUND(NVL(SUM(SEP_A),0)) \"SEP_A\", ROUND(NVL(SUM(OCT_A),0)) \"OCT_A\",     "
					+ " ROUND(NVL(SUM(NOV_A),0)) \"NOV_A\", ROUND(NVL(SUM(DEC_A),0)) \"DEC_A\", ROUND(NVL(SUM(YR_TOT_A),0)) \"YR_TOT_A\" FROM FJPORTAL.SIP_SEGs_BRANCH_BKNG_YTD_VIEW  "
					+ "WHERE COMP  = ?  " + "AND YEAR = ?  " + "AND SM_CODE IN (" + salesCodes + ")   "
					+ "GROUP BY YEAR  " + ")  T2  " + "ON T1.SMT_YEAR = T2.YEAR";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myStmt.setString(2, company_code);
			myStmt.setInt(3, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String year1 = myRes.getString(1);
				String monthly_target = myRes.getString(2);
				String yr_total_target = myRes.getString(3);
				String ytm_target = myRes.getString(4);
				String jan_a = myRes.getString(5);
				String feb_a = myRes.getString(6);
				String mar_a = myRes.getString(7);
				String apr_a = myRes.getString(8);
				String may_a = myRes.getString(9);
				String jun_a = myRes.getString(10);
				String jul_a = myRes.getString(11);
				String aug_a = myRes.getString(12);
				String sep_a = myRes.getString(13);
				String oct_a = myRes.getString(14);
				String nov_a = myRes.getString(15);
				String dec_a = myRes.getString(16);
				String ytm_actual = myRes.getString(17);
				SipBooking tempBookingList = new SipBooking(company_code, year1, monthly_target, yr_total_target,
						ytm_target, jan_a, feb_a, mar_a, apr_a, may_a, jun_a, jul_a, aug_a, sep_a, oct_a, nov_a, dec_a,
						ytm_actual);
				bookingList.add(tempBookingList);
			}
			return bookingList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBranchPerformance> getSalesEngineersCodesForBranchManager(String companyCode, int year)
			throws SQLException {
		List<SipBranchPerformance> salesCodeList = new ArrayList<>();// booking list for an year.. in yera to date
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DISTINCT CQH_SM_CODE " + "  FROM OT_CUST_QUOT_HEAD "
					+ "WHERE TO_CHAR (CQH_DT, 'RRRR') = ?  " + " AND CQH_COMP_CODE = ? " + "UNION "
					+ "SELECT DISTINCT SOH_SM_CODE " + "  FROM OT_SO_HEAD " + "WHERE TO_CHAR (SOH_DT, 'RRRR') = ?  "
					+ "       AND SOH_COMP_CODE = ? " + "UNION " + "SELECT DISTINCT INVH_SM_CODE "
					+ "  FROM OT_INVOICE_HEAD " + "WHERE TO_CHAR (INVH_DT, 'RRRR') = ?   "
					+ "       AND INVH_COMP_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myStmt.setString(2, companyCode);
			myStmt.setInt(3, year);
			myStmt.setString(4, companyCode);
			myStmt.setInt(5, year);
			myStmt.setString(6, companyCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesCode = myRes.getString(1);
				// System.out.println("SEG : "+salesCode);
				SipBranchPerformance tempSalesCodeList = new SipBranchPerformance(salesCode);
				salesCodeList.add(tempSalesCodeList);
			}
			return salesCodeList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBilling> getYtmBilling(String branchManagerCode, int year, String salesCodes, String company_code)
			throws SQLException {
		List<SipBilling> billingList = new ArrayList<>();// booking list for an year.. in yera to date
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SMT_YEAR, MTH_TRGT, TOT_TRGT, YTD_TRGT, JAN_A, FEB_A, MAR_A, APR_A, MAY_A, JUN_A, JUL_A, AUG_A, SEP_A, OCT_A, NOV_A, DEC_A, YR_TOT_A  "
					+ "FROM (  ( "
					+ "SELECT SMT_YEAR  , ROUND(NVL(SUM(JAN_T),0)) \"MTH_TRGT\", ROUND(NVL(SUM(YR_TOT_T),0)) \"TOT_TRGT\",  ROUND(NVL(SUM(YTD_TARG),0)) \"YTD_TRGT\"  "
					+ " FROM ( "
					+ " SELECT  SMT_CODE,  SMT_YEAR, JAN_T, YR_TOT_T, ROUND(NVL(YR_TOT_T,0)/365*(TO_DATE(SYSDATE,'DD/MM/RRRR') -TO_DATE(TRUNC(SYSDATE,'RRRR'))),0)YTD_TARG   "
					+ " FROM FJT_SM_BLNG_TRG_ACT_SUMM_TBL WHERE SMT_CODE IN  (" + salesCodes + ") AND SMT_YEAR= ?  "
					+ "   ) Ts " + "   GROUP BY SMT_YEAR " + ") )T1 " + "LEFT JOIN " + "( "
					+ "SELECT YEAR, ROUND(NVL(SUM(JAN_A),0)) \"JAN_A\", ROUND(NVL(SUM(FEB_A),0)) \"FEB_A\", ROUND(NVL(SUM(MAR_A),0)) \"MAR_A\", ROUND(NVL(SUM(APR_A),0)) \"APR_A\",   "
					+ " ROUND(NVL(SUM(MAY_A),0)) \"MAY_A\", ROUND(NVL(SUM(JUN_A),0)) \"JUN_A\", ROUND(NVL(SUM(JUL_A),0)) \"JUL_A\", ROUND(NVL(SUM(AUG_A),0)) \"AUG_A\", ROUND(NVL(SUM(SEP_A),0)) \"SEP_A\", ROUND(NVL(SUM(OCT_A),0)) \"OCT_A\",    "
					+ " ROUND(NVL(SUM(NOV_A),0)) \"NOV_A\", ROUND(NVL(SUM(DEC_A),0)) \"DEC_A\", ROUND(NVL(SUM(YR_TOT_A),0)) \"YR_TOT_A\" FROM FJPORTAL.SIP_SEGs_BRANCH_BLNG_YTD_VIEW "
					+ "WHERE COMP = ? " + "AND YEAR = ?  " + "AND SM_CODE IN  (" + salesCodes + ") " + "GROUP BY YEAR "
					+ ")  T2 " + "ON T1.SMT_YEAR = T2.YEAR ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myStmt.setString(2, company_code);
			myStmt.setInt(3, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String year1 = myRes.getString(1);
				String monthly_target = myRes.getString(2);
				String yr_total_target = myRes.getString(3);
				String ytm_target = myRes.getString(4);
				String jan_a = myRes.getString(5);
				String feb_a = myRes.getString(6);
				String mar_a = myRes.getString(7);
				String apr_a = myRes.getString(8);
				String may_a = myRes.getString(9);
				String jun_a = myRes.getString(10);
				String jul_a = myRes.getString(11);
				String aug_a = myRes.getString(12);
				String sep_a = myRes.getString(13);
				String oct_a = myRes.getString(14);
				String nov_a = myRes.getString(15);
				String dec_a = myRes.getString(16);
				String ytm_actual = myRes.getString(17);
				SipBilling tempBillingList = new SipBilling(company_code, year1, monthly_target, yr_total_target,
						ytm_target, jan_a, feb_a, mar_a, apr_a, may_a, jun_a, jul_a, aug_a, sep_a, oct_a, nov_a, dec_a,
						ytm_actual);
				billingList.add(tempBillingList);
			}
			return billingList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> bookingDetailsYtd(String companyCode, String year, String salesCodesString)
			throws SQLException {
		List<SipBookingBillingDetails> bookingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year
			String sql = "select  COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, LOI_RCVD_DT, CURR,AMOUNT_AED "
					+ " from SIP_SM_BKNG_TBL where COMP = ? " + " AND  SM_CODE IN (" + salesCodesString
					+ ")and LOI_RCVD_DT between '01-JAN-'|| ? and to_date(sysdate,'DD/MM/RRRR') "
					+ "order by LOI_RCVD_DT desc";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myStmt.setString(2, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String dcmnt_id = myRes.getString(3);
				String dcmnt_dt = myRes.getString(4);
				String sm_id = myRes.getString(5);
				String sm_name = myRes.getString(6);
				String party_name = myRes.getString(7);
				String contact = myRes.getString(8);
				String telephone = myRes.getString(9);
				String project_name = myRes.getString(10);
				String product = myRes.getString(11);
				String zone = myRes.getString(12);
				String loi_rcvd_dt = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempbkYtdDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						loi_rcvd_dt, currency, amount);
				bookingDetailsYtdList.add(tempbkYtdDetailsList);
			}
			return bookingDetailsYtdList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> bookingDetailsYtm(String companyCode, String month, String Year,
			String salesCodesString) throws SQLException {

		List<SipBookingBillingDetails> bookingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year - YTM
			String sql = " select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, LOI_RCVD_DT, CURR,AMOUNT_AED from SIP_SM_BKNG_VIEW where COMP = ? "
					+ " AND SM_CODE IN (" + salesCodesString
					+ ") and LOI_RCVD_DT between '01-'||?||'-'||? and last_day('01-'||?||'-'||?)  order by LOI_RCVD_DT desc";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myStmt.setString(2, month);
			myStmt.setString(3, Year);
			myStmt.setString(4, month);
			myStmt.setString(5, Year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String dcmnt_id = myRes.getString(3);
				String dcmnt_dt = myRes.getString(4);
				String sm_id = myRes.getString(5);
				String sm_name = myRes.getString(6);
				String party_name = myRes.getString(7);
				String contact = myRes.getString(8);
				String telephone = myRes.getString(9);
				String project_name = myRes.getString(10);
				String product = myRes.getString(11);
				String zone = myRes.getString(12);
				String loi_rcvd_dt = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempbkYtmDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						loi_rcvd_dt, currency, amount);
				bookingDetailsYtmList.add(tempbkYtmDetailsList);
			}
			return bookingDetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> billingDetailsYtd(String companyCode, String year, String salesCodesString)
			throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get billingdetails for a given month and year
			String sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED   "
					+ "from SIP_SM_BLNG_TBL where COMP = ? " + " and SM_CODE IN (" + salesCodesString
					+ ") and doc_date between '01-JAN-'||? and to_date(sysdate,'DD/MM/RRRR') "
					+ "order by doc_date desc  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myStmt.setString(2, year);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String dcmnt_id = myRes.getString(3);
				String dcmnt_dt = myRes.getString(4);
				String sm_id = myRes.getString(5);
				String sm_name = myRes.getString(6);
				String party_name = myRes.getString(7);
				String contact = myRes.getString(8);
				String telephone = myRes.getString(9);
				String project_name = myRes.getString(10);
				String product = myRes.getString(11);
				String zone = myRes.getString(12);
				String currency = myRes.getString(13);
				String amount = myRes.getString(14);
				SipBookingBillingDetails tempblYtdDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone, currency,
						amount);
				billingDetailsYtdList.add(tempblYtdDetailsList);
			}
			return billingDetailsYtdList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> billingDetailsYtm(String companyCode, String month, String Year,
			String salesCodesString) throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year
			String sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED "
					+ "from SIP_SM_BLNG_VIEW where COMP = ?  " + " and SM_CODE IN ( " + salesCodesString
					+ ") and doc_date between '01-'||?||'-'||?  and last_day('01-'||?||'-'||?)  order by doc_date desc ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myStmt.setString(2, month);
			myStmt.setString(3, Year);
			myStmt.setString(4, month);
			myStmt.setString(5, Year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String dcmnt_id = myRes.getString(3);
				String dcmnt_dt = myRes.getString(4);
				String sm_id = myRes.getString(5);
				String sm_name = myRes.getString(6);
				String party_name = myRes.getString(7);
				String contact = myRes.getString(8);
				String telephone = myRes.getString(9);
				String project_name = myRes.getString(10);
				String product = myRes.getString(11);
				String zone = myRes.getString(12);
				String currency = myRes.getString(13);
				String amount = myRes.getString(14);
				SipBookingBillingDetails tempblYtmDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone, currency,
						amount);
				billingDetailsYtmList.add(tempblYtmDetailsList);
			}
			return billingDetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<SipJihvSummary> getJobInHandVolumeSummary(String salesCodesString, String companyCode)
			throws SQLException {

		List<SipJihvSummary> volumeList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT JIH_AGING, ROUND(SUM(QTN_AMOUNT),0)AMT FROM FJT_SM_JIH_AGING_SUM_TBL "
					+ "WHERE SALES_EGR_CODE IN ( " + salesCodesString
					+ ") AND COMP_CODE = ?  GROUP BY JIH_AGING ORDER BY JIH_AGING";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String duration_tmp = myRes.getString(1);
				String amount_tmp = myRes.getString(2);
				SipJihvSummary tempVolumeList = new SipJihvSummary(duration_tmp, amount_tmp);
				volumeList.add(tempVolumeList);
			}
			return volumeList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDStage2LostSummary> getStage2LostCountforBranch(String salesCodesString, String copmanyCode)
			throws SQLException {
		List<SipDStage2LostSummary> stage2LostQtnList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  "
					+ "SUM(THREEMTHSCNT), SUM(THREEMTHSLOSTCNT), SUM(THREEMTHSLOSTAMT), SUM(THREESIXMTHSCNT), "
					+ "SUM(THREESIXMTHSCNT), SUM(THREESIXMTHSLOSTCNT),  SUM(THREESIXMTHSAMT), SUM(THREESIXMTHSLOSTAMT), "
					+ "SUM(SIXMTHSCNT), SUM(SIXMTHSLOSTCNT), SUM(SIXMTHSAMT), SUM(SIXMTHSLOSTAMT) "
					+ "FROM AM_SM_JIH_AGE_SUM_2YR_TBL " + "WHERE  SM_CODE IN ( " + salesCodesString
					+ ") AND COMPCODE = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, copmanyCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String aging1_count_tmp = myRes.getString(1);
				String aging1_lost_count_tmp = myRes.getString(2);
				String ging1_amount = myRes.getString(3);
				String aging1_lost_amount_tmp = myRes.getString(4);
				String aging2_count_tmp = myRes.getString(5);
				String aging2_lost_count_tmp = myRes.getString(6);
				String aging2_amount_tmp = myRes.getString(7);
				String aging2_lost_amount_tmp = myRes.getString(8);
				String aging3_count_tmp = myRes.getString(9);
				String aging3_lost_count_tmp = myRes.getString(10);
				String aging3_amount_tmp = myRes.getString(11);
				String aging3_lost_amount_tmp = myRes.getString(12);
				SipDStage2LostSummary tempStage2LostSummary = new SipDStage2LostSummary(copmanyCode, aging1_count_tmp,
						aging1_lost_count_tmp, ging1_amount, aging1_lost_amount_tmp, aging2_count_tmp,
						aging2_lost_count_tmp, aging2_amount_tmp, aging2_lost_amount_tmp, aging3_count_tmp,
						aging3_lost_count_tmp, aging3_amount_tmp, aging3_lost_amount_tmp);
				stage2LostQtnList.add(tempStage2LostSummary);
			}
			return stage2LostQtnList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	private String formatDate(String sqlDate) {
		String dateValue = sqlDate.substring(0, 10);
		// System.out.println(dateValue);
		String formattedDate = "";
		String[] tempArray;
		String delimiter = "-";
		tempArray = dateValue.split(delimiter);
		String[] newArray = new String[3];
		for (int i = 0, j = 2; i <= 2; i++) {
			// System.out.println(tempArray[i] +" j = "+j);
			newArray[j] = tempArray[i];
			j--;
		}

		formattedDate = Arrays.toString(newArray);
		formattedDate = formattedDate.substring(1, formattedDate.length() - 1).replace(", ", "/");
		// System.out.println(formattedDate);

		return formattedDate;

	}

	public List<SipDivStage2LostDetails> getStage2LostAging_Details_Division(String salesCodesString, String aging,
			String companyCode) throws SQLException {
		List<SipDivStage2LostDetails> agingDetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "   SELECT DISTINCT T1.COMP_CODE, T1.WEEK,   T1.QTN_DT,  T1.QTN_CODE, "
					+ "  T1.QTN_NO,  T1.CUST_CODE, T1.CUST_NAME, T1.SALES_EGR_CODE,  "
					+ "  T1.SALES_ENG_NAME, T1.PROJECT_NAME,  T1.CONSULTANT,  T1.INVOICING_YEAR,  T1.PROD_TYPE,  T1.PROD_CLASSFCN,   "
					+ " T1.ZONE, T1.PROFIT_PERC, T1.QTN_AMOUNT,  T2.LH_STATUS, "
					+ " coalesce(( SELECT DESCRIPTION FROM  QUOT_LOST_TYPE  WHERE CODE = T2.LHREMARKS_TYPE ),'-') LOST_TYPE , coalesce(T2.LH_REMARKS, '-') LOST_DESC FROM FJT_DM_JIH_AGE_DET_LOST_TBL T1 "
					+ " LEFT JOIN FJPORTAL.FJT_SM_STG2_TBL T2" + " ON  T1.QTN_SYS_ID = T2.CQHSYSID  "
					+ " GROUP BY T1.COMP_CODE, T1.WEEK,   T1.QTN_DT,  T1.QTN_CODE,  "
					+ "  T1.QTN_NO,  T1.CUST_CODE, T1.CUST_NAME, T1.SALES_EGR_CODE,  "
					+ "  T1.SALES_ENG_NAME, T1.PROJECT_NAME,  T1.CONSULTANT,  T1.INVOICING_YEAR,  T1.PROD_TYPE,  T1.PROD_CLASSFCN,   "
					+ "  T1.ZONE, T1.PROFIT_PERC, T1.QTN_AMOUNT, T1.JIH_AGING, T2.LH_STATUS, T2.LHREMARKS_TYPE, T2.LH_REMARKS"
					+ " HAVING T1.SALES_EGR_CODE in (" + salesCodesString + ")"
					+ "  AND T1.JIH_AGING = ? AND T1.COMP_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, aging);
			myStmt.setString(2, companyCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String week = myRes.getString(1);
				String cmp_code = myRes.getString(2);
				String qtn_date = myRes.getString(3);
				String qtn_code = myRes.getString(4);
				String qtn_numbr = myRes.getString(5);
				String cust_code = myRes.getString(6);
				String cust_name = myRes.getString(7);
				String sales_egr_code = myRes.getString(8);
				String sales_egr_name = myRes.getString(9);
				String project_name = myRes.getString(10);
				String consultant = myRes.getString(11);
				String invoice_yr = myRes.getString(12);
				String product_type = myRes.getString(13);
				String product_classfctn = myRes.getString(14);
				String zone = myRes.getString(15);
				String profit = myRes.getString(16);
				String qtn_amount = myRes.getString(17);
				String qtn_status = myRes.getString(18);
				String qtn_lost_type = myRes.getString(19);
				String qtn_lost_remark = myRes.getString(20);

				SipDivStage2LostDetails tempagingdetailsList = new SipDivStage2LostDetails(week, cmp_code, qtn_date,
						qtn_code, qtn_numbr, cust_code, cust_name, sales_egr_code, sales_egr_name, project_name,
						consultant, invoice_yr, product_type, product_classfctn, zone, profit, qtn_amount, qtn_status,
						qtn_lost_type, qtn_lost_remark);
				agingDetailsList.add(tempagingdetailsList);
			}
			return agingDetailsList;

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihvDetails> getJihvAgingDetails(String salesCodesString, String companyCode, String agingCode)
			throws SQLException {
		List<SipJihvDetails> agingDetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE, CUST_NAME, PROJECT_NAME, CONSULTANT, INVOICING_YEAR, PROD_TYPE, "
					+ " PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT, SALES_EGR_CODE, SALES_ENG_NAME FROM FJT_SM_JIH_AGING_DETAIL_TBL "
					+ "WHERE COMP_CODE = ? AND  SALES_EGR_CODE  in (" + salesCodesString
					+ ") AND JIH_AGING=?   order by QTN_DT";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myStmt.setString(2, agingCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String cmp_code = myRes.getString(1);
				String week = myRes.getString(2);
				String quatation_dt = myRes.getString(3);
				String quatation_code = myRes.getString(4);
				String quatation_num = myRes.getString(5);
				String customer_code = myRes.getString(6);
				String customer_name = myRes.getString(7);
				String project_name = myRes.getString(8);
				String consultant = myRes.getString(9);
				String invoicing_yr = myRes.getString(10);
				String prdct_type = myRes.getString(11);
				String product_classf = myRes.getString(12);
				String zone = myRes.getString(13);
				String profit_perc = myRes.getString(14);
				int qtn_amount = myRes.getInt(15);
				String segCode = myRes.getString(16);
				String segName = myRes.getString(17);
				SipJihvDetails tempagingDetailsList = new SipJihvDetails(cmp_code, week, quatation_dt, quatation_code,
						quatation_num, customer_code, customer_name, project_name, consultant, invoicing_yr, prdct_type,
						product_classf, zone, profit_perc, qtn_amount, segCode, segName);
				agingDetailsList.add(tempagingDetailsList);
			}
			return agingDetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<CustomerVisit> getSalesEngineerCustoVisitCounts(String salesCodesString, int year, String companyCode)
			throws SQLException {
		List<CustomerVisit> visitCounts = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT MTH, SUM(CNT) from (SELECT EXTRACT(YEAR FROM ACT_DT) YR, EXTRACT(MONTH FROM ACT_DT) MTH, ACT_SM_CODE, "
					+ "  COUNT(ACT_SM_CODE) CNT " + "  FROM FJPORTAL.CUS_VIST_ACTION "
					+ "  GROUP BY EXTRACT(YEAR FROM ACT_DT), EXTRACT(MONTH FROM ACT_DT) , ACT_SM_CODE "
					+ "  HAVING  ACT_SM_CODE IN ( " + salesCodesString + " )  AND EXTRACT(YEAR FROM ACT_DT) = ? "
					+ "  ORDER BY 2 ASC ) T1 " + "  GROUP BY MTH ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int month = myRes.getInt(1);
				int totalVisits = myRes.getInt(2);
				CustomerVisit tmpVisitCounts = new CustomerVisit(year, month, totalVisits);
				visitCounts.add(tmpVisitCounts);
			}
			return visitCounts;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<CustomerVisit> getSegCustomerVisitDetails(String salesCodesString, String year, String month)
			throws SQLException {
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "  SELECT ACT_DOC_ID, ACT_SM_CODE, ACT_DT, ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME, "
					+ "CONT_PERSON, CONT_NUMBER, SM_NAME " + " FROM  FJPORTAL.CUS_VIST_ACTION T1 "
					+ " LEFT JOIN OM_SALESMAN T2 " + " ON T1.ACT_SM_CODE = T2.SM_CODE " + " WHERE   "
					+ " ACT_SM_CODE  IN ( " + salesCodesString
					+ ")  AND to_number(to_char(to_date(ACT_DT,'DD-MM-YY'),'YYYY'))  = ?  AND to_number(to_char(to_date(ACT_DT,'DD-MM-YY'),'MM')) = ?  ORDER BY 4 ASC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year);
			myStmt.setString(2, month);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String smCode = myRes.getString(2);
				String actionDate = myRes.getString(3);
				String actionDesc = myRes.getString(4);
				String visitType = myRes.getString(5);
				String fromTime = myRes.getString(6);
				String toTime = myRes.getString(7);
				String projectName = myRes.getString(8);
				String partyName = myRes.getString(9);
				String custName = myRes.getString(10);
				String custContactNo = myRes.getString(11);
				String smName = myRes.getString(12);
				CustomerVisit tmpProjectList = new CustomerVisit(documentId, smCode, actionDate, actionDesc, visitType,
						fromTime, toTime, projectName, partyName, custName, custContactNo, smName);
				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBranchPerformance> checkTheBranchManagerPermissionForMangment() throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		List<SipBranchPerformance> companyList = new ArrayList<>();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DISTINCT COMPANY, ACT_YN FROM FJPORTAL.FJ_SALES_BRANCH_MANGRS "
					+ " WHERE  ACT_YN = ? ORDER BY COMPANY ASC";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "Y");
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String activeYN = myRes.getString(2);
				SipBranchPerformance tempCompanyList = new SipBranchPerformance(company, activeYN);
				companyList.add(tempCompanyList);
			}
			return companyList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipMainDivisionBillingSummaryYtm> getYtmBillingSummaryForAllDivision(String branchManagerCode)
			throws SQLException {
		List<SipMainDivisionBillingSummaryYtm> divisionBillingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DIVN,  " + "  DMCODE,  " + "  JAN_A \"JAN\",  " + "  FEB_A \"FEB\",  "
					+ "  MAR_A \"MAR\",  " + "  APR_A \"APR\",  " + "  MAY_A \"MAY\",  " + "  JUN_A \"JUN\",  "
					+ "  JUL_A \"JUL\",  " + "  AUG_A \"AUG\",  " + "  SEP_A \"SEP\",  " + "  OCT_A \"OCT\",  "
					+ "  NOV_A \"NOV\",  " + "  DEC_A \"DEC\",  " + "  YR_TOT_A \"TOTAL\" FROM KSA_BLNG_TRGT_TBL  "
					+ "  WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, branchManagerCode);// branchManagerCode
			// Execute a SQL query
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String divn_tmp = myRes.getString(1);
				String dm_tmp = myRes.getString(2);
				String jan_tmp = myRes.getString(3);
				String feb_tmp = myRes.getString(4);
				String mar_tmp = myRes.getString(5);
				String apr_tmp = myRes.getString(6);
				String may_tmp = myRes.getString(7);
				String jun_tmp = myRes.getString(8);
				String jul_tmp = myRes.getString(9);
				String aug_tmp = myRes.getString(10);
				String sep_tmp = myRes.getString(11);
				String oct_tmp = myRes.getString(12);
				String nov_tmp = myRes.getString(13);
				String dec_tmp = myRes.getString(14);
				String total_tmp = myRes.getString(15);
				SipMainDivisionBillingSummaryYtm tempdivisionBillingList = new SipMainDivisionBillingSummaryYtm(
						divn_tmp, dm_tmp, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp, jun_tmp, jul_tmp, aug_tmp,
						sep_tmp, oct_tmp, nov_tmp, dec_tmp, total_tmp);
				divisionBillingList.add(tempdivisionBillingList);
			}
			return divisionBillingList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipMainDivisionBookingSummaryYtm> getYtmBookingSummaryForAllDivision(String branchManagerCode)
			throws SQLException {
		List<SipMainDivisionBookingSummaryYtm> divisionBookingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DIVN,  " + "  DMCODE,  " + "  JAN_A \"JAN\",  " + "  FEB_A \"FEB\",  "
					+ "  MAR_A \"MAR\",  " + "  APR_A \"APR\",  " + "  MAY_A \"MAY\",  " + "  JUN_A \"JUN\",  "
					+ "  JUL_A \"JUL\",  " + "  AUG_A \"AUG\",  " + "  SEP_A \"SEP\",  " + "  OCT_A \"OCT\",  "
					+ "  NOV_A \"NOV\",  " + "  DEC_A \"DEC\",  " + "  YR_TOT_A \"TOTAL\" FROM KSA_BKNG_TRGT_TBL   "
					+ "  WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, branchManagerCode);// branchManagerCode
			// Execute a SQL query
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String divn_tmp = myRes.getString(1);
				String dm_tmp = myRes.getString(2);
				String jan_tmp = myRes.getString(3);
				String feb_tmp = myRes.getString(4);
				String mar_tmp = myRes.getString(5);
				String apr_tmp = myRes.getString(6);
				String may_tmp = myRes.getString(7);
				String jun_tmp = myRes.getString(8);
				String jul_tmp = myRes.getString(9);
				String aug_tmp = myRes.getString(10);
				String sep_tmp = myRes.getString(11);
				String oct_tmp = myRes.getString(12);
				String nov_tmp = myRes.getString(13);
				String dec_tmp = myRes.getString(14);
				String total_tmp = myRes.getString(15);
				SipMainDivisionBookingSummaryYtm tempdivisionBillingList = new SipMainDivisionBookingSummaryYtm(
						divn_tmp, dm_tmp, jan_tmp, feb_tmp, mar_tmp, apr_tmp, may_tmp, jun_tmp, jul_tmp, aug_tmp,
						sep_tmp, oct_tmp, nov_tmp, dec_tmp, total_tmp);
				divisionBookingList.add(tempdivisionBillingList);
			}
			return divisionBookingList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBranchSubDivisionLevelBookingBilling> getSubDivisionBillingDetailsForYTD(String theDivision,
			int theMonth, int theYear) throws SQLException {
		String mmyy = "";
		if (theMonth <= 12) {
			mmyy = (theMonth > 9 ? theMonth + "/" + theYear : "0" + theMonth + "/" + theYear);
		} else {
			mmyy = "" + theYear;
		}
		String sql = "";
		List<SipBranchSubDivisionLevelBookingBilling> detailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (theMonth <= 12) {
				sql = " SELECT * FROM SIP_DM_BLNG_TBL   WHERE DIVN_CODE = ?       "
						+ " AND  TO_CHAR(DOC_DATE, 'MM/YYYY')  = ?  ";

			} else {
				sql = " SELECT * FROM SIP_DM_BLNG_TBL   WHERE DIVN_CODE = ?       "
						+ " AND  TO_CHAR(DOC_DATE, 'YYYY')  = ?  ";
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDivision);
			myStmt.setString(2, mmyy);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String documentID = myRes.getString(3);
				String documentDate = myRes.getString(4);
				String smCode = myRes.getString(5);
				String smName = myRes.getString(6);
				String dmCode = myRes.getString(7);
				String division = myRes.getString(8);
				String partyName = myRes.getString(9);
				String contact = myRes.getString(10);
				String telePhone = myRes.getString(11);
				String projectName = myRes.getString(12);
				String product = myRes.getString(13);
				String zone = myRes.getString(14);
				String currency = myRes.getString(15);
				String amount = myRes.getString(16);

				SipBranchSubDivisionLevelBookingBilling tempdetailsList = new SipBranchSubDivisionLevelBookingBilling(
						company, week, documentID, documentDate, smCode, smName, dmCode, division, partyName, contact,
						telePhone, projectName, product, zone, currency, amount);
				detailsList.add(tempdetailsList);
			}
			return detailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipBranchSubDivisionLevelBookingBilling> getSubDivisionBilookingDetailsForYTD(String theDivision,
			int theMonth, int theYear) throws SQLException {
		String mmyy = "";
		if (theMonth <= 12) {
			mmyy = (theMonth > 9 ? theMonth + "/" + theYear : "0" + theMonth + "/" + theYear);
		} else {
			mmyy = "" + theYear;
		}
		String sql = "";
		List<SipBranchSubDivisionLevelBookingBilling> detailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (theMonth <= 12) {
				sql = " SELECT * FROM SIP_DM_BKNG_TBL   WHERE DIVN_CODE = ?       "
						+ " AND  TO_CHAR(DOC_DATE, 'MM/YYYY')  = ?  ";

			} else {
				sql = " SELECT * FROM SIP_DM_BKNG_TBL   WHERE DIVN_CODE = ?       "
						+ " AND  TO_CHAR(DOC_DATE, 'YYYY')  = ?  ";
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDivision);
			myStmt.setString(2, mmyy);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String documentID = myRes.getString(3);
				String documentDate = myRes.getString(4);
				String smCode = myRes.getString(5);
				String smName = myRes.getString(6);
				String dmCode = myRes.getString(7);
				String division = myRes.getString(8);
				String partyName = myRes.getString(9);
				String contact = myRes.getString(10);
				String telePhone = myRes.getString(11);
				String projectName = myRes.getString(12);
				String product = myRes.getString(13);
				String zone = myRes.getString(14);
				String currency = myRes.getString(15);
				String amount = myRes.getString(16);

				SipBranchSubDivisionLevelBookingBilling tempdetailsList = new SipBranchSubDivisionLevelBookingBilling(
						company, week, documentID, documentDate, smCode, smName, dmCode, division, partyName, contact,
						telePhone, projectName, product, zone, currency, amount);
				detailsList.add(tempdetailsList);
			}
			return detailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public String getBranchManagerCodeByCompany(String companyCode) throws SQLException {
		String branchMangerCode = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select distinct  GM_CODE from  FJ_SALES_BRANCH_MANGRS where COMPANY = ?  AND  ROWNUM = 1  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, companyCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				branchMangerCode = myRes.getString(1);
			}
			return branchMangerCode;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
}
