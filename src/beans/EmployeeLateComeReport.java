package beans;

public class EmployeeLateComeReport {
	private String accssNo = null;
	private String count = null;
	private String empCode = null;
	private String empname = null;
	private String designation = null;
	private String company = null;
	private String division = null;
	private String frzLog = null;

	public String getAccssNo() {
		return accssNo;
	}

	public void setAccssNo(String accssNo) {
		this.accssNo = accssNo;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getEmpname() {
		return empname;
	}

	public void setEmpname(String empname) {
		this.empname = empname;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getFrzLog() {
		return frzLog;
	}

	public void setFrzLog(String frzLog) {
		this.frzLog = frzLog;
	}

	public EmployeeLateComeReport(String empCode, String count, String accssNo, String empname, String designation,
			String company, String division, String frzLog) {
		super();
		this.empCode = empCode;
		this.count = count;
		this.accssNo = accssNo;
		this.empname = empname;
		this.designation = designation;
		this.company = company;
		this.division = division;
		this.frzLog = frzLog;
	}

}
