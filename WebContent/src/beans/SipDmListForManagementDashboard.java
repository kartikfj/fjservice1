package beans;

public class SipDmListForManagementDashboard {
	private String dmEmp_Code = null;
	private String dmEmp_name = null;

	public SipDmListForManagementDashboard(String dmEmp_Code, String dmEmp_name) {
		super();
		this.setDmEmp_Code(dmEmp_Code);
		this.setDmEmp_name(dmEmp_name);
	}

	public String getDmEmp_Code() {
		return dmEmp_Code;
	}

	public void setDmEmp_Code(String dmEmp_Code) {
		this.dmEmp_Code = dmEmp_Code;
	}

	public String getDmEmp_name() {
		return dmEmp_name;
	}

	public void setDmEmp_name(String dmEmp_name) {
		this.dmEmp_name = dmEmp_name;
	}

}
