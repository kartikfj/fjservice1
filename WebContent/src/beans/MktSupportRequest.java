package beans;

import java.util.List;

public class MktSupportRequest {
	private int insertStatus = 0;
	private int lastInsertedRow = 0;

	private String id = null;
	private String type = null;
	private String division = null;
	private String product = null;
	private String consultant = null;
	private String contractor = null;
	private double offerValue = 0;
	private String projectDetails = null;
	private String initialReamrks = null;
	private String seEmpCode = null;
	private String seName = null;
	private String requestedOn = null;
	private String p1Status = null;

	private String support_accept_remarks = null;
	private String p2Status = null;// request support status 0 (pending), 1 (accepted, 2 (rejected) // accept and
									// intiated or declined
	private String support_accept_by = null;
	private String support_accept_on = null;

	private String mkt_acted_on = null;
	private String mkt_remarks = null;
	private String mkt_followup_by = null;
	private String p3Status = null;

	private String se_remarks = null;
	private String p4Status = null;
	private String se_followup_on = null;

	private List<String> followupRemarks = null;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getConsultant() {
		return consultant;
	}

	public void setConsultant(String consultant) {
		this.consultant = consultant;
	}

	public String getContractor() {
		return contractor;
	}

	public void setContractor(String contractor) {
		this.contractor = contractor;
	}

	public double getOfferValue() {
		return offerValue;
	}

	public void setOfferValue(double offerValue) {
		this.offerValue = offerValue;
	}

	public String getProjectDetails() {
		return projectDetails;
	}

	public void setProjectDetails(String projectDetails) {
		this.projectDetails = projectDetails;
	}

	public String getSeEmpCode() {
		return seEmpCode;
	}

	public void setSeEmpCode(String seEmpCode) {
		this.seEmpCode = seEmpCode;
	}

	public String getSeName() {
		return seName;
	}

	public void setSeName(String seName) {
		this.seName = seName;
	}

	public String getRequestedOn() {
		return requestedOn;
	}

	public void setRequestedOn(String requestedOn) {
		this.requestedOn = requestedOn;
	}

	public String getP1Status() {
		return p1Status;
	}

	public void setP1Status(String p1Status) {
		this.p1Status = p1Status;
	}

	public String getP2Status() {
		return p2Status;
	}

	public void setP2Status(String p2Status) {
		this.p2Status = p2Status;
	}

	public String getSupport_accept_by() {
		return support_accept_by;
	}

	public void setSupport_accept_by(String support_accept_by) {
		this.support_accept_by = support_accept_by;
	}

	public String getSupport_accept_on() {
		return support_accept_on;
	}

	public void setSupport_accept_on(String support_accept_on) {
		this.support_accept_on = support_accept_on;
	}

	public String getMkt_acted_on() {
		return mkt_acted_on;
	}

	public void setMkt_acted_on(String mkt_acted_on) {
		this.mkt_acted_on = mkt_acted_on;
	}

	public String getMkt_remarks() {
		return mkt_remarks;
	}

	public void setMkt_remarks(String mkt_remarks) {
		this.mkt_remarks = mkt_remarks;
	}

	public String getMkt_followup_by() {
		return mkt_followup_by;
	}

	public void setMkt_followup_by(String mkt_followup_by) {
		this.mkt_followup_by = mkt_followup_by;
	}

	public String getP3Status() {
		return p3Status;
	}

	public void setP3Status(String p3Status) {
		this.p3Status = p3Status;
	}

	public String getSe_remarks() {
		return se_remarks;
	}

	public void setSe_remarks(String se_remarks) {
		this.se_remarks = se_remarks;
	}

	public String getP4Status() {
		return p4Status;
	}

	public void setP4Status(String p4Status) {
		this.p4Status = p4Status;
	}

	public String getSe_followup_on() {
		return se_followup_on;
	}

	public void setSe_followup_on(String se_followup_on) {
		this.se_followup_on = se_followup_on;
	}

	public List<String> getFollowupRemarks() {
		return followupRemarks;
	}

	public void setFollowupRemarks(List<String> followupRemarks) {
		this.followupRemarks = followupRemarks;
	}

	public MktSupportRequest(String type, String division, String product, String consultant, String contractor,
			double offerValue, String projectDetails, String initialReamrks, String seEmpCode, String seName) {
		super();
		// create new suppport request by sales engineer
		this.type = type;
		this.division = division;
		this.product = product;
		this.consultant = consultant;
		this.contractor = contractor;
		this.offerValue = offerValue;
		this.projectDetails = projectDetails;
		this.initialReamrks = initialReamrks;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
	}

