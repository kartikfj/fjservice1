package beans;

public class SipDivLoiToSoAnalysis {
	private String divname = null;
	private String year = null;
	private String loi = null;
	private String loi_val = null;
	private String sales_order = null;
	private String sales_order_val = null;

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

	public String getSales_order() {
		return sales_order;
	}

	public void setSales_order(String sales_order) {
		this.sales_order = sales_order;
	}

	public String getSales_order_val() {
		return sales_order_val;
	}

	public void setSales_order_val(String sales_order_val) {
		this.sales_order_val = sales_order_val;
	}

	public SipDivLoiToSoAnalysis(String divname, String year, String loi, String loi_val, String sales_order,
			String sales_order_val) {
		super();
		this.divname = divname;
		this.year = year;
		this.loi = loi;
		this.loi_val = loi_val;
		this.sales_order = sales_order;
		this.sales_order_val = sales_order_val;
	}

}
