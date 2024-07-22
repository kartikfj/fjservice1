package beans;

import java.util.List;

public class SalesOrder_Budget {
	private String so_sys_id = null;// primary key
	private String so_number = null;
	private String so_code = null;
	private String customer_code = null;
	private String customer_name = null;
	private String project = null;
	private String total_value = null;
	private String budget_value = null;
	private String profit_amt = null;
	private String profit_perc = null;
	private String so_margin = null;
	private String so_total = null;
	private String primary_mail = null;
	private String secondary_mail = null;
	private String create_dtime = null;
	private String sob_margin = null;
	private String sob_tol = null;
	private String so_term = null;
	private String so_aprv_status = null;

	private String sobd_1 = null;// expense title
	private String sobd_2 = null;// expense description
	private String sobd_3 = null;// expense amount

	private String se_code = null;// sales engineer code
	private String se_name = null;// sales engineer code

	private String reply_mail_ids = null;
	private String so_apprvd_date = null;

	private List<SalesOrder_Budget> budgetExpencDtls = null;
	// private List<SalesOrder_Budget> apprvRejctMailReplyDtls=null;

	public String getSobd_1() {
		return sobd_1;
	}

	public void setSobd_1(String sobd_1) {
		this.sobd_1 = sobd_1;
	}

	public String getSobd_2() {
		return sobd_2;
	}

	public void setSobd_2(String sobd_2) {
		this.sobd_2 = sobd_2;
	}

	public String getSobd_3() {
		return sobd_3;
	}

	public void setSobd_3(String sobd_3) {
		this.sobd_3 = sobd_3;
	}

	public String getSo_sys_id() {
		return so_sys_id;
	}

	public void setSo_sys_id(String so_sys_id) {
		this.so_sys_id = so_sys_id;
	}

	public String getSo_number() {
		return so_number;
	}

	public void setSo_number(String so_number) {
		this.so_number = so_number;
	}

	public String getSo_code() {
		return so_code;
	}

	public void setSo_code(String so_code) {
		this.so_code = so_code;
	}

