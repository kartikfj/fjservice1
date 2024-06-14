package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import beans.CustomerVisit;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.SalesManForecast;
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
import beans.SipOutRecvbleReprt;
import beans.SipWeeklyReport;
import beans.Stage1Details;
import beans.Stage3Details;
import beans.Stage4Details;
import beans.Stage5Details;

public class SipChartDbUtil {

	public SipChartDbUtil() {
	}

	public int getCountofSalesCode(String employee_Code) throws SQLException {
		// This function for identifying ,a sales egr have multiple sales code or not
		int sales_code_count = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT COUNT(SM_CODE) FROM OM_SALESMAN WHERE SM_FLEX_08 = ? AND SM_FRZ_FLAG_NUM = 2 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, employee_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				sales_code_count = myRes.getInt(1);
			}
			return sales_code_count;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();// close jdbc objects
		}
	}

	public List<SipJihvSummary> getJobInHandVolumeSummary(String sales_man_code) throws SQLException {

		List<SipJihvSummary> volumeList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT JIH_AGING, ROUND(SUM(QTN_AMOUNT),0)AMT FROM FJT_SM_JIH_AGING_DETAIL_TBL "
					+ "WHERE SALES_EGR_CODE = ?  GROUP BY JIH_AGING ORDER BY JIH_AGING";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);
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

	public List<SipJihvSummary> getSalesEngListfor_Dm(String dm_emp_code) throws SQLException {

		List<SipJihvSummary> salesEngList = new ArrayList<>();// appraise company code list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";

//			String sql = "SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME FROM OM_SALESMAN  "
//					+ "WHERE SM_FLEX_07='Y' AND SM_FRZ_FLAG_NUM=2 and SM_FLEX_18 = ? ";
			// Modified as Mr.Najib want to access the sales engineers performance dashboard
			// for KSA
			if (dm_emp_code.equals("E004853")) {
				sql = "SELECT * FROM (SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME FROM OM_SALESMAN WHERE SM_FLEX_07='Y' AND SM_FRZ_FLAG_NUM=2 AND SM_FLEX_14 LIKE '%KSA%')T ORDER BY SM_FLEX_08";
				myStmt = myCon.prepareStatement(sql);
			} else {
				sql = "SELECT * FROM ( SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME FROM OM_SALESMAN   "
						+ "WHERE   SM_FRZ_FLAG_NUM=2 and   SM_FLEX_08 =  ?  " + "UNION "
						+ "SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME FROM OM_SALESMAN   "
						+ "WHERE SM_FLEX_07='Y' AND SM_FRZ_FLAG_NUM=2 and  SM_FLEX_18 = ? ) T ORDER BY SM_FLEX_08 ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_emp_code);// division manager employee code
				myStmt.setString(2, dm_emp_code);// division manager employee code
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String salesman_emp_code = myRes.getString(3);
				SipJihvSummary tempSalesmanList = new SipJihvSummary(salesman_code, salesman_name, salesman_emp_code,
						0);
				salesEngList.add(tempSalesmanList);

			}

		} catch (SQLException e) {
			System.out.println("Exception dm_emp_code SipcharDbUtil.getSalesEngListfor_DM " + dm_emp_code);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return salesEngList;
	}

	public List<SipBooking> getYtmBooking(String sales_man_code, String tYear) throws SQLException {
		List<SipBooking> bookingList = new ArrayList<>();// booking list for an year.. in yera to date
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  SMT_CODE,  SMT_YEAR,ROUND(NVL(JAN_T,0)), FEB_T, MAR_T,APR_T,MAY_T,JUN_T, JUL_T, AUG_T, SEP_T, OCT_T,NOV_T,DEC_T,YR_TOT_T, "
					+ " ROUND(NVL(YR_TOT_T,0)/365*(TO_DATE(SYSDATE,'DD/MM/RRRR') -TO_DATE(TRUNC(SYSDATE,'RRRR'))),0)YTD_TARG, "
					+ " JAN_A,FEB_A, MAR_A, APR_A, MAY_A,JUN_A,JUL_A, AUG_A, SEP_A,OCT_A, NOV_A, DEC_A, " + " YR_TOT_A "
					+ " FROM FJT_SM_BKNG_TRG_ACT_SUMM_TBL WHERE SMT_CODE=? " + " AND SMT_YEAR= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);
			myStmt.setString(2, tYear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company_code = myRes.getString(1);
				String year = myRes.getString(2);
				String monthly_target = myRes.getString(3);
				String yr_total_target = myRes.getString(15);
				String ytm_target = myRes.getString(16);
				String jan_a = myRes.getString(17);
				String feb_a = myRes.getString(18);
				String mar_a = myRes.getString(19);
				String apr_a = myRes.getString(20);
				String may_a = myRes.getString(21);
				String jun_a = myRes.getString(22);
				String jul_a = myRes.getString(23);
				String aug_a = myRes.getString(24);
				String sep_a = myRes.getString(25);
				String oct_a = myRes.getString(26);
				String nov_a = myRes.getString(27);
				String dec_a = myRes.getString(28);
				String ytm_actual = myRes.getString(29);
				SipBooking tempBookingList = new SipBooking(company_code, year, monthly_target, yr_total_target,
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

	public List<SipJihvDetails> getJihvAgingDetails(String sales_man_code, String agingCode) throws SQLException {
		List<SipJihvDetails> agingDetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
//			String sql = "SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE, CUST_NAME, PROJECT_NAME, CONSULTANT, INVOICING_YEAR, PROD_TYPE, "
//					+ " PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT FROM FJT_SM_JIH_AGING_DET_VIEW "
//					+ "WHERE SALES_EGR_CODE=? AND JIH_AGING=? " + "order by QTN_DT";
			String sql = " SELECT A.COMP_CODE, A.WEEK, A.QTN_DT, A.QTN_CODE, A.QTN_NO, A.CUST_CODE, A.CUST_NAME, A.PROJECT_NAME,A.CONSULTANT, A.INVOICING_YEAR, A.PROD_TYPE, "
					+ " A.PROD_CLASSFCN, A.ZONE,A.PROFIT_PERC, A.QTN_AMOUNT ,	 NVL(B.LH_STATUS,'P') QTN_STATUS,"
					+ "  NVL(B.LH_REMARKS,'NA') REMARKS 	FROM FJT_SM_JIH_AGING_DETAIL_TBL A,FJT_SM_STG2_TBL B "
					+ " WHERE A.SALES_EGR_CODE = ? 	AND A.JIH_AGING = ? AND A.CQHSYSID = B.CQHSYSID order by A.QTN_DT";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);
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
				String qtaStatus = myRes.getString(16);
				String qtaStatusVal = qtaStatus.equals("P") ? "Pending" : "Hold";
				String reason = myRes.getString(17);

				SipJihvDetails tempagingDetailsList = new SipJihvDetails(cmp_code, week, quatation_dt, quatation_code,
						quatation_num, customer_code, customer_name, project_name, consultant, invoicing_yr, prdct_type,
						product_classf, zone, profit_perc, qtn_amount, qtaStatusVal, reason, "");
				agingDetailsList.add(tempagingDetailsList);
			}
			return agingDetailsList;
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

	public List<SipBilling> getYtmBilling(String salesEngCode, String tYear) throws SQLException {
		List<SipBilling> billingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  SMT_CODE,  SMT_YEAR,ROUND(NVL(JAN_T,0)), FEB_T, MAR_T,APR_T,MAY_T,JUN_T, JUL_T, AUG_T, SEP_T, OCT_T,NOV_T,DEC_T,YR_TOT_T, "
					+ " ROUND(NVL(YR_TOT_T,0)/365*(TO_DATE(SYSDATE,'DD/MM/RRRR') -TO_DATE(TRUNC(SYSDATE,'RRRR'))),0)YTD_TARG, "
					+ " JAN_A,FEB_A, MAR_A, APR_A, MAY_A,JUN_A,JUL_A, AUG_A, SEP_A,OCT_A, NOV_A, DEC_A, " + " YR_TOT_A "
					+ " FROM FJT_SM_BLNG_TRG_ACT_SUMM_TBL WHERE SMT_CODE=? " + " AND SMT_YEAR= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEngCode);
			myStmt.setString(2, tYear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company_code = myRes.getString(1);
				String year = myRes.getString(2);
				String monthly_target = myRes.getString(3);
				String yr_total_target = myRes.getString(15);
				String ytm_target = myRes.getString(16);
				String jan_a = myRes.getString(17);
				String feb_a = myRes.getString(18);
				String mar_a = myRes.getString(19);
				String apr_a = myRes.getString(20);
				String may_a = myRes.getString(21);
				String jun_a = myRes.getString(22);
				String jul_a = myRes.getString(23);
				String aug_a = myRes.getString(24);
				String sep_a = myRes.getString(25);
				String oct_a = myRes.getString(26);
				String nov_a = myRes.getString(27);
				String dec_a = myRes.getString(28);
				String ytm_actual = myRes.getString(29);
				SipBilling tempBillingList = new SipBilling(company_code, year, monthly_target, yr_total_target,
						ytm_target, jan_a, feb_a, mar_a, apr_a, may_a, jun_a, jul_a, aug_a, sep_a, oct_a, nov_a, dec_a,
						ytm_actual);
				billingList.add(tempBillingList);
			}
			return billingList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBillingStage4Summery> getYtdBillingStage4Summery(String salesEngCode, String theYear)
			throws SQLException {
		List<SipBillingStage4Summery> billingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  SMT_CODE,  SMT_YEAR,ROUND(NVL(JAN_T,0)), FEB_T, MAR_T,APR_T,MAY_T,JUN_T, JUL_T, AUG_T, SEP_T, OCT_T,NOV_T,DEC_T,YR_TOT_T,  "
					+ " ROUND(NVL(YR_TOT_T,0)/365*(TO_DATE(SYSDATE,'DD/MM/RRRR') -TO_DATE(TRUNC(SYSDATE,'RRRR'))),0)YTD_TARG,  "
					+ " JAN_A,FEB_A, MAR_A, APR_A, MAY_A,JUN_A,JUL_A, AUG_A, SEP_A,OCT_A, NOV_A, DEC_A,  "
					+ " YR_TOT_A  " + " FROM FJT_SM_BLNG_TRG_STG4_SUMM_TBL WHERE SMT_CODE = ?" + " AND SMT_YEAR = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEngCode);
			myStmt.setString(2, theYear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String sm_code = myRes.getString(1);
				String year = myRes.getString(2);
				String monthly_target = myRes.getString(3);
				String yr_total_target = myRes.getString(15);
				String ytm_target = myRes.getString(16);
				String jan_a = myRes.getString(17);
				String feb_a = myRes.getString(18);
				String mar_a = myRes.getString(19);
				String apr_a = myRes.getString(20);
				String may_a = myRes.getString(21);
				String jun_a = myRes.getString(22);
				String jul_a = myRes.getString(23);
				String aug_a = myRes.getString(24);
				String sep_a = myRes.getString(25);
				String oct_a = myRes.getString(26);
				String nov_a = myRes.getString(27);
				String dec_a = myRes.getString(28);
				String ytm_actual = myRes.getString(29);
				SipBillingStage4Summery tempBillingList = new SipBillingStage4Summery(sm_code, year, monthly_target,
						yr_total_target, ytm_target, jan_a, feb_a, mar_a, apr_a, may_a, jun_a, jul_a, aug_a, sep_a,
						oct_a, nov_a, dec_a, ytm_actual);
				billingList.add(tempBillingList);
			}
			return billingList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage3Summary(String sale_Egs_Code) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s3 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE3 FOR A GIVEN SALES EGR AS ON RUNNING DATE.
			String sql = " SELECT NVL(AMOUNT,0) FROM STG3_SUMMARY " + " WHERE CQH_SM_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sale_Egs_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s3 = myRes.getLong(1);
			}
			return s3;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage4Summary(String sale_Egs_Code) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s4 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE4 FOR A GIVEN SALES EGR AS ON RUNNING DATE (DATA BACKED
			// UP TO A TABLE AT NIGHT).
			String sql = " SELECT NVL(STG4_VALUE,0) FROM STG4_SM_SUMMARY   WHERE SOH_SM_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sale_Egs_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s4 = myRes.getLong(1);
			}
			return s4;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage3Details> stage3SummaryDetails(String sales_man_code) throws SQLException {
		List<Stage3Details> s3DetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --LISTING OF STAGE3 TRANSACTIONS FOR A GIVEN SALES EGR AS ON RUNNING DATE.

			String sql = " SELECT  WEEK, ZONE, SALES_EGR_CODE, PROD_CATG, PROD_SUB_CATG, PROJECT_NAME, CONSULTANT, "
					+ " CUSTOMER, QUOT_DT, QUOT_CODE, QUOT_NO, AMOUNT, AVG_GP, LOI_RCD_DT, EXP_PO_DT, INVOICING_YEAR "
					+ " FROM STG3_DETAIL " + " WHERE SALES_EGR_CODE = ? " + " ORDER BY LOI_RCD_DT desc ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);
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
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage4Details> stage4SummaryDetails(String sales_man_code) throws SQLException {

		List<Stage4Details> s4DetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// ----listing of Stage4 transactions for a given Sales Egr, as on Current
			// running date
			String sql = "SELECT SO_DT,SO_TXN_CODE,SO_NO,SOH_SM_CODE,SALES_ENG,SH_LC_NO,LC_EXP_DT,ZONE,PROD_CATG,  "
					+ "PROD_SUB_CATG,PROJECT,CONSULTANT,PMT_TERM,CUSTOMER,PROF_PERC,BALANCE_VALUE,  "
					+ "PROJECTED_INV_DT,SO_LOCN_CODE  " + "FROM FJT_STG4_DET_SM_TBL WHERE  " + "SOH_SM_CODE= ?  "
					+ "ORDER BY SO_DT DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);

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

	public List<SipJihvSummary> getSalesEngListfor_Mg(String sales_eng_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// Comments to show sales engineers who is having targets.
			/*
			 * String sql =
			 * "SELECT SM_CODE,SM_NAME,SM_FLEX_08,SM_BL_SHORT_NAME FROM OM_SALESMAN " +
			 * "WHERE sm_frz_flag_num=2  " +
			 * "AND (sm_flex_07='Y' OR sm_flex_09='Y') AND SM_FLEX_08 IN ( SELECT EMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')) Order by SM_NAME "
			 * ;
			 */
			String sql = "SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME  FROM OM_SALESMAN  WHERE     SM_FRZ_FLAG_NUM = 2 AND (SM_FLEX_07 = 'Y' OR SM_FLEX_09 = 'Y')  AND"
					+ " SM_FLEX_08 IN  (SELECT EMP_CODE  FROM FJPORTAL.PM_EMP_KEY WHERE     EMP_FRZ_FLAG = 'N'  AND (EMP_STATUS = '1' OR EMP_STATUS = '2')) AND "
					+ " SM_CODE IN (SELECT SMT_CODE FROM BV_SM_TARGET WHERE SMT_YEAR = TO_NUMBER(TO_CHAR(SYSDATE,'RRRR')) 	AND SMT_TAMT > 500 ) ORDER BY SM_NAME";

			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String salesman_emp_code = myRes.getString(3);
				String salesman_division = myRes.getString(4);
				SipJihvSummary tempSalesmanList = new SipJihvSummary(salesman_code, salesman_name, salesman_emp_code,
						salesman_division, 0);
				salesEngList.add(tempSalesmanList);
			}

		} catch (SQLException e) {
			System.out
					.println("Exception Sales eng EMp COde SipcharDbUtil.getSalesEngListfor_Mg " + sales_eng_Emp_code);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return salesEngList;

	}

	public List<SipBookingBillingDetails> bookingDetailsYtm(String sales_egr_id, String month, String Year)
			throws SQLException {

		List<SipBookingBillingDetails> bookingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year - YTM
			String sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, LOI_RCVD_DT, CURR,AMOUNT_AED from SIP_SM_BKNG_VIEW where sm_code=? "
					+ "and LOI_RCVD_DT between '01-'||?||'-'||? and last_day('01-'||?||'-'||?)  order by LOI_RCVD_DT desc";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_egr_id);
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

	public List<SipBookingBillingDetails> bookingDetailsYtd(String sales_egr_id, String selYear, String currYear)
			throws SQLException {
		List<SipBookingBillingDetails> bookingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String sql = "";
		try {
			myCon = orcl.getOrclConn();
			int seleYear = Integer.parseInt(selYear);
			int currentYear = Integer.parseInt(currYear);
			// --query to get booking details for a given month and year
			if (seleYear < currentYear) {
				sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, LOI_RCVD_DT, CURR,AMOUNT_AED   "
						+ "from SIP_SM_BKNG_VIEW where sm_code=? "
						+ "and LOI_RCVD_DT between '01-JAN-'||? and '31-DEC-'||? " + "order by LOI_RCVD_DT desc  ";
			} else {
				sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, LOI_RCVD_DT, CURR,AMOUNT_AED   "
						+ "from SIP_SM_BKNG_VIEW where sm_code=? "
						+ "and LOI_RCVD_DT between '01-JAN-'||? and to_date(sysdate,'DD/MM/RRRR') "
						+ "order by LOI_RCVD_DT desc  ";
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_egr_id);
			myStmt.setString(2, selYear);
			if (seleYear < currentYear) {
				myStmt.setString(3, selYear);
			}
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

	public List<SipBookingBillingDetails> billingDetailsYtm(String sales_egr_id, String month, String Year)
			throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get booking details for a given month and year
			String sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED "
					+ "from SIP_SM_BLNG_VIEW where sm_code=?  "
					+ "and doc_date between '01-'||?||'-'||?  and last_day('01-'||?||'-'||?)  order by doc_date desc ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_egr_id);
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

	public List<SipBookingBillingDetails> billingDetailsYtd(String sales_egr_id, String selYear, String currentYear)
			throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		int seleYear = 0;
		int currYear = 0;
		if (selYear != null) {
			seleYear = Integer.parseInt(selYear);
		}
		if (currentYear != null) {
			currYear = Integer.parseInt(currentYear);
		}
		String sql = "";
		try {
			myCon = orcl.getOrclConn();
			// --query to get billingdetails for a given month and year
			if (seleYear < currYear) {
				sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED   "
						+ "from SIP_SM_BLNG_VIEW where sm_code=? "
						+ "and doc_date between '01-JAN-'||? and '31-DEC-'||? " + "order by doc_date desc  ";

			} else {
				sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED   "
						+ "from SIP_SM_BLNG_VIEW where sm_code=? "
						+ "and doc_date between '01-JAN-'||? and to_date(sysdate,'DD/MM/RRRR') "
						+ "order by doc_date desc  ";
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_egr_id);
			myStmt.setString(2, selYear);
			if (seleYear < currYear) {
				myStmt.setString(3, selYear);
			}

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

	public List<SipJihvSummary> getSalesEngListfor_NormalSalesEgr(String sales_eng_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();// sales egr list for normal sales egr
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select SM_CODE, SM_NAME,SM_FLEX_08 from om_salesman where ( SM_FLEX_08= ?  OR SM_FLEX_17 = ? ) AND SM_FRZ_FLAG_NUM=2";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_eng_Emp_code);
			myStmt.setString(2, sales_eng_Emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String salesman_emp_code = myRes.getString(3);
				SipJihvSummary tempSalesmanList = new SipJihvSummary(salesman_code, salesman_name, salesman_emp_code,
						0);
				salesEngList.add(tempSalesmanList);
			}
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipOutRecvbleReprt> getOutstandingRecievableforSaleEgr(String sales_eng_code) throws SQLException {
		List<SipOutRecvbleReprt> outstRcvbleRprt = new ArrayList<>();// Outstanding recvble aging repport list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT FJT_SM_RCVBLE_DET.sm_code,  OM_SALESMAN.SM_NAME,  SUM(BAL_AMT_0_30) BAL_AMT_0_30, "
					+ " SUM (BAL_AMT_30_60) BAL_AMT_30_60,  SUM (BAL_AMT_60_90) BAL_AMT_60_90, "
					+ " SUM (BAL_AMT_90_120) BAL_AMT_90_120,   SUM (BAL_AMT_120_180) BAL_AMT_120_180, "
					+ " SUM (BAL_AMT_181) BAL_AMT_181,CR_DT   FROM FJT_SM_RCVBLE_DET, OM_SALESMAN "
					+ " WHERE FJT_SM_RCVBLE_DET.SM_CODE = OM_SALESMAN.SM_CODE " + " AND FJT_SM_RCVBLE_DET.SM_CODE = ? "
					+ " GROUP BY FJT_SM_RCVBLE_DET.SM_CODE,OM_SALESMAN.SM_NAME,CR_DT  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_eng_code);// sales egr sales code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String aging1 = myRes.getString(3);
				String aging2 = myRes.getString(4);
				String aging3 = myRes.getString(5);
				String aging4 = myRes.getString(6);
				String aging5 = myRes.getString(7);
				String aging6 = myRes.getString(8);
				String cr_date = myRes.getString(9);
				SipOutRecvbleReprt tempOutRecvbleReprt = new SipOutRecvbleReprt(salesman_code, salesman_name, aging1,
						aging2, aging3, aging4, aging5, aging6, cr_date);
				outstRcvbleRprt.add(tempOutRecvbleReprt);
			}
			return outstRcvbleRprt;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDivisionOutstandingRecivablesDtls> getOutstandingRecievableAgingDetailsforSaleEgr(String smCode,
			String aging) throws SQLException {
		// This db function for retrieving out recvbles aging wise details
		List<SipDivisionOutstandingRecivablesDtls> outstRcvbleDetails = new ArrayList<>();// Outstanding recvble aging
																							// repport list
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			switch (aging) {
			case "30":
				sql = " SELECT INVNO,INV_DT,CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT, "
						+ " SUM (BAL_AMT_0_30) BAL_AMT_0_30 FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO,  INV_DT, CUST_CODE, "
						+ " CUST_NAME,PROJ_NAME,CONSULTANT HAVING SUM (BAL_AMT_0_30) > 0 ";
				break;
			case "3060":
				sql = " SELECT INVNO, INV_DT, CUST_CODE,   CUST_NAME,PROJ_NAME,CONSULTANT,  "
						+ " SUM (BAL_AMT_30_60) BAL_AMT_30_60 FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO, "
						+ " INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT  HAVING SUM (BAL_AMT_30_60) > 0 ";
				break;
			case "6090":
				sql = " SELECT INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT, "
						+ " SUM (BAL_AMT_60_90) BAL_AMT_60_90  FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO, "
						+ " INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT HAVING SUM (BAL_AMT_60_90) > 0 ";
				break;
			case "90120":
				sql = "  SELECT INVNO,  INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT, "
						+ " SUM (BAL_AMT_90_120) BAL_AMT_90_120  FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO, "
						+ " INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT " + " HAVING SUM (BAL_AMT_90_120) > 0 ";
				break;
			case "120180":
				sql = " SELECT INVNO,INV_DT,CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT, "
						+ " SUM (BAL_AMT_120_180) BAL_AMT_120_180  FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO, INV_DT, CUST_CODE, "
						+ " CUST_NAME,PROJ_NAME,CONSULTANT  HAVING SUM (BAL_AMT_120_180) > 0 ";
				break;
			case "181":
				sql = "  SELECT INVNO,  INV_DT, CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT, "
						+ " SUM (BAL_AMT_181) BAL_AMT_181 FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO, INV_DT, "
						+ " CUST_CODE,   CUST_NAME,PROJ_NAME,CONSULTANT  HAVING SUM (BAL_AMT_181) > 0 ";
				break;
			default:
				sql = " SELECT INVNO,INV_DT,CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT, "
						+ " SUM (BAL_AMT_0_30) BAL_AMT_0_30 FROM FJT_SM_RCVBLE_DET "
						+ " WHERE SM_CODE = ? GROUP BY INVNO,  INV_DT, CUST_CODE, "
						+ " CUST_NAME,PROJ_NAME,CONSULTANT HAVING SUM (BAL_AMT_0_30) > 0 ";
				break;
			}

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);// sales egr sales code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String invoiceNo_temp = myRes.getString(1);
				String invoiceDate_temp = myRes.getString(2);
				String customerCode_temp = myRes.getString(3);
				String customerName_temp = myRes.getString(4);
				String prjctName_temp = myRes.getString(5);
				String consultant_temp = myRes.getString(6);
				String aging_value_temp = myRes.getString(7);
				SipDivisionOutstandingRecivablesDtls tempOutRecvbleDtls = new SipDivisionOutstandingRecivablesDtls(
						invoiceNo_temp, invoiceDate_temp, customerCode_temp, customerName_temp, prjctName_temp,
						consultant_temp, aging_value_temp);
				outstRcvbleDetails.add(tempOutRecvbleDtls);
			}
			return outstRcvbleDetails;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	// Stage 2 LOST SUMMARY

	public List<SipDStage2LostSummary> getStage2LostCountforSalesEgr(String sm_code) throws SQLException {
		// this function for Stage 2 Aging - JIH Stages Qtns where no LOI received
		List<SipDStage2LostSummary> stage2LostQtnList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT "
					+ " SUM(THREEMTHSCNT), SUM(THREEMTHSLOSTCNT), SUM(THREEMTHSAMT), SUM(THREEMTHSLOSTAMT), "
					+ "   SUM(THREESIXMTHSCNT), SUM(THREESIXMTHSLOSTCNT), SUM(THREESIXMTHSAMT),  SUM(THREESIXMTHSLOSTAMT),  "
					+ "   SUM(SIXMTHSCNT), SUM(SIXMTHSLOSTCNT), SUM(SIXMTHSAMT), SUM(SIXMTHSLOSTAMT) "
					+ "  FROM AM_SM_JIH_AGE_SUM_2YR_TBL   WHERE SM_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sm_code);
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
				SipDStage2LostSummary tempStage2LostSummary = new SipDStage2LostSummary(sm_code, aging1_count_tmp,
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

	public List<SipDivStage2LostDetails> getStage2LostAging_Details_Division(String sm_Code, String aging)
			throws SQLException {
		List<SipDivStage2LostDetails> agingDetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			/*
			 * String sql = "SELECT DISTINCT COMP_CODE, WEEK,   QTN_DT,  QTN_CODE,  " +
			 * "QTN_NO,  CUST_CODE, CUST_NAME, SALES_EGR_CODE,  " +
			 * "SALES_ENG_NAME, PROJECT_NAME,  CONSULTANT,  " +
			 * "INVOICING_YEAR,  PROD_TYPE,  PROD_CLASSFCN,  " +
			 * "ZONE, PROFIT_PERC, QTN_AMOUNT,  QTN_STATUS  " +
			 * "FROM FJT_DM_JIH_AGING_DET_LOST_STAT  " + "WHERE SALES_EGR_CODE = ?  " +
			 * "AND JIH_AGING = ? ";
			 */ // old backup
			String sql = "  SELECT DISTINCT T1.COMP_CODE, T1.WEEK,   T1.QTN_DT,  T1.QTN_CODE, "
					+ "  T1.QTN_NO,  T1.CUST_CODE, T1.CUST_NAME, T1.SALES_EGR_CODE,  "
					+ "  T1.SALES_ENG_NAME, T1.PROJECT_NAME,  T1.CONSULTANT,  T1.INVOICING_YEAR,  T1.PROD_TYPE,  T1.PROD_CLASSFCN,   "
					+ " T1.ZONE, T1.PROFIT_PERC, T1.QTN_AMOUNT,  T2.LH_STATUS, "
					+ " coalesce(( SELECT DESCRIPTION FROM  QUOT_LOST_TYPE  WHERE CODE = T2.LHREMARKS_TYPE ),'-') LOST_TYPE , coalesce(T2.LH_REMARKS, '-') LOST_DESC FROM FJT_DM_JIH_AGE_DET_LOST_TBL T1"
					+ " LEFT JOIN FJPORTAL.FJT_SM_STG2_TBL  T2" + " ON  T1.QTN_SYS_ID = T2.CQHSYSID  "
					+ " GROUP BY T1.COMP_CODE, T1.WEEK,   T1.QTN_DT,  T1.QTN_CODE,  "
					+ "  T1.QTN_NO,  T1.CUST_CODE, T1.CUST_NAME, T1.SALES_EGR_CODE,  "
					+ "  T1.SALES_ENG_NAME, T1.PROJECT_NAME,  T1.CONSULTANT,  T1.INVOICING_YEAR,  T1.PROD_TYPE,  T1.PROD_CLASSFCN,   "
					+ "  T1.ZONE, T1.PROFIT_PERC, T1.QTN_AMOUNT, T1.JIH_AGING, T2.LH_STATUS, T2.LHREMARKS_TYPE, T2.LH_REMARKS"
					+ " HAVING T1.SALES_EGR_CODE = ?" + "  AND T1.JIH_AGING = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sm_Code);
			myStmt.setString(2, aging);
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

	public List<SipChartDivDmJobToStage3Dtls> getStage2ToStage3Details() throws SQLException {
		List<SipChartDivDmJobToStage3Dtls> stage3JobDtls = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT WEEK,SM_CODE,SALES_ENG,PROJECT_CODE,QT_CODE,QT_NO,QT_DT,LOI_DT,PRODUCT, "
					+ "REGION,CUSTOMER,CONTACT,TELPHONE,CONSULTANT FROM NEWSTG3_TBL  WHERE QT_DT  IS NOT NULL AND SALES_ENG IS NOT NULL ORDER BY WEEK DESC ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String week_temp = myRes.getString(1);
				String s_egr_code_temp = myRes.getString(2);
				String s_egr_name_temp = myRes.getString(3);
				String project_code_temp = myRes.getString(4);
				String qtn_code_temp = myRes.getString(5);
				String qtn_no_temp = myRes.getString(6);
				String qtn_date_temp = myRes.getString(7);
				String loi_date_temp = myRes.getString(8);
				String product_temp = myRes.getString(9);
				String region_temp = myRes.getString(10);
				String customer_temp = myRes.getString(11);
				String contact_person_temp = myRes.getString(12);
				String contact_no_temp = myRes.getString(13);
				String consultant_temp = myRes.getString(14);
				SipChartDivDmJobToStage3Dtls tempstage3JobDtls = new SipChartDivDmJobToStage3Dtls(week_temp,
						s_egr_code_temp, s_egr_name_temp, project_code_temp, qtn_code_temp, qtn_no_temp, qtn_date_temp,
						loi_date_temp, product_temp, region_temp, customer_temp, contact_person_temp, contact_no_temp,
						consultant_temp);
				stage3JobDtls.add(tempstage3JobDtls);
			}
			return stage3JobDtls;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipBookingBillingDetails> billingS4DetailsYtd(String smCode, String year) throws SQLException {
		List<SipBookingBillingDetails> billingDetailsYtdList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get billing target vs s4 amount details for a given month and year
			String sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED     "
					+ "from SM_STG4_VIEW where sm_code = ?  "
					+ "and doc_date between '01-JAN-' || ? and to_date(sysdate,'DD/MM/RRRR')   "
					+ "order by doc_date desc ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);
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

	public List<SipBookingBillingDetails> billingS4DetailsYtm(String smCode, String month, String year)
			throws SQLException {
		List<SipBookingBillingDetails> billings4DetailsYtmList = new ArrayList<>();// booking details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get billing target vs s4 amount details for a given month and year
			String sql = "select COMP,WEEK, DOC_ID,DOC_DATE,SM_CODE,SM_NAME,PARTY_NAME,CONTACT,TELEPHONE,PROJ_NAME, PRODUCT, ZONE, CURR,AMOUNT_AED   "
					+ "from SM_STG4_VIEW where sm_code = ?   "
					+ "and doc_date between '01-'|| ? ||'-'|| ?  and last_day('01-'|| ? ||'-'|| ? )  order by doc_date desc ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);
			myStmt.setString(2, month);
			myStmt.setString(3, year);
			myStmt.setString(4, month);
			myStmt.setString(5, year);
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
				billings4DetailsYtmList.add(tempblYtmDetailsList);
			}
			return billings4DetailsYtmList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	// Billing for last 3 Years
	public List<SipBilling> getBillingforLast3Years(String salesEngCode, String theYear) throws SQLException {
		List<SipBilling> billingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SMT_CODE,  SMT_YEAR,YR_TOT_T,  "
					+ " ROUND ( NVL (YR_TOT_T, 0) / 365  * (  TO_DATE (SYSDATE, 'DD/MM/RRRR') - TO_DATE (TRUNC (SYSDATE, 'RRRR'))), 0)  YTD_TARG, "
					+ " YR_TOT_A  FROM FJT_SM_BLNG_TRG_ACT_SUMM_TBL " + " WHERE SMT_CODE = ? AND SMT_YEAR =  ?  "
					+ " UNION " + " SELECT SMT_CODE, SMT_YEAR,  YR_TOT_T, "
					+ " ROUND ( NVL (YR_TOT_T, 0) / 365  * (  TO_DATE (SYSDATE, 'DD/MM/RRRR') - TO_DATE (TRUNC (SYSDATE, 'RRRR'))),  0) YTD_TARG, "
					+ " YR_TOT_A FROM FJT_SM_BLNG_TRG_ACT_SUMM_TBL " + " WHERE SMT_CODE = ? AND SMT_YEAR =  ? - 1 "
					+ " UNION " + " SELECT SMT_CODE,   SMT_YEAR, YR_TOT_T, "
					+ " ROUND ( NVL (YR_TOT_T, 0)  / 365  * (  TO_DATE (SYSDATE, 'DD/MM/RRRR')  - TO_DATE (TRUNC (SYSDATE, 'RRRR'))), 0) YTD_TARG, "
					+ " YR_TOT_A FROM FJT_SM_BLNG_TRG_ACT_SUMM_TBL " + " WHERE SMT_CODE = ? AND SMT_YEAR =  ? - 2 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEngCode);
			myStmt.setString(2, theYear);
			myStmt.setString(3, salesEngCode);
			myStmt.setString(4, theYear);
			myStmt.setString(5, salesEngCode);
			myStmt.setString(6, theYear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String sales_egr_code = myRes.getString(1);
				String year = myRes.getString(2);
				String yr_total_target = myRes.getString(3);
				String ytm_target = myRes.getString(4);
				String ytm_actual = myRes.getString(5);
				SipBilling tempBillingList = new SipBilling(sales_egr_code, year, yr_total_target, ytm_target,
						ytm_actual);
				billingList.add(tempBillingList);
			}
			return billingList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	// USER BASHBOARD USAGEHSTORY

	public int insertDashboardUserHistory(String emp_code, String emp_name, String seg_code, String company,
			String division, String role) throws SQLException {
		int logType = 1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			// INSERT INTO `newfjtco`.`dashboard_user_history`(`workdate`,
			// `empCode`,`empName`, `segCode`, `firstUse`,`year`, `company`,`division`)
			// VALUES(current_date(),'E003006','NUFAIL
			// ACHATH','IT01',current_timestamp(),2019,'001','IT')
			// ON DUPLICATE KEY UPDATE `updatedUse` = current_timestamp() ;

			// String sql = "INSERT INTO
			// dashboard_user_history(`workdate`,`empCode`,`empName`, `segCode`,
			// `firstUse`,`year`,`month`, `company`,`division`,`user_role`) "
			// + " VALUES(current_date(), ?, ?, ?, now(), YEAR(NOW()),month(NOW()), ?, ?, ?)
			// + " ON DUPLICATE KEY UPDATE `updatedUse` = now()";
			String sql = "INSERT INTO user_login_history(`workdate`,`empCode`,`empName`,`loggedin`, `year`,`month`,`company`,`division`,`user_role`) "
					+ " VALUES(current_date(), ?, ?, now(), YEAR(NOW()),month(NOW()), ?, ?, ?) ";

			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, emp_code);
			myStmt.setString(2, emp_name);
			// myStmt.setString(3, seg_code);
			myStmt.setString(3, company);
			myStmt.setString(4, division);
			myStmt.setString(5, role);

			logType = myStmt.executeUpdate();

		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}
		return logType;
	}

	public List<SipJihvDetails> getStage2DetailsForSalesEngineer(String sales_man_code) throws SQLException {
		List<SipJihvDetails> agingDetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE, CUST_NAME, PROJECT_NAME, CONSULTANT, INVOICING_YEAR, PROD_TYPE, "
					+ " PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT FROM FJT_SM_JIH_AGING_DETAIL_TBL "
					+ "WHERE SALES_EGR_CODE=?   order by QTN_DT";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);
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

	public long stage1Summary(String salesEngCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s3 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE1 TENDER STAGE FOR A GIVEN SALES EGR AS ON RUNNING
			// DATE.
			String sql = " SELECT NVL(ROUND(SUM(QTN_AMOUNT),0),0) AMT FROM FJT_SM_TENDER_DET_TBL   WHERE SALES_EGR_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEngCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s3 = myRes.getLong(1);
			}
			return s3;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<CustomerVisit> getSalesEngineerProjectListForCustVisit(String salesEngCode) throws SQLException {
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DOC_ID, PARTY_NAME, CONTACT_PERSON, PROJ_NAME, PRODUCT, CONSULTANT FROM CUS_VIST_ACTION_VIEW  WHERE SM_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEngCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String partyName = myRes.getString(2);
				String contacts = myRes.getString(3);
				String projectName = myRes.getString(4);
				String product = myRes.getString(5);
				String consultant = myRes.getString(6);
				CustomerVisit tmpProjectList = new CustomerVisit(documentId, partyName, contacts, projectName, product,
						consultant);
				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	// SALES PERFORMANCE SUMMARY
	public Map<String, SalesmanPerformance> getSmPerformance(String smCode, String sYear, String smEmpCode)
			throws SQLException {
		List<SalesmanPerformance> performanceList = new ArrayList<>();
		Connection connection = null;
		Map<String, SalesmanPerformance> smMap = new HashMap<String, SalesmanPerformance>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		OrclDBConnectionPool orcle = new OrclDBConnectionPool();
		try {
			connection = orcle.getOrclConn();
			// String sql = "SELECT * FROM SM_YTD_PERF_AKM WHERE SMCODE = ? ";
			// String sql = "SELECT * FROM SM_YTD_PERF_AKM_TBL WHERE SMCODE = ? ";
			String sql = "SELECT * FROM SM_YTD_PERF_AKM_TBL WHERE SMCODE = ? " + " UNION "
					+ " SELECT NULL,'9','Visit Target Act',SUM(TOTALSUM) FROM (SELECT MTH, SUM(CNT) AS TOTALSUM from (SELECT EXTRACT(YEAR FROM ACT_DT) YR, EXTRACT(MONTH FROM ACT_DT) MTH, ACT_SM_CODE, "
					+ " COUNT(ACT_SM_CODE) CNT   FROM FJPORTAL.CUS_VIST_ACTION "
					+ " GROUP BY EXTRACT(YEAR FROM ACT_DT), EXTRACT(MONTH FROM ACT_DT) , ACT_SM_CODE "
					+ " HAVING  ACT_SM_CODE IN (SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_08 = ?)  AND EXTRACT(YEAR FROM ACT_DT) = ? "
					+ " ORDER BY 2 ASC ) T1   GROUP BY MTH) " + "  UNION ALL "
					+ "   SELECT NULL, '10', 'JIH LOST TOTAL', SUM (COALESCE (lostDeatails.VALUE, 0)) VALUE FROM FJPORTAL.QUOT_LOST_TYPE lostType LEFT JOIN  (  SELECT LHREMARKS_TYPE,  COUNT (LHREMARKS_TYPE) COUNT, "
					+ "    SUM (QTN_AMOUNT) VALUE  FROM FJT_SM_STG2_TBL WHERE     LH_STATUS = 'L'  AND LHREMARKS_TYPE IS NOT NULL  AND TO_CHAR (UPD_DT, 'RRRR') = TO_CHAR (SYSDATE, 'RRRR')  AND SALES_EGR_CODE = ?"
					+ "   GROUP BY LHREMARKS_TYPE, SALES_EGR_CODE) lostDeatails   ON lostType.CODE = lostDeatails.LHREMARKS_TYPE WHERE CODE NOT IN ('H', 'WO') "
					+ " UNION ALL "
					+ "SELECT NULL,  '10.1', 'JIH LOST No RESP', COALESCE (lostDeatails.VALUE, 0) VALUE FROM FJPORTAL.QUOT_LOST_TYPE lostType  LEFT JOIN  (  SELECT LHREMARKS_TYPE,  COUNT (LHREMARKS_TYPE) COUNT, "
					+ "  SUM (QTN_AMOUNT) VALUE  FROM FJT_SM_STG2_TBL WHERE     LH_STATUS = 'L'  AND LHREMARKS_TYPE IS NOT NULL AND EXTRACT (YEAR FROM UPD_DT) = ?  AND SALES_EGR_CODE = ?  GROUP BY LHREMARKS_TYPE, SALES_EGR_CODE) lostDeatails "
					+ "  ON     lostType.CODE = lostDeatails.LHREMARKS_TYPE AND DESCRIPTION = 'No Response' WHERE CODE NOT IN ('H', 'WO') AND ROWNUM = 1 ORDER BY 1";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, smCode);
			preparedStatement.setString(2, smEmpCode);
			preparedStatement.setString(3, sYear);
			preparedStatement.setString(4, smCode);
			preparedStatement.setString(5, sYear);
			preparedStatement.setString(6, smCode);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				String smcode = resultSet.getString(1);
				String srN0 = resultSet.getString(2);
				String perf_ttl = resultSet.getString(3);
				String yearTot = resultSet.getString(4);

				SalesmanPerformance tempList = new SalesmanPerformance(smcode, srN0, perf_ttl, yearTot);
				performanceList.add(tempList);
				smMap.put(perf_ttl, tempList);

			}

		} finally {
			close(preparedStatement, resultSet);
			orcle.closeConnection();
		}

		return smMap;

	}

	// CUSTOMER VISIT COUNT FOR DASHBAORD
	public List<CustomerVisit> getSalesEngineerCustoVisitCounts(String salesEmpCode, String year) throws SQLException {
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
					+ "  HAVING  ACT_SM_CODE IN ( SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_08 = ? )  AND EXTRACT(YEAR FROM ACT_DT) = ? "
					+ "  ORDER BY 2 ASC ) T1 " + "  GROUP BY MTH ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEmpCode);
			myStmt.setString(2, year);
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

	public List<CustomerVisit> getSegCustomerVisitDetails(String saleEngEmpCode, String year, String month)
			throws SQLException {
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "  SELECT * FROM  FJPORTAL.CUS_VIST_ACTION  WHERE   "
					+ " ACT_SM_CODE  IN ( SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_08 = ? )  AND to_number(to_char(to_date(ACT_DT,'DD-MM-YY'),'YYYY'))  = ?  AND to_number(to_char(to_date(ACT_DT,'DD-MM-YY'),'MM')) = ?  ORDER BY 4 ASC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, saleEngEmpCode);
			myStmt.setString(2, year);
			myStmt.setString(3, month);
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
				CustomerVisit tmpProjectList = new CustomerVisit(documentId, smCode, actionDate, actionDesc, visitType,
						fromTime, toTime, projectName, partyName, custName, custContactNo);
				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage1Details> stage1SummaryDetails(String smCode) throws SQLException {
		List<Stage1Details> s1DetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE, CUST_NAME, PROJECT_NAME, CONSULTANT, JOB_STAGES, PROD_TYPE,   "
					+ " PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT, SALES_EGR_CODE, SALES_ENG_NAME FROM FJT_SM_TENDER_DET_TBL  "
					+ " WHERE SALES_EGR_CODE= ? order by QTN_DT ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);

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

	public List<SipJihDues> getJihLostDetails(String smCode, String sYear) throws SQLException {
		List<SipJihDues> jihDueList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DESCRIPTION,COALESCE (LOSTDEATAILS.COUNT, 0) COUNT, COALESCE (LOSTDEATAILS.VALUE, 0) VALUE  FROM FJPORTAL.QUOT_LOST_TYPE LOSTTYPE "
					+ "   LEFT JOIN (  SELECT LHREMARKS_TYPE, COUNT (LHREMARKS_TYPE) COUNT,  SUM (QTN_AMOUNT) VALUE FROM FJT_SM_STG2_TBL   WHERE     LH_STATUS = 'L' "
					+ "  AND LHREMARKS_TYPE IS NOT NULL  AND  EXTRACT(YEAR FROM UPD_DT) = ? AND SALES_EGR_CODE = ?   GROUP BY LHREMARKS_TYPE, SALES_EGR_CODE) LOSTDEATAILS "
					+ "   ON LOSTTYPE.CODE = LOSTDEATAILS.LHREMARKS_TYPE WHERE CODE NOT IN ('H', 'WO') ORDER BY 1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sYear);
			myStmt.setString(2, smCode);
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

	public List<SipJihDues> getSEJihLostQtnDetails(String lostType, String smCode, String selyear) throws SQLException {
		List<SipJihDues> volumeList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJT_SM_STG2_TBL WHERE SALES_EGR_CODE = ? AND  EXTRACT(YEAR FROM UPD_DT) = ? AND  LHREMARKS_TYPE = (SELECT DISTINCT CODE FROM QUOT_LOST_TYPE WHERE DESCRIPTION = ? ) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);
			myStmt.setString(2, selyear);
			myStmt.setString(3, lostType);
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
				double qtnAMount = myRes.getDouble(12);
				String qtnStatus = myRes.getString(21);
				String remarks = myRes.getString(22);
				String updatedDate = formatDate(myRes.getString(25));
				SipJihDues tempVolumeList = new SipJihDues(slesCode, sys_id, qtnDate, qtnCode, qtnNo, custCode,
						custName, projectName, consultant, qtnAMount, qtnStatus, remarks, updatedDate);
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
		// System.out.println("dateValue= " + dateValue);
		String formattedDate = "";
		String[] tempArray;
		String delimiter = "-";
		tempArray = dateValue.split(delimiter);
		// System.out.println("tempArray" + tempArray);
		String[] newArray = new String[3];
		for (int i = 0, j = 2; i <= 2; i++) {
			// System.out.println(tempArray[i] + " j = " + j);
			newArray[j] = tempArray[i];
			j--;
		}

		formattedDate = Arrays.toString(newArray);
		formattedDate = formattedDate.substring(1, formattedDate.length() - 1).replace(", ", "/");
		// System.out.println(formattedDate);

		return formattedDate;

	}

	public String getEmployeeCodeBySalesCode(String theSalesEngCode) throws SQLException {
		String empCode = "E000000";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SM_FLEX_08 FROM OM_SALESMAN WHERE SM_CODE = ? AND ROWNUM = 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theSalesEngCode);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				empCode = myRes.getString(1);
			}
			return empCode;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<CustomerVisit> getSalesEngineerStage2ProjectListForCustVisit(String emp_code) throws SQLException {
		// System.out.println("INSIDE ");
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DOC_ID, PARTY_NAME, CONTACT_PERSON, PROJ_NAME, PROJ_STAGE, CONSULTANT FROM CUS_VIST_ACTION_TBL "
					+ " WHERE  SM_CODE IN (SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 )  "
					+ "  AND  DOC_DATE BETWEEN ADD_MONTHS (TRUNC (SYSDATE,'YEAR'), -12) AND SYSDATE   "
					+ " ORDER BY DOC_DATE DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String partyName = myRes.getString(2);
				String contacts = myRes.getString(3);
				String projectName = myRes.getString(4);
				String projectStage = myRes.getString(5);
				String consultant = myRes.getString(6);
				// System.out.println("document ID : "+documentId);
				CustomerVisit tmpProjectList = new CustomerVisit(documentId, partyName, contacts, projectName,
						projectStage, consultant);
				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int weeklySalesTarget(String segEmplCode) throws SQLException {
		int count = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  MAX(NVL(SM_FLEX_11,0)) \"WEEKLY_TARGET\" FROM OM_SALESMAN "
					+ "WHERE SM_FLEX_08  = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, segEmplCode);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				count = myRes.getInt(1);
			}
			return count;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<CustomerVisit> getSalesEngineerStage2ProjectListForReminders(String emp_code) throws SQLException {
		// System.out.println("INSIDE ");
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DOC_ID, PARTY_NAME, CONTACT_PERSON, PROJ_NAME, PROJ_STAGE, CONSULTANT,H_SYS_ID FROM FOLLOWUP_DOC_TBL "
					+ " WHERE  SM_CODE IN (SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 )  "
					+ "  AND  DOC_DATE BETWEEN ADD_MONTHS (TRUNC (SYSDATE,'YEAR'), -12) AND SYSDATE   "
					+ " ORDER BY DOC_DATE DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String partyName = myRes.getString(2);
				String contacts = myRes.getString(3);
				String projectName = myRes.getString(4);
				String projectStage = myRes.getString(5);
				String consultant = myRes.getString(6);
				int hsysId = myRes.getInt(7);
				// System.out.println("document ID : "+documentId);
				CustomerVisit tmpProjectList = new CustomerVisit(documentId, partyName, contacts, projectName,
						projectStage, consultant, hsysId);
				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<CustomerVisit> getRemindersFortheDay(String emp_code, String theDate) throws SQLException {
		// System.out.println("INSIDE ");
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		java.sql.Date sqlDate = null;
		try {
			java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(theDate);
			sqlDate = new java.sql.Date(date1.getTime());
		} catch (Exception e) {

		}
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT QUOT_OR_ENQ_TYPE,REMINDER_DESC,QUOT_PROJ_NAME,ACT_PARTY_NAME,USER_TYPE FROM  FJPORTAL.SIP_REMINDER WHERE REMINDER_DATE = ? AND EMP_CODE = ? ORDER BY 1";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, sqlDate);
			myStmt.setString(2, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				CustomerVisit tmpProjectList;
				String documentId = myRes.getString(1);
				String reminderDesc = myRes.getString(2);
				String projectName = myRes.getString(3);
				String partyName = myRes.getString(4);
				String userType = myRes.getString(5);
				if (userType.equals("0")) {
					tmpProjectList = new CustomerVisit(documentId, partyName, projectName, reminderDesc, userType);
				} else {
					tmpProjectList = new CustomerVisit(documentId, partyName, projectName,
							documentId + " : " + reminderDesc, userType);
				}
				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipWeeklyReport> getS2S3S4WeeklySalesSummery(String salesEngCode, String theYear) throws SQLException {
		List<SipWeeklyReport> sipWeeklyReport = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		SipWeeklyReport tempSalesmanList = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = " select week,sum(STG2_AMT),sum(STG3_AMT),sum(STG4_AMT),sum(STG5_AMT) FROM STG2_STG3_STG4_SMDIVNWEEK WHERE SM = ? GROUP BY WEEK ORDER BY WEEK";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEngCode);
			// myStmt.setString(2, theYear);
			myRes = myStmt.executeQuery();
			int count = 1;
			while (myRes.next()) {
				String week = myRes.getString(1);
				String s2Count = myRes.getString(2);
				String s3Count = myRes.getString(3);
				String s4Count = myRes.getString(4);
				String s5Count = myRes.getString(5);
				int weekNo = Integer.parseInt(week);
				if (count < weekNo) {
					System.out.println("count" + count);
					for (; count < weekNo; count++) {
						tempSalesmanList = new SipWeeklyReport(count, "", "", "0", "", "0", "", "0", "", "0", "");
						sipWeeklyReport.add(tempSalesmanList);
					}
				}
				tempSalesmanList = new SipWeeklyReport(weekNo, "", "", s2Count, "", s3Count, "", s4Count, "", s5Count,
						"");
				sipWeeklyReport.add(tempSalesmanList);
				count++;
			}
			return sipWeeklyReport;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihvSummary> getSalesMgrsListfor_Mg(String sales_eng_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
//			String sql = "SELECT SM_CODE,SM_NAME,SM_FLEX_08,SM_BL_SHORT_NAME FROM OM_SALESMAN WHERE sm_frz_flag_num=2  "
//					+ "AND SM_FLEX_08 IN ( SELECT DISTINCT MGR_EMPCODE FROM SMGR_MAP) Order by SM_NAME ";
			String sql = "SELECT DISTINCT MGR_EMPCODE, EMP_NAME MGR_NAME " + "  FROM SMGR_MAP, PAYROLL.PM_EMP_KEY "
					+ "WHERE MGR_EMPCODE = EMP_CODE order by MGR_NAME";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String salesman_emp_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				// String salesman_code = myRes.getString(3);
				// String salesman_division = myRes.getString(4);
				SipJihvSummary tempSalesmanList = new SipJihvSummary("", salesman_name, salesman_emp_code, "", 0);
				salesEngList.add(tempSalesmanList);
			}

		} catch (SQLException e) {
			System.out
					.println("Exception Sales eng EMp COde SipcharDbUtil.getSalesEngListfor_Mg " + sales_eng_Emp_code);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return salesEngList;

	}

	public List<SipJihvSummary> getSalesEngListfor_SalesMgrs(String sales_mgr_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DISTINCT SMGR_SMCODE SMCODE,SM_NAME,SM_FLEX_08 SM_EMPCODE,SM_BL_SHORT_NAME FROM SMGR_MAP,OM_SALESMAN "
					+ " WHERE SMGR_SMCODE = SM_CODE AND MGR_EMPCODE= ? ORDER BY 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_mgr_Emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String salesman_emp_code = myRes.getString(3);
				String salesman_division = myRes.getString(4);
				SipJihvSummary tempSalesmanList = new SipJihvSummary(salesman_code, salesman_name, salesman_emp_code,
						salesman_division, 0);
				salesEngList.add(tempSalesmanList);
			}
		} catch (SQLException e) {
			System.out
					.println("Exception Sales eng EMp COde SipcharDbUtil.getSalesEngListfor_Mg " + sales_mgr_Emp_code);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return salesEngList;

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

	public Map<String, SalesmanPerformance> getSalesManagerPerformance(String smCode) throws SQLException {
		List<SalesmanPerformance> performanceList = new ArrayList<>();
		Connection connection = null;
		Map<String, SalesmanPerformance> smMap = new HashMap<String, SalesmanPerformance>();
		Map<String, String> salesEngList = new LinkedHashMap();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		OrclDBConnectionPool orcle = new OrclDBConnectionPool();
		try {
			connection = orcle.getOrclConn();
//			String sql = "SELECT MGR_EMPCODE,SRNO,PERF_TTL,NVL(SUM(YR_TOT_T),0) YR_TOT_T FROM SMGR_MAP,SM_YTD_PERF_AKM_TBL,PAYROLL.PM_EMP_KEY WHERE SMGR_SMCODE = SMCODE "
//					+ "AND MGR_EMPCODE = EMP_CODE AND UPPER(PERF_TTL) NOT LIKE '%PERC%' AND MGR_EMPCODE = ? GROUP BY MGR_EMPCODE,EMP_NAME,SRNO,PERF_TTL ORDER BY 3";
//			String sql = "SELECT MGR_EMPCODE,SRNO,PERF_TTL,NVL(SUM(YR_TOT_T),0) YR_TOT_T,NULL SM_CODE,NULL SM_NAME"
//					+ " FROM SMGR_MAP,SM_YTD_PERF_AKM_TBL,PAYROLL.PM_EMP_KEY WHERE SMGR_SMCODE = SMCODE"
//					+ " AND MGR_EMPCODE = EMP_CODE AND MGR_EMPCODE = ? GROUP BY MGR_EMPCODE,"
//					+ " SRNO,PERF_TTL UNION ALL SELECT NULL,'111',NULL,NULL,"
//					+ " SM_CODE,SM_NAME FROM SMGR_MAP,OM_SALESMAN WHERE SMGR_SMCODE = SM_CODE"
//					+ " AND MGR_EMPCODE = ? ORDER BY 1,2,3,6 ";
			String sql = "SELECT MGR_EMPCODE,  SRNO,PERF_TTL,NVL(SUM(YR_TOT_T),0) YR_TOT_T,NULL SM_CODE,NULL SM_NAME  "
					+ "FROM SMGR_MAP,SM_YTD_PERF_AKM_TBL,PAYROLL.PM_EMP_KEY  WHERE SMGR_SMCODE = SMCODE  "
					+ " AND MGR_EMPCODE = EMP_CODE  " + "AND MGR_EMPCODE = ?  "
					+ " AND UPPER(PERF_TTL) NOT LIKE '%PERC%'  AND UPPER(PERF_TTL) NOT LIKE '%RATIO%'  "
					+ " GROUP BY MGR_EMPCODE,  SRNO,PERF_TTL  " + " UNION ALL  " + " SELECT MGR_EMPCODE,'7.1',  "
					+ "'OUTSTANDING-RECV <90',  SUM (BAL_AMT_0_30) +  "
					+ " SUM (BAL_AMT_30_60) +   SUM (BAL_AMT_60_90) ,NULL SM_CODE,NULL SM_NAME  "
					+ " FROM FJT_SM_RCVBLE_DET,SMGR_MAP   WHERE SM_CODE = SMGR_SMCODE  "
					+ " AND MGR_EMPCODE = ?   GROUP BY MGR_EMPCODE  " + " UNION ALL  "
					+ " SELECT MGR_EMPCODE,'7.2',  'OUTSTANDING-RECV >90',  "
					+ " SUM (BAL_AMT_90_120),NULL SM_CODE,NULL SM_NAME  "
					+ " FROM FJT_SM_RCVBLE_DET,SMGR_MAP  WHERE SM_CODE = SMGR_SMCODE  "
					+ " AND MGR_EMPCODE = ?  GROUP BY MGR_EMPCODE " + " UNION ALL  "
					+ " SELECT MGR_EMPCODE,'7.3',  'OUTSTANDING-RECV >120',  "
					+ " SUM (BAL_AMT_120_180) +   SUM (BAL_AMT_181) ,NULL SM_CODE,NULL SM_NAME  "
					+ " FROM FJT_SM_RCVBLE_DET,SMGR_MAP    WHERE SM_CODE = SMGR_SMCODE  "
					+ " AND MGR_EMPCODE = ? GROUP BY MGR_EMPCODE   " + " UNION ALL  "
					+ " SELECT MGR_EMPCODE,'8',   'Conversion Ratio',  "
					+ " TRUNC((SUM(STG2_STG4_AMT)/(NVL(SUM(STG2_6MTH_AMT),0)+NVL(SUM(STG2_LOST_AMT),0)+NVL(SUM(STG2_HOLD_AMT),0)+NVL(SUM(STG2_STG4_AMT),0))*100),2) ,  "
					+ " NULL SM_CODE,NULL SM_NAME  " + "    FROM SM_CONV_TBL,SMGR_MAP  "
					+ " WHERE SALES_EGR_CODE = SMGR_SMCODE  AND MGR_EMPCODE = ?  " + " GROUP BY MGR_EMPCODE      "
					+ " UNION ALL SELECT  MGR_EMPCODE,'9','Visit Target Act',COUNT(ACT_SM_CODE),NULL SM_CODE,  NULL SM_NAME FROM CUS_VIST_ACTION,SMGR_MAP "
					+ "  WHERE TO_CHAR(ACT_DT,'RRRR') = TO_CHAR (SYSDATE, 'RRRR')  AND ACT_SM_CODE = SMGR_SMCODE  AND MGR_EMPCODE = ? GROUP BY MGR_EMPCODE "
					+ "   UNION ALL SELECT MGR_EMP_CODE,  '9.1',  'WEEKLY VISIT TAR',   SUM (VIS_TGT) AS TAR,  NULL SM_CODE, NULL SM_NAME FROM (SELECT DISTINCT "
					+ "  SM_FLEX_08 SM_EMP_CODE, NVL(TO_NUMBER (SM_FLEX_11),0) VIS_TGT,  SM_FLEX_17 MGR_EMP_CODE  FROM OM_SALESMAN, SMGR_MAP  WHERE     SM_FLEX_17 = MGR_EMPCODE "
					+ "     AND SM_FLEX_17 = ?   AND NVL (SM_FLEX_11, 0) <> 0 AND SM_CODE = SMGR_SMCODE) GROUP BY MGR_EMP_CODE"
					+ " UNION ALL SELECT MGR_EMPCODE,  '10',  'JIH LOST TOTAL',  SUM (QTN_AMOUNT) ,    NULL SM_CODE,  NULL SM_NAME "
					+ "    FROM FJT_SM_STG2_TBL, SMGR_MAP WHERE LH_STATUS = 'L'  AND LHREMARKS_TYPE IS NOT NULL  AND TO_CHAR (UPD_DT, 'RRRR') = TO_CHAR (SYSDATE, 'RRRR') "
					+ "   AND SALES_EGR_CODE = SMGR_SMCODE   AND MGR_EMPCODE = ? GROUP BY MGR_EMPCODE "
					+ "   UNION ALL "
					+ " SELECT  MGR_EMPCODE,'10.1','JIH LOST No RESP', SUM (QTN_AMOUNT) ,  NULL SM_CODE,  NULL SM_NAME "
					+ "    FROM FJT_SM_STG2_TBL, SMGR_MAP WHERE LH_STATUS = 'L' AND NVL(LHREMARKS_TYPE,'AA') = 'NR'  AND TO_CHAR (UPD_DT, 'RRRR') = TO_CHAR (SYSDATE, 'RRRR') "
					+ "   AND SALES_EGR_CODE = SMGR_SMCODE  AND MGR_EMPCODE = ? GROUP BY MGR_EMPCODE         "
					+ " UNION ALL  " + " SELECT NULL,'11',NULL,NULL,  "
					+ " SM_CODE,SM_NAME FROM SMGR_MAP,OM_SALESMAN  WHERE SMGR_SMCODE = SM_CODE  "
					+ " AND MGR_EMPCODE = ?  ORDER BY 1,2,3,6";

			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, smCode);
			preparedStatement.setString(2, smCode);
			preparedStatement.setString(3, smCode);
			preparedStatement.setString(4, smCode);
			preparedStatement.setString(5, smCode);
			preparedStatement.setString(6, smCode);
			preparedStatement.setString(7, smCode);
			preparedStatement.setString(8, smCode);
			preparedStatement.setString(9, smCode);
			preparedStatement.setString(10, smCode);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				String smcode = resultSet.getString(1);
				String srN0 = resultSet.getString(2);
				String perf_ttl = resultSet.getString(3);
				String yearTot = resultSet.getString(4);
				String salesCode = resultSet.getString(5);
				if (salesCode != null) {
					salesEngList.put(salesCode, resultSet.getString(6));
				}
				SalesmanPerformance tempList = new SalesmanPerformance(smcode, srN0, perf_ttl, yearTot, salesEngList);
				performanceList.add(tempList);
				smMap.put(perf_ttl, tempList);

			}

		} finally {
			close(preparedStatement, resultSet);
			orcle.closeConnection();
		}

		return smMap;

	}

	public Map<String, SalesmanPerformance> getSalesEngineerPerformance(String smCode, String seEmpCode)
			throws SQLException {
		List<SalesmanPerformance> performanceList = new ArrayList<>();
		Connection connection = null;
		Map<String, SalesmanPerformance> smMap = new HashMap<String, SalesmanPerformance>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String aging1 = null, aging2 = null, aging3 = null, aging4 = null, aging5 = null, aging6 = null;
		OrclDBConnectionPool orcle = new OrclDBConnectionPool();
		try {
			connection = orcle.getOrclConn();
			// String sql = "SELECT SMCODE,SRNO,PERF_TTL,NVL(YR_TOT_T,0) FROM
			// SM_YTD_PERF_AKM_TBL,OM_SALESMAN WHERE SMCODE = SM_CODE "
			// + "AND SMCODE = ? ORDER BY 2";
			String sql = "SELECT SMCODE,SRNO,PERF_TTL,NVL(YR_TOT_T,0),NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM SM_YTD_PERF_AKM_TBL WHERE SMCODE = ? "
					+ " UNION ALL "
					+ " SELECT FJT_SM_RCVBLE_DET.sm_code, '222', NULL,NULL, SUM(BAL_AMT_0_30) BAL_AMT_0_30, "
					+ "     SUM (BAL_AMT_30_60) BAL_AMT_30_60,  SUM (BAL_AMT_60_90) BAL_AMT_60_90, "
					+ "   SUM (BAL_AMT_90_120) BAL_AMT_90_120,   SUM (BAL_AMT_120_180) BAL_AMT_120_180, "
					+ "  SUM (BAL_AMT_181) BAL_AMT_181,CR_DT   FROM FJT_SM_RCVBLE_DET, OM_SALESMAN "
					+ "    WHERE FJT_SM_RCVBLE_DET.SM_CODE = OM_SALESMAN.SM_CODE AND FJT_SM_RCVBLE_DET.SM_CODE = ?"
					+ "    GROUP BY FJT_SM_RCVBLE_DET.SM_CODE,OM_SALESMAN.SM_NAME,CR_DT " + " UNION ALL "
					+ "  SELECT NULL,'9','Visit Target Act',SUM(TOTALSUM),NULL,NULL,NULL,NULL,NULL,NULL,"
					+ "       NULL FROM (SELECT MTH, SUM(CNT) AS TOTALSUM from (SELECT EXTRACT(YEAR FROM ACT_DT) YR, EXTRACT(MONTH FROM ACT_DT) MTH, ACT_SM_CODE, "
					+ "                      COUNT(ACT_SM_CODE) CNT   FROM FJPORTAL.CUS_VIST_ACTION "
					+ "                      GROUP BY EXTRACT(YEAR FROM ACT_DT), EXTRACT(MONTH FROM ACT_DT) , ACT_SM_CODE "
					+ "                     HAVING  ACT_SM_CODE IN (SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_08 = ?)  AND EXTRACT(YEAR FROM ACT_DT) = ?"
					+ "                      ORDER BY 2 ASC ) T1   GROUP BY MTH)" + " UNION ALL"
					+ " SELECT  NULL,'9.1','WEEKLY VISIT TAR',to_number(MAX(NVL(SM_FLEX_11,0)))AS TAR ,NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM OM_SALESMAN WHERE SM_FLEX_08  = ? "
					+ " UNION ALL " + "  SELECT  NULL,'10','JIH LOST TOTAL',      "
					+ "         sum(COALESCE (lostDeatails.VALUE, 0)) VALUE,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
					+ "    FROM FJPORTAL.QUOT_LOST_TYPE lostType " + "         LEFT JOIN "
					+ "         (  SELECT LHREMARKS_TYPE, " + "                   COUNT (LHREMARKS_TYPE) COUNT,"
					+ "                   SUM (QTN_AMOUNT) VALUE " + "              FROM FJT_SM_STG2_TBL "
					+ "             WHERE     LH_STATUS = 'L' "
					+ "                   AND LHREMARKS_TYPE IS NOT NULL AND TO_CHAR(UPD_DT,'RRRR') = TO_CHAR(SYSDATE,'RRRR')"
					+ "                   AND SALES_EGR_CODE = ? "
					+ "          GROUP BY LHREMARKS_TYPE, SALES_EGR_CODE) lostDeatails "
					+ "            ON lostType.CODE = lostDeatails.LHREMARKS_TYPE "
					+ "   WHERE CODE NOT IN ('H', 'WO') " + " UNION ALL   "
					+ " SELECT  NULL,'10.1','JIH LOST No RESP',       "
					+ "         COALESCE (lostDeatails.VALUE, 0) VALUE ,NULL,NULL,NULL,NULL,NULL,NULL,NULL   FROM FJPORTAL.QUOT_LOST_TYPE lostType "
					+ "         LEFT JOIN " + "         (  SELECT LHREMARKS_TYPE, "
					+ "                   COUNT (LHREMARKS_TYPE) COUNT, " + "                   SUM (QTN_AMOUNT) VALUE "
					+ "              FROM FJT_SM_STG2_TBL " + "             WHERE     LH_STATUS = 'L' "
					+ "                   AND LHREMARKS_TYPE IS NOT NULL "
					+ "  AND  EXTRACT(YEAR FROM UPD_DT) = ?                 AND SALES_EGR_CODE = ? "
					+ "          GROUP BY LHREMARKS_TYPE, SALES_EGR_CODE) lostDeatails "
					+ "            ON lostType.CODE = lostDeatails.LHREMARKS_TYPE and DESCRIPTION ='No Response'  "
					+ "   WHERE CODE NOT IN ('H', 'WO') AND ROWNUM = 1" + " ORDER BY 1";

			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, smCode);
			preparedStatement.setString(2, smCode);
			preparedStatement.setString(3, seEmpCode);
			preparedStatement.setInt(4, Calendar.getInstance().get(Calendar.YEAR));
			preparedStatement.setString(5, seEmpCode);
			preparedStatement.setString(6, smCode);
			preparedStatement.setInt(7, Calendar.getInstance().get(Calendar.YEAR));
			preparedStatement.setString(8, smCode);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				String smcode = resultSet.getString(1);
				String srN0 = resultSet.getString(2);
				String perf_ttl = resultSet.getString(3);
				String yearTot = resultSet.getString(4);
				if (srN0.equals("222")) {
					aging1 = resultSet.getString(5);
					aging2 = resultSet.getString(6);
					aging3 = resultSet.getString(7);
					aging4 = resultSet.getString(8);
					aging5 = resultSet.getString(9);
					aging6 = resultSet.getString(10);
				}

				SalesmanPerformance tempList = new SalesmanPerformance(smcode, srN0, perf_ttl, yearTot, aging1, aging2,
						aging3, aging4, aging5, aging6);
				performanceList.add(tempList);
				smMap.put(perf_ttl, tempList);

			}

		} finally {
			close(preparedStatement, resultSet);
			orcle.closeConnection();
		}

		return smMap;

	}

	public String checkIfRecordExists(String salesCode, String weekNo) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String result = "No";
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT *  FROM FORECAST_STG234_SMDIVNWEEK WHERE SM = ? AND WEEK = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesCode);
			myStmt.setString(2, weekNo);
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

	public int updateSaleForecast(String salesCode, String weekNo, String s3no, String s4no, String s5no)
			throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = "UPDATE FORECAST_STG234_SMDIVNWEEK SET STG3_AMT = ?,STG4_AMT = ?,STG5_AMT = ? WHERE SM = ? AND WEEK = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, s3no);
			myStmt.setString(2, s4no);
			myStmt.setString(3, s5no);
			myStmt.setString(4, salesCode);
			myStmt.setString(5, weekNo);
			logType = myStmt.executeUpdate();
			return logType;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int insertSaleForecast(String salesCode, String weekNo, String s3no, String s4no, String s5no,
			String compCode, String divnCode) throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = "INSERT INTO FORECAST_STG234_SMDIVNWEEK(WEEK,COMP,SM,DIVN,STG3_AMT,STG4_AMT,STG5_AMT,YEAR) VALUES (?,?,?,?,?,?,?,to_char(sysdate, 'YYYY'))";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, weekNo);
			myStmt.setString(2, compCode);
			myStmt.setString(3, salesCode);
			myStmt.setString(4, divnCode);
			myStmt.setString(5, s3no);
			myStmt.setString(6, s4no);
			myStmt.setString(7, s5no);
			logType = myStmt.executeUpdate();
			return logType;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SalesManForecast> getSalesEngListfor_NormalSalesEgrWithForecastDetails(String sales_eng_Emp_code,
			String weekNo) throws SQLException {
		List<SalesManForecast> salesEngList = new ArrayList<>();// sales egr list for normal sales egr
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SM_CODE, SM_NAME,SM_FLEX_08,STG3_AMT,STG4_AMT,STG5_AMT FROM FORECAST_STG234_SMDIVNWEEK forecast,om_salesman omsales WHERE WEEK (+)= ?"
					+ " AND forecast.SM(+)=omsales.SM_CODE AND (omsales.SM_FLEX_08= ? OR SM_FLEX_17 = ?)";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, weekNo);
			myStmt.setString(2, sales_eng_Emp_code);
			myStmt.setString(3, sales_eng_Emp_code);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String salesman_emp_code = myRes.getString(3);
				String s3No = myRes.getString(4);
				String s4No = myRes.getString(5);
				String s5No = myRes.getString(6);
				SalesManForecast tempSalesmanList = new SalesManForecast(salesman_code, salesman_name,
						salesman_emp_code, s3No, s4No, s5No);
				salesEngList.add(tempSalesmanList);
			}
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihvSummary> getSalesMgrsListfor_Dm(String sales_eng_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DISTINCT EMP_CODE,EMP_NAME FROM PM_EMP_KEY,OM_SALESMAN  WHERE EMP_CODE IN (SELECT DISTINCT SM_FLEX_17  from  OM_SALESMAN WHERE SM_FLEX_18= ? and SM_FLEX_17 IS NOT NULL) ORDER BY 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_eng_Emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String salesman_emp_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				SipJihvSummary tempSalesmanList = new SipJihvSummary("", salesman_name, salesman_emp_code, "", 0);
				salesEngList.add(tempSalesmanList);
			}

		} catch (SQLException e) {
			System.out
					.println("Exception Sales eng EMp COde SipcharDbUtil.getSalesMgrsListfor_Dm " + sales_eng_Emp_code);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return salesEngList;

	}

	public long stage5Summary(String sale_Egs_Code, String syear) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s5 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE5 FOR A GIVEN SALES EGR AS ON RUNNING DATE.
			String sql = " SELECT NVL(YR_TOT_A,0) FROM FJT_SM_BLNG_TRG_ACT_SUMM  WHERE SMT_CODE = ? AND SMT_YEAR=? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sale_Egs_Code);
			myStmt.setString(2, syear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s5 = myRes.getLong(1);
			}
			return s5;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage5Details> stage5SummaryDetails(String sales_man_code) throws SQLException {

		List<Stage5Details> s5DetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// ----listing of Stage5 transactions for a given Sales Egr, as on Current
			// running date
			String sql = "SELECT * FROM SIP_SM_BLNG_TBL WHERE SM_CODE =  ?  AND TO_CHAR(DOC_DATE,'YYYY') = TO_CHAR(SYSDATE,'YYYY') order by DOC_DATE";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_man_code);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String comp_code = myRes.getString(1);
				String week = myRes.getString(2);
				String doc_id = myRes.getString(3);
				String doc_date = myRes.getString(4);
				String sm_code = myRes.getString(5);
				String sm_name = myRes.getString(6);
				String partyName = myRes.getString(7);
				String contact = myRes.getString(8);
				String phone = myRes.getString(9);
				String projectName = myRes.getString(10);
				String product = myRes.getString(11);
				String zone = myRes.getString(12);
				String currency = myRes.getString(13);
				int balance_value = myRes.getInt(14);

				Stage5Details temps5DetailsList = new Stage5Details(comp_code, week, doc_id, doc_date, sm_code, sm_name,
						partyName, contact, phone, projectName, product, zone, currency, balance_value);
				s5DetailsList.add(temps5DetailsList);
			}
			return s5DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
}