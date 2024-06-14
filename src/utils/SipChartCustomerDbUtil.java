package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipCustomer;
import beans.SipCustomerPaymentTermHistory;
import beans.SipDivPdcOnHand;
import beans.SipJihvSummary;
import beans.SipLCSignaturePending;

public class SipChartCustomerDbUtil {

	public List<SipJihvSummary> getSalesEngListfor_Dm(String dm_emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();// appraise company code list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SM_CODE, SM_NAME,SM_FLEX_08 FROM OM_SALESMAN  "
					+ "WHERE SM_FLEX_08 IN (SELECT EMP_CODE FROM PM_EMP_KEY "
					+ "WHERE EMP_STATUS IN (1,2)  AND EMP_FRZ_FLAG='N') "
					+ "AND SM_FLEX_07='Y' AND SM_FRZ_FLAG_NUM=2 and SM_FLEX_18 = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);// division manager employee code
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

	public List<SipCustomer> getCustomerVisitSummery(String year, String sm_Code) throws SQLException {
		List<SipCustomer> visitList = new ArrayList<>();// appraise company code list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT ACT_SM_CODE SM_CODE,SM_NAME SALESMAN,  "
					+ "TO_CHAR (AS_ON_DATE, 'RR') || '-' || WEEK WEEK,COUNT(ACT_DOC_ID) VISITS  "
					+ "FROM ORION.SIP_FUP_ACTION,ORION.MANISH_DATE,ORION.OM_SALESMAN  "
					+ "WHERE (ACT_TYPE LIKE 'Out%' OR ACT_DOC_ID='General')  " + "AND ACT_DT = AS_ON_DATE  "
					+ "AND ACT_SM_CODE = SM_CODE  " + "AND TO_CHAR(ACT_DT,'RRRR') = ? " + "AND ACT_SM_CODE LIKE ? "
					+ "AND SM_CODE LIKE 'F%'  " + "AND NVL(SM_FRZ_FLAG_NUM,2) = 2  "
					+ "GROUP BY ACT_SM_CODE,SM_NAME,TO_CHAR (AS_ON_DATE, 'RR') || '-' || WEEK  " + "ORDER BY 1,3 DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year);
			myStmt.setString(2, sm_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String year_temp = myRes.getString(1);
				String week_temp = myRes.getString(2);
				String visit_temp = myRes.getString(3);
				SipCustomer tempvisitList = new SipCustomer(year_temp, week_temp, visit_temp);
				visitList.add(tempvisitList);
			}
			return visitList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipCustomer> getCustomerWiseProjectList() throws SQLException {
		List<SipCustomer> customerProjectList = new ArrayList<>();//
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJT_JIH_DET_STAT WHERE WEEK LIKE '18%'";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String customer_code = myRes.getString(1);
				String customer_name = myRes.getString(2);
				String week = myRes.getString(3);
				String quatation_status = myRes.getString(4);
				String quatation_date = myRes.getString(5);
				String company_code = myRes.getString(6);
				String quatation_code = myRes.getString(7);
				String quatation_no = myRes.getString(8);
				String division = myRes.getString(9);
				String sm_code = myRes.getString(10);
				String sm_name = myRes.getString(11);
				String project_name = myRes.getString(12);
				String consultant = myRes.getString(13);
				String prdct_type = myRes.getString(14);
				String pproduct_classf = myRes.getString(15);
				String zone = myRes.getString(16);
				SipCustomer tempcustomerProjectList = new SipCustomer(customer_code, customer_name, week,
						quatation_status, quatation_date, company_code, quatation_code, quatation_no, division, sm_code,
						sm_name, project_name, consultant, prdct_type, pproduct_classf, zone);
				customerProjectList.add(tempcustomerProjectList);
			}
			return customerProjectList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDivPdcOnHand> getPdcOnHand(String dm_emp_code) throws SQLException {
		// this function for pdc on hand report for all divisions under dm with passing
		// dm code
		List<SipDivPdcOnHand> pdcList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DIVN, NVL(SUM (JAN_AMT),0) JAN, NVL(SUM (FEB_AMT),0) FEB, NVL(SUM (MAR_AMT),0) MAR,NVL(SUM (APR_AMT),0) APR, NVL(SUM (MAY_AMT),0) MAY,NVL(SUM (JUN_AMT),0) JUN, "
					+ "  NVL(SUM (JUL_AMT),0) JUL,  NVL(SUM (AUG_AMT),0) AUG, NVL(SUM (SEP_AMT),0) SEP,NVL(SUM (OCT_AMT),0) OCT, NVL(SUM (NOV_AMT),0) NOV, NVL(SUM (DEC_AMT),0) DEC "
					+ " FROM (  SELECT DIVN,SUM (LC_AMT) JAN_AMT, NULL FEB_AMT, NULL MAR_AMT, NULL APR_AMT, NULL MAY_AMT, NULL JUN_AMT,  "
					+ " NULL JUL_AMT, NULL AUG_AMT,  NULL SEP_AMT,NULL OCT_AMT,NULL NOV_AMT, NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'JAN'  GROUP BY DIVN  UNION ALL   "
					+ " SELECT DIVN,NULL JAN_AMT, SUM (LC_AMT) FEB_AMT,NULL MAR_AMT, NULL APR_AMT,  NULL MAY_AMT,  "
					+ " NULL JUN_AMT,  NULL JUL_AMT, NULL AUG_AMT,NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT, NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'FEB' GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,SUM (LC_AMT) MAR_AMT, NULL APR_AMT, NULL MAY_AMT,  NULL JUN_AMT, NULL JUL_AMT,    "
					+ " NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT,  "
					+ " NULL NOV_AMT, NULL DEC_AMT FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'MAR' GROUP BY DIVN  "
					+ " UNION ALL  "
					+ " SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,NULL MAR_AMT,SUM (LC_AMT) APR_AMT,NULL MAY_AMT,  "
					+ " NULL JUN_AMT, NULL JUL_AMT,NULL AUG_AMT,NULL SEP_AMT, NULL OCT_AMT,NULL NOV_AMT, NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'APR' GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,  NULL MAR_AMT,NULL APR_AMT,SUM (LC_AMT) MAY_AMT,  "
					+ " NULL JUN_AMT, NULL JUL_AMT,NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT,NULL NOV_AMT, NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'MAY' GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN,NULL JAN_AMT,  NULL FEB_AMT, NULL MAR_AMT, NULL APR_AMT, NULL MAY_AMT, SUM (LC_AMT) JUN_AMT,  "
					+ " NULL JUL_AMT,NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT,NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'JUN' GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT, NULL MAR_AMT,NULL APR_AMT,NULL MAY_AMT,NULL JUN_AMT,  "
					+ " SUM (LC_AMT) JUL_AMT,  NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT, NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'JUL' GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN,NULL JAN_AMT, NULL FEB_AMT,NULL MAR_AMT, NULL APR_AMT,NULL MAY_AMT,  "
					+ " NULL JUN_AMT,NULL JUL_AMT, SUM (LC_AMT) AUG_AMT,NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT,NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'AUG' GROUP BY DIVN  "
					+ " UNION ALL SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT, NULL MAR_AMT, NULL APR_AMT, NULL MAY_AMT,  "
					+ " NULL JUN_AMT, NULL JUL_AMT, NULL AUG_AMT, SUM (LC_AMT) SEP_AMT,NULL OCT_AMT,  NULL NOV_AMT,NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'SEP'  GROUP BY DIVN  "
					+ " UNION ALL SELECT DIVN,NULL JAN_AMT, NULL FEB_AMT, NULL MAR_AMT,NULL APR_AMT, NULL MAY_AMT, NULL JUN_AMT,  "
					+ " NULL JUL_AMT, NULL AUG_AMT,NULL SEP_AMT, SUM (LC_AMT) OCT_AMT, NULL NOV_AMT, NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'OCT'  GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN,NULL JAN_AMT,NULL FEB_AMT, NULL MAR_AMT,NULL APR_AMT,NULL MAY_AMT,  NULL JUN_AMT,  NULL JUL_AMT,  "
					+ " NULL AUG_AMT, NULL SEP_AMT,  NULL OCT_AMT, SUM (LC_AMT) NOV_AMT,NULL DEC_AMT  "
					+ " FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'NOV'  GROUP BY DIVN   UNION ALL  "
					+ " SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,NULL MAR_AMT,  NULL APR_AMT, NULL MAY_AMT, NULL JUN_AMT, NULL JUL_AMT,   "
					+ " NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT, SUM (LC_AMT) DEC_AMT  "
					+ " FROM FJT_PDC_HAND  WHERE DM_EMP_CODE = ?  AND MONTH = 'DEC' GROUP BY DIVN) GROUP BY DIVN ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myStmt.setString(2, dm_emp_code);
			myStmt.setString(3, dm_emp_code);
			myStmt.setString(4, dm_emp_code);
			myStmt.setString(5, dm_emp_code);
			myStmt.setString(6, dm_emp_code);
			myStmt.setString(7, dm_emp_code);
			myStmt.setString(8, dm_emp_code);
			myStmt.setString(9, dm_emp_code);
			myStmt.setString(10, dm_emp_code);
			myStmt.setString(11, dm_emp_code);
			myStmt.setString(12, dm_emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String divname = myRes.getString(1);
				String jan_data_tmp = myRes.getString(2);
				String feb_data_tmp = myRes.getString(3);
				String mar_data_tmp = myRes.getString(4);
				String apr_data_tmp = myRes.getString(5);
				String may_data_tmp = myRes.getString(6);
				String jun_data_tmp = myRes.getString(7);
				String jul_data_tmp = myRes.getString(8);
				String aug_data_tmp = myRes.getString(9);
				String sep_data_tmp = myRes.getString(10);
				String oct_data_tmp = myRes.getString(11);
				String nov_data_tmp = myRes.getString(12);
				String dec_data_tmp = myRes.getString(13);
				SipDivPdcOnHand tempPdcReprt = new SipDivPdcOnHand(divname, jan_data_tmp, feb_data_tmp, mar_data_tmp,
						apr_data_tmp, may_data_tmp, jun_data_tmp, jul_data_tmp, aug_data_tmp, sep_data_tmp,
						oct_data_tmp, nov_data_tmp, dec_data_tmp);
				pdcList.add(tempPdcReprt);
			}
			return pdcList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipCustomerPaymentTermHistory> getCustomerPaymentTermsHistory() throws SQLException {
		List<SipCustomerPaymentTermHistory> customerPaymentList = new ArrayList<>();//
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT PDH_SUB_ACNT_CODE CUSTCODE,CUST_NAME,TERM_NAME,  "
					+ "NVL(PDH_TRAN_CODE,'-') PDCCODE,NVL(PDH_DOC_NO,0) PDCNO,  "
					+ "PDC_DUE_DT DUE_DATE,PDH_CURR_CODE CURR,PDH_FC_AMT AMOUNT,  "
					+ "NVL(BCT_TRAN_CODE,0) BNQ_CODE,NVL(BCT_DOC_NO,0) BNQ_NO,  "
					+ "BCT_DOC_DT BNQ_ENT_DT,NVL(BCT_DOC_REF,'-') BNQ_REF,  "
					+ "NVL(BCT_DESC,'-') BNQ_NARRATION,NVL(PDH_DIVN_CODE,'-') DIVN  " + "FROM PDC_BOUNCED_FJT  "
					+ "ORDER BY 1 ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String customer_code = myRes.getString(1);
				String customer_name = myRes.getString(2);
				String term_name = myRes.getString(3);
				String pdc_code = myRes.getString(4);
				String pdc_no = myRes.getString(5);
				String due_date = myRes.getString(6);
				String currency = myRes.getString(7);
				String amount = myRes.getString(8);
				String bnq_code = myRes.getString(9);
				String bnq_no = myRes.getString(10);
				String bnq_ent_date = myRes.getString(11);
				String bnq_reference = myRes.getString(12);
				String bnq_narration = myRes.getString(13);
				String division = myRes.getString(14);

				SipCustomerPaymentTermHistory tempcustomerPaymentList = new SipCustomerPaymentTermHistory(customer_code,
						customer_name, term_name, pdc_code, pdc_no, due_date, currency, amount, bnq_code, bnq_no,
						bnq_ent_date, bnq_reference, bnq_narration, division);
				customerPaymentList.add(tempcustomerPaymentList);
			}
			return customerPaymentList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipLCSignaturePending> getLcSignaturePending(String divisionList) throws SQLException {
		List<SipLCSignaturePending> lcSignaturePndngList = new ArrayList<>();//
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT MS_SUB_ACNT_CODE CUST_CODE, SUB_ACNT_NAME CUST_NAME,DRCR, SUM (CLOSING_BAL) SIG_PEND_VALUE "
					+ " FROM FJT_LC_SIG_PEND WHERE ABAL_DIVN_CODE IN (" + divisionList + ") "
					+ " GROUP BY MS_SUB_ACNT_CODE, SUB_ACNT_NAME, DRCR";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String customer_code = myRes.getString(1);
				String customer_name = myRes.getString(2);
				String drcr = myRes.getString(3);
				String amount = myRes.getString(4);
				SipLCSignaturePending templcSignaturePndngList = new SipLCSignaturePending(customer_code, customer_name,
						drcr, amount);
				lcSignaturePndngList.add(templcSignaturePndngList);
			}
			return lcSignaturePndngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipLCSignaturePending> getLCAcceptancePending(String division_list) throws SQLException {
		List<SipLCSignaturePending> lcSignaturePndngList = new ArrayList<>();//
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT MS_SUB_ACNT_CODE CUST_CODE, SUB_ACNT_NAME CUST_NAME,DRCR, SUM (CLOSING_BAL) ACCEPT_PEND_VALUE "
					+ " FROM FJT_LC_ACCEPT_PEND WHERE ABAL_DIVN_CODE IN (" + division_list + ") "
					+ " GROUP BY MS_SUB_ACNT_CODE, SUB_ACNT_NAME, DRCR";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String customer_code = myRes.getString(1);
				String customer_name = myRes.getString(2);
				String drcr = myRes.getString(3);
				String amount = myRes.getString(4);

				SipLCSignaturePending templcSignaturePndngList = new SipLCSignaturePending(customer_code, customer_name,
						drcr, amount);
				lcSignaturePndngList.add(templcSignaturePndngList);
			}
			return lcSignaturePndngList;
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

}
