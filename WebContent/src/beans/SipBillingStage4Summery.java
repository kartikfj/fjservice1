package beans;

public class SipBillingStage4Summery {
	private String dm_emp_code = null;
	private String company = null;
	private String year = null;
	private String monthly_target = null;
	private String yr_total_target = null;
	private String ytm_target = null;
	private String jan = null;
	private String feb = null;
	private String mar = null;
	private String apr = null;
	private String may = null;
	private String jun = null;
	private String jul = null;
	private String aug = null;
	private String sep = null;
	private String oct = null;
	private String nov = null;
	private String dec = null;
	private String ytm_actual = null;

	public String getDm_emp_code() {
		return dm_emp_code;
	}

	public void setDm_emp_code(String dm_emp_code) {
		this.dm_emp_code = dm_emp_code;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonthly_target() {
		return monthly_target;
	}

	public void setMonthly_target(String monthly_target) {
		this.monthly_target = monthly_target;
	}

	public String getYr_total_target() {
		return yr_total_target;
	}

	public void setYr_total_target(String yr_total_target) {
		this.yr_total_target = yr_total_target;
	}

	public String getYtm_target() {
		return ytm_target;
	}

	public void setYtm_target(String ytm_target) {
		this.ytm_target = ytm_target;
	}

	public String getJan() {
		return jan;
	}

	public void setJan(String jan) {
		this.jan = jan;
	}

	public String getFeb() {
		return feb;
	}

	public void setFeb(String feb) {
		this.feb = feb;
	}

	public String getMar() {
		return mar;
	}

	public void setMar(String mar) {
		this.mar = mar;
	}

	public String getApr() {
		return apr;
	}

	public void setApr(String apr) {
		this.apr = apr;
	}

	public String getMay() {
		return may;
	}

	public void setMay(String may) {
		this.may = may;
	}

	public String getJun() {
		return jun;
	}

	public void setJun(String jun) {
		this.jun = jun;
	}

	public String getJul() {
		return jul;
	}

	public void setJul(String jul) {
		this.jul = jul;
	}

	public String getAug() {
		return aug;
	}

	public void setAug(String aug) {
		this.aug = aug;
	}

	public String getSep() {
		return sep;
	}

	public void setSep(String sep) {
		this.sep = sep;
	}

	public String getOct() {
		return oct;
	}

	public void setOct(String oct) {
		this.oct = oct;
	}

	public String getNov() {
		return nov;
	}

	public void setNov(String nov) {
		this.nov = nov;
	}

	public String getDec() {
		return dec;
	}

	public void setDec(String dec) {
		this.dec = dec;
	}

	public String getYtm_actual() {
		return ytm_actual;
	}

	public void setYtm_actual(String ytm_actual) {
		this.ytm_actual = ytm_actual;
	}

	public SipBillingStage4Summery(String company, String year, String monthly_target, String yr_total_target,
			String ytm_target, String jan, String feb, String mar, String apr, String may, String jun, String jul,
			String aug, String sep, String oct, String nov, String dec, String ytm_actual) {
		super();
		this.company = company;
		this.year = year;
		this.monthly_target = monthly_target;
		this.yr_total_target = yr_total_target;
		this.ytm_target = ytm_target;
		this.jan = jan;
		this.feb = feb;
		this.mar = mar;
		this.apr = apr;
		this.may = may;
		this.jun = jun;
		this.jul = jul;
		this.aug = aug;
		this.sep = sep;
		this.oct = oct;
		this.nov = nov;
		this.dec = dec;
		this.ytm_actual = ytm_actual;
	}

	public SipBillingStage4Summery(String dm_emp_code, String monthly_target, String yr_total_target, String ytm_target,
			String jan, String feb, String mar, String apr, String may, String jun, String jul, String aug, String sep,
			String oct, String nov, String dec, String ytm_actual) {
		super();
		this.dm_emp_code = dm_emp_code;
		this.monthly_target = monthly_target;
		this.yr_total_target = yr_total_target;
		this.ytm_target = ytm_target;
		this.jan = jan;
		this.feb = feb;
		this.mar = mar;
		this.apr = apr;
		this.may = may;
		this.jun = jun;
		this.jul = jul;
		this.aug = aug;
		this.sep = sep;
		this.oct = oct;
		this.nov = nov;
		this.dec = dec;
		this.ytm_actual = ytm_actual;
	}

}
