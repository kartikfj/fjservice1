package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import beans.OrclDBConnectionPool;
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
import beans.SipMainDivisionBillingSummaryYtm;
import beans.SipMainDivisionBookingSummaryYtm;
import beans.SipOutRecvbleReprt;
import beans.SipSalesEngWeeklyBookningReport;
import beans.Stage1Details;
import beans.Stage3Details;
import beans.Stage4Details;

public class SipMainDivisionChartDbUtil {

	public String getDeafultDivisionNameforDm(String dm_Emp_Code) throws SQLException {
		// System.out.println("DM EMP CODE db: "+dm_Emp_Code);
		String div = "DCSERVE";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select distinct  FJTMAINDIVN from  FJT_TXN_FLEX where FJTDIVNCODE IN (SELECT SM_BL_SHORT_NAME FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_Emp_Code);
			myRes = myStmt.executeQuery();
			int rowCount = 0;
			while (myRes.next()) {
				rowCount++;
				System.out.println("rowCount== " + rowCount);
			}
			if (rowCount == 1) {
				div = getDivisionToDisplay(dm_Emp_Code, 1);
				return div;
			} else if (rowCount > 1) {
				div = getDivisionToDisplay(dm_Emp_Code, 2);
				return div;
			}

			return div;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihvSummary> getJobInHandVolume(String dm_Emp_code) throws SQLException {
		List<SipJihvSummary> volumeList = new ArrayList<>();// appraise company code list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM JIH_DM_TBL  WHERE DMEMPCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_Emp_code);// division manager employee code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String duration_tmp = myRes.getString(1);
				String amount_tmp = myRes.getString(3);
				SipJihvSummary tempVolumeList = new SipJihvSummary(duration_tmp, amount_tmp);
				volumeList.add(tempVolumeList);
			}
			return volumeList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public String getDivisionToDisplay(String Emp_code, int i) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String div = null;
		String sql = "";
		try {
			myCon = orcl.getOrclConn();
			if (i == 1) {
				sql = "	select distinct  FJTMAINDIVN from  FJT_TXN_FLEX where FJTDIVNCODE IN (SELECT SM_BL_SHORT_NAME FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2)";
			} else {
				sql = " SELECT DISPLAY_NAME FROM DISPLAY_DIVISION  WHERE EMP_ID = ? ";
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, Emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				div = myRes.getString(1);
			}
			return div;
		} finally {
			// close jdbc objects
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

	public List<SipJihvDetails> getJihvAgingDetails(String theDmCode, String agingCode) throws SQLException {
		List<SipJihvDetails> agingDetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			/*
			 * String sql = "SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE,  "
			 * + "CUST_NAME, PROJECT_NAME, CONSULTANT, INVOICING_YEAR, PROD_TYPE, " +
			 * "PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT,QTN_STATUS FROM FJT_SM_JIH_AGEING_TBL "
			 * + "WHERE  " + "  DMEMPCODE = ? " + "AND JIH_AGING = ?  " +
			 * "order by QTN_DT ";
			 */
			String sql = " SELECT A.COMP_CODE, A.WEEK, A.QTN_DT, A.QTN_CODE, A.QTN_NO, A.CUST_CODE,A.CUST_NAME, A.PROJECT_NAME,A.CONSULTANT, A.INVOICING_YEAR, A.PROD_TYPE,A.PROD_CLASSFCN, A.ZONE,A.PROFIT_PERC, A.QTN_AMOUNT, "
					+ "  B.LH_STATUS ,B.LH_REMARKS   FROM FJT_SM_JIH_AGEING_TBL A,FJT_SM_STG2_TBL B   WHERE   A.DMEMPCODE = ? AND A.JIH_AGING = ?   AND A.QTN_CODE = B.QTN_CODE    AND A.QTN_NO = B.QTN_NO  order by A.QTN_DT";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
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
				String qtnstatus = myRes.getString(16);
				String remarks = myRes.getString(17);
				SipJihvDetails tempagingDetailsList = new SipJihvDetails(cmp_code, week, quatation_dt, quatation_code,
						quatation_num, customer_code, customer_name, project_name, consultant, invoicing_yr, prdct_type,
						product_classf, zone, profit_perc, qtn_amount, qtnstatus, remarks, "");
				agingDetailsList.add(tempagingDetailsList);
			}
			return agingDetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipBooking> getYtmBooking(String theDmCode) throws SQLException {
		List<SipBooking> bookingList = new ArrayList<>();// booking list for an year.. in yera to date
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  *  FROM BKNG_DM_TBL WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String dmcode = myRes.getString(1);
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
				SipBooking tempBookingList = new SipBooking(dmcode, monthly_target, yr_total_target, ytm_target, jan_a,
						feb_a, mar_a, apr_a, may_a, jun_a, jul_a, aug_a, sep_a, oct_a, nov_a, dec_a, ytm_actual);
				bookingList.add(tempBookingList);
			}
			return bookingList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBilling> getYtmBilling(String theDmCode) throws SQLException {
		List<SipBilling> billingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT *  FROM BLNG_DM_TBL WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String dmcode = myRes.getString(1);
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
				SipBilling tempBillingList = new SipBilling(dmcode, monthly_target, yr_total_target, ytm_target, jan_a,
						feb_a, mar_a, apr_a, may_a, jun_a, jul_a, aug_a, sep_a, oct_a, nov_a, dec_a, ytm_actual);
				billingList.add(tempBillingList);
			}
			return billingList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage3Summary(String theDmCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s3 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE3 FOR A GIVEN DM CODE .
			String sql = "SELECT STG3 FROM STG3_DM_TBL WHERE DMEMPCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s3 = myRes.getLong(1);
			}
			return s3;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage4Summary(String theDmCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s4 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE4 FOR A GIVEN DM CODE .
			String sql = " SELECT STG4_VALUE FROM STG4_DM_TBL WHERE DMEMPCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s4 = myRes.getLong(1);
			}
			return s4;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage1Summary(String theDmCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s4 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE4 FOR A GIVEN DM CODE .
			String sql = " SELECT NVL(ROUND(SUM(QTN_AMOUNT),0),0) AMT FROM STG1_DM_TBL WHERE DM_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s4 = myRes.getLong(1);
			}
			return s4;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage3Details> stage3SummaryDetails(String thedM_code) throws SQLException {
		List<Stage3Details> s3DetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " Select   WEEK, ZONE, SALES_EGR_CODE, PROD_CATG, PROD_SUB_CATG, PROJECT_NAME, CONSULTANT, "
					+ " CUSTOMER, QUOT_DT, QUOT_CODE, QUOT_NO, AMOUNT, AVG_GP, LOI_RCD_DT, EXP_PO_DT, INVOICING_YEAR from STG3_DM_DETAIL "
					+ " WHERE DMEMPCODE = ? " + " ORDER BY LOI_RCD_DT desc";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, thedM_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String week = myRes.getString(1);
				String zone = myRes.getString(2);
				String sales_eg_code = myRes.getString(3);
				String prod_cat = myRes.getString(4);
				String prod_sub_catg = myRes.getString(5);
				String prjct_name = myRes.getString(6);
				String consultnt = myRes.getString(7);
				String custmr = myRes.getString(8);
				String qt_dt = myRes.getString(9);
				String qtn_code = myRes.getString(10);
				String qtn_num = myRes.getString(11);
				int amount = myRes.getInt(12);
				String avg_gp = myRes.getString(13);
				String loi_rcd_dt = myRes.getString(14);
				String exp_po_dt = myRes.getString(15);
				String invoicing_year = myRes.getString(16);
				Stage3Details temps3DetailsList = new Stage3Details(week, zone, sales_eg_code, prod_cat, prod_sub_catg,
						prjct_name, consultnt, custmr, qt_dt, qtn_code, qtn_num, amount, avg_gp, loi_rcd_dt, exp_po_dt,
						invoicing_year);
				s3DetailsList.add(temps3DetailsList);
			}
			return s3DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage1Details> stage1SummaryDetails(String dmCode) throws SQLException {
		List<Stage1Details> s1DetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE, CUST_NAME, PROJECT_NAME, CONSULTANT, JOB_STAGES, PROD_TYPE,    "
					+ " PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT, SALES_EGR_CODE, SALES_ENG_NAME  FROM STG1_DM_TBL  "
					+ " WHERE DM_CODE = ? order by QTN_DT ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmCode);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String comp_code = myRes.getString(1);
				String week = myRes.getString(2);
				String qtn_date = myRes.getString(3);
				String qtn_code = myRes.getString(4);
				String qtn_number = myRes.getString(5);
				String customer_code = myRes.getString(6);
				String customer_name = myRes.getString(7);
				String project = myRes.getString(8);
				String consultant = myRes.getString(9);
				String job_stage = myRes.getString(10);
				String product_type = myRes.getString(11);
				String product_classifctn = myRes.getString(12);
				String zone = myRes.getString(13);
				String profit_perc = myRes.getString(14);
				int qtn_amount = myRes.getInt(15);
				String seg_code = myRes.getString(16);
				String seg_name = myRes.getString(17);
				Stage1Details temps1DetailsList = new Stage1Details(comp_code, week, qtn_date, qtn_code, qtn_number,
						customer_code, customer_name, project, consultant, job_stage, product_type, product_classifctn,
						zone, profit_perc, qtn_amount, seg_code, seg_name);
				s1DetailsList.add(temps1DetailsList);
			}
			return s1DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage4Details> stage4SummaryDetails(String thedm_code) throws SQLException {
		List<Stage4Details> s4DetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SO_DT,SO_TXN_CODE, SO_NO, SOH_SM_CODE,SALES_ENG,  "
					+ "SH_LC_NO,LC_EXP_DT,ZONE,PROD_CATG,PROD_SUB_CATG,PROJECT, "
					+ "CONSULTANT,PMT_TERM,CUSTOMER,PROF_PERC,BALANCE_VALUE, " + "PROJECTED_INV_DT,SO_LOCN_CODE "
					+ "FROM FJT_STG4_DETAILS_TBL " + "WHERE DMEMPCODE = ? " + "ORDER BY SO_DT DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, thedm_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String so_date = myRes.getString(1);
				String so_trxn_code = myRes.getString(2);
				String so_number = myRes.getString(3);
				String sm_code = myRes.getString(4);
				String sm_name = myRes.getString(5);
				String sh_lc_nu = myRes.getString(6);
				String lc_exp_dt = myRes.getString(7);
				String zone = myRes.getString(8);
				String pdct_cat = myRes.getString(9);
				String pdct_sub_cat = myRes.getString(10);
				String prjct = myRes.getString(11);
				String consultant = myRes.getString(12);
				String pmt_term = myRes.getString(13);
				String customer = myRes.getString(14);
				String prof_perc = myRes.getString(15);
				int balance_value = myRes.getInt(16);
				String projected_inv_dt = myRes.getString(17);
				String so_lcn_code = myRes.getString(18);
				Stage4Details temps4DetailsList = new Stage4Details(so_date, so_trxn_code, so_number, sm_code, sm_name,
						sh_lc_nu, lc_exp_dt, zone, pdct_cat, pdct_sub_cat, prjct, consultant, pmt_term, customer,
						prof_perc, balance_value, projected_inv_dt, so_lcn_code);
				s4DetailsList.add(temps4DetailsList);
			}
			return s4DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> bookingDetailsforMonth(String sales_egr_id, String month, String Year)
			throws SQLException {
		List<SipBookingBillingDetails> bookingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year - YTM
			/*
			 * String sql = " SELECT COMP,   WEEK, DOC_ID,  DOC_DATE,   SM_CODE, SM_NAME,  "
			 * +
			 * " PARTY_NAME, CONTACT,  TELEPHONE, PROJ_NAME,  PRODUCT, ZONE,DIVN_CODE, CURR,  AMOUNT_AED  "
			 * + " FROM SIP_DM_BKNG_VIEW  WHERE     DM_CODE = ?  " +
			 * " AND DOC_DATE BETWEEN '01-' || ? || '-' || ?   AND LAST_DAY ('01-' || ? || '-' || ?)  "
			 * + " ORDER BY DOC_DATE DESC ";
			 */

			String sql = " SELECT COMP,   WEEK, DOC_ID,  DOC_DATE,   SM_CODE, SM_NAME,  "
					+ " PARTY_NAME, CONTACT,  TELEPHONE, PROJ_NAME,  PRODUCT, ZONE,DIVN_CODE, CURR,  AMOUNT_AED  "
					+ " FROM SIP_DM_BKNG_VIEW  WHERE     DM_CODE = ?  "
					+ "   AND TO_CHAR(LOI_RCVD_DT,'MON/RRRR') = ?||'/'||? " + " ORDER BY DOC_DATE DESC ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_egr_id);
			myStmt.setString(2, month.toUpperCase());
			// System.out.println("MTH "+month.toUpperCase());
			// System.out.println("YR "+Year);
			myStmt.setString(3, Year);
			/*
			 * myStmt.setString(4, month); myStmt.setString(5, Year);
			 */
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
				String division_code = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempbkYtmDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						division_code, currency, amount);
				bookingDetailsYtmList.add(tempbkYtmDetailsList);
			}
			return bookingDetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}

	}

	public List<SipBookingBillingDetails> bookingDetailsYtd(String thedm_Code, String theYear) throws SQLException {
		List<SipBookingBillingDetails> bookingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year for particular DM
			String sql = "SELECT COMP,WEEK,DOC_ID,DOC_DATE,SM_CODE,SM_NAME,  "
					+ "  PARTY_NAME, CONTACT, TELEPHONE, PROJ_NAME,  "
					+ " PRODUCT, ZONE,DIVN_CODE, CURR, AMOUNT_AED    FROM SIP_DM_BKNG_VIEW  "
					+ " WHERE  DM_CODE = ?  AND DOC_DATE BETWEEN '01-JAN-' || ?  "
					+ " AND TO_DATE (SYSDATE, 'DD/MM/RRRR')  " + " ORDER BY DOC_DATE DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, thedm_Code);
			myStmt.setString(2, theYear);
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
				String division_code = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempbkYtdDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						division_code, currency, amount);
				bookingDetailsYtdList.add(tempbkYtdDetailsList);
			}
			return bookingDetailsYtdList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> billingDetailsforMonth(String theDm_Code, String themonth, String theYear)
			throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year
			String sql = " SELECT COMP, WEEK, DOC_ID, DOC_DATE, SM_CODE, SM_NAME,"
					+ " PARTY_NAME, CONTACT, TELEPHONE, PROJ_NAME, PRODUCT, ZONE,DIVN_CODE, CURR, AMOUNT_AED"
					+ " FROM SIP_DM_BLNG_VIEW WHERE DM_CODE = ?  " + " AND DOC_DATE BETWEEN '01-' || ? || '-' || ? "
					+ " AND LAST_DAY ('01-' || ? || '-' ||  ? ) " + " ORDER BY DOC_DATE DESC  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDm_Code);
			myStmt.setString(2, themonth);
			myStmt.setString(3, theYear);
			myStmt.setString(4, themonth);
			myStmt.setString(5, theYear);
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
				String division_code = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempblYtmDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						division_code, currency, amount);
				billingDetailsYtmList.add(tempblYtmDetailsList);
			}
			return billingDetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipBookingBillingDetails> billingDetailsYtd(String theDm_Code, String theYear) throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get billingdetails for a given month and year
			String sql = "  SELECT COMP, WEEK, DOC_ID, DOC_DATE, SM_CODE, SM_NAME,PARTY_NAME, "
					+ "  CONTACT, TELEPHONE, PROJ_NAME, PRODUCT, ZONE, DIVN_CODE, CURR, AMOUNT_AED "
					+ "  FROM SIP_DM_BLNG_VIEW WHERE DM_CODE = ? " + "  AND DOC_DATE BETWEEN '01-JAN-' || ? "
					+ "  AND TO_DATE (SYSDATE, 'DD/MM/RRRR') ORDER BY DOC_DATE DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDm_Code);
			myStmt.setString(2, theYear);
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
				String division_code = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempblYtdDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						division_code, currency, amount);
				billingDetailsYtdList.add(tempblYtdDetailsList);
			}
			return billingDetailsYtdList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipOutRecvbleReprt> getOutstandingRecievableforMainDivn(String theDmCode) throws SQLException {
		List<SipOutRecvbleReprt> outstRcvbleRprt = new ArrayList<>();// Outstanding recvble aging repport list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "  SELECT DMEMPCODE,SUM (BAL_AMT_0_30) BAL_AMT_0_30, SUM (BAL_AMT_30_60) BAL_AMT_30_60,  "
					+ " SUM (BAL_AMT_60_90) BAL_AMT_60_90, SUM (BAL_AMT_90_120) BAL_AMT_90_120,SUM (BAL_AMT_120_180) BAL_AMT_120_180,  "
					+ " SUM (BAL_AMT_181) BAL_AMT_181,CR_DT  FROM FJT_SM_RCVBLE_DET,  FJT_DMSM_TBL  "
					+ " WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
					+ " AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
					+ " AND DMEMPCODE = ?   " + " GROUP BY DMEMPCODE,CR_DT ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);// dm code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String dm_code = myRes.getString(1);// its actually dm code
				String aging1 = myRes.getString(2);
				String aging2 = myRes.getString(3);
				String aging3 = myRes.getString(4);
				String aging4 = myRes.getString(5);
				String aging5 = myRes.getString(6);
				String aging6 = myRes.getString(7);
				String cr_date = myRes.getString(8);
				SipOutRecvbleReprt tempOutRecvbleReprt = new SipOutRecvbleReprt(dm_code, aging1, aging2, aging3, aging4,
						aging5, aging6, cr_date);
				outstRcvbleRprt.add(tempOutRecvbleReprt);
			}
			return outstRcvbleRprt;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDivisionOutstandingRecivablesDtls> getOutstandingRecievableAgingDetailsforMainDivn(String theDmCode,
			String aging) throws SQLException {
		// This db function for retrieving out recvbles aging wise details for Main
		// Division by DM CODE
		List<SipDivisionOutstandingRecivablesDtls> outstRcvbleDetails = new ArrayList<>();// Outstanding recvble aging
																							// report list
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			switch (aging) {
			case "30":
				sql = "   SELECT INVNO, INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME, SUM (BAL_AMT_0_30) BAL_AMT_0_30  "
						+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "  AND DMEMPCODE = ?    "
						+ "  GROUP BY INVNO,INV_DT, CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
						+ "  HAVING SUM (BAL_AMT_0_30) > 0 ";
				break;
			case "3060":
				sql = "  SELECT INVNO, INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME, SUM (BAL_AMT_30_60) BAL_AMT_30_60  "
						+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "  AND DMEMPCODE = ?     "
						+ "  GROUP BY INVNO, INV_DT,   CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_30_60) > 0  ";
				break;
			case "6090":
				sql = " SELECT INVNO, INV_DT,   CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,  SM_NAME,   SUM (BAL_AMT_60_90) BAL_AMT_60_90  "
						+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "  AND DMEMPCODE = ?     "
						+ "  GROUP BY INVNO,   INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME HAVING SUM (BAL_AMT_60_90) > 0  ";
				break;
			case "90120":
				sql = "  SELECT INVNO,INV_DT, CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,  SM_NAME, SUM (BAL_AMT_90_120) BAL_AMT_90_120  "
						+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "  AND DMEMPCODE = ?    "
						+ "  GROUP BY INVNO,  INV_DT, CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_90_120) > 0 ";
				break;
			case "120180":
				sql = "   SELECT INVNO,  INV_DT,   CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,   SM_NAME,   SUM (BAL_AMT_120_180) BAL_AMT_120_180  "
						+ "   FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "   WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "   AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "   AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "   FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "   AND DMEMPCODE = ?    "
						+ "   GROUP BY INVNO,  INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_120_180) > 0 ";
				break;
			case "181":
				sql = "   SELECT INVNO,   INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,   SM_NAME,  SUM (BAL_AMT_181) BAL_AMT_181  "
						+ "   FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "   WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "   AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "   AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "   FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "   AND DMEMPCODE = ?    "
						+ "   GROUP BY INVNO, INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_181) > 0  ";
				break;
			default:
				sql = "   SELECT INVNO, INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME, SUM (BAL_AMT_0_30) BAL_AMT_0_30  "
						+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  "
						+ "  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
						+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
						+ "  AND DMEMPCODE = ?    "
						+ "  GROUP BY INVNO,INV_DT, CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
						+ "  HAVING SUM (BAL_AMT_0_30) > 0 ";
				break;
			}

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);// dm emp code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String invoiceNo_temp = myRes.getString(1);
				String invoiceDate_temp = myRes.getString(2);
				String customerCode_temp = myRes.getString(3);
				String customerName_temp = myRes.getString(4);
				String prjctName_temp = myRes.getString(5);
				String consultant_temp = myRes.getString(6);
				String salesEg_name_temp = myRes.getString(7);
				String aging_value_temp = myRes.getString(8);
				SipDivisionOutstandingRecivablesDtls tempOutRecvbleDtls = new SipDivisionOutstandingRecivablesDtls(
						invoiceNo_temp, invoiceDate_temp, customerCode_temp, customerName_temp, prjctName_temp,
						consultant_temp, salesEg_name_temp, aging_value_temp);
				outstRcvbleDetails.add(tempOutRecvbleDtls);
			}
			return outstRcvbleDetails;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipSalesEngWeeklyBookningReport> getWeekWiseBookingForsalesEngrsDataforDMs(String theDmCode, int year,
			String month) throws SQLException {

		List<SipSalesEngWeeklyBookningReport> weeklyBkngReprt = new ArrayList<>();// Week wise booking report for sales
																					// engineer for particular dm
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT   DMCODE,  DIVISION,    SALES_CODE, SALE_ENGINEER_NAME, YRLY_BKNG_TGT,  YTD_ACTUAL_BKNG, YTD_TARGET_BKNG,  \"TGT_%_ACHIEVED\",   \"WKLYAVGTGT(52WKS)\"  FROM DM_SM_BKNG_SUM_TBL  WHERE DMCODE =  ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String dvn_code_tmp = myRes.getString(2);
				String sales_eng_code_tmp = myRes.getString(3);
				String sales_eng_name_tmp = myRes.getString(4);
				String yrly_bkng_tgt_tmp = myRes.getString(5);
				String ytd_actl_bkng_tmp = myRes.getString(6);
				String ytd_target_bkng_tmp = myRes.getString(7);
				String target_percntg_achievd_tmp = myRes.getString(8);
				String weekly_average_target = myRes.getString(9);
				SipSalesEngWeeklyBookningReport tempWeeklyBkngReprt = new SipSalesEngWeeklyBookningReport(dvn_code_tmp,
						sales_eng_code_tmp, sales_eng_name_tmp, yrly_bkng_tgt_tmp, ytd_actl_bkng_tmp,
						ytd_target_bkng_tmp, target_percntg_achievd_tmp, weekly_average_target);
				weeklyBkngReprt.add(tempWeeklyBkngReprt);
			}
			return weeklyBkngReprt;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDmListForManagementDashboard> getDMListfor_Mg() throws SQLException {
		List<SipDmListForManagementDashboard> dmList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// OR EMP_STATUS ='4' added to get saddad in the DM list.
			String sql = " SELECT DISTINCT (SM_FLEX_08), (SELECT EMP_NAME FROM  PM_EMP_KEY WHERE EMP_CODE = SM_FLEX_08 ) \"NAME\" FROM OM_SALESMAN  WHERE sm_frz_flag_num=2   "
					+ "  AND    sm_flex_09='Y' AND sm_flex_19='Y'  "
					+ "  AND SM_FLEX_08 IN ( SELECT EMP_CODE FROM  PM_EMP_KEY WHERE EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2' OR EMP_STATUS ='4')) ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String dm_code_tmp = myRes.getString(1);
				String dm_name_tmp = myRes.getString(2);
				SipDmListForManagementDashboard tempdmList = new SipDmListForManagementDashboard(dm_code_tmp,
						dm_name_tmp);
				dmList.add(tempdmList);
			}
			return dmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipMainDivisionBillingSummaryYtm> getYtmBillingSummaryForAllDivision(String theDmCode)
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
					+ "  NOV_A \"NOV\",  " + "  DEC_A \"DEC\",  " + "  YR_TOT_A \"TOTAL\" FROM DM_BLNG_TRGT_TBL  "
					+ "  WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);// dm employee code
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

	public List<SipMainDivisionBookingSummaryYtm> getYtmBookingSummaryForAllDivision(String theDmCode)
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
					+ "  NOV_A \"NOV\",  " + "  DEC_A \"DEC\",  " + "  YR_TOT_A \"TOTAL\" FROM DM_BKNG_TRGT_TBL  "
					+ "  WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);// dm employee code
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

	public List<SipJihvDetails> getStage2DetailsForDivision(String theDmCode) throws SQLException {
		List<SipJihvDetails> agingDetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE,  "
					+ " CUST_NAME, PROJECT_NAME, CONSULTANT, INVOICING_YEAR, PROD_TYPE, "
					+ " PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT FROM FJT_SM_JIH_AGEING_TBL"
					+ " WHERE DMEMPCODE = ? " + " order by QTN_DT ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
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

				SipJihvDetails tempagingDetailsList = new SipJihvDetails(cmp_code, week, quatation_dt, quatation_code,
						quatation_num, customer_code, customer_name, project_name, consultant, invoicing_yr, prdct_type,
						product_classf, zone, profit_perc, qtn_amount);
				agingDetailsList.add(tempagingDetailsList);
			}
			return agingDetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipForecastSalesOrderDelivery> getForecastSalesOrderDeliveryDateWiseSummary(String theDmCode)
			throws SQLException {
		List<SipForecastSalesOrderDelivery> summaryList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String year = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			/*
			 * Modified to improve the page performance -- Rajakumari String sql =
			 * "SELECT  " + "TO_CHAR(SOH_DEL_DT,'MM/RRRR') MMRRRR,  " +
			 * "SUM (ROUND (BV_GET_LC_AMT (SO_COMP_CODE, TO_NUMBER (balance_amount)), 2))     AS FORECAST_STG4_VALUE  "
			 * +
			 * "  FROM MANISH_SUPPLIERWISE_PENDING_SO, OT_CUST_QUOT_HEAD, MANISH_DATE,FJT_DMSM  "
			 * + " WHERE     SOH_REF_TXN_CODE = CQH_TXN_CODE(+)  " +
			 * "       AND SOH_REF_NO = CQH_NO(+)  " +
			 * "       AND TO_DATE (SO_DT, 'DD/MM/RRRR') = AS_ON_DATE  " +
			 * "       AND TO_DATE (SOH_DEL_DT, 'DD/MM/RRRR') >= SYSDATE  " +
			 * "       AND SO_COMP_CODE = CQH_COMP_CODE(+)  " +
			 * "       AND CUSTOMER NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST)  " +
			 * "       AND SOH_SM_CODE = SM_CODE  " +
			 * "       AND SO_TXN_CODE = FJTTXNCODE  " + "       AND DMEMPCODE = ? " +
			 * "       GROUP BY  TO_CHAR(SOH_DEL_DT,'MM/RRRR')  " + "       order by 1";
			 */
			String sql = " SELECT *FROM STG3_STG4_DM_FCST_TBL WHERE DMEMPCODE = ? AND MMRRRR BETWEEN '01/01/'|| ? and '31/'||12||'/'||?  ORDER BY 2";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myStmt.setString(2, year);
			myStmt.setString(3, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String dateYrMonth = myRes.getString(2);
				String fcStg3 = myRes.getString(3);
				String fcStg4 = myRes.getString(4);
				SipForecastSalesOrderDelivery tempsummaryList = new SipForecastSalesOrderDelivery(dateYrMonth, fcStg4,
						fcStg3);
				summaryList.add(tempsummaryList);
			}
			return summaryList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipForecastSalesOrderDelivery> getForecastSalesOrderDeliveryDateWiseDetails(String theDmCode)
			throws SQLException {
		List<SipForecastSalesOrderDelivery> detailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			/*
			 * Modified to improve Division Performance page,. Fetching the data directly
			 * from the table- Rajakumari String sql =
			 * " SELECT SO_TXN_CODE,  SO_NO, SO_DT,  SOH_SM_CODE,   SALES_ENG,   FJTDIVNCODE DIVN,    PROJECT,   CONSULTANT,  "
			 * +
			 * " PAYMENT_TERM_NAME PMT_TERM,   CUSTOMER,    SUM (  ROUND (BV_GET_LC_AMT (SO_COMP_CODE, TO_NUMBER (BALANCE_AMOUNT)), 2))   AS BALANCE_VALUE,  "
			 * + " TO_DATE (SOH_DEL_DT, 'DD/MM/RRRR') DEL_DT  " +
			 * " FROM MANISH_SUPPLIERWISE_PENDING_SO,  " +
			 * " OT_CUST_QUOT_HEAD,  MANISH_DATE,    FJT_DMSM    WHERE     SOH_REF_TXN_CODE = CQH_TXN_CODE(+)  "
			 * +
			 * " AND SOH_REF_NO = CQH_NO(+)   AND TO_DATE (SO_DT, 'DD/MM/RRRR') = AS_ON_DATE  "
			 * +
			 * " AND SO_COMP_CODE = CQH_COMP_CODE(+)    AND CUSTOMER NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST)  "
			 * + " AND SOH_SM_CODE = SM_CODE    AND SO_TXN_CODE = FJTTXNCODE  " +
			 * " AND DMEMPCODE = ?  " +
			 * " AND TO_DATE (SOH_DEL_DT, 'DD/MM/RRRR') >= SYSDATE   HAVING SUM (  ROUND (BV_GET_LC_AMT (SO_COMP_CODE, TO_NUMBER (BALANCE_AMOUNT)), 2)) >     0  "
			 * +
			 * " GROUP BY SO_DT,    SO_TXN_CODE,   SO_NO,  SOH_SM_CODE,    SALES_ENG,  FJTDIVNCODE,  "
			 * +
			 * " PROJECT,    CONSULTANT,    PAYMENT_TERM_NAME,  CUSTOMER,   SOH_DEL_DT    ORDER BY SOH_DEL_DT "
			 * ;
			 */
			String sql = "SELECT TXN_CODE,NO,DT,SM_CODE,SALES_ENG,DIVN,PROJECT,CONSULTANT,PMT_TERM, CUSTOMER,FORECAST_STG4_VALUE, TO_DATE (DEL_DT, 'DD/MM/RRRR') DEL_DT FROM STG4_DM_FCST_DTL_TBL  WHERE DMEMPCODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String soTxnCode = myRes.getString(1);
				String soNumber = myRes.getString(2);
				String soDate = myRes.getString(3);
				String smCode = myRes.getString(4);
				String smName = myRes.getString(5);
				String division = myRes.getString(6);
				String project = myRes.getString(7);
				String consultant = myRes.getString(8);
				String paymentTerm = myRes.getString(9);
				String customer = myRes.getString(10);
				String balanceValue = myRes.getString(11);
				String deliveryDate = myRes.getString(12);

				SipForecastSalesOrderDelivery tempdetailsList = new SipForecastSalesOrderDelivery(soTxnCode, soNumber,
						soDate, smCode, smName, division, project, consultant, paymentTerm, customer, balanceValue,
						deliveryDate);
				detailsList.add(tempdetailsList);
			}
			return detailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	// Stage 2 LOST SUMMARY
	public List<SipDStage2LostSummary> getStage2LostCountforDivisionDeafault(String dm_emp_code) throws SQLException {
		// this function for Stage 2 Aging - JIH Stages Qtns where no LOI received
		// used for finding default division
		List<SipDStage2LostSummary> stage2LostQtnList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "  SELECT "
					+ "  NVL(SUM(\"0_3_Mths_CNT\"),0),  NVL(SUM(\"0_3_Mths_LOST_CNT\"),0),  NVL(SUM(\"0_3_Mths_AMT\"),0),\r\n"
					+ "  NVL(SUM(\"0_3_Mths_LOST_AMT\"),0),  NVL(SUM(\"3_6_Mths_CNT\"),0),  NVL(SUM(\"3_6_Mths_LOST_CNT\"),0),"
					+ "  NVL(SUM(\"3_6_Mths_AMT\"),0),  NVL(SUM(\"3_6_Mths_LOST_AMT\"),0), "
					+ "  NVL(SUM(\">6Mths_Mths_CNT\"),0),  NVL(SUM(\">6Mths_LOST_CNT\"),0),"
					+ "  NVL(SUM(\">6Mths_Mths_AMT\"),0),  NVL(SUM(\">6Mths_LOST_AMT\"),0) "
					+ "  FROM AM_JIH_AGING_SUM_TBL WHERE  DM_CODE = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
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
				SipDStage2LostSummary tempStage2LostSummary = new SipDStage2LostSummary(aging1_count_tmp,
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

	public List<SipDivStage2LostDetails> getStage2LostAging_Details_Division(String dM_Code, String aging)
			throws SQLException {
		// function for fetching Job in hand volume Aging wise Details List for main
		// division
		// under an division manager
		List<SipDivStage2LostDetails> agingDetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT distinct COMP_CODE,WEEK,QTN_DT,QTN_CODE,QTN_NO,CUST_CODE,CUST_NAME,SALES_EGR_CODE,SALES_ENG_NAME,PROJECT_NAME,   "
					+ " CONSULTANT,INVOICING_YEAR,PROD_TYPE,PROD_CLASSFCN,ZONE,PROFIT_PERC,QTN_AMOUNT,QTN_STATUS from FJT_DM_JIH_AGING_DET_ALL_STAT,FJT_DMSM_TBL  "
					+ " WHERE DM_CODE = DMEMPCODE AND DM_CODE= ?  AND DMEMPCODE = ?  AND JIH_AGING=  ? "
					+ " AND QTN_CODE = FJTTXNCODE    ORDER BY QTN_STATUS,QTN_DT ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dM_Code);
			myStmt.setString(2, dM_Code);
			myStmt.setString(3, aging);
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
				SipDivStage2LostDetails tempagingdetailsList = new SipDivStage2LostDetails(week, cmp_code, qtn_date,
						qtn_code, qtn_numbr, cust_code, cust_name, sales_egr_code, sales_egr_name, project_name,
						consultant, invoice_yr, product_type, product_classfctn, zone, profit, qtn_amount, qtn_status);
				agingDetailsList.add(tempagingdetailsList);
			}
			return agingDetailsList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihDues> getJihLostDetails(String theDmCode) throws SQLException {
		List<SipJihDues> jihDueList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "    SELECT DESCRIPTION, COALESCE (SUM (COUNT), 0), COALESCE (SUM (VALUE), 0)  FROM (SELECT DESCRIPTION,  COALESCE (LOSTDEATAILS.COUNT, 0) COUNT, COALESCE (LOSTDEATAILS.VALUE, 0) VALUE "
					+ "  FROM FJPORTAL.QUOT_LOST_TYPE LOSTTYPE  LEFT JOIN  (  SELECT LHREMARKS_TYPE, COUNT (LHREMARKS_TYPE) COUNT, SUM (QTN_AMOUNT) VALUE FROM FJT_SM_STG2_TBL "
					+ "  WHERE  LH_STATUS = 'L' AND LHREMARKS_TYPE IS NOT NULL  AND SALES_EGR_CODE IN (SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_18 = ?) GROUP BY LHREMARKS_TYPE, SALES_EGR_CODE) LOSTDEATAILS "
					+ "  ON LOSTTYPE.CODE = LOSTDEATAILS.LHREMARKS_TYPE WHERE CODE NOT IN ('H', 'WO')) SUMMARY GROUP BY DESCRIPTION ORDER BY 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String lostType = myRes.getString(1);
				long lostCount = myRes.getLong(2);
				long lostValue = myRes.getLong(3);

				SipJihDues tmpJihDueList = new SipJihDues(lostType, lostCount, lostValue);
				jihDueList.add(tmpJihDueList);
			}
			return jihDueList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihDues> getSEJihLostQtnDetails(String lostType, String dmCode) throws SQLException {
		List<SipJihDues> volumeList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJT_SM_STG2_TBL WHERE SALES_EGR_CODE IN (SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_18 = ?) AND  LHREMARKS_TYPE = (SELECT DISTINCT CODE FROM QUOT_LOST_TYPE WHERE DESCRIPTION = ? )";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmCode);
			myStmt.setString(2, lostType);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String slesCode = myRes.getString(2);
				String sys_id = myRes.getString(14);
				String qtnDate = formatDate(myRes.getString(5));
				String qtnCode = myRes.getString(6);
				String qtnNo = myRes.getString(7);
				String custCode = myRes.getString(8);
				String custName = myRes.getString(9);
				String projectName = myRes.getString(10);
				String consultant = myRes.getString(11);
				int qtnAMount = myRes.getInt(12);
				String qtnStatus = myRes.getString(21);
				String remarks = myRes.getString(22);
				SipJihDues tempVolumeList = new SipJihDues(slesCode, sys_id, qtnDate, qtnCode, qtnNo, custCode,
						custName, projectName, consultant, qtnAMount, qtnStatus, remarks);
				volumeList.add(tempVolumeList);
			}
			return volumeList;
		} finally { // close jdbc objects
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

	public List<SipForecastSalesOrderDelivery> getForecastStg3SalesOrderDeliveryDateWiseDetails(String theDmCode)
			throws SQLException {
		List<SipForecastSalesOrderDelivery> detailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT TXN_CODE,NO,DT,SM_CODE,SALES_ENG,DIVN,PROJECT,CONSULTANT,PMT_TERM, CUSTOMER,FORECAST_STG3_VALUE, TO_DATE (INV_DATE, 'DD/MM/RRRR') INV_DT FROM STG3_DM_FCST_DTL_TBL  WHERE DMEMPCODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String soTxnCode = myRes.getString(1);
				String soNumber = myRes.getString(2);
				String soDate = myRes.getString(3);
				String smCode = myRes.getString(4);
				String smName = myRes.getString(5);
				String division = myRes.getString(6);
				String project = myRes.getString(7);
				String consultant = myRes.getString(8);
				String paymentTerm = myRes.getString(9);
				String customer = myRes.getString(10);
				String balanceValue = myRes.getString(11);
				String deliveryDate = myRes.getString(12);

				SipForecastSalesOrderDelivery tempdetailsList = new SipForecastSalesOrderDelivery(soTxnCode, soNumber,
						soDate, smCode, smName, division, project, consultant, paymentTerm, customer, balanceValue,
						deliveryDate);
				detailsList.add(tempdetailsList);
			}
			return detailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public String checkSalesMgrPerfTabisAllowed(String dm_Emp_Code) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String result = "No";
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DISTINCT MGR_EMPCODE FROM SMGR_MAP where MGR_EMPCODE IN (?)";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_Emp_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				result = "Yes";
			}
			return result;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipForecastSalesOrderDelivery> getTopTenCustomersDetails(String theDmCode) throws SQLException {
		List<SipForecastSalesOrderDelivery> summaryList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String year = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			String sql = " SELECT *FROM( " + "  SELECT SUM(ROUND(AMOUNT_AED)) AS AMOUNT,PARTY_NAME "
					+ "    FROM SIP_DM_BLNG_VIEW " + "   WHERE     DM_CODE = ? "
					+ "      AND DOC_DATE BETWEEN '01-JAN-' || ? " + "      AND TO_DATE (SYSDATE, 'DD/MM/RRRR') "
					+ "GROUP BY PARTY_NAME  ORDER BY AMOUNT DESC) WHERE  rownum <= 10";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myStmt.setString(2, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String amount = myRes.getString(1);
				String partyName = myRes.getString(2);
				// String fcStg4 = myRes.getString(4);
				SipForecastSalesOrderDelivery tempsummaryList = new SipForecastSalesOrderDelivery("", amount,
						partyName);
				summaryList.add(tempsummaryList);
			}
			return summaryList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipBookingBillingDetails> getDetailsofSelCust(String theDmCode, String theCustomerCode)
			throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String year = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			String sql = "  SELECT COMP, WEEK, DOC_ID, DOC_DATE,SM_CODE, SM_NAME, PARTY_NAME,CONTACT,TELEPHONE, PROJ_NAME, PRODUCT,ZONE, DIVN_CODE, CURR,AMOUNT_AED "
					+ "    FROM SIP_DM_BLNG_VIEW  WHERE     DM_CODE = ?  AND DOC_DATE BETWEEN '01-JAN-' || ?"
					+ "                          AND TO_DATE (SYSDATE, 'DD/MM/RRRR') AND PARTY_NAME =  ?"
					+ "ORDER BY DOC_DATE DESC";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myStmt.setString(2, year);
			myStmt.setString(3, theCustomerCode);
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
				String division_code = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempblYtmDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						division_code, currency, amount);
				billingDetailsYtmList.add(tempblYtmDetailsList);
			}
			return billingDetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public long stage5Summary(String theDmCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s4 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE5 FOR A GIVEN DM CODE .
			String sql = " SELECT NVL(YR_TOT_A,0) FROM BLNG_DM_TBL  WHERE DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s4 = myRes.getLong(1);
			}
			return s4;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> stage5SummaryDetails(String theDm_Code) throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year
			String sql = " SELECT COMP, WEEK, DOC_ID, DOC_DATE, SM_CODE, SM_NAME,"
					+ " PARTY_NAME, CONTACT, TELEPHONE, PROJ_NAME, PRODUCT, ZONE,DIVN_CODE, CURR, AMOUNT_AED"
					+ " FROM SIP_DM_BLNG_VIEW WHERE DM_CODE = ?  AND TO_CHAR(DOC_DATE,'YYYY') = TO_CHAR(SYSDATE,'YYYY') ORDER BY DOC_DATE DESC  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDm_Code);
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
				String division_code = myRes.getString(13);
				String currency = myRes.getString(14);
				String amount = myRes.getString(15);
				SipBookingBillingDetails tempblYtmDetailsList = new SipBookingBillingDetails(company, week, dcmnt_id,
						dcmnt_dt, sm_id, sm_name, party_name, contact, telephone, project_name, product, zone,
						division_code, currency, amount);
				billingDetailsYtmList.add(tempblYtmDetailsList);
			}
			return billingDetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}
}
