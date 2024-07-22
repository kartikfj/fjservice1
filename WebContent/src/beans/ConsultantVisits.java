package beans;

import java.sql.Date;

public class ConsultantVisits {

	private String cnslt_id = null;
	private String conslt_name = null;// consultant_name
	private Date date = null; // product
	private String visit_reason = null; // status
	private int noofattendees; // division
	private String meeting_notes = null;// remarks
	private String meetingperson_details = null;// created year
	private String employee_Code = null;
	private String division = null;
	private String product = null;
	private String consultantType = null;

	public String getCnslt_id() {
		return cnslt_id;
	}

	public void setCnslt_id(String cnslt_id) {
		this.cnslt_id = cnslt_id;
	}

	public String getConslt_name() {
		return conslt_name;
	}

	public void setConslt_name(String conslt_name) {
		this.conslt_name = conslt_name;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getVisit_reason() {
		return visit_reason;
	}

	public void setVisit_reason(String visit_reason) {
		this.visit_reason = visit_reason;
	}

	public int getNoofattendees() {
		return noofattendees;
	}

	public void setNoofattendees(int noofattendees) {
		this.noofattendees = noofattendees;
	}

	public String getMeeting_notes() {
		return meeting_notes;
	}

	public void setMeeting_notes(String meeting_notes) {
		this.meeting_notes = meeting_notes;
	}

	public String getMeetingperson_details() {
		return meetingperson_details;
	}

	public void setMeetingperson_details(String meetingperson_details) {
		this.meetingperson_details = meetingperson_details;
	}

	public String getEmployee_Code() {
		return employee_Code;
	}

	public void setEmployee_Code(String employee_Code) {
		this.employee_Code = employee_Code;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getConsultantType() {
		return consultantType;
	}

	public void setConsultantType(String consultantType) {
		this.consultantType = consultantType;
	}

	public ConsultantVisits(String conslt_name, String visit_reason, Date date, int noofattendees,
			String meetingperson_details, String meeting_notes, String empcode, String division, String product) {
		this.conslt_name = conslt_name;
		this.date = date;
		this.visit_reason = visit_reason;
		this.noofattendees = noofattendees;
		this.meetingperson_details = meetingperson_details;
		this.meeting_notes = meeting_notes;
		this.employee_Code = empcode;
		this.division = division;
		this.product = product;
	}

	public ConsultantVisits(String conslt_name, String visit_reason, Date date, int noofattendees,
			String meetingperson_details, String meeting_notes) {
		this.conslt_name = conslt_name;
		this.date = date;
		this.visit_reason = visit_reason;
		this.noofattendees = noofattendees;
		this.meetingperson_details = meetingperson_details;
		this.meeting_notes = meeting_notes;
	}

	public ConsultantVisits(String conslt_name, String visit_reason, Date date, int noofattendees,
			String meetingperson_details, String meeting_notes, String empcode, String division, String product,
			String consultantType) {
		this.conslt_name = conslt_name;
		this.date = date;
		this.visit_reason = visit_reason;
		this.noofattendees = noofattendees;
		this.meetingperson_details = meetingperson_details;
		this.meeting_notes = meeting_notes;
		this.employee_Code = empcode;
		this.division = division;
		this.product = product;
		this.consultantType = consultantType;
	}
}
