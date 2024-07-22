package beans;

public class MktDashboard {

	private String division = null;
	private String leadType = null;
	private String seEmpCode = null;
	private String seEmpName = null;
	private String totalLeads = null;
	private String ackPendingLeads = null;
	private String acknowledgedLeads = null;
	private String declinedLeads = null;
	private String stage3Count = null;
	private String stage3Value = null;
	private String stage4Count = null;
	private String stage4Value = null;
	private String stage4NotConfrmd = null;
	private String qtdLeads = null;
	private String lostLeadsAtOV = null;
	private String lostLeadsAtS3 = null;

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getTotalLeads() {
		return totalLeads;
	}

	public void setTotalLeads(String totalLeads) {
		this.totalLeads = totalLeads;
	}

	public String getAckPendingLeads() {
		return ackPendingLeads;
	}

	public void setAckPendingLeads(String ackPendingLeads) {
		this.ackPendingLeads = ackPendingLeads;
	}

	public String getAcknowledgedLeads() {
		return acknowledgedLeads;
	}

	public void setAcknowledgedLeads(String acknowledgedLeads) {
		this.acknowledgedLeads = acknowledgedLeads;
	}

	public String getStage3Count() {
		return stage3Count;
	}

	public void setStage3Count(String stage3Count) {
		this.stage3Count = stage3Count;
	}

	public String getStage3Value() {
		return stage3Value;
	}

	public void setStage3Value(String stage3Value) {
		this.stage3Value = stage3Value;
	}

	public String getStage4Count() {
		return stage4Count;
	}

	public void setStage4Count(String stage4Count) {
		this.stage4Count = stage4Count;
	}

	public String getStage4Value() {
		return stage4Value;
	}

	public void setStage4Value(String stage4Value) {
		this.stage4Value = stage4Value;
	}

	public String getStage4NotConfrmd() {
		return stage4NotConfrmd;
	}

	public void setStage4NotConfrmd(String stage4NotConfrmd) {
		this.stage4NotConfrmd = stage4NotConfrmd;
	}

	public String getDeclinedLeads() {
		return declinedLeads;
	}

	public void setDeclinedLeads(String declinedLeads) {
		this.declinedLeads = declinedLeads;
	}

	public String getQtdLeads() {
		return qtdLeads;
	}

	public void setQtdLeads(String qtdLeads) {
		this.qtdLeads = qtdLeads;
	}

	public String getLostLeadsAtOV() {
		return lostLeadsAtOV;
	}

	public void setLostLeadsAtOV(String lostLeadsAtOV) {
		this.lostLeadsAtOV = lostLeadsAtOV;
	}

	public String getLostLeadsAtS3() {
		return lostLeadsAtS3;
	}

	public void setLostLeadsAtS3(String lostLeadsAtS3) {
		this.lostLeadsAtS3 = lostLeadsAtS3;
	}

	public String getLeadType() {
		return leadType;
	}

	public void setLeadType(String leadType) {
		this.leadType = leadType;
	}

	public String getSeEmpCode() {
		return seEmpCode;
	}

	public void setSeEmpCode(String seEmpCode) {
		this.seEmpCode = seEmpCode;
	}

	public String getSeEmpName() {
		return seEmpName;
	}

	public void setSeEmpName(String seEmpName) {
		this.seEmpName = seEmpName;
	}

	public MktDashboard(String division, String leadType, String totalLeads, String ackPendingLeads,
			String acknowledgedLeads, String declinedLeads, String stage3Count, String stage3Value, String stage4Count,
			String stage4Value, String stage4NotConfrmd, String qtdLeads, String lostLeadsAtOV, String lostLeadsAtS3) {
		// complete division analysis
		super();
		this.division = division;
		this.leadType = leadType;
		this.totalLeads = totalLeads;
		this.ackPendingLeads = ackPendingLeads;
		this.acknowledgedLeads = acknowledgedLeads;
		this.declinedLeads = declinedLeads;
		this.stage3Count = stage3Count;
		this.stage3Value = stage3Value;
		this.stage4Count = stage4Count;
		this.stage4Value = stage4Value;
		this.stage4NotConfrmd = stage4NotConfrmd;
		this.qtdLeads = qtdLeads;
		this.lostLeadsAtOV = lostLeadsAtOV;
		this.lostLeadsAtS3 = lostLeadsAtS3;
	}

	public MktDashboard(String division, String leadType, String seEmpCode, String seEmpName, String totalLeads,
			String ackPendingLeads, String acknowledgedLeads, String declinedLeads, String stage3Count,
			String stage3Value, String stage4Count, String stage4Value, String stage4NotConfrmd, String qtdLeads,
			String lostLeadsAtOV, String lostLeadsAtS3) {
		super();
		this.division = division;
		this.leadType = leadType;
		this.seEmpCode = seEmpCode;
		this.seEmpName = seEmpName;
		this.totalLeads = totalLeads;
		this.ackPendingLeads = ackPendingLeads;
		this.acknowledgedLeads = acknowledgedLeads;
		this.declinedLeads = declinedLeads;
		this.stage3Count = stage3Count;
		this.stage3Value = stage3Value;
		this.stage4Count = stage4Count;
		this.stage4Value = stage4Value;
		this.stage4NotConfrmd = stage4NotConfrmd;
		this.qtdLeads = qtdLeads;
		this.lostLeadsAtOV = lostLeadsAtOV;
		this.lostLeadsAtS3 = lostLeadsAtS3;
	}

	public MktDashboard(String leadType, String totalLeads) {
		super();
		// unique lead count details
		this.leadType = leadType;
		this.totalLeads = totalLeads;
	}

}
