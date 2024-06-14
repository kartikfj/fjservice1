package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import beans.LOIBudgetReplyMailer;
import beans.OrclDBConnectionPool;
import beans.SalesOrder_Budget;

public class LOIBudgetApprovalMailDbutil {

	public LOIBudgetApprovalMailDbutil() {
	}

	public int soStatus(String so_id) throws SQLException {

		int retVal = 0;
		String flex_val = "PORTAL19";
		String mailSendStatus = "Y";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			// Get Connection
			myCon = orcl.getOrclConn();

			// Execute sql stamt
			String sql = "select * FROM LOI_BDG_APPR WHERE SOB_CQH_SYS_ID= ? AND SOB_FLEX_01= ? "
					+ " AND SOB_APPR_STATUS IS NULL AND SOB_APPR_DT IS NULL AND  SOB_APPR_UID IS NULL "
					+ " AND SOB_MAIL_STATUS = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, so_id);
			myStmt.setString(2, flex_val);
			myStmt.setString(3, mailSendStatus);
			myRes = myStmt.executeQuery();

			if (myRes.next()) {
				retVal = 1;

			}
			return retVal;
		} catch (SQLException e) {
			System.out.println("Exception  for SOID  BudgetApprovalMailDbUtil.soStatus " + so_id);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return retVal;
	}

