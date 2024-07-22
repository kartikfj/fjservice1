package beans;

public class Feedbacks {

	public String yearMth = null;
	public String description = null;
	public double amount = 0;
		
		
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


		public Feedbacks(String yearMth, String description, double amount) {
			super();
			this.yearMth = yearMth;
			this.description = description;
			this.amount = amount;
		}
		
		
}
