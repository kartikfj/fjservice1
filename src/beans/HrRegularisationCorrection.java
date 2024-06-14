package beans;

public class HrRegularisationCorrection {
private String employeeCode = null;
private String employeeName = null;
private String approverCode = null;
private String approverName = null;
private String dateToRegularise = null;
private String reason = null;
private String appliedDate = null;
private String appliedBy = null;
private String companyCode = null;
private String accessCrd = null;

private int optnStatus = 0;
private String optnMessage =  null;


public String getEmployeeCode() {
	return employeeCode;
}
public void setEmployeeCode(String employeeCode) {
	this.employeeCode = employeeCode;
}
public String getEmployeeName() {
	return employeeName;
}
public void setEmployeeName(String employeeName) {
	this.employeeName = employeeName;
}
public String getApproverCode() {
	return approverCode;
}
public void setApproverCode(String approverCode) {
	this.approverCode = approverCode;
}
public String getApproverName() {
	return approverName;
}
public void setApproverName(String approverName) {
	this.approverName = approverName;
}
public String getDateToRegularise() {
	return dateToRegularise;
}
public void setDateToRegularise(String dateToRegularise) {
	this.dateToRegularise = dateToRegularise;
}
public String getReason() {
	return reason;
}
public void setReason(String reason) {
	this.reason = reason;
}
public String getAppliedDate() {
	return appliedDate;
}
public void setAppliedDate(String appliedDate) {
	this.appliedDate = appliedDate;
}
public String getAppliedBy() {
	return appliedBy;
}
public void setAppliedBy(String appliedBy) {
	this.appliedBy = appliedBy;
}


public String getCompanyCode() {
	return companyCode;
}
public void setCompanyCode(String companyCode) {
	this.companyCode = companyCode;
}



public String getAccessCrd() {
	return accessCrd;
}
public void setAccessCrd(String accessCrd) {
	this.accessCrd = accessCrd;
}
public int getOptnStatus() {
	return optnStatus;
}
public void setOptnStatus(int optnStatus) {
	this.optnStatus = optnStatus;
}
public String getOptnMessage() {
	return optnMessage;
}
public void setOptnMessage(String optnMessage) {
	this.optnMessage = optnMessage;
}
public HrRegularisationCorrection(String employeeCode, String employeeName, String approverCode, String approverName, String companyCode, String accessCrd) {
	super();
	// employee and approver details
	this.employeeCode = employeeCode;
	this.employeeName = employeeName;
	this.approverCode = approverCode;
	this.approverName = approverName;
	this.companyCode = companyCode;
	this.accessCrd = accessCrd;
}
public HrRegularisationCorrection(String employeeCode, String employeeName, String approverCode, String approverName,
		String dateToRegularise, String reason,  String appliedBy, String companyCode, String accessCrd) {
	super();
	this.employeeCode = employeeCode;
	this.employeeName = employeeName;
	this.approverCode = approverCode;
	this.approverName = approverName;
	this.dateToRegularise = dateToRegularise;
	this.reason = reason; 
	this.appliedBy = appliedBy;
	this.companyCode = companyCode;
	this.accessCrd = accessCrd;
}
 
public HrRegularisationCorrection(String dateToRegularise, String reason, String employeeCode, String employeeName, String approverCode, String approverName, String companyCode, String accessCrd,  String appliedDate, String appliedBy, int optnStatus,
		String optnMessage) {
	super(); 
	this.employeeCode = employeeCode;
	this.employeeName = employeeName;
	this.approverCode = approverCode;
	this.approverName = approverName;
	this.companyCode = companyCode;
	this.accessCrd = accessCrd;
	this.appliedDate = appliedDate;
	this.appliedBy = appliedBy;
	this.optnStatus = optnStatus;
	this.optnMessage = optnMessage;
	this.dateToRegularise = dateToRegularise;
	this.reason = reason;
	
}
 
}
