package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import beans.CustomerVisit;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.SSLMail;
import beans.SipJihDues;
import beans.SipStageFollowUp;
import beans.fjtcouser;

public class SipStageFollowpDbUtil {
	public List<SipStageFollowUp> getFilterList() throws SQLException {
		List<SipStageFollowUp> statusList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT STATUS, STAGE, FILTER, STYLE " + " FROM FJPORTAL.SIP_STAGE_FILTERS "
					+ "WHERE ACTIVE_YN = ? order by DISPLAYORDER,STATUS ASC";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "Y");
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String status = myRes.getString(1);
				int stage = myRes.getInt(2);
				String filter = myRes.getString(3);
				String style = myRes.getString(4);
				SipStageFollowUp tempstatusList = new SipStageFollowUp(status, stage, filter, style);
				statusList.add(tempstatusList);
			}
			return statusList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipStageFollowUp> getStatusList() throws SQLException {
		List<SipStageFollowUp> statusList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT STATUS, STAGE " + " FROM SIP_STAGE_STATUS " + "WHERE ACTIVE_YN = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "Y");
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String status = myRes.getString(1);
				int stage = myRes.getInt(2);

				SipStageFollowUp tempstatusList = new SipStageFollowUp(status, stage);
				statusList.add(tempstatusList);
			}
			return statusList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipStageFollowUp> getPriorityList() throws SQLException {
		List<SipStageFollowUp> priorityList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  STAGE, PRIORITY " + " FROM SIP_STAGE_PRIORITY " + "WHERE ACTIVE_YN = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "Y");
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int stage = myRes.getInt(1);
				String priority = myRes.getString(2);
				SipStageFollowUp temppriorityList = new SipStageFollowUp(stage, priority);
				priorityList.add(temppriorityList);
			}
			return priorityList;
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

	public String checkFilterValue(String filter) {

		if (filter == null || filter.isEmpty()) {
			filter = "-";
		}
		// System.out.println("Filter "+filter);
		return filter;

	};

	public List<SipStageFollowUp> getStage2Details(String seCode, String status, String priority,
			String consultantwinning, String contractortwinning, String searchremarks, String totalwinning,
			String amountgreaterthan) throws SQLException {
		List<SipStageFollowUp> stageList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String formattedsearchremarks = null;
		try {
			myCon = orcl.getOrclConn();
			status = checkFilterValue(status);
			priority = checkFilterValue(priority);
			consultantwinning = checkFilterValue(consultantwinning);
			contractortwinning = checkFilterValue(contractortwinning);
			totalwinning = checkFilterValue(totalwinning);
			searchremarks = checkFilterValue(searchremarks);
			amountgreaterthan = checkFilterValue(amountgreaterthan);

			if (!searchremarks.equalsIgnoreCase("-")) {
				formattedsearchremarks = "%" + searchremarks + "%";
			}
			StringBuilder sqlQuery = new StringBuilder(
					"SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST2.CQHSYSID) REMINDERCNT,  "
							+ " EXP_LOI_DT, SALESWIN,SUB_STATUS_CODE,APPR_CONS 	 FROM FJT_SM_STG2_TBL ST2 WHERE  SALES_EGR_CODE  IN ("
							+ seCode + ")  ");
			int counter = 1;
			if (!priority.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND   QTN_PRI =   ? ");
			}
			if (!status.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND QTN_STAT =   ? ");
			}
			if (!consultantwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND CONSULTANTWIN IN (?) ");
			}
			if (!contractortwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND CONTRACTORWIN IN  (?) ");
			}
			if (!totalwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND TOTALWIN IN  (?) ");
			}
			if (!searchremarks.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND UPPER(QTN_REMARKS) LIKE UPPER(?)  ");
			}
			if (!amountgreaterthan.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND QTN_AMOUNT >= (?)  ");
			}
			sqlQuery.append(
					" AND NVL(LH_STATUS,'W') <> 'L'  AND  LOI_AMT IS NULL AND LOI_DT IS NULL AND CQHSYSID NOT IN ( SELECT DISTINCT CQHSYSID FROM FJT_SM_STG3_TBL)");

			myStmt = myCon.prepareStatement(sqlQuery.toString());

			if (!priority.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, priority);
			}
			if (!status.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, status);

			}
			if (!consultantwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, consultantwinning);
			}
			if (!contractortwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, contractortwinning);
			}
			if (!totalwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, totalwinning);
			}
			if (!searchremarks.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, formattedsearchremarks);
			}
			if (!amountgreaterthan.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, amountgreaterthan);
			}
			/*
			 * if (status.equalsIgnoreCase("-") && !priority.equalsIgnoreCase("-")) { String
			 * sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST2.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG2_TBL ST2 " + "WHERE  SALES_EGR_CODE  IN ( " + seCode +
			 * "   )   AND   QTN_PRI =   ?  AND NVL(LH_STATUS,'W') <> 'L' AND  CQHSYSID NOT IN ( SELECT DISTINCT CQHSYSID FROM FJT_SM_STG3_TBL)  "
			 * ; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, priority); } else
			 * if (!status.equalsIgnoreCase("-") && priority.equalsIgnoreCase("-")) { String
			 * sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST2.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG2_TBL ST2 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )  AND QTN_STAT =   ? AND NVL(LH_STATUS,'W') <> 'L'  AND  CQHSYSID NOT IN ( SELECT DISTINCT CQHSYSID FROM FJT_SM_STG3_TBL)  "
			 * ; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, status); } else
			 * if (!status.equalsIgnoreCase("-") && !priority.equalsIgnoreCase("-")) {
			 * String sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST2.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG2_TBL ST2 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )   AND QTN_STAT =   ? AND   QTN_PRI =   ? AND NVL(LH_STATUS,'W') <> 'L' AND  CQHSYSID NOT IN ( SELECT DISTINCT CQHSYSID FROM FJT_SM_STG3_TBL) "
			 * ; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, status);
			 * myStmt.setString(2, priority); } else { String sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST2.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG2_TBL ST2 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )  AND NVL(LH_STATUS,'W') <> 'L'  AND  CQHSYSID NOT IN ( SELECT DISTINCT CQHSYSID FROM FJT_SM_STG3_TBL)  "
			 * ; myStmt = myCon.prepareStatement(sql); }
			 */
			System.out.println(sqlQuery);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String expLOIDate = "";
				String id = myRes.getString(1);
				String se_code = myRes.getString(2);
				String se_name = myRes.getString(3);
				String qtnDt = myRes.getString(4);
				String qtnCode = myRes.getString(5);
				String qtnNo = myRes.getString(6);
				String custName = myRes.getString(7);
				String projName = myRes.getString(8);
				String consultant = myRes.getString(9);
				double amount = myRes.getDouble(10);
				String priorityOrg = myRes.getString(11);
				String statusOrg = myRes.getString(12);
				String remarks = myRes.getString(13);
				String updatedBy = myRes.getString(14);
				String updatedOn = myRes.getString(15);
				int consltWin = myRes.getInt(16);
				int contractorWin = myRes.getInt(17);
				int totalWin = myRes.getInt(18);
				int reminderCount = myRes.getInt(19);
				if (myRes.getString(20) != null) {
					expLOIDate = formatDate(myRes.getString(20));
				}
				String sewinper = myRes.getString(21);
				String submittalcode = myRes.getString(22);
				String isApproved = myRes.getString(23);
				SipStageFollowUp tempstageList = new SipStageFollowUp(id, se_code, se_name, qtnDt, qtnCode, qtnNo,
						custName, projName, consultant, amount, priorityOrg, statusOrg, remarks, updatedBy, updatedOn,
						reminderCount, consltWin, contractorWin, totalWin, expLOIDate, sewinper, submittalcode,
						isApproved);
				stageList.add(tempstageList);
			}
			return stageList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipStageFollowUp> getStage3Details(String seCode, String status, String priority,
			String consultantwinning, String contractortwinning, String totalwinning, String amountgreaterthan)
			throws SQLException {
		List<SipStageFollowUp> stageList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			status = checkFilterValue(status);
			priority = checkFilterValue(priority);
			consultantwinning = checkFilterValue(consultantwinning);
			contractortwinning = checkFilterValue(contractortwinning);
			totalwinning = checkFilterValue(totalwinning);
			amountgreaterthan = checkFilterValue(amountgreaterthan);
			StringBuilder sqlQuery = new StringBuilder(
					"SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT,EXP_PO_DT,EXP_INV_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST3.CQHSYSID) REMINDERCNT,  "
							+ "	EXP_ORD_DT, SALESWIN FROM FJT_SM_STG3_TBL ST3  WHERE  SALES_EGR_CODE IN ( " + seCode
							+ ")  ");
			int counter = 1;
			if (!priority.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND   QTN_PRI =   ? ");
			}
			if (!status.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND QTN_STAT =   ? ");
			}
			if (!consultantwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND CONSULTANTWIN IN (?) ");
			}
			if (!contractortwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND CONTRACTORWIN IN  (?) ");
			}
			if (!totalwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND TOTALWIN IN  (?) ");
			}
			if (!amountgreaterthan.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND QTN_AMOUNT >= (?)  ");
			}
			sqlQuery.append(
					" AND NVL(LH_STATUS,'W') <> 'L'  AND  CQHSYSID NOT IN (SELECT SOH_SYS_ID  FROM FJT_SM_STG4_TBL) ");
			myStmt = myCon.prepareStatement(sqlQuery.toString());

			if (!priority.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, priority);
			}
			if (!status.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, status);

			}
			if (!consultantwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, consultantwinning);
			}
			if (!contractortwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, contractortwinning);
			}
			if (!totalwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, totalwinning);
			}
			if (!amountgreaterthan.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, amountgreaterthan);
			}
			/*
			 * if (status.equalsIgnoreCase("-") && !priority.equalsIgnoreCase("-")) { String
			 * sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT,EXP_PO_DT,EXP_INV_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST3.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG3_TBL ST3 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )    AND   QTN_PRI =   ? AND NVL(LH_STATUS,'W') <> 'L' AND  CQHSYSID NOT IN (SELECT SOH_SYS_ID  FROM FJT_SM_STG4_TBL) "
			 * ; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, priority); } else
			 * if (!status.equalsIgnoreCase("-") && priority.equalsIgnoreCase("-")) { String
			 * sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT,EXP_PO_DT,EXP_INV_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST3.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG3_TBL ST3 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )  AND QTN_STAT =   ? AND NVL(LH_STATUS,'W') <> 'L' AND  CQHSYSID NOT IN (SELECT SOH_SYS_ID  FROM FJT_SM_STG4_TBL) "
			 * ; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, status); } else
			 * if (!status.equalsIgnoreCase("-") && !priority.equalsIgnoreCase("-")) {
			 * String sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT,EXP_PO_DT,EXP_INV_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST3.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG3_TBL ST3 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )  AND QTN_STAT =   ? AND   QTN_PRI =   ? AND NVL(LH_STATUS,'W') <> 'L' AND  CQHSYSID NOT IN (SELECT SOH_SYS_ID  FROM FJT_SM_STG4_TBL) "
			 * ; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, status);
			 * myStmt.setString(2, priority); } else { String sql =
			 * "SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT,EXP_PO_DT,EXP_INV_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST3.CQHSYSID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG3_TBL ST3 " + "WHERE  SALES_EGR_CODE IN ( " + seCode +
			 * "   )   AND NVL(LH_STATUS,'W') <> 'L' AND  CQHSYSID NOT IN (SELECT SOH_SYS_ID  FROM FJT_SM_STG4_TBL) "
			 * ; myStmt = myCon.prepareStatement(sql); }
			 */
			System.out.println("sqlQuery" + sqlQuery);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String expODate = "";
				String id = myRes.getString(1);
				String se_code = myRes.getString(2);
				String se_name = myRes.getString(3);
				String qtnDt = myRes.getString(4);
				String qtnCode = myRes.getString(5);
				String qtnNo = myRes.getString(6);
				String custName = myRes.getString(7);
				String projName = myRes.getString(8);
				String consultant = myRes.getString(9);
				double amount = myRes.getDouble(10);
				String priorityOrg = myRes.getString(11);
				String statusOrg = myRes.getString(12);
				String remarks = myRes.getString(13);
				String updatedBy = myRes.getString(14);
				String updatedOn = myRes.getString(15);
				String poDate = null, invoiceDate = null;
				if (myRes.getString(16) != null) {
					poDate = formatDate(myRes.getString(16));
				}
				if (myRes.getString(17) != null) {
					invoiceDate = formatDate(myRes.getString(17));
				}
				int consltWin = myRes.getInt(18);
				int contractorWin = myRes.getInt(19);
				int totalWin = myRes.getInt(20);
				int reminderCount = myRes.getInt(21);
				if (myRes.getString(22) != null) {
					expODate = formatDate(myRes.getString(22));
				}
				String sewinper = myRes.getString(23);
				SipStageFollowUp tempstageList = new SipStageFollowUp(id, se_code, se_name, qtnDt, qtnCode, qtnNo,
						custName, projName, consultant, amount, priorityOrg, statusOrg, remarks, updatedBy, updatedOn,
						poDate, invoiceDate, reminderCount, consltWin, contractorWin, totalWin, expODate, sewinper);
				stageList.add(tempstageList);
			}
			return stageList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipStageFollowUp> getStage4Details(String seCode, String etaMonth, String material, String payment,
			String readiness, String amountgreaterthan) throws SQLException {
		List<SipStageFollowUp> stageList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			etaMonth = checkFilterValue(etaMonth);
			material = checkFilterValue(material);
			payment = checkFilterValue(payment);
			readiness = checkFilterValue(readiness);
			amountgreaterthan = checkFilterValue(amountgreaterthan);

			String sql1 = "( "
					+ " SELECT  SOH_SYS_ID, SOH_SM_CODE, SALES_ENG, SO_DT, SO_TXN_CODE, SO_NO, CUSTOMER, PROJECT, CONSULTANT, BALANCE_VALUE,  SOH_DEL_DT, ITEM_CODE, SO_ITEM_DESC, SO_UOM, BALANCE_QTY, "
					+ " MATSTAT, PAYSTAT, READY, BILLSTAT, MODBY, MODDT, SOI_SYS_ID  ,HEADDET , (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST4.SOH_SYS_ID) REMINDERCNT,EXP_BILL_DT  "
					+ "  FROM FJT_SM_STG4_TBL ST4 WHERE SOH_SM_CODE IN ( " + seCode + "   )  "
					+ " AND SOH_SYS_ID IN ( SELECT SOH_SYS_ID FROM AKM_SUPP_PEND_SO_TBL) "// commenting as we not sure
					// why this was put.bcz of this, data mismatch from stage details to here
					+ "AND ( ";
			String sql2 = "  ) AND (HEADDET = 'HEADER' OR HEADDET = 'DETAIL')"
					+ " ) ORDER BY SOH_SYS_ID DESC, SO_ITEM_DESC DESC ";
			String sqlCondition = " 1=1 ";

			if (!material.equalsIgnoreCase("-"))
				sqlCondition = sqlCondition + " AND NVL(MATSTAT,'-')  = ?";

			if (!payment.equalsIgnoreCase("-"))
				sqlCondition = sqlCondition + " AND NVL(PAYSTAT,'-')  = ?";

			if (!readiness.equalsIgnoreCase("-"))
				sqlCondition = sqlCondition + " AND NVL(READY,'-')  = ?";

			if (!etaMonth.equalsIgnoreCase("-"))
				sqlCondition = sqlCondition + " AND NVL(DEL_MTH,'-')  = ?";

			if (amountgreaterthan != null && !amountgreaterthan.equalsIgnoreCase("-"))
				sqlCondition = sqlCondition + " AND BALANCE_VALUE >  = ?";

			myStmt = myCon.prepareStatement(sql1 + sqlCondition + sql2);
			System.out.println("query " + sql1 + sqlCondition + sql2);
			int paramCount = 1;

			if (!material.equalsIgnoreCase("-"))
				myStmt.setString(paramCount++, material);

			if (!payment.equalsIgnoreCase("-"))
				myStmt.setString(paramCount++, payment);

			if (!readiness.equalsIgnoreCase("-"))
				myStmt.setString(paramCount++, readiness);

			if (!etaMonth.equalsIgnoreCase("-"))
				myStmt.setString(paramCount++, etaMonth);

			if (amountgreaterthan != null && !amountgreaterthan.equalsIgnoreCase("-"))
				myStmt.setString(paramCount++, amountgreaterthan);

			/*
			 * String sql1 = "( " +
			 * " SELECT  SOH_SYS_ID, SOH_SM_CODE, SALES_ENG, SO_DT, SO_TXN_CODE, SO_NO, CUSTOMER, PROJECT, CONSULTANT, BALANCE_VALUE,  SOH_DEL_DT, ITEM_CODE, SO_ITEM_DESC, SO_UOM, BALANCE_QTY, "
			 * +
			 * " MATSTAT, PAYSTAT, READY, BILLSTAT, MODBY, MODDT, SOI_SYS_ID  ,HEADDET , (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST4.SOH_SYS_ID) REMINDERCNT  "
			 * + "  FROM FJT_SM_STG4_TBL ST4 WHERE SOH_SYS_ID IN  ( " +
			 * "  SELECT  SOH_SYS_ID FROM FJT_SM_STG4_TBL " + "  WHERE SOH_SM_CODE IN ( " +
			 * seCode + "   )  AND NVL(BILLSTAT,'PENDING') <> 'COMPLETED' AND ( "; String
			 * sql2 = " ) ) AND HEADDET = 'HEADER' " + " ) UNION "; String sql3 = " (" +
			 * "	 SELECT  SOH_SYS_ID, SOH_SM_CODE, SALES_ENG, SO_DT, SO_TXN_CODE, SO_NO, CUSTOMER, PROJECT, CONSULTANT, BALANCE_VALUE,  SOH_DEL_DT, ITEM_CODE, SO_ITEM_DESC, SO_UOM, BALANCE_QTY, "
			 * +
			 * " MATSTAT, PAYSTAT, READY, BILLSTAT, MODBY, MODDT, SOI_SYS_ID  ,HEADDET , (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST4.SOH_SYS_ID) REMINDERCNT  "
			 * + " FROM FJT_SM_STG4_TBL ST4 " + " WHERE SOH_SM_CODE IN ( " + seCode +
			 * "   )  AND NVL(BILLSTAT,'PENDING') <> 'COMPLETED' AND ("; String sql4 =
			 * " AND HEADDET = 'DETAIL'" +
			 * " )) ORDER BY SOH_SYS_ID DESC, SO_ITEM_DESC DESC ";
			 * 
			 * if (!material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-") &&
			 * !readiness.equalsIgnoreCase("-") && !etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition =
			 * "    NVL(MATSTAT,'-')  = ? AND  NVL(PAYSTAT,'-')  = ? AND NVL(READY,'-')  = ? AND NVL(DEL_MTH,'-')  = ?    "
			 * ; String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, material); myStmt.setString(2, payment);
			 * myStmt.setString(3, readiness); myStmt.setString(4, etaMonth);
			 * myStmt.setString(5, material); myStmt.setString(6, payment);
			 * myStmt.setString(7, readiness); myStmt.setString(8, etaMonth);
			 * 
			 * } else if (!material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-")
			 * && !readiness.equalsIgnoreCase("-") && etaMonth.equalsIgnoreCase("-")) {
			 * String sqlCondition =
			 * "   NVL(MATSTAT,'-')  = ? AND  NVL(PAYSTAT,'-')  = ? AND NVL(READY,'-')  = ?  "
			 * ; String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, material); myStmt.setString(2, payment);
			 * myStmt.setString(3, readiness); myStmt.setString(4, material);
			 * myStmt.setString(5, payment); myStmt.setString(6, readiness); } else if
			 * (!material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-") &&
			 * readiness.equalsIgnoreCase("-") && !etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition =
			 * "   NVL(MATSTAT,'-')  = ? AND  NVL(PAYSTAT,'-')  = ? AND NVL(DEL_MTH,'-')  = ? "
			 * ; String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, material); myStmt.setString(2, payment);
			 * myStmt.setString(3, etaMonth); myStmt.setString(4, material);
			 * myStmt.setString(5, payment); myStmt.setString(6, etaMonth); } else if
			 * (material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-") &&
			 * !readiness.equalsIgnoreCase("-") && !etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition =
			 * "   NVL(PAYSTAT,'-')  = ? AND  NVL(READY,'-')  = ? AND NVL(DEL_MTH,'-')  = ? "
			 * ; String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, payment); myStmt.setString(2, readiness);
			 * myStmt.setString(3, etaMonth); myStmt.setString(4, payment);
			 * myStmt.setString(5, readiness); myStmt.setString(6, etaMonth); } else if
			 * (!material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-") &&
			 * readiness.equalsIgnoreCase("-") && etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "   NVL(MATSTAT,'-')  = ? AND  NVL(PAYSTAT,'-')  = ?   ";
			 * String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, material); myStmt.setString(2, payment);
			 * myStmt.setString(3, material); myStmt.setString(4, payment); } else if
			 * (!material.equalsIgnoreCase("-") && payment.equalsIgnoreCase("-") &&
			 * !readiness.equalsIgnoreCase("-") && etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "    NVL(MATSTAT,'-')  = ? AND  NVL(READY,'-')  = ?"; String
			 * sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, material); myStmt.setString(2, readiness);
			 * myStmt.setString(3, material); myStmt.setString(4, readiness); } else if
			 * (!material.equalsIgnoreCase("-") && payment.equalsIgnoreCase("-") &&
			 * readiness.equalsIgnoreCase("-") && !etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "   NVL(MATSTAT,'-')  = ? AND  NVL(DEL_MTH,'-')  = ?   ";
			 * String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, material); myStmt.setString(2, etaMonth);
			 * myStmt.setString(3, material); myStmt.setString(4, etaMonth); } else if
			 * (material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-") &&
			 * !readiness.equalsIgnoreCase("-") && etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "   NVL(PAYSTAT,'-')  = ? AND  NVL(READY,'-')  = ? "; String
			 * sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, payment); myStmt.setString(2, readiness);
			 * myStmt.setString(3, payment); myStmt.setString(4, readiness); } else if
			 * (material.equalsIgnoreCase("-") && !payment.equalsIgnoreCase("-") &&
			 * readiness.equalsIgnoreCase("-") && !etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "   NVL(PAYSTAT,'-')  = ? AND  NVL(DEL_MTH,'-')  = ?   ";
			 * String sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, payment); myStmt.setString(2, etaMonth);
			 * myStmt.setString(3, payment); myStmt.setString(4, etaMonth); } else if
			 * (material.equalsIgnoreCase("-") && payment.equalsIgnoreCase("-") &&
			 * !readiness.equalsIgnoreCase("-") && !etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "   NVL(READY,'-')  = ? AND  NVL(DEL_MTH,'-')  = ?  "; String
			 * sql = sql1 + " " + sqlCondition + " " + sql2 + " " + sql3 + " " +
			 * sqlCondition + " " + sql4 + " "; myStmt = myCon.prepareStatement(sql);
			 * myStmt.setString(1, readiness); myStmt.setString(2, etaMonth);
			 * myStmt.setString(3, readiness); myStmt.setString(4, etaMonth); } else if
			 * (!material.equalsIgnoreCase("-") && payment.equalsIgnoreCase("-") &&
			 * readiness.equalsIgnoreCase("-") && etaMonth.equalsIgnoreCase("-")) { String
			 * sqlCondition = "   NVL(MATSTAT,'-')  = ? "; String sql = sql1 + " " +
			 * sqlCondition + " " + sql2 + " " + sql3 + " " + sqlCondition + " " + sql4 +
			 * " "; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, material);
			 * myStmt.setString(2, material); } else if (material.equalsIgnoreCase("-") &&
			 * !payment.equalsIgnoreCase("-") && readiness.equalsIgnoreCase("-") &&
			 * etaMonth.equalsIgnoreCase("-")) { String sqlCondition =
			 * "   NVL(PAYSTAT,'-')  = ?  "; String sql = sql1 + " " + sqlCondition + " " +
			 * sql2 + " " + sql3 + " " + sqlCondition + " " + sql4 + " "; myStmt =
			 * myCon.prepareStatement(sql); myStmt.setString(1, payment);
			 * myStmt.setString(2, payment); } else if (material.equalsIgnoreCase("-") &&
			 * payment.equalsIgnoreCase("-") && !readiness.equalsIgnoreCase("-") &&
			 * etaMonth.equalsIgnoreCase("-")) { String sqlCondition =
			 * "   NVL(READY,'-')  = ? "; String sql = sql1 + " " + sqlCondition + " " +
			 * sql2 + " " + sql3 + " " + sqlCondition + " " + sql4 + " "; myStmt =
			 * myCon.prepareStatement(sql); myStmt.setString(1, readiness);
			 * myStmt.setString(2, readiness); } else if (material.equalsIgnoreCase("-") &&
			 * payment.equalsIgnoreCase("-") && readiness.equalsIgnoreCase("-") &&
			 * !etaMonth.equalsIgnoreCase("-") && !amountgreaterthan.equalsIgnoreCase("-"))
			 * { String sqlCondition = "  NVL(DEL_MTH,'-')  = ? "; String sql = sql1 + " " +
			 * sqlCondition + " " + sql2 + " " + sql3 + " " + sqlCondition + " " + sql4 +
			 * " "; myStmt = myCon.prepareStatement(sql); myStmt.setString(1, etaMonth);
			 * myStmt.setString(2, etaMonth); } else { String sqlCondition =
			 * "   SOH_SYS_ID IS NOT NULL   "; String sql = sql1 + " " + sqlCondition + " "
			 * + sql2 + " " + sql3 + " " + sqlCondition + " " + sql4 + " ";
			 * System.out.println("sql in iff" + sql); myStmt = myCon.prepareStatement(sql);
			 * }
			 */

			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String id = myRes.getString(1);
				String se_code = myRes.getString(2);
				String se_name = myRes.getString(3);
				String soDt = myRes.getString(4);
				String soTxnCode = myRes.getString(5);
				String soNo = myRes.getString(6);
				String custName = myRes.getString(7);
				String projName = myRes.getString(8);
				String consultant = myRes.getString(9);
				String balanceValue = myRes.getString(10);
				String deliveryDate = myRes.getString(11);
				String itemCode = myRes.getString(12);
				String itemDesc = myRes.getString(13);
				String soUom = myRes.getString(14);
				String balanceQty = myRes.getString(15);
				String materialStatus = myRes.getString(16);
				String paymentStatus = myRes.getString(17);
				String readynessStatus = myRes.getString(18);
				String billStatus = myRes.getString(19);
				String updatedBy = myRes.getString(20);
				String updatedOn = myRes.getString(21);
				String itemId = myRes.getString(22);
				String type = myRes.getString(23);
				int reminderCount = myRes.getInt(24);
				String expBillingDate = "";
				if (myRes.getString(25) != null) {
					expBillingDate = formatDate(myRes.getString(25));
				}
				SipStageFollowUp tempstageList = new SipStageFollowUp(id, se_code, se_name, soDt, soTxnCode, soNo,
						custName, projName, consultant, balanceValue, deliveryDate, itemCode, itemDesc, soUom,
						balanceQty, materialStatus, paymentStatus, readynessStatus, billStatus, updatedBy, updatedOn,
						itemId, type, reminderCount, expBillingDate);

				stageList.add(tempstageList);
			}
			return stageList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int updateStage2Status(String seCode, String status, String priority, String remarks, String id,
			String sales_eng_Emp_code) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG2_TBL  "
					+ " SET QTN_PRI = ?, QTN_STAT = ?, QTN_REMARKS = ?, QTN_MOD_BY = ?, QTN_MOD_DT = SYSDATE, UPD_DT = SYSDATE "
					+ " WHERE  SALES_EGR_CODE = ? AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, priority);
			myStmt.setString(2, status);
			myStmt.setString(3, remarks);
			myStmt.setString(4, sales_eng_Emp_code);
			myStmt.setString(5, seCode);
			myStmt.setString(6, id);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of stage update for " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateJIHDeQtnStatus(String qtn_id, String reason, String saleEngEmpCode, String remarkType,
			String newStatus, fjtcouser fjtuser, String segSalesCode) throws SQLException {

		int logType = -2;
		int retval = 0;
		// String newStatus = "L";
		String mailSubject = "FJPortal-Quotation marked as Lost with reason - NOT IN VENDOR LIST";
		String text;
		if (newStatus.equals("L")) {
			text = "Marked as Lost by ";
		} else {
			text = "Marked as Hold by ";
		}
		String remarks = reason + ", " + text + saleEngEmpCode + " through FJPORTAL, updated on " + previousDay() + "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG2_TBL  "
					+ " SET LH_STATUS = ?, LH_REMARKS = ? , LHREMARKS_TYPE = ?, UPD_DT = SYSDATE "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, newStatus);
			myStmt.setString(2, remarks);
			myStmt.setString(3, remarkType);
			myStmt.setString(4, segSalesCode);
			myStmt.setString(5, qtn_id);
			logType = myStmt.executeUpdate();
			if (logType > 0) {
				if (newStatus.equals("L") && remarkType.equals("VL")) {
					SipJihDues sipJihdues = getJihDueDetailsForQuatation(segSalesCode, qtn_id);
					String consultant = getConsultantDetailsForQuatation(sipJihdues);
					if (consultant != null && (!consultant.equals("CS00552") && !consultant.equals("CS01643")
							&& !consultant.equals("CS01617") && !consultant.equals("CS01822")
							&& !consultant.equals("CS01928"))) {
						SSLMail sslmail = new SSLMail();
						String msg = getLostwithNotInVendorListMailBody(fjtuser, reason, sipJihdues);
						System.out.println("approver emailid -- " + fjtuser.getApproverId() + " logged inuser emaild--"
								+ fjtuser.getEmailid());
						sslmail.setToaddr(getMarketingTeamEmailId());
						sslmail.setCcaddr(fjtuser.getApproverId() + "," + fjtuser.getEmailid() + ","
								+ new MktSalesLeadsDbUtil().getDmEmailIdByEmpcode(fjtuser.getEmp_code()));
						sslmail.setMessageSub(mailSubject + " - " + fjtuser.getUname());
						sslmail.setMessagebody(msg);
						int status = sslmail.sendMail(fjtuser.getUrlAddress());
						if (status != 1) {
							System.out.print(
									"Error in sending Email when quotation was lost with not in vendor reason...");
							retval = -1;
						} else {
							System.out.print("sent when quotation was lost with not in vendor reason...");
							retval = 1;
						}
						// sending email to IT dept
						SSLMail sslmailtoIT = new SSLMail();
						String msg1 = getLostwithNotInVendorListMailBody(fjtuser, reason, sipJihdues);
						sslmailtoIT.setToaddr("arun@fjtco.com" + "," + "rajakumari.ch@fjtco.com");
						sslmailtoIT.setMessageSub(mailSubject + " - " + fjtuser.getUname());
						sslmailtoIT.setMessagebody(msg1);
						int status1 = sslmailtoIT.sendMail(fjtuser.getUrlAddress());
						if (status1 != 1) {
							System.out.print(
									"Error in sending Email when quotation was lost with not in vendor reason...");
							retval = -1;
						} else {
							System.out.print("sent when quotation was lost with not in vendor reason...");
							retval = 1;
						}
					}
				}
			}

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of qtn lost update for " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}

		return logType;

	}

	public int updateStage3Status(String seCode, String status, String priority, String remarks, String id,
			String sales_eng_Emp_code) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG3_TBL  "
					+ " SET QTN_PRI = ?, QTN_STAT = ?, QTN_REMARKS = ?, QTN_MOD_BY = ?, QTN_MOD_DT = SYSDATE , UPD_DT = SYSDATE "
					+ " WHERE  SALES_EGR_CODE = ? AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, priority);
			myStmt.setString(2, status);
			myStmt.setString(3, remarks);
			myStmt.setString(4, sales_eng_Emp_code);
			myStmt.setString(5, seCode);
			myStmt.setString(6, id);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of stage update for " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateStageRemarks(String seCode, String remarks, String id, String sales_eng_Emp_code) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();

			String sql = "UPDATE FJT_SM_STG1_TBL "
					+ "SET QTN_REMARKS = ?, QTN_MOD_BY = ?, QTN_MOD_DT = SYSDATE, UPD_DT = SYSDATE "
					+ "WHERE SALES_EGR_CODE = ? AND CQHSYSID = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, remarks);
			myStmt.setString(2, sales_eng_Emp_code);
			myStmt.setString(3, seCode);
			myStmt.setString(4, id);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of stage update for " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateStage4ItemsDetails(String seCode, String soId, String sales_eng_Emp_code,
			ArrayList<SipStageFollowUp> itemDetails) throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Iterator<SipStageFollowUp> iterator = itemDetails.iterator();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJPORTAL.FJT_SM_STG4_TBL  " + " SET "
					+ " SOH_DEL_DT = TO_DATE(?,'DD/MM/YYYY') , DEL_MTH = ?, " + " MATSTAT = ?, "
					+ " PAYSTAT = ?, READY = ?,  MODBY = ?, MODDT = SYSDATE  "
					+ " WHERE  SOH_SM_CODE = ? AND SOH_SYS_ID = ?  AND SOI_SYS_ID = ? ";

			myStmt = myCon.prepareStatement(sql);
			myCon.setAutoCommit(false);
			while (iterator.hasNext()) {
				SipStageFollowUp theItemData = (SipStageFollowUp) iterator.next();

				myStmt.setString(1, theItemData.getDeliveryDate());
				myStmt.setString(2, theItemData.getDeliveryDate().substring(3));
				myStmt.setString(3, theItemData.getMaterialStatus());
				myStmt.setString(4, theItemData.getPaymentStatus());
				myStmt.setString(5, theItemData.getReadynessStatus());
				myStmt.setString(6, sales_eng_Emp_code);
				myStmt.setString(7, seCode);
				myStmt.setString(8, soId);
				myStmt.setString(9, theItemData.getItemId());
				// System.out.println("ITEM "+theItemData.getItemId()+"
				// deliverydate"+theItemData.getDeliveryDate()+" material
				// "+theItemData.getMaterialStatus()+" ready
				// "+theItemData.getReadynessStatus());
				myStmt.addBatch();
				iterator.remove();
			}

			// logType = myStmt.executeUpdate();
			int[] affectedRecords = myStmt.executeBatch();
			myCon.commit();
			logType = affectedRecords.length;
		} catch (SQLException ex) {
			myCon.rollback();
			System.out.println("SQL Exception in closing DB resources at the time of stage 4 item update for " + soId);
			System.out.println("SQL Exception  " + ex);
		} catch (Exception ex) {
			myCon.rollback();
			System.out.println("Exception in closing DB resources at the time of stage 4 item update for " + soId);
			System.out.println("Exception  " + ex);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	private Date previousDay() {
		final Calendar cal = Calendar.getInstance();
		return cal.getTime();
	}

	public int updateJIHDeQtnStatusToHold(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode,
			String segSalesCode, int loiamount) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG2_TBL  " + " SET LOI_DT = ?, LOI_AMT = ?, UPD_DT = SYSDATE "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setInt(2, loiamount);
			myStmt.setString(3, segSalesCode);
			myStmt.setString(4, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of qtn lost update for " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateLOIQtnToLost(String qtn_id, String reason, String saleEngEmpCode, String remarkType,
			String newStatus, fjtcouser fjtuser, String segSalesCode) throws SQLException {

		int logType = -2;
		int retval = 0;
		String mailSubject = "FJPortal-Quotation marked as " + (newStatus.equals("L") ? "Lost" : "Hold");
		String text = newStatus.equals("L") ? "Marked as Lost by " : "Marked as Hold by ";
		String remarks = reason + ", " + text + saleEngEmpCode + " through FJPORTAL, updated on " + previousDay();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();

			String sql = "UPDATE FJT_SM_STG3_TBL SET LH_STATUS = ?, LH_REMARKS = ?, LHREMARKS_TYPE = ?, UPD_DT = SYSDATE "
					+ "WHERE SALES_EGR_CODE = ? AND CQHSYSID = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, newStatus);
			myStmt.setString(2, remarks);
			myStmt.setString(3, remarkType);
			myStmt.setString(4, segSalesCode);
			myStmt.setString(5, qtn_id);

// Debugging statements
			System.out.println("Executing SQL: " + sql);
			System.out.println("Parameters: [" + newStatus + ", " + remarks + ", " + remarkType + ", " + segSalesCode
					+ ", " + qtn_id + "]");

			logType = myStmt.executeUpdate();
			System.out.println("Update result: " + logType);

			if (logType == 0) {
				System.out.println("No rows were updated. Check the conditions and input parameters.");
			}

			if (newStatus.equals("L") && remarkType.equals("VL")) {
// Send email logic
				SipJihDues sipJihdues = getJihDueDetailsForQuatation(saleEngEmpCode, qtn_id);
				SSLMail sslmail = new SSLMail();
				String msg = getLostwithNotInVendorListMailBody(fjtuser, reason, sipJihdues);

				System.out.println("Sending email to marketing team...");
				sslmail.setToaddr(getMarketingTeamEmailId());
				sslmail.setCcaddr(fjtuser.getApproverId() + "," + fjtuser.getEmailid() + ","
						+ new MktSalesLeadsDbUtil().getDmEmailIdByEmpcode(fjtuser.getEmp_code()));
				sslmail.setMessageSub(mailSubject + " - " + fjtuser.getUname());
				sslmail.setMessagebody(msg);
				int status = sslmail.sendMail(fjtuser.getUrlAddress());

				if (status != 1) {
					System.out.print("Error in sending Email when quotation was lost with not in vendor reason...");
					retval = -1;
				} else {
					System.out.print("Email sent successfully when quotation was lost with not in vendor reason...");
					retval = 1;
				}

// sending email to IT dept
				SSLMail sslmailtoIT = new SSLMail();
				String msg1 = getLostwithNotInVendorListMailBody(fjtuser, reason, sipJihdues);
				sslmailtoIT.setToaddr("arun@fjtco.com, rajakumari.ch@fjtco.com");
				sslmailtoIT.setMessageSub(mailSubject + " - " + fjtuser.getUname());
				sslmailtoIT.setMessagebody(msg1);
				int status1 = sslmailtoIT.sendMail(fjtuser.getUrlAddress());

				if (status1 != 1) {
					System.out.print(
							"Error in sending Email to IT department when quotation was lost with not in vendor reason...");
					retval = -1;
				} else {
					System.out.print(
							"Email sent to IT department successfully when quotation was lost with not in vendor reason...");
					retval = 1;
				}
			}

		} catch (SQLException ex) {
			System.out.println("SQL Exception: " + ex.getMessage());
			ex.printStackTrace();
		} finally {
			close(myStmt, null);
			orcl.closeConnection();
		}

		return logType;
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

	public int updatePODate(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG3_TBL  " + " SET EXP_PO_DT = ?, UPD_DT = SYSDATE "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updatePODate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateINVDate(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG3_TBL  " + " SET EXP_INV_DT = ?, UPD_DT = SYSDATE "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updatePODate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public SipJihDues getJihDueDetailsForQuatation(String emp_code, String quotationNo) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		SipJihDues volumeList = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT CONSULTANT,PROJECT_NAME,QTN_CODE,QTN_NO,QTN_DT,QTN_AMOUNT FROM FJT_SM_STG2_TBL WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myStmt.setString(2, quotationNo);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String consultant = myRes.getString(1);
				String projectName = myRes.getString(2);
				String quotationCode = myRes.getString(3);
				String quotatiNo = myRes.getString(4);
				String quotationDate = formatDate(myRes.getString(5));
				int quotationAmount = myRes.getInt(6);
				volumeList = new SipJihDues(projectName, consultant, quotationCode, quotatiNo, quotationDate,
						quotationAmount);
			}

		} catch (SQLException e) {
			System.out
					.println("Exception Sales eng EMp COde SipJihDuesDbUtil.getJihDueDetailsForQuatation " + emp_code);
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return volumeList;
	}

	public String getMarketingTeamEmailId() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return null;
		String retval = null;
		PreparedStatement psmt = null;

		ResultSet rs = null; // status,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid
		String usrsql = "select emailid from  emailconf where usagetype='MKTEAM'";
		try {
			psmt = mcon.prepareStatement(usrsql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
				// retval = "rajakumari.ch@fjtco.com";
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					;
				psmt.close();
				con.closeConnection();
			} catch (SQLException e) {

				System.out.println("Exception in closing DB resources");
				retval = null;
			}
		}
		System.out.println("MK team emaild ids" + retval);
		return retval;
	}

	private String getLostwithNotInVendorListMailBody(fjtcouser fjtuser, String reason, SipJihDues sipJihduesObj) {

		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n"
				+ "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		NumberFormat nf = NumberFormat.getInstance(Locale.US);
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		mbody.append("Dear Business development Team, <br/><br/>");
		mbody.append("A Quotation has been marked as lost with reason \"NOT IN VENDOR LIST\".<br/>");
		mbody.append("Please take necessary action or follow up with salesman.<br/><br/>");
		mbody.append(
				"<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
		mbody.append("<tr><td><b>Salesman</b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + fjtuser.getUname()
				+ "</td></tr><tr><td><b>Email</b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + fjtuser.getEmailid()
				+ "</td></tr>");
		mbody.append("<tr><td><b>Quotation Details </b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
				+ sipJihduesObj.getQtnCode() + " - " + sipJihduesObj.getQtnNo() + "</td></tr>");
		mbody.append("<tr><td><b>Quotation Date </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + sipJihduesObj.getQtnDate()
				+ "</td></tr>");
		mbody.append(
				"<tr><td><b>Quotation Stage </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + "Job In Hand" + "</td></tr>");
		mbody.append("<tr><td><b>Quotation Value </b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
				+ nf.format(sipJihduesObj.getQtnAMount()) + "</td></tr>");
		mbody.append("<tr><td><b>Consultant </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + sipJihduesObj.getConsultant()
				+ "</td></tr><tr><td><b>Project Name </b></td><td><b>&nbsp;:&nbsp; </b></td><td> "
				+ sipJihduesObj.getProjectName() + "</td></tr>");
		mbody.append("</table><br/></div>");
		return mbody.toString();
	}

	public int updateReminderDetails(String qtn_id, java.sql.Date reminderDate, String saleEngEmpCode,
			String segSalesCode, String reminderDesc, String projectName, String qtnCodeNo) throws SQLException {

		int logCount = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " INSERT  INTO FJPORTAL.SIP_REMINDER(REMINDER_DATE, REMINDER_DESC,  EMP_CODE, USER_TYPE, QUOT_OR_ENQ_TYPE, QUOT_PROJ_NAME, H_SYS_ID) "
					+ " VALUES(?, ?, ?, ?, ?, ?, ?) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, reminderDate);
			myStmt.setString(2, reminderDesc);
			myStmt.setString(3, saleEngEmpCode);
			myStmt.setString(4, "1");
			myStmt.setString(5, qtnCodeNo);
			myStmt.setString(6, projectName);
			myStmt.setString(7, qtn_id);
			logCount = myStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			if (myCon != null) {
				try {
					System.out.println("Transaction is being rolled back. Customer visit updates" + logCount);
					logCount = 0;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;

	}

	public List<CustomerVisit> getRemindersFortheQtn(String emp_code, String qtncodeno) throws SQLException {
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT QUOT_OR_ENQ_TYPE,REMINDER_DESC,QUOT_PROJ_NAME,ACT_PARTY_NAME,USER_TYPE,REMINDER_DATE FROM  FJPORTAL.SIP_REMINDER WHERE QUOT_OR_ENQ_TYPE = ? AND EMP_CODE = ? ORDER BY 1";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, qtncodeno);
			myStmt.setString(2, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				CustomerVisit tmpProjectList;
				String documentId = myRes.getString(1);
				String reminderDesc = myRes.getString(2);
				String projectName = myRes.getString(3);
				String partyName = myRes.getString(4);
				String userType = myRes.getString(5);
				String reminderDate = myRes.getString(6);
				tmpProjectList = new CustomerVisit(reminderDate, documentId + " : " + reminderDesc);

				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<CustomerVisit> getSubmittalStatusfortheqtnFortheQtn(String qtncodeno) throws SQLException {
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  DESCRIPTION,SUB_STATUS_REMARKS   FROM FJT_SM_STG2_TBL ST2,SUBMITTAL_STATUS SS WHERE   CQHSYSID = ? and ST2.SUB_STATUS_CODE = SS.CODE";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, qtncodeno);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				CustomerVisit tmpProjectList;
				String description = myRes.getString(1);
				String remarks = myRes.getString(2);
				tmpProjectList = new CustomerVisit(description, remarks);

				projectList.add(tmpProjectList);
			}
			return projectList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public String getConsultantDetailsForQuatation(SipJihDues sipjihduesObj) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String portal = "CONSULT";
		String consultant = null;
		try {
			myCon = orcl.getOrclConn();
			// String sql = " SELECT VSSV_BL_SHORT_NAME FROM IM_VS_STATIC_VALUE WHERE
			// VSSV_CODE = ? AND VSSV_VS_CODE = ?";
			String sql = " SELECT VSSV_BL_SHORT_NAME FROM IM_VS_STATIC_VALUE WHERE VSSV_CODE = ? AND VSSV_VS_CODE = ?  AND VSSV_FRZ_FLAG_NUM <> 1 AND VSSV_FIELD_08 <>'NA'";

			System.out.println("Project Name== " + sipjihduesObj.getProjectName().split("-")[0]);
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sipjihduesObj.getProjectName().split("-")[0]);
			myStmt.setString(2, portal);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				consultant = myRes.getString(1);
			}

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipJihDuesDbUtil.getConsultantDetailsForQuatation ");
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return consultant;
	}

	public int updateExpLOIDate(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG2_TBL  " + " SET EXP_LOI_DT = ?  "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updateExpLOIDate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateExpOrderDate(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG3_TBL  " + " SET EXP_ORD_DT = ?  "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updateExpOrderDate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateExpBillingDate(String qtn_id, java.sql.Date billingDate, String saleEngEmpCode)
			throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG4_TBL  " + " SET EXP_BILL_DT = ?  "
					+ " WHERE SOH_SM_CODE = ?  AND SOH_SYS_ID = ? AND HEADDET='HEADER'";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, billingDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updateExpBillingDate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateSEWINPercentage(String qtn_id, int sewin, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG2_TBL  " + " SET SALESWIN = ?  "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, sewin);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updateExpLOIDate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateSEWINPercentageforstage3(String qtn_id, int sewin, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG3_TBL  " + " SET SALESWIN = ?  "
					+ " WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, sewin);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updateExpLOIDate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public List<SipJihDues> getSubmitalStausOptions() throws SQLException {
		List<SipJihDues> remarksList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM  SUBMITTAL_STATUS";
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String type = myRes.getString(1);
				String desc = myRes.getString(2);
				SipJihDues tempRemarksList = new SipJihDues(type, desc);
				remarksList.add(tempRemarksList);
			}
			return remarksList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int updateSubmittalStatus(String sysID, String substatusDesc, String substatusCode, String sales_Egr_Code)
			throws SQLException {

		int logCount = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			myCon = orcl.getOrclConn();
			String sql = " UPDATE FJT_SM_STG2_TBL SET SUB_STATUS_CODE = ?,SUB_STATUS_REMARKS = ?  WHERE SALES_EGR_CODE = ?  AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, substatusCode);
			myStmt.setString(2, substatusDesc);
			myStmt.setString(3, sales_Egr_Code);
			myStmt.setString(4, sysID);
			logCount = myStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			if (myCon != null) {
				try {
					System.out.println("Transaction is being rolled back. Customer visit updates" + logCount);
					logCount = 0;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;

	}

	public int updateShortClose(String qtn_id, String sales_Egr_Code) throws SQLException {

		int logCount = 0, sysId = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			if (qtn_id != null) {
				sysId = Integer.parseInt(qtn_id);
			}
			myCon = orcl.getOrclConn();
			myCon.setAutoCommit(false);
			String sql = " UPDATE ORION.OT_SO_HEAD SET  SOH_CLO_UID = ?,SOH_CLO_STATUS = ?,SOH_CLO_DT = SYSDATE WHERE SOH_SYS_ID = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sales_Egr_Code);
			myStmt.setInt(2, 1);
			myStmt.setInt(3, sysId);
			logCount = myStmt.executeUpdate();
			if (logCount == 1) {
				int logupdate = deleteFromStage4Table(qtn_id);
				if (logupdate > 0) {
					System.out.print("sent updateShortClose...");
					myCon.commit();
					logCount = 1;
				}
			} else {
				myCon.rollback();
				System.out.print("Error in updateShortClose...");
				logCount = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			if (myCon != null) {
				try {
					System.out.println("Error while short closeing updateShortClose" + logCount);
					logCount = 0;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;

	}

	public int moveToStage1(String qtn_id, String salesEgrCode) throws SQLException {
		int logCount = 0;
		int sysId = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			if (qtn_id != null) {
				sysId = Integer.parseInt(qtn_id);
			}

			myCon = orcl.getOrclConn();
			myCon.setAutoCommit(false);

			String sql = "UPDATE ORION.OT_CUST_QUOT_HEAD SET CQH_FLEX_03 = 1, CQH_UPD_UID = ?, CQH_UPD_DT = SYSDATE WHERE CQH_SYS_ID = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEgrCode);
			myStmt.setInt(2, sysId);

			logCount = myStmt.executeUpdate();
			System.out.println("Update count: " + logCount); // Log the update count

			if (logCount == 1) {
				int logUpdate = deleteFromStage2Table(qtn_id);
				if (logUpdate != 1) {
					myCon.rollback();
					System.err.println("Error in deleteFromStage2Table, rolling back...");
					return -1;
				} else {
					myCon.commit();
				}
			} else {
				myCon.commit();
			}
		} catch (SQLException e) {
			if (myCon != null) {
				try {
					myCon.rollback();
					System.err.println("Error during SQL execution, rolling back: " + e.getMessage());
				} catch (SQLException ex) {
					System.err.println("Error during rollback: " + ex.getMessage());
				}
			}
			throw e;
		} finally {
			if (myStmt != null) {
				try {
					myStmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (myCon != null) {
				try {
					myCon.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			orcl.closeConnection();
		}
		return logCount;
	}

	public int deleteFromStage2Table(String sysId) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		int logCount = 0;
		try {
			myCon = orcl.getOrclConn();
			String sql = "DELETE FROM FJT_SM_STG2_TBL WHERE  CQHSYSID = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sysId);
			logCount = myStmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipJihDuesDbUtil.deleteFromStage2Table " + e);
			e.printStackTrace();
			logCount = 0;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;
	}

	public int deleteFromStage4Table(String sysId) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		int logCount = 0;
		try {
			myCon = orcl.getOrclConn();
			String sql = "DELETE FROM FJT_SM_STG4_TBL WHERE  SOH_SYS_ID = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sysId);
			logCount = myStmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipJihDuesDbUtil.deleteFromStage4Table " + e);
			e.printStackTrace();
			logCount = 0;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;
	}

	public List<SipStageFollowUp> getStage1Details(String seCode, String status, String priority,
			String consultantwinning, String contractortwinning, String searchremarks, String totalwinning,
			String amountgreaterthan) throws SQLException {
		List<SipStageFollowUp> stageList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String formattedsearchremarks = null;
		try {
			myCon = orcl.getOrclConn();
			status = checkFilterValue(status);
			priority = checkFilterValue(priority);
			consultantwinning = checkFilterValue(consultantwinning);
			contractortwinning = checkFilterValue(contractortwinning);
			totalwinning = checkFilterValue(totalwinning);
			searchremarks = checkFilterValue(searchremarks);
			amountgreaterthan = checkFilterValue(amountgreaterthan);

			if (!searchremarks.equalsIgnoreCase("-")) {
				formattedsearchremarks = "%" + searchremarks + "%";
			}
			StringBuilder sqlQuery = new StringBuilder(
					"SELECT  CQHSYSID, SALES_EGR_CODE, SALES_ENG_NAME, QTN_DT, QTN_CODE, QTN_NO, CUST_NAME, PROJECT_NAME, CONSULTANT, QTN_AMOUNT,  QTN_PRI, QTN_STAT, QTN_REMARKS, QTN_MOD_BY,  QTN_MOD_DT, CONSULTANTWIN, CONTRACTORWIN, TOTALWIN, (SELECT COUNT(1) FROM  SIP_REMINDER WHERE H_SYS_ID = ST1.CQHSYSID) REMINDERCNT,  "
							+ " EXP_LOI_DT, SALESWIN,SUB_STATUS_CODE 	 FROM FJT_SM_STG1_TBL ST1 WHERE  SALES_EGR_CODE  IN ("
							+ seCode + ")  ");
			int counter = 1;
			if (!priority.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND   QTN_PRI =   ? ");
			}
			if (!status.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND QTN_STAT =   ? ");
			}
			if (!consultantwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND CONSULTANTWIN IN (?) ");
			}
			if (!contractortwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND CONTRACTORWIN IN  (?) ");
			}
			if (!totalwinning.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND TOTALWIN IN  (?) ");
			}
			if (!searchremarks.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND UPPER(QTN_REMARKS) LIKE UPPER(?)  ");
			}
			if (!amountgreaterthan.equalsIgnoreCase("-")) {
				sqlQuery.append(" AND QTN_AMOUNT >= (?)  ");
			}
			sqlQuery.append(
					" AND NVL(LH_STATUS,'W') <> 'L'  AND  CQHSYSID NOT IN ( SELECT DISTINCT CQHSYSID FROM FJT_SM_STG3_TBL)");

			myStmt = myCon.prepareStatement(sqlQuery.toString());

			if (!priority.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, priority);
			}
			if (!status.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, status);

			}
			if (!consultantwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, consultantwinning);
			}
			if (!contractortwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, contractortwinning);
			}
			if (!totalwinning.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, totalwinning);
			}
			if (!searchremarks.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, formattedsearchremarks);
			}
			if (!amountgreaterthan.equalsIgnoreCase("-")) {
				myStmt.setString(counter++, amountgreaterthan);
			}

			System.out.println(sqlQuery);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String expLOIDate = "";
				String id = myRes.getString(1);
				String se_code = myRes.getString(2);
				String se_name = myRes.getString(3);
				String qtnDt = myRes.getString(4);
				String qtnCode = myRes.getString(5);
				String qtnNo = myRes.getString(6);
				String custName = myRes.getString(7);
				String projName = myRes.getString(8);
				String consultant = myRes.getString(9);
				double amount = myRes.getDouble(10);
				String priorityOrg = myRes.getString(11);
				String statusOrg = myRes.getString(12);
				String remarks = myRes.getString(13);
				String updatedBy = myRes.getString(14);
				String updatedOn = myRes.getString(15);
				int consltWin = myRes.getInt(16);
				int contractorWin = myRes.getInt(17);
				int totalWin = myRes.getInt(18);
				int reminderCount = myRes.getInt(19);
				if (myRes.getString(20) != null) {
					expLOIDate = formatDate(myRes.getString(20));
				}
				String sewinper = myRes.getString(21);
				String submittalcode = myRes.getString(22);
				SipStageFollowUp tempstageList = new SipStageFollowUp(id, se_code, se_name, qtnDt, qtnCode, qtnNo,
						custName, projName, consultant, amount, priorityOrg, statusOrg, remarks, updatedBy, updatedOn,
						reminderCount, consltWin, contractorWin, totalWin, expLOIDate, sewinper, submittalcode);
				stageList.add(tempstageList);
			}
			return stageList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int updateStage1Status(String seCode, String status, String priority, String remarks, String id,
			String sales_eng_Emp_code) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJT_SM_STG1_TBL  "
					+ " SET QTN_PRI = ?, QTN_STAT = ?, QTN_REMARKS = ?, QTN_MOD_BY = ?, QTN_MOD_DT = SYSDATE, UPD_DT = SYSDATE "
					+ " WHERE  SALES_EGR_CODE = ? AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, priority);
			myStmt.setString(2, status);
			myStmt.setString(3, remarks);
			myStmt.setString(4, sales_eng_Emp_code);
			myStmt.setString(5, seCode);
			myStmt.setString(6, id);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of stage update for " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int moveToStage2(String qtn_id, String salesEgrCode) throws SQLException {
		int logCount = 0;
		int sysId = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			if (qtn_id != null) {
				sysId = Integer.parseInt(qtn_id);
				System.out.println("Received qtn_id: " + qtn_id); // Log the received qtn_id
			}

			myCon = orcl.getOrclConn();
			myCon.setAutoCommit(false);

			String sql = "UPDATE ORION.OT_CUST_QUOT_HEAD SET CQH_FLEX_03 = 2, CQH_UPD_UID = ?, CQH_UPD_DT = SYSDATE WHERE CQH_SYS_ID = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesEgrCode);
			myStmt.setInt(2, sysId);

			logCount = myStmt.executeUpdate();
			System.out.println("Update count: " + logCount); // Log the update count

			if (logCount == 1) {
				int logUpdate = deleteFromStage1Table(qtn_id);
				if (logUpdate != 1) {
					myCon.rollback();
					System.err.println("Error in deleteFromStage1Table, rolling back...");
					return -1;
				} else {
					myCon.commit();
				}
			} else {
				myCon.commit();
			}
		} catch (SQLException e) {
			if (myCon != null) {
				try {
					myCon.rollback();
					System.err.println("Error during SQL execution, rolling back: " + e.getMessage());
				} catch (SQLException ex) {
					System.err.println("Error during rollback: " + ex.getMessage());
				}
			}
			throw e;
		} finally {
			if (myStmt != null) {
				try {
					myStmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (myCon != null) {
				try {
					myCon.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			orcl.closeConnection();
		}
		return logCount;
	}

	private void close(PreparedStatement myStmt, ResultSet myRes) {
		if (myStmt != null) {
			try {
				myStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (myRes != null) {
			try {
				myRes.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public int deleteFromStage1Table(String sysId) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		int logCount = 0;
		try {
			myCon = orcl.getOrclConn();
			String sql = "DELETE FROM FJT_SM_STG1_TBL WHERE  CQHSYSID = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, sysId);
			logCount = myStmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipJihDuesDbUtil.deleteFromStage1Table " + e);
			e.printStackTrace();
			logCount = 0;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;
	}

	public String getEmployeeCode(String segSalesCode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String employeeCode = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SM_FLEX_08 from FJPORTAL.OM_SALESMAN WHERE SM_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, segSalesCode);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				employeeCode = myRes.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return employeeCode;

	}

	public int updateApprovalStatusForConslt(String qtncodeno, String sesalescode, String approvalStatus,
			fjtcouser fjtuser) throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String mailSubject = "FJPortal-Product is specified : NO/Not sure";

			String sql = " UPDATE FJT_SM_STG2_TBL SET  APPR_CONS = ?, APPR_CONS_DT = SYSDATE "
					+ " WHERE  SALES_EGR_CODE = ? AND CQHSYSID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approvalStatus);
			myStmt.setString(2, sesalescode);
			myStmt.setString(3, qtncodeno);

			logType = myStmt.executeUpdate();
			if (approvalStatus.equals("NS")) {
				SipJihDues sipJihdues = getJihDueDetailsForQuatation(sesalescode, qtncodeno);
				SSLMail sslmail = new SSLMail();
				String msg = getProductIsnotSpecifiedMailBody(fjtuser, sipJihdues, approvalStatus);
				sslmail.setToaddr(getMarketingTeamEmailId());
				sslmail.setMessageSub(mailSubject + " - " + fjtuser.getUname());
				sslmail.setMessagebody(msg);
				int status = sslmail.sendMail(fjtuser.getUrlAddress());
				if (status != 1) {
					System.out.print("Error in sending Email when product is not specified... to mkt");
				} else {
					System.out.print("sent when product is not specified...to mkt");

				}
			}
			if (approvalStatus.equals("NO")) {
				SipJihDues sipJihdues = getJihDueDetailsForQuatation(sesalescode, qtncodeno);
				SSLMail sslmail1 = new SSLMail();
				String msg = getProductIsnotSpecifiedMailBody(fjtuser, sipJihdues, approvalStatus);
				sslmail1.setToaddr("ben.t@fjtco.com");
				sslmail1.setMessageSub(mailSubject + " - " + fjtuser.getUname());
				sslmail1.setMessagebody(msg);
				int status = sslmail1.sendMail(fjtuser.getUrlAddress());
				if (status != 1) {
					System.out.print("Error in sending Email when product is not specified... to Ben");
				} else {
					System.out.print("sent when product is not specified... to ben");

				}
			}

		} catch (SQLException ex) {
			System.out.println(
					"Exception in closing DB resources at the time of updateApprovalStatusForConslt for " + qtncodeno);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateFocusListStatus(String qtncodeno, String sesalescode, String approvalStatus, fjtcouser fjtuser,
			String stage) throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String text = "Focus List";
		try {
			myCon = orcl.getOrclConn();
			String sql = "UPDATE " + stage + " SET QTN_PRI = ? WHERE SALES_EGR_CODE = ? AND CQHSYSID = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approvalStatus.equals("Focus List") ? "Focus List" : "");
			myStmt.setString(2, sesalescode);
			myStmt.setString(3, qtncodeno);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updateFocusListStatus for " + qtncodeno + ": " + ex.getMessage());
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logType;
	}

	private String getProductIsnotSpecifiedMailBody(fjtcouser fjtuser, SipJihDues sipJihduesObj,
			String approvalStatus) {
		if (approvalStatus.equals("NS")) {
			approvalStatus = "Not Sure";
		}
		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n"
				+ "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		mbody.append("Dear Business Development Team, <br/><br/>");
		mbody.append("A Quotation has been marked as PRODUCT IS SPECIFIED: NO/NOT SURE.<br/>");
		mbody.append("Please take necessary action or follow up with salesman.<br/><br/>");
		mbody.append(
				"<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
		mbody.append("<tr><td><b>Salesman</b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + fjtuser.getUname()
				+ "</td></tr><tr><td><b>Email</b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + fjtuser.getEmailid()
				+ "</td></tr>");
		mbody.append("<tr><td><b>Quotation Details </b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
				+ sipJihduesObj.getQtnCode() + " - " + sipJihduesObj.getQtnNo() + "</td></tr>");
		mbody.append("<tr><td><b>Quotation Date </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + sipJihduesObj.getQtnDate()
				+ "</td></tr>");
		mbody.append(
				"<tr><td><b>Quotation Stage </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + "Job In Hand" + "</td></tr>");
		// mbody.append("<tr><td><b>Quotation Value
		// </b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
		// + nf.format(sipJihduesObj.getQtnAMount()) + "</td></tr>");
		mbody.append("<tr><td><b>Consultant </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + sipJihduesObj.getConsultant()
				+ "</td></tr><tr><td><b>Project Name </b></td><td><b>&nbsp;:&nbsp; </b></td><td> "
				+ sipJihduesObj.getProjectName() + "</td></tr>");
		mbody.append("<tr><td><b>Product Specified </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + approvalStatus
				+ "</td></tr>");
		mbody.append("</table><br/></div>");
		return mbody.toString();
	}

}
