package beans;

public class SipWeeklyReport {

	private String week = null;
	private String company = null;
	private String division = null;
	private String s2Count = null;
	private String s2Value = null;
	private String s3Count = null;
	private String s3Value = null;
	private String s4Count = null;
	private String s4Value = null;
	private String s5Count = null;
	private String s5Value = null;
	private String smCode = null;
	private String smName = null;
	private int weekNo = 0;

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getS2Count() {
		return s2Count;
	}

	public void setS2Count(String s2Count) {
		this.s2Count = s2Count;
	}

	public String getS2Value() {
		return s2Value;
	}

	public void setS2Value(String s2Value) {
		this.s2Value = s2Value;
	}

	public String getS3Count() {
		return s3Count;
	}

	public void setS3Count(String s3Count) {
		this.s3Count = s3Count;
	}

	public String getS3Value() {
		return s3Value;
	}

	public void setS3Value(String s3Value) {
		this.s3Value = s3Value;
	}

	public String getS4Count() {
		return s4Count;
	}

	public void setS4Count(String s4Count) {
		this.s4Count = s4Count;
	}

	public String getS4Value() {
		return s4Value;
	}

	public void setS4Value(String s4Value) {
		this.s4Value = s4Value;
	}

	public String getS5Count() {
		return s5Count;
	}

	public void setS5Count(String s5Count) {
		this.s5Count = s5Count;
	}

	public String getS5Value() {
		return s5Value;
	}

	public void setS5Value(String s5Value) {
		this.s5Value = s5Value;
	}

	public String getSmCode() {
		return smCode;
	}

	public void setSmCode(String smCode) {
		this.smCode = smCode;
	}

	public String getSmName() {
		return smName;
	}

	public void setSmName(String smName) {
		this.smName = smName;
	}

	public int getWeekNo() {
		return weekNo;
	}

	public void setWeekNo(int weekNo) {
		this.weekNo = weekNo;
	}

	public SipWeeklyReport(String week, String company, String division, String s2Count, String s2Value, String s3Count,
			String s3Value, String s4Count, String s4Value, String s5Count, String s5Value) {
		super();
		this.week = week;
		this.company = company;
		this.division = division;
		this.s2Count = s2Count;
		this.s2Value = s2Value;
		this.s3Count = s3Count;
		this.s3Value = s3Value;
		this.s4Count = s4Count;
		this.s4Value = s4Value;
		this.s5Count = s5Count;
		this.s5Value = s5Value;
	}

	public SipWeeklyReport(String week, String company, String division, String s2Count, String s2Value, String s3Count,
			String s3Value, String s4Count, String s4Value, String s5Count, String s5Value, String smCode,
			String smName) {
		super();
		this.week = week;
		this.company = company;
		this.division = division;
		this.s2Count = s2Count;
		this.s2Value = s2Value;
		this.s3Count = s3Count;
		this.s3Value = s3Value;
		this.s4Count = s4Count;
		this.s4Value = s4Value;
		this.s5Count = s5Count;
		this.s5Value = s5Value;
		this.smCode = smCode;
		this.smName = smName;
	}

	public SipWeeklyReport(int weekNo, String company, String division, String s2Count, String s2Value, String s3Count,
			String s3Value, String s4Count, String s4Value, String s5Count, String s5Value) {
		super();
		this.weekNo = weekNo;
		this.company = company;
		this.division = division;
		this.s2Count = s2Count;
		this.s2Value = s2Value;
		this.s3Count = s3Count;
		this.s3Value = s3Value;
		this.s4Count = s4Count;
		this.s4Value = s4Value;
		this.s5Count = s5Count;
		this.s5Value = s5Value;
	}

}
