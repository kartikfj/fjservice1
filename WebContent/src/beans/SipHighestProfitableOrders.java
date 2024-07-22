package beans;

public class SipHighestProfitableOrders {
	private String inv_no = null;// invoice number
	private String inv_dt = null;// invoice date
	private String division = null;// its for main division list
	private String currncy = null;// currency
	private String inv_value = null;// invoice value
	private String profit = null;// profit
	private String prft_perc = null;// profit percentage
	private String customer = null;// customer name
	private String project = null;// project details

	public String getInv_no() {
		return inv_no;
	}

	public void setInv_no(String inv_no) {
		this.inv_no = inv_no;
	}

	public String getInv_dt() {
		return inv_dt;
	}

	public void setInv_dt(String inv_dt) {
		this.inv_dt = inv_dt;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getCurrncy() {
		return currncy;
	}

	public void setCurrncy(String currncy) {
		this.currncy = currncy;
	}

	public String getInv_value() {
		return inv_value;
	}

	public void setInv_value(String inv_value) {
		this.inv_value = inv_value;
	}

	public String getProfit() {
		return profit;
	}

	public void setProfit(String profit) {
		this.profit = profit;
	}

	public String getPrft_perc() {
		return prft_perc;
	}

	public void setPrft_perc(String prft_perc) {
		this.prft_perc = prft_perc;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	// for sub division
	public SipHighestProfitableOrders(String inv_no, String inv_dt, String currncy, String inv_value, String profit,
			String prft_perc, String customer, String project) {
		super();
		this.inv_no = inv_no;
		this.inv_dt = inv_dt;
		this.currncy = currncy;
		this.inv_value = inv_value;
		this.profit = profit;
		this.prft_perc = prft_perc;
		this.customer = customer;
		this.project = project;
	}

	// for main division
	public SipHighestProfitableOrders(String inv_no, String inv_dt, String division, String currncy, String inv_value,
			String profit, String prft_perc, String customer, String project) {
		super();
		this.inv_no = inv_no;
		this.inv_dt = inv_dt;
		this.division = division;
		this.currncy = currncy;
		this.inv_value = inv_value;
		this.profit = profit;
		this.prft_perc = prft_perc;
		this.customer = customer;
		this.project = project;
	}

}
