package beans;

public class MktSalesLeads {
	private int insertStatus = 0;
	private int lastInsertedRow = 0;
	private String product = null;

	private String se_code = null;
	private String se_name = null;
	private String se_emp_code = null;

	private String id = null;
	private String leadUnfctnCode = null;
	private String type = null;
	private String division = null;
	private String prdct = null;
	private String contractor = null;
	private String consultant = null;
	private String projectDetails = null;
	private String leadRemarks = null;
	private String seEmpCode = null;
	private String seName = null;
	private String createdBy = null;
	private String createdOn = null;
	private String p1Status = null;// status to identify lead created or not , 0 not created, 1 created

	private String ackRemarks = null;// acknowledgment remarks by sales engineer for status p2
	private String p2Status = null;// status to identify sales engineer accepted the lead to work on it or not
	private String acknowledgeOn = null;

	private String soNumber = null;
	private String prjctCode = null;
	private double offerValue = 0;
	private String loi = null;
	private String lpo = null;
	private String seRemarks = null;// sales engineer remarks or comments on update
	private String followupOn = null;
	private String p3Status = null;// status to identify sales engineers follow up done or not , 0 not completed, 1
									// completed

	private String mktRemarks = null;
	private String mktStatus = null;// this status is using for lead is successful/ unsuccessful
	private String mktUpdatedOn = null;
	private String mktUpdatedBy = null;
	private String p4Status = null;

	private String typeCode = null;
	private String processCount = null;
	private String ackDesc = null;// acknowledgment description by sales engineer in process 2
	private String followUpAckDesc = null;// follow up acknledgment by sales engineer in process 3

	private String consultantCode = null;
	private String consultantName = null;
	private String mainContCode = null;
	private String mainContName = null;
	private String mepContCode = null;
	private String mepContName = null;
	private String zone = null;
	private String client = null;
	private String segDivDetails = null;

	private String stage2QtdDivisions = null;
	private String location = null;
	public String getConsultantCode() {
		return consultantCode;
	}

	public void setConsultantCode(String consultantCode) {
		this.consultantCode = consultantCode;
	}

	public String getConsultantName() {
		return consultantName;
	}

	public void setConsultantName(String consultantName) {
		this.consultantName = consultantName;
	}

	public String getMainContCode() {
		return mainContCode;
	}

	public void setMainContCode(String mainContCode) {
		this.mainContCode = mainContCode;
	}

	public String getMainContName() {
		return mainContName;
	}

	public void setMainContName(String mainContName) {
		this.mainContName = mainContName;
	}

	public String getMepContCode() {
		return mepContCode;
	}

	public void setMepContCode(String mepContCode) {
		this.mepContCode = mepContCode;
	}

	public String getMepContName() {
		return mepContName;
	}

