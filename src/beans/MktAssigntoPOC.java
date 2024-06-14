package beans;

import java.util.List;

public class MktAssigntoPOC {
	private String id = null;
	private String bdmTaskName = null;
	private String bdmEmpCode = null;
	private String bdmName = null;
	private String seEmpCode = null;
	private String seName = null;
	private String requestedOn = null;
	private String p1Status = null;
	private String initialReamrks = null;

	private String se_accept_remarks = null;
	private String p2Status = null;
	private String se_accept_by = null;
	private String se_accept_on = null;

	private String se_acted_on = null;
	private String se_remarks = null;
	private String se_followup_by = null;
	private String se_followup_on = null;
	private String p3Status = null;

	private String bdm_remarks = null;
	private String p4Status = null;
	private String bdm_update_on = null;
	private List<String> followupRemarks = null;

	private int insertStatus = 0;
	private int lastInsertedRow = 0;

	public String getBdmEmpCode() {
		return bdmEmpCode;
	}

	public void setBdmEmpCode(String bdmEmpCode) {
		this.bdmEmpCode = bdmEmpCode;
	}

	public String getBdmName() {
		return bdmName;
	}

	public void setBdmName(String bdmName) {
		this.bdmName = bdmName;
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

	public String getSe_accept_remarks() {
		return se_accept_remarks;
	}

	public void setSe_accept_remarks(String se_accept_remarks) {
		this.se_accept_remarks = se_accept_remarks;
	}

	public String getP2Status() {
		return p2Status;
	}

	public void setP2Status(String p2Status) {
		this.p2Status = p2Status;
	}

	public String getSe_accept_by() {
		return se_accept_by;
	}

	public void setSe_accept_by(String se_accept_by) {
		this.se_accept_by = se_accept_by;
	}

	public String getSe_accept_on() {
		return se_accept_on;
	}

	public void setSe_accept_on(String se_accept_on) {
		this.se_accept_on = se_accept_on;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSe_acted_on() {
		return se_acted_on;
	}

	public void setSe_acted_on(String se_acted_on) {
		this.se_acted_on = se_acted_on;
	}

	public String getSe_remarks() {
		return se_remarks;
	}

	public void setSe_remarks(String se_remarks) {
		this.se_remarks = se_remarks;
	}

	public String getSe_followup_by() {
		return se_followup_by;
	}

	public void setSe_followup_by(String se_followup_by) {
		this.se_followup_by = se_followup_by;
	}

	public String getP3Status() {
		return p3Status;
	}

	public void setP3Status(String p3Status) {
		this.p3Status = p3Status;
	}

	public String getBdm_remarks() {
		return bdm_remarks;
	}

	public void setBdm_remarks(String bdm_remarks) {
		this.bdm_remarks = bdm_remarks;
	}

	public String getP4Status() {
		return p4Status;
	}

	public void setP4Status(String p4Status) {
		this.p4Status = p4Status;
	}

	public String getBdm_update_on() {
		return bdm_update_on;
	}

	public void setBdm_followup_on(String bdm_update_on) {
		this.bdm_update_on = bdm_update_on;
	}

	public List<String> getFollowupRemarks() {
		return followupRemarks;
	}

	public void setFollowupRemarks(List<String> followupRemarks) {
		this.followupRemarks = followupRemarks;
	}

	public String getBdmTaskName() {
		return bdmTaskName;
	}

	public void setBdmTaskName(String bdmTaskName) {
		this.bdmTaskName = bdmTaskName;
	}

	public int getInsertStatus() {
		return insertStatus;
	}

	public void setInsertStatus(int insertStatus) {
		this.insertStatus = insertStatus;
	}

	public int getLastInsertedRow() {
		return lastInsertedRow;
	}

	public void setLastInsertedRow(int lastInsertedRow) {
		this.lastInsertedRow = lastInsertedRow;
	}

	public String getInitialReamrks() {
		return initialReamrks;
	}

	public void setInitialReamrks(String initialReamrks) {
		this.initialReamrks = initialReamrks;
	}

	public void setBdm_update_on(String bdm_update_on) {
		this.bdm_update_on = bdm_update_on;
	}

	public String getSe_followup_on() {
		return se_followup_on;
	}

	public void setSe_followup_on(String se_followup_on) {
		this.se_followup_on = se_followup_on;
	}

	public MktAssigntoPOC() {

	}

	public MktAssigntoPOC(int insertStatus, int lastInsertedRow) {
		super();
		// to get latst primary key auto incriment number and inserted status
		this.insertStatus = insertStatus;
		this.lastInsertedRow = lastInsertedRow;
	}

	public MktAssigntoPOC(String bdmTaskName, String bdmCode, String bdmName, String seEmpCode, String seName,
			String bdmRemarks) {
		this.bdmEmpCode = bdmCode;
		this.bdmName = bdmName;
		this.bdmTaskName = bdmTaskName;
		this.seEmpCode = seEmpCode;
		this.seName = seName;
		this.initialReamrks = bdmRemarks;
	}

	public MktAssigntoPOC(String mktid, String bdmEmpCode_temp, String bdmEmpName_temp, String seempCode_temp,
			String seempName_temp, String requestedOn_temp, String bdmrequestedStatus_temp, String seAccptRemarkss_temp,
			String seAccptStatus_temp, String seAcceptBy_temp, String seAcceptOn_temp, String sefolloupBy_temp,
			String se_folloupOn_temp, String se_folloupStatus_temp, String bdmRemark_temp, String bdmUpdatedOn_temp,
			String bdmUpdatedStatus_temp, String bdmTaskName, String initialSeRemarks, List<String> followupRemarks) {
		this.id = mktid;
		this.bdmEmpCode = bdmEmpCode_temp;
		this.bdmName = bdmEmpName_temp;
		this.bdmTaskName = bdmTaskName;
		this.seEmpCode = seempCode_temp;
		this.seName = seempName_temp;
		this.requestedOn = requestedOn_temp;
		this.p1Status = bdmrequestedStatus_temp;
		this.p2Status = seAccptStatus_temp;
		this.p3Status = se_folloupStatus_temp;
		this.p4Status = bdmUpdatedStatus_temp;
		this.se_accept_remarks = seAccptRemarkss_temp;
		this.se_accept_by = seAcceptBy_temp;
		this.se_accept_on = seAcceptOn_temp;
		this.se_followup_on = se_folloupOn_temp;
		// this.se_remarks = mkt_remarks;
		this.se_followup_by = sefolloupBy_temp;
		this.bdm_remarks = bdmRemark_temp;
		this.bdm_update_on = bdmUpdatedOn_temp;
		this.initialReamrks = initialSeRemarks;
		this.followupRemarks = followupRemarks;
	}

	public MktAssigntoPOC(String id, String type, String mkt_remarks) {
		super();
		// process 3 by marketing team if mkt accepted the rquest that is p2 status is 1
		this.id = id;
		this.se_accept_remarks = mkt_remarks;
	}

	public MktAssigntoPOC(String id, String type, String p2Status, String support_accept_by,
			String support_accept_remarks) {
		super();
		// support request handling constructor -- process -2
		this.id = id;
		this.p2Status = p2Status;
		this.se_accept_by = support_accept_by;
		this.se_accept_remarks = support_accept_remarks;
	}

	public MktAssigntoPOC(String id, String se_remarks) {
		super();
		// process 4 for sales engineer if mkt asscepted the rquest that is p2 status =
		// 1 and p3 status = 1
		this.id = id;
		this.se_remarks = se_remarks;
	}
}
