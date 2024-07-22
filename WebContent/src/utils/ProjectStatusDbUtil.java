package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.ProjectStatusDetails;

public class ProjectStatusDbUtil {

	public List<ProjectStatusDetails> getProjectStatusDetails() throws SQLException {
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;

		List<ProjectStatusDetails> projectStatusDetails = new ArrayList<>();

		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "SELECT * FROM FJPORTAL.SM_STG2_STG3_STG4_TBL";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String stage = myRes.getString(1);
				String txnCode = myRes.getString(2);
				String txnNo = myRes.getString(3);
				String txtDate = myRes.getString(4);
				String loiDate = myRes.getString(5);
				String expPODate = myRes.getString(6);
				String expInvDate = myRes.getString(7);
				int amount = myRes.getInt(8);
				String smCode = myRes.getString(9);
				String smName = myRes.getString(10);
				String status = myRes.getString(11);
				String email = myRes.getString(12);
				String projectnName = myRes.getString(13);
				String consultant = myRes.getString(14);
				String customer = myRes.getString(15);
				int consultantWinning = myRes.getInt(16);
				int contractorWinning = myRes.getInt(17);
				int totalWinning = myRes.getInt(18);
				String txnName = myRes.getString(19);
				ProjectStatusDetails projectDetails = new ProjectStatusDetails(stage, txnCode, txnNo, txtDate, loiDate,
						expPODate, expInvDate, amount, smCode, smName, projectnName, consultant, customer, status,
						email, consultantWinning, contractorWinning, totalWinning, txnName);

				projectStatusDetails.add(projectDetails);

			}
			return projectStatusDetails;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<ProjectStatusDetails> getProjectStatusDetails(String dm_emp_code) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		List<ProjectStatusDetails> projectStatusDetails = new ArrayList<>();
		try {
			myCon = orcl.getOrclConn();

			String sql = "SELECT * FROM FJPORTAL.SM_STG2_STG3_STG4_TBL WHERE SMCODE IN ( "
					+ "   SELECT SM_CODE FROM ( SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME FROM OM_SALESMAN   "
					+ "   WHERE   SM_FRZ_FLAG_NUM=2 and   SM_FLEX_08 =  ?  UNION "
					+ "   SELECT SM_CODE, SM_NAME,SM_FLEX_08, SM_BL_SHORT_NAME FROM OM_SALESMAN   "
					+ "   WHERE SM_FLEX_07='Y' AND SM_FRZ_FLAG_NUM=2 and  SM_FLEX_18 = ? ) T)";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myStmt.setString(2, dm_emp_code);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String stage = myRes.getString(1);
				String txnCode = myRes.getString(2);
				String txnNo = myRes.getString(3);
				String txtDate = myRes.getString(4);
				String loiDate = myRes.getString(5);
				String expPODate = myRes.getString(6);
				String expInvDate = myRes.getString(7);
				int amount = myRes.getInt(8);
				String smCode = myRes.getString(9);
				String smName = myRes.getString(10);
				String status = myRes.getString(11);
				String email = myRes.getString(12);
				String projectnName = myRes.getString(13);
				String consultant = myRes.getString(14);
				String customer = myRes.getString(15);
				int consultantWinning = myRes.getInt(16);
				int contractorWinning = myRes.getInt(17);
				int totalWinning = myRes.getInt(18);
				String txnName = myRes.getString(19);
				ProjectStatusDetails projectDetails = new ProjectStatusDetails(stage, txnCode, txnNo, txtDate, loiDate,
						expPODate, expInvDate, amount, smCode, smName, projectnName, consultant, customer, status,
						email, consultantWinning, contractorWinning, totalWinning, txnName);

				projectStatusDetails.add(projectDetails);

			}
			return projectStatusDetails;

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
