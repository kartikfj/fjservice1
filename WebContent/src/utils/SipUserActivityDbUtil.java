package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.SipJihvSummary;
import beans.SipUserActivity;

public class SipUserActivityDbUtil {
	public SipUserActivityDbUtil() {
	}

	public List<SipUserActivity> getDeafultMonthUserActivity(String uid) throws SQLException {
		List<SipUserActivity> activityList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			// String sql = "select * from dashboard_user_history where empCode=? and
			// year=YEAR(NOW()) and month= month(NOW()) order by workdate desc";
			String sql = "select * from user_login_history where  empCode=? and year=YEAR(NOW()) and month= month(NOW()) order by loggedin desc";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, uid);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String workdate = myRes.getString(2);
				String empCode = myRes.getString(3);
				String empName = myRes.getString(4);
				// String segCode = myRes.getString(4);
				String loggedin = myRes.getString(5);
				String company = myRes.getString(8);
				String division = myRes.getString(9);

				SipUserActivity tmpActivityList = new SipUserActivity(workdate, empCode, empName, loggedin, company,
						division);
				// System.out.println("goal_list"+empName);
				activityList.add(tmpActivityList);

			}
			return activityList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<SipUserActivity> getCustomeMonthUserActivity(String uid, int monthVal) throws SQLException {
		List<SipUserActivity> activityList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			// String sql = "select * from dashboard_user_history where empCode=? and
			// year=YEAR(NOW()) and month= ? order by workdate desc";
			String sql = "select * from user_login_history where  empCode=? and year=YEAR(NOW()) and month= ? order by loggedin desc";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, uid);
			myStmt.setInt(2, monthVal);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String workdate = myRes.getString(2);
				String empCode = myRes.getString(3);
				String empName = myRes.getString(4);
				// String segCode = myRes.getString(4);
				// String firstUse = myRes.getString(5);
				String loggedin = myRes.getString(5);
				String company = myRes.getString(8);
				String division = myRes.getString(9);

				SipUserActivity tmpActivityList = new SipUserActivity(workdate, empCode, empName, loggedin, company,
						division);
				// System.out.println("goal_list"+empName+" "+workdate);
				activityList.add(tmpActivityList);

			}
			return activityList;

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

	public List<SipJihvSummary> getSalesEngListfor_Mg(String sales_eng_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select  '' AS SM_CODE,EMP_NAME,EMP_CODE,'' AS SM_BL_SHORT_NAME from FJPORTAL.PM_EMP_KEY "
					+ " WHERE EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') "
					+ " and EMP_CODE IN( SELECT SM_FLEX_08 FROM FJPORTAL.OM_SALESMAN  WHERE sm_frz_flag_num=2 AND (sm_flex_07='Y' OR sm_flex_09='Y'))ORDER BY EMP_NAME";

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

	public List<SipJihvSummary> getSalesEngListfor_Dm(String dm_emp_code) throws SQLException {

		List<SipJihvSummary> salesEngList = new ArrayList<>();// appraise company code list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "SELECT * FROM ( SELECT '' as SM_CODE, EMP_NAME,EMP_CODE, '' AS SM_BL_SHORT_NAME FROM PM_EMP_KEY  "
					+ "  WHERE   EMP_FRZ_FLAG='N' AND EMP_CODE IN( SELECT SM_FLEX_08 FROM FJPORTAL.OM_SALESMAN WHERE SM_FRZ_FLAG_NUM=2 AND SM_FLEX_08 =  ?)"
					+ " UNION " + "  SELECT '' AS SM_CODE, EMP_NAME,EMP_CODE,''AS SM_BL_SHORT_NAME FROM PM_EMP_KEY   "
					+ "  WHERE EMP_FRZ_FLAG='N' AND EMP_CODE IN( SELECT SM_FLEX_08 FROM FJPORTAL.OM_SALESMAN WHERE SM_FRZ_FLAG_NUM=2 AND SM_FLEX_07='Y' AND SM_FLEX_18 = ?)) ORDER BY EMP_NAME ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);// division manager employee code
			myStmt.setString(2, dm_emp_code);// division manager employee code

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

	public List<SipJihvSummary> getSalesEngListfor_NormalSalesEgr(String sales_eng_Emp_code) throws SQLException {
		List<SipJihvSummary> salesEngList = new ArrayList<>();// sales egr list for normal sales egr
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select  '' AS SM_CODE,EMP_NAME,EMP_CODE,'' AS SM_BL_SHORT_NAME from FJPORTAL.PM_EMP_KEY  where EMP_CODE IN (SELECT SM_FLEX_08 FROM FJPORTAL.OM_SALESMAN  WHERE SM_FLEX_08= ? OR SM_FLEX_17 = ?  AND SM_FRZ_FLAG_NUM=2)";
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

}
