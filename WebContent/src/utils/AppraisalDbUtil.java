package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.Achievements;
import beans.Appraisal;
import beans.AppraisalUserProfile;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class AppraisalDbUtil {
	// create a reference to a private data source

	// Create a Constructor (this for passing servlet parameter to db util)
	public AppraisalDbUtil() {

	}

	public void insetAppraisal(Appraisal theGsData) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "insert into appraisal_new (year, empid, appr_id, goal_type, goal, measure, target) values(?,?,?,?,?,?,?)";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, theGsData.getYear());
			myStmt.setString(2, theGsData.getEmpid());
			myStmt.setString(3, theGsData.getAppr_id());
			myStmt.setString(4, theGsData.getGoal_type());
			myStmt.setString(5, theGsData.getGoal());
			myStmt.setString(6, theGsData.getMeasure());
			myStmt.setString(7, theGsData.getTarget());

			// execute sql query
			myStmt.execute();

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

	public List<Appraisal> getEmployeeGoals(String uid, String tyear) throws SQLException {
		List<Appraisal> goalList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select * from appraisal_new where empid=? and year=?";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, uid);
			myStmt.setString(2, tyear);
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

	public String getUserForm(String year, String uid) {

		return uid;

	}

	public int getGoalSettingDate(String year, String uid) throws SQLException {
		String company = getUserCompany(uid);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		int output = 1;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select 1 as one from appraisalhr_new where "
					+ " year=?  and company=? and aprslstdt<=CURDATE()  and aprsleddt>=CURDATE() ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year);
			myStmt.setString(2, company);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				return output = 0;
			}

			return output;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	private String getUserCompany(String uid) throws SQLException {
		String fjtcouserCompany = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			// Get Connection
			myCon = orcl.getOrclConn();

			// Execute sql stamt
			String sql = "select  EMP_COMP_CODE as company FROM FJPORTAL.PM_EMP_KEY where EMP_CODE=? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, uid);
			myRes = myStmt.executeQuery();

			if (myRes.next()) {

				fjtcouserCompany = myRes.getString(1);

				// System.out.println("get User Company"+fjtcouserCompany);

			}
			return fjtcouserCompany;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public int getMidTermDate(String year, String uid) throws SQLException {
		String company = getUserCompany(uid);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		int output = 1;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select 1 as one from appraisalhr_new where "
					+ " year=?  and company=? and mdaprslstdt<=CURDATE()  and mdaprsleddt>=CURDATE() ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year);
			myStmt.setString(2, company);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				return output = 0;
			}

			return output;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int getFinalTermDate(String year, String uid) throws SQLException {

		String company = getUserCompany(uid);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		int output = 1;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select 1 as one from appraisalhr_new where "
					+ " year=?  and company=? and finalstdt<=CURDATE()  and finaleddt>=CURDATE() ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year);
			myStmt.setString(2, company);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				return output = 0;
			}

			return output;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void updateFtGoal(Appraisal editAppraisal) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set " + "goal =?, measure =?, target =? " + " where  goal_id =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, editAppraisal.getGoal());
			myStmt.setString(2, editAppraisal.getMeasure());
			myStmt.setString(3, editAppraisal.getTarget());
			myStmt.setInt(4, editAppraisal.getGoal_id());

			// execute sql query
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
	}

	public void deleteFtGoal(int goal_id) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from appraisal_new " + " where  goal_id =? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, goal_id);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
	}

	public int checkGoalCount(Appraisal theGsData) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select count(empid) as goal_count from appraisal_new "
					+ "where empid=? and year=? and  goal_type=? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theGsData.getEmpid());
			myStmt.setInt(2, theGsData.getYear());
			myStmt.setString(3, theGsData.getGoal_type());
			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				int count = myRes.getInt(1);
				System.out.println("gs testing " + count);
				return count;

			}
			return 0;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	/*
	 * public int getGoalApprovedDate(String year,String uid) throws SQLException {
	 * String company=getUserCompany(uid); Connection myCon=null; PreparedStatement
	 * myStmt=null; ResultSet myRes=null; int output = 1; MysqlDBConnectionPool con=
	 * new MysqlDBConnectionPool(); try {
	 * 
	 * //Get Connection myCon = con.getMysqlConn();
	 * 
	 * // Execute sql stamt String sql = "select 1 as one from appraisalhr where " +
	 * " year=?  and company=? and aprslstdt<=CURDATE()  and aprsleddt>=CURDATE() ";
	 * 
	 * myStmt=myCon.prepareStatement(sql); myStmt.setString(1,year);
	 * myStmt.setString(2,company); myRes=myStmt.executeQuery(); while
	 * (myRes.next()) {
	 * 
	 * return output = 0; }
	 * 
	 * return output; } finally { // close jdbc objects close(myStmt,myRes);
	 * con.closeConnection();
	 * 
	 * } }
	 * 
	 */

	public Appraisal getUserApprovedDetails(String year, String uid) throws SQLException {
		Appraisal appraisUserDt = null;
		// String apprr_id=getUserApproverId(uid);
		// String apprr_name=getUserApproverName(uid);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select distinct gs_approved,gs_apprddate,gs_approvedid,"
					+ "mid_approved,mid_apprddate,mid_approvedid,"
					+ "fin_approved,fin_apprddate,fin_approvedid from appraisal_new where " + " empid=? and year=?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, uid);
			myStmt.setString(2, year);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String appr_gs_yn = myRes.getString(1);
				String appr_gs_dt = myRes.getString(2);
				String appr_gs_by = myRes.getString(3);
				String appr_mid_yn = myRes.getString(4);
				String appr_mid_dt = myRes.getString(5);
				String appr_mid_by = myRes.getString(6);
				String appr_fin_yn = myRes.getString(7);
				String appr_fin_dt = myRes.getString(8);
				String appr_fin_by = myRes.getString(9);

				appraisUserDt = new Appraisal(appr_gs_yn, appr_gs_dt, appr_gs_by, appr_mid_yn, appr_mid_dt, appr_mid_by,
						appr_fin_yn, appr_fin_dt, appr_fin_by);

			}

			return appraisUserDt;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

