package beans;

public class Stage4Details {
	private String d1 = null;// so_date
	private String d2 = null;// so_trxn_code
	private String d3 = null;// so_number
	private String d4 = null;// sm_code
	private String d5 = null;// sm_name
	private String d6 = null;// sh_lc_nu
	private String d7 = null;// lc_exp_dt
	private String d8 = null;// zone
	private String d9 = null;// pdct_cat
	private String d10 = null;// pdct_sub_cat
	private String d11 = null;// prjct
	private String d12 = null;// consultant
	private String d13 = null;// pmt_term
	private String d14 = null;// customer
	private String d15 = null;// prof_perc
	private int d16;// balance_value
	private String d17 = null;// projected_inv_dt
	private String d18 = null;// so_lcn_code

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

	public String getProf_perc() {
		return d15;
	}

	public void setProf_perc(String prof_perc) {
		this.d15 = prof_perc;
	}

	public int getBalance_value() {
		return d16;
	}

	public void setBalance_value(int balance_value) {
		this.d16 = balance_value;
	}

	public String getProjected_inv_dt() {
		return d17;
	}

	public void setProjected_inv_dt(String projected_inv_dt) {
		this.d17 = projected_inv_dt;
	}

	public String getSo_lcn_code() {
		return d18;
	}

	public void setSo_lcn_code(String so_lcn_code) {
		this.d18 = so_lcn_code;
	}

	public Stage4Details(String d1, String d2, String d3, String d4, String d5, String d6, String d7, String d8,
			String d9, String d10, String d11, String d12, String d13, String d14, String d15, int d16, String d17,
			String d18) {
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
