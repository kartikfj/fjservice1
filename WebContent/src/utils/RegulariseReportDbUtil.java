package utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import beans.Approver;
import beans.LeaveApplication;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.Regularise_Report;

public class RegulariseReportDbUtil {

	public List<Regularise_Report> getregularisationreport(String startdt, String enddt, String emplList)
			throws SQLException {

		List<Regularise_Report> regulariseList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		java.sql.Date fromDate = null;
		java.sql.Date toDate = null;
		try {
			dt = formatter.parse(startdt);
			fromDate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
		}
		try {
			dt = formatter.parse(enddt);
			toDate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
		}
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			// SELECT * FROM newfjtco.regularisation_application WHERE date_to_regularise
			// BETWEEN '2018-05-01' AND '2018-05-31'
			// and uid in ('E000812','E001752','E001768','E002193','E002601')
			// order by uid,date_to_regularise;
			String sql = "SELECT *  FROM  regularisation_application WHERE date_to_regularise " + " BETWEEN ? AND ?  "
					+ " and uid in (" + emplList + ")" + " order by uid,date_to_regularise ";

			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setDate(1, fromDate);
			myStmt.setDate(2, toDate);
			// myStmt.setString(3,emplList);

			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {

				String emp_code = myRes.getString(2);
				String emp_Name = getUserProfileDetails(emp_code);
				String dateA = myRes.getString(3);
				String dateR = myRes.getString(4);
				String reason = myRes.getString(5);
				String approver = myRes.getString(6);
				String status = myRes.getString(7);
				String autdate = myRes.getString(8);
				String company = myRes.getString(9);
				String prjtCode = myRes.getString(10);

				Regularise_Report tempregulariseList = new Regularise_Report(emp_code, dateA, dateR, reason, approver,
						status, autdate, company, prjtCode, emp_Name);

				// System.out.println("REGULARISE LIST"+tempregulariseList.getUid());
				// add appraise id's to a array list of Approver
				regulariseList.add(tempregulariseList);

			}
			return regulariseList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

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

	public String getUserProfileDetails(String emp_com_code) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			// Get Connection
			myCon = orcl.getOrclConn();

			// Execute sql stamt
			String sql = "select EMP_NAME from FJPORTAL.PM_EMP_KEY "
					+ "where EMP_CODE=? and EMP_STATUS in (1,2) and EMP_FRZ_FLAG='N' and EMP_COMP_CODE <>'ALP'";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_com_code);
			myRes = myStmt.executeQuery();
			String emp_name = emp_com_code;

