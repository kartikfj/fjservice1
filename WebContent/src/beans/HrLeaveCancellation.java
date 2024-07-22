package beans;

public class HrLeaveCancellation {

	private String uid = null;
	private String type = null;
	private String applied_dt = null;
	private String fromDate = null;
	private String toDate = null;
	private String reason = null;
	private String leave_days = null;

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getApplied_dt() {
		return applied_dt;
	}

	public void setApplied_dt(String applied_dt) {
		this.applied_dt = applied_dt;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getLeave_days() {
		return leave_days;
	}

	public void setLeave_days(String leave_days) {
		this.leave_days = leave_days;
	}

	public HrLeaveCancellation(String uid, String type, String applied_dt, String fromDate, String toDate,
			String reason, String leave_days) {
		super();
		this.uid = uid;
		this.type = type;
		this.applied_dt = applied_dt;
		this.fromDate = fromDate;
		this.toDate = toDate;
		this.reason = reason;
		this.leave_days = leave_days;
	}

	public HrLeaveCancellation(String uid, String type, String reason, String fromDate, String toDate) {
		super();
		this.uid = uid;
		this.type = type;
		this.reason = reason;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}

}