//	private String getUserApproverId(String uid) throws SQLException {
//
//		String ApprId = null;
//
//		Connection myCon = null;
//		PreparedStatement myStmt = null;
//		ResultSet myRes = null;
//		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
//		try {
//			// Get Connection
//			myCon = orcl.getOrclConn();
//
//			// Execute sql stamt
//			String sql = "SELECT TXNFIELD_FLD3 from FJPORTAL.PT_TXN_FLEX_FIELDS "
//					+ "where TXNFIELD_EMP_CODE=? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1 ";
//			myStmt = myCon.prepareStatement(sql);
//			myStmt.setString(1, uid);
//			myRes = myStmt.executeQuery();
//
//			if (myRes.next()) {
//
//				ApprId = myRes.getString(1);
//
//				// System.out.println("get User Approver Id"+ApprId);
//
//			}
//			return ApprId;
//		} finally {
//			// close jdbc objects
//			close(myStmt, myRes);
//			orcl.closeConnection();
//
//		}
//	}

	public Object getMidtApprovedDetails(String string, String emp_com_code) {

		return null;
	}

	public Object getFinaltDetails(String string, String emp_com_code) {
		// TODO Auto-generated method stub
		return null;
	}

	public void updateMidProgAppraisal(Appraisal editMidProgAppr) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set " + "mdprogress=? " + " where  goal_id =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, editMidProgAppr.getMdprogress());
			myStmt.setInt(2, editMidProgAppr.getGoal_id());

			// execute sql query
			myStmt.execute();
			// System.out.println("getmid
			// id=+"+editMidProgAppr.getGoal_id()+""+editMidProgAppr.getMdprogress());

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public void updateFinProgAppraisal(Appraisal editFinProgAppr) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update appraisal_new " + "set " + "finalap=? " + " where  goal_id =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, editFinProgAppr.getFinalap());
			myStmt.setInt(2, editFinProgAppr.getGoal_id());

			// execute sql query
			myStmt.execute();
			// System.out.println("getmid
			// id=+"+editFinProgAppr.getGoal_id()+""+editFinProgAppr.getFinalap());

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public Object getPrvsAppraisalRprt(String year, String emp_com_code) throws SQLException {

		String company = getUserCompany(emp_com_code);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		int output = 1;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select 1 as one from appraisalhr_new where "
					+ " year=?  and company=? and  finaleddt<CURDATE() "; // changed less than or equal to in to less
																			// than

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, year);
			myStmt.setString(2, company);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				return output = -1;// return -1 if there a record is true, that is final term end date should less
									// than or equal to today date
			}

			return output;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int checkAchievementCount(Achievements theAchievementData) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select count(empid) as achievement_count from achievements_new "
					+ "where empid=? and year=? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theAchievementData.getEmpid());
			myStmt.setInt(2, theAchievementData.getYear());
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

	public void insertAchievements(Achievements theAchievementData) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "insert into achievements_new (year, empid, apprid, achievement) values(?,?,?,?)";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, theAchievementData.getYear());
			myStmt.setString(2, theAchievementData.getEmpid());
			myStmt.setString(3, theAchievementData.getAppr_id());
			myStmt.setString(4, theAchievementData.getAchievement());

			// execute sql query
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	/*
	 * int year=myRes.getInt(2); String empid=myRes.getString(3); String
	 * appr_id=myRes.getString(4);
	 * 
	 * String goal_type=myRes.getString(5); String goal=myRes.getString(6); String
	 * measure=myRes.getString(7); String target=myRes.getString(8);
	 * 
	 * String gs_approved=myRes.getString(5); String
	 * gs_apprddate=myRes.getString(6); String gs_approvedid=myRes.getString(7);
	 * String mdprogressA=myRes.getString(5); String mdremark=myRes.getString(6);
	 * String mdtrack=myRes.getString(7);
	 * 
	 * String mid_approved=myRes.getString(8); String
	 * mid_apprddate=myRes.getString(5); String mid_approvedid=myRes.getString(6);
	 * 
	 * String finalap=myRes.getString(7); String finalapA=myRes.getString(8); String
	 * finalremark=myRes.getString(8);
	 * 
	 * String fin_approved=myRes.getString(7); String
	 * fin_apprddate=myRes.getString(8); String fin_approvedid=myRes.getString(8);
	 */

	/*
	 * goal_id, year, empid, appr_id, goal_type, goal, measure, target, gs_approved,
	 * gs_apprddate, gs_approvedid, mdprogress, mdprogressA, mdremark, mdtrack,
	 * mid_approved, mid_apprddate, mid_approvedid, finalap, finalapA, finalremark,
	 * fin_approved, fin_apprddate, fin_approvedid
	 */

	public List<Achievements> getEmployeeAchievements(String uid, String tyear) throws SQLException {
		List<Achievements> achievementsList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select * from achievements_new where empid=? and year=?";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, uid);
			myStmt.setString(2, tyear);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				int goal_id = myRes.getInt(1);
				int year = myRes.getInt(2);
				String empid = myRes.getString(3);
				String appr_id = myRes.getString(4);
				String goal_type = myRes.getString(5);

				Achievements tempAchvList = new Achievements(goal_id, year, empid, appr_id, goal_type);
				// System.out.println("goal_list"+goal_id);

				achievementsList.add(tempAchvList);

			}
			return achievementsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void updateAchvmtDb(Achievements editAchievements) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update achievements_new " + "set " + "achievement=? " + " where  achevmnt_id=? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, editAchievements.getAchievement());
			myStmt.setInt(2, editAchievements.getAchvmt_id());

			// execute sql query
			myStmt.execute();
			// System.out.println("getAchmnt
			// id=+"+editAchievements.getAchvmt_id()+"text"+editAchievements.getAchievement());

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public void deleteDbAchv(int achv_id) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from achievements_new " + " where  achevmnt_id=? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, achv_id);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public AppraisalUserProfile getUserProfileDetails(String emp_com_code) throws SQLException {
		AppraisalUserProfile fjtcouserData = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			// Get Connection
			myCon = orcl.getOrclConn();

			// Execute sql stamt
			String sql = "select * from FJPORTAL.PM_EMP_KEY "
					+ "where EMP_CODE=? and EMP_STATUS in (1,2) and EMP_FRZ_FLAG='N' and EMP_COMP_CODE <>'ALP'";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_com_code);
			myRes = myStmt.executeQuery();

			if (myRes.next()) {

				String company = myRes.getString(1);
				String emp_id = myRes.getString(2);
				String emp_name = myRes.getString(3);
				String job_title = myRes.getString(32);
				String div = myRes.getString(33);
				String dept = myRes.getString(34);
				String location = myRes.getString(38);
				// System.out.println("get User Data"+company+" "+emp_id+" "+emp_name+"
				// "+job_title+" "+div+" "+dept+" "+location);
				// create a new Fjtco User List object
				fjtcouserData = new AppraisalUserProfile(company, emp_id, emp_name, job_title, div, dept, location);

				// add this to a array list of FjtcoUser

			}
			return fjtcouserData;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

}
