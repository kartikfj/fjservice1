package beans;

public class SipOutRecvbleReprt {
	// Dashboard Outstanding Receivable Aging report
	private String sm_code = null;
	private String sm_name = null;
	private String subDvn_code = null;
	private String aging_1 = null;// <30
	private String aging_2 = null;// 30-60
	private String aging_3 = null;// 60-90
	private String aging_4 = null;// 90-120
	private String aging_5 = null;// 120-180
	private String aging_6 = null;// >180
	private String pr_date = null;// procced date

	public String getSm_code() {
		return sm_code;
	}

	public void setSm_code(String sm_code) {
		this.sm_code = sm_code;
	}

	public String getSm_name() {
		return sm_name;
	}

	public void setSm_name(String sm_name) {
		this.sm_name = sm_name;
	}

	public String getAging_1() {
		return aging_1;
	}

	public void setAging_1(String aging_1) {
		this.aging_1 = aging_1;
	}

	public String getAging_2() {
		return aging_2;
	}

	public void setAging_2(String aging_2) {
		this.aging_2 = aging_2;
	}

	public String getAging_3() {
		return aging_3;
	}

	public void setAging_3(String aging_3) {
		this.aging_3 = aging_3;
	}

	public String getAging_4() {
		return aging_4;
	}

	public void setAging_4(String aging_4) {
		this.aging_4 = aging_4;
	}

	public String getAging_5() {
		return aging_5;
	}

	public void setAging_5(String aging_5) {
		this.aging_5 = aging_5;
	}

	public String getAging_6() {
		return aging_6;
	}

	public void setAging_6(String aging_6) {
		this.aging_6 = aging_6;
	}

	public String getPr_date() {
		return pr_date;
	}

	public void setPr_date(String pr_date) {
		this.pr_date = pr_date;
	}

	public String getSubDvn_code() {
		return subDvn_code;
	}

	public void setSubDvn_code(String subDvn_code) {
		this.subDvn_code = subDvn_code;
	}

	public SipOutRecvbleReprt(String sm_code, String sm_name, String aging_1, String aging_2, String aging_3,
			String aging_4, String aging_5, String aging_6, String pr_date) {
		super();
		this.sm_code = sm_code;
		this.sm_name = sm_name;
		this.aging_1 = aging_1;
		this.aging_2 = aging_2;
		this.aging_3 = aging_3;
		this.aging_4 = aging_4;
		this.aging_5 = aging_5;
		this.aging_6 = aging_6;
		this.pr_date = pr_date;
	}

	public SipOutRecvbleReprt(String subDvn_code, String aging_1, String aging_2, String aging_3, String aging_4,
			String aging_5, String aging_6, String pr_date) {
		super();
		this.subDvn_code = subDvn_code;
		this.aging_1 = aging_1;
		this.aging_2 = aging_2;
		this.aging_3 = aging_3;
		this.aging_4 = aging_4;
		this.aging_5 = aging_5;
		this.aging_6 = aging_6;
		this.pr_date = pr_date;
	}
}
