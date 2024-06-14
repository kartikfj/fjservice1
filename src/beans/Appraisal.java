package beans;

public class Appraisal {

	private int goal_id = 0;
	private int year = 0;
	private String empid = null;
	private String appr_id = null;
	private String goal_type = null;
	private String goal = null;
	private String measure = null;
	private String target = null;
	private String gs_approved = null;
	private String gs_apprddate = null;
	private String gs_approvedid = null;
	private String mdprogress = null;
	private String mdprogressA = null;
	private String mdremark = null;
	private String mdtrack = null;
	private String mid_approved = null;
	private String mid_apprddate = null;
	private String mid_approvedid = null;
	private String finalap = null;
	private String finalapA = null;
	private String finalremark = null;
	private String fin_approved = null;
	private String fin_apprddate = null;
	private String fin_approvedid = null;

	// Constructor for approver, with approver id field, approver id taken from fj
	// user

	// constructor for normal employee , if hr published the time span for first
	// term appraisal

	// complete list

	// first
	public Appraisal(int goal_id, int year, String empid, String appr_id, String goal_type, String goal, String measure,
			String target) {

		this.goal_id = goal_id;
		this.year = year;
		this.empid = empid;
		this.appr_id = appr_id;
		this.goal_type = goal_type;
		this.goal = goal;
		this.measure = measure;
		this.target = target;
	}

	public Appraisal(String gs_approved, String gs_apprddate, String gs_approvedid, String mid_approved,
			String mid_apprddate, String mid_approvedid, String fin_approved, String fin_apprddate,
			String fin_approvedid) {
		super();
		this.gs_approved = gs_approved;
		this.gs_apprddate = gs_apprddate;
		this.gs_approvedid = gs_approvedid;
		this.mid_approved = mid_approved;
		this.mid_apprddate = mid_apprddate;
		this.mid_approvedid = mid_approvedid;
		this.fin_approved = fin_approved;
		this.fin_apprddate = fin_apprddate;
		this.fin_approvedid = fin_approvedid;
	}

	public Appraisal(String mdprogressA, String mdremark, String mdtrack, int goal_id) {
		super();

		this.mdprogressA = mdprogressA;
		this.mdremark = mdremark;
		this.mdtrack = mdtrack;
		this.goal_id = goal_id;
	}

	public Appraisal(int goal_id, String finalapA, String finalremark) {
		super();
		this.goal_id = goal_id;
		this.finalapA = finalapA;
		this.finalremark = finalremark;
	}

	public Appraisal(String finalap, int goal_id) {
		super();
		this.goal_id = goal_id;
		this.finalap = finalap;
	}

	public Appraisal(int goal_id, int year, String empid, String appr_id, String goal_type, String goal, String measure,
			String target, String mdprogress, String mdprogressA, String mdremark, String mdtrack) {
		super();
		this.goal_id = goal_id;
		this.year = year;
		this.empid = empid;
		this.appr_id = appr_id;
		this.goal_type = goal_type;
		this.goal = goal;
		this.measure = measure;
		this.target = target;
		this.mdprogress = mdprogress;
		this.mdprogressA = mdprogressA;
		this.mdremark = mdremark;
		this.mdtrack = mdtrack;
	}

	// full
	public Appraisal(int goal_id, int year, String empid, String appr_id, String goal_type, String goal, String measure,
			String target, String gs_approved, String gs_apprddate, String gs_approvedid, String mdprogress,
			String mdprogressA, String mdremark, String mdtrack, String mid_approved, String mid_apprddate,
			String mid_approvedid, String finalap, String finalapA, String finalremark, String fin_approved,
			String fin_apprddate, String fin_approvedid) {
		super();
		this.goal_id = goal_id;
		this.year = year;
		this.empid = empid;
		this.appr_id = appr_id;
		this.goal_type = goal_type;
		this.goal = goal;
		this.measure = measure;
		this.target = target;
		this.gs_approved = gs_approved;
		this.gs_apprddate = gs_apprddate;
		this.gs_approvedid = gs_approvedid;
		this.mdprogress = mdprogress;
		this.mdprogressA = mdprogressA;
		this.mdremark = mdremark;
		this.mdtrack = mdtrack;
		this.mid_approved = mid_approved;
		this.mid_apprddate = mid_apprddate;
		this.mid_approvedid = mid_approvedid;
		this.finalap = finalap;
		this.finalapA = finalapA;
		this.finalremark = finalremark;
		this.fin_approved = fin_approved;
		this.fin_apprddate = fin_apprddate;
		this.fin_approvedid = fin_approvedid;
	}

