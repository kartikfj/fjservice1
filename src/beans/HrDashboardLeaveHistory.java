package beans;

public class HrDashboardLeaveHistory {
	private String empCode = null;
	private String  leave = null; 
	private String fromDate = null;
	private String  toDate = null;
	private float leaveDays = 0;

	  
 
	public float getLeaveDays() {
		return leaveDays;
	}
	public void setLeaveDays(float leaveDays) {
		this.leaveDays = leaveDays;
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
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getLeave() {
		return leave;
	}
	public void setLeave(String leave) {
		this.leave = leave;
	}   
	public HrDashboardLeaveHistory(String empCode, String leave, String fromDate, String toDate, float leaveDays) {
		// employee leave history
		super();
		this.empCode = empCode;
		this.leave = leave;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.leaveDays = leaveDays;
	}
	 

}
