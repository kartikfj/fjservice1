package utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import beans.EmailHrEvaluation;
import beans.HrEvaluationCategory;
import beans.HrEvaluationDetails;
import beans.HrEvaluationOperations;
import beans.HrEvaluationRating;
import beans.HrEvaluationReport;
import beans.HrEvaluationSettings;
import beans.HrEvaluationUserProfile;
import beans.OrclDBConnectionPool;

public class HrEvaluationDbUtil {
	public int updateEvaluationUserEntryStatus(long id, String empCode, int evaluationYear, int evaluationTerm,
			int employeeorManagerEntry, String columnName) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			String sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER   " + " SET " + columnName + "=?"
					+ " WHERE EMP_ID = ? AND EMP_EVL_SYS_ID = ?  AND EVL_YEAR = ? AND EVL_TERM = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, employeeorManagerEntry);// employee entry ative or not, 1: disable, 0: active
			// myStmt.setInt(2, managerEntry);// employee entry ative or not, 1: disable, 0:
			// active
			myStmt.setString(2, empCode);
			myStmt.setLong(3, id);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);
			// String sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER " + " SET " +
			// coltoupdate + "= ?"
			// + " WHERE EMP_ID = ? AND EMP_EVL_SYS_ID = ? AND EVL_YEAR = ? AND EVL_TERM = ?
			// ";
			// myStmt = myCon.prepareStatement(sql);
			// myStmt.setInt(1, employeeorManagerEntry);// employee entry ative or not, 1:
			// disable, 0: active
			// myStmt.setInt(2, managerEntry);// employee entry ative or not, 1: disable, 0:
			// active
			// myStmt.setString(2, empCode);
			// myStmt.setLong(3, id);
			// myStmt.setInt(4, evaluationYear);
			// myStmt.setInt(5, evaluationTerm);

			logType = myStmt.executeUpdate();
			// System.out.println("DB OP "+logType);
		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out
					.println("Exception in closing DB resources at the time updating evl user entry status  status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int checkEvaluationYearDateActiveOrNot(HrEvaluationSettings settings) throws ParseException {
		int result = 0;

		Date currentDate = settings.getCurrentDate();
		Date startDate = settings.getStartDate();
		Date endDate = settings.getEndDate();
		long evldatesDiff = (endDate.getTime() - startDate.getTime()) / (24 * 60 * 60 * 1000) + 1;
		long evlEndDtDiffwithCurrDt = (endDate.getTime() - currentDate.getTime()) / (24 * 60 * 60 * 1000) + 1;
		// System.out.println(startDate+" "+endDate+" currentDate"+currentDate);
		if ((evldatesDiff > 0) && (settings.getActiveOrNot() == 1) && (evlEndDtDiffwithCurrDt > 0)) {
			result = 1;

		}
		// System.out.println("Result = "+result+" diff "+evldatesDiff+" diff with curr
		// date "+evlEndDtDiffwithCurrDt);
		return result;
	}

	public List<HrEvaluationSettings> getPreviuosEvaluationYears() throws SQLException {
		List<HrEvaluationSettings> hrEvaluationSettings = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DISTINCT EVAL_YEAR    from FJPORTAL.HR_EVALUATION_SETTINGS ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				int evlYear = myRes.getInt(1);

				HrEvaluationSettings tempHrEvaluationSettings = new HrEvaluationSettings(evlYear);
				hrEvaluationSettings.add(tempHrEvaluationSettings);
			}

		} catch (SQLException e) {
			System.out.println("Exception in fetching ratings ");
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return hrEvaluationSettings;

	}

	public HrEvaluationUserProfile employeeUserProfile(String empCode) throws SQLException {

		HrEvaluationUserProfile empDtls = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete master entry
			String sql = " SELECT EMP_CODE, EMP_NAME, EMP_JOIN_DT, EMP_JOB_LONG_DESC, EMP_DIVN_CODE, "
					+ " (SELECT  EMP_NAME  FROM FJPORTAL.PM_EMP_KEY  "
					+ " WHERE EMP_CODE = (SELECT TXNFIELD_FLD7 FROM FJPORTAL.PT_TXN_FLEX_FIELDS  "
					+ " WHERE TXNFIELD_EMP_CODE = ? AND ROWNUM = ?) ) MANAGER,  "
					+ " (SELECT  EMP_CODE  FROM FJPORTAL.PM_EMP_KEY  "
					+ " WHERE EMP_CODE = (SELECT TXNFIELD_FLD7 FROM FJPORTAL.PT_TXN_FLEX_FIELDS  "
					+ " WHERE TXNFIELD_EMP_CODE = ? AND ROWNUM = ?) ) MANAGER_CODE  " + " FROM FJPORTAL.PM_EMP_KEY   "
					+ " WHERE EMP_CODE = ? AND ROWNUM = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setInt(2, 1);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, 1);
			myStmt.setString(5, empCode);
			myStmt.setInt(6, 1);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String employeeCode = myRes.getString(1);
				String empName = myRes.getString(2);
				String joiningDate = myRes.getString(3);
				String jobTitle = myRes.getString(4);
				String division = myRes.getString(5);
				String manager = myRes.getString(6);
				String managerCode = myRes.getString(7);
				empDtls = new HrEvaluationUserProfile(employeeCode, empName, joiningDate, division, jobTitle, manager,
						managerCode);

			}
			return empDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationUserProfile> employeeListForReport(String dmCode) throws SQLException {
		List<HrEvaluationUserProfile> ratingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT  TXNFIELD_EMP_CODE, EMP_NAME, EMP_FRZ_FLAG "
					+ " FROM FJPORTAL.PT_TXN_FLEX_FIELDS JOIN PAYROLL.PM_EMP_KEY   "
					+ " ON EMP_CODE = TXNFIELD_EMP_CODE "
					+ " WHERE TXNFIELD_FLD7 = ? AND  EMP_FRZ_FLAG = ? AND (EMP_STATUS = ?  OR EMP_STATUS = ?) AND ( EMP_CALENDAR_CODE = ? OR EMP_CONT_TYPE_CODE = ? ) "
					+ " UNION " + " SELECT  TXNFIELD_EMP_CODE, EMP_NAME, EMP_FRZ_FLAG "
					+ " FROM FJPORTAL.PT_TXN_FLEX_FIELDS JOIN PAYROLL.PM_EMP_KEY   "
					+ " ON EMP_CODE = TXNFIELD_EMP_CODE "
					+ " WHERE TXNFIELD_FLD8 = ? AND  EMP_FRZ_FLAG = ? AND (EMP_STATUS = ?  OR EMP_STATUS = ?) AND ( EMP_CALENDAR_CODE = ? OR EMP_CONT_TYPE_CODE = ? ) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmCode);
			myStmt.setString(2, "N");
			myStmt.setInt(3, 1);
			myStmt.setInt(4, 2);
			myStmt.setString(5, "SUN-THU");
			myStmt.setString(6, "STAFF");
			myStmt.setString(7, dmCode);
			myStmt.setString(8, "N");
			myStmt.setInt(9, 1);
			myStmt.setInt(10, 2);
			myStmt.setString(11, "SUN-THU");
			myStmt.setString(12, "STAFF");

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empCode = myRes.getString(1);
				String empName = myRes.getString(2);
				HrEvaluationUserProfile tempRatingList = new HrEvaluationUserProfile(empCode, empName);
				ratingList.add(tempRatingList);
			}

		} catch (SQLException e) {
			System.out.println("Exception in fetching ratings ");
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return ratingList;

	}

	public List<HrEvaluationUserProfile> evaluationEmployeesPendingList(String dmCode, int evaluationYear)
			throws SQLException {
		List<HrEvaluationUserProfile> ratingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT EMP_CODE, EMP_NAME, EMP_FRZ_FLAG FROM (  "
					+ "SELECT EMP_CODE, EMP_NAME, EMP_FRZ_FLAG, COALESCE(EVL_MANAGER_ENTRY_ACTV,0) EVL_MANAGER_ENTRY_ACTV, COALESCE(EVL_OPTN_STATUS,0) EVL_OPTN_STATUS   FROM  "
					+ "(SELECT  EMP_CODE, EMP_NAME, EMP_FRZ_FLAG  "
					+ "FROM FJPORTAL.PT_TXN_FLEX_FIELDS JOIN PAYROLL.PM_EMP_KEY      "
					+ "ON EMP_CODE = TXNFIELD_EMP_CODE   "
					+ "WHERE TXNFIELD_FLD7 = ? AND  EMP_FRZ_FLAG = ? AND (EMP_STATUS =  ? OR EMP_STATUS = ? ) AND ( EMP_CALENDAR_CODE = ? OR EMP_CONT_TYPE_CODE = ? )) T1  "
					+ "JOIN (SELECT *FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER WHERE EVL_YEAR = ?)   "
					+ "ON EMP_CODE = EMP_ID (+)   " + ") T2  " + "WHERE EVL_MANAGER_ENTRY_ACTV = 0 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmCode);
			myStmt.setString(2, "N");
			myStmt.setInt(3, 1);
			myStmt.setInt(4, 2);
			myStmt.setString(5, "SUN-THU");
			myStmt.setString(6, "STAFF");
			myStmt.setInt(7, evaluationYear);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empCode = myRes.getString(1);
				String empName = myRes.getString(2);
				HrEvaluationUserProfile tempRatingList = new HrEvaluationUserProfile(empCode, empName);
				ratingList.add(tempRatingList);
			}

		} catch (SQLException e) {
			System.out.println("Exception in fetching ratings ");
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return ratingList;

	}

	public List<HrEvaluationUserProfile> employeeList(String dmCode) throws SQLException {
		List<HrEvaluationUserProfile> ratingList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT  TXNFIELD_EMP_CODE, EMP_NAME, EMP_FRZ_FLAG "
					+ " FROM FJPORTAL.PT_TXN_FLEX_FIELDS JOIN PAYROLL.PM_EMP_KEY   "
					+ " ON EMP_CODE = TXNFIELD_EMP_CODE "
					+ " WHERE TXNFIELD_FLD7 = ? AND  EMP_FRZ_FLAG = ? AND (EMP_STATUS = ?  OR EMP_STATUS = ?) AND ( EMP_CALENDAR_CODE = ? OR EMP_CONT_TYPE_CODE = ? ) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dmCode);
			myStmt.setString(2, "N");
			myStmt.setInt(3, 1);
			myStmt.setInt(4, 2);
			myStmt.setString(5, "SUN-THU");
			myStmt.setString(6, "STAFF");

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empCode = myRes.getString(1);
				String empName = myRes.getString(2);
				HrEvaluationUserProfile tempRatingList = new HrEvaluationUserProfile(empCode, empName);
				ratingList.add(tempRatingList);
			}

		} catch (SQLException e) {
			System.out.println("Exception in fetching ratings ");
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return ratingList;

	}

	public List<HrEvaluationRating> evaluationRatings() throws SQLException {
		List<HrEvaluationRating> ratingList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT RATING_VALUE,DESCRIPTION  FROM FJPORTAL.HR_EVALUATION_RATINGS ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				int ratingCode = myRes.getInt(1);
				String ratingDesc = myRes.getString(2);
				HrEvaluationRating tempRatingList = new HrEvaluationRating(ratingCode, ratingDesc);
				ratingList.add(tempRatingList);
			}

		} catch (SQLException e) {
			System.out.println("Exception in fetching ratings ");
			e.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
		return ratingList;

	}

	public HrEvaluationSettings hrEvaluationSettings() throws SQLException {

		HrEvaluationSettings hrEvlSetting = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete master entry
			String sql = "  select EVAL_YEAR, START_ON, END_ON, TERM, ACTIVE, SYSDATE   from FJPORTAL.HR_EVALUATION_SETTINGS "
					+ " WHERE ACTIVE = ? AND ROWNUM = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, 1); // only active settings
			myStmt.setInt(2, 1);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				int evlYear = myRes.getInt(1);
				java.sql.Date startOn = myRes.getDate(2);
				java.sql.Date endOn = myRes.getDate(3);
				int evlTerm = myRes.getInt(4);
				int activeOrNot = myRes.getInt(5);
				java.sql.Date currentDate = myRes.getDate(6);
				hrEvlSetting = new HrEvaluationSettings(evlYear, startOn, endOn, evlTerm, activeOrNot, currentDate);
			}
			return hrEvlSetting;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public HrEvaluationDetails employeeEvaluationMasterEntryDetails(String empCode, int evaluationYear,
			int evaluationTerm) throws SQLException {

		HrEvaluationDetails empEvlDtls = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete master entry
			String sql = " SELECT EMP_EVL_SYS_ID, EVL_YEAR, EMP_GOALS_PROF_DEV_CMMNT, EMP_COMMENT,  "
					+ "	DM_COMMENT,EVL_OPTN_STATUS,  DM_UID, DM_UPD_DT, EMP_UPD_DT, EMP_CRD_DT, EMP_ID, EVL_EMP_ENTRY_ACTV, EVL_MANAGER_ENTRY_ACTV , HR_COMMENT ,EVL_HR_ENTRY_ACTV ,IMPRMENT_ARERS , TRAINING_NEEDS,get_emp_training_needs(heeem.training_needs) as emp_training_needs "
					+ "	FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER heeem "
					+ "	WHERE  EMP_ID = ? AND EVL_YEAR = ? AND EVL_TERM = ? AND ROWNUM = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setInt(2, evaluationYear);
			myStmt.setInt(3, evaluationTerm);
			myStmt.setInt(4, 1);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				long id = myRes.getLong(1);
				int evlYear = myRes.getInt(2);
				String empGoals = myRes.getString(3);
				String empComment = myRes.getString(4);
				String dmComment = myRes.getString(5);
				int evaluationStatus = myRes.getInt(6);
				String dmId = myRes.getString(7);
				String dmUpdatedOn = myRes.getString(8);
				String empUpdtedOn = myRes.getString(9);
				String empCrtOn = myRes.getString(10);
				String evltnEmp = myRes.getString(11);
				int empEntryActive = myRes.getInt(12);
				int managerEntryActive = myRes.getInt(13);
				String hrComment = myRes.getString(14);
				int hrEntryActive = myRes.getInt(15);
				String imprareas = myRes.getString(16);
				String trainingneedscodes = myRes.getString(17);
				String trainingneedsDesc = myRes.getString(18);
				empEvlDtls = new HrEvaluationDetails(id, evlYear, empGoals, empComment, dmComment, evaluationStatus,
						dmId, dmUpdatedOn, empUpdtedOn, empCrtOn, evltnEmp, empEntryActive, managerEntryActive,
						hrComment, hrEntryActive, imprareas, trainingneedscodes, trainingneedsDesc);

			}
			return empEvlDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationCategory> employeeEvaluationSummary(String empCode, int evaluationYear, int evaluationTerm)
			throws SQLException, ParseException {

		List<HrEvaluationCategory> empCategryContents = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String s = "01/01/" + evaluationYear;
		System.out.println(s);
		java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
		java.sql.Date sqlDate = new java.sql.Date(date1.getTime());
		System.out.println("sqlDate== " + sqlDate);

		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete evaluation category wise summary
			String sql = "  SELECT  CODE, DESCRPTION, TOTAL_RATING_CONTENT, COALESCE(UPDTD_COUNT,0) EMPUPDTD_COUNT, COALESCE(DMCOMMENT_COUNT,0) DMRATING_COUNT FROM "
					+ " (   "
					+ " SELECT DISTINCT EVL_CODE CODE,DESCRPTION, DPORDER,COUNT(CONTENT_NUMBER) TOTAL_RATING_CONTENT    from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  HETD "
					+ " LEFT JOIN  FJPORTAL.HR_EVALUATION_TYPES_MASTER   HETM " + " ON EVL_CODE = CODE   "
					+ " WHERE RATING_REQRD_YN = 'Y'   AND ? BETWEEN HETD.EFFECTIVE_START_DATE AND nvl(HETD.EFFECTIVE_END_DATE,SYSDATE+1)"
					+ " AND (HETD.EMP_CATEGORY IS NULL OR HETD.EMP_CATEGORY IN ("
					+ "	SELECT nvl(HEET.EMP_CATEGORY,'EMP') FROM PM_EMP_KEY PEK"
					+ "	LEFT JOIN HR_EVALUATION_EMP_TYPES HEET" + "	ON PEK.EMP_CODE = HEET.EMP_CODE "
					+ "	WHERE PEK.EMP_CODE = ?))  " + " GROUP BY EVL_CODE, DESCRPTION , DPORDER  " + "  ) T1   "
					+ " LEFT JOIN   (      "
					+ " SELECT TYPES_CODE, SUM(UPDTD_COUNT) UPDTD_COUNT, SUM(DMCOMMENT_COUNT) DMCOMMENT_COUNT from ((SELECT TYPES_CODE , COALESCE(COUNT(TYPES_CODE),0) UPDTD_COUNT, 0 DMCOMMENT_COUNT FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN  "
					+ " WHERE EMP_EVL_SYS_ID = (    "
					+ " SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    "
					+ " WHERE  EMP_ID = ? AND  EVL_YEAR = ? AND EVL_TERM = ?   "
					+ " AND TYPES_CONTENT_NUMBER IN ( SELECT CONTENT_NUMBER from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  WHERE EVL_CODE = TYPES_CODE AND RATING_REQRD_YN = 'Y'  AND ? BETWEEN EFFECTIVE_START_DATE AND nvl(EFFECTIVE_END_DATE,SYSDATE+1) )  )  AND EMP_COMMENT IS NOT NULL  "
					+ " GROUP BY TYPES_CODE )  " + " UNION ALL "
					+ " (SELECT TYPES_CODE , 0, COALESCE(COUNT(TYPES_CODE),0) DMCOMMENT_COUNT FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN  "
					+ " WHERE EMP_EVL_SYS_ID = (    "
					+ " SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    "
					+ " WHERE  EMP_ID = ? AND  EVL_YEAR = ? AND EVL_TERM = ?    "
					+ " AND TYPES_CONTENT_NUMBER IN ( SELECT CONTENT_NUMBER from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  WHERE EVL_CODE = TYPES_CODE AND RATING_REQRD_YN = 'Y'  AND ? BETWEEN EFFECTIVE_START_DATE AND nvl(EFFECTIVE_END_DATE,SYSDATE+1) )  )  AND RATING IS NOT NULL AND RATING != 0   "
					+ " GROUP BY TYPES_CODE ))  " + " GROUP BY TYPES_CODE  )T2    "
					+ " ON  T1.CODE = T2.TYPES_CODE ORDER BY DPORDER";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, sqlDate);
			myStmt.setString(2, empCode);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);
			myStmt.setDate(6, sqlDate);
			myStmt.setString(7, empCode);
			myStmt.setInt(8, evaluationYear);
			myStmt.setInt(9, evaluationTerm);
			myStmt.setDate(10, sqlDate);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String evlCategoryCode = myRes.getString(1);
				String evlCategoryDesc = myRes.getString(2);
				int totalContents = myRes.getInt(3);
				int updatedContents = myRes.getInt(4);// by employee
				int updatedRatings = myRes.getInt(5);// by dm

				HrEvaluationCategory tempEvlCategryDtlsList = new HrEvaluationCategory(evlCategoryCode, evlCategoryDesc,
						totalContents, updatedContents, updatedRatings);
				empCategryContents.add(tempEvlCategryDtlsList);
			}
			return empCategryContents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationCategory> employeeEvaluationSummaryForManager(String empCode, int evaluationYear,
			int evaluationTerm) throws SQLException, ParseException {

		List<HrEvaluationCategory> empCategryContents = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String s = "01/01/" + evaluationYear;
		System.out.println(s);
		try {
			myCon = orcl.getOrclConn();
			java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
			java.sql.Date sqlDate = new java.sql.Date(date1.getTime());
			// --query to get employee complete evaluation category wise summary
			String sql = "  SELECT  CODE, DESCRPTION, TOTAL_RATING_CONTENT, COALESCE(UPDTD_COUNT,0) EMPUPDTD_COUNT, COALESCE(DMCOMMENT_COUNT,0) DMRATING_COUNT FROM "
					+ " (   "
					+ " SELECT DISTINCT EVL_CODE CODE,DESCRPTION, DPORDER,COUNT(CONTENT_NUMBER) TOTAL_RATING_CONTENT    from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  HETD "
					+ " LEFT JOIN  FJPORTAL.HR_EVALUATION_TYPES_MASTER   HETM " + " ON EVL_CODE = CODE   "
					+ " WHERE RATING_REQRD_YN = 'Y'  AND ? BETWEEN HETD.EFFECTIVE_START_DATE AND nvl(HETD.EFFECTIVE_END_DATE,SYSDATE+1)"
					+ " AND (HETD.EMP_CATEGORY IS NULL OR HETD.EMP_CATEGORY IN ("
					+ "	SELECT nvl(HEET.EMP_CATEGORY,'EMP') FROM PM_EMP_KEY PEK"
					+ "	LEFT JOIN HR_EVALUATION_EMP_TYPES HEET" + "	ON PEK.EMP_CODE = HEET.EMP_CODE "
					+ "	WHERE PEK.EMP_CODE = ?))  " + " GROUP BY EVL_CODE, DESCRPTION,DPORDER " + "  ) T1   "
					+ " LEFT JOIN   (      "
					+ "  SELECT TYPES_CODE, SUM(UPDTD_COUNT) UPDTD_COUNT, SUM(DMCOMMENT_COUNT) DMCOMMENT_COUNT from ((SELECT TYPES_CODE , COALESCE(COUNT(TYPES_CODE),0) UPDTD_COUNT, 0 DMCOMMENT_COUNT FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN  "
					+ " WHERE EMP_EVL_SYS_ID = (    "
					+ " SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    "
					+ " WHERE  EMP_ID = ? AND  EVL_YEAR = ? AND EVL_TERM = ?   "
					+ " AND TYPES_CONTENT_NUMBER IN ( SELECT CONTENT_NUMBER from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  WHERE EVL_CODE = TYPES_CODE AND RATING_REQRD_YN = 'Y'  AND ? BETWEEN EFFECTIVE_START_DATE AND nvl(EFFECTIVE_END_DATE,sysdate+1)  )  )  AND EMP_COMMENT IS NOT NULL  "
					+ " GROUP BY TYPES_CODE )  " + " UNION ALL "
					+ " (SELECT TYPES_CODE , 0, COALESCE(COUNT(TYPES_CODE),0) DMCOMMENT_COUNT FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN  "
					+ " WHERE EMP_EVL_SYS_ID = (    "
					+ " SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    "
					+ " WHERE  EMP_ID = ? AND  EVL_YEAR = ? AND EVL_TERM = ?    "
					+ " AND TYPES_CONTENT_NUMBER IN ( SELECT CONTENT_NUMBER from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  WHERE EVL_CODE = TYPES_CODE AND RATING_REQRD_YN = 'Y'   AND ? BETWEEN EFFECTIVE_START_DATE AND nvl(EFFECTIVE_END_DATE,sysdate+1)  )  )  AND RATING IS NOT NULL AND RATING != 0   "
					+ " GROUP BY TYPES_CODE ))  " + " GROUP BY TYPES_CODE  )T2    "
					+ " ON  T1.CODE = T2.TYPES_CODE ORDER BY DPORDER";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, sqlDate);
			myStmt.setString(2, empCode);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);
			myStmt.setDate(6, sqlDate);
			myStmt.setString(7, empCode);
			myStmt.setInt(8, evaluationYear);
			myStmt.setInt(9, evaluationTerm);
			myStmt.setDate(10, sqlDate);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String evlCategoryCode = myRes.getString(1);
				String evlCategoryDesc = myRes.getString(2);
				int totalContents = myRes.getInt(3);
				int updatedContents = myRes.getInt(4);// by employee
				int updatedRatings = myRes.getInt(5);// by dm

				HrEvaluationCategory tempEvlCategryDtlsList = new HrEvaluationCategory(evlCategoryCode, evlCategoryDesc,
						totalContents, updatedContents, updatedRatings);
				empCategryContents.add(tempEvlCategryDtlsList);
			}
			return empCategryContents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationCategory> empSingleCategoryEvaluation(String empCode, int evaluationYear,
			String evaluationCode, int evaluationTerm) throws SQLException {

		List<HrEvaluationCategory> empCategryContents = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String s = "01/01/" + evaluationYear;
		java.sql.Date sqlDate = null;
		try {
			java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
			sqlDate = new java.sql.Date(date1.getTime());
		} catch (Exception e) {
			System.out.println(e);
		}
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee single category evaluation updates details
			String sql = "SELECT  EVL_CODE, CONTENT_NUMBER, DETAILS, EMP_COMMENT, DM_COMMENT, RATING, EMP_UPD_DT, DM_UID, DM_UPD_DT, RATING_REQRD_YN   FROM FJPORTAL.HR_EVALUATION_TYPES_DETAILS "
					+ "LEFT JOIN  " + "( " + "SELECT * FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN "
					+ "WHERE EMP_EVL_SYS_ID = ( "
					+ "SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER "
					+ "WHERE  EMP_ID = ? AND  EVL_YEAR = ?  AND EVL_TERM = ?  )  )T2 "
					+ "ON EVL_CODE = T2.TYPES_CODE  AND CONTENT_NUMBER = T2.TYPES_CONTENT_NUMBER  "
					+ "WHERE EVL_CODE = ?  AND ? BETWEEN EFFECTIVE_START_DATE AND nvl(EFFECTIVE_END_DATE,SYSDATE+1)"
					+ " AND (EMP_CATEGORY IS NULL OR EMP_CATEGORY IN ("
					+ "	SELECT nvl(HEET.EMP_CATEGORY,'EMP') FROM PM_EMP_KEY PEK"
					+ "	LEFT JOIN HR_EVALUATION_EMP_TYPES HEET" + "	ON PEK.EMP_CODE = HEET.EMP_CODE "
					+ "	WHERE PEK.EMP_CODE = ?))" + " ORDER BY EVL_CODE, CONTENT_NUMBER";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setInt(2, evaluationYear);
			myStmt.setInt(3, evaluationTerm);
			myStmt.setString(4, evaluationCode);
			myStmt.setDate(5, sqlDate);
			myStmt.setString(6, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String evlCode = myRes.getString(1);
				int evalCntentNumber = myRes.getInt(2);
				String evlContent = myRes.getString(3);
				String employeeComment = myRes.getString(4);
				String mgrComment = myRes.getString(5);
				String rating = myRes.getString(6);
				String empUpdatedOn = myRes.getString(7);
				String dmCode = myRes.getString(8);
				String dmUpdatedOn = myRes.getString(9);
				String ratingReqrdOrNot = myRes.getString(10);

				HrEvaluationCategory tempEvlCategryDtlsList = new HrEvaluationCategory(evlCode, evalCntentNumber,
						evlContent, employeeComment, mgrComment, rating, empUpdatedOn, dmCode, dmUpdatedOn,
						ratingReqrdOrNot);
				empCategryContents.add(tempEvlCategryDtlsList);
			}
			return empCategryContents;
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

	public HrEvaluationOperations createNewEvaluationMasterEntry(String empCode, int evaluationYear, int evaluationTerm,
			String evaluatorCode) {
		HrEvaluationOperations optnFlags = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return new HrEvaluationOperations(0, -2);
		PreparedStatement psmt = null;
		int retval = 0;
		String generatedColumns[] = { "EMP_EVL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER ");
		sqlstr.append("( EVL_YEAR, EVL_TERM,  EMP_ID, EMP_CRD_DT, DM_UID )");
		sqlstr.append(" VALUES ( ?, ?,  ?, SYSDATE, ?) ");

		try {

			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setInt(1, evaluationYear);
			psmt.setInt(2, evaluationTerm);
			psmt.setString(3, empCode);
			psmt.setString(4, evaluatorCode);
			retval = psmt.executeUpdate();
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) {
				optnFlags = new HrEvaluationOperations(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("NEW EVL MASTER ENTRY INSERT DB ERROR status to " + retval + " for employee evltn "
					+ empCode + "  and year " + evaluationYear);
			e.printStackTrace();
			optnFlags = new HrEvaluationOperations(0, -2);
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				optnFlags = new HrEvaluationOperations(0, -2);
			}
		}
		return optnFlags;

	}

	public HrEvaluationOperations createNewEvaluationMasterEntryByManager(String empCode, int evaluationYear,
			int evaluationTerm, String dmCode) {
		HrEvaluationOperations optnFlags = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return new HrEvaluationOperations(0, -2);
		PreparedStatement psmt = null;
		int retval = 0;
		String generatedColumns[] = { "EMP_EVL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER ");
		sqlstr.append("( EVL_YEAR, EVL_TERM,  EMP_ID, DM_UID,  DM_UPD_DT )");
		sqlstr.append(" VALUES ( ?, ?,  ?, ?, SYSDATE) ");

		try {

			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setInt(1, evaluationYear);
			psmt.setInt(2, evaluationTerm);
			psmt.setString(3, empCode);
			psmt.setString(4, dmCode);
			retval = psmt.executeUpdate();
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) {
				optnFlags = new HrEvaluationOperations(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("NEW EVL MASTER ENTRY INSERT DB ERROR status to " + retval + " for employee evltn "
					+ empCode + "  and year " + evaluationYear);
			e.printStackTrace();
			optnFlags = new HrEvaluationOperations(0, -2);
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				optnFlags = new HrEvaluationOperations(0, -2);
			}
		}
		return optnFlags;

	}

	public int createNewSingleCategoryEntry(long id, String evaluationCode, int contentNumber, String comment) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		PreparedStatement psmt = null;
		int retval = 0;
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN ");
		sqlstr.append("( EMP_EVL_SYS_ID, TYPES_CODE, TYPES_CONTENT_NUMBER, EMP_COMMENT, EMP_UPD_DT )");
		sqlstr.append(" VALUES (?, ?, ?, ?, SYSDATE)");
		try {
			psmt = con.prepareStatement(sqlstr.toString());
			psmt.setLong(1, id);
			psmt.setString(2, evaluationCode);
			psmt.setInt(3, contentNumber);
			psmt.setString(4, comment);
			retval = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("CREATE SINGLE ENTRY TXN INSERT DB ERROR status to " + retval + " for evaluation id "
					+ id + " " + evaluationCode + " " + contentNumber);
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				// if(rs!=null)
				// rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int createNewSingleCategoryEntryByManager(long id, String evaluationCode, int contentNumber, String comment,
			int rating, String dmCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		PreparedStatement psmt = null;
		int retval = 0;
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN ");
		sqlstr.append("( EMP_EVL_SYS_ID, TYPES_CODE, TYPES_CONTENT_NUMBER, DM_COMMENT, RATING, DM_UID, DM_UPD_DT )");
		sqlstr.append(" VALUES (?, ?, ?, ?, ?, ?,  SYSDATE)");
		try {
			psmt = con.prepareStatement(sqlstr.toString());
			psmt.setLong(1, id);
			psmt.setString(2, evaluationCode);
			psmt.setInt(3, contentNumber);
			psmt.setString(4, comment);
			psmt.setInt(5, rating);
			psmt.setString(6, dmCode);
			retval = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("CREATE SINGLE ENTRY TXN INSERT DB ERROR by Manager status to " + retval
					+ " for evaluation id " + id + " " + evaluationCode + " " + contentNumber);
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				// if(rs!=null)
				// rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int updateSingleCategory(long id, String evaluationCode, int contentNumber, String comment) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			String sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN   "
					+ " SET EMP_COMMENT = ?, EMP_UPD_DT = SYSDATE  "
					+ " WHERE EMP_EVL_SYS_ID = ?  AND TYPES_CODE = ? AND TYPES_CONTENT_NUMBER = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			myStmt.setLong(2, id);
			myStmt.setString(3, evaluationCode);
			myStmt.setInt(4, contentNumber);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating single categry cntnt updated by emp optn   status to "
							+ logType + " for evaluation id " + id + " " + evaluationCode + " " + contentNumber);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateSingleCategoryByManager(long id, String evaluationCode, int contentNumber, String comment,
			int rating, String dmCode) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			String sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN   "
					+ " SET DM_COMMENT = ?, RATING = ?, DM_UID = ?, DM_UPD_DT = SYSDATE  "
					+ " WHERE EMP_EVL_SYS_ID = ?  AND TYPES_CODE = ? AND TYPES_CONTENT_NUMBER = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			myStmt.setInt(2, rating);
			myStmt.setString(3, dmCode);
			myStmt.setLong(4, id);
			myStmt.setString(5, evaluationCode);
			myStmt.setInt(6, contentNumber);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating single categry cntnt updated by manger optn   status to "
							+ logType + " for evaluation id " + id + " " + evaluationCode + " " + contentNumber);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public HrEvaluationOperations createNewEvalMasterEntryGeneralByEmployee(String empCode, int evaluationYear,
			String comment, int fieldCode, int evaluationTerm, String evaluatorCode) {
		HrEvaluationOperations optnFlags = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return new HrEvaluationOperations(0, -2);
		PreparedStatement psmt = null;
		int retval = 0;
		String generatedColumns[] = { "EMP_EVL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER ");
		sqlstr.append("( EVL_YEAR, EVL_TERM, EMP_ID, EMP_CRD_DT, DM_UID ");
		if (fieldCode == 1) {// goals
			sqlstr.append(" ,EMP_GOALS_PROF_DEV_CMMNT)");
		} else {// employee comment
			sqlstr.append(" ,EMP_COMMENT)");
		}
		sqlstr.append(" VALUES ( ?, ?, ?,  SYSDATE, ?, ?) ");

		try {

			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setInt(1, evaluationYear);
			psmt.setInt(2, evaluationTerm);
			psmt.setString(3, empCode);
			psmt.setString(4, evaluatorCode);
			psmt.setString(5, comment);
			retval = psmt.executeUpdate();
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) {
				optnFlags = new HrEvaluationOperations(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("NEW EVL MASTER ENTRY INSERT GENERAL DB ERROR status to " + retval
					+ " for employee evltn " + empCode + "  and year " + evaluationYear);
			e.printStackTrace();
			optnFlags = new HrEvaluationOperations(0, -2);
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Exception in closing DB resources");
				optnFlags = new HrEvaluationOperations(0, -2);
			}
		}
		return optnFlags;
	}

	public HrEvaluationOperations createNewEvaluationMasterEntryGeneralByManager(String empCode, int evaluationYear,
			String comment, int evaluationTerm, String dmCode) {
		HrEvaluationOperations optnFlags = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return new HrEvaluationOperations(0, -2);
		PreparedStatement psmt = null;
		int retval = 0;
		String generatedColumns[] = { "EMP_EVL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER ");
		sqlstr.append("( EVL_YEAR, EVL_TERM, EMP_ID, DM_UID, DM_UPD_DT, DM_COMMENT)");
		sqlstr.append(" VALUES ( ?, ?, ?, ?,  SYSDATE, ?) ");

		try {

			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setInt(1, evaluationYear);
			psmt.setInt(2, evaluationTerm);
			psmt.setString(3, empCode);
			psmt.setString(4, dmCode);
			psmt.setString(5, comment);
			retval = psmt.executeUpdate();
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) {
				optnFlags = new HrEvaluationOperations(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("NEW EVL MASTER ENTRY INSERT GENERAL BY MANAGER  DB ERROR status to " + retval
					+ " for employee evltn " + empCode + "  and year " + evaluationYear);
			e.printStackTrace();
			optnFlags = new HrEvaluationOperations(0, -2);
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Exception in closing DB resources");
				optnFlags = new HrEvaluationOperations(0, -2);
			}
		}
		return optnFlags;
	}

	public int updateEvaluationMasterEntryGeneral(long id, String empCode, int evaluationYear, String comment,
			int fieldCode) {
		int logType = -2;
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			if (fieldCode == 1) {
				sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER   " + " SET " + " EMP_GOALS_PROF_DEV_CMMNT = ?,"
						+ " EMP_UPD_DT = SYSDATE  " + " WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ? ";
			} else {
				sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER   " + " SET " + " EMP_COMMENT = ?,"
						+ " EMP_UPD_DT = SYSDATE  " + " WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ? ";
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			myStmt.setLong(2, id);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating mast goals/emp comment updated by emp optn   status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateEvaluationMasterEntryGeneralByManager(long id, String empCode, int evaluationYear, String comment,
			int evaluationTerm, String dmCode) {
		int logType = -2;
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;

			sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    SET   DM_COMMENT = ?, DM_UID = ?, "
					+ " DM_UPD_DT = SYSDATE  WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ?  AND EVL_TERM = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			myStmt.setString(2, dmCode);
			myStmt.setLong(3, id);
			myStmt.setString(4, empCode);
			myStmt.setInt(5, evaluationYear);
			myStmt.setInt(6, evaluationTerm);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating mast dm comment updated by manager optn   status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int closeEvaluation(long id, String empCode, int evaluationYear, int finalOperation, int evaluationTerm,
			String dmCode) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;

			String sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER   " + " SET "
					+ " EVL_OPTN_STATUS = ?, DM_UID = ?, " + " EMP_UPD_DT = SYSDATE  "
					+ " WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ? AND EVL_TERM = ? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, finalOperation); // 1: submitted to mgr, 2: return by mgr for resubmit, 3: resubmitted to
												// mgr, 4: approved by mgr
			myStmt.setString(2, dmCode);
			myStmt.setLong(3, id);
			myStmt.setString(4, empCode);
			myStmt.setInt(5, evaluationYear);
			myStmt.setInt(6, evaluationTerm);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating notify manger operation  updated by emp optn   status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int sendHREvaluationMailNotification(int evaluationYear, int evaluationTerm, String toEmpCode,
			String toEmpName, String ccEmpCode, String ccEmpName, String mailSubject, String mailContent) {
		int logType = -2;
		EmailHrEvaluation sslmail = new EmailHrEvaluation();
		String toAddress = getEmailIdByEmpcode(toEmpCode);
		String ccAddress = getEmailIdByEmpcode(ccEmpCode);
		// System.out.println(toEmpCode+"/"+toAddress+" - "+ccEmpCode+"/"+ccAddress);
		if (toAddress != null && ccAddress != null) {

			String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
					+ "<tr>" + "<td align=\"left\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
					+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>"
					+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
					+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">" + mailSubject
					+ "</div>" + "</td>" + "</tr>" + "<tr>"
					+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
					+ "<b>Dear " + toEmpName + ",</b>" + "<p>" + mailContent + "<br/> " + "<h4><u>Details</u></h4> "
					+ "<b>Evaluation Updated By :</b>  " + ccEmpName + "<br/>" + "<br/>";
			sslmail.setToaddr(toAddress);
			sslmail.setCcaddr(ccAddress);
			sslmail.setMessageSub(mailSubject);
			sslmail.setMessagebody(msg);
			int status = sslmail.sendMail();
			if (status != 1) {

				System.out.print("Error in sending Mail to employee for evaluation update notify  status : " + status);
			} else {
				// System.out.print("Sent Mail to employee for evaluation update notify
				// successfully, status : " + status);
			}
			logType = status;
		}

		return logType;
	}

	public String getEmailIdByEmpcode(String empCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND ROWNUM = ? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, empCode);
			psmt.setInt(2, 1);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = null;
			}
		}
		return retval;
	}

	public int getTotalActualScoreByMgr(String employeeCode, int evaluationYear, int evaluationTerm) {
		int logType = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;

			String sql = "  SELECT SUM(COALESCE(RATING,0)) ACTUAL_SCORE  from FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN"
					+ " WHERE EMP_EVL_SYS_ID = ( SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER"
					+ " WHERE  EMP_ID = ? AND  EVL_YEAR = ? AND EVL_TERM = ?  ) ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, employeeCode);
			myStmt.setInt(2, evaluationYear);
			myStmt.setInt(3, evaluationTerm);
			myRes = myStmt.executeQuery();
			if (myRes.next()) {
				logType = myRes.getInt(1);
			}

		} catch (SQLException ex) {
			logType = 0;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time of getting actual score , status " + logType);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	// report section

	public HrEvaluationReport getSingleEmployeeCategoryScore(String subordinateCode, String subordinateName,
			int evaluationYear, int evaluationTerm) throws SQLException {

		HrEvaluationReport empCategryContents = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		int total = 0;
		java.sql.Date sqlDate = null;
		String evlCategoryCode = null;
		Map<String, Integer> catMapObj = new LinkedHashMap();
		try {
			String s = "01/01/" + evaluationYear;
			java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
			sqlDate = new java.sql.Date(date1.getTime());

		} catch (Exception e) {

		}
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete evaluation category wise summary
			String sql = "SELECT  CODE, DESCRPTION, COALESCE(TOTAL_SCORE,0) TOTAL_SCORE,DPORDER FROM  " + " (    "
					+ " SELECT DISTINCT EVL_CODE CODE,DESCRPTION ,DPORDER  from FJPORTAL.HR_EVALUATION_TYPES_DETAILS  HETD  "
					+ " LEFT JOIN  FJPORTAL.HR_EVALUATION_TYPES_MASTER     " + " ON EVL_CODE = CODE    "
					+ " WHERE ? BETWEEN HETD.EFFECTIVE_START_DATE AND nvl(HETD.EFFECTIVE_END_DATE,SYSDATE+1) AND RATING_REQRD_YN = 'Y'    "
					+ " GROUP BY EVL_CODE, DESCRPTION ,DPORDER   " + "  ) T1    " + " LEFT JOIN" + " ("
					+ " SELECT TYPES_CODE , COALESCE(SUM(RATING),0) TOTAL_SCORE  FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN   "
					+ " WHERE EMP_EVL_SYS_ID = (     "
					+ " SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER     "
					+ " WHERE  EMP_ID = ?  AND  EVL_YEAR = ? AND EVL_TERM = ? )       " + " GROUP BY TYPES_CODE"
					+ " )T2" + "  ON  T1.CODE = T2.TYPES_CODE" + "  ORDER BY DPORDER ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, sqlDate);
			myStmt.setString(2, subordinateCode);
			myStmt.setInt(3, evaluationYear);
			myStmt.setInt(4, evaluationTerm);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				evlCategoryCode = myRes.getString(1);
				// String evlCategoryDesc = myRes.getString(2);
				int score = myRes.getInt(3);
				total = total + score;
				catMapObj.put(evlCategoryCode, score);
				/*
				 * switch (evlCategoryCode) { case "ADAP": adap = score; break; case "CSRV":
				 * csrv = score; break; case "DLRY": dlry = score; break; case "IPSK": ipsk =
				 * score; break; case "LDRP": ldrp = score; break; case "QLTY": qlty = score;
				 * break; case "FJGCCV": fjgcc = score; break; case "SLDRP": sldrp = score;
				 * break; case "CR": cr = score; break; default: break;
				 * 
				 * }
				 */
			}
			empCategryContents = new HrEvaluationReport(subordinateCode, subordinateName, total, catMapObj);
			return empCategryContents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationCategory> getCompleteCategoryContentForReport(String empCode, int evaluationYear,
			int evaluationTerm) throws SQLException {

		List<HrEvaluationCategory> empCategryContents = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		java.sql.Date sqlDate = null;
		try {
			String s = "01/01/" + evaluationYear;
			java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
			sqlDate = new java.sql.Date(date1.getTime());

		} catch (Exception e) {

		}
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete category evaluation content details
			String sql = " SELECT    CODE,CONTENT_NUMBER, DESCRPTION, EMP_COMMENT, DM_COMMENT,  COALESCE(RATING,0), DETAILS ,RATING_REQRD_YN  FROM   "
					+ " (     "
					+ " SELECT  EVL_CODE CODE,CONTENT_NUMBER, DESCRPTION, DETAILS,DPORDER ,RATING_REQRD_YN from FJPORTAL.HR_EVALUATION_TYPES_DETAILS   HETD  "
					+ " LEFT JOIN  FJPORTAL.HR_EVALUATION_TYPES_MASTER      " + " ON EVL_CODE = CODE   "
					+ " WHERE   ?  BETWEEN HETD.EFFECTIVE_START_DATE AND nvl(HETD.EFFECTIVE_END_DATE,SYSDATE+1)"
					+ " AND (HETD.EMP_CATEGORY IS NULL OR HETD.EMP_CATEGORY IN ("
					+ "	SELECT nvl(HEET.EMP_CATEGORY,'EMP') FROM PM_EMP_KEY PEK"
					+ "	LEFT JOIN HR_EVALUATION_EMP_TYPES HEET" + "	ON PEK.EMP_CODE = HEET.EMP_CODE "
					+ "	WHERE PEK.EMP_CODE = ?)) " + " ORDER BY CODE,CONTENT_NUMBER      " + "  ) T1     "
					+ " LEFT JOIN " + " ( "
					+ " SELECT TYPES_CODE,TYPES_CONTENT_NUMBER, EMP_COMMENT, DM_COMMENT, RATING   FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN    "
					+ " WHERE EMP_EVL_SYS_ID = (      "
					+ " SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER      "
					+ " WHERE  EMP_ID = ?  AND  EVL_YEAR = ? AND EVL_TERM = ? )    " + " )T2 "
					+ "  ON  T1.CODE = T2.TYPES_CODE AND T1.CONTENT_NUMBER = T2.TYPES_CONTENT_NUMBER "
					+ "  ORDER BY DPORDER, CONTENT_NUMBER";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, sqlDate);
			myStmt.setString(2, empCode);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String code = myRes.getString(1);
				int content_number = myRes.getInt(2);
				String code_desc = myRes.getString(3);
				String emp_comment = myRes.getString(4);
				String dm_comment = myRes.getString(5);
				int finatRating = myRes.getInt(6);
				String contentDetails = myRes.getString(7);
				String ratingReqYorN = myRes.getString(8);
				HrEvaluationCategory tempEvlCategryDtlsList = new HrEvaluationCategory(code, content_number, code_desc,
						emp_comment, dm_comment, finatRating, contentDetails, ratingReqYorN);
				empCategryContents.add(tempEvlCategryDtlsList);
			}
			return empCategryContents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public HrEvaluationDetails getGeneralCommentsForReports(String empCode, int evaluationYear, int evaluationTerm)
			throws SQLException {

		HrEvaluationDetails empGeneralContents = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		String closeStatus1 = "Closed Evaluation With Mutual Understand";
		String closeStatus2 = "Closed Evaluation With Pending Discussion";
		String closeStatus3 = "Evaluation closed successfully.";
		String status = "";
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			status = "";
			myCon = orcl.getOrclConn();
			// --query to get employee general details
			String sql = "SELECT EMP_GOALS_PROF_DEV_CMMNT, EMP_COMMENT, DM_COMMENT, COALESCE(EVL_OPTN_STATUS,0), EVL_EMP_ENTRY_ACTV, HR_COMMENT, IMPRMENT_ARERS, get_emp_training_needs(heeem.training_needs) as emp_training_needs,EVL_HR_ENTRY_ACTV FROM  FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER  heeem "
					+ "WHERE EMP_ID = ? AND EVL_YEAR = ? AND  EVL_TERM = ? AND ROWNUM = 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setInt(2, evaluationYear);
			myStmt.setInt(3, evaluationTerm);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empGoals = myRes.getString(1);
				String empComment = myRes.getString(2);
				String dmComment = myRes.getString(3);
				int evlCloseStstus = myRes.getInt(4);
				int empEntryActivity = myRes.getInt(5);
				String hrComment = myRes.getString(6);
				String imprAreas = myRes.getString(7);
				String trainingneeds = myRes.getString(8);
				int hrEntryActivity = myRes.getInt(9);
				switch (evlCloseStstus) {
				case 1:
					if (evlCloseStstus == 1 && empEntryActivity == 0) {
						status = closeStatus2;
					} else if (evlCloseStstus == 1 && hrEntryActivity == 1) {
						status = closeStatus3;
					} else {
						status = closeStatus1;
					}

					break;
				case 2:
					status = closeStatus2;
					break;
				default:
					status = "";
					break;
				}

				empGeneralContents = new HrEvaluationDetails(empGoals, empComment, dmComment, status, hrComment,
						imprAreas, trainingneeds);
			}
			if (empGeneralContents == null) {
				empGeneralContents = new HrEvaluationDetails("", "", "", "", "", "", "");
			}
			return empGeneralContents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationReport> getEvaluationReportForManagment(int evaluationYear, int evaluationTerm)
			throws SQLException {

		List<HrEvaluationReport> contents = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete category evaluation content details
			String sql = "SELECT COMP,DIVN, EMPCODE,EMP_NAME, EVAL_EMP_CODE, EVAL_EMP_NAME, DM_EMP_CODE, DM_EMP_NAME, EVAL_STATUS, "
					+ "COALESCE((SELECT SUM(COALESCE(RATING,0)) ACTUAL_SCORE  from FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN  "
					+ "WHERE EMP_EVL_SYS_ID = ( SELECT EMP_EVL_SYS_ID FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER  "
					+ "WHERE  EMP_ID = EMPCODE  AND  EVL_YEAR = ? AND EVL_TERM = ?  )), 0) \"Actual Score\" "
					+ "FROM  EMP_EVAL " + "WHERE EVL_YEAR = ? AND EVL_TERM = ? " + "ORDER BY EVAL_STATUS DESC " + " ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, evaluationYear);
			myStmt.setInt(2, evaluationTerm);
			myStmt.setInt(3, evaluationYear);
			myStmt.setInt(4, evaluationTerm);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String division = myRes.getString(2);
				String empCode = myRes.getString(3);
				String empName = myRes.getString(4);
				String evaluatorCode = myRes.getString(5);
				String evaluatorName = myRes.getString(6);
				String dmCode = myRes.getString(7);
				String dmName = myRes.getString(8);
				String status = myRes.getString(9);
				int totalScore = myRes.getInt(10);

				HrEvaluationReport tempContentList = new HrEvaluationReport(company, division, empCode, empName,
						evaluatorCode, evaluatorName, dmCode, dmName, status, totalScore);
				contents.add(tempContentList);
			}
			return contents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public String getEvaluatorCode(String empCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD7 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND ROWNUM = ? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, empCode);
			psmt.setInt(2, 1);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = null;
			}
		}
		return retval;
	}

	public int getEmployeeCommntsOrRespCount(int evaluationYear, int evaluationTerm, long id, String employeeCode) {
		int logType = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			String sql = " SELECT SUM(TOTAL) \"TOTAL\" FROM ( "
					+ "SELECT COUNT(*) \"TOTAL\" FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER "
					+ "WHERE EMP_EVL_SYS_ID = ? AND EMP_ID = ? AND EVL_YEAR = ? AND EVL_TERM = ? AND (EMP_GOALS_PROF_DEV_CMMNT IS NOT NULL OR EMP_COMMENT IS NOT NULL) "
					+ "UNION " + "SELECT COUNT(*) FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_TXN "
					+ "WHERE  EMP_EVL_SYS_ID = ? AND EMP_COMMENT IS NOT NULL " + ") ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setLong(1, id);
			myStmt.setString(2, employeeCode);
			myStmt.setInt(3, evaluationYear);
			myStmt.setInt(4, evaluationTerm);
			myStmt.setLong(5, id);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				logType = myRes.getInt(1);
			}
		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println("Exception in closing DB resources at the checking employee response count " + logType
					+ " for evaluation id " + id);
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logType;
	}

	public String getEmpCategory(String empCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT EMP_CATEGORY FROM FJPORTAL.HR_EVALUATION_EMP_TYPES WHERE EMP_CODE = ? AND ROWNUM = ? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, empCode);
			psmt.setInt(2, 1);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = null;
			}
		}
		return retval;
	}

	public List<HrEvaluationReport> getAllEmployeesCommentsDoneByManager(String dmcode, int evaluationYear,
			int evaluationTerm) throws SQLException {

		List<HrEvaluationReport> contents = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete category evaluation content details
			String sql = " SELECT  EMP_ID, EMP_NAME,EMP_COMP_CODE,EMP_DEPT_CODE      "
					+ " FROM FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER , PM_EMP_KEY "
					+ " WHERE EMP_CODE = EMP_ID  AND EVL_YEAR = ? AND EVL_TERM = ? AND EMP_END_OF_SERVICE_DT IS NULL AND  EVL_MANAGER_ENTRY_ACTV=1 AND EVL_OPTN_STATUS = 0 AND EVL_EMP_ENTRY_ACTV =1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, evaluationYear);
			myStmt.setInt(2, evaluationTerm);
			// myStmt.setInt(3, evaluationYear);
			// myStmt.setInt(4, evaluationTerm);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empCode = myRes.getString(1);
				String empName = myRes.getString(2);
				String empcompcode = myRes.getString(3);
				String empdeptName = myRes.getString(4);
				HrEvaluationReport tempContentList = new HrEvaluationReport(empCode, empName, empcompcode, empdeptName);
				contents.add(tempContentList);
			}
			return contents;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int updateEvaluationMasterEntryGeneralByHR(long id, String empCode, int evaluationYear, String comment,
			int evaluationTerm, String dmCode) {
		int logType = -2;
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;

			sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    SET   HR_COMMENT = ?, EVL_HR_ENTRY_ACTV = 1, HR_UPD_DT = SYSDATE"
					+ " WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ?  AND EVL_TERM = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			// myStmt.setString(2, dmCode);
			myStmt.setLong(2, id);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating mast dm comment updated by manager optn   status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateEvaluationMasterEntryAreasImprByMgr(long id, String empCode, int evaluationYear, String comment,
			int evaluationTerm, String dmCode) {
		int logType = -2;
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;

			sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    SET   IMPRMENT_ARERS = ?"
					+ " WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ?  AND EVL_TERM = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			// myStmt.setString(2, dmCode);
			myStmt.setLong(2, id);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating mast dm comment updated by manager optn   status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public int updateEvaluationMasterEntryTrainingNeedsByMgr(long id, String empCode, int evaluationYear,
			String comment, int evaluationTerm, String dmCode) {
		int logType = -2;
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;

			sql = " UPDATE FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER    SET   TRAINING_NEEDS = ?"
					+ " WHERE EMP_EVL_SYS_ID = ?  AND EMP_ID = ? AND EVL_YEAR = ?  AND EVL_TERM = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, comment);
			// myStmt.setString(2, dmCode);
			myStmt.setLong(2, id);
			myStmt.setString(3, empCode);
			myStmt.setInt(4, evaluationYear);
			myStmt.setInt(5, evaluationTerm);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			ex.printStackTrace();
			System.out.println(
					"Exception in closing DB resources at the time updating mast dm comment updated by manager optn   status to "
							+ logType + " for evaluation id " + id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public HrEvaluationOperations createNewEvaluationMasterEntryImprareasByManager(String empCode, int evaluationYear,
			String comment, int evaluationTerm, String dmCode) {
		HrEvaluationOperations optnFlags = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return new HrEvaluationOperations(0, -2);
		PreparedStatement psmt = null;
		int retval = 0;
		String generatedColumns[] = { "EMP_EVL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER ");
		sqlstr.append("( EVL_YEAR, EVL_TERM, EMP_ID, DM_UID, DM_UPD_DT, IMPRMENT_ARERS)");
		sqlstr.append(" VALUES ( ?, ?, ?, ?,  SYSDATE, ?) ");

		try {

			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setInt(1, evaluationYear);
			psmt.setInt(2, evaluationTerm);
			psmt.setString(3, empCode);
			psmt.setString(4, dmCode);
			psmt.setString(5, comment);
			retval = psmt.executeUpdate();
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) {
				optnFlags = new HrEvaluationOperations(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("NEW EVL MASTER ENTRY INSERT GENERAL BY MANAGER  DB ERROR status to " + retval
					+ " for employee evltn " + empCode + "  and year " + evaluationYear);
			e.printStackTrace();
			optnFlags = new HrEvaluationOperations(0, -2);
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Exception in closing DB resources");
				optnFlags = new HrEvaluationOperations(0, -2);
			}
		}
		return optnFlags;
	}

	public HrEvaluationOperations createNewEvaluationMasterEntryTraingingneedsByManager(String empCode,
			int evaluationYear, String comment, int evaluationTerm, String dmCode) {
		HrEvaluationOperations optnFlags = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return new HrEvaluationOperations(0, -2);
		PreparedStatement psmt = null;
		int retval = 0;
		String generatedColumns[] = { "EMP_EVL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder("INSERT INTO FJPORTAL.HR_EVALUATION_EMP_ENTRY_MASTER ");
		sqlstr.append("( EVL_YEAR, EVL_TERM, EMP_ID, DM_UID, DM_UPD_DT, TRAINING_NEEDS)");
		sqlstr.append(" VALUES ( ?, ?, ?, ?,  SYSDATE, ?) ");

		try {

			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setInt(1, evaluationYear);
			psmt.setInt(2, evaluationTerm);
			psmt.setString(3, empCode);
			psmt.setString(4, dmCode);
			psmt.setString(5, comment);
			retval = psmt.executeUpdate();
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) {
				optnFlags = new HrEvaluationOperations(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("NEW EVL MASTER ENTRY INSERT GENERAL BY MANAGER  DB ERROR status to " + retval
					+ " for employee evltn " + empCode + "  and year " + evaluationYear);
			e.printStackTrace();
			optnFlags = new HrEvaluationOperations(0, -2);
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Exception in closing DB resources");
				optnFlags = new HrEvaluationOperations(0, -2);
			}
		}
		return optnFlags;
	}

}
