package beans;

public class SipJihvDetails {

	private String d1 = null;// sm_code
	private String d2 = null; // aging
	private String d3 = null;// company_code
	private String d4 = null;// week
	private String d5 = null;// qtn_dt
	private String d6 = null; // qtn_code
	private String d7 = null;// qtn_no
	private String d8 = null;// cust_code
	private String d9 = null;// cust_name
	private String d10 = null;// prjct_name
	private String d11 = null;// consultant
	private String d12 = null;// invoicing_year
	private String d13 = null;// prod_type
	private String d14 = null;// prod_classfcn
	private String d15 = null;// zone
	private String d16 = null;// profit_perc
	private int d17;// qtn_amount
	private String d18 = null;// Quation status
	private String d19 = null;// reson

	private String segCode = null;//
	private String segName = null;//

	public String getSm_code() {
		return d1;
	}

	public void setSm_code(String d1) {
		this.d1 = d1;
	}

	public String getAging() {
		return d2;
	}

	public void setAging(String d2) {
		this.d2 = d2;
	}

	public String getCompany_code() {
		return d3;
	}

	public void setCompany_code(String d3) {
		this.d3 = d3;
	}

	public String getWeek() {
		return d4;
	}

	public void setWeek(String d4) {
		this.d4 = d4;
	}

	public String getQtn_dt() {
		return d5;
	}

	public void setQtn_dt(String d5) {
		this.d5 = d5;
	}

	public String getQtn_code() {
		return d6;
	}

	public void setQtn_code(String d6) {
		this.d6 = d6;
	}

	public String getQtn_no() {
		return d7;
	}

	public void setQtn_no(String d7) {
		this.d7 = d7;
	}

	public String getCust_code() {
		return d8;
	}

	public void setCust_code(String d8) {
		this.d8 = d8;
	}

	public String getCust_name() {
		return d9;
	}

	public void setCust_name(String d9) {
		this.d9 = d9;
	}

	public String getPrjct_name() {
		return d10;
	}

	public void setPrjct_name(String d10) {
		this.d10 = d10;
	}

	public String getConsultant() {
		return d11;
	}

	public void setConsultant(String d11) {
		this.d11 = d11;
	}

	public String getInvoicing_year() {
		return d12;
	}

	public void setInvoicing_year(String d12) {
		this.d12 = d12;
	}

	public String getProd_type() {
		return d13;
	}

	public void setProd_type(String d13) {
		this.d13 = d13;
	}

	public String getProd_classfcn() {
		return d14;
	}

	public void setProd_classfcn(String d14) {
		this.d14 = d14;
	}

	public String getZone() {
		return d15;
	}

	public void setZone(String d15) {
		this.d15 = d15;
	}

	public String getProfit_perc() {
		return d16;
	}

	public void setProfit_perc(String d16) {
		this.d16 = d16;
	}

	public int getQtn_amount() {
		return d17;
	}

	public void setQtn_amount(int d17) {
		this.d17 = d17;
	}

	public String getSegCode() {
		return segCode;
	}

	public void setSegCode(String segCode) {
		this.segCode = segCode;
	}

	public String getSegName() {
		return segName;
	}

	public void setSegName(String segName) {
		this.segName = segName;
	}

	public String getD18() {
		return d18;
	}

	public void setD18(String d18) {
		this.d18 = d18;
	}

	public String getD19() {
		return d19;
	}

	public void setD19(String d19) {
		this.d19 = d19;
	}

	public SipJihvDetails(String d3, String d4, String d5, String d6, String d7, String d8, String d9, String d10,
			String d11, String d12, String d13, String d14, String d15, String d16, int d17) {
		super();
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
		this.d13 = d13;
		this.d14 = d14;
		this.d15 = d15;
		this.d16 = d16;
		this.d17 = d17;
	}

	public SipJihvDetails(String d3, String d4, String d5, String d6, String d7, String d8, String d9, String d10,
			String d11, String d12, String d13, String d14, String d15, String d16, int d17, String segCode,
			String segName) {
		super();
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
		this.d13 = d13;
		this.d14 = d14;
		this.d15 = d15;
		this.d16 = d16;
		this.d17 = d17;
		this.segCode = segCode;
		this.segName = segName;
	}

	public SipJihvDetails(String d1, String d2) {
		super();
		this.d1 = d1;
		this.d2 = d2;
	}

	public SipJihvDetails(String d3, String d4, String d5, String d6, String d7, String d8, String d9, String d10,
			String d11, String d12, String d13, String d14, String d15, String d16, int d17, String d18, String d19,
			String test) {
		super();
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
		this.d13 = d13;
		this.d14 = d14;
		this.d15 = d15;
		this.d16 = d16;
		this.d17 = d17;
		this.d18 = d18;
		this.d19 = d19;
	}

}