	public void setMepContName(String mepContName) {
		this.mepContName = mepContName;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getSegDivDetails() {
		return segDivDetails;
	}

	public void setSegDivDetails(String segDivDetails) {
		this.segDivDetails = segDivDetails;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getSe_code() {
		return se_code;
	}

	public void setSe_code(String se_code) {
		this.se_code = se_code;
	}

	public String getSe_name() {
		return se_name;
	}

	public void setSe_name(String se_name) {
		this.se_name = se_name;
	}

	public String getSe_emp_code() {
		return se_emp_code;
	}

	public void setSe_emp_code(String se_emp_code) {
		this.se_emp_code = se_emp_code;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPrdct() {
		return prdct;
	}

	public void setPrdct(String prdct) {
		this.prdct = prdct;
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

	public String getContractor() {
		return contractor;
	}

	public void setContractor(String contractor) {
		this.contractor = contractor;
	}

	public String getConsultant() {
		return consultant;
	}

	public void setConsultant(String consultant) {
		this.consultant = consultant;
	}

	public String getProjectDetails() {
		return projectDetails;
	}

	public void setProjectDetails(String projectDetails) {
		this.projectDetails = projectDetails;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getP1Status() {
		return p1Status;
	}

	public void setP1Status(String p1Status) {
		this.p1Status = p1Status;
	}

	public String getAckRemarks() {
		return ackRemarks;
	}

	public void setAckRemarks(String ackRemarks) {
		this.ackRemarks = ackRemarks;
	}

	public String getAcknowledgeOn() {
		return acknowledgeOn;
	}

	public void setAcknowledgeOn(String acknowledgeOn) {
		this.acknowledgeOn = acknowledgeOn;
	}

	public String getP2Status() {
		return p2Status;
	}

	public void setP2Status(String p2Status) {
		this.p2Status = p2Status;
	}

	public String getSeRemarks() {
		return seRemarks;
	}

	public void setSeRemarks(String seRemarks) {
		this.seRemarks = seRemarks;
	}

	public String getSoNumber() {
		return soNumber;
	}

	public void setSoNumber(String soNumber) {
		this.soNumber = soNumber;
	}

	public String getPrjctCode() {
		return prjctCode;
	}

	public void setPrjctCode(String prjctCode) {
		this.prjctCode = prjctCode;
	}

	public double getOfferValue() {
		return offerValue;
	}

	public void setOfferValue(double offerValue) {
		this.offerValue = offerValue;
	}

	public String getLpo() {
		return lpo;
	}

	public void setLpo(String lpo) {
		this.lpo = lpo;
	}

	public String getLoi() {
		return loi;
	}

	public void setLoi(String loi) {
		this.loi = loi;
	}

	public String getFollowupOn() {
		return followupOn;
	}

	public void setFollowupOn(String followupOn) {
		this.followupOn = followupOn;
	}

	public String getP3Status() {
		return p3Status;
	}

	public void setP3Status(String p3Status) {
		this.p3Status = p3Status;
	}

	public String getMktRemarks() {
		return mktRemarks;
	}

	public void setMktRemarks(String mktRemarks) {
		this.mktRemarks = mktRemarks;
	}

	public String getMktStatus() {
		return mktStatus;
	}

	public void setMktStatus(String mktStatus) {
		this.mktStatus = mktStatus;
	}

	public String getMktUpdatedOn() {
		return mktUpdatedOn;
	}

	public void setMktUpdatedOn(String mktUpdatedOn) {
		this.mktUpdatedOn = mktUpdatedOn;
	}

	public String getMktUpdatedBy() {
		return mktUpdatedBy;
	}

	public void setMktUpdatedBy(String mktUpdatedBy) {
		this.mktUpdatedBy = mktUpdatedBy;
	}

	public String getP4Status() {
		return p4Status;
	}

	public void setP4Status(String p4Status) {
		this.p4Status = p4Status;
	}

	public String getLeadUnfctnCode() {
		return leadUnfctnCode;
	}

	public void setLeadUnfctnCode(String leadUnfctnCode) {
		this.leadUnfctnCode = leadUnfctnCode;
	}

	public String getLeadRemarks() {
		return leadRemarks;
	}

	public void setLeadRemarks(String leadRemarks) {
		this.leadRemarks = leadRemarks;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getProcessCount() {
		return processCount;
	}

	public void setProcessCount(String processCount) {
		this.processCount = processCount;
	}

	public MktSalesLeads(String product) {
		super();
		// to list product based on division code
		this.product = product;
	}

	public MktSalesLeads(String se_code, String se_name, String se_emp_code) {
		super();
		// All Sales Engineer List
		this.se_code = se_code;
		this.se_name = se_name;
		this.se_emp_code = se_emp_code;
	}

	public MktSalesLeads(String leadUnfctnCode, String type, String division, String prdct, String seEmpCode,
			String seName, String projectDetails, String leadRemarks, String consultant, String contractor,
			String createdBy, String typeCode, String processCount, String stage2QtdDivisions, String prjctCode) {
		super();
		// create new lead by MKt
		this.leadUnfctnCode = leadUnfctnCode;
		this.type = type;
		this.division = division;
		this.prdct = prdct;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.projectDetails = projectDetails;
		this.leadRemarks = leadRemarks;
		this.consultant = consultant;
		this.contractor = contractor;
		this.createdBy = createdBy;
		this.typeCode = typeCode;
		this.processCount = processCount;
		this.stage2QtdDivisions = stage2QtdDivisions;
		this.prjctCode = prjctCode;
	}

	public MktSalesLeads(String id, String leadUnfctnCode, String type, String division, String prdct,
			String contractor, String consultant, String projectDetails, String leadRemarks, String seEmpCode,
			String seName, String createdBy, String createdOn, String p1Status, String ackRemarks, String p2Status,
			String acknowledgeOn, String soNumber, String prjctCode, double offerValue, String loi, String lpo,
			String seRemarks, String followupOn, String p3Status, String mktRemarks, String mktStatus,
			String mktUpdatedOn, String mktUpdatedBy, String p4Status, String typeCode, String processCount,
			String ackDesc, String followUpAckDesc, String stage2QtdDivisions, String location) {
		super();
		// get All Lead Details
		this.id = id;
		this.leadUnfctnCode = leadUnfctnCode;
		this.type = type;
		this.division = division;
		this.prdct = prdct;
		this.contractor = contractor;
		this.consultant = consultant;
		this.projectDetails = projectDetails;
		this.leadRemarks = leadRemarks;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.createdBy = createdBy;
		this.createdOn = createdOn;
		this.p1Status = p1Status;
		this.ackRemarks = ackRemarks;
		this.p2Status = p2Status;
		this.acknowledgeOn = acknowledgeOn;
		this.soNumber = soNumber;
		this.prjctCode = prjctCode;
		this.offerValue = offerValue;
		this.loi = loi;
		this.lpo = lpo;
		this.followupOn = lpo;
		this.seRemarks = seRemarks;
		this.followupOn = followupOn;
		this.p3Status = p3Status;
		this.mktRemarks = mktRemarks;
		this.mktStatus = mktStatus;
		this.mktUpdatedOn = mktUpdatedOn;
		this.mktUpdatedBy = mktUpdatedBy;
		this.p4Status = p4Status;
		this.typeCode = typeCode;
		this.processCount = processCount;
		this.ackDesc = ackDesc;
		this.followUpAckDesc = followUpAckDesc;
		this.stage2QtdDivisions = stage2QtdDivisions;
		this.location = location;
	}

	public MktSalesLeads(String id, String leadUnfctnCode, String ackRemarks, String p2Status, String seEmpCode,
			String seName) {
		super();
		// update constructor for sales engineer acknowledgment
		this.id = id;
		this.leadUnfctnCode = leadUnfctnCode;
		this.ackRemarks = ackRemarks;
		this.p2Status = p2Status;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
	}

	public MktSalesLeads(String id, String leadUnfctnCode, String soNumber, String prjctCode, double offerValue,
			String loi, String lpo, String seRemarks, String p3Status, String seEmpCode, String seName,
			String followUpAckDesc) {
		super();
		// update constructor for sales engineer update/folloup
		this.id = id;
		this.leadUnfctnCode = leadUnfctnCode;
		this.soNumber = soNumber;
		this.prjctCode = prjctCode;
		this.offerValue = offerValue;
		this.loi = loi;
		this.lpo = lpo;
		this.seRemarks = seRemarks;
		this.p3Status = p3Status;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.followUpAckDesc = followUpAckDesc;
	}

	public MktSalesLeads(String id, String leadUnfctnCode, String seEmpCode, String seName, String mktRemarks,
			String mktStatus, String mktUpdatedBy) {
		super();
		// close lead constructor for marketing team for close lead
		this.id = id;
		this.leadUnfctnCode = leadUnfctnCode;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.mktRemarks = mktRemarks;
		this.mktStatus = mktStatus;
		this.mktUpdatedBy = mktUpdatedBy;
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

	public MktSalesLeads(int insertStatus, int lastInsertedRow) {
		super();
		// to get latst primary key auto incriment number and inserted status
		this.insertStatus = insertStatus;
		this.lastInsertedRow = lastInsertedRow;
	}

	public String getAckDesc() {
		return ackDesc;
	}

	public void setAckDesc(String ackDesc) {
		this.ackDesc = ackDesc;
	}

	public String getFollowUpAckDesc() {
		return followUpAckDesc;
	}

	public void setFollowUpAckDesc(String followUpAckDesc) {
		this.followUpAckDesc = followUpAckDesc;
	}

	public MktSalesLeads(String prjctCode, String projectDetails, String consultantCode, String consultantName,
			String mainContCode, String mainContName, String mepContCode, String mepContName, String zone,
			String client, String segDivDetails) {
		super();
		this.prjctCode = prjctCode;
		this.projectDetails = projectDetails;
		this.consultantCode = consultantCode;
		this.consultantName = consultantName;
		this.mainContCode = mainContCode;
		this.mainContName = mainContName;
		this.mepContCode = mepContCode;
		this.mepContName = mepContName;
		this.zone = zone;
		this.client = client;
		this.segDivDetails = segDivDetails;
	}

	public String getStage2QtdDivisions() {
		return stage2QtdDivisions;
	}

	public void setStage2QtdDivisions(String stage2QtdDivisions) {
		this.stage2QtdDivisions = stage2QtdDivisions;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

}