	public int updateApproveRejectStatus(String so_id, String approver_eid, String aprvOrReject) throws SQLException {
		String mail_send_status = "Y";
		String flex_val = "PORTAL19";
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE LOI_BDG_APPR " + " SET SOB_APPR_UID = ?, SOB_APPR_DT=SYSDATE, SOB_APPR_STATUS= ? "
					+ " where SOB_CQH_SYS_ID= ? AND SOB_MAIL_STATUS = ? AND SOB_FLEX_01= ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approver_eid);
			myStmt.setString(2, aprvOrReject);
			myStmt.setString(3, so_id);
			myStmt.setString(4, mail_send_status);
			myStmt.setString(5, flex_val);
			// myStmt.execute();
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of approval and reject process ");
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public List<SalesOrder_Budget> getNewSOBudgetApprovalRows(String emailId) throws SQLException {

		// select all so budget request which is not updated, its for MAILNG HANDLE

		String flex_val = "PORTAL19";
		List<SalesOrder_Budget> soUnUpdatedList = new ArrayList<>();//

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SOB_CQH_SYS_ID, SOB_QTN_CODE, SOB_QTN_NO, SOB_CUST_CODE, SOB_CUST_NAME,SOB_PROJ,  "
					+ "SOB_TOT_QTN_AMT, SOB_TOT_BDGT_AMT, SOB_GROSS_PROFIT_AMT, SOB_BUDG_PROF_PERC,  "
					+ "SOB_MARGIN, SOB_TOL, SOB_DM_EMAIL, SOB_OTHER_EMAIL, SOB_CR_DT, NVL(SOB_MARGIN,0),NVL(SOB_TOL,0) "
					+ "FROM LOI_BDG_APPR   "
					+ "WHERE SOB_APPR_UID IS NULL AND SOB_APPR_DT IS NULL AND SOB_APPR_STATUS IS NULL AND SOB_MAIL_STATUS IS NULL AND SOB_FLEX_01= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, flex_val);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String sys_id_tmp = myRes.getString(1);
				String so_code_tmp = myRes.getString(2);
				String so_number_tmp = myRes.getString(3);
				String customer_code_tmp = myRes.getString(4);
				String customer_name_tmp = myRes.getString(5);
				String project_tmp = myRes.getString(6);
				String tot_val_tmp = myRes.getString(7);
				String sbudget_val_tmp = myRes.getString(8);
				String profit_amount_tmp = myRes.getString(9);
				String profit_perc_tmp = myRes.getString(10);
				String so_margin_tmp = myRes.getString(11);
				String so_tol_tmp = myRes.getString(12);
				String mail_fst_tmp = myRes.getString(13);
				String mail_scnd_tmp = myRes.getString(14);
				String create_dtime_tmp = myRes.getString(15);
				String sob_margin_tmp = myRes.getString(16);
				String sob_tol_tmp = myRes.getString(17);

				SalesOrder_Budget tempsoList = new SalesOrder_Budget(sys_id_tmp, so_number_tmp, so_code_tmp,
						customer_code_tmp, customer_name_tmp, project_tmp, tot_val_tmp, sbudget_val_tmp,
						profit_amount_tmp, profit_perc_tmp, so_margin_tmp, so_tol_tmp, mail_fst_tmp, mail_scnd_tmp,
						create_dtime_tmp, sob_margin_tmp, sob_tol_tmp);

				soUnUpdatedList.add(tempsoList);
			}

			return soUnUpdatedList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	// for dashboard apporovereject

	public int updateApproveRejectStatusDashboard(String so_id, String approver_eid, String aprvOrReject)
			throws SQLException {
		int logType = -2;
		String mail_send_status = "Y";
		String flex_val = "PORTAL19";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE LOI_BDG_APPR "
					+ " SET SOB_APPR_UID = ?, SOB_APPR_DT=SYSDATE, SOB_APPR_STATUS= ?, SOB_MAIL_STATUS = ? "
					+ " where SOB_CQH_SYS_ID= ?  AND SOB_FLEX_01= ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approver_eid);
			myStmt.setString(2, aprvOrReject);
			myStmt.setString(3, mail_send_status);
			myStmt.setString(4, so_id);
			myStmt.setString(5, flex_val);
			// myStmt.execute();
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of approval and reject process ");
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int checkSoBudgetApproverAuthentication(String emailId) throws SQLException {

		// check the employee is authnticated to approve the so budget by passing his
		// emailid

		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// String sqlstr = "select OTHSOB_PGM_EMAIL1 from FJPORTAL.FJT_OTHSOB_PGM where
		// OTHSOB_PGM_EMAIL1 = 'nufail.a@fjtco.com'";
		String sqlstr = "select OTHSOB_PGM_EMAIL1 from FJPORTAL.FJT_OTHSOB_PGM  where OTHSOB_PGM_EMAIL1 = ? ";

		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, emailId);
			rs = psmt.executeQuery();
			if (rs.next()) {

				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
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

	public List<SalesOrder_Budget> getSOBudgetSOCode(String approverMailId) throws SQLException {

		List<SalesOrder_Budget> soCodeList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " select OTHSOB_PGM_SO_CODE from FJPORTAL.FJT_OTHSOB_PGM  where OTHSOB_PGM_EMAIL1 = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approverMailId);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String soCode = myRes.getString(1);
				SalesOrder_Budget tempsocodeList = new SalesOrder_Budget(soCode);
				soCodeList.add(tempsocodeList);
			}

			return soCodeList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<SalesOrder_Budget> getNewSOBudgetApprovalRowsMaster(String soCodeList) throws SQLException {
		// Function (1) for fetching all Sales order that not updated by SO CODE (like
		// SOVAL, SOPIP etc) (Normal, Base on Master table )
		// function to fetch sales order budget details by SOCODE (ie SOPIP, SOVAL)

		String flex_val = "PORTAL19";
		List<SalesOrder_Budget> soUnUpdatedList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SOB_CQH_SYS_ID, SOB_QTN_CODE, SOB_QTN_NO, SOB_CUST_CODE, SOB_CUST_NAME,SOB_PROJ,  "
					+ " SOB_TOT_QTN_AMT, SOB_TOT_BDGT_AMT, SOB_GROSS_PROFIT_AMT, SOB_BUDG_PROF_PERC,  "
					+ " SOB_MARGIN, SOB_TOL, SOB_DM_EMAIL, SOB_OTHER_EMAIL, SOB_CR_DT, NVL(SOB_MARGIN,0),NVL(SOB_TOL,0),SOB_APPR_STATUS, "
					+ " SOB_SM_CODE,SOB_SM_NAME,SOB_TERM  " + " FROM LOI_BDG_APPR   "
					+ " WHERE NOT(SOB_TOT_QTN_AMT > = 100000 AND SOB_BUDG_PROF_PERC < (NVL(SOB_MARGIN,0)-NVL(SOB_TOL,0))) "
					+ " AND ( SOB_APPR_STATUS = 'N' OR  SOB_APPR_STATUS IS NULL )  AND SOB_FLEX_01= ? AND SOB_QTN_CODE in ("
					+ soCodeList + ")  "
					+ "   AND ( (TO_DATE(SYSDATE, 'DD-MM-YYYY') - TO_DATE(SOB_APPR_DT, 'DD-MM-YYYY') <= 7 ) OR SOB_APPR_DT IS  NULL) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, flex_val);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String sys_id_tmp = myRes.getString(1);
				String so_code_tmp = myRes.getString(2);
				String so_number_tmp = myRes.getString(3);
				String customer_code_tmp = myRes.getString(4);
				String customer_name_tmp = myRes.getString(5);
				String project_tmp = myRes.getString(6);
				String tot_val_tmp = myRes.getString(7);
				String sbudget_val_tmp = myRes.getString(8);
				String profit_amount_tmp = myRes.getString(9);
				String profit_perc_tmp = myRes.getString(10);
				String so_margin_tmp = myRes.getString(11);
				String so_tol_tmp = myRes.getString(12);
				String mail_fst_tmp = myRes.getString(13);
				String mail_scnd_tmp = myRes.getString(14);
				String create_dtime_tmp = myRes.getString(15);
				String sob_margin_tmp = myRes.getString(16);
				String sob_tol_tmp = myRes.getString(17);
				String so_aprv_status_temp = myRes.getString(18);
				String seg_code_tmp = myRes.getString(19);
				String seg_name_tmp = myRes.getString(20);
				String so_term_tmp = myRes.getString(21);

				SalesOrder_Budget tempsoList = new SalesOrder_Budget(sys_id_tmp, so_number_tmp, so_code_tmp,
						customer_code_tmp, customer_name_tmp, so_term_tmp, project_tmp, tot_val_tmp, sbudget_val_tmp,
						profit_amount_tmp, profit_perc_tmp, so_margin_tmp, so_tol_tmp, mail_fst_tmp, mail_scnd_tmp,
						create_dtime_tmp, sob_margin_tmp, sob_tol_tmp, so_aprv_status_temp, seg_code_tmp, seg_name_tmp,
						getSoBdgExpencDtls(sys_id_tmp));
				// System.out.println("test"+sys_id_tmp+" : "+tempsoList);
				soUnUpdatedList.add(tempsoList);

			}

			return soUnUpdatedList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SalesOrder_Budget> getNewSOBudgetApprovalRowsTxn(String emailId) throws SQLException {
		// Function (2) for fetching all Sales order that not updated by email id (For
		// Dm, from TXN table (SO_BDG_APPR), field : SOB_DM_EMAIL)
		// Fetch Sales Orders details thats not approved for DM's, by checking email id
		// in SO_BDG_APPR table, SOB_DM_EMAIL is present

		String flex_val = "PORTAL19";
		List<SalesOrder_Budget> soUnUpdatedList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SOB_CQH_SYS_ID, SOB_QTN_CODE, SOB_QTN_NO, SOB_CUST_CODE, SOB_CUST_NAME,SOB_PROJ,  "
					+ " SOB_TOT_QTN_AMT, SOB_TOT_BDGT_AMT, SOB_GROSS_PROFIT_AMT, SOB_BUDG_PROF_PERC,  "
					+ " SOB_MARGIN, SOB_TOL, SOB_DM_EMAIL, SOB_OTHER_EMAIL, SOB_CR_DT, NVL(SOB_MARGIN,0),NVL(SOB_TOL,0),SOB_APPR_STATUS,"
					+ " SOB_SM_CODE,SOB_SM_NAME,SOB_TERM " + " FROM LOI_BDG_APPR   "
					+ " WHERE  NOT(SOB_TOT_QTN_AMT > = 100000 AND SOB_BUDG_PROF_PERC < (NVL(SOB_MARGIN,0)-NVL(SOB_TOL,0))) "
					+ " AND ( SOB_APPR_STATUS = 'N' OR  SOB_APPR_STATUS IS NULL )  AND SOB_FLEX_01= ? AND SOB_DM_EMAIL = ?  "
					+ "    AND ( (TO_DATE(SYSDATE, 'DD-MM-YYYY') - TO_DATE(SOB_APPR_DT, 'DD-MM-YYYY') <= 7 ) OR SOB_APPR_DT IS  NULL) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, flex_val);
			myStmt.setString(2, emailId);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String sys_id_tmp = myRes.getString(1);
				String so_code_tmp = myRes.getString(2);
				String so_number_tmp = myRes.getString(3);
				String customer_code_tmp = myRes.getString(4);
				String customer_name_tmp = myRes.getString(5);
				String project_tmp = myRes.getString(6);
				String tot_val_tmp = myRes.getString(7);
				String sbudget_val_tmp = myRes.getString(8);
				String profit_amount_tmp = myRes.getString(9);
				String profit_perc_tmp = myRes.getString(10);
				String so_margin_tmp = myRes.getString(11);
				String so_tol_tmp = myRes.getString(12);
				String mail_fst_tmp = myRes.getString(13);
				String mail_scnd_tmp = myRes.getString(14);
				String create_dtime_tmp = myRes.getString(15);
				String sob_margin_tmp = myRes.getString(16);
				String sob_tol_tmp = myRes.getString(17);
				String so_aprv_status_temp = myRes.getString(18);
				String seg_code_tmp = myRes.getString(19);
				String seg_name_tmp = myRes.getString(20);
				String so_term_tmp = myRes.getString(21);

				SalesOrder_Budget tempsoList = new SalesOrder_Budget(sys_id_tmp, so_number_tmp, so_code_tmp,
						customer_code_tmp, customer_name_tmp, so_term_tmp, project_tmp, tot_val_tmp, sbudget_val_tmp,
						profit_amount_tmp, profit_perc_tmp, so_margin_tmp, so_tol_tmp, mail_fst_tmp, mail_scnd_tmp,
						create_dtime_tmp, sob_margin_tmp, sob_tol_tmp, so_aprv_status_temp, seg_code_tmp, seg_name_tmp,
						getSoBdgExpencDtls(sys_id_tmp));

				soUnUpdatedList.add(tempsoList);
			}

			return soUnUpdatedList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SalesOrder_Budget> getNewSOBudgetApprovalRowsForCeo() throws SQLException {
		// Function (3) for fetching all Sales order that satisfying the below condition
		// SOB_TOT_SO_AMT > = 100000 AND SOB_BUDG_PROF_PERC <
		// (NVL(SOB_MARGIN,0)-NVL(SOB_TOL,0))
		// Fetch Sales Orders details thats not approved by CEO

		String flex_val = "PORTAL19";
		List<SalesOrder_Budget> soUnUpdatedList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SOB_CQH_SYS_ID, SOB_QTN_CODE, SOB_QTN_NO, SOB_CUST_CODE, SOB_CUST_NAME,SOB_PROJ,  "
					+ " SOB_TOT_QTN_AMT, SOB_TOT_BDGT_AMT, SOB_GROSS_PROFIT_AMT, SOB_BUDG_PROF_PERC,  "
					+ " SOB_MARGIN, SOB_TOL, SOB_DM_EMAIL, SOB_OTHER_EMAIL, SOB_CR_DT, NVL(SOB_MARGIN,0),NVL(SOB_TOL,0),SOB_APPR_STATUS, "
					+ "  SOB_SM_CODE,SOB_SM_NAME,SOB_TERM  " + " FROM LOI_BDG_APPR   "
					+ " WHERE  SOB_TOT_QTN_AMT > = 100000 AND SOB_BUDG_PROF_PERC < (NVL(SOB_MARGIN,0)-NVL(SOB_TOL,0)) "
					+ " AND ( SOB_APPR_STATUS = 'N' OR  SOB_APPR_STATUS IS NULL )  AND SOB_FLEX_01= ?  "
					+ "   AND ( (TO_DATE(SYSDATE, 'DD-MM-YYYY') - TO_DATE(SOB_APPR_DT, 'DD-MM-YYYY') <= 7 ) OR SOB_APPR_DT IS  NULL) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, flex_val);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String sys_id_tmp = myRes.getString(1);
				String so_code_tmp = myRes.getString(2);
				String so_number_tmp = myRes.getString(3);
				String customer_code_tmp = myRes.getString(4);
				String customer_name_tmp = myRes.getString(5);
				String project_tmp = myRes.getString(6);
				String tot_val_tmp = myRes.getString(7);
				String sbudget_val_tmp = myRes.getString(8);
				String profit_amount_tmp = myRes.getString(9);
				String profit_perc_tmp = myRes.getString(10);
				String so_margin_tmp = myRes.getString(11);
				String so_tol_tmp = myRes.getString(12);
				String mail_fst_tmp = myRes.getString(13);
				String mail_scnd_tmp = myRes.getString(14);
				String create_dtime_tmp = myRes.getString(15);
				String sob_margin_tmp = myRes.getString(16);
				String sob_tol_tmp = myRes.getString(17);
				String so_aprv_status_temp = myRes.getString(18);
				String seg_code_tmp = myRes.getString(19);
				String seg_name_tmp = myRes.getString(20);
				String so_term_tmp = myRes.getString(21);

				SalesOrder_Budget tempsoList = new SalesOrder_Budget(sys_id_tmp, so_number_tmp, so_code_tmp,
						customer_code_tmp, customer_name_tmp, so_term_tmp, project_tmp, tot_val_tmp, sbudget_val_tmp,
						profit_amount_tmp, profit_perc_tmp, so_margin_tmp, so_tol_tmp, mail_fst_tmp, mail_scnd_tmp,
						create_dtime_tmp, sob_margin_tmp, sob_tol_tmp, so_aprv_status_temp, seg_code_tmp, seg_name_tmp,
						getSoBdgExpencDtls(sys_id_tmp));

				soUnUpdatedList.add(tempsoList);
			}

			return soUnUpdatedList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SalesOrder_Budget> getSoBdgExpencDtls(String sob_id) throws SQLException {
		// function to fetch sales order budget expense details by SO SYS ID
		List<SalesOrder_Budget> budgetExpencDtls = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT SOBD_EXP_HEAD,SOBD_EXP_DESC,SOBD_EXP_BDG_AMT  FROM  SO_BDG_APPR_DET WHERE SOBD_SOH_SYS_ID = ? AND SOBD_EXP_BDG_AMT > 0  "
					+ " ORDER BY SOBD_EXP_HEAD ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sob_id);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String bdg_expnc_ttl = myRes.getString(1);
				String bdg_expnc_desc = myRes.getString(2);
				String bdg_expnc_amount = myRes.getString(3);

				SalesOrder_Budget tempsoList = new SalesOrder_Budget(bdg_expnc_ttl, bdg_expnc_desc, bdg_expnc_amount);

				budgetExpencDtls.add(tempsoList);

			}

		} catch (SQLException e) {
			System.out.println("Exception in BudgetApprovalDbUtil.getSoBdgExpencDtls " + sob_id);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, null);
			orcl.closeConnection();
		}
		return budgetExpencDtls;
	}

