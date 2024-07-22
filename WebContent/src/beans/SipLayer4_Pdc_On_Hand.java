package beans;

public class SipLayer4_Pdc_On_Hand {
	// ------PDC's On Hand----------------------------//

	private String d1 = null;// pdc due date
	private String d2 = null;// pdc check number
	private String d3 = null;// Bank
	private String d4 = null;// Currency
	private String d5 = null;// Amount
	private String d6 = null;// Amount(AED)

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

	public String getD5() {
		return d5;
	}

	public void setD5(String d5) {
		this.d5 = d5;
	}

	public String getD6() {
		return d6;
	}

	public void setD6(String d6) {
		this.d6 = d6;
	}

	public SipLayer4_Pdc_On_Hand(String d1, String d2, String d3, String d4, String d5, String d6) {
		super();
		this.d1 = d1;
		this.d2 = d2;
		this.d3 = d3;
		this.d4 = d4;
		this.d5 = d5;
		this.d6 = d6;
	}

}
