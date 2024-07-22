package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ExperienceCertificate {

	private String emp_code;
	private String emp_com_code = null;
	private String name = null;
	private String division = null;
	private String department = null;
	private String designation = null;
	private String nationality = null;
	private String join_date = null;
	private String basic_amt = null;
	private String allow_amt = null;
	private String tot_sal = null;
	private String emp_id = null;
	private String passport_Number = null;
	private String currency = null;
	private String cost_center = null;
	private String gender = null;
	private String company_name = null;
	private String emp_end_of_service_dt = null;
	private String jobLocation = null;
	private String cc_code = null;

	public String getEmp_com_code() {
		return emp_com_code;
	}

	public void setEmp_com_code(String emp_comp_code) {
		this.emp_com_code = emp_comp_code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getBasic_amt() {
		return basic_amt;
	}

	public void setBasic_amt(String basic_amt) {
		this.basic_amt = basic_amt;
	}

	public String getAllow_amt() {
		return allow_amt;
	}

	public void setAllow_amt(String allow_amt) {
		this.allow_amt = allow_amt;
	}

	public String getTot_sal() {
		return tot_sal;
	}

	public void setTot_sal(String tot_sal) {
		this.tot_sal = tot_sal;
	}

	public String getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}

	public String getPassport_Number() {
		return passport_Number;
	}

	public void setPassport_Number(String passport_Number) {
		this.passport_Number = passport_Number;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getCost_center() {
		return cost_center;
	}

	public void setCost_center(String cost_center) {
		this.cost_center = cost_center;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getEmp_end_of_service_dt() {
		return emp_end_of_service_dt;
	}

	public void setEmp_end_of_service_dt(String emp_end_of_service_dt) {
		this.emp_end_of_service_dt = emp_end_of_service_dt;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public String getJobLocation() {
		return jobLocation;
	}

	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}

	public String getCc_code() {
		return cc_code;
	}

	public void setCc_code(String cc_code) {
		this.cc_code = cc_code;
	}

	public ExperienceCertificate() {
	}

	public ExperienceCertificate(String emp_comp_code, String division, String department, String emp_code, String name,
			String designation, String nationality, String basic_amt, String allow_amt, String tot_sal,
			String passport_Number, String join_date, String currency, String cost_center, String gender,
			String company_name, String emp_end_of_service_dt, String jobLocation, String cc_code) {
		super();
		this.emp_com_code = emp_comp_code;
		this.emp_code = emp_code;
		this.name = name;
		this.division = division;
		this.department = department;
		this.designation = designation;
		this.nationality = nationality;
		this.join_date = join_date;
		this.basic_amt = basic_amt;
		this.allow_amt = allow_amt;
		this.tot_sal = tot_sal;
		this.passport_Number = passport_Number;
		this.currency = currency;
		this.cost_center = cost_center;
		this.gender = gender;
		this.company_name = company_name;
		this.emp_end_of_service_dt = emp_end_of_service_dt;
		this.jobLocation = jobLocation;
		this.cc_code = cc_code;
	}

	public ExperienceCertificate getSalaryCertificateData() throws SQLException {
		ExperienceCertificate empDetails = null;
		int logType = -1;
		logType = isNotFrozenAccount();
		if (logType == 1) {
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				String sql = " SELECT * FROM FJPORTAL.EMPDET_AKM_NEW WHERE EMPLOYEE_CODE = ? AND EMP_COMP_CODE NOT IN  ('KSA','KSAIND','FJQ','FIQ','RKIPL','IRQ','OMN','OMNFJ')";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, this.emp_code);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					String emp_comp_code = myRes.getString(1);
					String division = myRes.getString(2);
					String department = myRes.getString(3);
					String jobLocation = myRes.getString(4);
					String emp_code = myRes.getString(9);
					String name = myRes.getString(10);
					String designation = myRes.getString(12);
					String gender = myRes.getString(15);
					String nationality = myRes.getString(16);
					String currency = myRes.getString(19);
					String basic_amt = myRes.getString(20);
					String allow_amt = myRes.getString(21);
					String tot_sal = myRes.getString(22);
					String passport_Number = myRes.getString(26);
					String join_date = myRes.getString(32);
					String emp_end_of_service_dt = myRes.getString(33);
					String cost_center = myRes.getString(55);
					String company_name = myRes.getString(56);
					String cc_code = myRes.getString(57);
					empDetails = new ExperienceCertificate(emp_comp_code, division, department, emp_code, name,
							designation, nationality, basic_amt, allow_amt, tot_sal, passport_Number, join_date,
							currency, cost_center, gender, company_name, emp_end_of_service_dt, jobLocation, cc_code);
				}
			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
		}
		return empDetails;
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

	public int isNotFrozenAccount() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = -1;
		// String sqlstr = "SELECT EMP_COMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE
		// =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		String sqlstr = "SELECT EMP_COMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.emp_com_code = rs.getString(1);
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

}
