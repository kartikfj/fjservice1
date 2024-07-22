package beans;

public class HrEvaluationRating {
	private int ratingCode = -1;
	private String ratingDesc = null;
	public int getRatingCode() {
		return ratingCode;
	}
	public void setRatingCode(int ratingCode) {
		this.ratingCode = ratingCode;
	}
	public String getRatingDesc() {
		return ratingDesc;
	}
	public void setRatingDesc(String ratingDesc) {
		this.ratingDesc = ratingDesc;
	}
	public HrEvaluationRating(int ratingCode, String ratingDesc) {
		super();
		this.ratingCode = ratingCode;
		this.ratingDesc = ratingDesc;
	}
	

}
