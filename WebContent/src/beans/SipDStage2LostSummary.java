package beans;

public class SipDStage2LostSummary {
	// stage 2 or jihv lost quotation
	private String div_code = null;
	private String aging1_count_actual = null;// 0-3 month actual count
	private String aging1_count_lost = null;// 0-3 month lost qtn count
	private String aging1_amt_actual = null;// 0-3 month actual qtn value
	private String aging1_amt_lost = null;// 0-3 month lost qtn valu
	private String aging2_count_actual = null;// 3-6 actual count
	private String aging2_count_lost = null;// 3-6 month lost qtn count
	private String aging2_amt_actual = null;// 3-6 month actual qtn value
	private String aging2_amt_lost = null;// 3-6 month lost qtn value
	private String aging3_count_actual = null;// >6 month actual count
	private String aging3_count_lost = null;// >6 month lost qtn count
	private String aging3_amt_actual = null;// >6Mths actual value
	private String aging3_amt_lost = null;// >6Mths month lost qtn value

	public String getDiv_code() {
		return div_code;
	}

	public void setDiv_code(String div_code) {
		this.div_code = div_code;
	}

	public String getAging1_count_actual() {
		return aging1_count_actual;
	}

	public void setAging1_count_actual(String aging1_count_actual) {
		this.aging1_count_actual = aging1_count_actual;
	}

	public String getAging1_count_lost() {
		return aging1_count_lost;
	}

	public void setAging1_count_lost(String aging1_count_lost) {
		this.aging1_count_lost = aging1_count_lost;
	}

	public String getAging1_amt_actual() {
		return aging1_amt_actual;
	}

	public void setAging1_amt_actual(String aging1_amt_actual) {
		this.aging1_amt_actual = aging1_amt_actual;
	}

	public String getAging1_amt_lost() {
		return aging1_amt_lost;
	}

	public void setAging1_amt_lost(String aging1_amt_lost) {
		this.aging1_amt_lost = aging1_amt_lost;
	}

	public String getAging2_count_actual() {
		return aging2_count_actual;
	}

	public void setAging2_count_actual(String aging2_count_actual) {
		this.aging2_count_actual = aging2_count_actual;
	}

	public String getAging2_count_lost() {
		return aging2_count_lost;
	}

	public void setAging2_count_lost(String aging2_count_lost) {
		this.aging2_count_lost = aging2_count_lost;
	}

	public String getAging2_amt_actual() {
		return aging2_amt_actual;
	}

	public void setAging2_amt_actual(String aging2_amt_actual) {
		this.aging2_amt_actual = aging2_amt_actual;
	}

	public String getAging2_amt_lost() {
		return aging2_amt_lost;
	}

	public void setAging2_amt_lost(String aging2_amt_lost) {
		this.aging2_amt_lost = aging2_amt_lost;
	}

	public String getAging3_count_actual() {
		return aging3_count_actual;
	}

	public void setAging3_count_actual(String aging3_count_actual) {
		this.aging3_count_actual = aging3_count_actual;
	}

	public String getAging3_count_lost() {
		return aging3_count_lost;
	}

	public void setAging3_count_lost(String aging3_count_lost) {
		this.aging3_count_lost = aging3_count_lost;
	}

	public String getAging3_amt_actual() {
		return aging3_amt_actual;
	}

	public void setAging3_amt_actual(String aging3_amt_actual) {
		this.aging3_amt_actual = aging3_amt_actual;
	}

	public String getAging3_amt_lost() {
		return aging3_amt_lost;
	}

	public void setAging3_amt_lost(String aging3_amt_lost) {
		this.aging3_amt_lost = aging3_amt_lost;
	}

	public SipDStage2LostSummary(String div_code, String aging1_count_actual, String aging1_count_lost,
			String aging1_amt_actual, String aging1_amt_lost, String aging2_count_actual, String aging2_count_lost,
			String aging2_amt_actual, String aging2_amt_lost, String aging3_count_actual, String aging3_count_lost,
			String aging3_amt_actual, String aging3_amt_lost) {
		super();
		this.div_code = div_code;
		this.aging1_count_actual = aging1_count_actual;
		this.aging1_count_lost = aging1_count_lost;
		this.aging1_amt_actual = aging1_amt_actual;
		this.aging1_amt_lost = aging1_amt_lost;
		this.aging2_count_actual = aging2_count_actual;
		this.aging2_count_lost = aging2_count_lost;
		this.aging2_amt_actual = aging2_amt_actual;
		this.aging2_amt_lost = aging2_amt_lost;
		this.aging3_count_actual = aging3_count_actual;
		this.aging3_count_lost = aging3_count_lost;
		this.aging3_amt_actual = aging3_amt_actual;
		this.aging3_amt_lost = aging3_amt_lost;
	}
	public SipDStage2LostSummary( String aging1_count_actual, String aging1_count_lost,
			String aging1_amt_actual, String aging1_amt_lost, String aging2_count_actual, String aging2_count_lost,
			String aging2_amt_actual, String aging2_amt_lost, String aging3_count_actual, String aging3_count_lost,
			String aging3_amt_actual, String aging3_amt_lost) {
		super(); 
		this.aging1_count_actual = aging1_count_actual;
		this.aging1_count_lost = aging1_count_lost;
		this.aging1_amt_actual = aging1_amt_actual;
		this.aging1_amt_lost = aging1_amt_lost;
		this.aging2_count_actual = aging2_count_actual;
		this.aging2_count_lost = aging2_count_lost;
		this.aging2_amt_actual = aging2_amt_actual;
		this.aging2_amt_lost = aging2_amt_lost;
		this.aging3_count_actual = aging3_count_actual;
		this.aging3_count_lost = aging3_count_lost;
		this.aging3_amt_actual = aging3_amt_actual;
		this.aging3_amt_lost = aging3_amt_lost;
	}
}
