package beans;

public class Stage1Details {
	private String d1 = null;// comp_code
	private String d2 = null;// week
	private String d3 = null;// qtn_date
	private String d4 = null;// qtn_code
	private String d5 = null;// qtn_number
	private String d6 = null;// customer_code
	private String d7 = null;// customer_name
	private String d8 = null;// project
	private String d9 = null;// consultant
	private String d10 = null;// job_stage
	private String d11 = null;// product_type
	private String d12 = null;// product_classifctn
	private String d13 = null;// zone
	private String d14 = null;// profit_perc
	private int d15;// qtn_amount
	private String d16 = null;// seg_code
	private String d17 = null;// seg_name

	public String getSo_date() {
		return d1;
	}

	public void setSo_date(String so_date) {
		this.d1 = so_date;
	}

	public String getSo_trxn_code() {
		return d2;
	}

	public void setSo_trxn_code(String so_trxn_code) {
		this.d2 = so_trxn_code;
	}

	public String getSo_number() {
		return d3;
	}

	public void setSo_number(String so_number) {
		this.d3 = so_number;
	}

	public String getSm_code() {
		return d4;
	}

	public void setSm_code(String sm_code) {
		this.d4 = sm_code;
	}

	public String getSm_name() {
		return d5;
	}

	public void setSm_name(String sm_name) {
		this.d5 = sm_name;
	}

	public String getSh_lc_nu() {
		return d6;
	}

	public void setSh_lc_nu(String sh_lc_nu) {
		this.d6 = sh_lc_nu;
	}

	public String getLc_exp_dt() {
		return d7;
	}

	public void setLc_exp_dt(String lc_exp_dt) {
		this.d7 = lc_exp_dt;
	}

	public String getZone() {
		return d8;
	}

	public void setZone(String zone) {
		this.d8 = zone;
	}

	public String getPdct_cat() {
		return d9;
	}

	public void setPdct_cat(String pdct_cat) {
		this.d9 = pdct_cat;
	}

	public String getPdct_sub_cat() {
		return d10;
	}

	public void setPdct_sub_cat(String pdct_sub_cat) {
		this.d10 = pdct_sub_cat;
	}

	public String getPrjct() {
		return d11;
	}

	public void setPrjct(String prjct) {
		this.d11 = prjct;
	}

	public String getConsultant() {
		return d12;
	}

	public void setConsultant(String consultant) {
		this.d12 = consultant;
	}

	public String getPmt_term() {
		return d13;
	}

	public void setPmt_term(String pmt_term) {
		this.d13 = pmt_term;
	}

	public String getCustomer() {
		return d14;
	}

	public void setCustomer(String customer) {
		this.d14 = customer;
	}

	public int getProf_perc() {
		return d15;
	}

	public void setProf_perc(int prof_perc) {
		this.d15 = prof_perc;
	}

	public String getBalance_value() {
		return d16;
	}

	public void setBalance_value(String balance_value) {
		this.d16 = balance_value;
	}

	public Stage1Details(String d1, String d2, String d3, String d4, String d5, String d6, String d7, String d8,
			String d9, String d10, String d11, String d12, String d13, String d14, int d15, String d16, String d17) {
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
	}

	public String getD17() {
		return d17;
	}

	public void setD17(String d17) {
		this.d17 = d17;
	}

}
