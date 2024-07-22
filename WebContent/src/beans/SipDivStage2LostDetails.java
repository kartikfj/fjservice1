package beans;

public class SipDivStage2LostDetails {

	private String d1 = null;// week
	private String d2 = null; // company code
	private String d3 = null;// qtn_dt
	private String d4 = null;// qtn_code
	private String d5 = null;// qtn_no
	private String d6 = null; // customer_code
	private String d7 = null;// customer_name
	private String d8 = null;// Sales Egr Code
	private String d9 = null;// Sales Egr Name
	private String d10 = null;// prjct_name
	private String d11 = null;// consultant
	private String d12 = null;// invoicing_year
	private String d13 = null;// prod_type
	private String d14 = null;// prod_classfcn
	private String d15 = null;// zone
	private String d16 = null;// profit_perc
	private String d17 = null;// qtn_amount
	private String d18 = null;// qtn_status
	private String d19 = null;// qtn_lost_type
	private String d20 = null;// qtn_lost_description

	public String getWeek() {
		return d1;
	}

	public void setWeek(String week) {
		this.d1 = week;
	}

	public String getCmp_code() {
		return d2;
	}

	public void setCmp_code(String cmp_code) {
		this.d2 = cmp_code;
	}

	public String getQtn_dt() {
		return d3;
	}

	public void setQtn_dt(String qtn_dt) {
		this.d3 = qtn_dt;
	}

	public String getQtn_code() {
		return d4;
	}

	public void setQtn_code(String qtn_code) {
		this.d4 = qtn_code;
	}

	public String getQtn_no() {
		return d5;
	}

	public void setQtn_no(String qtn_no) {
		this.d5 = qtn_no;
	}

	public String getCustomer_code() {
		return d6;
	}

	public void setCustomer_code(String customer_code) {
		this.d6 = customer_code;
	}

	public String getCustomer_name() {
		return d7;
	}

	public void setCustomer_name(String customer_name) {
		this.d7 = customer_name;
	}

	public String getSales_Egr_Code() {
		return d8;
	}

	public void setSales_Egr_Code(String sales_Egr_Code) {
		this.d8 = sales_Egr_Code;
	}

	public String getSales_Egr_Name() {
		return d9;
	}

	public void setSales_Egr_Name(String sales_Egr_Name) {
		this.d9 = sales_Egr_Name;
	}

	public String getPrjct_name() {
		return d10;
	}

	public void setPrjct_name(String prjct_name) {
		this.d10 = prjct_name;
	}

	public String getConsultant() {
		return d11;
	}

	public void setConsultant(String consultant) {
		this.d11 = consultant;
	}

	public String getInvoicing_year() {
		return d12;
	}

	public void setInvoicing_year(String invoicing_year) {
		this.d12 = invoicing_year;
	}

	public String getProd_type() {
		return d13;
	}

	public void setProd_type(String prod_type) {
		this.d13 = prod_type;
	}

	public String getProd_classfcn() {
		return d14;
	}

	public void setProd_classfcn(String prod_classfcn) {
		this.d14 = prod_classfcn;
	}

	public String getZone() {
		return d15;
	}

	public void setZone(String zone) {
		this.d15 = zone;
	}

	public String getProfit_perc() {
		return d16;
	}

	public void setProfit_perc(String profit_perc) {
		this.d16 = profit_perc;
	}

	public String getQtn_amount() {
		return d17;
	}

	public void setQtn_amount(String qtn_amount) {
		this.d17 = qtn_amount;
	}

	public String getQtn_status() {
		return d18;
	}

	public void setQtn_status(String qtn_status) {
		this.d18 = qtn_status;
	}
	public String getD19() {
		return d19;
	}

	public void setD19(String d19) {
		this.d19 = d19;
	}

	public String getD20() {
		return d20;
	}

	public void setD20(String d20) {
		this.d20 = d20;
	}

	// for SEG LOST
	public SipDivStage2LostDetails(String d1, String d2, String d3, String d4, String d5, String d6, String d7,
			String d8, String d9, String d10, String d11, String d12, String d13, String d14, String d15, String d16,
			String d17, String d18, String d19, String d20) {
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
		this.d13 = d13;
		this.d14 = d14;
		this.d15 = d15;
		this.d16 = d16;
		this.d17 = d17;
		this.d18 = d18;
		this.d19 = d19;
		this.d20 = d20;
	}
// FOR DIVISIN LOST
	public SipDivStage2LostDetails(String d1, String d2, String d3, String d4, String d5, String d6, String d7,
			String d8, String d9, String d10, String d11, String d12, String d13, String d14, String d15, String d16,
			String d17, String d18) {
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
		this.d13 = d13;
		this.d14 = d14;
		this.d15 = d15;
		this.d16 = d16;
		this.d17 = d17;
		this.d18 = d18; 
	}

}
