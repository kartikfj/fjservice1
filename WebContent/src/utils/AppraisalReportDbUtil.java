package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.AppraisalReport;
import beans.Appraisal_Email_Status;
import beans.EmployeeLateComeReport;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class AppraisalReportDbUtil {

	private String compcode = "001";
	private String sectionCode = "AC";

	public String getCompcode() {
		return compcode;
	}

	public void setCompcode(String compcode) {
		this.compcode = compcode;
	}

	public String getSectionCode() {
		return sectionCode;
	}

	public void setSectionCode(String sectionCode) {
		this.sectionCode = sectionCode;
	}

	public List<Appraisal_Email_Status> getDivisionAppraisalReportList(int i) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Appraisal_Email_Status> getAppraisalReportList(int year) throws Exception {

		List<Appraisal_Email_Status> hrAppraisaReportlList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "SELECT * FROM email_submit_details where year=? ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String emp_code = myRes.getString(1);
				String year_res = myRes.getString(2);
				String division = myRes.getString(3);
				String company = myRes.getString(4);
				String employee_name = myRes.getString(5);
				String gs_date = myRes.getString(6);
				String gs_status = myRes.getString(7);
				String g_notify_dt = myRes.getString(8);
				String g_notify_status = myRes.getString(9);
				String g_notify_id = myRes.getString(10);
				String g_notify_name = myRes.getString(11);
				String g_aprvd_dt = myRes.getString(12);
				String g_aprvd_id = myRes.getString(13);
				String g_aprvd_name = myRes.getString(14);
				String g_aprvd_status = myRes.getString(15);
				String mid_date = myRes.getString(16);
				String mid_status = myRes.getString(17);
				String mid_notify_dt = myRes.getString(18);
				String mid_notify_status = myRes.getString(19);
				String mid_notify_id = myRes.getString(20);
				String mid_notify_name = myRes.getString(21);
				String mid_aprvd_dt = myRes.getString(22);
				String mid_aprvd_id = myRes.getString(23);
				String mid_aprvd_name = myRes.getString(24);
				String mid_aprvd_status = myRes.getString(25);
				String fin_date = myRes.getString(26);
				String fin_status = myRes.getString(27);
				String fin_notify_dt = myRes.getString(28);
				String fin_notify_status = myRes.getString(29);
				String fin_notify_id = myRes.getString(30);
				String fin_notify_name = myRes.getString(31);
				String fin_aprvd_dt = myRes.getString(32);
				String fin_aprvd_id = myRes.getString(33);
				String fin_aprvd_name = myRes.getString(34);
				String fin_aprvd_status = myRes.getString(35);

				Appraisal_Email_Status tempReportList = new Appraisal_Email_Status(emp_code, year_res, division,
						company, employee_name, gs_date, gs_status, g_notify_dt, g_notify_status, g_notify_id,
						g_notify_name, g_aprvd_dt, g_aprvd_id, g_aprvd_name, g_aprvd_status, mid_date, mid_status,
						mid_notify_dt, mid_notify_status, mid_notify_id, mid_notify_name, mid_aprvd_dt, mid_aprvd_id,
						mid_aprvd_name, mid_aprvd_status, fin_date, fin_status, fin_notify_dt, fin_notify_status,
						fin_notify_id, fin_notify_name, fin_aprvd_dt, fin_aprvd_id, fin_aprvd_name, fin_aprvd_status);
				hrAppraisaReportlList.add(tempReportList);
			}
			return hrAppraisaReportlList;
		} finally {
			close(myStmt, null);
			con.closeConnection();

		}

	}

	public List<AppraisalReport> getCompanyList() throws SQLException {

		List<AppraisalReport> hrCompanyList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			// Get Connection
			myCon = orcl.getOrclConn();

			String sql = "SELECT COMP_CODE FROM FJPORTAL.FM_COMPANY where COMP_FRZ_FLAG = 'N' order by COMP_CODE ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {

				String company = myRes.getString(1);

				AppraisalReport tempCompanyList = new AppraisalReport(company);
				hrCompanyList.add(tempCompanyList);
			}
			return hrCompanyList;

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

	//
	public List<AppraisalReport> getReportDetailsAllEmployee(String year1, String divCode, String company)
			throws SQLException {
		System.out.println("Company code" + company + " div " + divCode + " year" + year1);
		List<AppraisalReport> hrAppraisaReportlList = new ArrayList<>();
		String calendarCode = "SUN-THU";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT EMP_CODE,EMP_NAME,EMP_JOB_LONG_DESC  FROM FJPORTAL.PM_EMP_KEY WHERE EMP_COMP_CODE = ? AND EMP_FRZ_FLAG = 'N' "
					+ "AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_DIVN_CODE= ? AND EMP_CALENDAR_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, company);
			myStmt.setString(2, divCode);
			myStmt.setString(3, calendarCode);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String emp_code = myRes.getString(1);
				String emp_name = myRes.getString(2);
				String emp_designation = myRes.getString(3);

				hrAppraisaReportlList.add(
						getDivisionAppraisalReportList(year1, divCode, emp_code, emp_name, emp_designation, company));
			}
			return hrAppraisaReportlList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public AppraisalReport getDivisionAppraisalReportList(String year1, String division1, String emp_Code,
			String emp_name, String emp_designation, String company_code) throws SQLException {
		AppraisalReport hrAppraisaReportlList = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "SELECT * FROM email_submit_details where year=? and division = ? and emp_id = ?";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year1);
			myStmt.setString(2, division1);
			myStmt.setString(3, emp_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String emp_code = myRes.getString(1);
				String year_res = myRes.getString(2);
				String division = myRes.getString(3);
				String company = myRes.getString(4);
				String employee_name = myRes.getString(5);
				String gs_date = myRes.getString(6);
				String gs_status = myRes.getString(7);
				String g_notify_dt = myRes.getString(8);
				String g_notify_status = myRes.getString(9);
				String g_notify_id = myRes.getString(10);
				String g_notify_name = myRes.getString(11);
				String g_aprvd_dt = myRes.getString(12);
				String g_aprvd_id = myRes.getString(13);
				String g_aprvd_name = myRes.getString(14);
				String g_aprvd_status = myRes.getString(15);
				String mid_date = myRes.getString(16);
				String mid_status = myRes.getString(17);
				String mid_notify_dt = myRes.getString(18);
				String mid_notify_status = myRes.getString(19);
				String mid_notify_id = myRes.getString(20);
				String mid_notify_name = myRes.getString(21);
				String mid_aprvd_dt = myRes.getString(22);
				String mid_aprvd_id = myRes.getString(23);
				String mid_aprvd_name = myRes.getString(24);
				String mid_aprvd_status = myRes.getString(25);
				String fin_date = myRes.getString(26);
				String fin_status = myRes.getString(27);
				String fin_notify_dt = myRes.getString(28);
				String fin_notify_status = myRes.getString(29);
				String fin_notify_id = myRes.getString(30);
				String fin_notify_name = myRes.getString(31);
				String fin_aprvd_dt = myRes.getString(32);
				String fin_aprvd_id = myRes.getString(33);
				String fin_aprvd_name = myRes.getString(34);
				String fin_aprvd_status = myRes.getString(35);

				hrAppraisaReportlList = new AppraisalReport(emp_code, year_res, division, employee_name, company,
						gs_date, gs_status, g_notify_dt, g_notify_status, g_notify_id, g_notify_name, g_aprvd_dt,
						g_aprvd_id, g_aprvd_name, g_aprvd_status, mid_date, mid_status, mid_notify_dt,
						mid_notify_status, mid_notify_id, mid_notify_name, mid_aprvd_dt, mid_aprvd_id, mid_aprvd_name,
						mid_aprvd_status, fin_date, fin_status, fin_notify_dt, fin_notify_status, fin_notify_id,
						fin_notify_name, fin_aprvd_dt, fin_aprvd_id, fin_aprvd_name, fin_aprvd_status, emp_designation);

			}
			if (hrAppraisaReportlList == null) {
				hrAppraisaReportlList = new AppraisalReport(emp_Code, year1, company_code, emp_name, division1, null,
						null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null,
						null, null, null, null, null, null, null, null, null, null, null, null, null, emp_designation);
				return hrAppraisaReportlList;
			} else {
				return hrAppraisaReportlList;
			}

		} finally {
			// close jdbc objects
			close(myStmt, null);
			con.closeConnection();
		}
	}

	public List<AppraisalReport> getDivisionList(String company_code) throws SQLException {
		List<AppraisalReport> divisionList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			// Get Connection
			myCon = orcl.getOrclConn();

			String sql = "SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, company_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String division = myRes.getString(1);

				AppraisalReport tempCompanyList = new AppraisalReport(division);
				divisionList.add(tempCompanyList);
			}
			return divisionList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}

	}

	public List<AppraisalReport> getAppraisalYear() throws SQLException {
		List<AppraisalReport> divisionList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			String sql = "select  distinct year from appraisalhr_new  order by year desc ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {

				String division = myRes.getString(1);

				AppraisalReport tempCompanyList = new AppraisalReport(division);
				divisionList.add(tempCompanyList);
			}
			return divisionList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	// for lijo special purpose montghly late come employee report start

	public List<EmployeeLateComeReport> getEmployeeLateComeReportList() throws SQLException {
		List<EmployeeLateComeReport> empLateList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = " SELECT accessCrdNo as accessNo,count(accessCrdNo) as latecount,  "
					+ " (SELECT user_id FROM fjtcouser where accesscrdNo = accessNo)as  "
					+ " emp_code FROM attendance   " + " where   " + " TIME(checkin) > ? and  "
					+ " workdate between ? and ?   " + " group by accessCrdNo  " + " having emp_code is not null "
					+ " order by latecount desc ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "08:30:59");
			myStmt.setString(2, "2019-01-01");
			myStmt.setString(3, "2019-01-31");
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String access_code = myRes.getString(1);
				String count = myRes.getString(2);
				String emp_code = myRes.getString(3);

				empLateList.add(getEmployeeDetails(emp_code, access_code, count));

			}
			return empLateList;

		} finally {
			// close jdbc objects
			close(myStmt, null);
			con.closeConnection();
		}
	}

	public EmployeeLateComeReport getEmployeeDetails(String empCode, String access_code, String count)
			throws SQLException {

		EmployeeLateComeReport empDetails = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT EMP_NAME,EMP_JOB_LONG_DESC,EMP_COMP_CODE,EMP_DIVN_CODE,EMP_FRZ_FLAG  FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String emp_name = myRes.getString(1);
				String emp_designation = myRes.getString(2);
				String company = myRes.getString(3);
				String division = myRes.getString(4);
				String frzflag = myRes.getString(5);

				empDetails = new EmployeeLateComeReport(empCode, count, access_code, emp_name, emp_designation, company,
						division, frzflag);

			}

			return empDetails;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	/// Emploee late punch end

}
