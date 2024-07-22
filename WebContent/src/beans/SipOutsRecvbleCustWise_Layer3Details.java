package beans;

import java.util.ArrayList;
import java.util.List;

public class SipOutsRecvbleCustWise_Layer3Details {

	private String d1 = null;// company code or Entity
	private String d2 = null;// customer code
	private String d3 = null;// doc date
	private String d4 = null;// doc number
	private String d5 = null;// division
	private String d6 = null;// Sales Engineer
	private String d7 = null;// LPO NUMBER
	private String d8 = null;// Project
	private String d9 = null;// payment terms
	private String d10 = null;// currency
	private String d11 = null;// Balance amount
	private String d12 = null;// on Account

	public String d13 = null;// Net Balance amount
	public String d14 = null;// net on Account
	public String d15 = null;// net total

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

	public String getD9() {
		return d9;
	}

	public void setD9(String d9) {
		this.d9 = d9;
	}

	public String getD10() {
		return d10;
	}

	public void setD10(String d10) {
		this.d10 = d10;
	}

	public String getD11() {
		return d11;
	}

	public void setD11(String d11) {
		this.d11 = d11;
	}

	public String getD12() {
		return d12;
	}

	public void setD12(String d12) {
		this.d12 = d12;
	}

	public String getD13() {
		return d13;
	}

	public void setD13(String d13) {
		this.d13 = d13;
	}

	public String getD14() {
		return d14;
	}

	public void setD14(String d14) {
		this.d14 = d14;
	}

	public String getD15() {
		return d15;
	}

	public void setD15(String d15) {
		this.d15 = d15;
	}

	public SipOutsRecvbleCustWise_Layer3Details(String d1, String d2, String d3, String d4, String d5, String d6,
			String d7, String d8, String d9, String d10, String d11, String d12) {
		super();
		this.d1 = d1;
		this.d2 = d2;
		this.d3 = d3;
		this.d4 = d4;
		this.d5 = d5;
		this.d6 = d6;
		this.d7 = d7;
		this.d8 = d8;
		this.d9 = d9;
		this.d10 = d10;
		this.d11 = d11;
		this.d12 = d12;
	}

	public SipOutsRecvbleCustWise_Layer3Details(String d13, String d14, String d15) {
		super();
		this.d13 = d13;
		this.d14 = d14;
		this.d15 = d15;
		// System.out.println("NUFAIL TESTING "+d13+"Cr "+d14+"Dr");
	}

	public List<SipOutsRecvbleCustWise_Layer3Details> netAccountBlnce() {
		List<SipOutsRecvbleCustWise_Layer3Details> onAccntCustmrDtls = new ArrayList<>();
		SipOutsRecvbleCustWise_Layer3Details temponAccntCustmrDtls = new SipOutsRecvbleCustWise_Layer3Details(this.d13,
				this.d14, this.d15);
		onAccntCustmrDtls.add(temponAccntCustmrDtls);

		return onAccntCustmrDtls;

	}
}
