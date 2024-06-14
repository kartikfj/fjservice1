package beans;

public class HrDashbaord {
private String empCode = null; 
private String empName = null;
private String company = null;
private String division = null;
private String joiningDate = null;
private String jobTitle = null;
private String manager = null; 
 

 
 
public String getEmpName() {
	return empName;
}
public void setEmpName(String empName) {
	this.empName = empName;
}
public String getCompany() {
	return company;
}
public void setCompany(String company) {
	this.company = company;
}
public String getDivision() {
	return division;
}
public void setDivision(String division) {
	this.division = division;
}
public String getJoiningDate() {
	return joiningDate;
}
public void setJoiningDate(String joiningDate) {
	this.joiningDate = joiningDate;
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
public String getEmpCode() {
	return empCode;
}
public void setEmpCode(String empCode) {
	this.empCode = empCode;
} 
public HrDashbaord(String empCode, String empName, String company, String division, String joiningDate, String jobTitle,
		String manager) {
	// user profile
	super();
	this.empCode = empCode;
	this.empName = empName;
	this.company = company;
	this.division = division;
	this.joiningDate = joiningDate;
	this.jobTitle = jobTitle;
	this.manager = manager;
}


}
