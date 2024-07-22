package beans;

public class SipDivSoToInvoiceAnalysis {
	private String divname = null;
	private String year = null;
	private String s_order = null;
	private String s_order_val = null;
	private String invoice = null;
	private String invoice_val = null;

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

	public String getS_order() {
		return s_order;
	}

	public void setS_order(String s_order) {
		this.s_order = s_order;
	}

	public String getS_order_val() {
		return s_order_val;
	}

	public void setS_order_val(String s_order_val) {
		this.s_order_val = s_order_val;
	}

	public String getInvoice() {
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public String getInvoice_val() {
		return invoice_val;
	}

	public void setInvoice_val(String invoice_val) {
		this.invoice_val = invoice_val;
	}

	public SipDivSoToInvoiceAnalysis(String divname, String year, String s_order, String s_order_val, String invoice,
			String invoice_val) {
		super();
		this.divname = divname;
		this.year = year;
		this.s_order = s_order;
		this.s_order_val = s_order_val;
		this.invoice = invoice;
		this.invoice_val = invoice_val;
	}

}
