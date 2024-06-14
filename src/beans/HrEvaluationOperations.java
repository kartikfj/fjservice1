package beans;

public class HrEvaluationOperations {
	private long id = 0 ;
	private int actionStatus = 0;
	private int totalScore = 0 ;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public int getActionStatus() {
		return actionStatus;
	}
	public void setActionStatus(int actionStatus) {
		this.actionStatus = actionStatus;
	}
	

	public int getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}
	public HrEvaluationOperations(long id, int actionStatus) {
		 
		this.id = id;
		this.actionStatus = actionStatus;
	}
	public HrEvaluationOperations(long id, int actionStatus, int totalScore) {
		 
		this.id = id;
		this.actionStatus = actionStatus;
		this.totalScore = totalScore;
	}
}
