package beans;

public class SipDivJihvSummary {

	private String div_code = null;
	private String div_desc = null;

	private String division = null;
	private String aging1 = null;// 0-3 month
	private String aging2 = null;// 3-6 month
	private String aging3 = null;// >6Mths

	public String getDiv_code() {
		return div_code;
	}

	public void setDiv_code(String div_code) {
		this.div_code = div_code;
	}

	public String getDiv_desc() {
		return div_desc;
	}

	public void setDiv_desc(String div_desc) {
		this.div_desc = div_desc;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getAging1() {
		return aging1;
	}

	public void setAging1(String aging1) {
		this.aging1 = aging1;
	}

	public String getAging2() {
		return aging2;
	}

	public void setAging2(String aging2) {
		this.aging2 = aging2;
	}

	public String getAging3() {
		return aging3;
	}

	public void setAging3(String aging3) {
		this.aging3 = aging3;
	}

	public SipDivJihvSummary(String division, String aging1, String aging2, String aging3) {
		super();
		this.division = division;

		this.aging1 = aging1;
		this.aging2 = aging2;
		this.aging3 = aging3;
	}

	// retrieving division details under division manager
	public SipDivJihvSummary(String div_code, String div_desc) {
		super();
		this.div_code = div_code;
		this.div_desc = div_desc;
	}

}
