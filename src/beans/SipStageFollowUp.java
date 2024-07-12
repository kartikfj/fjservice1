package beans;

public class SipStageFollowUp {
	private String status = null;
	private String priority = null;
	private String filter = null;
	private int stage = 0;

	private String cqhSysId = null;
	private String seCode = null;
	private String seName = null;
	private String qtnDt = null;
	private String qtnCode = null;
	private String qtnNo = null;
	private String custName = null;
	private String projectName = null;
	private String consultant = null;
	private String amount = null;
	private String remarks = null;
	private String updatedOn = null;
	private String updatedBy = null;

	private String deliveryDate = null;
	private String itemCode = null;
	private String itemDesc = null;
	private String soUom = null;
	private String balanceQty = null;
	private String materialStatus = null;
	private String paymentStatus = null;
	private String readynessStatus = null;
	private String billStatus = null;
	private String itemId = null;
	private String type = null;

	private String style = null;

	private String poDate = null;
	private String invoiceDate = null;
	private int reminderCount = 0;

	private int consultWin = 0;
	private int contractorWin = 0;
	private int totalWin = 0;
	private double qtnAmount;
	private String expLOIDate = null;
	private String sewinper = null;

	private String submittalcode = null;
	private String submittalRemarks = null;

	private String isApproved = null;

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public int getStage() {
		return stage;
	}

	public void setStage(int stage) {
		this.stage = stage;
	}

	public String getCqhSysId() {
		return cqhSysId;
	}

	public void setCqhSysId(String cqhSysId) {
		this.cqhSysId = cqhSysId;
	}

	public String getSeCode() {
		return seCode;
	}

	public void setSeCode(String seCode) {
		this.seCode = seCode;
	}

	public String getSeName() {
		return seName;
	}

	public void setSeName(String seName) {
		this.seName = seName;
	}

	public String getQtnDt() {
		return qtnDt;
	}

	public void setQtnDt(String qtnDt) {
		this.qtnDt = qtnDt;
	}

	public String getQtnCode() {
		return qtnCode;
	}

	public void setQtnCode(String qtnCode) {
		this.qtnCode = qtnCode;
	}

	public String getQtnNo() {
		return qtnNo;
	}

