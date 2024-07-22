package beans;

public class SengAttendance {
	private String approver_id = null;
	private String sub_ord_id = null;
	private String sub_ord_cmp = null;
	private String sub_ord_name = null;
	private String sub_ord_pos = null;
	private String sub_ord_div = null;
	private String sub_ord_loc = null;
	private String year = "0";

	public String getApprover_id() {
		return approver_id;
	}

	public void setApprover_id(String approver_id) {
		this.approver_id = approver_id;
	}

	public String getSub_ord_id() {
		return sub_ord_id;
	}

	public void setSub_ord_id(String sub_ord_id) {
		this.sub_ord_id = sub_ord_id;
	}

	public String getSub_ord_cmp() {
		return sub_ord_cmp;
	}

	public void setSub_ord_cmp(String sub_ord_cmp) {
		this.sub_ord_cmp = sub_ord_cmp;
	}

	public String getSub_ord_name() {
		return sub_ord_name;
	}

	public void setSub_ord_name(String sub_ord_name) {
		this.sub_ord_name = sub_ord_name;
	}

	public String getSub_ord_pos() {
		return sub_ord_pos;
	}

	public void setSub_ord_pos(String sub_ord_pos) {
		this.sub_ord_pos = sub_ord_pos;
	}

	public String getSub_ord_div() {
		return sub_ord_div;
	}

	public void setSub_ord_div(String sub_ord_div) {
		this.sub_ord_div = sub_ord_div;
	}

	public String getSub_ord_loc() {
		return sub_ord_loc;
	}

	public void setSub_ord_loc(String sub_ord_loc) {
		this.sub_ord_loc = sub_ord_loc;
	}

	public SengAttendance(String sub_ord_id, String sub_ord_cmp, String sub_ord_name, String sub_ord_pos,
			String sub_ord_div, String sub_ord_loc) {

		this.sub_ord_id = sub_ord_id;
		this.sub_ord_cmp = sub_ord_cmp;
		this.sub_ord_name = sub_ord_name;
		this.sub_ord_pos = sub_ord_pos;
		this.sub_ord_div = sub_ord_div;
		this.sub_ord_loc = sub_ord_loc;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public SengAttendance(String year) {
		this.year = year;
	}

}
