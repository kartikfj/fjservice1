package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.Payslip;

public class PayslipDbUtil {

	public List<Payslip> getDefaultPayslipReportData(String empCode, String fpmonth) throws SQLException {

		List<Payslip> payslipDetails = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM FJPORTAL.PAYSLIP " + "WHERE FP_EMP_CODE = ? " + " AND FP_PROC_MTH = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setString(2, fpmonth);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String yearMonth_tmp = myRes.getString(1);
				String desc_tmp = myRes.getString(3);
				double amount_tmp = Double.parseDouble(myRes.getString(4));
				String company_name = myRes.getString(6);
				Payslip tempPayslipDetails = new Payslip(yearMonth_tmp, desc_tmp, amount_tmp, company_name);
				payslipDetails.add(tempPayslipDetails);
			}
			return payslipDetails;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Payslip> getCustomPayslipReportData(String empCode, String fpmonth) throws SQLException {
		// System.out.println(fpmonth);
		List<Payslip> payslipDetails = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM FJPORTAL.PAYSLIP " + "WHERE FP_EMP_CODE = ? " + " AND FP_PROC_MTH = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setString(2, fpmonth);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String yearMonth_tmp = myRes.getString(1);
				String desc_tmp = myRes.getString(3);
				double amount_tmp = Double.parseDouble(myRes.getString(4));
				String company_name = myRes.getString(6);
				Payslip tempPayslipDetails = new Payslip(yearMonth_tmp, desc_tmp, amount_tmp, company_name);
				payslipDetails.add(tempPayslipDetails);
			}
			return payslipDetails;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public String getCompanyName(String empCode, String fpmonth) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String companyName = "FAISAL JASSIM INDUSTRIES LLC";
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT CCDESC FROM FJPORTAL.PAYSLIP WHERE FP_EMP_CODE = ? AND FP_PROC_MTH = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setString(2, fpmonth);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				companyName = myRes.getString(1);
			}
			return companyName;
		} finally { // close jdbc objects
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
