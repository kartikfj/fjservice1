/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author
 */
public class Regularisation {
	private String emp_code;
	private String emp_name;
	private String reason;
	private String project_details;
	private Timestamp applied_date;
	private Date regularise_date;
	private String approver_id;
	private String approver_eid;
	private String comp_code;
	private String chkinTime;
	private java.sql.Date cur_procm_startdt;
	private List<CustomerVisit> visitData = null;
	private int regOptnStatus = 0;
	private String sales_code;
	private int alrdyUpdtdVstCount = 0;
	private String customerName;
	private String projectName;
	private String reminderDesc;
	private String reminderType;
	private String partyName;
	private String userType;
	private int hsysId;

	public int getSendRegularisationRequest() {
		// System.out.println("USER OPERATION STATUS "+this.regOptnStatus);
		String projectDetails = this.project_details;
		String reason = this.reason;
		String mailSubject = "FJPortal-Regularisation Application ";
		if (this.regOptnStatus == 1) {
			projectDetails = "CUSTVISIT";
			mailSubject = "FJPortal- Regularisation with Customer Visit Application ";
			reason = "Customer Visit";
		}
		fjtcouser fusr = new fjtcouser();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;

		PreparedStatement psmt = null;
		// System.out.println(this.approver_eid + " " + this.approver_id + " " +
		// this.emp_name + " " + this.emp_code + " " + reason + " " +
		// this.regularise_date + " " + this.comp_code);
		String usrsql = "insert into  regularisation_application (uid,date_to_regularise,reason,applied_date,status,authorised_by,comp_code,project_code) values (?,?,?,?,?,?,?,?)";
		try {
			mcon.setAutoCommit(false);
			psmt = mcon.prepareStatement(usrsql);
			long curtime = System.currentTimeMillis();
			java.sql.Timestamp tp = new java.sql.Timestamp(curtime);
			this.applied_date = tp;
			psmt.setString(1, this.emp_code);
			psmt.setDate(2, this.regularise_date);
			psmt.setString(3, reason);
			psmt.setTimestamp(4, tp);
			psmt.setInt(5, 1);
			psmt.setString(6, this.approver_id);
			psmt.setString(7, this.comp_code);
			psmt.setString(8, projectDetails);
			psmt.executeUpdate();
			SSLMail sslmail = new SSLMail();
			long unqid = curtime;
			String msg = getRegularisationRequestMessageBody();
			sslmail.setToaddr(getApprover_eid());
			sslmail.setMessageSub(mailSubject + " - " + getEmp_name());
			sslmail.setMessagebody(msg);
			int status = sslmail.sendMail(fusr.getUrlAddress());
			if (status != 1) {
				mcon.rollback();
				System.out.print("Error in sending regularisation request...");
				retval = -1;
			} else {
				System.out.print("sent regularisation request...");
				mcon.commit();
				retval = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;

		} finally {
			try {
				if (psmt != null)
					;
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {

				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}

		return retval;

	}

	/**
	 * @return the emp_code
	 */
	public String getEmp_code() {
		return emp_code;
	}

	/**
	 * @param emp_code the emp_code to set
	 */
	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	/**
	 * @return the reason
	 */
	public String getReason() {
		return reason;
	}

	/**
	 * @param reason the reason to set
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * @return the applied_date
	 */
	public Timestamp getApplied_date() {
		return applied_date;
	}

	/**
	 * @param applied_date the applied_date to set
	 */
	public void setApplied_date(Timestamp applied_date) {
		this.applied_date = applied_date;
	}

	/**
	 * @return the regularise_date
	 */
	public Date getRegularise_date() {
		return regularise_date;
	}

	/**
	 * @param regularise_date the regularise_date to set
	 */
	public void setRegularise_date(Date regularise_date) {
		this.regularise_date = regularise_date;
	}

	/**
	 * @return the approver_id
	 */
	public String getApprover_id() {
		return approver_id;
	}

	/**
	 * @param approver_id the approver_id to set
	 */
	public void setApprover_id(String approver_id) {
		this.approver_id = approver_id;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getReminderDesc() {
		return reminderDesc;
	}

	public void setReminderDesc(String reminderDesc) {
		this.reminderDesc = reminderDesc;
	}

	public String getReminderType() {
		return reminderType;
	}

	public void setReminderType(String reminderType) {
		this.reminderType = reminderType;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public int getHsysId() {
		return hsysId;
	}

	public void setHsysId(int hsysId) {
		this.hsysId = hsysId;
	}

	private String getRegularisationRequestMessageBody() {
		fjtcouser fjuser = new fjtcouser();
		if (this.emp_name == null) {
			System.out.println("employee details not available.");
			return null;
		}

		if (this.regOptnStatus == 0 && (this.regularise_date == null || this.reason == null || this.approver_id == null
				|| this.approver_eid == null || this.chkinTime == null)) {
			System.out.println("Not all details available. Regularisation Only");
			return null;
		} else if (this.regOptnStatus == 1 && (this.regularise_date == null || this.approver_id == null
				|| this.approver_eid == null || this.chkinTime == null || this.visitData == null)) {
			System.out.println("Not all details available. Cust visit & Regularisation ");
			return null;
		} else {
			String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n"
					+ "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
			StringBuilder mbody = new StringBuilder("");
			mbody.append(div);
			mbody.append("A regularisation application is submitted for your approval.<br/>");
			mbody.append(
					"<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
			mbody.append("<tr><td><b>Employee Name </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + this.emp_name
					+ "</td></tr><tr><td><b>Employee code </b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + this.emp_code
					+ "</td></tr>");
			mbody.append("<tr><td><b>Regularisation Date </b></td><td><b>&nbsp;:&nbsp; </b></td><td> "
					+ getFormatedDateStr(this.regularise_date) + "</td></tr>");
			if (this.regOptnStatus == 0) {
				mbody.append(
						"<tr><td><b>Reason </b></td><td><b>&nbsp;:&nbsp; </b></td><td>" + this.reason + "</td></tr>");
			} else {
				mbody.append("<tr><td><b>Reason </b></td><td><b>&nbsp;:&nbsp; </b></td><td> Customer Visit</td></tr>");
			}
			mbody.append("<tr><td><b>Swipe Details </b></td><td>&nbsp;:&nbsp;</td><td> <span style=\"color:red;\"> "
					+ this.chkinTime + "</span></td><tr></table><br/>");

			if (this.regOptnStatus == 1)
				mbody.append(getCustomerVisitDetailsForMail());

			mbody.append(
					"<br/></div><table><tr><td align=\"center\"  bgcolor=\"#34a853\" style=\"padding: 5px;border-radius:2px;color:#ffffff;display:block\" >");
			mbody.append(
					"<a style=\"text-decoration:none;font-size:15px;font-family:Helvetica,Arial,sans-serif;text-decoration:none!important;width:100%;font-weight:bold;\" target=\"_blank\" data-saferedirecturl=\'"
							+ fjuser.getUrlAddress() + "\' href=\'" + fjuser.getUrlAddress()
							+ "LeaveProcess?ocjtfdinu=");
			// mbody.append("<a style='text-decoration: none;'
			// href=\'http://127.0.0.1:8090/fjtco/LeaveProcess?ocjtfdinu=");
			mbody.append(this.applied_date.getTime() + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver_id
					+ "&dpsroe=7&ntac=raluger' > <span style=\"color:#ffffff\"> Approve </span> </a> </td><td width=\"20\"></td>");
			mbody.append(
					"<td align=\"center\"  bgcolor=\"#ce3325\" style=\"padding: 5px;border-radius:2px;color:#ffffff;display:block\" >");
			mbody.append(
					"<a style=\"text-decoration:none;font-size:15px;font-family:Helvetica,Arial,sans-serif;text-decoration:none!important;width:100%;font-weight:bold;\" target=\"_blank\" ata-saferedirecturl=\'"
							+ fjuser.getUrlAddress() + "\' href=\'" + fjuser.getUrlAddress()
							+ "LeaveProcess?ocjtfdinu=");
			// mbody.append("<a style='text-decoration: none;'
			// href=\'http://127.0.0.1:8090/fjtco/LeaveProcess?ocjtfdinu=");
			mbody.append(this.applied_date.getTime() + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver_id
					+ "&dpsroe=5&ntac=raluger'> <span style=\"color:#ffffff\"> Reject</span> </a> </td></tr></table>");
			return mbody.toString();

		}

	}

	private String getCustomerVisitDetailsForMail() {
		String content = "<table style=\"padding:20px;\" bgcolor=\"#f5f1d9\" id=\"stkTable\" role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"f5f1d9\" cellpadding=\"0\" cellspacing=\"0\">"
				+ "<tr><th align=\"center\" colspan=\"5\"><span style=\"width:100%;color:#009688;font-size:18px;font-weight:bold;\">CUSTOMER VISIT</span><span style=\"color:#009688;font-size:18px;font-weight:bold;\">&nbsp;&nbsp;&nbsp;DETAILS</span></th></tr>";
		content += "<tr><td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Doc. ID</td>"
				+ "<td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Project</td>"
				+ "<td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Party</td>"
				+ "<td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Action Type</td>"
				+ "<td align=\"left\" width=\"85\" style=\"width: 85px;padding:5px;border:1px solid #ffffff;font-weight:bold;\">Time</td>"
				+ "<td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Contact Person Name</td>"
				+ "<td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Contact Person No.</td>"
				+ "<td align=\"left\" style=\"padding:5px;border:1px solid #ffffff;font-weight:bold;\">Action Desc.</td></tr>";
		if (this.alrdyUpdtdVstCount >= 1) {
			try {
				this.setVisitData(getAlrdyUpdatedCustVisitDetails());
			} catch (SQLException e) {
				System.out.println("Error in fetching customer dtls for sending reglzn mail  - 2");
				e.printStackTrace();
			}

		}
		Iterator<CustomerVisit> iterator = this.visitData.iterator();

		while (iterator.hasNext()) {
			CustomerVisit theVisitData = (CustomerVisit) iterator.next();
			// System.out.println("documentId: "+theVisitData.getDocumentId()+" segCode:
			// "+theVisitData.getSegCode()+" visitDate: "+theVisitData.getVisitDate()+"
			// actnDesc: "+theVisitData.getActnDesc()+" actionType:
			// "+theVisitData.getActionType()+" fromTime: "+theVisitData.getFromTime()+"
			// toTime: "+theVisitData.getToTime()+" project: "+theVisitData.getProject()+"
			// party: "+theVisitData.getPartyName());
			content += "<tr><td style=\"padding:5px;border:1px solid #ffffff\" >" + theVisitData.getDocumentId()
					+ "</td>" + "<td style=\"padding:5px;border:1px solid #ffffff\" >" + theVisitData.getProject()
					+ "</td><td style=\"padding:5px;border:1px solid #ffffff\" >" + theVisitData.getPartyName()
					+ "</td>  <td style=\"padding:5px;border:1px solid #ffffff\">" + theVisitData.getActionType()
					+ "</td>" + "<td width=\"85\" style=\"width: 85px;padding:5px;border:1px solid #ffffff\">"
					+ theVisitData.getFromTime() + "-" + theVisitData.getToTime() + "</td>"
					+ "<td style=\"padding:5px;border:1px solid #ffffff\">" + theVisitData.getCustomerName() + "</td>"
					+ "<td style=\"padding:5px;border:1px solid #ffffff\">" + theVisitData.getCustomerContactNo()
					+ "</td>" + "<td style=\"padding:5px;border:1px solid #ffffff\">" + theVisitData.getActnDesc()
					+ "</td></tr>";
		}
		content += "</table>";
		return content;
	}

	/**
	 * @return the approver_eid
	 */
	public String getApprover_eid() {
		return approver_eid;
	}

	/**
	 * @param approver_eid the approver_eid to set
	 */
	public void setApprover_eid(String approver_eid) {
		this.approver_eid = approver_eid;
	}

	/**
	 * @return the emap_name
	 */
	public String getEmp_name() {
		return emp_name;
	}

	/**
	 * @param emap_name the emap_name to set
	 */
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getFormatedDateStr(Date dt) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String text = formatter.format(dt);
		return text;
	}

	public void setRegularise_dateStr(String str) {
		// System.out.println(str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.regularise_date = new Date(dt.getTime());
		} catch (ParseException ex) {

			System.out.println("date error");
			this.regularise_date = null;
		}
	}

	/////////////////
	public int processApplicationApproval(long tp, int status) {
		java.sql.Timestamp tmp = new java.sql.Timestamp(tp);
		this.applied_date = tmp;
		int appstatus = isApplicationProcessedAlready();
		if (appstatus == 4 || appstatus == 3) {
			return -1; // already processed
		}
		if (appstatus == -2 || appstatus == 0) {
			return appstatus;
		}
		int retval = -2;
		if (appstatus == 1) {
			fjtcouser fusr = new fjtcouser();
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			Connection mcon = con.getMysqlConn();
			if (mcon == null)
				return -2;
			PreparedStatement psmt = null;
			// System.out.println(tp);
			String usrsql = "update  regularisation_application  set status = ?, authorised_by = ?, authorised_date = ? where uid=? and applied_date = ?";
			try {
				java.util.Date utilDate = new java.util.Date();
				java.sql.Date today = new java.sql.Date(utilDate.getTime());
				psmt = mcon.prepareStatement(usrsql);
				psmt.setInt(1, status);
				psmt.setString(2, this.approver_id);
				psmt.setDate(3, today);
				psmt.setString(4, this.emp_code);
				psmt.setTimestamp(5, tmp);
				int nor = psmt.executeUpdate();
				if (nor == 1) {
					// System.out.println("Updated backend");
					if (status == 4) { // approval
						retval = 1;
						String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
						String msg = this.getResponseMessageBody("Your regularisation application is approved.");
						SSLMail sslmail = new SSLMail();
						sslmail.setToaddr(toaddr);
						sslmail.setMessageSub("Regularisation Application Approved");
						sslmail.setMessagebody(msg);
						sslmail.sendMail(fusr.getUrlAddress());
						System.out.print("sent...");

					} else if (status == 3) {
						retval = 1;
						String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
						System.out.print(toaddr);
						String msg = this.getResponseMessageBody("Your regularisation application is rejected.");
						SSLMail sslmail = new SSLMail();
						sslmail.setToaddr(toaddr);
						sslmail.setMessageSub("Regularisation Application Rejected");
						sslmail.setMessagebody(msg);
						sslmail.sendMail(fusr.getUrlAddress());
						System.out.print("sent...");
					} // properly done
				} else {
					System.out.println("No records updated!");
					retval = 0;
				}

			} catch (Exception e) {
				e.printStackTrace();
				retval = -2;

			} finally {
				try {
					if (psmt != null)
						;
					psmt.close();
					con.closeConnection();

				} catch (SQLException e) {

					System.out.println("Exception in closing DB resources");
					retval = -2;
				}
			}

		}
		return retval;
	}

	private int isApplicationProcessedAlready() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usrsql = "select status,date_to_regularise,reason from  regularisation_application where uid=? and applied_date = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setTimestamp(2, this.applied_date);
			rs = psmt.executeQuery();
			if (rs.next()) {
				int status = rs.getInt(1);
				// System.out.println(status);
				if (status == 1) {
					this.regularise_date = rs.getDate(2);
					this.reason = rs.getString(3);
				}
				retval = status;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					;
				psmt.close();
				con.closeConnection();
			} catch (SQLException e) {

				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}

		return retval;
	}

	private String getResponseMessageBody(String response) {
		if (this.emp_code == null)
			return null;
		StringBuilder mbody = new StringBuilder("");
		mbody.append(response);
		mbody.append("<br/>Employee Code :" + this.emp_code + "<br/>");
		mbody.append("<br/>Application type: Regularisation.<br/>");
		mbody.append("Regularised date: " + getFormatedDateStr(this.regularise_date) + "<br/>");
		mbody.append("Reason : " + this.reason + "<br/>");
		return mbody.toString();
	}

	/**
	 * @return the comp_code
	 */
	public String getComp_code() {
		return comp_code;
	}

	/**
	 * @param comp_code the comp_code to set
	 */
	public void setComp_code(String comp_code) {
		this.comp_code = comp_code;
	}

	/**
	 * @return the cur_procm_startdt
	 */
	public java.sql.Date getCur_procm_startdt() {
		return cur_procm_startdt;
	}

	/**
	 * @param cur_procm_startdt the cur_procm_startdt to set
	 */
	public void setCur_procm_startdt(java.sql.Date cur_procm_startdt) {
		this.cur_procm_startdt = cur_procm_startdt;
	}

	/**
	 * @return the project_details
	 */
	public String getProject_details() {
		return project_details;
	}

	/**
	 * @param project_details the project_details to set
	 */
	public void setProject_details(String project_details) {
		this.project_details = project_details;
	}

	/**
	 * @return the chkinTime
	 */
	public String getChkinTime() {
		return chkinTime;
	}

	/**
	 * @param chkinTime the chkinTime to set
	 */
	public void setChkinTime(String chkinTime) {
		this.chkinTime = chkinTime;
	}

	// CUSTOMER VISIT START
	/**
	 * @return the visitData
	 */
	public List<CustomerVisit> getVisitData() {
		return visitData;
	}

	/**
	 * @param visitData the project_details to set
	 */

	public void setVisitData(List<CustomerVisit> visitData) {
		this.visitData = visitData;
	}

	public int getCustomerVisitDetailsInsertStatus() throws SQLException {
		/*
		 * for (CustomerVisit visits : this.visitData){
		 * 
		 * System.out.println( "ID : "+visits.getId() + "Document : " +
		 * visits.getDocumentId() + " Project : " +
		 * visits.getProject()+" F-T : "+visits.getFromTime()+" - "+visits.getToTime()
		 * +" Description : "+visits.getActnDesc()); }
		 */
		int logCount = 0;
		// System.out.println(" VISIT LIST LENGTH = "+this.visitData.size());
		if (this.visitData != null && this.visitData.size() <= 7) {
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			Iterator<CustomerVisit> iterator = this.visitData.iterator();
			try {
				myCon = orcl.getOrclConn();
				String sql = " INSERT  INTO FJPORTAL.CUS_VIST_ACTION(ACT_DOC_ID, ACT_SM_CODE, ACT_DT, ACT_DESC, ACT_TYPE, ACT_FM_TM,  ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME, CONT_PERSON, CONT_NUMBER, ACT_CR_DT) "
						+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE) ";
				myStmt = myCon.prepareStatement(sql);
				myCon.setAutoCommit(false);

				while (iterator.hasNext()) {
					CustomerVisit theVisitData = (CustomerVisit) iterator.next();

					myStmt.setString(1, theVisitData.getDocumentId());
					myStmt.setString(2, this.getSales_code());
					myStmt.setDate(3, this.getRegularise_date());
					myStmt.setString(4, theVisitData.getActnDesc());
					myStmt.setString(5, theVisitData.getActionType());
					myStmt.setString(6, theVisitData.getFromTime());
					myStmt.setString(7, theVisitData.getToTime());
					myStmt.setString(8, theVisitData.getProject());
					myStmt.setString(9, theVisitData.getPartyName());
					myStmt.setString(10, theVisitData.getCustomerName());
					myStmt.setString(11, theVisitData.getCustomerContactNo());

					myStmt.addBatch();
				}

				// Create an int[] to hold returned values
				int[] affectedRecords = myStmt.executeBatch();
				myCon.commit();
				logCount = affectedRecords.length;
				// System.out.println("Final Cust visit count after updates = " + logCount);

			} catch (SQLException e) {

				e.printStackTrace();
				if (myCon != null) {
					try {
						// STEP 3 - Roll back transaction
						System.out.println("Transaction is being rolled back. Customer visit updates" + logCount);
						myCon.rollback();
						logCount = 0;
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}

			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
			return logCount;
		} else {
			return logCount;
		}
	}

	public List<CustomerVisit> getAlrdyUpdatedCustVisitDetails() throws SQLException {
		// fjtcouser fusr = new fjtcouser();
		List<CustomerVisit> custVisitDetails = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT ACT_DOC_ID, ACT_SM_CODE, ACT_DT, ACT_DESC, ACT_TYPE, ACT_FM_TM, ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME, CONT_PERSON, CONT_NUMBER FROM  FJPORTAL.CUS_VIST_ACTION WHERE "
					+ "   ACT_DT = TO_DATE(?, 'DD/MM/YYYY')   AND ACT_SM_CODE IN ( SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 AND ROWNUM = 1 ) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, getFormatedDateStr(this.getRegularise_date()));
			myStmt.setString(2, this.emp_code);
			// System.out.println (getFormatedDateStr(this.getRegularise_date())+" "+"
			// "+this.getRegularise_date()+" "+this.emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String segCode = myRes.getString(2);
				String visitDate = myRes.getString(3);
				String actnDesc = myRes.getString(4);
				String actionType = myRes.getString(5);
				String fromTime = myRes.getString(6);
				String toTime = myRes.getString(7);
				String project = myRes.getString(8);
				String party = myRes.getString(9);
				String customerName = myRes.getString(10);
				String customerContactNo = myRes.getString(11);
				CustomerVisit tmpVisitDtlls = new CustomerVisit(documentId, segCode, visitDate, actnDesc, actionType,
						fromTime, toTime, project, party, customerName, customerContactNo);
				custVisitDetails.add(tmpVisitDtlls);
			}

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					System.out.println("Error in fetching customer dtls for sending reglzn mail - 1");
					myCon.rollback();
					custVisitDetails = null;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return custVisitDetails;
	}

	public Date getSqlDate(String date2) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date date;
		java.util.Date dt;
		try {
			dt = formatter.parse(date2);
			// System.out.println(dt);
			date = new Date(dt.getTime());
		} catch (ParseException ex) {
			ex.printStackTrace();
			date = null;
		}

		return date;

	}
	// CUSTOMER VISIT END

	public int getRegOptnStatus() {
		return regOptnStatus;
	}

	public void setRegOptnStatus(int regOptnStatus) {
		this.regOptnStatus = regOptnStatus;
	}

	public int getAlrdyUpdtdVstCount() {
		return alrdyUpdtdVstCount;
	}

	public void setAlrdyUpdtdVstCount(int alrdyUpdtdVstCount) {
		this.alrdyUpdtdVstCount = alrdyUpdtdVstCount;
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

	public String getSales_code() {
		return sales_code;
	}

	public void setSales_code(String sales_code) {
		this.sales_code = sales_code;
	}

	public int getCustomerVisitPlannerDetailsInsertStatus() throws SQLException {

		int logCount = 0;
		// System.out.println(" VISIT LIST LENGTH = "+this.visitData.size());
		if (this.visitData != null && this.visitData.size() <= 7) {
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			Iterator<CustomerVisit> iterator = this.visitData.iterator();
			try {
				myCon = orcl.getOrclConn();
				String sql = " INSERT  INTO FJPORTAL.CUS_VIST_PLANNER(ACT_DOC_ID, ACT_SM_CODE, ACT_DT, ACT_DESC, ACT_TYPE, ACT_FM_TM,  ACT_TO_TM, ACT_PROJ_NAME, ACT_PARTY_NAME, CONT_PERSON, CONT_NUMBER,EMP_CODE) "
						+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
				myStmt = myCon.prepareStatement(sql);
				myCon.setAutoCommit(false);

				while (iterator.hasNext()) {
					CustomerVisit theVisitData = (CustomerVisit) iterator.next();

					myStmt.setString(1, theVisitData.getDocumentId());
					myStmt.setString(2, this.getSales_code());
					myStmt.setDate(3, this.getRegularise_date());
					myStmt.setString(4, theVisitData.getActnDesc());
					myStmt.setString(5, theVisitData.getActionType());
					myStmt.setString(6, theVisitData.getFromTime());
					myStmt.setString(7, theVisitData.getToTime());
					myStmt.setString(8, theVisitData.getProject());
					myStmt.setString(9, theVisitData.getPartyName());
					myStmt.setString(10, theVisitData.getCustomerName());
					myStmt.setString(11, theVisitData.getCustomerContactNo());
					myStmt.setString(12, this.emp_code);
					myStmt.addBatch();
				}

				// Create an int[] to hold returned values
				int[] affectedRecords = myStmt.executeBatch();
				myCon.commit();
				logCount = affectedRecords.length;
				// System.out.println("Final Cust visit count after updates = " + logCount);

			} catch (SQLException e) {

				e.printStackTrace();
				if (myCon != null) {
					try {
						// STEP 3 - Roll back transaction
						System.out.println("Transaction is being rolled back. Customer visit updates" + logCount);
						myCon.rollback();
						logCount = 0;
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}

			} finally {
				close(myStmt, myRes);
				orcl.closeConnection();
			}
			return logCount;
		} else {
			return logCount;
		}
	}

	public int getReminderDetailsInsertStatus() throws SQLException {

		int logCount = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " INSERT  INTO FJPORTAL.SIP_REMINDER(QUOT_OR_ENQ_TYPE, REMINDER_DATE, REMINDER_DESC, QUOT_PROJ_NAME,H_SYS_ID, EMP_CODE, ACT_PARTY_NAME,USER_TYPE) "
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, this.getReminderType());
			myStmt.setDate(2, this.getRegularise_date());
			myStmt.setString(3, this.getReminderDesc());
			myStmt.setString(4, this.getProjectName());
			myStmt.setInt(5, this.getHsysId());
			myStmt.setString(6, this.emp_code);
			myStmt.setString(7, this.getPartyName());
			myStmt.setString(8, this.getUserType());
			logCount = myStmt.executeUpdate();
		} catch (

		SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					System.out.println("Transaction is being rolled back. Customer visit updates" + logCount);
					logCount = 0;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return logCount;

	}

}
