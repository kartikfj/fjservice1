package beans;

public class HrEvaluationUserProfile {
private String empCode = null;
private String empName = null;
private String joiningDate = null;
private String division = null;
private String jobTitle = null;
private String manager = null;
private String managerCode = null;

public String getEmpCode() {
	return empCode;
}
public void setEmpCode(String empCode) {
	this.empCode = empCode;
}
public String getEmpName() {
	return empName;
}
public void setEmpName(String empName) {
	this.empName = empName;
}
public String getJoiningDate() {
	return joiningDate;
}
public void setJoiningDate(String joiningDate) {
	this.joiningDate = joiningDate;
}
public String getDivision() {
	return division;
}
public void setDivision(String division) {
	this.division = division;
}
public String getJobTitle() {
	return jobTitle;
}
public void setJobTitle(String jobTitle) {
	this.jobTitle = jobTitle;
}
public String getManager() {
	return manager;
}
public void setManager(String manager) {
	this.manager = manager;
}

public String getManagerCode() {
	return managerCode;
}
public void setManagerCode(String managerCode) {
	this.managerCode = managerCode;
}
public HrEvaluationUserProfile(String empCode, String empName) {
	super();
	this.empCode = empCode;
	this.empName = empName;
}
public HrEvaluationUserProfile(String empCode, String empName, String joiningDate, String division, String jobTitle,
		String manager, String managerCode) {
	super();
	this.empCode = empCode;
	this.empName = empName;
	this.joiningDate = joiningDate;
	this.division = division;
	this.jobTitle = jobTitle;
	this.manager = manager;
	this.managerCode = managerCode;
}


}
