package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import beans.OrclDBConnectionPool;
import beans.SalaryCertificate;

public class ExperienceCertificateDbUtil {

	public SalaryCertificate getExperienceCertificateData(String empCode) throws SQLException {

		SalaryCertificate empDetails = null;

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM FJPORTAL.EMPDET_AKM_NEW WHERE EMPLOYEE_CODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			// myStmt.setString(2, fpmonth);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String emp_comp_code = myRes.getString(1);
				String division = myRes.getString(2);
				String department = myRes.getString(3);
				String job_location = myRes.getString(4);
				// String status = myRes.getString(5);

				// String emp_type = myRes.getString(7);
				String emp_code = myRes.getString(9);
				String name = myRes.getString(10);
				String designation = myRes.getString(12);
				// String birth_dt = myRes.getString(13);
				// String age = myRes.getString(14);
				String gender = myRes.getString(15);
				String nationality = myRes.getString(16);
				// String grade = myRes.getString(18);
				String currency = myRes.getString(19);
				String basic_amt = myRes.getString(20);
				String allow_amt = myRes.getString(21);
				String tot_sal = myRes.getString(22);
				String passport_Number = myRes.getString(26);
				// String passport_Expiry_Date = myRes.getString(27);
				// String EID_Number = myRes.getString(30);
				// String EID_Expiry_Date = myRes.getString(31);
				String join_date = myRes.getString(32);
				String emp_end_of_service_dt = myRes.getString(33);
				// String tenure = myRes.getString(34);
				// String email = myRes.getString(35);
				// String office_Mobile_Number = myRes.getString(36);
				String cost_center = myRes.getString(55);
				String company_name = myRes.getString(56);
				String cc_code = myRes.getString(57);
				empDetails = new SalaryCertificate(emp_comp_code, division, department, emp_code, name, designation,
						nationality, basic_amt, allow_amt, tot_sal, passport_Number, join_date, currency, cost_center,
						gender, company_name, emp_end_of_service_dt, job_location, cc_code);

			}
			return empDetails;
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
