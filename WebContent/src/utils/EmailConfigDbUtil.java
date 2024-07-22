package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import beans.Appraisal_Email_Status;
import beans.EmailConfig;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.fjtcouser;

 
public class EmailConfigDbUtil {

	public int submitGsMail(Appraisal_Email_Status mail_Details, String appr_mail_id, String emp_name, String emp_div,
			String emp_dept, String emp_location, String emp_job_title, String gsEndDt) throws SQLException {

		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table><tr>"
				+ "<th align=\"left\" colspan=\"6\">Employee Details<br/></th></tr><tr><td style=\"border-right: 2px solid #065685;\">Name : "
				+ emp_name + "</span>" + "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Position : "
				+ emp_job_title + "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Emp Code : "
				+ mail_Details.getEmp_id() + "</td>"
				+ "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Company : "
				+ mail_Details.getCompany()
				+ "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Department : " + emp_dept
				+ "</td>" + "<td style=\"padding-left: 2px;\">Location : " + emp_location
				+ "</td></tr><tr><td colspan=\"6\"><br/><br/></td></tr><tr>"
				+ "<td  align=\"left\" colspan=\"6\" style=\"padding-left: 5px;\">Goals have been submitted for your review. "
				+ "Please review with the employee and submit them before <b style=\"color:red;\">" + gsEndDt
				+ "</b> .<br/>" + "<br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJ-PORTAL for Appraisal Activity</strong></a>" + "<br/></td></tr></table>";
		sslmail.setToaddr(appr_mail_id);
		sslmail.setMessageSub("FJHRPortal-Appraisal Goal Setting Submitted by " + mail_Details.getEmp_name() + " for "
				+ mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "insert into email_submit_details(emp_id, year, company, division, emp_name,gs_submit_date,gs_submit_Status) values(?,?,?,?,?,NOW(),?)";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getEmp_id());
				myStmt.setString(2, mail_Details.getYear());
				myStmt.setString(3, mail_Details.getCompany());
				myStmt.setString(4, emp_div);
				myStmt.setString(5, emp_name);
				myStmt.setString(6, "YES");

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}

	}

	public int submitMidMail(Appraisal_Email_Status mail_Details, String appr_mail_id, String emp_name, String emp_div,
			String emp_dept, String emp_location, String emp_job_title, String midEndDate) throws SQLException {
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = "<table><tr>"
				+ "<th align=\"left\" colspan=\"6\">Employee Details<br/></th></tr><tr><td style=\"border-right: 2px solid #065685;\">Name : "
				+ emp_name + "</span>" + "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Position : "
				+ emp_job_title + "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Emp Code : "
				+ mail_Details.getEmp_id() + "</td>"
				+ "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Company : "
				+ mail_Details.getCompany()
				+ "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Department : " + emp_dept
				+ "</td>" + "<td style=\"padding-left: 2px;\">Location : " + emp_location
				+ "</td></tr><tr><td colspan=\"6\"><br/><br/></td></tr><tr>"
				+ "<td  align=\"left\" colspan=\"6\" style=\"padding-left: 5px;\"><br/>Mid Term progress has been submitted for your review. Please ensure, that you review with the employee and finalize before <b style=\"color:red;\">"
				+ midEndDate + "</b> . " + "<br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJ-PORTAL for Appraisal Activity</strong></a>" + "<br/></td></tr></table>";
		sslmail.setToaddr(appr_mail_id);
		sslmail.setMessageSub(
				"FJHRPortal-Mid Term Progress Submitted by " + emp_name + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set mid_submit_date=NOW(), mid_submit_Status=?  where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, "YES");
				myStmt.setString(2, mail_Details.getEmp_id());
				myStmt.setString(3, mail_Details.getYear());
				myStmt.setString(4, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	public int submitFinMail(Appraisal_Email_Status mail_Details, String appr_mail_id, String emp_name, String emp_div,
			String emp_dept, String emp_location, String emp_job_title, String finEndDate) throws SQLException {
		// System.out.println("mailid"+appr_mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table><tr>"
				+ "<th align=\"left\" colspan=\"6\">Employee Details<br/></th></tr><tr><td style=\"border-right: 2px solid #065685;\">Name : "
				+ emp_name + "</span>" + "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Position : "
				+ emp_job_title + "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Emp Code : "
				+ mail_Details.getEmp_id() + "</td>"
				+ "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Company : "
				+ mail_Details.getCompany()
				+ "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Department : " + emp_dept
				+ "</td>" + "<td style=\"padding-left: 2px;\">Location : " + emp_location
				+ "</td></tr><tr><td colspan=\"6\"><br/><br/></td></tr><tr>"
				+ "<td  align=\"left\" colspan=\"6\" style=\"padding-left: 5px;\"><br/>The Final Term Progress has been submitted for your review. Please ensure, that you have review with the employee and finalize it before <b style=\"color:red;\">"
				+ finEndDate + "</b> .<br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJ-PORTAL for Appraisal Activity</strong></a>" + "<br/></td>" + "</tr></table>";
		sslmail.setToaddr(appr_mail_id);
		sslmail.setMessageSub(
				"FJHRPortal-Final Term Appraisal Submitted by " + emp_name + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			// System.out.print("Error in sending Mail to Approver / Appraisee..."+status);
			return 0;
		} else {
			// System.out.print("Sent Submit Form Sucessfully..."+status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set fin_submit_date=NOW(), fin_submit_Status=?  where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, "YES");
				myStmt.setString(2, mail_Details.getEmp_id());
				myStmt.setString(3, mail_Details.getYear());
				myStmt.setString(4, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	public int ApproveGsMail(Appraisal_Email_Status mail_Details) throws SQLException {
		// System.out.println(mail_Details.getEmp_id()+mail_Details.getYear()+mail_Details.getCompany()+mail_Details.getGs_appr_id()+mail_Details.getGs_appr_name());
		String employee_Mail_id = getEmailIdByEmpcode(mail_Details.getEmp_id());
		// System.out.println("mail ID"+employee_Mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>"
				+ "<tr><td style=\"padding-left: 15px;\">This is to notify, that the Goals submitted by you, have been approved by your Approver.<br/>"
				+ "<br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJHRPortal for Appraisal Activity</strong></a>" + "<br/></td>" + "</tr></table>";
		sslmail.setToaddr(employee_Mail_id);
		sslmail.setMessageSub("FJHRPortal-Appraisal Goals of " + mail_Details.getEmp_id() + " Approved by  "
				+ mail_Details.getGs_appr_name() + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			// System.out.print("Sent Submit Form Sucessfully..."+status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set gs_approved_date=NOW(), gs_appr_id=?, gs_appr_name=?, gs_approved_Status=? where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getGs_appr_id());
				myStmt.setString(2, mail_Details.getGs_appr_name());
				myStmt.setString(3, "YES");
				myStmt.setString(4, mail_Details.getEmp_id());
				myStmt.setString(5, mail_Details.getYear());
				myStmt.setString(6, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	public int ApproveMidMail(Appraisal_Email_Status mail_Details) throws SQLException {
		// System.out.println(mail_Details.getEmp_id()+mail_Details.getYear()+mail_Details.getCompany()+mail_Details.getGs_appr_id()+mail_Details.getGs_appr_name());

		String employee_Mail_id = getEmailIdByEmpcode(mail_Details.getEmp_id());
		// System.out.println("mail ID"+employee_Mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>"
				+ "<tr><td style=\"padding-left: 15px;\">This is to notify, that the Mid Term Appraisal Progress submitted by you, has been approved, by your Approver.<br/>"
				+ "<br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJHRPortal for Appraisal Activity</strong></a>" + "<br/></td>" + "</tr></table>";
		sslmail.setToaddr(employee_Mail_id);
		sslmail.setMessageSub("FJHRPortal- Mid Term Progress of " + mail_Details.getEmp_id() + " Approved by  "
				+ mail_Details.getGs_appr_name() + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set mid_approved_date=NOW(), mid_appr_id=?, mid_appr_name=?, mid_approved_Status=? where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getGs_appr_id());
				myStmt.setString(2, mail_Details.getGs_appr_name());
				myStmt.setString(3, "YES");
				myStmt.setString(4, mail_Details.getEmp_id());
				myStmt.setString(5, mail_Details.getYear());
				myStmt.setString(6, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	public int ApproveFinMail(Appraisal_Email_Status mail_Details) throws SQLException {
		// System.out.println(mail_Details.getEmp_id()+mail_Details.getYear()+mail_Details.getCompany()+mail_Details.getGs_appr_id()+mail_Details.getGs_appr_name());
		String employee_Mail_id = getEmailIdByEmpcode(mail_Details.getEmp_id());
		// System.out.println("mail ID"+employee_Mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>"
				+ "<tr><td style=\"padding-left: 15px;\">This is to notify, that the Final Term Appraisal Progress submitted by you, has been approved, by your Approver.<br/>"
				+ "<br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJHRPortal for Appraisal Activity</strong></a>" + "<br/></td>" + "</tr></table>";
		sslmail.setToaddr(employee_Mail_id);
		sslmail.setMessageSub("FJHRPortal-Final Term Progress of " + mail_Details.getEmp_id() + " Approved by  "
				+ mail_Details.getGs_appr_name() + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set fin_approved_date=NOW(), fin_appr_id=?, fin_appr_name=?, fin_approved_Status=? where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getGs_appr_id());
				myStmt.setString(2, mail_Details.getGs_appr_name());
				myStmt.setString(3, "YES");
				myStmt.setString(4, mail_Details.getEmp_id());
				myStmt.setString(5, mail_Details.getYear());
				myStmt.setString(6, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	public int NotifyMidMail(Appraisal_Email_Status mail_Details) throws SQLException {
		String employee_Mail_id = getEmailIdByEmpcode(mail_Details.getEmp_id());
		// System.out.println("mail ID"+employee_Mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>" + "<tr><td style=\"padding-left: 15px;\">"
				+ "This is a notification sent to you, on the Mid Term Appraisal Progress. "
				+ "Your approver has asked for a review discussion on your progress."
				+ "Please finalize the dates and conduct the review at the earliest."
				+ "<br/><br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJHRPortal for Appraisal Activity</strong></a>" + "<br/></td>" + "</tr></table>";
		sslmail.setToaddr(employee_Mail_id);
		sslmail.setMessageSub("FJHRPortal-Mid Term Progress Review Notification of " + mail_Details.getEmp_id() + " by "
				+ mail_Details.getGs_appr_name() + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set mid_notify_date=NOW(), mid_notify_appr_id=?, mid_notify_appr_name=?, mid_notify_Status=? where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getGs_appr_id());
				myStmt.setString(2, mail_Details.getGs_appr_name());
				myStmt.setString(3, "YES");
				myStmt.setString(4, mail_Details.getEmp_id());
				myStmt.setString(5, mail_Details.getYear());
				myStmt.setString(6, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	public int NotifyFinMail(Appraisal_Email_Status mail_Details) throws SQLException {
		String employee_Mail_id = getEmailIdByEmpcode(mail_Details.getEmp_id());
		// System.out.println("mail ID"+employee_Mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>" + "<tr><td style=\"padding-left: 15px;\">"
				+ "This is a notification sent to you, on the Final Term Appraisal Progress."
				+ " Your approver has requested for a review discussion on your progress. "
				+ "Please finalize the dates and conduct a review at the earliest."
				+ "<br/><br/><a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJHRPortal for Appraisal Activity</strong></a>" + "<br/></td>" + "</tr></table>";
		sslmail.setToaddr(employee_Mail_id);
		sslmail.setMessageSub("FJHRPortal- Final Term Progress Review Notification of " + mail_Details.getEmp_id()
				+ "  by " + mail_Details.getGs_appr_name() + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set finnotify_date=NOW(), fin_notify_appr_id=?, fin_notify_appr_name=?, fin_notify_Status=? where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getGs_appr_id());
				myStmt.setString(2, mail_Details.getGs_appr_name());
				myStmt.setString(3, "YES");
				myStmt.setString(4, mail_Details.getEmp_id());
				myStmt.setString(5, mail_Details.getYear());
				myStmt.setString(6, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}

	private void close(Statement myStmt, ResultSet myRes) {

		try {
			if (myRes != null) {
				myRes.close();
			}
			if (myStmt != null) {
				myStmt.close();
			}

		} catch (Exception exc) {
			exc.printStackTrace();
		}

	}

	public int check_count(Appraisal_Email_Status mail_Details) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select count(emp_id) from email_submit_details where emp_id=? and year=? and company=?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, mail_Details.getEmp_id());
			myStmt.setString(2, mail_Details.getYear());
			myStmt.setString(3, mail_Details.getCompany());
			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				int count = myRes.getInt(1);
				// System.out.println("mail_status_count"+count);
				return count;

			}
			return 0;

		} finally {
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public String checkGoalSettingEnddate(String theYear, String theCompany) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		String gsEndDate = "";
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select aprsleddt from appraisalhr_new where year=? and company= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theYear);
			myStmt.setString(2, theCompany);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				gsEndDate = myRes.getString(1);
				System.out.println("goal setting end date" + gsEndDate);

			}
			return gsEndDate;

		} finally {
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public String midTermEnddate(String theYear, String theCompany) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		String midEndDate = "";
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select mdaprsleddt from appraisalhr_new where year=? and company= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theYear);
			myStmt.setString(2, theCompany);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				midEndDate = myRes.getString(1);

			}
			return midEndDate;

		} finally {
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public String finalTermEnddate(String theYear, String theCompany) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		String finalEndDate = "";
		try {
			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select finaleddt from appraisalhr_new where year=? and company= ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theYear);
			myStmt.setString(2, theCompany);
			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				finalEndDate = myRes.getString(1);

			}
			return finalEndDate;

		} finally {
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public int updateSubmitGsMail(Appraisal_Email_Status mail_Details, String appr_mail_id, String emp_name,
			String emp_div, String emp_dept, String emp_location, String emp_job_title, String gsEndDt)
			throws SQLException {
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>" + "<tr>"
				+ "<th align=\"left\" colspan=\"6\">Employee Details<br/></th></tr><tr><td style=\"border-right: 2px solid #065685;\">Name : "
				+ emp_name + "</span>" + "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Position : "
				+ emp_job_title + "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Emp Code : "
				+ mail_Details.getEmp_id() + "</td>"
				+ "<td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Company : "
				+ mail_Details.getCompany()
				+ "</td><td style=\"border-right: 2px solid #065685;padding-left: 2px;\">Department : " + emp_dept
				+ "</td>" + "<td style=\"padding-left: 2px;\">Location : " + emp_location
				+ "</td></tr><tr><td colspan=\"6\"><br/><br/></td></tr><tr>"
				+ "<td  align=\"left\" colspan=\"6\" style=\"padding-left:5px;\">Goals have been submitted for your review.Please review with the employee and submit them before <b style=\"color:red;\">"
				+ gsEndDt + "</b>." + "<br/>" + "<a style=\"color:#065685;\" href=" + fusr.getUrlAddress()
				+ "><strong>Go To FJ-PORTAL for Appraisal Activity</strong></a>" + "<br/>" + "</td>" + "</tr></table>";
		sslmail.setToaddr(appr_mail_id);
		sslmail.setMessageSub("FJHRPortal-Appraisal Goal Setting Submitted by  " + mail_Details.getEmp_name() + " for "
				+ mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set gs_submit_date=NOW()  where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getEmp_id());
				myStmt.setString(2, mail_Details.getYear());
				myStmt.setString(3, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}

	}

	public String getEmailIdByEmpcode(String newempcode) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String retval = "nufail.a@fjtco.com";
			String sql = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
			// String sql = "SELECT TXNFIELD_FLD5 FROM ORION.PT_TXN_FLEX_FIELDS WHERE
			// TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, newempcode);
			myRes = myStmt.executeQuery();
			if (myRes.next()) {
				retval = myRes.getString(1);

			}
			return retval;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public int NotifyGSMail(Appraisal_Email_Status mail_Details) throws SQLException {
		String employee_Mail_id = getEmailIdByEmpcode(mail_Details.getEmp_id());
		// System.out.println("mail ID"+employee_Mail_id);
		EmailConfig sslmail = new EmailConfig();
		fjtcouser fusr = new fjtcouser();
		String msg = " <table>" + "<tr><td style=\"padding-left: 15px;\">This is a notification sent to you, on"
				+ " the goal setting progress." + " Your Approver has asked "
				+ "for a review discussion on the goal set by you. please finalize the dates and "
				+ "conduct the review at the earliest.<br/>" + "<br/><a style=\"color:#065685;\" href="
				+ fusr.getUrlAddress() + "><strong>Go To FJHRPortal for Appraisal Activity</strong></a>" + "<br/></td>"
				+ "</tr></table>";
		sslmail.setToaddr(employee_Mail_id);
		sslmail.setMessageSub("FJHRPortal- Goal Setting Review Notification of " + mail_Details.getEmp_id() + "  by "
				+ mail_Details.getGs_appr_name() + " for " + mail_Details.getYear());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to Approver / Appraisee..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {

				myCon = con.getMysqlConn();

				// INSERT INTO fjtco.email_submit_details(emp_id, year,
				// company,emp_name,gs_submit_date,gs_submit_Status) values()
				String sql = "update email_submit_details set gs_notify_date=NOW(), gs_notify_appr_id=?, gs_notify_appr_name=?, gs_notify_Status=? where emp_id=? and  year=? and company=?";
				myStmt = myCon.prepareStatement(sql);

				myStmt.setString(1, mail_Details.getGs_appr_id());
				myStmt.setString(2, mail_Details.getGs_appr_name());
				myStmt.setString(3, "YES");
				myStmt.setString(4, mail_Details.getEmp_id());
				myStmt.setString(5, mail_Details.getYear());
				myStmt.setString(6, mail_Details.getCompany());

				myStmt.execute();

			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
			return 1;
		}
	}
}
