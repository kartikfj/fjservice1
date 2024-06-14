package beans;

public class SalaryCertificate {
	private String emp_comp_code = null;
	private String emp_code = null;
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

	public SalaryCertificate() {

	}

	public String getEmp_comp_code() {
		return emp_comp_code;
	}

	public void setEmp_comp_code(String emp_comp_code) {
		this.emp_comp_code = emp_comp_code;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
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

	public SalaryCertificate(String emp_comp_code, String division, String department, String emp_code, String name,
			String designation, String nationality, String basic_amt, String allow_amt, String tot_sal,
			String passport_Number, String join_date, String currency, String cost_center, String gender,
			String company_name, String emp_end_of_service_dt, String job_location, String cc_code) {
		super();
		this.emp_comp_code = emp_comp_code;
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
		this.jobLocation = job_location;
		this.cc_code = cc_code;
	}

	public SalaryCertificate(String emp_comp_code, String emp_code, String name,String division,String designation) {
		super();
		this.emp_comp_code = emp_comp_code;
		this.emp_code = emp_code;
		this.name = name;
		this.division = division;
		this.designation = designation;
	}
}
