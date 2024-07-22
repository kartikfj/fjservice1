package beans;

public class MktConfig {
	private String id = null;
	private String type = null;
	private String category = null;
	private String typeCode = null;
	private String processCount = null;

	private String ackDesc = null;
	private int ackStatus = 0;
	private int sendMailYN = 0;
	private int seFpStage = 0;

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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public MktConfig(String id, String type, String category) {
		super();
		// this constructor using to get the lead type list for support request
		this.id = id;
		this.type = type;
		this.category = category;
	}

	public MktConfig(String id, String type, String category, String typeCode, String processCount) {
		super();
		// this constructor using to get the lead type list for sales lead
		this.id = id;
		this.type = type;
		this.category = category;
		this.typeCode = typeCode;
		this.processCount = processCount;
	}

	public String getProcessCount() {
		return processCount;
	}

	public void setProcessCount(String processCount) {
		this.processCount = processCount;
	}

	public int getAckStatus() {
		return ackStatus;
	}

	public void setAckStatus(int ackStatus) {
		this.ackStatus = ackStatus;
	}

	public String getAckDesc() {
		return ackDesc;
	}

	public void setAckDesc(String ackDesc) {
		this.ackDesc = ackDesc;
	}

	public int getSendMailYN() {
		return sendMailYN;
	}

	public void setSendMailYN(int sendMailYN) {
		this.sendMailYN = sendMailYN;
	}

	public MktConfig(String ackDesc, int ackStatus, int sendMailYN, int seFpStage) {
		super();
		// to display acknwoledgment types in process 2 & 3
		this.ackDesc = ackDesc;
		this.ackStatus = ackStatus;
		this.sendMailYN = sendMailYN;
		this.seFpStage = seFpStage;
	}

	public int getSeFpStage() {
		return seFpStage;
	}

	public void setSeFpStage(int seFpStage) {
		this.seFpStage = seFpStage;
	}

}
