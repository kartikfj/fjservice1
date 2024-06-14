package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import beans.CustomerVisit;
import beans.DailyTask;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class DailyTaskDbUtil {

	public DailyTaskDbUtil() {
	}

	public int updateEmployeeTask(DailyTask theTask) throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			/*
			 * String sql= "update dailytask " + "set " +
			 * " task =?, desc=?, starttime=?, endtime=?, updated_date=now()  " +
			 * " where  id =? " ;
			 */
			String sql = " update dailytask  set "
					+ " `task` =?, `desc`=?, `starttime`=?, `endtime`=?, `updated_date`=now()  " + " where  id =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, theTask.getTtyp07());
			myStmt.setString(2, theTask.getTdesc08());
			myStmt.setString(3, theTask.getTst09());
			myStmt.setString(4, theTask.getTet10());
			myStmt.setString(5, theTask.getTid01());

			logType = myStmt.executeUpdate();
			// System.out.println( "task updated status:"+logType);

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
		return logType;
	}

	public int deleteATask(String task_id) throws SQLException {
		int logType = 1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from dailytask " + " where  id =? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, task_id);
			logType = myStmt.executeUpdate();
			// System.out.println( "task deleted status : "+logType);

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
		return logType;
	}

	public int createnewEmployeeTask(DailyTask theTask) throws SQLException {

		int logType = 1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			// String sql= "insert into dailytask(year, empid, salecode, workday, month,
			// task, desc, starttime, endtime, created_date) "
			// + " values(?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			String sql = "insert into dailytask(`year`,`empid`,`emp_name`,`company`,`division`,`salecode`,`workday`,`month`,`task`,`desc`,`starttime`,`endtime`,`created_date`) "
					+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,now()) ";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, theTask.getTyr02());
			myStmt.setString(2, theTask.getTuid03());
			myStmt.setString(3, theTask.getTendb11());// emp name
			myStmt.setString(4, theTask.getTecmp12());// emp company
			myStmt.setString(5, theTask.getTedvn13());// emp divison
			myStmt.setString(6, theTask.getTsid04());
			myStmt.setString(7, theTask.getTwd05());
			myStmt.setString(8, theTask.getTmth06());
			myStmt.setString(9, theTask.getTtyp07());
			myStmt.setString(10, theTask.getTdesc08());
			myStmt.setString(11, theTask.getTst09());
			myStmt.setString(12, theTask.getTet10());
			logType = myStmt.executeUpdate();
			// System.out.println( "task updated status:"+logType);

		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}
		return logType;
	}

	public List<DailyTask> getEmployeeTaskforCurrentMonth(String uid, String tyear, int tmonth) throws SQLException {
		List<DailyTask> taskList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();
			// Execute sql stamt
			String sql = "select * from dailytask where empid=? and year=? and month = ? ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, uid);
			myStmt.setString(2, tyear);
			myStmt.setInt(3, tmonth);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String task_id = myRes.getString(1);
				String year = myRes.getString(2);
				String empid = myRes.getString(3);
				String emp_name = myRes.getString(4);
				// System.out.println(emp_name);
				String company = myRes.getString(5);
				String division = myRes.getString(6);
				String salesid = myRes.getString(7);
				String workday = myRes.getString(8);
				String month = myRes.getString(9);
				String task = myRes.getString(10);
				String desc = myRes.getString(11);
				String start_time = myRes.getString(12);
				String end_time = myRes.getString(13);

				DailyTask tempGoalList = new DailyTask(task_id, year, empid, emp_name, company, division, salesid,
						workday, month, task, desc, start_time, end_time, "-", "-", "-");
				taskList.add(tempGoalList);
			}
			return taskList;
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

	public List<DailyTask> getSubordinatesDetails(String dmEmp_code) throws SQLException {
		List<DailyTask> subordianteList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT EMP_CODE,EMP_NAME from FJPORTAL.PM_EMP_KEY "
					+ " where  EMP_CODE in (SELECT TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS "
					+ " WHERE TXNFIELD_FLD3 = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1) "
					+ "AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') ";
			// + "AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND
			// EMP_CALENDAR_CODE = 'MON-FRI' ";

			/*
			 * String sql1 ="  SELECT EMP_CODE,EMP_NAME from FJPORTAL.PM_EMP_KEY" +
			 * "  where  EMP_CODE in ( "+
			 * "  SELECT T.TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS  T" +
			 * "  WHERE T.TXNFIELD_FLD3 = ? " + "  UNION" +
			 * "  SELECT T1.TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS T1,FJPORTAL.PT_TXN_FLEX_FIELDS T2   WHERE T1.TXNFIELD_FLD3 = T2.TXNFIELD_EMP_CODE"
			 * + "  AND T2.TXNFIELD_FLD3 = ? )" +
			 * "  AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_CALENDAR_CODE = 'SUN-THU'"
			 * + "  ORDER BY 2";
			 * 
			 * String sql12 ="  SELECT EMP_CODE,EMP_NAME from FJPORTAL.PM_EMP_KEY" +
			 * "  WHERE  EMP_CODE IN ( "+
			 * "  SELECT TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS " +
			 * "  START WITH  TXNFIELD_FLD3 = ? " +
			 * "  CONNECT  BY PRIOR TXNFIELD_EMP_CODE = TXNFIELD_FLD3  )" +
			 * "  AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_CALENDAR_CODE = 'SUN-THU' "
			 * + "  ORDER BY 2";
			 */
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmEmp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String emp_code = myRes.getString(1);
				String emp_name = myRes.getString(2);

				DailyTask tempSubordList = new DailyTask(emp_code, emp_name);
				subordianteList.add(tempSubordList);

			}
		} catch (SQLException e) {
			System.out.println("Exception DMCODE DailyTaskDbUtil.getSubordinatesDetails " + dmEmp_code);
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return subordianteList;
	}

	public String employeeDivision(String emp_code) throws SQLException {

		String division = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "select EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				division = myRes.getString(1);

			}
			return division;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	// Daily Task complete staff single day report

	public List<DailyTask> getStaffsDailyTaskForDivMngr(List<DailyTask> listEmps, String taskDate) throws SQLException {
		// List<DailyTask> empList = getDivisionStaffsDailyTaskReport(dmEmp_code);
		int flag = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Iterator<DailyTask> itr = listEmps.iterator();

		List<DailyTask> taskList = new ArrayList<>();

		while (itr.hasNext()) {
			flag = 0;
			DailyTask st = (DailyTask) itr.next();
			// System.out.println(st.getEmp_code() + " " + taskDate);
			try {

				// Get Connection
				myCon = con.getMysqlConn();
				// Execute sql stamt
				String sql = "select   task, starttime, endtime, `desc` from dailytask where empid = ? and   workday = ? ";
				myStmt = myCon.prepareStatement(sql);

				// set the param values for the student
				myStmt.setString(1, st.getEmp_code());
				myStmt.setString(2, taskDate);
				// Execute a SQL query
				myRes = myStmt.executeQuery();

				// Process the result set

				while (myRes.next()) {
					flag = 1;
					String task = myRes.getString(1);
					String start_time = myRes.getString(2);
					String end_time = myRes.getString(3);
					String desc = myRes.getString(4);
					// System.out.println(st.getEmp_code()+" "+taskDate+" "+desc);

					DailyTask tempTasklList = new DailyTask(st.getTecmp12(), st.getTedvn13(), st.getEmp_code(),
							st.getEmp_name(), taskDate, task, start_time, end_time, desc);
					taskList.add(tempTasklList);
				}

				if (flag == 0) {
					DailyTask tempTasklList = new DailyTask(st.getTecmp12(), st.getTedvn13(), st.getEmp_code(),
							st.getEmp_name(), taskDate, " - ", "  ", "  ", " ");
					taskList.add(tempTasklList);
				}

			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				con.closeConnection();
			}
		}
		return taskList;
	}

	public List<DailyTask> getDivisionStaffsDailyTaskReport(String dmEmp_code, String taskDate) throws SQLException {
		List<DailyTask> subordianteList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			/*
			 * String sql
			 * ="  SELECT EMP_COMP_CODE,EMP_DIVN_CODE,EMP_CODE,EMP_NAME from FJPORTAL.PM_EMP_KEY"
			 * + "  WHERE  EMP_CODE IN ( "+
			 * "  SELECT TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS " +
			 * "  START WITH  TXNFIELD_FLD3 = ? " +
			 * "  CONNECT  BY PRIOR TXNFIELD_EMP_CODE = TXNFIELD_FLD3  )" +
			 * "  AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_CALENDAR_CODE = 'SUN-THU'"
			 * + "  ORDER BY 2";
			 */// bug in query loop
			String sql = " SELECT EMP_COMP_CODE,EMP_DIVN_CODE,EMP_CODE,EMP_NAME from FJPORTAL.PM_EMP_KEY "
					+ " where  EMP_CODE in (SELECT TXNFIELD_EMP_CODE FROM FJPORTAL.PT_TXN_FLEX_FIELDS "
					+ " WHERE TXNFIELD_FLD3 = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1) "
					+ "AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_CALENDAR_CODE = 'SUN-THU' ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmEmp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String company_code = myRes.getString(1);
				String divn_code = myRes.getString(2);
				String emp_code = myRes.getString(3);
				String emp_name = myRes.getString(4);

				DailyTask tempSubordList = new DailyTask(company_code, divn_code, emp_code, emp_name);
				subordianteList.add((DailyTask) tempSubordList);

			}

			return getStaffsDailyTaskForDivMngr(subordianteList, taskDate);

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<CustomerVisit> getCustomerVisitDetailsForSingleDay(String date, String empid) throws SQLException {

		List<CustomerVisit> visitList = new ArrayList<>();// sales engineer customer visit list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT  ACT_DOC_ID, ACT_SM_CODE, TO_CHAR(ACT_DT,'DD/MM/YYYY'),  "
					+ "ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME,  CONT_PERSON, CONT_NUMBER   "
					+ "FROM  FJPORTAL.CUS_VIST_ACTION WHERE  ACT_DT =  TO_DATE(?,'YYYY-MM-DD')   AND ACT_SM_CODE IN ( SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2) "
					+ "ORDER BY 6";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, date);
			myStmt.setString(2, empid);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String smCode = myRes.getString(2);
				String actionDate = myRes.getString(3);
				String actionDesc = myRes.getString(4);
				String visitType = myRes.getString(5);
				String fromTime = myRes.getString(6);
				String toTime = myRes.getString(7);
				String projectName = myRes.getString(8);
				String partyName = myRes.getString(9);
				String custName = myRes.getString(10);
				String custContactNo = myRes.getString(11);

				// System.out.println("documentId "+documentId+" actnTyp "+actnTyp);
				CustomerVisit tempVisitList = new CustomerVisit(documentId, smCode, actionDate, actionDesc, visitType,
						fromTime, toTime, projectName, partyName, custName, custContactNo);
				visitList.add(tempVisitList);

			}
			return visitList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<DailyTask> getCustomerVisitDetails(String year, int month, String empid, String sales_man_code)
			throws SQLException {

		List<DailyTask> visitList = new ArrayList<>();// sales engineer customer visit list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  ACT_DOC_ID, ACT_SM_CODE, TO_CHAR(ACT_DT,'YYYY-MM-DD'), ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME   FROM  FJPORTAL.CUS_VIST_ACTION WHERE EXTRACT(YEAR FROM ACT_DT) = ? AND EXTRACT(MONTH FROM ACT_DT) = ? AND ACT_SM_CODE = ? "
					+ "ORDER BY 3 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, Integer.parseInt(year));
			myStmt.setInt(2, month);
			myStmt.setString(3, sales_man_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String sm_code = myRes.getString(2);
				String visitDate = myRes.getString(3);
				String actionDesc = myRes.getString(4);
				String actnTyp = myRes.getString(5);
				String fromTime = myRes.getString(6);
				String toTime = myRes.getString(7);
				String project = myRes.getString(8);
				String partyName = myRes.getString(9);

				DailyTask tempVisitList = new DailyTask("cv", year, empid, sm_code, "-", "-", sales_man_code, visitDate,
						"" + month, actnTyp, actionDesc, fromTime, toTime, documentId, project, partyName);
				visitList.add(tempVisitList);

			}
			return visitList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public DailyTask getSalesStausWithCode(String emp_code) {
		DailyTask salesVisitStatus = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String sqlstr = "SELECT SM_FLEX_07, SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 ";

		try {
			con = orcl.getOrclConn();
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				salesVisitStatus = new DailyTask(rs.getString(1), rs.getString(2), emp_code);
			} else
				salesVisitStatus = new DailyTask("n", "", emp_code);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return salesVisitStatus;
	}

	public List<DailyTask> getCustomerVisitPlannerDetails(String year, int month, String empid, String sales_man_code)
			throws SQLException {

		List<DailyTask> visitList = new ArrayList<>();// sales engineer customer visit list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  ACT_DOC_ID, ACT_SM_CODE, TO_CHAR(ACT_DT,'YYYY-MM-DD'), ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME,CONT_PERSON,CONT_NUMBER,SYS_ID   FROM  FJPORTAL.CUS_VIST_PLANNER WHERE EXTRACT(YEAR FROM ACT_DT) = ?  AND ACT_SM_CODE = ? AND MOVEDTO_ACTUAL IS NULL "
					+ "ORDER BY 3 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, Integer.parseInt(year));
			// myStmt.setInt(2, month);
			myStmt.setString(2, sales_man_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String sm_code = myRes.getString(2);
				String visitDate = myRes.getString(3);
				String actionDesc = myRes.getString(4);
				String actnTyp = myRes.getString(5);
				String fromTime = myRes.getString(6);
				String toTime = myRes.getString(7);
				String project = myRes.getString(8);
				String partyName = myRes.getString(9);
				String contactPerson = myRes.getString(10);
				String contactNumber = myRes.getString(11);
				int id = myRes.getInt(12);
				DailyTask tempVisitList = new DailyTask("cv", year, empid, sm_code, "-", "-", sales_man_code, visitDate,
						"" + month, actnTyp, actionDesc, fromTime, toTime, documentId, project, partyName,
						contactPerson, contactNumber, id);
				visitList.add(tempVisitList);

			}
			return visitList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int updateCustomerVisitPlannerDetails(DailyTask theTask) throws SQLException {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE FJPORTAL.CUS_VIST_PLANNER SET ACT_FM_TM=? , ACT_TO_TM = ? , ACT_DESC = ?, ACT_PROJ_NAME = ?  WHERE  SYS_ID =? ";
			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student

			myStmt.setString(1, theTask.getTtyp07());
			myStmt.setString(2, theTask.getTdesc08());
			myStmt.setString(3, theTask.getTst09());
			myStmt.setString(4, theTask.getTet10());
			myStmt.setInt(5, theTask.getSysid());
			logType = myStmt.executeUpdate();
			// System.out.println( "task updated status:"+logType);

		} finally {
			// close jdbc objects

			close(myStmt, null);
			orcl.closeConnection();

		}
		return logType;
	}

	public int selectCustomerVisitPlannerDetails(int sysid) throws SQLException {
		int logType = -2;
		int result = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		List<CustomerVisit> custVisitDetails = new ArrayList<>();
		ResultSet myRes = null;
		try {
			myCon = orcl.getOrclConn();

			String sql = "UPDATE FJPORTAL.CUS_VIST_PLANNER SET MOVEDTO_ACTUAL= 1  WHERE  SYS_ID =? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, sysid);
			logType = myStmt.executeUpdate();

			if (logType == 1) {
				// String insertsql = " INSERT INTO FJPORTAL.CUS_VIST_ACTION_BKP SELECT
				// ACT_DOC_ID, ACT_SM_CODE, ACT_DT, ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM,
				// ACT_PROJ_NAME, ACT_PARTY_NAME, CONT_PERSON, CONT_NUMBER FROM
				// FJPORTAL.CUS_VIST_PLANNER WHERE SYS_ID =? ";
				String insertsql = " INSERT INTO FJPORTAL.CUS_VIST_ACTION SELECT ACT_DOC_ID,ACT_SM_CODE,ACT_DT,ACT_DESC,ACT_TYPE,ACT_FM_TM,ACT_TO_TM,ACT_PROJ_NAME,ACT_PARTY_NAME,CONT_PERSON,CONT_NUMBER,SYSDATE FROM  FJPORTAL.CUS_VIST_PLANNER WHERE SYS_ID =? ";
				myStmt = myCon.prepareStatement(insertsql);
				myStmt.setInt(1, sysid);
				result = myStmt.executeUpdate();
			}
		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			orcl.closeConnection();

		}
		/*
		 * try { getCustomerVisitDetailsInsertStatus(custVisitDetails); } catch
		 * (Exception e) {
		 * System.out.println("Error in selectCustomerVisitPlannerDetails" + e); }
		 */
		return result;
	}

	public int getCustomerVisitDetailsInsertStatus(List<CustomerVisit> custVisitDetails)
			throws SQLException, ParseException {

		int logCount = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Iterator<CustomerVisit> iterator = custVisitDetails.iterator();

		try {
			myCon = orcl.getOrclConn();
			String sql = " INSERT  INTO FJPORTAL.CUS_VIST_ACTION_BKP(ACT_DOC_ID, ACT_SM_CODE, ACT_DT, ACT_DESC, ACT_TYPE, ACT_FM_TM,  ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME, CONT_PERSON, CONT_NUMBER) "
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			myStmt = myCon.prepareStatement(sql);
			myCon.setAutoCommit(false);

			while (iterator.hasNext()) {

				CustomerVisit theVisitData = (CustomerVisit) iterator.next();
				java.util.Date date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(theVisitData.getVisitDate());
				java.sql.Date sqlDate = new java.sql.Date(date.getTime());
				System.out.println("sqlDate == " + sqlDate);
				myStmt.setString(1, theVisitData.getDocumentId());
				myStmt.setString(2, theVisitData.getSegCode());
				myStmt.setDate(3, sqlDate);
				myStmt.setString(4, theVisitData.getActnDesc());
				myStmt.setString(5, theVisitData.getActionType());
				myStmt.setString(6, theVisitData.getFromTime());
				myStmt.setString(7, theVisitData.getToTime());
				myStmt.setString(8, theVisitData.getProject());
				myStmt.setString(9, theVisitData.getPartyName());
				myStmt.setString(10, theVisitData.getCustomerName());
				myStmt.setString(11, theVisitData.getCustomerContactNo());

				myStmt.addBatch();
			}

			// Create an int[] to hold returned values
			int[] affectedRecords = myStmt.executeBatch();
			myCon.commit();
			logCount = affectedRecords.length;
			// System.out.println("Final Cust visit count after updates = " + logCount);

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					// STEP 3 - Roll back transaction
					System.out.println("Transaction is being rolled back. Customer visit updates" + logCount);
					myCon.rollback();
					logCount = 0;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;

	}

	public List<DailyTask> getEmployeeCustVisitsCurrentMonth(String year, int month, String empid,
			String sales_man_code) throws SQLException {

		List<DailyTask> visitList = new ArrayList<>();// sales engineer customer visit Planner list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  ACT_DOC_ID, ACT_SM_CODE, TO_CHAR(ACT_DT,'YYYY-MM-DD'), ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME   FROM  FJPORTAL.CUS_VIST_PLANNER WHERE EXTRACT(YEAR FROM ACT_DT) = ? AND EXTRACT(MONTH FROM ACT_DT) = ? AND ACT_SM_CODE = ? "
					+ "ORDER BY 3 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, Integer.parseInt(year));
			myStmt.setInt(2, month);
			myStmt.setString(3, sales_man_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String sm_code = myRes.getString(2);
				String visitDate = myRes.getString(3);
				String actionDesc = myRes.getString(4);
				String actnTyp = myRes.getString(5);
				String fromTime = myRes.getString(6);
				String toTime = myRes.getString(7);
				String project = myRes.getString(8);
				String partyName = myRes.getString(9);

				DailyTask tempVisitList = new DailyTask("cv", year, empid, sm_code, "-", "-", sales_man_code, visitDate,
						"" + month, actnTyp, actionDesc, fromTime, toTime, documentId, project, partyName);
				visitList.add(tempVisitList);

			}
			return visitList;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
}
