package beans;

public class ServiceReport {
private String type = null;
private int totalServiceCalls = 0;
private int totalVisits = 0;
private int totalManPwr = 0;
private double totalServiceHrs = 0;
private double totalCost = 0;
private double totalOtherExp = 0 ;
private String holiday = null;

private String startDate = null;
private String toDate = null;
private String fieldStaffList = null;
private int fldStaffCount = 0;
String division = null;
public int getFldStaffCount() {
	return fldStaffCount;
}
public void setFldStaffCount(int fldStaffCount) {
	this.fldStaffCount = fldStaffCount;
}
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}
public int getTotalServiceCalls() {
	return totalServiceCalls;
}
public void setTotalServiceCalls(int totalServiceCalls) {
	this.totalServiceCalls = totalServiceCalls;
}
public int getTotalVisits() {
	return totalVisits;
}
public void setTotalVisits(int totalVisits) {
	this.totalVisits = totalVisits;
}
public int getTotalManPwr() {
	return totalManPwr;
}
public void setTotalManPwr(int totalManPwr) {
	this.totalManPwr = totalManPwr;
}
public double getTotalServiceHrs() {
	return totalServiceHrs;
}
public void setTotalServiceHrs(double totalServiceHrs) {
	this.totalServiceHrs = totalServiceHrs;
}
public double getTotalCost() {
	return totalCost;
}
public void setTotalCost(double totalCost) {
	this.totalCost = totalCost;
}
 
public String getToDate() {
	return toDate;
}
public void setToDate(String toDate) {
	this.toDate = toDate;
}
public String getStartDate() {
	return startDate;
}
public void setStartDate(String startDate) {
	this.startDate = startDate;
}

public double getTotalOtherExp() {
	return totalOtherExp;
}
public void setTotalOtherExp(double totalOtherExp) {
	this.totalOtherExp = totalOtherExp;
}


public String getFieldStaffList() {
	return fieldStaffList;
}
public void setFieldStaffList(String fieldStaffList) {
	this.fieldStaffList = fieldStaffList;
}

public String getDivision() {
	return division;
}
public void setDivision(String division) {
	this.division = division;
}
public ServiceReport(String type, int totalServiceCalls, int totalVisits, int totalManPwr, double totalServiceHrs,
		double totalCost, double totalOtherExp) {
	super();
	this.type = type;
	this.totalServiceCalls = totalServiceCalls;
	this.totalVisits = totalVisits;
	this.totalManPwr = totalManPwr;
	this.totalServiceHrs = totalServiceHrs;
	this.totalCost = totalCost;
	this.totalOtherExp = totalOtherExp;
}
public ServiceReport(String startDate, String toDate, String fieldStaffList, int fldStaffCount) {
	super();
	this.startDate = startDate;
	this.toDate = toDate;
	this.fieldStaffList = fieldStaffList;
	this.fldStaffCount = fldStaffCount;
}
public ServiceReport(String holiday) {
	super(); 
	this.holiday = holiday;
}
public String getHoliday() {
	return holiday;
}
public void setHoliday(String holiday) {
	this.holiday = holiday;
}
public ServiceReport(String startDate, String toDate, String fieldStaffList, int fldStaffCount, String division) {
	super();
	this.startDate = startDate;
	this.toDate = toDate;
	this.fieldStaffList = fieldStaffList;
	this.fldStaffCount = fldStaffCount;
	this.division = division;
}
}
