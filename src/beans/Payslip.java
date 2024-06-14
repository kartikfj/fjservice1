package beans;

public class Payslip {

	public String yearMth = null;
	public String description = null;
	public double amount = 0;
	public String companyName = null;

	public String getYearMth() {
		return yearMth;
	}

	public void setYearMth(String yearMth) {
		this.yearMth = yearMth;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompany_name(String companyName) {
		this.companyName = companyName;
	}

	public Payslip(String yearMth, String description, double amount, String companyName) {
		super();
		this.yearMth = yearMth;
		this.description = description;
		this.amount = amount;
		this.companyName = companyName;
	}

}