	public SalesOrder_Budget getSoDetailsForReplyMail(String sob_id) throws SQLException {
		// function to fetch sales order budget expense details by SO SYS ID

		SalesOrder_Budget mailreplyDtls = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT SOB_QTN_CODE,SOB_QTN_NO,SOB_APPR_DT,SOB_SM_EMAIL,"
					+ "SOB_CUST_CODE, SOB_CUST_NAME,SOB_PROJ,  "
					+ "SOB_TOT_QTN_AMT, SOB_TOT_BDGT_AMT, SOB_GROSS_PROFIT_AMT, SOB_BUDG_PROF_PERC,  "
					+ " SOB_SM_CODE,SOB_SM_NAME,SOB_TERM " + "  FROM  LOI_BDG_APPR  WHERE SOB_CQH_SYS_ID = ?  ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sob_id);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String so_code = myRes.getString(1);
				String so_no = myRes.getString(2);
				String so_apprvd_date = myRes.getString(3);
				String replyMail_ids = myRes.getString(4);
				String customer_code_tmp = myRes.getString(5);
				String customer_name_tmp = myRes.getString(6);
				String project_tmp = myRes.getString(7);
				String tot_val_tmp = myRes.getString(8);
				String sbudget_val_tmp = myRes.getString(9);
				String profit_amount_tmp = myRes.getString(10);
				String profit_perc_tmp = myRes.getString(11);
				String seg_code_tmp = myRes.getString(12);
				String seg_name_tmp = myRes.getString(13);
				String so_term_tmp = myRes.getString(14);

				mailreplyDtls = new SalesOrder_Budget(so_code, so_no, so_apprvd_date, replyMail_ids, customer_code_tmp,
						customer_name_tmp, project_tmp, tot_val_tmp, sbudget_val_tmp, profit_amount_tmp,
						profit_perc_tmp, seg_code_tmp, seg_name_tmp, so_term_tmp);

			}

