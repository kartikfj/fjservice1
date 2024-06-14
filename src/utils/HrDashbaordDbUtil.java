package utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import beans.HREmployeeSalary;
import beans.HrDashbaord;
import beans.HrDashbaordEmployeeCompleteDetails;
import beans.HrDashbaordEmployeeGeneralDetails;
import beans.HrDashbaordEmployeeMoreDetails;
import beans.HrDashboardLeaveDetails;
import beans.HrDashboardLeaveHistory;
import beans.HrEvaluationUserProfile;
import beans.OrclDBConnectionPool;

public class HrDashbaordDbUtil {

	public HrDashbaord employeeUserProfile(String empCode) throws SQLException {

		HrDashbaord empDtls = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee complete master entry
			String sql = " SELECT EMP_CODE, EMP_NAME, EMP_COMP_CODE, EMP_DIVN_CODE,  EMP_JOIN_DT, EMP_JOB_LONG_DESC,    "
					+ "  (SELECT  EMP_NAME  FROM FJPORTAL.PM_EMP_KEY    "
					+ "  WHERE EMP_CODE = (SELECT TXNFIELD_FLD7 FROM FJPORTAL.PT_TXN_FLEX_FIELDS    "
					+ "  WHERE TXNFIELD_EMP_CODE = ? AND ROWNUM = ?) ) MANAGER,   "
					+ "   (SELECT  EMP_CODE  FROM FJPORTAL.PM_EMP_KEY   "
					+ "  WHERE EMP_CODE = (SELECT TXNFIELD_FLD7 FROM FJPORTAL.PT_TXN_FLEX_FIELDS    "
					+ "   WHERE TXNFIELD_EMP_CODE = ? AND ROWNUM = ?) ) MANAGER_CODE   "
					+ "   FROM FJPORTAL.PM_EMP_KEY  " + "   WHERE EMP_CODE = ? AND ROWNUM = ?";
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
				String company = myRes.getString(3);
				String division = myRes.getString(4);
				String joiningDate = myRes.getString(5);
				String jobTitle = myRes.getString(6);
				String manager = myRes.getString(7);
				empDtls = new HrDashbaord(employeeCode, empName, company, division, joiningDate, jobTitle, manager);

			}
			return empDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrEvaluationUserProfile> employeeList() throws SQLException {
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
					+ " WHERE EMP_FRZ_FLAG = ? AND  (EMP_STATUS = ?  OR EMP_STATUS = ?) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "N");
			myStmt.setInt(2, 1);
			myStmt.setInt(3, 2);

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

	public List<HrDashboardLeaveDetails> employeeleaveDetails(String empCode) throws SQLException {

		List<HrDashboardLeaveDetails> empLeave = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee leave details summary
			String sql = " Select * from FJPORTAL.LEAVE_STAT_AKM where EMPCODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String employeeCode = myRes.getString(1);
				String leave = myRes.getString(2);
				int year = myRes.getInt(3);
				float accruedleaveDays = myRes.getFloat(4);
				float availedLeaveDays = myRes.getFloat(5);
				float balanceDays = myRes.getFloat(6);

				HrDashboardLeaveDetails tempEmpLeave = new HrDashboardLeaveDetails(employeeCode, leave, year,
						accruedleaveDays, availedLeaveDays, balanceDays);
				empLeave.add(tempEmpLeave);
			}
			return empLeave;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrDashboardLeaveHistory> employeeleaveHistory(String empCode) throws SQLException {

		List<HrDashboardLeaveHistory> empLeave = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee leave details summary
			String sql = " Select * from FJPORTAL.LEAVE_DET_AKM where EMPCODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String employeeCode = myRes.getString(1);
				String leave = myRes.getString(2);
				String from = myRes.getString(3);
				String to = myRes.getString(4);
				float leaveDays = myRes.getFloat(5);

				HrDashboardLeaveHistory tempEmpLeave = new HrDashboardLeaveHistory(employeeCode, leave, from, to,
						leaveDays);
				empLeave.add(tempEmpLeave);
			}
			return empLeave;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HREmployeeSalary> employeeSalaryHistory(String empCode) throws SQLException {
		List<HREmployeeSalary> empSalary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee salary details summary
			// String sql = " SELECT * FROM FJPORTAL.SAL_REVN_AKM WHERE EMPCODE = ? ";
			String sql = " SELECT * FROM  FJPORTAL.SAL_REVN_AKM1 WHERE EMPCODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String employeeCode = myRes.getString(1);
				String from = myRes.getString(2);
				// String to = myRes.getString(3);
				String allowance = myRes.getString(5);
				String currency = myRes.getString(3);
				String basicAmount = myRes.getString(4);
				// String adjAmount = myRes.getString(8);
				String totalAmount = myRes.getString(6);
				HREmployeeSalary tempEmpSalary = new HREmployeeSalary(employeeCode, from, "", allowance, currency,
						basicAmount, "", totalAmount);
				empSalary.add(tempEmpSalary);
			}
			return empSalary;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<HrDashbaordEmployeeCompleteDetails> employeeCompleteDetails() throws SQLException {
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;

		List<HrDashbaordEmployeeCompleteDetails> empCompleteDetails = new ArrayList<>();

		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			// String sql = "SELECT * FROM FJPORTAL.EMPDET_AKM T1 " + "LEFT JOIN " +
			// "FJPORTAL.HR_EMP_MORE_DTLS_AKM T2 "+ "ON T1.EMPLOYEE_CODE = T2.EMP_ID";
			// String sql = "SELECT * FROM FJPORTAL.EMPDET_AKM_NEW T1 " + "LEFT JOIN "
			// + "FJPORTAL.HR_EMP_MORE_DTLS_AKM T2 " + "ON T1.EMPLOYEE_CODE = T2.EMP_ID";
			String sql = "SELECT * FROM FJPORTAL.EMPDET_AKM_NEW";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String emp_comp_code = myRes.getString(1);
				String division = myRes.getString(2);
				String department = myRes.getString(3);
				String job_location = myRes.getString(4);
				String status = myRes.getString(5);
				String leftReason = myRes.getString(6);
				String emp_type = myRes.getString(7);
				String skilledornot = myRes.getString(8);
				String emp_code = myRes.getString(9);
				System.out.println("emp_code==" + emp_code);
				String name = myRes.getString(10);
				String desingationCode = myRes.getString(11);
				String designation = myRes.getString(12);
				String birth_dt = myRes.getString(13);
				String age = myRes.getString(14);
				String gender = myRes.getString(15);
				String nationality = myRes.getString(16);
				String maritalStatus = myRes.getString(17);
				String grade = myRes.getString(18);
				String currency = myRes.getString(19);
				String basic_amt = myRes.getString(20);
				String allow_amt = myRes.getString(21);
				String tot_sal = myRes.getString(22);
				String supervisorCode = myRes.getString(23);
				String supervisorName = myRes.getString(24);
				String supervisorDesignation = myRes.getString(25);
				String passport_Number = myRes.getString(26);
				String passport_Expiry_Date = myRes.getString(27);
				String laborcard_Number = myRes.getString(28);
				String laborcard_Expiry_Date = myRes.getString(29);
				String EID_Number = myRes.getString(30);
				String EID_Expiry_Date = myRes.getString(31);
				String join_date = myRes.getString(32);
				String emp_end_of_service_dt = myRes.getString(33);
				String tenure = myRes.getString(34);
				String email = myRes.getString(35);
				// String emp_id = myRes.getString(37);
				String office_Mobile_Number = myRes.getString(36);
				// String emirates_Id_Number = myRes.getString(38);
				// String emirates_Id_Expiry_Date = myRes.getString(40);
				// String visa_Number = myRes.getString(41);
				// String date_Of_Issue = myRes.getString(42);
				// String visa_Expiry_Date = myRes.getString(43);
				// String uid_Number = myRes.getString(44);
				// String uID_Expiry_Date = myRes.getString(45);
				String medical_Insurance_Category = myRes.getString(37);
				String emergency_Contact_Full_Name = myRes.getString(38);
				String emergency_Contact_Mobile_Number = myRes.getString(39);
				String emergency_Contact_Relationship = myRes.getString(40);
				String end_Of_Service_Nomination = myRes.getString(41);
				String end_Of_Service_Mobile_Number = myRes.getString(42);
				String religiondesc = myRes.getString(44);
				String education1desc = myRes.getString(46);
				String education2desc = myRes.getString(48);
				String education3desc = myRes.getString(50);

				String directSupervisorCode = myRes.getString(60);
				String directSupervisorName = myRes.getString(61);
				String directSupervisorDesig = myRes.getString(62);
				String costCenterCode = myRes.getString(63);
				String costCenterDetails = myRes.getString(64);
				HrDashbaordEmployeeCompleteDetails tempEmpCompleteDetails = new HrDashbaordEmployeeCompleteDetails(
						emp_comp_code, emp_code, name, status, division, department, designation, email, age, gender,
						nationality, join_date, emp_end_of_service_dt, tenure, job_location, emp_type, birth_dt, grade,
						basic_amt, allow_amt, tot_sal, office_Mobile_Number, passport_Number, passport_Expiry_Date,
						medical_Insurance_Category, emergency_Contact_Full_Name, emergency_Contact_Mobile_Number,
						emergency_Contact_Relationship, end_Of_Service_Nomination, end_Of_Service_Mobile_Number,
						religiondesc, education1desc, leftReason, skilledornot, desingationCode, maritalStatus,
						currency, supervisorCode, supervisorName, supervisorDesignation, laborcard_Number,
						laborcard_Expiry_Date, EID_Number, EID_Expiry_Date, education2desc, education3desc,
						directSupervisorCode, directSupervisorName, directSupervisorDesig, costCenterCode,
						costCenterDetails);

				empCompleteDetails.add(tempEmpCompleteDetails);

			}
			return empCompleteDetails;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<HrDashbaordEmployeeGeneralDetails> employeeDetails() throws SQLException {
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		List<HrDashbaordEmployeeGeneralDetails> empDetails = new ArrayList<>();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "SELECT * FROM FJPORTAL.EMPDET_AKM";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String emp_comp_code = myRes.getString(1);
				String emp_code = myRes.getString(2);
				String name = myRes.getString(3);
				String status = myRes.getString(4);
				String division = myRes.getString(5);
				String department = myRes.getString(6);
				String designation = myRes.getString(7);
				String email = myRes.getString(8);
				String comp_bank_code = myRes.getString(9);
				String emp_bank_code = myRes.getString(10);
				String iban_no = myRes.getString(11);
				String age = myRes.getString(12);
				String gender = myRes.getString(13);
				String nationality = myRes.getString(14);
				String join_date = myRes.getString(15);
				String emp_end_of_service_dt = myRes.getString(16);
				String tenure = myRes.getString(17);
				String job_location = myRes.getString(18);
				String emp_type = myRes.getString(19);
				String birth_dt = myRes.getString(20);
				String grade = myRes.getString(21);
				String basic_amt = myRes.getString(22);
				String allow_amt = myRes.getString(23);
				String tot_sal = myRes.getString(24);
				HrDashbaordEmployeeGeneralDetails tempEmpDetails = new HrDashbaordEmployeeGeneralDetails(emp_comp_code,
						emp_code, name, status, division, department, designation, email, comp_bank_code, emp_bank_code,
						iban_no, age, gender, nationality, join_date, emp_end_of_service_dt, tenure, job_location,
						emp_type, birth_dt, grade, basic_amt, allow_amt, tot_sal);
				empDetails.add(tempEmpDetails);
			}
			return empDetails;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<HrDashbaordEmployeeMoreDetails> employeeMoreDetails() throws SQLException {
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		List<HrDashbaordEmployeeMoreDetails> empDetails = new ArrayList<>();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "SELECT * FROM FJPORTAL.HR_EMP_MORE_DTLS_AKM";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String emp_code = myRes.getString(1);
				String office_Mobile_Number = myRes.getString(2);
				String emirates_Id_Number = myRes.getString(3);
				String emirates_Id_Expiry_Date = myRes.getString(4);
				String visa_Number = myRes.getString(5);
				String date_Of_Issue = myRes.getString(6);
				String visa_Expiry_Date = myRes.getString(7);
				String uid_Number = myRes.getString(8);
				String uID_Expiry_Date = myRes.getString(9);
				String passport_Number = myRes.getString(10);
				String passport_Expiry_Date = myRes.getString(11);
				String medical_Insurance_Category = myRes.getString(12);
				String emergency_Contact_Full_Name = myRes.getString(13);
				String emergency_Contact_Mobile_Number = myRes.getString(14);
				String emergency_Contact_Relationship = myRes.getString(15);
				String end_Of_Service_Nomination = myRes.getString(16);
				String end_Of_Service_Mobile_Number = myRes.getString(17);
				String religion = myRes.getString(18);
				String education1 = myRes.getString(19);
				String eduDuration1 = myRes.getString(20);
				String education2 = myRes.getString(21);
				String eduDuration2 = myRes.getString(22);
				String education3 = myRes.getString(23);
				String eduDuration3 = myRes.getString(24);
				HrDashbaordEmployeeMoreDetails tempEmpDetails = new HrDashbaordEmployeeMoreDetails(emp_code,
						office_Mobile_Number, emirates_Id_Number, emirates_Id_Expiry_Date, visa_Number, date_Of_Issue,
						visa_Expiry_Date, uid_Number, uID_Expiry_Date, passport_Number, passport_Expiry_Date,
						medical_Insurance_Category, emergency_Contact_Full_Name, emergency_Contact_Mobile_Number,
						emergency_Contact_Relationship, end_Of_Service_Nomination, end_Of_Service_Mobile_Number,
						religion, education1, education2, education3, eduDuration1, eduDuration2, eduDuration3);
				empDetails.add(tempEmpDetails);

			}
			return empDetails;

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

	public HrDashbaordEmployeeCompleteDetails employeeCompleteSelfDetails(String empCode) throws SQLException {
		HrDashbaordEmployeeCompleteDetails empDetails = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee salary details summary
			// String sql = "SELECT * FROM FJPORTAL.EMPDET_AKM T1 " + "LEFT JOIN " +
			// "FJPORTAL.HR_EMP_MORE_DTLS_AKM T2 "
			// + "ON T1.EMPLOYEE_CODE = T2.EMP_ID WHERE T1.EMPLOYEE_CODE = ? AND ROWNUM =
			// 1";
			String sql = "SELECT * FROM FJPORTAL.EMPDET_AKM_NEW WHERE EMPLOYEE_CODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String emp_comp_code = myRes.getString(1);
				String division = myRes.getString(2);
				String department = myRes.getString(3);
				String job_location = myRes.getString(4);
				String status = myRes.getString(5);

				String emp_type = myRes.getString(7);
				String emp_code = myRes.getString(9);
				String name = myRes.getString(10);
				String designation = myRes.getString(12);
				String birth_dt = myRes.getString(13);
				String age = myRes.getString(14);
				String gender = myRes.getString(15);
				String nationality = myRes.getString(16);
				String grade = myRes.getString(18);
				String basic_amt = myRes.getString(20);
				String allow_amt = myRes.getString(21);
				String tot_sal = myRes.getString(22);
				String passport_Number = myRes.getString(26);
				String passport_Expiry_Date = myRes.getString(27);
				String EID_Number = myRes.getString(30);
				String EID_Expiry_Date = myRes.getString(31);
				String join_date = myRes.getString(32);
				String emp_end_of_service_dt = myRes.getString(33);
				String tenure = myRes.getString(34);
				String email = myRes.getString(35);
				String office_Mobile_Number = myRes.getString(36);
				// String emirates_Id_Number = myRes.getString(38);
				// String emirates_Id_Expiry_Date = myRes.getString(40);
				// String visa_Number = myRes.getString(41);
				// String date_Of_Issue = myRes.getString(42);
				// String visa_Expiry_Date = myRes.getString(43);
				// String uid_Number = myRes.getString(44);
				// String uID_Expiry_Date = myRes.getString(45);
				String medical_Insurance_Category = myRes.getString(37);
				String emergency_Contact_Full_Name = myRes.getString(38);
				String emergency_Contact_Mobile_Number = myRes.getString(39);
				String emergency_Contact_Relationship = myRes.getString(40);
				String end_Of_Service_Nomination = myRes.getString(41);
				String end_Of_Service_Mobile_Number = myRes.getString(42);
				String religioncode = myRes.getString(43);
				String religiondesc = myRes.getString(44);
				String education1code = myRes.getString(45);
				String education1desc = myRes.getString(46);
				String education2code = myRes.getString(47);
				String education2desc = myRes.getString(48);
				String education3code = myRes.getString(49);
				String education3desc = myRes.getString(50);
				String iban_no = myRes.getString(51);
				String duration1desc = myRes.getString(52);
				String duration2desc = myRes.getString(53);
				String duration3desc = myRes.getString(54);
				empDetails = new HrDashbaordEmployeeCompleteDetails(emp_comp_code, emp_code, name, status, division,
						department, designation, email, age, gender, nationality, join_date, emp_end_of_service_dt,
						tenure, job_location, emp_type, birth_dt, grade, basic_amt, allow_amt, tot_sal,
						office_Mobile_Number, EID_Number, EID_Expiry_Date, passport_Number, passport_Expiry_Date,
						medical_Insurance_Category, emergency_Contact_Full_Name, emergency_Contact_Mobile_Number,
						emergency_Contact_Relationship, end_Of_Service_Nomination, end_Of_Service_Mobile_Number,
						religioncode, religiondesc, education1code, education1desc, education2code, education2desc,
						education3code, education3desc, iban_no, duration1desc, duration2desc, duration3desc);

			}
			return empDetails;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public HrDashbaordEmployeeMoreDetails getEmployeeExsistingDetails(String empCode) throws SQLException {
		HrDashbaordEmployeeMoreDetails empMoreDetails = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			// --query to get employee salary details summary
			String sql = "SELECT * FROM  FJPORTAL.HR_EMP_MORE_DTLS_AKM   " + "  WHERE  EMP_ID =  ? AND ROWNUM = 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String emp_id = myRes.getString(1);
				String office_Mobile_Number = myRes.getString(2);
				String emirates_Id_Number = myRes.getString(3);
				String emirates_Id_Expiry_Date = myRes.getString(4);
				String visa_Number = myRes.getString(5);
				String date_Of_Issue = myRes.getString(6);
				String visa_Expiry_Date = myRes.getString(7);
				String uid_Number = myRes.getString(8);
				String uID_Expiry_Date = myRes.getString(9);
				String passport_Number = myRes.getString(10);
				String passport_Expiry_Date = myRes.getString(11);
				String medical_Insurance_Category = myRes.getString(12);
				String emergency_Contact_Full_Name = myRes.getString(13);
				String emergency_Contact_Mobile_Number = myRes.getString(14);
				String emergency_Contact_Relationship = myRes.getString(15);
				String end_Of_Service_Nomination = myRes.getString(16);
				String end_Of_Service_Mobile_Number = myRes.getString(17);
				String religion = myRes.getString(18);
				String education1 = myRes.getString(19);
				String eduDuration1 = myRes.getString(20);
				String education2 = myRes.getString(21);
				String eduDuration2 = myRes.getString(22);
				String education3 = myRes.getString(23);
				String eduDuration3 = myRes.getString(24);

				empMoreDetails = new HrDashbaordEmployeeMoreDetails(emp_id, office_Mobile_Number, emirates_Id_Number,
						emirates_Id_Expiry_Date, visa_Number, date_Of_Issue, visa_Expiry_Date, uid_Number,
						uID_Expiry_Date, passport_Number, passport_Expiry_Date, medical_Insurance_Category,
						emergency_Contact_Full_Name, emergency_Contact_Mobile_Number, emergency_Contact_Relationship,
						end_Of_Service_Nomination, end_Of_Service_Mobile_Number, religion, education1, education2,
						education3, eduDuration1, eduDuration2, eduDuration3);

			}
			return empMoreDetails;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int updateEmployeeMoreDetails(HrDashbaordEmployeeMoreDetails empMoreNewDetails) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			String sql = " UPDATE FJPORTAL.HR_EMP_MORE_DTLS_AKM   "
					+ " SET OFFICE_MOBILE_NUMBER = ? , RELIGION  = ?, EDUCATION = ? ,"
					+ " MEDICAL_INSURANCE_CATEGORY = ?, EMERG_CONTACT_FULL_NAME = ?, EMERG_CONTACT_MOBILE_NUMBER = ?, "
					+ " EMERGENCY_CONTACT_RELATIONSHIP = ?, END_OF_SERVICE_NOMINATION = ?, END_OF_SERVICE_MOBILE_NUMBER = ?, EDUCATION1 = ? ,EDUCATION2 = ? , DURATION = ?, DURATION1 = ?, DURATION2 = ?,  "
					+ " EMP_UPD_DT = SYSDATE  WHERE EMP_ID = ?    AND  ROWNUM = 1 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empMoreNewDetails.getOffice_Mobile_Number());
			myStmt.setString(2, empMoreNewDetails.getReligion());
			myStmt.setString(3, empMoreNewDetails.getEducation1());
			myStmt.setString(4, empMoreNewDetails.getMedical_Insurance_Category());
			myStmt.setString(5, empMoreNewDetails.getEmergency_Contact_Full_Name());
			myStmt.setString(6, empMoreNewDetails.getEmergency_Contact_Mobile_Number());
			myStmt.setString(7, empMoreNewDetails.getEmergency_Contact_Relationship());
			myStmt.setString(8, empMoreNewDetails.getEnd_Of_Service_Nomination());
			myStmt.setString(9, empMoreNewDetails.getEnd_Of_Service_Mobile_Number());
			myStmt.setString(10, empMoreNewDetails.getEducation2());
			myStmt.setString(11, empMoreNewDetails.getEducation3());
			myStmt.setString(12, empMoreNewDetails.getDuration1desc());
			myStmt.setString(13, empMoreNewDetails.getDuration2desc());
			myStmt.setString(14, empMoreNewDetails.getDuration3desc());
			myStmt.setString(15, empMoreNewDetails.getEmp_code());
			logType = myStmt.executeUpdate();
			// System.out.println("LOG VALUE : "+logType);
		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at the time updating user more details  "
					+ empMoreNewDetails.getEmp_code() + "");
			ex.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

	public Date getSqlDate(String str) {
		if (str == null || str.equals("") || str.isEmpty()) {
			return null;
		} else {
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			Date date;
			java.util.Date dt;
			try {
				dt = formatter.parse(str);
				// System.out.println(dt);
				date = new Date(dt.getTime());
			} catch (ParseException ex) {
				ex.printStackTrace();
				date = null;
			}

			// System.out.println(date);
			return date;
		}
	}

	public int createNewEmployeeMoreDetails(String empCode) {
		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null)
				return -2;
			String sql = " INSERT INTO FJPORTAL.HR_EMP_MORE_DTLS_AKM   " + " (  EMP_ID, EMP_CRD_DT  )"
					+ " VALUES (?, SYSDATE) ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			logType = myStmt.executeUpdate();
			// System.out.println("LOG VALUE : "+logType);
		} catch (SQLException ex) {
			logType = -2;
			System.out.println(
					"Exception in closing DB resources at the time creating new  user more details  " + empCode + "");
			ex.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}

}
