package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipWeeklyReport;

public class SipWeeklyReportDbUtil {

	public SipWeeklyReportDbUtil() {
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

	public List<SipWeeklyReport> getWeeklyReportForMg() throws SQLException {
		List<SipWeeklyReport> salesEngList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM stg2_stg3_stg4_divnweek  ORDER BY 2,3,1 ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String week = myRes.getString(1);
				String company = myRes.getString(2);
				String division = myRes.getString(3);
				String s2Count = myRes.getString(4);
				String s2Value = myRes.getString(5);
				String s3Count = myRes.getString(6);
				String s3Value = myRes.getString(7);
				String s4Count = myRes.getString(8);
				String s4Value = myRes.getString(9);
				String s5Count = myRes.getString(10);
				String s5Value = myRes.getString(11);
				SipWeeklyReport tempSalesmanList = new SipWeeklyReport(week, company, division, s2Count, s2Value,
						s3Count, s3Value, s4Count, s4Value, s5Count, s5Value);
				salesEngList.add(tempSalesmanList);
			}
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipWeeklyReport> getWeeklyReportForDM(String empCode) throws SQLException {
		List<SipWeeklyReport> salesEngList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM stg2_stg3_stg4_divnweek  "
					+ " WHERE DIVN IN (SELECT DISTINCT DIVN_NAME FROM  FJT_DIVNNAME_DM " + " WHERE DM_EMP_CODE = ? ) "
					+ " ORDER BY 2,3,1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String week = myRes.getString(1);
				String company = myRes.getString(2);
				String division = myRes.getString(3);
				String s2Count = myRes.getString(4);
				String s2Value = myRes.getString(5);
				String s3Count = myRes.getString(6);
				String s3Value = myRes.getString(7);
				String s4Count = myRes.getString(8);
				String s4Value = myRes.getString(9);
				String s5Count = myRes.getString(10);
				String s5Value = myRes.getString(11);
				SipWeeklyReport tempSalesmanList = new SipWeeklyReport(week, company, division, s2Count, s2Value,
						s3Count, s3Value, s4Count, s4Value, s5Count, s5Value);
				salesEngList.add(tempSalesmanList);
			}
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipWeeklyReport> getWeeklyReportForSalesEngineer(String smCode) throws SQLException {
		List<SipWeeklyReport> salesEngList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT *FROM STG2_STG3_STG4_SMDIVNWEEK WHERE SM  = ?  ORDER BY 2,3,1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String week = myRes.getString(1);
				String company = myRes.getString(2);
				String division = myRes.getString(4);
				String s2Count = myRes.getString(5);
				String s2Value = myRes.getString(6);
				String s3Count = myRes.getString(7);
				String s3Value = myRes.getString(8);
				String s4Count = myRes.getString(9);
				String s4Value = myRes.getString(10);
				String s5Count = myRes.getString(11);
				String s5Value = myRes.getString(12);
				// String SNAME = myRes.getString(13);
				SipWeeklyReport tempSalesmanList = new SipWeeklyReport(week, company, division, s2Count, s2Value,
						s3Count, s3Value, s4Count, s4Value, s5Count, s5Value);
				salesEngList.add(tempSalesmanList);
			}
			System.out.println("salesEngList list" + salesEngList.size());
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipWeeklyReport> getWeeklyReportForSalesEngineerForDMs(String smCode) throws SQLException {
		List<SipWeeklyReport> salesEngList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * from ( SELECT DISTINCT(SM_CODE),SM_NAME,WEEK,COMP,DIVN,STG2_NOS,STG2_AMT,STG3_NOS,STG3_AMT,STG4_NOS,STG4_AMT,STG5_NOS,STG5_AMT FROM OM_SALESMAN,STG2_STG3_STG4_SMDIVNWEEK   WHERE  SM=SM_CODE and SM_FRZ_FLAG_NUM=2 and   SM_FLEX_08 =  ?  UNION SELECT DISTINCT(SM_CODE),SM_NAME,WEEK,COMP,DIVN,STG2_NOS,STG2_AMT,STG3_NOS,STG3_AMT,STG4_NOS,STG4_AMT,STG5_NOS,STG5_AMT FROM OM_SALESMAN,STG2_STG3_STG4_SMDIVNWEEK   WHERE SM_FLEX_07='Y' AND SM=SM_CODE AND SM_FRZ_FLAG_NUM=2 and  SM_FLEX_18 = ? ) T ORDER BY 4,5,3";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, smCode);
			myStmt.setString(2, smCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String smcode = myRes.getString(1);
				String smname = myRes.getString(2);
				String week = myRes.getString(3);
				String company = myRes.getString(4);
				String division = myRes.getString(5);
				String s2Count = myRes.getString(6);
				String s2Value = myRes.getString(7);
				String s3Count = myRes.getString(8);
				String s3Value = myRes.getString(9);
				String s4Count = myRes.getString(10);
				String s4Value = myRes.getString(11);
				String s5Count = myRes.getString(12);
				String s5Value = myRes.getString(13);
				SipWeeklyReport tempSalesmanList = new SipWeeklyReport(week, company, division, s2Count, s2Value,
						s3Count, s3Value, s4Count, s4Value, s5Count, s5Value, smcode, smname);
				salesEngList.add(tempSalesmanList);
			}

		} catch (SQLException e) {
			System.out.println("" + e);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		System.out.println("salesEngList" + salesEngList.size());
		return salesEngList;
	}

	public List<SipWeeklyReport> getWeeklyReportForSalesEngineerForManagement(String smCode) throws SQLException {
		List<SipWeeklyReport> salesEngList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * from ( SELECT DISTINCT(SM_CODE),SM_NAME,WEEK,COMP,DIVN,STG2_NOS,STG2_AMT,STG3_NOS,STG3_AMT,STG4_NOS,STG4_AMT,STG5_NOS,STG5_AMT FROM OM_SALESMAN,STG2_STG3_STG4_SMDIVNWEEK\r\n"
					+ "WHERE sm_frz_flag_num=2 AND SM=SM_CODE AND (sm_flex_07='Y' OR sm_flex_09='Y') AND SM_FLEX_08 IN ( SELECT EMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2'))) Order by 4,5,3";
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String smcode = myRes.getString(1);
				String smname = myRes.getString(2);
				String week = myRes.getString(3);
				String company = myRes.getString(4);
				String division = myRes.getString(5);
				String s2Count = myRes.getString(6);
				String s2Value = myRes.getString(7);
				String s3Count = myRes.getString(8);
				String s3Value = myRes.getString(9);
				String s4Count = myRes.getString(10);
				String s4Value = myRes.getString(11);
				String s5Count = myRes.getString(12);
				String s5Value = myRes.getString(13);
				SipWeeklyReport tempSalesmanList = new SipWeeklyReport(week, company, division, s2Count, s2Value,
						s3Count, s3Value, s4Count, s4Value, s5Count, s5Value, smcode, smname);
				salesEngList.add(tempSalesmanList);
			}

		} catch (SQLException e) {
			System.out.println("" + e);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		System.out.println("salesEngList" + salesEngList.size());
		return salesEngList;
	}

}