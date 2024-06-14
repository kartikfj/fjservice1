package beans;

public class AppraisalUserProfile {

	private String emp_com_code = null;
	private String emp_code = null;
	private String uname = null;
	private String job_desc = null;
	private String emp_div = null;
	private String emp_dept = null;
	private String emp_location = null;

	public String getEmp_com_code() {
		return emp_com_code;
	}

	public void setEmp_com_code(String emp_com_code) {
		this.emp_com_code = emp_com_code;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getJob_desc() {
		return job_desc;
	}

	public void setJob_desc(String job_desc) {
		this.job_desc = job_desc;
	}

	public String getEmp_div() {
		return emp_div;
	}

	public void setEmp_div(String emp_div) {
		this.emp_div = emp_div;
	}

	public String getEmp_dept() {
		return emp_dept;
	}

	public void setEmp_dept(String emp_dept) {
		this.emp_dept = emp_dept;
	}

	public String getEmp_location() {
		return emp_location;
	}

	public void setEmp_location(String emp_location) {
		this.emp_location = emp_location;
	}

	public AppraisalUserProfile(String emp_com_code, String emp_code, String uname, String job_desc, String emp_div,
			String emp_dept, String emp_location) {
		super();
		this.emp_com_code = emp_com_code;
		this.emp_code = emp_code;
		this.uname = uname;
		this.job_desc = job_desc;
		this.emp_div = emp_div;
		this.emp_dept = emp_dept;
		this.emp_location = emp_location;
	}

}
