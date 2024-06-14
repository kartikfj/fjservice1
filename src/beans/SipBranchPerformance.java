package beans;

public class SipBranchPerformance {
private String salesCode = null;
private String companyCode = null;
private String activeYN = null;


public String getSalesCode() {
	return salesCode;
}

public void setSalesCode(String salesCode) {
	this.salesCode = salesCode;
}

public SipBranchPerformance(String salesCode) {
	super();
	this.salesCode = salesCode;
}

public String getCompanyCode() {
	return companyCode;
}

public void setCompanyCode(String companyCode) {
	this.companyCode = companyCode;
}

 
public String getActiveYN() {
	return activeYN;
}

public void setActiveYN(String activeYN) {
	this.activeYN = activeYN;
}

public SipBranchPerformance(String companyCode, String activeYN) {
	super();
	this.companyCode = companyCode;
	this.activeYN = activeYN;
}



}
