package utils;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.Appraisal;
import beans.AppraisalEmpDtlsforApprover;
import beans.Approver;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.Overview; 

public class ApproverDbUtil {

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

	public List<Approver> getYear() throws SQLException {

		List<Approver> yearList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "select  distinct year from appraisalhr_new  " + "where year <= YEAR(CURDATE())+1";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {

				String year = myRes.getString(1);

				Approver tempYearList = new Approver(year);
				// System.out.println("Appraisee_list"+tempYearList.toString());
				// add appraise id's to a array list of Approver
				yearList.add(tempYearList);

			}
			return yearList;

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

	public List<Appraisal> getSelectedEmployeeGoals(String emp_id, int yearl) throws SQLException {
		List<Appraisal> goalList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select * from appraisal_new where empid=? and year=? ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, emp_id);
			myStmt.setInt(2, yearl);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				int goal_id = myRes.getInt(1);
				int year = myRes.getInt(2);
				String empid = myRes.getString(3);
				String appr_id = myRes.getString(4);
				String goal_type = myRes.getString(5);
				String goal = myRes.getString(6);
				String measure = myRes.getString(7);
				String target = myRes.getString(8);

				String gs_approved = myRes.getString(9);
				String gs_apprddate = myRes.getString(10);
				String gs_approvedid = myRes.getString(11);
				String mdprogress = myRes.getString(12);
				String mdprogressA = myRes.getString(13);
				String mdremark = myRes.getString(14);
				String mdtrack = myRes.getString(15);

				String mid_approved = myRes.getString(16);
				String mid_apprddate = myRes.getString(17);
				String mid_approvedid = myRes.getString(18);

				String finalap = myRes.getString(19);
				String finalapA = myRes.getString(20);
				String finalremark = myRes.getString(21);

				String fin_approved = myRes.getString(22);
				String fin_apprddate = myRes.getString(23);
				String fin_approvedid = myRes.getString(24);

				/*
				 * goal_id, year, empid, appr_id, goal_type, goal, measure, target, gs_approved,
				 * gs_apprddate, gs_approvedid, mdprogress, mdprogressA, mdremark, mdtrack,
				 * mid_approved, mid_apprddate, mid_approvedid, finalap, finalapA, finalremark,
				 * fin_approved, fin_apprddate, fin_approvedid
				 */

				// create a new AppraisalHr object
				Appraisal tempGoalList = new Appraisal(goal_id, year, empid, appr_id, goal_type, goal, measure, target,
						gs_approved, gs_apprddate, gs_approvedid, mdprogress, mdprogressA, mdremark, mdtrack,
						mid_approved, mid_apprddate, mid_approvedid, finalap, finalapA, finalremark, fin_approved,
						fin_apprddate, fin_approvedid);
				// System.out.println("goal_list"+goal_id);
				// add this to a array list of AppraisalHr
				goalList.add(tempGoalList);

			}
			return goalList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void approveEmployeeMidTermAppraisal(String year, String approver_id, String emp_id) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set "
					+ "mid_approved='YES', mid_apprddate=curdate(), mid_approvedid=? "
					+ " where  empid=? and year=? and goal_id > 0 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approver_id);
			myStmt.setString(2, emp_id);
			myStmt.setString(3, year);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();
		}
	}

	public void approveEmployeeGoalSettings(String year, String approver_id, String emp_id) throws SQLException {
		// System.out.println("Updated ENTERED NUFAIL");
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();
			// System.out.println("Updated Nufail Connectio Created");
			String sql = "update appraisal_new " + "set "
					+ "gs_approved='YES', gs_apprddate=curdate(), gs_approvedid=? "
					+ " where  empid=? and year=? and goal_id > 0 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approver_id);
			myStmt.setString(2, emp_id);
			myStmt.setString(3, year);
			myStmt.execute();
			// System.out.println("Updated Successfully");

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public void approveEmployeeFinalTermAppraisal(String year, String approver_id, String emp_id) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set "
					+ "fin_approved='YES', fin_apprddate=curdate(), fin_approvedid=? "
					+ " where  empid=? and year=? and goal_id > 0 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approver_id);
			myStmt.setString(2, emp_id);
			myStmt.setString(3, year);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
	}

	public void updateMidProgressDetails(Appraisal theMidProgressApprover) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set " + "mdprogressA=?, mdremark=?, mdtrack=? "
					+ " where  goal_id =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, theMidProgressApprover.getMdprogressA());
			myStmt.setString(2, theMidProgressApprover.getMdremark());
			myStmt.setString(3, theMidProgressApprover.getMdtrack());
			myStmt.setInt(4, theMidProgressApprover.getGoal_id());

			// execute sql query
			myStmt.execute();

			// System.out.println("getmid
			// id=+"+theMidProgressApprover.getGoal_id()+""+theMidProgressApprover.getMdprogress());

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public void updateFinProgDetails(Appraisal theFinProgA) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set " + "finalapA=?, finalremark=? " + " where  goal_id =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, theFinProgA.getFinalapA());
			myStmt.setString(2, theFinProgA.getFinalremark());
			myStmt.setInt(3, theFinProgA.getGoal_id());

			// execute sql query
			myStmt.execute();

			// System.out.println("getmid
			// id=+"+theFinProgA.getGoal_id()+""+theFinProgA.getFinalapA());

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
	}

	public int checkOverviewCount(Overview theOverviewData) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select count(empid) as overview_count from overview_new " + "where empid=? and year=? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theOverviewData.getEmpid());
			myStmt.setInt(2, theOverviewData.getYear());
			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				int count = myRes.getInt(1);
				// System.out.println(count);
				return count;

			}
			return 0;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public Overview getEmployeeOverview(String emp_id, String tyear) throws SQLException {
		Overview overviewList = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select * from overview_new where empid=? and year=?";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, emp_id);
			myStmt.setString(2, tyear);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				int overview_id = myRes.getInt(1);
				int year = myRes.getInt(2);
				String empid = myRes.getString(3);
				String appr_id = myRes.getString(4);

				String strength = myRes.getString(5);
				String improvement = myRes.getString(6);

				String rating = myRes.getString(7);
				String promotion = myRes.getString(8);
				String sign_off = myRes.getString(9);

				Overview tempOverviewList = new Overview(overview_id, year, empid, appr_id, strength, improvement,
						rating, promotion, sign_off);
				// System.out.println("goal_list"+overview_id);

				overviewList = tempOverviewList;

			}
			return overviewList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void insertOverview(Overview theOverviewData) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "insert into overview_new (year, empid, apprid, strength, improvement, rating, promotion, sign_off) values(?,?,?,?,?,?,?,?)";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, theOverviewData.getYear());
			myStmt.setString(2, theOverviewData.getEmpid());
			myStmt.setString(3, theOverviewData.getAppr_id());
			myStmt.setString(4, theOverviewData.getStrength());
			myStmt.setString(5, theOverviewData.getImprovement());
			myStmt.setString(6, theOverviewData.getRating());
			myStmt.setString(7, theOverviewData.getPromotion());
			myStmt.setString(8, theOverviewData.getSign_off());

			// execute sql query
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public void updateOvrerviewDetails(Overview theUpdateOverviewList) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update overview_new " + "set " + "apprid=?, strength=?, improvement=?, rating=?, promotion=? "
					+ " where   overview_id=?  ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theUpdateOverviewList.getAppr_id());
			myStmt.setString(2, theUpdateOverviewList.getStrength());
			myStmt.setString(3, theUpdateOverviewList.getImprovement());
			myStmt.setString(4, theUpdateOverviewList.getRating());
			myStmt.setString(5, theUpdateOverviewList.getPromotion());
			myStmt.setInt(6, theUpdateOverviewList.getOverview_id());
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();
		}

	}

	public void deleteOverview(int overview_id) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from overview_new " + " where  overview_id=? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, overview_id);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public void approveEmployeeFinalReview(Overview approveOverView) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update overview_new " + "set " + "apprid=?, sign_off=?  " + " where   overview_id=?  ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, approveOverView.getAppr_id());
			myStmt.setString(2, approveOverView.getSign_off());
			myStmt.setInt(3, approveOverView.getOverview_id());

			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();
		}

	}

	public List<AppraisalEmpDtlsforApprover> getAppraiseeDetails(String apprvaisee_id) throws SQLException {

		List<AppraisalEmpDtlsforApprover> appraiseeDetails = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  EMP_CODE,EMP_NAME,EMP_COMP_CODE,EMP_DIVN_CODE,EMP_DEPT_CODE,EMP_JOIN_DT,EMP_JOB_LONG_DESC,EMP_LOCN_CODE FROM PM_EMP_KEY WHERE EMP_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, apprvaisee_id);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String aprise_code = myRes.getString(1);
				String aprise_name = myRes.getString(2);
				String aprise_company = myRes.getString(3);
				String aprise_divn = myRes.getString(4);
				String aprise_dept = myRes.getString(5);
				String aprise_joing_dt = myRes.getString(6);
				String aprise_designation = myRes.getString(7);
				String location = myRes.getString(8);
				AppraisalEmpDtlsforApprover tempappraiseeDetails = new AppraisalEmpDtlsforApprover(aprise_code,
						aprise_name, aprise_company, aprise_divn, aprise_dept, aprise_joing_dt, aprise_designation,
						location);
				appraiseeDetails.add(tempappraiseeDetails);
			}
			return appraiseeDetails;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

}