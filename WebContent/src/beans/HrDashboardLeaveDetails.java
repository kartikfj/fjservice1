package beans;

public class HrDashboardLeaveDetails {
	private String empCode = null;
	private String  leave = null;
	private int  year = 0;
	private float accruedleaveDays  = 0;
	private float availedLeaveDays  = 0;
	private float balanceDays  = 0; 	
	 
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
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public float getAccruedleaveDays() {
		return accruedleaveDays;
	}
	public void setAccruedleaveDays(float accruedleaveDays) {
		this.accruedleaveDays = accruedleaveDays;
	}
	public float getAvailedLeaveDays() {
		return availedLeaveDays;
	}
	public void setAvailedLeaveDays(float availedLeaveDays) {
		this.availedLeaveDays = availedLeaveDays;
	}
	public float getBalanceDays() {
		return balanceDays;
	}
	public void setBalanceDays(float balanceDays) {
		this.balanceDays = balanceDays;
	}
	public HrDashboardLeaveDetails(String empCode, String leave, int year, float accruedleaveDays, float availedLeaveDays,
			float balanceDays) {
		// employee leave details
		super();
		this.empCode = empCode;
		this.leave = leave;
		this.year = year;
		this.accruedleaveDays = accruedleaveDays;
		this.availedLeaveDays = availedLeaveDays;
		this.balanceDays = balanceDays;
	} 

}
