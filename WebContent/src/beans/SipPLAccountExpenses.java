package beans;

public class SipPLAccountExpenses {
	private String accountName = null;

	private String d1 = null;// month
	private String d2 = null;// Budget Expense
	private String d3 = null;// Actual Expense
	private String d4 = null;// Difference

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getD1() {
		return d1;
	}

	public void setD1(String d1) {
		this.d1 = d1;
	}

	public String getD2() {
		return d2;
	}

	public void setD2(String d2) {
		this.d2 = d2;
	}

	public String getD3() {
		return d3;
	}

	public void setD3(String d3) {
		this.d3 = d3;
	}

	public String getD4() {
		return d4;
	}

	public void setD4(String d4) {
		this.d4 = d4;
	}

	public SipPLAccountExpenses(String accountName) {
		// this for getting complete list of account name in fj group for expense
		// calculation
		super();
		this.accountName = accountName;
	}

	public SipPLAccountExpenses(String d1, String d2, String d3, String d4) {
		super(); // this for budget expenses values based on division and account name
		this.d1 = d1;
		this.d2 = d2;
		this.d3 = d3;
		this.d4 = d4;
	}

}
