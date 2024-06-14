package beans;

public class SipDivQuotationToLoiAnalysis {
	private String divname = null;
	private String year = null;
	private String quotation = null;
	private String quotation_val = null;
	private String loi = null;
	private String loi_val = null;

	public String getDivname() {
		return divname;
	}

	public void setDivname(String divname) {
		this.divname = divname;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getQuotation() {
		return quotation;
	}

	public void setQuotation(String quotation) {
		this.quotation = quotation;
	}

	public String getQuotation_val() {
		return quotation_val;
	}

	public void setQuotation_val(String quotation_val) {
		this.quotation_val = quotation_val;
	}

	public String getLoi() {
		return loi;
	}

	public void setLoi(String loi) {
		this.loi = loi;
	}

	public String getLoi_val() {
		return loi_val;
	}

	public void setLoi_val(String loi_val) {
		this.loi_val = loi_val;
	}

	public SipDivQuotationToLoiAnalysis(String divname, String year, String quotation, String quotation_val, String loi,
			String loi_val) {
		super();
		this.divname = divname;
		this.year = year;
		this.quotation = quotation;
		this.quotation_val = quotation_val;
		this.loi = loi;
		this.loi_val = loi_val;
	}

}
