package beans;

public class LogisticDelivery {

	private int userPermission = 0;
	
	
	private String id = null;
	private String txnCode = null;
	private String invcNumber = null;
	private String invcDate = null;
	private String customerCode = null;
	private String customername = null;
	private String project = null;
	private String paymentTerms = null;
	private String paymentStatus = null;
	private String contactName = null;
	private String contactNumber = null;
	private String siteLocation = null;
	private String expectedDeliveryDate = null;
	private String numberOfvehicleRequired = null;
	private String divnRemarks = null;
	private String divnUpdatedBy = null;
	private String divnEmpName = null;
	private String divnUpdatedDate = null; 
	
	private String finStatus = null; 
	private String finRemarks = null;
	private String finUpdatedBy = null;
	private String finEmpName = null;
	private String finUpdatedDate = null;
	
	private String logisticApproved = null;
	private String logisticRemark = null;
	private String logisticUpdBy = null;
	private String logEmpName = null;
	private String logisticUpdDate = null;
	
	
	//for remarks txn
	private String remarks_id = null;
	private String invc_id = null;
	private String remarks = null;
	private String remarks_crtd_by = null;
	private String remarks_crtd_on = null;
	private String rem_action_by = null; 
	
	public int getUserPermission() {
		return userPermission;
	}
	public void setUserPermission(int userPermission) {
		this.userPermission = userPermission;
	}
	public String getTxnCode() {
		return txnCode;
	}
	public void setTxnCode(String txnCode) {
		this.txnCode = txnCode;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	

	
	
	public String getInvcNumber() {
		return invcNumber;
	}
	public void setInvcNumber(String invcNumber) {
		this.invcNumber = invcNumber;
	}
	public String getInvcDate() {
		return invcDate;
	}
	public void setInvcDate(String invcDate) {
		this.invcDate = invcDate;
	}
	public String getCustomerCode() {
		return customerCode;
	}
	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}
	public String getCustomername() {
		return customername;
	}
	public void setCustomername(String customername) {
		this.customername = customername;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getPaymentTerms() {
		return paymentTerms;
	}
	public void setPaymentTerms(String paymentTerms) {
		this.paymentTerms = paymentTerms;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getSiteLocation() {
		return siteLocation;
	}
	public void setSiteLocation(String siteLocation) {
		this.siteLocation = siteLocation;
	}
	public String getExpectedDeliveryDate() {
		return expectedDeliveryDate;
	}
	public void setExpectedDeliveryDate(String expectedDeliveryDate) {
		this.expectedDeliveryDate = expectedDeliveryDate;
	}
	public String getNumberOfvehicleRequired() {
		return numberOfvehicleRequired;
	}
	public void setNumberOfvehicleRequired(String numberOfvehicleRequired) {
		this.numberOfvehicleRequired = numberOfvehicleRequired;
	}
	public String getDivnRemarks() {
		return divnRemarks;
	}
	public void setDivnRemarks(String divnRemarks) {
		this.divnRemarks = divnRemarks;
	}
	public String getDivnUpdatedBy() {
		return divnUpdatedBy;
	}
	public void setDivnUpdatedBy(String divnUpdatedBy) {
		this.divnUpdatedBy = divnUpdatedBy;
	}
	public String getDivnEmpName() {
		return divnEmpName;
	}
	public void setDivnEmpName(String divnEmpName) {
		this.divnEmpName = divnEmpName;
	}
	public String getDivnUpdatedDate() {
		return divnUpdatedDate;
	}
	public void setDivnUpdatedDate(String divnUpdatedDate) {
		this.divnUpdatedDate = divnUpdatedDate;
	}
	public String getFinStatus() {
		return finStatus;
	}
	public void setFinStatus(String finStatus) {
		this.finStatus = finStatus;
	}
	public String getFinRemarks() {
		return finRemarks;
	}
	public void setFinRemarks(String finRemarks) {
		this.finRemarks = finRemarks;
	}
	public String getFinUpdatedBy() {
		return finUpdatedBy;
	}
	public void setFinUpdatedBy(String finUpdatedBy) {
		this.finUpdatedBy = finUpdatedBy;
	}
	public String getFinEmpName() {
		return finEmpName;
	}
	public void setFinEmpName(String finEmpName) {
		this.finEmpName = finEmpName;
	}
	public String getFinUpdatedDate() {
		return finUpdatedDate;
	}
	public void setFinUpdatedDate(String finUpdatedDate) {
		this.finUpdatedDate = finUpdatedDate;
	}
	public String getLogisticApproved() {
		return logisticApproved;
	}
	public void setLogisticApproved(String logisticApproved) {
		this.logisticApproved = logisticApproved;
	}
	public String getLogisticRemark() {
		return logisticRemark;
	}
	public void setLogisticRemark(String logisticRemark) {
		this.logisticRemark = logisticRemark;
	}
	public String getLogisticUpdBy() {
		return logisticUpdBy;
	}
	public void setLogisticUpdBy(String logisticUpdBy) {
		this.logisticUpdBy = logisticUpdBy;
	}
	public String getLogEmpName() {
		return logEmpName;
	}
	public void setLogEmpName(String logEmpName) {
		this.logEmpName = logEmpName;
	}
	public String getLogisticUpdDate() {
		return logisticUpdDate;
	}
	public void setLogisticUpdDate(String logisticUpdDate) {
		this.logisticUpdDate = logisticUpdDate;
	}
	
	
	
	public String getRemarks_id() {
		return remarks_id;
	}
	public void setRemarks_id(String remarks_id) {
		this.remarks_id = remarks_id;
	}
	public String getInvc_id() {
		return invc_id;
	}
	public void setInvc_id(String invc_id) {
		this.invc_id = invc_id;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	 
	public LogisticDelivery(String id, String txnCode, String invcNumber, String invcDate, String customerCode,
			String customername, String project, String paymentTerms, String paymentStatus, String contactName,
			String contactNumber, String siteLocation, String expectedDeliveryDate, String numberOfvehicleRequired,
			String divnRemarks, String divnUpdatedBy, String divnEmpName, String divnUpdatedDate, String finStatus,
			String finRemarks, String finUpdatedBy, String finEmpName, String finUpdatedDate, String logisticApproved,
			String logisticRemark, String logisticUpdBy, String logEmpName, String logisticUpdDate) { 
		// get all invoice dlvry details
		super();
		this.id = id;
		this.txnCode = txnCode;
		this.invcNumber = invcNumber;
		this.invcDate = invcDate;
		this.customerCode = customerCode;
		this.customername = customername;
		this.project = project;
		this.paymentTerms = paymentTerms;
		this.paymentStatus = paymentStatus;
		this.contactName = contactName;
		this.contactNumber = contactNumber;
		this.siteLocation = siteLocation;
		this.expectedDeliveryDate = expectedDeliveryDate;
		this.numberOfvehicleRequired = numberOfvehicleRequired;
		this.divnRemarks = divnRemarks;
		this.divnUpdatedBy = divnUpdatedBy;
		this.divnEmpName = divnEmpName;
		this.divnUpdatedDate = divnUpdatedDate;
		this.finStatus = finStatus;
		this.finRemarks = finRemarks;
		this.finUpdatedBy = finUpdatedBy;
		this.finEmpName = finEmpName;
		this.finUpdatedDate = finUpdatedDate;
		this.logisticApproved = logisticApproved;
		this.logisticRemark = logisticRemark;
		this.logisticUpdBy = logisticUpdBy;
		this.logEmpName = logEmpName;
		this.logisticUpdDate = logisticUpdDate;
	}
	 
	public LogisticDelivery(int userPermission, String txnCode) {
		// to check user permission for lg dashbaord
		super();
		this.userPermission = userPermission;
		this.txnCode = txnCode;
	}
	
	public LogisticDelivery(String id, String paymentTerms, String paymentStatus, String contactName, String contactNumber,
			String siteLocation, String expectedDeliveryDate, String numberOfvehicleRequired, String divnRemarks, String divnUpdatedBy, String divnEmpName, String invcNumber) {
		super();
		// division updation
		this.id = id;
		this.paymentTerms = paymentTerms;
		this.paymentStatus = paymentStatus;
		this.contactName = contactName;
		this.contactNumber = contactNumber;
		this.siteLocation = siteLocation;
		this.expectedDeliveryDate = expectedDeliveryDate;
		this.numberOfvehicleRequired = numberOfvehicleRequired;
		this.divnRemarks = divnRemarks;
		this.divnUpdatedBy = divnUpdatedBy;
		this.divnEmpName = divnEmpName;  
		this.invcNumber = invcNumber;
		
		
	}
	 
	
	public LogisticDelivery(String id, String finStatus, String finRemarks, String finUpdatedBy, String finEmpName, String invcNumber, String contactName, String contactNumber, String siteLocation, String expectedDeliveryDate, String numberOfvehicleRequired) {
		super();
		// finance updates
		this.id = id;
		this.finStatus = finStatus;
		this.finRemarks = finRemarks;
		this.finUpdatedBy = finUpdatedBy;
		this.finEmpName = finEmpName;
		this.invcNumber = invcNumber;
		this.contactName = contactName;
		this.contactNumber = contactNumber;
		this.siteLocation = siteLocation;
		this.expectedDeliveryDate = expectedDeliveryDate;
		this.numberOfvehicleRequired = numberOfvehicleRequired;
	}
	
	
	public LogisticDelivery(String divnEmpName, int flag, String id,  String logisticApproved,  String logisticRemark, String logisticUpdBy,
			String logEmpName,  String invcNumber, String divnUpdatedBy) {
		super();
		// logistic updates
		this.id = id;
		this.logisticApproved = logisticApproved;
		this.logisticRemark = logisticRemark;
		this.logisticUpdBy = logisticUpdBy;
		this.logEmpName = logEmpName;
		this.invcNumber = invcNumber;
		this.divnEmpName = divnEmpName;
		this.divnUpdatedBy = divnUpdatedBy;
	}
//remarks section	
	public String getRemarks_crtd_by() {
		return remarks_crtd_by;
	}
	public void setRemarks_crtd_by(String remarks_crtd_by) {
		this.remarks_crtd_by = remarks_crtd_by;
	}
	public String getRemarks_crtd_on() {
		return remarks_crtd_on;
	}
	public void setRemarks_crtd_on(String remarks_crtd_on) {
		this.remarks_crtd_on = remarks_crtd_on;
	}
	public String getRem_action_by() {
		return rem_action_by;
	}
	public void setRem_action_by(String rem_action_by) {
		this.rem_action_by = rem_action_by;
	}

	public LogisticDelivery(String remarks_id, String invc_id, String remarks, String remarks_crtd_by,
			String remarks_crtd_on, String rem_action_by) {
		super();
		this.remarks_id = remarks_id;
		this.invc_id = invc_id;
		this.remarks = remarks;
		this.remarks_crtd_by = remarks_crtd_by;
		this.remarks_crtd_on = remarks_crtd_on;
		this.rem_action_by = rem_action_by; 
	}
	 
	
	
	
}
