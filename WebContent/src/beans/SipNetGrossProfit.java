package beans;

public class SipNetGrossProfit {
	private String year = null;
	private String acnt_type = null;
	private String target = null;
	private String actual = null;

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getAcnt_type() {
		return acnt_type;
	}

	public void setAcnt_type(String acnt_type) {
		this.acnt_type = acnt_type;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getActual() {
		return actual;
	}

	public void setActual(String actual) {
		this.actual = actual;
	}

	public SipNetGrossProfit(String year, String acnt_type, String target, String actual) {
		super();
		this.year = year;
		this.acnt_type = acnt_type;
		this.target = target;
		this.actual = actual;
	}

	public SipNetGrossProfit(String year, String target, String actual) {
		super();
		this.year = year;
		this.target = target;
		this.actual = actual;
	}

}
