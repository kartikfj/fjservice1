package beans;

public class SipForecastSalesOrderDelivery {

	private String monthYear = null;
	private String value = null;
	private String fcStg3 = null;

	private String d1 = null; // SO_TXN_CODE
	private String d2 = null; // SO_NO
	private String d3 = null; // SO_DT
	private String d4 = null; // SOH_SM_CODE
	private String d5 = null; // SALES_ENG
	private String d6 = null; // DIVN
	private String d7 = null; // PROJECT
	private String d8 = null; // CONSULTANT
	private String d9 = null; // PAYMENT_TERM_NAME
	private String d10 = null; // CUSTOMER
	private String d11 = null; // BALANCE_VALUE
	private String d12 = null; // DELIVERY_DT

	public String getMonthYear() {
		return monthYear;
	}

	public void setMonthYear(String monthYear) {
		this.monthYear = monthYear;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

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

	public String getFcStg3() {
		return fcStg3;
	}

	public void setFcStg3(String fcStg3) {
		this.fcStg3 = fcStg3;
	}

	public SipForecastSalesOrderDelivery(String monthYear, String value) {
		super();
		// summary
		this.monthYear = monthYear;
		this.value = value;
	}

	public SipForecastSalesOrderDelivery(String monthYear, String fcStg4, String fcStg3) {
		super();
		// summary
		this.monthYear = monthYear;
		this.value = fcStg4;
		this.fcStg3 = fcStg3;
	}

	public SipForecastSalesOrderDelivery(String d1, String d2, String d3, String d4, String d5, String d6, String d7,
			String d8, String d9, String d10, String d11, String d12) {
		super();
		// details
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

}