			return mailreplyDtls;

		} finally {
			// close jdbc objects
			close(myStmt, null);
			orcl.closeConnection();
		}
	}

	public int sendApprovalOrRejectStatusReplyMail(String so_id, String aprvRjctStatusMsg) throws SQLException {
		LocalDateTime fjaprvDateObj = LocalDateTime.now();
		DateTimeFormatter fjaprvDateFormatObj = DateTimeFormatter.ofPattern("E, MMM dd yyyy HH:mm:ss");
		// int val=1;
		LOIBudgetReplyMailer sslmail = new LOIBudgetReplyMailer();
		// sslmail.setCheckMailRequestForFjAprvRepMil(val);
		// System.out.println("test reply mail function or not started: "+val);

		String msg = "";
		String titleStatus = "";
		String mailToAddress = "";
		String mailCCAddress = "";
		String approved_date = "";

		SalesOrder_Budget mailreplyDetails = getSoDetailsForReplyMail(so_id);

		if (mailreplyDetails.getReply_mail_ids().contains(";")) {
			String[] mailIdSplit = mailreplyDetails.getReply_mail_ids().split(";");
			int noOfmailIds = mailIdSplit.length;
			System.out.println("count : " + noOfmailIds);
			mailToAddress = mailIdSplit[0];
			if (noOfmailIds > 2) {// to handle multiple CC address
				mailIdSplit = Arrays.copyOfRange(mailIdSplit, 1, mailIdSplit.length);
				mailCCAddress = String.join(",", mailIdSplit);

			} else {
				mailCCAddress = mailIdSplit[1];
			}

			System.out.println("sales Egr: Mail(1-TO) : " + mailToAddress);
			System.out.println("SO Submitter Mail(2-CC) : " + mailCCAddress);
		} else {
			mailToAddress = mailreplyDetails.getReply_mail_ids();
			System.out.println(" sales Egr: Mail(1-To) : " + mailToAddress);
			System.out.println(" SO Submitter Mail(No-CC) : " + mailCCAddress);
		}

		approved_date = mailreplyDetails.getSo_apprvd_date().substring(0, 16);

		// System.out.println("MAil Reply Details so
		// code"+mailreplyDetails.getSo_code());
		// System.out.println("MAil Reply Details so
		// number"+mailreplyDetails.getSo_number());
		// System.out.println("MAil Reply Details so reoly mails
		// "+mailreplyDetails.getReply_mail_ids());
		// System.out.println("MAil Reply Details so date
		// "+mailreplyDetails.getSo_apprvd_date().substring(0, 16));

		if (aprvRjctStatusMsg.equals("Y")) {
			titleStatus = "Approved";
			msg = " <table>" + "<tr><td><b>Quotation No</b></td><td> <b>:</b> </td><td> "
					+ mailreplyDetails.getSo_code() + "-" + mailreplyDetails.getSo_number() + "</td></tr>"
					+ "<tr><td><b>Customer Code </b> </td><td><b> :</b> </td><td>" + mailreplyDetails.getCustomer_code()
					+ " </td></tr>" + "<tr><td><b>Customer Name  </b> </td><td><b> :</b> </td><td>"
					+ mailreplyDetails.getCustomer_name() + " </td></tr>"
					+ "<tr><td><b>Payment Term  </b> </td><td><b> :</b> </td><td>" + mailreplyDetails.getSo_term()
					+ " </td></tr>"
					+ "<tr><td><b>Project  </b> </td><td><b> :</b> </td><td>  <span style=\"color:#0089cd;font-weight: bold;\"> "
					+ mailreplyDetails.getProject() + "  </span></td></tr>"
					+ "<tr><td><b>Sales Engineer  </b> </td><td><b> :</b> </td><td>  <span style=\"color:#0089cd;font-weight: bold;\"> "
					+ mailreplyDetails.getSe_code() + " - " + mailreplyDetails.getSe_name() + "  </span></td></tr>"
					+ "<tr><td colspan=\"2\"><br/>Has been  <strong style=\"color:green;\">Approved</strong>   on "
					+ approved_date + " .</td></tr>" + "</table>";
		} else {
			titleStatus = "Rejected";
			msg = " <table>" + "<tr><td><b>Quotation No</b></td><td> <b>:</b> </td><td> "
					+ mailreplyDetails.getSo_code() + "-" + mailreplyDetails.getSo_number() + "</td></tr>"
					+ "<tr><td><b>Customer Code </b> </td><td><b> :</b> </td><td>" + mailreplyDetails.getCustomer_code()
					+ " </td></tr>" + "<tr><td><b>Customer Name  </b> </td><td><b> :</b> </td><td>"
					+ mailreplyDetails.getCustomer_name() + " </td></tr>"
					+ "<tr><td><b>Payment Term  </b> </td><td><b> :</b> </td><td>" + mailreplyDetails.getSo_term()
					+ " </td></tr>"
					+ "<tr><td><b>Project  </b> </td><td><b> :</b> </td><td>  <span style=\"color:#0089cd;font-weight: bold;\"> "
					+ mailreplyDetails.getProject() + "  </span></td></tr>"
					+ "<tr><td><b>Sales Engineer  </b> </td><td><b> :</b> </td><td>  <span style=\"color:#0089cd;font-weight: bold;\"> "
					+ mailreplyDetails.getSe_code() + " - " + mailreplyDetails.getSe_name() + "  </span></td></tr>"
					+ "<tr><td colspan=\"2\"><br/>Has been  <strong style=\"color:red;\">Rejected</strong>   on "
					+ approved_date + " .</td></tr>" + "</table>";
		}
		sslmail.setToaddr(mailToAddress);
		sslmail.setCcaddr(mailCCAddress);
		sslmail.setMessageSub("LOI Budget Sheet  " + mailreplyDetails.getSo_code() + " - "
				+ mailreplyDetails.getSo_number() + " " + titleStatus + " .");
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Sales engineer and Secretrary.  " + mailreplyDetails.getSo_code()
					+ " - " + mailreplyDetails.getSo_number() + " is " + titleStatus + " at"
					+ fjaprvDateObj.format(fjaprvDateFormatObj) + "  GST ... Status : " + status);
			return status;
		} else {
			System.out.print("SO Budget Sheet  Reply Mail " + mailreplyDetails.getSo_code() + " - "
					+ mailreplyDetails.getSo_number() + " is " + titleStatus + " .Send mail Successfully at "
					+ fjaprvDateObj.format(fjaprvDateFormatObj) + " GST . Status : " + status);
			return status;
		}
	}
}
