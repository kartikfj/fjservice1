package beans;

public class HrEvaluationCategory {
	private String code = null;
	private String code_desc = null;
	private int total_contents = 0;
	private int content_number = 0;
	private String content_desc = null;

	private String emp_comment = null;
	private String dm_comment = null;
	private String rating = null;
	private String dm_code = null;
	private String emp_code = null;
	private String emp_UpdOn = null;
	private String dm_UpdOn = null;

	private String ratingReqrdOrNot = null;

	private int updatedContents = 0;
	private int updatedRatings = 0;
	private int score = 0;
	private int finatRating = 0;
	private String contentDetails = null;

	public String getContentDetails() {
		return contentDetails;
	}

	public void setContentDetails(String contentDetails) {
		this.contentDetails = contentDetails;
	}

	public int getFinatRating() {
		return finatRating;
	}

	public void setFinatRating(int finatRating) {
		this.finatRating = finatRating;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCode_desc() {
		return code_desc;
	}

	public void setCode_desc(String code_desc) {
		this.code_desc = code_desc;
	}

	public int getTotal_contents() {
		return total_contents;
	}

	public void setTotal_contents(int total_contents) {
		this.total_contents = total_contents;
	}

	public int getContent_number() {
		return content_number;
	}

	public void setContent_number(int content_number) {
		this.content_number = content_number;
	}

	public String getContent_desc() {
		return content_desc;
	}

	public void setContent_desc(String content_desc) {
		this.content_desc = content_desc;
	}

	public String getEmp_comment() {
		return emp_comment;
	}

	public void setEmp_comment(String emp_comment) {
		this.emp_comment = emp_comment;
	}

	public String getDm_comment() {
		return dm_comment;
	}

	public void setDm_comment(String dm_comment) {
		this.dm_comment = dm_comment;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getDm_code() {
		return dm_code;
	}

	public void setDm_code(String dm_code) {
		this.dm_code = dm_code;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public String getEmp_UpdOn() {
		return emp_UpdOn;
	}

	public void setEmp_UpdOn(String emp_UpdOn) {
		this.emp_UpdOn = emp_UpdOn;
	}

	public String getDm_UpdOn() {
		return dm_UpdOn;
	}

	public void setDm_UpdOn(String dm_UpdOn) {
		this.dm_UpdOn = dm_UpdOn;
	}

	public int getUpdatedContents() {
		return updatedContents;
	}

	public void setUpdatedContents(int updatedContents) {
		this.updatedContents = updatedContents;
	}

	public String getRatingReqrdOrNot() {
		return ratingReqrdOrNot;
	}

	public void setRatingReqrdOrNot(String ratingReqrdOrNot) {
		this.ratingReqrdOrNot = ratingReqrdOrNot;
	}

	public int getUpdatedRatings() {
		return updatedRatings;
	}

	public void setUpdatedRatings(int updatedRatings) {
		this.updatedRatings = updatedRatings;
	}

	public HrEvaluationCategory(String code, int content_number, String content_desc, String emp_comment,
			String dm_comment, String rating, String emp_UpdOn, String dm_code, String dm_UpdOn,
			String ratingReqrdOrNot) {
		super();
		// employee single category evaluation updates details
		this.code = code;
		this.content_number = content_number;
		this.content_desc = content_desc;
		this.emp_comment = emp_comment;
		this.dm_comment = dm_comment;
		this.rating = rating;
		this.emp_UpdOn = emp_UpdOn;
		this.dm_code = dm_code;
		this.dm_UpdOn = dm_UpdOn;
		this.ratingReqrdOrNot = ratingReqrdOrNot;
	}

	public HrEvaluationCategory(String code, String code_desc, int total_contents, int updatedContents,
			int updatedRatings) {
		super();
		// employee complete evaluation category wise summary
		this.code = code;
		this.code_desc = code_desc;
		this.total_contents = total_contents;
		this.updatedContents = updatedContents;
		this.updatedRatings = updatedRatings;
	}

	public HrEvaluationCategory(String code, String code_desc, int score) {
		// single employee category score for reports
		this.code = code;
		this.code_desc = code_desc;
		this.score = score;
	}

	public HrEvaluationCategory(String code, int content_number, String code_desc, String emp_comment,
			String dm_comment, int finatRating, String contentDetails, String ratingReqYorN) {
		// complete evaluation contents for reports
		this.code = code;
		this.content_number = content_number;
		this.code_desc = code_desc;
		this.emp_comment = emp_comment;
		this.dm_comment = dm_comment;
		this.finatRating = finatRating;
		this.contentDetails = contentDetails;
		this.ratingReqrdOrNot = ratingReqYorN;
	}

}
