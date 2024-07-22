package beans;

public class Mkt_SEFollowUp {
	private String process_id = null;
	private String lead_id = null;
	private String process31_status = null;
	private String process31_desc = null;
	private String process31_on = null;
	private String process32_status = null;
	private String process32_desc = null;
	private String process32_on = null;
	private String process33_status = null;
	private String process33_desc = null;
	private String process33_on = null;
	private String lastPrccsdStage = null;

	public String getProcess_id() {
		return process_id;
	}

	public void setProcess_id(String process_id) {
		this.process_id = process_id;
	}

	public String getLead_id() {
		return lead_id;
	}

	public void setLead_id(String lead_id) {
		this.lead_id = lead_id;
	}

	public String getProcess31_status() {
		return process31_status;
	}

	public void setProcess31_status(String process31_status) {
		this.process31_status = process31_status;
	}

	public String getProcess31_desc() {
		return process31_desc;
	}

	public void setProcess31_desc(String process31_desc) {
		this.process31_desc = process31_desc;
	}

	public String getProcess31_on() {
		return process31_on;
	}

	public void setProcess31_on(String process31_on) {
		this.process31_on = process31_on;
	}

	public String getProcess32_status() {
		return process32_status;
	}

	public void setProcess32_status(String process32_status) {
		this.process32_status = process32_status;
	}

	public String getProcess32_desc() {
		return process32_desc;
	}

	public void setProcess32_desc(String process32_desc) {
		this.process32_desc = process32_desc;
	}

	public String getProcess32_on() {
		return process32_on;
	}

	public void setProcess32_on(String process32_on) {
		this.process32_on = process32_on;
	}

	public String getProcess33_status() {
		return process33_status;
	}

	public void setProcess33_status(String process33_status) {
		this.process33_status = process33_status;
	}

	public String getProcess33_desc() {
		return process33_desc;
	}

	public void setProcess33_desc(String process33_desc) {
		this.process33_desc = process33_desc;
	}

	public String getProcess33_on() {
		return process33_on;
	}

	public void setProcess33_on(String process33_on) {
		this.process33_on = process33_on;
	}

	public Mkt_SEFollowUp(String process_id, String lead_id, String process31_status, String process31_desc,
			String process31_on, String process32_status, String process32_desc, String process32_on,
			String process33_status, String process33_desc, String process33_on, String lastPrccsdStage) {
		super();
		this.process_id = process_id;
		this.lead_id = lead_id;
		this.process31_status = process31_status;
		this.process31_desc = process31_desc;
		this.process31_on = process31_on;
		this.process32_status = process32_status;
		this.process32_desc = process32_desc;
		this.process32_on = process32_on;
		this.process33_status = process33_status;
		this.process33_desc = process33_desc;
		this.process33_on = process33_on;
		this.lastPrccsdStage = lastPrccsdStage;
	}

	public String getLastPrccsdStage() {
		return lastPrccsdStage;
	}

	public void setLastPrccsdStage(String lastPrccsdStage) {
		this.lastPrccsdStage = lastPrccsdStage;
	}

}
