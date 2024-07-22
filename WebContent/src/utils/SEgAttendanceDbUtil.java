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
import beans.Regularise_Report;
import beans.SengAttendance; 

public class SEgAttendanceDbUtil {
	public SEgAttendanceDbUtil() {
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

	public List<Regularise_Report> getregularisationreport(String startdt, String enddt, String emplList)
			throws SQLException {

		List<Regularise_Report> regulariseList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();
			String sql = "SELECT *  FROM  attendance  WHERE date_to_regularise " + " BETWEEN ? AND ?  "
					+ " and uid in (" + emplList + ")" + " order by uid,date_to_regularise ";

			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, startdt);
			myStmt.setString(2, enddt);
			// myStmt.setString(3,emplList);

			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {

				String emp_code = getUserProfileDetails(myRes.getString(2));

				String dateA = myRes.getString(3);
				String dateR = myRes.getString(4);
				String reason = myRes.getString(5);
				String approver = myRes.getString(6);
				String status = myRes.getString(7);
				String autdate = myRes.getString(8);
				String company = myRes.getString(9);
				String prjtCode = myRes.getString(10);

				Regularise_Report tempregulariseList = new Regularise_Report(emp_code, dateA, dateR, reason, approver,
						status, autdate, company, prjtCode);

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

	public List<SengAttendance> getAllActiveSegDetails() throws SQLException {

		List<SengAttendance> salesEngList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT  EMP_COMP_CODE,EMP_CODE,EMP_NAME,EMP_JOB_LONG_DESC,EMP_DIVN_CODE,EMP_LOCN_CODE FROM  PM_EMP_KEY  "
					+ " WHERE  EMP_CODE IN (SELECT SM_FLEX_08 FROM OM_SALESMAN  "
					+ " WHERE SM_FLEX_08 IS NOT NULL AND SM_CODE IS NOT NULL  " + " AND SM_FRZ_FLAG_NUM = 2    "
					+ " AND (sm_flex_07='Y' OR sm_flex_09='Y'))  "
					+ " AND   EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {

				String subord_cmp = myRes.getString(1);
				String subord_code = myRes.getString(2);
				String subord_name = myRes.getString(3);
				String subord_position = myRes.getString(4);
				String subord_div = myRes.getString(5);
				String subord_loc = myRes.getString(6);

				SengAttendance tempSalesEngList = new SengAttendance(subord_code, subord_cmp, subord_name,
						subord_position, subord_div, subord_loc);
				salesEngList.add(tempSalesEngList);

			}
			return salesEngList;

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
