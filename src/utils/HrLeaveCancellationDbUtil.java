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

import beans.HrLeaveCancellation;
import beans.LeaveApplication;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class HrLeaveCancellationDbUtil {

	private String payrollId = null;
	private String fjportalId = null;
	private String mysqlPrlId = null;

	public int checkPayrollLwpLeaveAvailability(String empCode, String fromStr, String toStr) {
		int retval = 0;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		myCon = orcl.getOrclConn();
		if (myCon == null) {
			return retval = -2;
		} else {
			StringBuilder sqlstr = new StringBuilder("SELECT * FROM PAYROLL.PT_LWP ");
			sqlstr.append(" WHERE LWP_EMP_CODE = ? and LWP_FROM_DT = ? and LWP_UPTO_DT = ?   ");
			try {

				myStmt = myCon.prepareStatement(sqlstr.toString());
				myStmt.setString(1, empCode);
				myStmt.setDate(2, getFormatedToSqlDate(fromStr));
				myStmt.setDate(3, getFormatedToSqlDate(toStr));

				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					this.setPayrollId(myRes.getString(1));
				}
				retval = myStmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
				retval = -2;
				// DB error
			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
			return retval;
		}

	}

	public int checkFjPortalLwpLeaveAvailability(String empCode, String fromStr, String toStr) {
		int retval = 0;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		myCon = orcl.getOrclConn();
		if (myCon == null) {
			return retval = -2;
		} else {
			StringBuilder sqlstr = new StringBuilder("SELECT * FROM FJPORTAL.PT_LWP ");
			sqlstr.append(
					" WHERE LWP_EMP_CODE = ? and LWP_FROM_DT = ? and LWP_UPTO_DT = ? and LWP_UPLD_STATUS = ? and LWP_CR_UID = ? ");
			try {

				myStmt = myCon.prepareStatement(sqlstr.toString());
				myStmt.setString(1, empCode);
				myStmt.setDate(2, getFormatedToSqlDate(fromStr));
				myStmt.setDate(3, getFormatedToSqlDate(toStr));
				myStmt.setString(4, "Y");
				myStmt.setString(5, "FJTPORTAL");
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					this.setFjportalId(myRes.getString(1));
				}
				retval = myStmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				retval = -2;
				// DB error
			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
			return retval;
		}

	}

	public int checkPayrollNonLwpLeaveAvailability(String empCode, String fromStr, String toStr) {
		int retval = 0;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		myCon = orcl.getOrclConn();
		if (myCon == null) {
			return retval = -2;
		} else {
			StringBuilder sqlstr = new StringBuilder("SELECT * FROM PAYROLL.PT_LEAVE_APPLICATION_HEAD ");
			sqlstr.append(" WHERE LVAH_EMP_CODE = ? and LVAH_START_DT = ? and LVAH_END_DT = ?   ");
			try {

				myStmt = myCon.prepareStatement(sqlstr.toString());
				myStmt.setString(1, empCode);
				myStmt.setDate(2, getFormatedToSqlDate(fromStr));
				myStmt.setDate(3, getFormatedToSqlDate(toStr));

				myRes = myStmt.executeQuery();

				while (myRes.next()) {
					this.setPayrollId(myRes.getString(1));
					// String t2 =myRes.getString(12);
					// String t3 =myRes.getString (15);
					// String t4=myRes.getString (16);
					// String t5 = myRes.getString(18);

					// System.out.println("Payroll => "+t1+" "+t2+" "+t3+" "+t4+" "+t5);
					// System.out.println("Payroll ID => "+this.getPayrollId());

				}
				retval = myStmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
				retval = -2;
				// DB error
			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
			return retval;
		}

	}

	public int checkFjPortalNonLwpLeaveAvailability(String empCode, String fromStr, String toStr) {
		int retval = 0;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		myCon = orcl.getOrclConn();
		if (myCon == null) {
			return retval = -2;
		} else {

			StringBuilder sqlstr = new StringBuilder("SELECT * FROM FJPORTAL.PT_LEAVE_APPLICATION_HEAD ");
			sqlstr.append(
					" WHERE LVAH_EMP_CODE = ? and LVAH_START_DT = ? and LVAH_END_DT = ? and LVAH_UPLD_STATUS = ? and LVAH_CR_UID = ? ");
			try {

				myStmt = myCon.prepareStatement(sqlstr.toString());
				myStmt.setString(1, empCode);
				myStmt.setDate(2, getFormatedToSqlDate(fromStr));
				myStmt.setDate(3, getFormatedToSqlDate(toStr));
				myStmt.setString(4, "Y");
				myStmt.setString(5, "FJTPORTAL");
             
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					this.setFjportalId(myRes.getString(1));
				}
				retval = myStmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
				retval = -2;
				// DB error
			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
			return retval;
		}

	}

	public Date getFormatedToSqlDate(String startdt) throws ParseException {
		Date fromdate;
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt = null;
		try {
			dt = formatter.parse(startdt);
			fromdate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			fromdate = null;
		}
		// System.out.println(fromdate+" : "+dt);
		return fromdate;
	}

	public List<HrLeaveCancellation> checkLeavDetailsAvailableOrNot(String startdt, String enddt, String employeeCode)
			throws SQLException, ParseException {

		List<HrLeaveCancellation> leaveList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();
			String sql = "SELECT reqid,uid,leavetype,applied_date,fromdate,todate,reason,leavedays  FROM  leave_application where    "
					+ " uid = ? and  fromdate = ? and  todate = ?  " + "  and status = 4  ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, employeeCode);
			myStmt.setDate(2, getFormatedToSqlDate(startdt));
			myStmt.setDate(3, getFormatedToSqlDate(enddt));
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				this.setMysqlPrlId(myRes.getString(1));
				String emp_code = myRes.getString(2);
				String lvtype = myRes.getString(3);
				String dateApplied = myRes.getString(4);
				String dateFrom = myRes.getString(5);
				String dateTo = myRes.getString(6);
				String reason = myRes.getString(7);
				String days = myRes.getString(8);
				// System.out.println("Leave Reason : "+reason);
				HrLeaveCancellation tempLeaveList = new HrLeaveCancellation(emp_code, lvtype, dateApplied, dateFrom,
						dateTo, reason, days);

				leaveList.add(tempLeaveList);

			}
			return leaveList;

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

	public int deleteOrclLeaveDeatilsNonLWP(String fjportalId, String payrollId) {
		int logValue = 0;
		Connection myCon = null;
		PreparedStatement myDeleteStmtFjport = null;
		PreparedStatement myDeleteStmtPayroll = null;
		ResultSet myRes = null;

		String sqlDeleteFjPortal = " DELETE FROM FJPORTAL.PT_LEAVE_APPLICATION_HEAD WHERE LVAH_SYS_ID = ? ";

		String sqlDeletePayroll = " DELETE FROM PAYROLL.PT_LEAVE_APPLICATION_HEAD WHERE LVAH_SYS_ID = ? ";
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();

			// STEP 1 - Disable auto commit mode
			myCon.setAutoCommit(false);

			myDeleteStmtFjport = myCon.prepareStatement(sqlDeleteFjPortal);
			myDeleteStmtPayroll = myCon.prepareStatement(sqlDeletePayroll);

			// Create update statement
			myDeleteStmtFjport.setString(1, fjportalId);
			logValue += myDeleteStmtFjport.executeUpdate();
			System.out.println("FJPORTAL ORCL NONLWP LEAVE DELETE OP STATUS " + logValue);
			// Create insert statement
			// Create update statement
			myDeleteStmtPayroll.setString(1, payrollId);
			logValue += myDeleteStmtPayroll.executeUpdate();
			System.out.println("PAYROLL ORCL NONLWP LEAVE DELETE OP STATUS " + logValue);

			// STEP 2 - Commit delete statements
			myCon.commit();

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					// STEP 3 - Roll back transaction
					System.out.println("Transaction is being rolled back for NON-LWP TXN  " + fjportalId);
					myCon.rollback();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			// close jdbc objects
			close(myDeleteStmtFjport, myRes);
			close(myDeleteStmtPayroll, myRes);
			orcl.closeConnection();

		}
		return logValue;
	}

	public int deleteOrclLeaveDeatilsLWP(String fjportalId, String payrollId) {
		int logValue = 0;
		Connection myCon = null;
		PreparedStatement myDeleteStmtFjport = null;
		PreparedStatement myDeleteStmtPayroll = null;
		ResultSet myRes = null;

		String sqlDeleteFjPortal = " DELETE FROM FJPORTAL.PT_LWP WHERE LWP_SYS_ID = ? ";

		String sqlDeletePayroll = " DELETE FROM PAYROLL.PT_LWP WHERE LWP_SYS_ID = ? ";
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();

			// STEP 1 - Disable auto commit mode
			myCon.setAutoCommit(false);

			myDeleteStmtFjport = myCon.prepareStatement(sqlDeleteFjPortal);
			myDeleteStmtPayroll = myCon.prepareStatement(sqlDeletePayroll);

			// Create update statement
			myDeleteStmtFjport.setString(1, fjportalId);
			logValue += myDeleteStmtFjport.executeUpdate();
			System.out.println("FJPORTAL ORCL  LWP LEAVE DELETE OP STATUS = " + logValue);
			// Create insert statement
			// Create update statement
			myDeleteStmtPayroll.setString(1, payrollId);
			logValue += myDeleteStmtPayroll.executeUpdate();
			System.out.println("PAYROLL ORCL  LWP LEAVE DELETE OP STATUS = " + logValue);

			// STEP 2 - Commit delete statements
			myCon.commit();

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					// STEP 3 - Roll back transaction
					System.out.println("Transaction is being rolled back for  LWP TXN  " + fjportalId);
					myCon.rollback();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			// close jdbc objects
			close(myDeleteStmtFjport, myRes);
			close(myDeleteStmtPayroll, myRes);
			orcl.closeConnection();

		}
		return logValue;
	}

	public int deleteMysqlLeaveDetails(String hrEmpCode, String mysqlId, String fjportalId, String payrollId,
			HrLeaveCancellation theData) throws SQLException, ParseException {
		int logType = 0;
		Connection myCon = null;
		PreparedStatement myInsertStmt = null;
		PreparedStatement myDeleteStmt = null;
		ResultSet myRes = null;

		String sqlDelete = " DELETE FROM  leave_application where reqid = ?  ";

		String sqlInsert = " INSERT INTO deleted_leave_application (emp_code, mysql_id, fjportal_id, payroll_id, leavetype, reason, fromdate, todate, deleted_by, deleted_on) "
				+ " VALUES(?, ?, ?, ?, ?, ?,  ?, ?, ?, now() ) ";
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();

		try {
			myCon = con.getMysqlConn();

			// STEP 1 - Disable auto commit mode
			myCon.setAutoCommit(false);
			myDeleteStmt = myCon.prepareStatement(sqlDelete);
			myInsertStmt = myCon.prepareStatement(sqlInsert);

			// Create Delete statement
			myDeleteStmt.setString(1, mysqlId);
			logType += myDeleteStmt.executeUpdate();

			System.out.println("MYSQL LEAVE DELETE OP STATUS = " + logType);

			// Create update statement
			myInsertStmt.setString(1, theData.getUid());
			myInsertStmt.setString(2, mysqlId);
			myInsertStmt.setString(3, fjportalId);
			myInsertStmt.setString(4, payrollId);
			myInsertStmt.setString(5, theData.getType());
			myInsertStmt.setString(6, theData.getReason());
			myInsertStmt.setDate(7, getFormatedToSqlDate(theData.getFromDate()));
			myInsertStmt.setDate(8, getFormatedToSqlDate(theData.getToDate()));
			myInsertStmt.setString(9, hrEmpCode);
			logType += myInsertStmt.executeUpdate();
			System.out.println("MYSQL LEAVE INSERT OP STATUS " + logType);
			myCon.commit();

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					// STEP 3 - Roll back transaction
					System.out.println("Transaction is being rolled back. for MYSQL operation " + mysqlId);
					myCon.rollback();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			// close jdbc objects
			close(myInsertStmt, myRes);
			close(myDeleteStmt, myRes);
			con.closeConnection();

		}
		return logType;
	}

	public String getPayrollId() {
		return payrollId;
	}

	public void setPayrollId(String payrollId) {
		this.payrollId = payrollId;
	}

	public String getFjportalId() {
		return fjportalId;
	}

	public void setFjportalId(String fjportalId) {
		this.fjportalId = fjportalId;
	}

	public String getMysqlPrlId() {
		return mysqlPrlId;
	}

	public void setMysqlPrlId(String mysqlPrlId) {
		this.mysqlPrlId = mysqlPrlId;
	}
}
