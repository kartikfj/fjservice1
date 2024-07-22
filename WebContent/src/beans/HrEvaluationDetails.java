package beans;

public class HrEvaluationDetails {
	private long id = 0;
	private int evaluationYear = 0;
	private String empGoals = null;
	private String empComment = null;
	private String dmComment = null;
	private int evaluationStatus = 0;
	private String dmId = null;
	private String dmUpdatedOn = null;
	private String empUpdtedOn = null;
	private String empCrtOn = null;
	private String evltnEmp = null;
	private String evlCloseStstus = null;

	private int empEntryActive = 0;
	private int managerEntryActive = 0;
	private int hrEntryActive = 0;

	private String hrComment = null;
	private String areastoImprv = null;
	private String trainingNeeded = null;
	private String trainingNeededDesc = null;

	public int getEmpEntryActive() {
		return empEntryActive;
	}

	public void setEmpEntryActive(int empEntryActive) {
		this.empEntryActive = empEntryActive;
	}

	public int getManagerEntryActive() {
		return managerEntryActive;
	}

	public void setManagerEntryActive(int managerEntryActive) {
		this.managerEntryActive = managerEntryActive;
	}

	public String getEvlCloseStstus() {
		return evlCloseStstus;
	}

	public void setEvlCloseStstus(String evlCloseStstus) {
		this.evlCloseStstus = evlCloseStstus;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getEvaluationYear() {
		return evaluationYear;
	}

	public void setEvaluationYear(int evaluationYear) {
		this.evaluationYear = evaluationYear;
	}

	public String getEmpGoals() {
		return empGoals;
	}

	public void setEmpGoals(String empGoals) {
		this.empGoals = empGoals;
	}

	public String getEmpComment() {
		return empComment;
	}

	public void setEmpComment(String empComment) {
		this.empComment = empComment;
	}

	public String getDmComment() {
		return dmComment;
	}

	public void setDmComment(String dmComment) {
		this.dmComment = dmComment;
	}

	public int getEvaluationStatus() {
		return evaluationStatus;
	}

	public void setEvaluationStatus(int evaluationStatus) {
		this.evaluationStatus = evaluationStatus;
	}

	public String getDmId() {
		return dmId;
	}

	public void setDmId(String dmId) {
		this.dmId = dmId;
	}

	public String getDmUpdatedOn() {
		return dmUpdatedOn;
	}

	public void setDmUpdatedOn(String dmUpdatedOn) {
		this.dmUpdatedOn = dmUpdatedOn;
	}

	public String getEmpUpdtedOn() {
		return empUpdtedOn;
	}

	public void setEmpUpdtedOn(String empUpdtedOn) {
		this.empUpdtedOn = empUpdtedOn;
	}

	public String getEmpCrtOn() {
		return empCrtOn;
	}

	public void setEmpCrtOn(String empCrtOn) {
		this.empCrtOn = empCrtOn;
	}

	public String getEvltnEmp() {
		return evltnEmp;
	}

	public void setEvltnEmp(String evltnEmp) {
		this.evltnEmp = evltnEmp;
	}

	public String getHrComment() {
		return hrComment;
	}

	public void setHrComment(String hrComment) {
		this.hrComment = hrComment;
	}

	public String getAreastoImprv() {
		return areastoImprv;
	}

	public void setAreastoImprv(String areastoImprv) {
		this.areastoImprv = areastoImprv;
	}

	public String getTrainingNeeded() {
		return trainingNeeded;
	}

	public void setTrainingNeeded(String trainingNeeded) {
		this.trainingNeeded = trainingNeeded;
	}

	public String getTrainingNeededDesc() {
		return trainingNeededDesc;
	}

	public void setTrainingNeededDesc(String trainingNeededDesc) {
		this.trainingNeededDesc = trainingNeededDesc;
	}

	public int getHrEntryActive() {
		return hrEntryActive;
	}

	public void setHrEntryActive(int hrEntryActive) {
		this.hrEntryActive = hrEntryActive;
	}

	public HrEvaluationDetails(long id, int evaluationYear, String empGoals, String empComment, String dmComment,
			int evaluationStatus, String dmId, String dmUpdatedOn, String empUpdtedOn, String empCrtOn, String evltnEmp,
			int empEntryActive, int managerEntryActive, String hrComment, int hrEntryActive, String imprareas,
			String trainingNeededCodes, String trainingNeededDesc) {
		super();
		// employee evaluation master entry details
		this.id = id;
		this.evaluationYear = evaluationYear;
		this.empGoals = empGoals;
		this.empComment = empComment;
		this.dmComment = dmComment;
		this.evaluationStatus = evaluationStatus;
		this.dmId = dmId;
		this.dmUpdatedOn = dmUpdatedOn;
		this.empUpdtedOn = empUpdtedOn;
		this.empCrtOn = empCrtOn;
		this.evltnEmp = evltnEmp;
		this.empEntryActive = empEntryActive;
		this.managerEntryActive = managerEntryActive;
		this.hrComment = hrComment;
		this.hrEntryActive = hrEntryActive;
		this.areastoImprv = imprareas;
		this.trainingNeeded = trainingNeededCodes;
		this.trainingNeededDesc = trainingNeededDesc;
	}

	public HrEvaluationDetails(String empGoals, String empComment, String dmComment, String evlCloseStstus,
			String hrComment, String imprareas, String trainingNeeded) {
		this.empGoals = empGoals;
		this.empComment = empComment;
		this.dmComment = dmComment;
		this.evlCloseStstus = evlCloseStstus;
		this.hrComment = hrComment;
		this.areastoImprv = imprareas;
		this.trainingNeeded = trainingNeeded;
	}

	// for report section

}