			if (myRes.next()) {

				emp_name = myRes.getString(1);
				// System.out.println("name to test 1"+emp_name +" code"+emp_com_code);
				return emp_name;

			}
			// System.out.println("name to test 2"+emp_name +" code"+emp_com_code);
			return emp_name;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<Regularise_Report> getSickCasualLeavereport(String startdt, String enddt, String emplList,
			String leave_type_list) throws SQLException {
		System.out.println(startdt + " " + enddt);

		List<Regularise_Report> regulariseList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			// System.out.println("nufail lv type"+leave_type_list);
			// Get Connection
			myCon = con.getMysqlConn();
			// SELECT uid,leavetype,applied_date,fromdate,todate,reason FROM
			// newfjtco.leave_application where leavetype in('SLV','CASUAl')
			// and authorised_by='E000009' and applied_date between '2018-01-01' and
			// '2018-7-30' and status=4 order by reqid desc;
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			java.util.Date dt;
			java.sql.Date fromDate = null;
			java.sql.Date toDate = null;
			try {
				dt = formatter.parse(startdt);
				fromDate = new Date(dt.getTime());
			} catch (ParseException ex) {
				Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			}
			try {
				dt = formatter.parse(enddt);
				toDate = new Date(dt.getTime());
			} catch (ParseException ex) {
				Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			}
			String sql = "SELECT uid,leavetype,applied_date,fromdate,todate,reason,leavedays  FROM  leave_application where leavetype in ("
					+ leave_type_list + ") and  " + " ( todate <= ? AND fromdate   >= ?  )"
					+ "  and status=4  and uid in (" + emplList + ")" + " order by reqid desc";

			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setDate(1, toDate);
			myStmt.setDate(2, fromDate);
			// myStmt.setString(3,emplList);

			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {

				String emp_code = getUserProfileDetails(myRes.getString(1));
				String lvtype = myRes.getString(2);
				// System.out.println("nufail "+lvtype);
				String dateApplied = myRes.getString(3);
				String dateFrom = myRes.getString(4);
				String dateTo = myRes.getString(5);
				String reason = myRes.getString(6);
				String days = myRes.getString(7);

				Regularise_Report tempregulariseList = new Regularise_Report(emp_code, lvtype, dateApplied, dateFrom,
						dateTo, reason, days);

				// System.out.println("REGULARISE LIST"+tempregulariseList.getUid());
				// add appraise id's to a array list of Approver
				regulariseList.add(tempregulariseList);

			}
			return regulariseList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<Approver> getSubordinatesDetails(String appr_com_code) throws SQLException {

		List<Approver> appraiseList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// select
			// EMP_COMP_CODE,EMP_CODE,EMP_NAME,EMP_JOB_LONG_DESC,EMP_DIVN_CODE,EMP_DEPT_CODE,EMP_LOCN_CODE
			// from fjtco.pm_emp_key
			// where EMP_CODE in (SELECT TXNFIELD_EMP_CODE FROM fjtco.pt_txn_fields
			// WHERE TXNFIELD_FLD3 = 'E001090' AND TXNFIELD_TXN_CODE='EMP' AND
			// TXNFIELD_BLOCK_NUM=1);

			String sql = " SELECT EMP_COMP_CODE,EMP_CODE,EMP_NAME,EMP_JOB_LONG_DESC,EMP_DIVN_CODE,EMP_DEPT_CODE,EMP_LOCN_CODE from FJPORTAL.PM_EMP_KEY "
					+ " where  EMP_CODE in (SELECT TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS "
					+ " WHERE TXNFIELD_FLD3 = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1) "
					+ "AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, appr_com_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String subord_cmp = myRes.getString(1);
				String subord_code = myRes.getString(2);
				String subord_name = myRes.getString(3);
				String subord_position = myRes.getString(4);
				String subord_div = myRes.getString(5);
				String subord_dept = myRes.getString(6);
				String subord_loc = myRes.getString(7);

				Approver tempAppraiseeList = new Approver(subord_code, subord_cmp, subord_name, subord_position,
						subord_div, subord_dept, subord_loc);
				// System.out.println("Appraisee_list"+tempAppraiseeList.toString());
				// add appraise id's to a array list of Approver
				appraiseList.add(tempAppraiseeList);

			}
			return appraiseList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<Regularise_Report> getBusinessTripReport(Date startdt, Date enddt, String emplList)
			throws SQLException {

		List<Regularise_Report> regulariseList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet rs = null;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			String sql = "SELECT uid, fromdate, todate, country,customer_name, purpose, otherdetails   FROM  businesstrip_leave_application where ( todate <= ? AND fromdate   >= ?  )"
					+ "  and status=4  and uid in (" + emplList + ")" + " order by req_id desc";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, enddt);
			myStmt.setDate(2, startdt);
			rs = myStmt.executeQuery();
			while (rs.next()) {
				String empName = getUserProfileDetails(rs.getString(1));
				// Date fromDate= rs.getDate(1);
				// Date toDate = rs.getDate(2);

				String dateA = rs.getString(2);
				String dateR = rs.getString(3);
				String country = rs.getString(4);
				String projectDetails = rs.getString(5);
				String purpose = rs.getString(6);
				String otherdetails = rs.getString(7);
				Regularise_Report tempregulariseList = new Regularise_Report(empName, dateA, dateR, country,
						projectDetails, purpose, otherdetails, null);
				regulariseList.add(tempregulariseList);

			}
			return regulariseList;

		} finally {
			// close jdbc objects
			close(myStmt, rs);
			con.closeConnection();

		}
	}
}
