package beans;

public class Regularise_Report {

	private String uid = null;
	private String applied_dt = null;
	private String dt_to_regul = null;
	private String reason = null;
	private String authorized = null;
	private String status = null;
	private String authorized_dt = null;
	private String company = null;
	private String project = null;
	private String empName = null;

	// for suresh account
	private String sc_type = null;
	private String sc_leave_toDate = null;
	private String sc_leave_fromDate = null;
	private String sc_leave_days = null;

	private String country = null;
	private String purpose = null;
	private String otherdetails = null;

	public String getSc_leave_days() {
		return sc_leave_days;
	}

	public void setSc_leave_days(String sc_leave_days) {
		this.sc_leave_days = sc_leave_days;
	}

	public String getSc_type() {
		return sc_type;
	}

	public void setSc_type(String sc_type) {
		this.sc_type = sc_type;
	}

	public String getSc_leave_toDate() {
		return sc_leave_toDate;
	}

	public void setSc_leave_toDate(String sc_leave_toDate) {
		this.sc_leave_toDate = sc_leave_toDate;
	}

	public String getSc_leave_fromDate() {
		return sc_leave_fromDate;
	}

	public void setSc_leave_fromDate(String sc_leave_fromDate) {
		this.sc_leave_fromDate = sc_leave_fromDate;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getApplied_dt() {
		return applied_dt;
	}

	public void setApplied_dt(String applied_dt) {
		this.applied_dt = applied_dt;
	}

	public String getDt_to_regul() {
		return dt_to_regul;
	}

	public void setDt_to_regul(String dt_to_regul) {
		this.dt_to_regul = dt_to_regul;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getAuthorized() {
		return authorized;
	}

	public void setAuthorized(String authorized) {
		this.authorized = authorized;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAuthorized_dt() {
		return authorized_dt;
	}

	public void setAuthorized_dt(String authorized_dt) {
		this.authorized_dt = authorized_dt;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getOtherdetails() {
		return otherdetails;
	}

	public void setOtherdetails(String otherdetails) {
		this.otherdetails = otherdetails;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public Regularise_Report(String uid, String applied_dt, String dt_to_regul, String reason, String authorized,
			String status, String authorized_dt, String company, String project) {
		super();
		this.uid = uid;
		this.applied_dt = applied_dt;
		this.dt_to_regul = dt_to_regul;
		this.reason = reason;
		this.authorized = authorized;
		this.status = status;
		this.authorized_dt = authorized_dt;
		this.company = company;
		this.project = project;
	}

	public Regularise_Report(String uid, String applied_dt, String dt_to_regul, String reason, String authorized,
			String status, String authorized_dt, String company, String project, String empName) {
		super();
		this.uid = uid;
		this.applied_dt = applied_dt;
		this.dt_to_regul = dt_to_regul;
		this.reason = reason;
		this.authorized = authorized;
		this.status = status;
		this.authorized_dt = authorized_dt;
		this.company = company;
		this.project = project;
		this.empName = empName;
	}

	public Regularise_Report(String uid, String sc_type, String applied_dt, String sc_leave_fromDate,
			String sc_leave_toDate, String reason, String sc_leave_days) {
		// leave report for suresh account
		super();
		this.uid = uid;
		this.sc_type = sc_type;
		this.applied_dt = applied_dt;
		this.sc_leave_fromDate = sc_leave_fromDate;
		this.sc_leave_toDate = sc_leave_toDate;
		this.reason = reason;
		this.sc_leave_days = sc_leave_days;
	}

	public Regularise_Report(String uid, String fromDate, String toDate, String country, String projectDetails,
			String purpose, String otherdetails, String empty) {
		// leave report for suresh account
		super();
		this.uid = uid;
		this.country = country;
		this.project = projectDetails;
		this.sc_leave_fromDate = fromDate;
		this.sc_leave_toDate = toDate;
		this.purpose = purpose;
		this.otherdetails = otherdetails;
	}

}
