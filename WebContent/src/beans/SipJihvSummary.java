package beans;

public class SipJihvSummary {
	private String duration = null;
	private String amount = null;
	private String salesman_code = null;
	private String salesman_name = null;
	private String salesman_emp_code = null;
	private String division = null;
	private String target_type = null;
	private String yrly_target = null;
	private String target_mth = null;
	private String actual_mth = null;
	private String target_ytm = null;
	private String actual_ytm = null;
	private String percentage = null;
	private String sm_division = null;

	public String getTarget_mth() {
		return target_mth;
	}

	public void setTarget_mth(String target_mth) {
		this.target_mth = target_mth;
	}

	public String getActual_mth() {
		return actual_mth;
	}

	public void setActual_mth(String actual_mth) {
		this.actual_mth = actual_mth;
	}

	public String getTarget_ytm() {
		return target_ytm;
	}

	public void setTarget_ytm(String target_ytm) {
		this.target_ytm = target_ytm;
	}

	public String getActual_ytm() {
		return actual_ytm;
	}

	public void setActual_ytm(String actual_ytm) {
		this.actual_ytm = actual_ytm;
	}

	public String getPercentage() {
		return percentage;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}

	private int sid = 0;

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getSalesman_name() {
		return salesman_name;
	}

	public void setSalesman_name(String salesman_name) {
		this.salesman_name = salesman_name;
	}

	public String getSalesman_code() {
		return salesman_code;
	}

	public void setSalesman_code(String salesman_code) {
		this.salesman_code = salesman_code;
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public SipJihvSummary(String duration, String amount) {
		super();
		this.duration = duration;
		this.amount = amount;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getTarget_type() {
		return target_type;
	}

	public void setTarget_type(String target_type) {
		this.target_type = target_type;
	}

	public String getYrly_target() {
		return yrly_target;
	}

	public void setYrly_target(String yrly_target) {
		this.yrly_target = yrly_target;
	}

	public SipJihvSummary(String salesman_code, String salesman_name, String salesman_emp_code, int sid) {
		super();
		this.salesman_code = salesman_code;
		this.salesman_name = salesman_name;
		this.salesman_emp_code = salesman_emp_code;
		this.sid = sid;
	}

	public SipJihvSummary(String salesman_code, String salesman_name, String division, String target_type,
			String yrly_target, String target_mth, String actual_mth, String target_ytm, String actual_ytm,
			String percentage) {
		super();
		this.salesman_code = salesman_code;
		this.salesman_name = salesman_name;
		this.division = division;
		this.target_type = target_type;
		this.yrly_target = yrly_target;
		this.target_mth = target_mth;
		this.actual_mth = actual_mth;
		this.target_ytm = target_ytm;
		this.actual_ytm = actual_ytm;
		this.percentage = percentage;
	}

	public SipJihvSummary(String salesman_code, String salesman_name, String salesman_emp_code, String sm_division,
			int sid) {
		super();
		this.salesman_code = salesman_code;
		this.salesman_name = salesman_name;
		this.salesman_emp_code = salesman_emp_code;
		this.sm_division = sm_division;
		this.sid = sid;
	}

	public String getSalesman_emp_code() {
		return salesman_emp_code;
	}

	public void setSalesman_emp_code(String salesman_emp_code) {
		this.salesman_emp_code = salesman_emp_code;
	}

	public String getsm_division() {
		return sm_division;
	}

	public void setsm_division(String sm_division) {
		this.sm_division = sm_division;
	}

}
