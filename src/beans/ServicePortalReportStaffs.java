package beans;

public class ServicePortalReportStaffs {
	private String fldStaffCode = null;
	private String fldStaffName = null;
	private String division =  null;
	
	
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


	public String getDivision() {
		return division;
	}


	public void setDivision(String division) {
		this.division = division;
	}


	public ServicePortalReportStaffs(String fldStaffCode, String fldStaffName, String division) {
		super();
		this.fldStaffCode = fldStaffCode;
		this.fldStaffName = fldStaffName;
		this.division = division;
	}


	public ServicePortalReportStaffs(String division) {
		super();
		this.division = division;
	}
	
}
