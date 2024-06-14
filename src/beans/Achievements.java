package beans;

public class Achievements {
	private int achvmt_id = 0;
	private int year = 0;
	private String empid = null;
	private String appr_id = null;
	private String achievement = null;

	public int getAchvmt_id() {
		return achvmt_id;
	}

	public void setAchvmt_id(int achvmt_id) {
		this.achvmt_id = achvmt_id;
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

	public String getAchievement() {
		return achievement;
	}

	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}

	public Achievements(int achvmt_id, int year, String empid, String appr_id, String achievement) {
		super();
		this.achvmt_id = achvmt_id;
		this.year = year;
		this.empid = empid;
		this.appr_id = appr_id;
		this.achievement = achievement;
	}

	public Achievements(int achvmt_id, String achievement) {
		super();
		this.achvmt_id = achvmt_id;
		this.achievement = achievement;
	}

}
