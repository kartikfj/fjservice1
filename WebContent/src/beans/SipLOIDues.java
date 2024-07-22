package beans;

public class SipLOIDues {
	private String slesCode = null;
	private String sys_id = null;
	private String qtnDate = null;
	private String qtnCode = null;
	private String qtnNo = null;
	private String custCode = null;
	private String custName = null;
	private String projectName = null;
	private String consultant = null;
	private int qtnAMount;
	private String qtnStatus = null;
	private String remarks = null;
	private String remarksType = null;
	private String remarkTypeDesc = null;
	private String loiDate = null;

	private String lostType = null;
	private long lostCount = 0;
	private long lostValue = 0;

	private String poDate = null;
	private String invoiceDate = null;

	public String getSlesCode() {
		return slesCode;
	}

	public void setSlesCode(String slesCode) {
		this.slesCode = slesCode;
	}

	public String getSys_id() {
		return sys_id;
	}

	public void setSys_id(String sys_id) {
		this.sys_id = sys_id;
	}

	public String getQtnDate() {
		return qtnDate;
	}

	public void setQtnDate(String qtnDate) {
		this.qtnDate = qtnDate;
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

	public String getCustCode() {
		return custCode;
	}

	public void setCustCode(String custCode) {
		this.custCode = custCode;
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

	public int getQtnAMount() {
		return qtnAMount;
	}

	public void setQtnAMount(int qtnAMount) {
		this.qtnAMount = qtnAMount;
	}

	public String getQtnStatus() {
		return qtnStatus;
	}

	public void setQtnStatus(String qtnStatus) {
		this.qtnStatus = qtnStatus;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getRemarksType() {
		return remarksType;
	}

	public void setRemarksType(String remarksType) {
		this.remarksType = remarksType;
	}

	public String getRemarkTypeDesc() {
		return remarkTypeDesc;
	}

	public void setRemarkTypeDesc(String remarkTypeDesc) {
		this.remarkTypeDesc = remarkTypeDesc;
	}

	public String getLostType() {
		return lostType;
	}

	public void setLostType(String lostType) {
		this.lostType = lostType;
	}

	public long getLostCount() {
		return lostCount;
	}

	public void setLostCount(long lostCount) {
		this.lostCount = lostCount;
	}

	public long getLostValue() {
		return lostValue;
	}

	public void setLostValue(long lostValue) {
		this.lostValue = lostValue;
	}

	public String getLoiDate() {
		return loiDate;
	}

	public void setLoiDate(String loiDate) {
		this.loiDate = loiDate;
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

	public SipLOIDues(String slesCode, String sys_id, String qtnDate, String qtnCode, String qtnNo, String custCode,
			String custName, String projectName, String consultant, int qtnAMount, String qtnStatus, String remarks,
			String loiDate, String poDate, String invoiceDate) {
		super();
		this.slesCode = slesCode;
		this.sys_id = sys_id;
		this.qtnDate = qtnDate;
		this.qtnCode = qtnCode;
		this.qtnNo = qtnNo;
		this.custCode = custCode;
		this.custName = custName;
		this.projectName = projectName;
		this.consultant = consultant;
		this.qtnAMount = qtnAMount;
		this.qtnStatus = qtnStatus;
		this.remarks = remarks;
		this.loiDate = loiDate;
		this.poDate = poDate;
		this.invoiceDate = invoiceDate;
	}

	public SipLOIDues(String remarksType, String remarkTypeDesc) {
		super();
		this.remarksType = remarksType;
		this.remarkTypeDesc = remarkTypeDesc;
	}

	public SipLOIDues(String lostType, long lostCount, long lostValue) {
		super();
		this.lostType = lostType;
		this.lostCount = lostCount;
		this.lostValue = lostValue;
	}
}
