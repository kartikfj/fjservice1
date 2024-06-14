package beans;

public class AppraisalHr {

	private int year = 0;
	private String appraisalSldt = null;
	private String appraisalEdt = null;
	private String midappSdt = null;
	private String midappEdt = null;
	private String finappStd = null;
	private String finappEdt = null;
	private String employe_id = null;
	private String company = null;
	private String modified = null;

	public AppraisalHr(String company) {
		super();
		this.company = company;
	}

	public AppraisalHr() {
		super();
	}

	public AppraisalHr(int year, String appraisalSldt, String appraisalEdt, String midappSdt, String midappEdt,
			String finappStd, String finappEdt, String employe_id, String company, String modified) {

		this.year = year;
		this.appraisalSldt = appraisalSldt;
		this.appraisalEdt = appraisalEdt;
		this.midappSdt = midappSdt;
		this.midappEdt = midappEdt;
		this.finappStd = finappStd;
		this.finappEdt = finappEdt;
		this.employe_id = employe_id;
		this.company = company;
		this.modified = modified;

	}

	public AppraisalHr(String finappStd, String finappEdt, String employe_id, String company, String modified,
			int year) {

		this.finappStd = finappStd;
		this.finappEdt = finappEdt;
		this.employe_id = employe_id;
		this.company = company;
		this.modified = modified;
		this.year = year;
	}

	public AppraisalHr(String midappSdt, String midappEdt, int year, String employe_id, String company,
			String modified) {

		this.year = year;
		this.midappSdt = midappSdt;
		this.midappEdt = midappEdt;
		this.employe_id = employe_id;
		this.company = company;
		this.modified = modified;
	}

	public AppraisalHr(int year, String appraisalSldt, String appraisalEdt, String employe_id, String company,
			String modified) {

		this.year = year;
		this.appraisalSldt = appraisalSldt;
		this.appraisalEdt = appraisalEdt;
		this.employe_id = employe_id;
		this.company = company;
		this.modified = modified;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getAppraisalSldt() {
		return appraisalSldt;
	}

	public void setAppraisalSldt(String appraisalSldt) {
		this.appraisalSldt = appraisalSldt;
	}

	public String getAppraisalEdt() {
		return appraisalEdt;
	}

	public void setAppraisalEdt(String appraisalEdt) {
		this.appraisalEdt = appraisalEdt;
	}

	public String getMidappSdt() {
		return midappSdt;
	}

	public void setMidappSdt(String midappSdt) {
		this.midappSdt = midappSdt;
	}

	public String getMidappEdt() {
		return midappEdt;
	}

	public void setMidappEdt(String midappEdt) {
		this.midappEdt = midappEdt;
	}

	public String getFinappStd() {
		return finappStd;
	}

	public void setFinappStd(String finappStd) {
		this.finappStd = finappStd;
	}

	public String getFinappEdt() {
		return finappEdt;
	}

	public void setFinappEdt(String finappEdt) {
		this.finappEdt = finappEdt;
	}

	public String getEmploye_id() {
		return employe_id;
	}

	public void setEmploye_id(String employe_id) {
		this.employe_id = employe_id;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getModified() {
		return modified;
	}

	public void setModified(String modified) {
		this.modified = modified;
	}

	// Constructor for calculating the appraisal term date condition to whicyh part
	// need to be show.
	public AppraisalHr(int year, String appraisalSldt, String appraisalEdt, String midappSdt, String midappEdt,
			String finappStd, String finappEdt) {
		super();
		this.year = year;
		this.appraisalSldt = appraisalSldt;
		this.appraisalEdt = appraisalEdt;
		this.midappSdt = midappSdt;
		this.midappEdt = midappEdt;
		this.finappStd = finappStd;
		this.finappEdt = finappEdt;
	}

}
