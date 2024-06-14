package beans;

public class Overview {
	private int overview_id = 0;
	private int year = 0;
	private String empid = null;
	private String appr_id = null;
	private String strength = null;
	private String improvement = null;
	private String rating = null;
	private String promotion = null;
	private String sign_off = null;

	public int getOverview_id() {
		return overview_id;
	}

	public void setOverview_id(int overview_id) {
		this.overview_id = overview_id;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getEmpid() {
		return empid;
	}

	public void setEmpid(String empid) {
		this.empid = empid;
	}

	public String getAppr_id() {
		return appr_id;
	}

	public void setAppr_id(String appr_id) {
		this.appr_id = appr_id;
	}

	public String getStrength() {
		return strength;
	}

	public void setStrength(String strength) {
		this.strength = strength;
	}

	public String getImprovement() {
		return improvement;
	}

	public void setImprovement(String improvement) {
		this.improvement = improvement;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getPromotion() {
		return promotion;
	}

	public void setPromotion(String promotion) {
		this.promotion = promotion;
	}

	public String getSign_off() {
		return sign_off;
	}

	public void setSign_off(String sign_off) {
		this.sign_off = sign_off;
	}

	public Overview(int overview_id, int year, String empid, String appr_id, String strength, String improvement,
			String rating, String promotion) {
		super();
		this.overview_id = overview_id;
		this.year = year;
		this.empid = empid;
		this.appr_id = appr_id;
		this.strength = strength;
		this.improvement = improvement;
		this.rating = rating;
		this.promotion = promotion;
	}

	public Overview(int overview_id, String appr_id, String sign_off) {
		super();
		this.overview_id = overview_id;
		this.appr_id = appr_id;
		this.sign_off = sign_off;
	}

	public Overview(int overview_id, String appr_id, String strength, String improvement, String rating,
			String promotion) {
		super();
		this.overview_id = overview_id;
		this.appr_id = appr_id;
		this.strength = strength;
		this.improvement = improvement;
		this.rating = rating;
		this.promotion = promotion;
	}

	public Overview(int overview_id, int year, String empid, String appr_id, String strength, String improvement,
			String rating, String promotion, String sign_off) {
		super();
		this.overview_id = overview_id;
		this.year = year;
		this.empid = empid;
		this.appr_id = appr_id;
		this.strength = strength;
		this.improvement = improvement;
		this.rating = rating;
		this.promotion = promotion;
		this.sign_off = sign_off;
	}

}
