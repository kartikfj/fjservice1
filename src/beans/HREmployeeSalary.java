package beans;

public class HREmployeeSalary {
private String empCode = null;
private String fromDate = null;
private String  toDate = null;
private String allowance = null;
private String currency = null;
private String  orgAmount =null; 
private String  adjAmount = null;
private String  finalAmount = null;


public String getEmpCode() {
	return empCode;
}


public String getFromDate() {
	return fromDate;
}


public void setFromDate(String fromDate) {
	this.fromDate = fromDate;
}


public String getToDate() {
	return toDate;
}


public void setToDate(String toDate) {
	this.toDate = toDate;
}


public void setEmpCode(String empCode) {
	this.empCode = empCode;
}


public String getAllowance() {
	return allowance;
}


public void setAllowance(String allowance) {
	this.allowance = allowance;
}


public String getCurrency() {
	return currency;
}


public void setCurrency(String currency) {
	this.currency = currency;
}


public String getOrgAmount() {
	return orgAmount;
}


public void setOrgAmount(String orgAmount) {
	this.orgAmount = orgAmount;
}


public String getAdjAmount() {
	return adjAmount;
}


public void setAdjAmount(String adjAmount) {
	this.adjAmount = adjAmount;
}


public String getFinalAmount() {
	return finalAmount;
}


public void setFinalAmount(String finalAmount) {
	this.finalAmount = finalAmount;
}


	public HREmployeeSalary(String empCode, String fromDate, String toDate, String allowance, String currency, String orgAmount,
			String adjAmount, String finalAmount) {
		// employee salary
		super();
		this.empCode = empCode;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.allowance = allowance;
		this.currency = currency;
		this.orgAmount = orgAmount;
		this.adjAmount = adjAmount;
		this.finalAmount = finalAmount;
	}

}
