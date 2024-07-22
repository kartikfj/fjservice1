package beans;

public class ProjectStatusDetails {
	private String stage = null;
	private String txnCode = null;
	private String txnNo = null;
	private String txnDate = null;
	private String loiDate = null;
	private String expPODate = null;
	private String expInvDate = null;
	private int amount;
	private String smCode = null;
	private String smName = null;
	private String projectName = null;
	private String consultant = null;
	private String customer = null;
	private String status = null;
	private String emailId = null;
	private int consultWin = 0;
	private int contractorWin = 0;
	private int totalWin = 0;
	private String txnName = null;

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getTxnCode() {
		return txnCode;
	}

	public void setTxnCode(String txnCode) {
		this.txnCode = txnCode;
	}

	public String getTxnNo() {
		return txnNo;
	}

	public void setTxnNo(String txnNo) {
		this.txnNo = txnNo;
	}

	public String getTxnDate() {
		return txnDate;
	}

	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}

	public String getLoiDate() {
		return loiDate;
	}

	public void setLoiDate(String loiDate) {
		this.loiDate = loiDate;
	}

	public String getExpPODate() {
		return expPODate;
	}

	public void setExpPODate(String expPODate) {
		this.expPODate = expPODate;
	}

	public String getExpInvDate() {
		return expInvDate;
	}

	public void setExpInvDate(String expInvDate) {
		this.expInvDate = expInvDate;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getSmCode() {
		return smCode;
	}

	public void setSmCode(String smCode) {
		this.smCode = smCode;
	}

	public String getSmName() {
		return smName;
	}

	public void setSmName(String smName) {
		this.smName = smName;
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

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
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

	public String getTxnName() {
		return txnName;
	}

	public void setTxnName(String txnName) {
		this.txnName = txnName;
	}

	public ProjectStatusDetails(String stage, String txnCode, String txnNo, String txnDate, String loiDate,
			String exppoDate, String expinvdate, int amount, String snCode, String smName, String projectName,
			String cusultant, String customer, String status, String emailid, int consultWin, int contractorWin,
			int totalWin, String txnName) {
		this.stage = stage;
		this.txnCode = txnCode;
		this.txnNo = txnNo;
		this.txnDate = txnDate;
		this.loiDate = loiDate;
		this.expPODate = exppoDate;
		this.expInvDate = expinvdate;
		this.amount = amount;
		this.smCode = snCode;
		this.smName = smName;
		this.projectName = projectName;
		this.consultant = cusultant;
		this.customer = customer;
		this.status = status;
		this.emailId = emailid;
		this.consultWin = consultWin;
		this.contractorWin = contractorWin;
		this.totalWin = totalWin;
		this.txnName = txnName;
	}
}