	public void setQtnNo(String qtnNo) {
		this.qtnNo = qtnNo;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getConsultant() {
		return consultant;
	}

	public void setConsultant(String consultant) {
		this.consultant = consultant;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(String updatedOn) {
		this.updatedOn = updatedOn;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public String getFilter() {
		return filter;
	}

	public void setFilter(String filter) {
		this.filter = filter;
	}

	public String getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getSoUom() {
		return soUom;
	}

	public void setSoUom(String soUom) {
		this.soUom = soUom;
	}

	public String getBalanceQty() {
		return balanceQty;
	}

	public void setBalanceQty(String balanceQty) {
		this.balanceQty = balanceQty;
	}

	public String getMaterialStatus() {
		return materialStatus;
	}

	public void setMaterialStatus(String materialStatus) {
		this.materialStatus = materialStatus;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getReadynessStatus() {
		return readynessStatus;
	}

	public void setReadynessStatus(String readynessStatus) {
		this.readynessStatus = readynessStatus;
	}

	public String getBillStatus() {
		return billStatus;
	}

	public void setBillStatus(String billStatus) {
		this.billStatus = billStatus;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getPoDate() {
		return poDate;
	}

	public void setPoDate(String poDate) {
		this.poDate = poDate;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public int getReminderCount() {
		return reminderCount;
	}

	public void setReminderCount(int reminderCount) {
		this.reminderCount = reminderCount;
	}

	public int getConsultWin() {
		return consultWin;
	}

	public void setConsultWin(int consultWin) {
		this.consultWin = consultWin;
	}

	public int getContractorWin() {
		return contractorWin;
	}

	public void setContractorWin(int contractorWin) {
		this.contractorWin = contractorWin;
	}

	public int getTotalWin() {
		return totalWin;
	}

	public void setTotalWin(int totalWin) {
		this.totalWin = totalWin;
	}

	public double getQtnAmount() {
		return qtnAmount;
	}

	public void setQtnAmount(double qtnAmount) {
		this.qtnAmount = qtnAmount;
	}

	public String getExpLOIDate() {
		return expLOIDate;
	}

	public void setExpLOIDate(String expLOIDate) {
		this.expLOIDate = expLOIDate;
	}

	public String getSewinper() {
		return sewinper;
	}

	public void setSewinper(String sewinper) {
		this.sewinper = sewinper;
	}

	public String getSubmittalcode() {
		return submittalcode;
	}

	public void setSubmittalcode(String submittalcode) {
		this.submittalcode = submittalcode;
	}

	public String getSubmittalRemarks() {
		return submittalRemarks;
	}

	public void setSubmittalRemarks(String submittalRemarks) {
		this.submittalRemarks = submittalRemarks;
	}

	public String getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}

	public SipStageFollowUp(String status, int stage) {
		super();
		this.status = status;
		this.stage = stage;
	}

	public SipStageFollowUp(String status, int stage, String filter, String style) {
		super();
		this.status = status;
		this.stage = stage;
		this.filter = filter;
		this.style = style;
	}

	public SipStageFollowUp(int stage, String priority) {
		super();
		this.stage = stage;
		this.priority = priority;
	}

	public SipStageFollowUp(String cqhSysId, String seCode, String seName, String qtnDt, String qtnCode, String qtnNo,
			String custName, String projectName, String consultant, String amount, String priority, String status,
			String remarks, String updatedBy, String updatedOn) {
		super();
		this.cqhSysId = cqhSysId;
		this.seCode = seCode;
		this.seName = seName;
		this.qtnDt = qtnDt;
		this.qtnCode = qtnCode;
		this.qtnNo = qtnNo;
		this.custName = custName;
		this.projectName = projectName;
		this.consultant = consultant;
		this.amount = amount;
		this.priority = priority;
		this.status = status;
		this.remarks = remarks;
		this.updatedBy = updatedBy;
		this.updatedOn = updatedOn;
	}

	public SipStageFollowUp(String cqhSysId, String seCode, String seName, String qtnDt, String qtnCode, String qtnNo,
			String custName, String projectName, String consultant, String amount, String deliveryDate, String itemCode,
			String itemDesc, String soUom, String balanceQty, String materialStatus, String paymentStatus,
			String readynessStatus, String billStatus, String updatedBy, String updatedOn, String itemId, String type,
			int reminderCount, String expBiilingDate) {
		super();
		this.cqhSysId = cqhSysId;
		this.seCode = seCode;
		this.seName = seName;
		this.qtnDt = qtnDt;
		this.qtnCode = qtnCode;
		this.qtnNo = qtnNo;
		this.custName = custName;
		this.projectName = projectName;
		this.consultant = consultant;
		this.amount = amount;
		this.deliveryDate = deliveryDate;
		this.itemCode = itemCode;
		this.itemDesc = itemDesc;
		this.soUom = soUom;
		this.balanceQty = balanceQty;
		this.materialStatus = materialStatus;
		this.paymentStatus = paymentStatus;
		this.readynessStatus = readynessStatus;
		this.billStatus = billStatus;
		this.updatedOn = updatedOn;
		this.updatedBy = updatedBy;
		this.itemId = itemId;
		this.type = type;
		this.reminderCount = reminderCount;
		this.expLOIDate = expBiilingDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public SipStageFollowUp(String itemId, String materialStatus, String paymentStatus, String readynessStatus,
			String deliveryDate) {
		super();
		this.itemId = itemId;
		this.materialStatus = materialStatus;
		this.paymentStatus = paymentStatus;
		this.readynessStatus = readynessStatus;
		this.deliveryDate = deliveryDate;
	}

	public SipStageFollowUp(String cqhSysId, String seCode, String seName, String qtnDt, String qtnCode, String qtnNo,
			String custName, String projectName, String consultant, double amount, String priority, String status,
			String remarks, String updatedBy, String updatedOn, String poDate, String invoiceDate, int reminderCount,
			int consltWin, int contractorWin, int totalWin, String expLOIDate, String sewinper) {
		super();
		this.cqhSysId = cqhSysId;
		this.seCode = seCode;
		this.seName = seName;
		this.qtnDt = qtnDt;
		this.qtnCode = qtnCode;
		this.qtnNo = qtnNo;
		this.custName = custName;
		this.projectName = projectName;
		this.consultant = consultant;
		this.qtnAmount = amount;
		this.priority = priority;
		this.status = status;
		this.remarks = remarks;
		this.updatedBy = updatedBy;
		this.updatedOn = updatedOn;
		this.poDate = poDate;
		this.invoiceDate = invoiceDate;
		this.reminderCount = reminderCount;
		this.consultWin = consltWin;
		this.contractorWin = contractorWin;
		this.totalWin = totalWin;
		this.expLOIDate = expLOIDate;
		this.sewinper = sewinper;
	}

	public SipStageFollowUp(String cqhSysId, String seCode, String seName, String qtnDt, String qtnCode, String qtnNo,
			String custName, String projectName, String consultant, double amount, String priority, String status,
			String remarks, String updatedBy, String updatedOn, int reminderCount, int consltWin, int contractorWin,
			int totalWin, String expLOIDate, String sewinper, String submittalcode) {
		super();
		this.cqhSysId = cqhSysId;
		this.seCode = seCode;
		this.seName = seName;
		this.qtnDt = qtnDt;
		this.qtnCode = qtnCode;
		this.qtnNo = qtnNo;
		this.custName = custName;
		this.projectName = projectName;
		this.consultant = consultant;
		this.qtnAmount = amount;
		this.priority = priority;
		this.status = status;
		this.remarks = remarks;
		this.updatedBy = updatedBy;
		this.updatedOn = updatedOn;
		this.reminderCount = reminderCount;
		this.consultWin = consltWin;
		this.contractorWin = contractorWin;
		this.totalWin = totalWin;
		this.expLOIDate = expLOIDate;
		this.sewinper = sewinper;
		this.submittalcode = submittalcode;
	}

	public SipStageFollowUp(String cqhSysId, String seCode, String seName, String qtnDt, String qtnCode, String qtnNo,
			String custName, String projectName, String consultant, double amount, String priority, String status,
			String remarks, String updatedBy, String updatedOn, int reminderCount, int consltWin, int contractorWin,
			int totalWin, String expLOIDate, String sewinper, String submittalcode, String isApproved) {
		super();
		this.cqhSysId = cqhSysId;
		this.seCode = seCode;
		this.seName = seName;
		this.qtnDt = qtnDt;
		this.qtnCode = qtnCode;
		this.qtnNo = qtnNo;
		this.custName = custName;
		this.projectName = projectName;
		this.consultant = consultant;
		this.qtnAmount = amount;
		this.priority = priority;
		this.status = status;
		this.remarks = remarks;
		this.updatedBy = updatedBy;
		this.updatedOn = updatedOn;
		this.reminderCount = reminderCount;
		this.consultWin = consltWin;
		this.contractorWin = contractorWin;
		this.totalWin = totalWin;
		this.expLOIDate = expLOIDate;
		this.sewinper = sewinper;
		this.submittalcode = submittalcode;
		this.isApproved = isApproved;
	}
}
