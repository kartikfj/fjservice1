package beans;

public class ServicePortalStaffs {
private String fldStaffCode = null;
private String fldStaffName = null;
private int hourlyRate = 0;
private String chkIn = null;
private String chkOut = null;
private int ttim = 0;// total time in mutes
 
private String visitDate = null;
private long visitDtlsId = 0;
private int visitOptnFlag = 0; 
 
public String getVisitDate() {
	return visitDate;
}
public void setVisitDate(String visitDate) {
	this.visitDate = visitDate;
}
public long getVisitDtlsId() {
	return visitDtlsId;
}
public void setVisitDtlsId(long visitDtlsId) {
	this.visitDtlsId = visitDtlsId;
}
public int getVisitOptnFlag() {
	return visitOptnFlag;
}
public void setVisitOptnFlag(int visitOptnFlag) {
	this.visitOptnFlag = visitOptnFlag;
}
public int getTtim() {
	return ttim;
}
public void setTtim(int ttim) {
	this.ttim = ttim;
}
public String getFldStaffCode() {
	return fldStaffCode;
}
public void setFldStaffCode(String fldStaffCode) {
	this.fldStaffCode = fldStaffCode;
}
public String getFldStaffName() {
	return fldStaffName;
}
public void setFldStaffName(String fldStaffName) {
	this.fldStaffName = fldStaffName;
}
public ServicePortalStaffs(String fldStaffCode) {
	this.fldStaffCode = fldStaffCode; 
}


public String getChkIn() {
	return chkIn;
}
public void setChkIn(String chkIn) {
	this.chkIn = chkIn;
}
public String getChkOut() {
	return chkOut;
}
public void setChkOut(String chkOut) {
	this.chkOut = chkOut;
}
public int getHourlyRate() {
	return hourlyRate;
}
public void setHourlyRate(int hourlyRate) {
	this.hourlyRate = hourlyRate;
}
public ServicePortalStaffs(String fldStaffCode, String fldStaffName) {
	this.fldStaffCode = fldStaffCode;
	this.fldStaffName = fldStaffName;
}
public ServicePortalStaffs(String fldStaffCode, String fldStaffName, int hourlyRate) {
	this.fldStaffCode = fldStaffCode;
	this.fldStaffName = fldStaffName;
	this.hourlyRate =  hourlyRate;
} 
public ServicePortalStaffs(String fldStaffCode, String chkIn, String chkOut, int ttim, int hourlyRate) {
	super(); 
	this.fldStaffCode = fldStaffCode;
	this.chkIn = chkIn;
	this.chkOut =  chkOut;
	this.ttim = ttim;
	this.hourlyRate = hourlyRate;
}
public ServicePortalStaffs(String fldStaffCode,String visitDate, String chkIn, String chkOut, int ttim, int hourlyRate) {
	super(); 
	this.fldStaffCode = fldStaffCode;
	this.visitDate = visitDate;
	this.chkIn = chkIn;
	this.chkOut =  chkOut;
	this.ttim = ttim;
	this.hourlyRate = hourlyRate;
}
public ServicePortalStaffs(String fldStaffCode,String visitDate, String chkIn, String chkOut, int ttim, int hourlyRate, String fldStaffName) {
	super(); 
	this.fldStaffCode = fldStaffCode;
	this.visitDate = visitDate;
	this.chkIn = chkIn;
	this.chkOut =  chkOut;
	this.ttim = ttim;
	this.hourlyRate = hourlyRate;
	this.fldStaffName = fldStaffName;
}
public ServicePortalStaffs(long visitDtlsId, int visitOptnFlag) {
	super();
	this.visitDtlsId = visitDtlsId;
	this.visitOptnFlag = visitOptnFlag;
}

 
}