	public String getCustomer_code() {
		return customer_code;
	}

	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
	}

	public String getCustomer_name() {
		return customer_name;
	}

	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public String getTotal_value() {
		return total_value;
	}

	public void setTotal_value(String total_value) {
		this.total_value = total_value;
	}

	public String getBudget_value() {
		return budget_value;
	}

	public void setBudget_value(String budget_value) {
		this.budget_value = budget_value;
	}

	public String getProfit_amt() {
		return profit_amt;
	}

	public void setProfit_amt(String profit_amt) {
		this.profit_amt = profit_amt;
	}

	public String getProfit_perc() {
		return profit_perc;
	}

	public void setProfit_perc(String profit_perc) {
		this.profit_perc = profit_perc;
	}

	public String getSo_margin() {
		return so_margin;
	}

	public void setSo_margin(String so_margin) {
		this.so_margin = so_margin;
	}

	public String getSo_total() {
		return so_total;
	}

	public void setSo_total(String so_total) {
		this.so_total = so_total;
	}

	public String getPrimary_mail() {
		return primary_mail;
	}

	public void setPrimary_mail(String primary_mail) {
		this.primary_mail = primary_mail;
	}

	public String getSecondary_mail() {
		return secondary_mail;
	}

	public void setSecondary_mail(String secondary_mail) {
		this.secondary_mail = secondary_mail;
	}

	public String getCreate_dtime() {
		return create_dtime;
	}

	public void setCreate_dtime(String create_dtime) {
		this.create_dtime = create_dtime;
	}

	public String getSob_margin() {
		return sob_margin;
	}

	public void setSob_margin(String sob_margin) {
		this.sob_margin = sob_margin;
	}

	public String getSob_tol() {
		return sob_tol;
	}

	public void setSob_tol(String sob_tol) {
		this.sob_tol = sob_tol;
	}

	public String getSo_aprv_status() {
		return so_aprv_status;
	}

	public void setSo_aprv_status(String so_aprv_status) {
		this.so_aprv_status = so_aprv_status;
	}

	public String getSe_code() {
		return se_code;
	}

	public void setSe_code(String se_code) {
		this.se_code = se_code;
	}

	public String getSe_name() {
		return se_name;
	}

	public void setSe_name(String se_name) {
		this.se_name = se_name;
	}

	public String getSo_term() {
		return so_term;
	}

	public void setSo_term(String so_term) {
		this.so_term = so_term;
	}

	public SalesOrder_Budget(String so_sys_id, String so_number, String so_code, String customer_code,
			String customer_name, String project, String total_value, String budget_value, String profit_amt,
			String profit_perc, String so_margin, String so_total, String primary_mail, String secondary_mail,
			String create_dtime, String sob_margin, String sob_tol) {
		super();
		this.so_sys_id = so_sys_id;
		this.so_number = so_number;
		this.so_code = so_code;
		this.customer_code = customer_code;
		this.customer_name = customer_name;
		this.project = project;
		this.total_value = total_value;
		this.budget_value = budget_value;
		this.profit_amt = profit_amt;
		this.profit_perc = profit_perc;
		this.so_margin = so_margin;
		this.so_total = so_total;
		this.primary_mail = primary_mail;
		this.secondary_mail = secondary_mail;
		this.create_dtime = create_dtime;
		this.sob_margin = sob_margin;
		this.sob_tol = sob_tol;

	}

	public SalesOrder_Budget(String so_sys_id, String so_number, String so_code, String customer_code,
			String customer_name, String so_term, String project, String total_value, String budget_value,
			String profit_amt, String profit_perc, String so_margin, String so_total, String primary_mail,
			String secondary_mail, String create_dtime, String sob_margin, String sob_tol, String so_aprv_status,
			String se_code, String se_name) {
		// for dashboard
		super();
		this.so_sys_id = so_sys_id;
		this.so_number = so_number;
		this.so_code = so_code;
		this.customer_code = customer_code;
		this.customer_name = customer_name;
		this.so_term = so_term;
		this.project = project;
		this.total_value = total_value;
		this.budget_value = budget_value;
		this.profit_amt = profit_amt;
		this.profit_perc = profit_perc;
		this.so_margin = so_margin;
		this.so_total = so_total;
		this.primary_mail = primary_mail;
		this.secondary_mail = secondary_mail;
		this.create_dtime = create_dtime;
		this.sob_margin = sob_margin;
		this.sob_tol = sob_tol;
		this.so_aprv_status = so_aprv_status;
		this.se_code = se_code;
		this.se_name = se_name;
	}

	public SalesOrder_Budget(String sobd_1, String sobd_2, String sobd_3) {
		super();
		this.sobd_1 = sobd_1;
		this.sobd_2 = sobd_2;
		this.sobd_3 = sobd_3;
	}

	public List<SalesOrder_Budget> getBudgetExpencDtls() {

		return budgetExpencDtls;
	}

	public void setBudgetExpencDtls(String sobd_1, String sobd_2, String sobd_3) {
		this.sobd_1 = sobd_1;
		this.sobd_2 = sobd_2;
		this.sobd_3 = sobd_3;
	}

	public SalesOrder_Budget(String so_sys_id, String so_number, String so_code, String customer_code,
			String customer_name, String so_term, String project, String total_value, String budget_value,
			String profit_amt, String profit_perc, String so_margin, String so_total, String primary_mail,
			String secondary_mail, String create_dtime, String sob_margin, String sob_tol, String so_aprv_status,
			String se_code, String se_name, List<SalesOrder_Budget> budgetExpencDtls) {
		super();
		this.so_sys_id = so_sys_id;
		this.so_number = so_number;
		this.so_code = so_code;
		this.customer_code = customer_code;
		this.customer_name = customer_name;
		this.so_term = so_term;
		this.project = project;
		this.total_value = total_value;
		this.budget_value = budget_value;
		this.profit_amt = profit_amt;
		this.profit_perc = profit_perc;
		this.so_margin = so_margin;
		this.so_total = so_total;
		this.primary_mail = primary_mail;
		this.secondary_mail = secondary_mail;
		this.create_dtime = create_dtime;
		this.sob_margin = sob_margin;
		this.sob_tol = sob_tol;
		this.so_aprv_status = so_aprv_status;
		this.se_code = se_code;
		this.se_name = se_name;
		this.budgetExpencDtls = budgetExpencDtls;
	}

	public SalesOrder_Budget(String so_code) {
		super();
		this.so_code = so_code;
	}

	public String getReply_mail_ids() {
		return reply_mail_ids;
	}

	public void setReply_mail_ids(String reply_mail_ids) {
		this.reply_mail_ids = reply_mail_ids;
	}

	public String getSo_apprvd_date() {
		return so_apprvd_date;
	}

	public void setSo_apprvd_date(String so_apprvd_date) {
		this.so_apprvd_date = so_apprvd_date;
	}

	public void setBudgetExpencDtls(List<SalesOrder_Budget> budgetExpencDtls) {
		this.budgetExpencDtls = budgetExpencDtls;
	}

	// Approve Reject getter Setter and Constructor Coding start Here, for both
	// mailer and portal

	public SalesOrder_Budget(String so_code, String so_number, String so_apprvd_date, String reply_mail_ids,
			String customer_code, String customer_name, String project, String total_value, String budget_value,
			String profit_amt, String profit_perc, String se_code, String se_name, String so_term) {
		// This constructor is used for send mail replies for approval and reject
		// operation, Constructor 2
		super();
		this.so_code = so_code;
		this.so_number = so_number;
		this.so_apprvd_date = so_apprvd_date;
		this.reply_mail_ids = reply_mail_ids;
		this.customer_code = customer_code;
		this.customer_name = customer_name;
		this.project = project;
		this.total_value = total_value;
		this.budget_value = budget_value;
		this.profit_amt = profit_amt;
		this.profit_perc = profit_perc;
		this.se_code = se_code;
		this.se_name = se_name;
		this.so_term = so_term;
	}

	// Approve Reject getter Setter and Constructor Coding end Here

}
