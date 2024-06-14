package beans;

public class SipSalesEngWeeklyBookningReport {

	private String division = null;
	private String sales_code = null;
	private String sales_eng_name = null;
	private String yrly_bkng_tgt = null;
	private String ytd_actual_bkng = null;
	private String ytd_target_bkng = null;
	private String target_perc_achvd = null;
	private String weekly_avg_target = null;

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getSales_code() {
		return sales_code;
	}

	public void setSales_code(String sales_code) {
		this.sales_code = sales_code;
	}

	public String getSales_eng_name() {
		return sales_eng_name;
	}

	public void setSales_eng_name(String sales_eng_name) {
		this.sales_eng_name = sales_eng_name;
	}

	public String getYrly_bkng_tgt() {
		return yrly_bkng_tgt;
	}

	public void setYrly_bkng_tgt(String yrly_bkng_tgt) {
		this.yrly_bkng_tgt = yrly_bkng_tgt;
	}

	public String getYtd_actual_bkng() {
		return ytd_actual_bkng;
	}

	public void setYtd_actual_bkng(String ytd_actual_bkng) {
		this.ytd_actual_bkng = ytd_actual_bkng;
	}

	public String getYtd_target_bkng() {
		return ytd_target_bkng;
	}

	public void setYtd_target_bkng(String ytd_target_bkng) {
		this.ytd_target_bkng = ytd_target_bkng;
	}

	public String getTarget_perc_achvd() {
		return target_perc_achvd;
	}

	public void setTarget_perc_achvd(String target_perc_achvd) {
		this.target_perc_achvd = target_perc_achvd;
	}

	public String getWeekly_avg_target() {
		return weekly_avg_target;
	}

	public void setWeekly_avg_target(String weekly_avg_target) {
		this.weekly_avg_target = weekly_avg_target;
	}

	public SipSalesEngWeeklyBookningReport(String division, String sales_code, String sales_eng_name,
			String yrly_bkng_tgt, String ytd_actual_bkng, String ytd_target_bkng, String target_perc_achvd,
			String weekly_avg_target) {
		super();
		this.division = division;
		this.sales_code = sales_code;
		this.sales_eng_name = sales_eng_name;
		this.yrly_bkng_tgt = yrly_bkng_tgt;
		this.ytd_actual_bkng = ytd_actual_bkng;
		this.ytd_target_bkng = ytd_target_bkng;
		this.target_perc_achvd = target_perc_achvd;
		this.weekly_avg_target = weekly_avg_target;
	}

}
