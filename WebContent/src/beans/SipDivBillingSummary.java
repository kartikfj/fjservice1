package beans;

public class SipDivBillingSummary {
	private String division = null;
	private long month_perc = 0;
	private String ytd_perc = null;
	private String month_actual = null;
	private String month_target = null;
	private String ytm_actual = null;
	private String ytm_target = null;

	// for last two years summary
	private String curr_yrt = null;
	private String curr_yra = null;
	private String prev_yrt = null;
	private String prev_yra = null;
	private String scnd_prev_yrt = null;
	private String scnd_prev_yra = null;

	public String getMonth_actual() {
		return month_actual;
	}

	public void setMonth_actual(String month_actual) {
		this.month_actual = month_actual;
	}

	public String getMonth_target() {
		return month_target;
	}

	public void setMonth_target(String month_target) {
		this.month_target = month_target;
	}

	public String getCurr_yrt() {
		return curr_yrt;
	}

	public void setCurr_yrt(String curr_yrt) {
		this.curr_yrt = curr_yrt;
	}

	public String getCurr_yra() {
		return curr_yra;
	}

	public void setCurr_yra(String curr_yra) {
		this.curr_yra = curr_yra;
	}

	public String getPrev_yrt() {
		return prev_yrt;
	}

	public void setPrev_yrt(String prev_yrt) {
		this.prev_yrt = prev_yrt;
	}

	public String getPrev_yra() {
		return prev_yra;
	}

	public void setPrev_yra(String prev_yra) {
		this.prev_yra = prev_yra;
	}

	public String getScnd_prev_yrt() {
		return scnd_prev_yrt;
	}

	public void setScnd_prev_yrt(String scnd_prev_yrt) {
		this.scnd_prev_yrt = scnd_prev_yrt;
	}

	public String getScnd_prev_yra() {
		return scnd_prev_yra;
	}

	public void setScnd_prev_yra(String scnd_prev_yra) {
		this.scnd_prev_yra = scnd_prev_yra;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public long getMonth_perc() {
		return month_perc;
	}

	public void setMonth_perc(long month_perc) {
		this.month_perc = month_perc;
	}

	public String getYtd_perc() {
		return ytd_perc;
	}

	public void setYtd_perc(String ytd_perc) {
		this.ytd_perc = ytd_perc;
	}

	public String getYtm_actual() {
		return ytm_actual;
	}

	public void setYtm_actual(String ytm_actual) {
		this.ytm_actual = ytm_actual;
	}

	public String getYtm_target() {
		return ytm_target;
	}

	public void setYtm_target(String ytm_target) {
		this.ytm_target = ytm_target;
	}

	public SipDivBillingSummary(String division, long month_perc, String ytd_perc, String month_actual,
			String month_target, String ytm_actual, String ytm_target) {
		super();
		this.division = division;
		this.month_perc = month_perc;
		this.ytd_perc = ytd_perc;
		this.month_actual = month_actual;
		this.month_target = month_target;
		this.ytm_actual = ytm_actual;
		this.ytm_target = ytm_target;
	}

	public SipDivBillingSummary(String division, String curr_yrt, String curr_yra, String prev_yrt, String prev_yra,
			String scnd_prev_yrt, String scnd_prev_yra) {
		super();
		this.division = division;
		this.curr_yrt = curr_yrt;
		this.curr_yra = curr_yra;
		this.prev_yrt = prev_yrt;
		this.prev_yra = prev_yra;
		this.scnd_prev_yrt = scnd_prev_yrt;
		this.scnd_prev_yra = scnd_prev_yra;
	}

}
