package beans;

import java.sql.Date;

public class HrEvaluationSettings {

	private int evaluationYear = 0;
	private Date startDate = null;
	private Date endDate = null;
	private int evaluationTerm  = 0;
	private int activeOrNot = 0;
	private Date currentDate = null;
	
	

	
	public int getEvaluationYear() {
		return evaluationYear;
	}
	public void setEvaluationYear(int evaluationYear) {
		this.evaluationYear = evaluationYear;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
 
	 
	public int getEvaluationTerm() {
		return evaluationTerm;
	}
	public void setEvaluationTerm(int evaluationTerm) {
		this.evaluationTerm = evaluationTerm;
	}
	
	public int getActiveOrNot() {
		return activeOrNot;
	}
	public void setActiveOrNot(int activeOrNot) {
		this.activeOrNot = activeOrNot;
	}
	
	public Date getCurrentDate() {
		return currentDate;
	}
	public void setCurrentDate(Date currentDate) {
		this.currentDate = currentDate;
	}
	public HrEvaluationSettings(int evaluationYear, Date startDate, Date endDate, int evaluationTerm, int activeOrNot) {
		super();
		this.evaluationYear = evaluationYear;
		this.startDate = startDate;
		this.endDate = endDate;
		this.evaluationTerm = evaluationTerm;
		this.activeOrNot = activeOrNot;
	}
	public HrEvaluationSettings(int evaluationYear, Date startDate, Date endDate, int evaluationTerm,
			int activeOrNot, Date currentDate) {
		super();
		this.evaluationYear = evaluationYear;
		this.startDate = startDate;
		this.endDate = endDate;
		this.evaluationTerm = evaluationTerm;
		this.activeOrNot = activeOrNot;
		this.currentDate = currentDate;
	}
	public HrEvaluationSettings(int evaluationYear) {
		super();
		this.evaluationYear = evaluationYear;
	}
 
	
	
	
	
}
