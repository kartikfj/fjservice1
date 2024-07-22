package beans;

public class SipLCSignaturePending {

	private String d1 = null; // =null;//customer_code
	private String d2 = null; // customer_name
	private String d3 = null; // drcr
	private String d4 = null; // signature pending value

	public String getD1() {
		return d1;
	}

	public void setD1(String d1) {
		this.d1 = d1;
	}

	public String getD2() {
		return d2;
	}

	public void setD2(String d2) {
		this.d2 = d2;
	}

	public String getD3() {
		return d3;
	}

	public void setD3(String d3) {
		this.d3 = d3;
	}

	public String getD4() {
		return d4;
	}

	public void setD4(String d4) {
		this.d4 = d4;
	}

	public SipLCSignaturePending(String d1, String d2, String d3, String d4) {
		super();
		this.d1 = d1;
		this.d2 = d2;
		this.d3 = d3;
		this.d4 = d4;
	}

}
