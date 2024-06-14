package beans;

public class SipDivisionOutstandingRecivablesDtls {

	private String d1 = null;// invoiceNo
	private String d2 = null;// invoiceDate
	private String d3 = null;// customerCode
	private String d4 = null;// customerName
	private String d5 = null; // prjctName
	private String d6 = null;// consultant
	private String d7 = null;// aging_value
	private String d8 = null;// sales eng name

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

	public String getD7() {
		return d7;
	}

	public void setD7(String d7) {
		this.d7 = d7;
	}

	public String getD8() {
		return d8;
	}

	public void setD8(String d8) {
		this.d8 = d8;
	}

	public SipDivisionOutstandingRecivablesDtls(String d1, String d2, String d3, String d4, String d5, String d6,
			String d7) {
		// this for handling sales engineer wise oustanding recivable details aging wise
		super();
		this.d1 = d1;
		this.d2 = d2;
		this.d3 = d3;
		this.d4 = d4;
		this.d5 = d5;
		this.d6 = d6;
		this.d7 = d7;
	}

	public SipDivisionOutstandingRecivablesDtls(String d1, String d2, String d3, String d4, String d5, String d6,
			String d8, String d7) {

		// this for handling sub division wise oustanding recivable details aging wise
		super();
		this.d1 = d1;
		this.d2 = d2;
		this.d3 = d3;
		this.d4 = d4;
		this.d5 = d5;
		this.d6 = d6;
		this.d8 = d8;
		this.d7 = d7;
	}

}