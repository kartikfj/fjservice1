package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.AppraisalHr;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class AppraisalHrDbUtil {

	// create a reference to a private data source
	// private DataSource dataSource;

	public AppraisalHrDbUtil() {

	}

	public void addFirstTermGoals(AppraisalHr theGoalDateSet) throws Exception {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// create sql query for insert
			String sql = "insert into appraisalhr_new (year, aprslstdt, aprsleddt, company, empid, modified) values(?,?,?,?,?,?)";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, theGoalDateSet.getYear());
			myStmt.setString(2, theGoalDateSet.getAppraisalSldt());
			myStmt.setString(3, theGoalDateSet.getAppraisalEdt());
			myStmt.setString(4, theGoalDateSet.getCompany());
			myStmt.setString(5, theGoalDateSet.getEmploye_id());
			myStmt.setString(6, theGoalDateSet.getModified());

			// execute sql query
			myStmt.execute();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();
		}

	}

	public String checkDistinct(AppraisalHr theGoalDateSet) throws Exception {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();
			// select distinct year,company from `fjtco`.`appraisalhr` where year=2018 and
			// company='001';
			String sql = "select distinct year, company from appraisalhr_new "
					+ " where year=? and company=? and aprslstdt IS NOT NULL ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, theGoalDateSet.getYear());
			myStmt.setString(2, theGoalDateSet.getCompany());
			myRes = myStmt.executeQuery();
			if (myRes.next()) {
				return myRes.getString(1) + " " + myRes.getString(2);
			} else {
				return null;
				// throw new Exception("could not find the company :"+company);
			}

		} finally {
			close(myStmt, null);
			con.closeConnection();
		}

	}

	public void updateFirsttoMid(AppraisalHr theGoalDateSet) throws Exception {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			// create sql UPDATE statement , if goals setting is not null
			String sql = "update appraisalhr_new " + "set mdaprslstdt=?, mdaprsleddt=?" + "where year=? and company=? ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);

			// set params
			myStmt.setString(1, theGoalDateSet.getMidappSdt());
			myStmt.setString(2, theGoalDateSet.getMidappEdt());
			myStmt.setInt(3, theGoalDateSet.getYear());
			myStmt.setString(4, theGoalDateSet.getCompany());

			// execute sql statement
			myStmt.execute();// use execute() if no result set

		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}

	}

	public String checkDistinctMdTerm(AppraisalHr theGoalDateSet) throws Exception {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			// select distinct year,company from `fjtco`.`appraisalhr` where year=2018 and
			// company='001'
			// and mdaprslstdt IS NOT NULL ;
			String sql = "select distinct year, company from appraisalhr_new " + " where year=? and company=? "
					+ " and mdaprslstdt IS NOT NULL ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, theGoalDateSet.getYear());
			myStmt.setString(2, theGoalDateSet.getCompany());
			myRes = myStmt.executeQuery();
			if (myRes.next()) {
				return myRes.getString(1) + " " + myRes.getString(2);
			} else {
				return null;
				// throw new Exception("could not find the company :"+company);
			}

		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}

	}

	public void updateMidtoFinal(AppraisalHr theGoalDateSet) throws Exception {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// create sql UPDATE statement
			String sql = "update appraisalhr_new " + "set finalstdt=?, finaleddt=? " + " where year=? and company=? ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);

			// set params
			myStmt.setString(1, theGoalDateSet.getFinappStd());
			myStmt.setString(2, theGoalDateSet.getFinappEdt());
			myStmt.setInt(3, theGoalDateSet.getYear());
			myStmt.setString(4, theGoalDateSet.getCompany());

			// execute sql statement
			myStmt.execute();// use execute() if no result set

		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}

	}

	public List<AppraisalHr> getAppraisalDates() throws Exception {

		List<AppraisalHr> hrAppraisalList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			// Execute sql stamt
			String sql = "select * from appraisalhr_new ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);

			// Process the result set
			while (myRes.next()) {
				int year = myRes.getInt(1);
				String appraisalSldt = myRes.getString(2);
				String appraisalEdt = myRes.getString(3);
				String midappSdt = myRes.getString(4);
				String midappEdt = myRes.getString(5);
				String finappStd = myRes.getString(6);
				String finappEdt = myRes.getString(7);
				String company = myRes.getString(9);
				String employe_id = myRes.getString(8);
				String modified = myRes.getString(10);

				// create a new AppraisalHr object
				AppraisalHr tempList = new AppraisalHr(year, appraisalSldt, appraisalEdt, midappSdt, midappEdt,
						finappStd, finappEdt, company, employe_id, modified);
				// System.out.println("modified db 2 by"+modified);
				// add this to a array list of AppraisalHr
				hrAppraisalList.add(tempList);

			}
			return hrAppraisalList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public AppraisalHr getSelectedAppraisalDates(String cmp, int yr) throws Exception {

		AppraisalHr hrAppraisal = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			// Execute sql stamt
			String sql = " select * from appraisalhr_new " + " where year=? and company=? ";
			// create a prepare statement
			myStmt = myCon.prepareStatement(sql);

			// set params
			myStmt.setInt(1, yr);
			myStmt.setString(2, cmp);

			// execute statement
			myRes = myStmt.executeQuery();

			// Process the result set
			if (myRes.next()) {
				int year = myRes.getInt(1);
				String appraisalSldt = myRes.getString(2);
				String appraisalEdt = myRes.getString(3);
				String midappSdt = myRes.getString(4);
				String midappEdt = myRes.getString(5);
				String finappStd = myRes.getString(6);
				String finappEdt = myRes.getString(7);
				String employe_id = myRes.getString(8);
				String company = myRes.getString(9);
				String modified = myRes.getString(10);

				// System.out.println(year+" "+appraisalSldt+" "+appraisalEdt+" "+midappSdt+"
				// "+midappEdt+" "+finappStd+" "+finappEdt+" "+company+" "+employe_id);
				// create a new AppraisalHr object
				hrAppraisal = new AppraisalHr(year, appraisalSldt, appraisalEdt, midappSdt, midappEdt, finappStd,
						finappEdt, company, employe_id, modified);

				// System.out.println("modified db 1 by"+modified);

			}
			return hrAppraisal;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();
		}

	}

	public void modifyHrAppraisal(AppraisalHr mDates) throws Exception {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();
			// System.out.println("modified hr appraisal by"+mDates.getModified());

			// create sql UPDATE statement for modify from editdates.jsp
			String sql = "update appraisalhr_new " + "set "
			// + "empid=?, "
					+ " aprslstdt=?, aprsleddt=?, " + " mdaprslstdt=?, mdaprsleddt=?, "
					+ " finalstdt=?, finaleddt=?, modified=? " + " where year=? and company=? ";

			// prepare statement
			myStmt = myCon.prepareStatement(sql);

			// set params
			// myStmt.setString(1,mDates.getEmploye_id());
			myStmt.setString(1, mDates.getAppraisalSldt());
			myStmt.setString(2, mDates.getAppraisalEdt());
			myStmt.setString(3, mDates.getMidappSdt());
			myStmt.setString(4, mDates.getMidappEdt());
			myStmt.setString(5, mDates.getFinappStd());
			myStmt.setString(6, mDates.getFinappEdt());
			myStmt.setString(7, mDates.getModified());
			myStmt.setInt(8, mDates.getYear());
			myStmt.setString(9, mDates.getCompany());

			// System.out.println("modified hr appraisal by"+mDates.getModified());
			// execute sql statement
			myStmt.execute();// use execute() if no result set

		} finally {
			close(myStmt, null);
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

	public List<AppraisalHr> getCompanyList() throws SQLException {

		List<AppraisalHr> hrAppraisalList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			// Get Connection
			myCon = orcl.getOrclConn();
			// String usrsql = "select distinct emp_comp_code as company from pm_emp_key
			// where emp_status in (1,2) and emp_frz_flag='N' and emp_comp_code <>'ALP'";
			String sql = " SELECT DISTINCT EMP_COMP_CODE FROM FJPORTAL.PM_EMP_KEY where EMP_STATUS in (1,2) and EMP_FRZ_FLAG='N' and EMP_COMP_CODE <>'ALP' ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);

			// Process the result set
			while (myRes.next()) {

				String company = myRes.getString(1);
				// System.out.println(myRes.next());
				// System.out.println("company"+company);
				AppraisalHr tempList1 = new AppraisalHr(company);
				// add this to a array list of AppraisalHr
				hrAppraisalList.add(tempList1);

			}
			return hrAppraisalList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}
}
