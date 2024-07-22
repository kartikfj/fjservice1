package beans;

public class SipSlowMovingStock {
	private String month = null;
	private String stock_value = null;

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getStock_value() {
		return stock_value;
	}

	public void setStock_value(String stock_value) {
		this.stock_value = stock_value;
	}

	public SipSlowMovingStock(String month, String stock_value) {
		super();
		this.month = month;
		this.stock_value = stock_value;
	}

}