	public MktSupportRequest(String id, String type, String division, String product, String consultant,
			String contractor, double offerValue, String projectDetails, String initialReamrks, String seEmpCode,
			String seName, String requestedOn, String p1Status, String support_accept_remarks, String p2Status,
			String support_accept_by, String support_accept_on, String mkt_remarks, String mkt_followup_by,
			String mkt_acted_on, String p3Status, String se_remarks, String se_followup_on, String p4Status) {
		super();
		// get all support requests
		this.id = id;
		this.type = type;
		this.division = division;
		this.product = product;
		this.consultant = consultant;
		this.contractor = contractor;
		this.offerValue = offerValue;
		this.projectDetails = projectDetails;
		this.initialReamrks = initialReamrks;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.requestedOn = requestedOn;
		this.support_accept_remarks = support_accept_remarks;
		this.p1Status = p1Status;
		this.p2Status = p2Status;
		this.support_accept_by = support_accept_by;
		this.support_accept_on = support_accept_on;
		this.mkt_acted_on = mkt_acted_on;
		this.mkt_remarks = mkt_remarks;
		this.mkt_followup_by = mkt_followup_by;
		this.p3Status = p3Status;
		this.se_remarks = se_remarks;
		this.p4Status = p4Status;
		this.se_followup_on = se_followup_on;
	}

	public MktSupportRequest(String id, String type, String p2Status, String support_accept_by,
			String support_accept_remarks) {
		super();
		// support request handling constructor -- process -2
		this.id = id;
		this.type = type;
		this.p2Status = p2Status;
		this.support_accept_by = support_accept_by;
		this.support_accept_remarks = support_accept_remarks;
	}

	public MktSupportRequest(String id, String type, String mkt_remarks) {
		super();
		// process 3 by marketing team if mkt accepted the rquest that is p2 status is 1
		this.id = id;
		this.type = type;
		this.mkt_remarks = mkt_remarks;
	}

	public MktSupportRequest(String id, String se_remarks) {
		super();
		// process 4 for sales engineer if mkt asscepted the rquest that is p2 status =
		// 1 and p3 status = 1
		this.id = id;
		this.se_remarks = se_remarks;
	}

	public int getLastInsertedRow() {
		return lastInsertedRow;
	}

	public void setLastInsertedRow(int lastInsertedRow) {
		this.lastInsertedRow = lastInsertedRow;
	}

	public int getInsertStatus() {
		return insertStatus;
	}

	public void setInsertStatus(int insertStatus) {
		this.insertStatus = insertStatus;
	}

	public MktSupportRequest(int insertStatus, int lastInsertedRow) {
		super();
		// to get latst primary key auto incriment number and inserted status
		this.insertStatus = insertStatus;
		this.lastInsertedRow = lastInsertedRow;
	}

	public String getInitialReamrks() {
		return initialReamrks;
	}

	public void setInitialReamrks(String initialReamrks) {
		this.initialReamrks = initialReamrks;
	}

	public String getSupport_accept_remarks() {
		return support_accept_remarks;
	}

	public void setSupport_accept_remarks(String support_accept_remarks) {
		this.support_accept_remarks = support_accept_remarks;
	}

	public MktSupportRequest(String id, String type, String division, String product, String consultant,
			String contractor, double offerValue, String projectDetails, String initialReamrks, String seEmpCode,
			String seName, String requestedOn, String p1Status, String support_accept_remarks, String p2Status,
			String support_accept_by, String support_accept_on, String mkt_remarks, String mkt_followup_by,
			String mkt_acted_on, String p3Status, String se_remarks, String se_followup_on, String p4Status,
			List<String> followupRemarks) {
		super();
		// get all support requests
		this.id = id;
		this.type = type;
		this.division = division;
		this.product = product;
		this.consultant = consultant;
		this.contractor = contractor;
		this.offerValue = offerValue;
		this.projectDetails = projectDetails;
		this.initialReamrks = initialReamrks;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.requestedOn = requestedOn;
		this.support_accept_remarks = support_accept_remarks;
		this.p1Status = p1Status;
		this.p2Status = p2Status;
		this.support_accept_by = support_accept_by;
		this.support_accept_on = support_accept_on;
		this.mkt_acted_on = mkt_acted_on;
		this.mkt_remarks = mkt_remarks;
		this.mkt_followup_by = mkt_followup_by;
		this.p3Status = p3Status;
		this.se_remarks = se_remarks;
		this.p4Status = p4Status;
		this.se_followup_on = se_followup_on;
		this.followupRemarks = followupRemarks;
	}
}