	public Appraisal(int goal_id, String goal, String measure, String target) {
		super();
		this.goal_id = goal_id;
		this.goal = goal;
		this.measure = measure;
		this.target = target;
	}

	public Appraisal(String gs_approved, String gs_apprddate, String gs_approvedid) {
		super();
		this.gs_approved = gs_approved;
		this.gs_apprddate = gs_apprddate;
		this.gs_approvedid = gs_approvedid;
	}

	// mid term self appraisal progress constructor
	public Appraisal(int goal_id, String mdprogress) {
		super();
		this.goal_id = goal_id;
		this.mdprogress = mdprogress;
	}

	public String getUserName() {
		return appr_id;

	}

	public int getGoal_id() {
		return goal_id;
	}

	public String getGoal_type() {
		return goal_type;
	}

	public void setGoal_type(String goal_type) {
		this.goal_type = goal_type;
	}

	public void setGoal_id(int goal_id) {
		this.goal_id = goal_id;
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

	public String getGoal() {
		return goal;
	}

	public void setGoal(String goal) {
		this.goal = goal;
	}

	public String getMeasure() {
		return measure;
	}

	public void setMeasure(String measure) {
		this.measure = measure;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getGs_approved() {
		return gs_approved;
	}

	public void setGs_approved(String gs_approved) {
		this.gs_approved = gs_approved;
	}

	public String getGs_apprddate() {
		return gs_apprddate;
	}

	public void setGs_apprddate(String gs_apprddate) {
		this.gs_apprddate = gs_apprddate;
	}

	public String getGs_approvedid() {
		return gs_approvedid;
	}

	public void setGs_approvedid(String gs_approvedid) {
		this.gs_approvedid = gs_approvedid;
	}

	public String getMdprogress() {
		return mdprogress;
	}

	public void setMdprogress(String mdprogress) {
		this.mdprogress = mdprogress;
	}

	public String getMdprogressA() {
		return mdprogressA;
	}

	public void setMdprogressA(String mdprogressA) {
		this.mdprogressA = mdprogressA;
	}

	public String getMdremark() {
		return mdremark;
	}

	public void setMdremark(String mdremark) {
		this.mdremark = mdremark;
	}

	public String getMdtrack() {
		return mdtrack;
	}

	public void setMdtrack(String mdtrack) {
		this.mdtrack = mdtrack;
	}

	public String getMid_approved() {
		return mid_approved;
	}

	public void setMid_approved(String mid_approved) {
		this.mid_approved = mid_approved;
	}

	public String getMid_apprddate() {
		return mid_apprddate;
	}

	public void setMid_apprddate(String mid_apprddate) {
		this.mid_apprddate = mid_apprddate;
	}

	public String getMid_approvedid() {
		return mid_approvedid;
	}

	public void setMid_approvedid(String mid_approvedid) {
		this.mid_approvedid = mid_approvedid;
	}

	public String getFinalap() {
		return finalap;
	}

	public void setFinalap(String finalap) {
		this.finalap = finalap;
	}

	public String getFinalapA() {
		return finalapA;
	}

	public void setFinalapA(String finalapA) {
		this.finalapA = finalapA;
	}

	public String getFinalremark() {
		return finalremark;
	}

	public void setFinalremark(String finalremark) {
		this.finalremark = finalremark;
	}

	public String getFin_approved() {
		return fin_approved;
	}

	public void setFin_approved(String fin_approved) {
		this.fin_approved = fin_approved;
	}

	public String getFin_apprddate() {
		return fin_apprddate;
	}

	public void setFin_apprddate(String fin_apprddate) {
		this.fin_apprddate = fin_apprddate;
	}

	public String getFin_approvedid() {
		return fin_approvedid;
	}

	public void setFin_approvedid(String fin_approvedid) {
		this.fin_approvedid = fin_approvedid;
	}

}
