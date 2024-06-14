package beans;

public class SipDivEnquirtToQtnAnalysis {
	private String divname = null;
	private String year = null;
	private String enquiry = null;
	private String quotation = null;
	private String noquotation = null;
	private String days = null;

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

	public String getEnquiry() {
		return enquiry;
	}

	public void setEnquiry(String enquiry) {
		this.enquiry = enquiry;
	}

	public String getNoquotation() {
		return noquotation;
	}

	public void setNoquotation(String noquotation) {
		this.noquotation = noquotation;
	}

	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public String getQuotation() {
		return quotation;
	}

	public void setQuotation(String quotation) {
		this.quotation = quotation;
	}

	public SipDivEnquirtToQtnAnalysis(String divname, String year, String enquiry, String quotation, String noquotation,
			String days) {
		super();
		this.divname = divname;
		this.year = year;
		this.enquiry = enquiry;
		this.quotation = quotation;
		this.noquotation = noquotation;
		this.days = days;
	}

}
