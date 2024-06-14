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
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author
 */
public class LeaveApplication {

	private Date fromdate;
	private Date todate;
	private Date resumedate;
	private String leavetype;
	private float leavedays;// total applied leave days from start date to end date without friday,starday
							// and holiday
	private String reason;
	private String leaveaddr;
	private String emp_code;
	private String comp_code;
	private String status;
	private String emp_name;
	private String approver;
	private String approverId;
	private String approverName;
	// private Date approveddt;
	private Timestamp approveddt;
	private long reqid;
	private Date proc_date;
	private Timestamp applied_date;
	private float leavebalance;
	private float totaldays;// total applied days from start date to end date including friday and starday
							// and holiday
	private String emp_divn_code = null;

	/**
	 * @return the fromdate
	 */
	public Date getFromdate() {
		return fromdate;
	}

	/**
	 * @param fromdate the fromdate to set
	 */
	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public LeaveApplication() {

	}

	public LeaveApplication(String leavetype, Date fromdate, Date todate, Date resumedate, float leavedays,
			String reason, String emp_code, float totaldays, String comp_code, String approver, String emp_name,
			String emp_divn_code, Timestamp applied_date) {
		this.leavetype = leavetype;
		this.fromdate = fromdate;
		this.todate = todate;
		this.resumedate = resumedate;
		this.leavedays = leavedays;
		this.reason = reason;
		this.emp_code = emp_code;
		this.totaldays = totaldays;
		this.comp_code = comp_code;
		this.approver = approver;
		this.emp_name = emp_name;
		this.emp_divn_code = emp_divn_code;
		this.applied_date = applied_date;
	}

	public void setFromdateStr(String str) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.fromdate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.fromdate = null;
		}

	}

	/**
	 * @return the todate
	 */
	public Date getTodate() {
		return todate;
	}

	/**
	 * @param todate the todate to set
	 */
	public void setTodateStr(String str) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.todate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.todate = null;
		}
	}

	public void setTodate(Date todate) {
		this.todate = todate;
	}

	/**
	 * @return the resumedate
	 */
	public Date getResumedate() {
		return resumedate;
	}

	public void setResumedateStr(String str) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.resumedate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.resumedate = null;
		}
	}

	/**
	 * @param resumedate the resumedate to set
	 */
	public void setResumedate(Date resumedate) {
		this.resumedate = resumedate;
	}

	/**
	 * @return the leavetype
	 */
	public String getLeavetype() {
		return leavetype;
	}

	/**
	 * @param leavetype the leavetype to set
	 */
	public void setLeavetype(String leavetype) {
		this.leavetype = leavetype;
	}

	/**
	 * @return the leavedays
	 */
	public float getLeavedays() {
		return leavedays;
	}

	/**
	 * @param leavedays the leavedays to set
	 */
	public void setLeavedays(float leavedays) {
		this.leavedays = leavedays;
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
	 * @return the leaveaddr
	 */
	public String getLeaveaddr() {
		return leaveaddr;
	}

	/**
	 * @param leaveaddr the leaveaddr to set
	 */
	public void setLeaveaddr(String leaveaddr) {
		this.leaveaddr = leaveaddr;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	public String getFormatedDateStr(Date dt) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String text = formatter.format(dt);
		return text;
	}

	public String getLeavResponseMessageBody(String response) {
		if (this.emp_code == null)
			return null;
		String leavecatName = null;
		if (this.leavetype.equalsIgnoreCase("LWP")) {
			leavecatName = "Leave without Pay";
		} else {
			LeaveEntry lv = new LeaveEntry();
			leavecatName = lv.getLeaveCategoryByCode(this.leavetype);
		}

		if (leavecatName == null)
			return null;

		StringBuilder mbody = new StringBuilder("");
		mbody.append(response);
		mbody.append("<br/>Leave type: " + leavecatName + "<br/>");
		mbody.append("Starting date: " + getFormatedDateStr(this.fromdate) + "<br/>");
		mbody.append("Ending date: " + getFormatedDateStr(this.todate) + "<br/>");
		mbody.append("Number of days: " + this.leavedays + "<br/>");
		if (this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("COMPASIONATE")) {
			mbody.append("Leave balance: " + this.leavebalance + "<br/>");
		}
		mbody.append("Resume date : " + getFormatedDateStr(this.resumedate) + "<br/>");
		mbody.append("Reason : " + this.reason + "<br/>");
		return mbody.toString();

	}

	public String getLeaveApplicationMessageBody(String leavecatName, long unqid, String stage) {
		fjtcouser fusr = new fjtcouser();
		if (this.emp_name == null) {
			System.out.println("employee details not available.");
			return null;
		}

		if (this.fromdate == null || this.leaveaddr == null || this.leavedays == 0 || this.leavetype == null
				|| this.reason == null || this.resumedate == null || this.todate == null) {
			System.out.println("Not all leave details available.");
			return null;
		}
		if ((this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("ELV") || this.leavetype.equalsIgnoreCase("COMPASIONATE"))
				&& this.leavebalance == -1) {
			System.out.println("Not all leave details available.");
			return null;
		}
		// System.out.println(unqid);
		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		mbody.append("A leave application is submitted for your approval.<br/><br/>");
		mbody.append("Employee name: " + emp_name + "&nbsp;&nbsp;(Employee code :" + this.emp_code + ")<br/>");
		mbody.append("Leave type: " + leavecatName + "<br/>");
		mbody.append("Starting date: " + getFormatedDateStr(this.fromdate) + "<br/>");
		mbody.append("Ending date: " + getFormatedDateStr(this.todate) + "<br/>");
		mbody.append("Number of Leave days: " + this.leavedays + "<br/>");
		// System.out.println("Number of Calendar Days "+this.totaldays+" Leave days
		// "+this.leavedays);
		mbody.append("Number of Calendar days: " + this.totaldays + "<br/>");
		if (this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("ELV") || this.leavetype.equalsIgnoreCase("COMPASIONATE")) {
			mbody.append("Leave balance: " + this.leavebalance + "<br/>");
		}
		mbody.append("Resume date : " + getFormatedDateStr(this.resumedate) + "<br/>");
		mbody.append("Reason : " + this.reason + "<br/></br></div>");
		mbody.append("<div style=\"width: auto;\n" + "float: left;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "border-radius: 3px;\n"
				+ "-webkit-border-radius: 3px;\n" + "-moz-border-radius: 3px;\n" + "border: 1px solid #a31d16;\n"
				+ "cursor: pointer;\">");
		mbody.append("<a style='text-decoration: none;' href='" + fusr.getUrlAddress() + "LeaveProcess?ocjtfdinu=");
		// mbody.append("<a style='text-decoration: none;'
		// href=\'http://fjprtl.dyndns.org:6080/fjhr/LeaveProcess?ocjtfdinu=");
		// mbody.append("<a style='text-decoration: none;'
		// href=\'http://127.0.01:8090/fjtco/LeaveProcess?ocjtfdinu=");
		if (this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("ELV") || this.leavetype.equalsIgnoreCase("COMPASIONATE")) {
			if (stage.equalsIgnoreCase("1")) { // manager approval
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver
						+ "&dpsroe=6&ntac=grulae&epyt=1&egats=1&lvbal=" + this.leavebalance
						+ "&signedBy=fjtco' target='_blank'>Authorise</a></div>");
			} else { // hr approval
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver
						+ "&dpsroe=7&ntac=grulae&epyt=1&egats=2&lvbal=" + this.leavebalance
						+ "&signedBy=fjtco' target='_blank'>Approve</a></div>");
			}
		} else {
			mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver
					+ "&dpsroe=7&ntac=grulae&epyt=2&egats=1&signedBy=fjtco' target='_blank'>Approve</a></div>");
		}

		mbody.append("<div style=\"width: auto;\n" + "float: left;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "border-radius: 3px;\n"
				+ "-webkit-border-radius: 3px;\n" + "-moz-border-radius: 3px;\n" + "border: 1px solid #a31d16;\n"
				+ "cursor: pointer;\">");
		mbody.append(
				"&nbsp;<a style='text-decoration: none;' href='" + fusr.getUrlAddress() + "LeaveProcess?ocjtfdinu=");
		// mbody.append("&nbsp;<a style='text-decoration: none;'
		// href=\'http://fjprtl.dyndns.org:6080/fjhr/LeaveProcess?ocjtfdinu=");
		// mbody.append("<a style='text-decoration: none;'
		// href=\'http://127.0.01:8090/fjtco/LeaveProcess?ocjtfdinu=");
		if (this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("ELV") || this.leavetype.equalsIgnoreCase("COMPASIONATE")) {
			if (stage.equalsIgnoreCase("1")) {
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver
						+ "&dpsroe=5&ntac=grulae&epyt=1&egats=1&lvbal=" + this.leavebalance + "&signedBy=fjtco' "
						+ " target='_blank'>Reject</a></div>");
			} else {
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver
						+ "&dpsroe=5&ntac=grulae&epyt=1&egats=2&lvbal=" + this.leavebalance
						+ "&signedBy=fjtco' target='_blank'>Reject</a></div>");
			}
		} else
			mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver
					+ "&dpsroe=5&ntac=grulae&epyt=2&egats=1&signedBy=fjtco' target='_blank'>Reject</a></div>");
		return mbody.toString();
	}

	/**
	 * @return the emp_name
	 */
	public String getEmp_name() {
		return emp_name;
	}

	/**
	 * @param emp_name the emp_name to set
	 */
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public int isLeaveApplicationProcessedAlready() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;

		ResultSet rs = null;// uid,fromdate,todate,leavetype,leavedays,reason,resumedate,address,status,applied_date
		String usrsql = "select status,leavetype,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid from  leave_application where uid=? and applied_date = ? and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setTimestamp(2, this.applied_date);
			rs = psmt.executeQuery();
			if (rs.next()) {
				int status = rs.getInt(1);
				if (status == 1 || status == 2) {
					this.leavetype = rs.getString(2);
					this.fromdate = rs.getDate(3);
					this.todate = rs.getDate(4);
					this.resumedate = rs.getDate(5);
					this.leavedays = rs.getFloat(6);
					this.reason = rs.getString(7);
					this.leaveaddr = rs.getString(8);
					this.comp_code = rs.getString(9);
					this.reqid = rs.getLong(10);
					// this.setApplied_date(tmp);//new java.sql.Date(tmp.getTime());
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

	public int processApplicationApproval(long tp, int status, String type, String stage) {
		java.sql.Timestamp tmp = new java.sql.Timestamp(tp);
		this.applied_date = tmp;
		int retval = -2;
		int appstatus = isLeaveApplicationProcessedAlready();
		if (appstatus == -2 || appstatus == 0) {
			return appstatus; // DB errors
		}

		if (type.equalsIgnoreCase("1") && stage.equalsIgnoreCase("2")) { // medical leave , emergency leave and
																			// compassionate approve by hr action
			if (appstatus == 4 || appstatus == 3) { // already rejected or approved
				return -1;
			} else if (appstatus == 2) { // authorised leave, proceed to approve or reject
				fjtcouser fusr = new fjtcouser();
				if (verifyApplicationBeforeInsert() != 1) {
					System.out.print("Not a viable application in type 1 stage 2 case");
					String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
					String empname = fusr.getEmpNameByUid(this.emp_code);
					// System.out.print(toaddr);
					StringBuilder msgl = new StringBuilder("Dear ");
					msgl.append(empname + "(" + this.emp_code + "),");
					msgl.append("<br/>Your leave application cannot be processed.");
					msgl.append(
							"Either an application exists for the same timespan or you do not have enough leave balance.");
					msgl.append("Please cancel this application and submit a new one.");
					String msg = this.getLeavResponseMessageBody(msgl.toString());
					if (msg == null)
						msg = msgl.toString();
					// System.out.println(msg);
					SSLMail sslmail = new SSLMail();
					sslmail.setToaddr(toaddr);
					sslmail.setMessageSub("Leave Application can not be processed");
					sslmail.setMessagebody(msg);
					int mstatus = sslmail.sendMail(fusr.getUrlAddress());
					if (mstatus == 1) {
						System.out.print(" Mail sent...");
						retval = -3;
					} else
						System.out.print("Error in sending mail");
					retval = -4;

				} else { // valid application
					MysqlDBConnectionPool con = new MysqlDBConnectionPool();
					Connection mcon = con.getMysqlConn();
					if (mcon == null)
						return -2;
					PreparedStatement psmt = null;

					String usrsql = "update leave_application  set status = ?, approved_by = ?, approved_date = ? where uid=? and applied_date = ?";
					try {
						java.util.Date utilDate = new java.util.Date();
						// java.sql.Date today = new java.sql.Date(utilDate.getTime());
						java.sql.Timestamp today = new java.sql.Timestamp(utilDate.getTime());
						this.approveddt = today;
						mcon.setAutoCommit(false);
						psmt = mcon.prepareStatement(usrsql);
						psmt.setInt(1, status); // 4 or 3
						psmt.setString(2, this.approver);
						// psmt.setDate(3, today);
						psmt.setTimestamp(3, today);
						psmt.setString(4, this.emp_code);
						psmt.setTimestamp(5, tmp);
						int nor = psmt.executeUpdate();

						if (nor == 1) {
							if (status == 4) { // approval
								this.approverName = fusr.getEmpNameByUid(this.approver);
								int oranstatus;
								oranstatus = insertOrionLeaveApplication();
								// }
								if (oranstatus == 1) {
									mcon.commit();
									retval = 1;
									// System.out.println("updated");

									String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
									String empname = fusr.getEmpNameByUid(this.emp_code);
									// System.out.print(toaddr);
									StringBuilder msgl = new StringBuilder("Dear ");
									msgl.append(empname + "(" + this.emp_code + "),<br/>");
									msgl.append("Your leave application is approved.");
									String msg = this.getLeavResponseMessageBody(msgl.toString());
									SSLMail sslmail = new SSLMail();
									sslmail.setToaddr(toaddr);
									sslmail.setMessageSub("Leave Application approved");
									sslmail.setMessagebody(msg);
									int mststus = sslmail.sendMail(fusr.getUrlAddress());
									if (mststus == 1)
										System.out.print("Mail sent...");
									else {
										retval = -4;
									}

								} else {
									mcon.rollback();
									System.out.print("Error in updating Oracle");
									retval = -2;
								}
							} else if (status == 3) {
								mcon.commit();
								retval = 1;
								// fjtcouser fusr = new fjtcouser();
								String empname = fusr.getEmpNameByUid(this.emp_code);
								StringBuilder msgl = new StringBuilder("Dear ");
								msgl.append(empname + "(" + this.emp_code + "),<br/>");
								String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
								msgl.append("Your leave application is rejected.");
								String msg = this.getLeavResponseMessageBody(msgl.toString());
								SSLMail sslmail = new SSLMail();
								sslmail.setToaddr(toaddr);
								sslmail.setMessageSub("Leave Application");
								sslmail.setMessagebody(msg);
								int mstatsus = sslmail.sendMail(fusr.getUrlAddress());
								if (mstatsus == 1) {
									System.out.println("Mail sent ...");
								} else {
									retval = -4;
								}
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

			}
		} else if (type.equalsIgnoreCase("2") || (type.equalsIgnoreCase("1") && stage.equalsIgnoreCase("1"))) {
			// medical leave , authorise action or other kind of leaves - only one level of
			// approval
			if (((appstatus == 4 || appstatus == 3) && type.equalsIgnoreCase("2")) || (type.equalsIgnoreCase("1")
					&& stage.equalsIgnoreCase("1") && (appstatus == 2 || appstatus == 3))) {
				// already rejected or approved
				return -1;
			}
			if (appstatus == 1) {
				fjtcouser fusr = new fjtcouser();
				int verifycode = 1;
				if (status != 3)
					verifycode = verifyApplicationBeforeInsert();
				if (verifycode != 1) {
					System.out.print("Not a viable application in type 2 stage 1");
					String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
					String empname = fusr.getEmpNameByUid(this.emp_code);
					StringBuilder msgl = new StringBuilder("Dear ");
					msgl.append(empname + "(" + this.emp_code + "),<br/>");

					//
					msgl.append("Your leave application cannot be processed.");
					msgl.append(
							"Either an application exists for the same timespan or you do not have enough leave balance.");
					msgl.append("Please cancel this application and submit a new one.");
					String msg = this.getLeavResponseMessageBody(msgl.toString());
					if (msg == null)
						msg = msgl.toString();
					// System.out.println(msg);
					SSLMail sslmail = new SSLMail();
					sslmail.setToaddr(toaddr);
					sslmail.setMessageSub("Leave Application can not be processed");
					sslmail.setMessagebody(msg);
					int mailstatus = sslmail.sendMail(fusr.getUrlAddress());
					if (mailstatus == 1) {
						retval = -3;
						System.out.print("Mail sent...");
					} else {
						retval = -4;
					}
					//////////////

				} else {
					MysqlDBConnectionPool con = new MysqlDBConnectionPool();
					Connection mcon = con.getMysqlConn();
					if (mcon == null)
						return -2;
					PreparedStatement psmt = null;
					// System.out.println(tp);
					// String spllevesql = "update leave_application set status = ?, authorised_by =
					// ?, authorised_date = ?, approved_startdt = ?, approved_endt = ? where uid=?
					// and applied_date = ?";
					String usrsql = "update  leave_application  set status = ?, authorised_by = ?, authorised_date = ?, approved_by = ?, approved_date = ?, approved_startdt = ?, approved_endt = ? where uid=? and applied_date = ?";
					try {
						java.util.Date utilDate = new java.util.Date();
						// java.sql.Date today = new java.sql.Date(utilDate.getTime());
						java.sql.Timestamp today = new java.sql.Timestamp(utilDate.getTime());
						this.approveddt = today;
						mcon.setAutoCommit(false);
						psmt = mcon.prepareStatement(usrsql);

						psmt.setInt(1, status);
						psmt.setString(2, this.approver);
						// psmt.setDate(3, today);
						psmt.setTimestamp(3, today);
						if ((type.equalsIgnoreCase("1") && stage.equalsIgnoreCase("1"))) { // SLV or SLVI or ELV or
																							// COMPASSIONATE authorise
							psmt.setNull(4, Types.VARCHAR);
							psmt.setNull(5, Types.DATE);
						} else {
							psmt.setString(4, this.approver);
							// psmt.setDate(5, today);
							psmt.setTimestamp(5, today);
						}

						psmt.setDate(6, this.fromdate);
						psmt.setDate(7, this.todate);
						psmt.setString(8, this.emp_code);
						psmt.setTimestamp(9, tmp);
						int nor = psmt.executeUpdate();
						// System.out.println("no. recs"+nor);

						if (nor == 1) {
							// System.out.println("Updated backend");
							if (status == 4) { // approval
								this.approverName = fusr.getEmpNameByUid(this.approver);
								int oranstatus;
								if (this.leavetype.equalsIgnoreCase("LWP")) {
									oranstatus = insertOrionLWPApplication();
								} else {
									oranstatus = insertOrionLeaveApplication();
								}
								if (oranstatus == 1) {
									mcon.commit();
									retval = 1;
									// System.out.println("updated");

									String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
									String empname = fusr.getEmpNameByUid(this.emp_code);
									StringBuilder msgl = new StringBuilder("Dear ");
									msgl.append(empname + "(" + this.emp_code + "),<br/>");
									msgl.append("Your leave application is approved.");
									String msg = this.getLeavResponseMessageBody(msgl.toString());
									SSLMail sslmail = new SSLMail();
									sslmail.setToaddr(toaddr);
									sslmail.setMessageSub("Leave Application approved");
									sslmail.setMessagebody(msg);
									int mailstatus = sslmail.sendMail(fusr.getUrlAddress());
									if (mailstatus == 1) {
										retval = 1;
										System.out.print("Mail sent..." + toaddr);
									} else {
										retval = -4;
									}

								} else {
									mcon.rollback();
									System.out.print("Error in updating Oracle");
									retval = -2;
								}
							} else if (status == 3) {
								mcon.commit();
								retval = 1;
								// fjtcouser fusr = new fjtcouser();
								String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
								String empname = fusr.getEmpNameByUid(this.emp_code);
								StringBuilder msgl = new StringBuilder("Dear ");
								msgl.append(empname + "(" + this.emp_code + "),<br/>");
								msgl.append("Your leave application is rejected.");
								String msg = this.getLeavResponseMessageBody(msgl.toString());
								SSLMail sslmail = new SSLMail();
								sslmail.setToaddr(toaddr);
								sslmail.setMessageSub("Leave Application");
								sslmail.setMessagebody(msg);
								int mailstatus = sslmail.sendMail(fusr.getUrlAddress());
								if (mailstatus == 1) {
									retval = 1;
									System.out.print("sent..." + toaddr);
								} else {
									retval = -4;
								}

							} // properly done
							else if (status == 2) { // ELV or SLV or SLVI or COMPASSIONATE authorised, forward to hr

								// get hrid
								this.emp_name = fusr.getEmpNameByUid(this.emp_code);
								LeaveEntry lv = new LeaveEntry();
								String lvcatname = null;
								if (this.leavetype.equalsIgnoreCase("LWP"))
									lvcatname = "Leave Without Pay";
								else
									lvcatname = lv.getLeaveCategoryByCode(this.leavetype);

								if (lvcatname != null) {

									String msg = this.getLeaveApplicationMessageBody(lvcatname, tp, "2");
									SSLMail sslmail = new SSLMail();
									String toaddr = getHREmailidForLeaveApplication();
									// sslmail.setToaddr("nufail.a@fjtco.com");
									sslmail.setToaddr(toaddr);
									sslmail.setMessageSub("FJHRPortal-Leave Application-" + getEmp_name());
									sslmail.setMessagebody(msg);
									int mailstatus = sslmail.sendMail(fusr.getUrlAddress());
									if (mailstatus == 1) {
										System.out.print("sent..." + toaddr);
										mcon.commit();
										retval = 1;
									} else {
										System.out.print("failed to send mail...");
										mcon.rollback();
										retval = -4;
									}
								} else {
									System.out.print("error in generating mail...");
									mcon.rollback();
									retval = -4;
								}
							}
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
			}

		}

		return retval;
	}

	public String getHREmailidForLeaveApplication() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return null;
		String retval = null;
		PreparedStatement psmt = null;

		ResultSet rs = null; // status,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid
		String usrsql = "select emailid from  emailconf where usagetype='HR'";
		try {
			psmt = mcon.prepareStatement(usrsql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
				// retval = "rajakumari.ch@fjtco.com";
			}

		} catch (Exception e) {
			e.printStackTrace();

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
				retval = null;
			}
		}

		return retval;
	}

	public int insertOrionLeaveApplication() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		Leave lv = new Leave();
		lv.setEmp_code(this.emp_code);
		lv.setEmp_comp_code(this.comp_code);
		lv.setCur_leave_type(this.leavetype);
		float actual_lv_bal = lv.getLeaveBalanceOf();
		PreparedStatement psmt = null;
		int retval = 0;
		// StringBuilder sqlstr = new StringBuilder("INSERT INTO
		// ORION.PT_LEAVE_APPLICATION_HEAD
		// (LVAH_COMP_CODE,LVAH_DT,LVAH_EMP_CODE,LVAH_LV_CATG_CODE,LVAH_DAYS,LVAH_ADD_1,");
		StringBuilder sqlstr = new StringBuilder(
				"INSERT INTO FJPORTAL.PT_LEAVE_APPLICATION_HEAD (LVAH_COMP_CODE,LVAH_DT,LVAH_EMP_CODE,LVAH_LV_CATG_CODE,LVAH_DAYS,LVAH_ADD_1,");
		sqlstr.append(
				"LVAH_SYS_ID,LVAH_TXN_CODE,LVAH_NO,LVAH_REF_FROM,LVAH_LV_TYPE_CODE,LVAH_CR_UID,LVAH_CR_DT,LVAH_START_DT,LVAH_END_DT,LVAH_REMARKS,LVAH_APPR_START_DT,LVAH_APPR_END_DT,LVAH_APPR_DAYS,LVAH_ACTUAL_LV_DAYS)");
		sqlstr.append(" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,CURRENT_DATE,?,?,?,?,?,?,?)");
		try {
			java.util.Date today = new java.util.Date();
			java.sql.Date appldt = new java.sql.Date(this.getApplied_date().getTime());
			String remarks = "Inserted by FJPortal, Approved by " + this.approverName + "(" + this.approver + ") on "
					+ today.toString();
			psmt = con.prepareStatement(sqlstr.toString());
			psmt.setString(1, this.comp_code);
			psmt.setDate(2, appldt);
			psmt.setString(3, this.emp_code);
			psmt.setString(4, this.leavetype);
			psmt.setFloat(5, this.leavedays);
			psmt.setString(6, this.leaveaddr);
			psmt.setLong(7, this.reqid);
			psmt.setString(8, "0");
			psmt.setInt(9, (int) this.reqid);
			psmt.setString(10, "D");
			psmt.setString(11, "0");
			psmt.setString(12, "FJTPORTAL");
			psmt.setDate(13, this.fromdate);
			psmt.setDate(14, this.todate);
			psmt.setString(15, remarks);// remarks inserted by fjport
			psmt.setDate(16, this.fromdate);
			psmt.setDate(17, this.todate);
			psmt.setFloat(18, this.leavedays);
			psmt.setFloat(19, actual_lv_bal);
			retval = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				// if(rs!=null)
				// rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int verifyApplicationBeforeInsert() {
		int status1 = this.getCheckLeaveClash();
		System.out.println("LeaveClash" + status1);
		if (status1 != 1)
			return status1;
		status1 = this.getCheckLWPClash();
		System.out.println("LeaveLWP" + status1);
		if (status1 != 1)
			return status1;
		if (this.leavetype.equalsIgnoreCase("LWP") || this.leavetype.equalsIgnoreCase("AN30")
				|| this.leavetype.equalsIgnoreCase("AN60") || this.leavetype.equalsIgnoreCase("AN15"))
			return status1;
		status1 = 0;

		java.sql.Date date = new java.sql.Date(this.fromdate.getTime());
		SimpleDateFormat simpDate = new SimpleDateFormat("dd/MM/yyyy");
		String dtstr = (simpDate.format(date));
		// System.out.print(dtstr);
		Leave lv = new Leave();
		lv.setCur_leave_type(this.leavetype);
		lv.setEmp_code(this.emp_code);
		lv.setEmp_comp_code(comp_code);
		lv.setCur_fromdt(dtstr);
		double accuredlv = lv.getCallfunctionasSQL();
		System.out.println("accuredlv :" + accuredlv);
		int curbal = lv.getCurrentAccruedLeave();
		System.out.println("curbal :" + curbal);
		if (accuredlv >= 0 || curbal >= 0) {
			System.out.println("IN IFF :" + this.leavedays);
			if (this.leavedays <= (accuredlv + curbal))
				status1 = 1;
		} else
			status1 = 0;
		System.out.println("status1 :" + status1);
		return status1;

	}

	/**
	 * check if any other LWP application exists in orion in the given time span
	 */
	public int getCheckLWPClash() {
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();
		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// String usrsql="SELECT * FROM ORION.PT_LWP WHERE LWP_EMP_CODE = ? AND
		// LWP_COMP_CODE =? AND ((? between LWP_FROM_DT and LWP_UPTO_DT) or (? between
		// LWP_FROM_DT and LWP_UPTO_DT) or (? <=LWP_FROM_DT and ? >=LWP_UPTO_DT))";
		String usrsql = "SELECT * FROM FJPORTAL.PT_LWP WHERE LWP_EMP_CODE = ? AND LWP_COMP_CODE =?  AND ((? between LWP_FROM_DT and LWP_UPTO_DT) or (? between LWP_FROM_DT and LWP_UPTO_DT) or (? <=LWP_FROM_DT and ? >=LWP_UPTO_DT))";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.comp_code);
			psmt.setDate(3, this.fromdate);
			psmt.setDate(4, this.todate);
			psmt.setDate(5, this.fromdate);
			psmt.setDate(6, this.todate);
			rs = psmt.executeQuery();
			if (!rs.next()) {
				retval = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				retval = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return retval;
	}

	/**
	 * check if any other leave application exists in orion in the given time span
	 */
	public int getCheckLeaveClash() {
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();
		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// String usrsql="SELECT * FROM ORION.PT_LEAVE_APPLICATION_HEAD WHERE
		// LVAH_EMP_CODE = ? AND LVAH_CANC_UID IS NULL AND LVAH_COMP_CODE =? AND ((?
		// between LVAH_START_DT and LVAH_END_DT) or (? between LVAH_START_DT and
		// LVAH_END_DT) or (? <=LVAH_START_DT and ? >=LVAH_END_DT))";
		String usrsql = "SELECT * FROM FJPORTAL.PT_LEAVE_APPLICATION_HEAD WHERE LVAH_EMP_CODE = ? AND LVAH_CANC_UID IS NULL AND LVAH_COMP_CODE =?  AND ((? between LVAH_START_DT and LVAH_END_DT) or (? between LVAH_START_DT and LVAH_END_DT) or (? <=LVAH_START_DT and ? >=LVAH_END_DT))";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.comp_code);
			psmt.setDate(3, this.fromdate);
			psmt.setDate(4, this.todate);
			psmt.setDate(5, this.fromdate);
			psmt.setDate(6, this.todate);
			rs = psmt.executeQuery();
			if (!rs.next()) {
				retval = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				retval = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return retval;
	}

	/**
	 * get LWP balance
	 */
	public float getLWPBalance() {
		return 0;
	}

	/**
	 * @return the approver
	 */
	public String getApprover() {
		return approver;
	}

	/**
	 * @param approver the approver to set
	 */
	public void setApprover(String approver) {
		this.approver = approver;
	}

	/**
	 * @return the approverId
	 */
	public String getApproverId() {
		return approverId;
	}

	/**
	 * @param approverId the approverId to set
	 */
	public void setApproverId(String approverId) {
		this.approverId = approverId;
	}

	public long generateUid() {
		long uid = 0;
		try {
			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			java.util.Date date = formatter.parse("01/01/2010");
			uid = System.currentTimeMillis() - date.getTime();
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
		}
		return uid;
	}

	public int isApplicationFeasible(java.sql.Date curprocdate) {
		// System.out.print("proc month "+curprocdate);
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;

		ResultSet rs = null; // status,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid
		String usrsql = "select reqid from  leave_application where uid=? and cancel_date=NULL and comp_code=? and fromdate > ? and (status !=3 or status!=4 or status!=2) and ((? between fromdate and todate) or (? between fromdate and todate) or (? <=fromdate and ? >=todate))";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.comp_code);
			psmt.setDate(3, curprocdate);
			psmt.setDate(4, fromdate);
			psmt.setDate(5, todate);
			psmt.setDate(6, fromdate);
			psmt.setDate(7, todate);
			rs = psmt.executeQuery();
			if (!rs.next()) {
				retval = 1;
			} else
				retval = 0;

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

	public int getSendApplicationForApproval() {
		// float test=this.totaldays;
		// System.out.println("Total Days include friday,sat and holiday
		// "+this.totaldays);
		fjtcouser fusr = new fjtcouser();
		int valid = this.isApplicationFeasible(this.proc_date);
		// System.out.println(valid);
		if (valid != 1)
			return valid;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;

		PreparedStatement psmt = null;
		String usrsql = "insert into  leave_application (uid,fromdate,todate,leavetype,leavedays,reason,resumedate,address,status,applied_date,comp_code,authorised_by,totaldays) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			mcon.setAutoCommit(false);
			psmt = mcon.prepareStatement(usrsql);
			long curtime = System.currentTimeMillis();
			java.sql.Timestamp tp = new java.sql.Timestamp(curtime);
			psmt.setString(1, this.emp_code);
			psmt.setDate(2, this.getFromdate());
			psmt.setDate(3, getTodate());
			psmt.setString(4, getLeavetype());
			psmt.setFloat(5, getLeavedays());
			psmt.setString(6, getReason());
			psmt.setDate(7, getResumedate());
			psmt.setString(8, getLeaveaddr());
			psmt.setInt(9, 1);
			psmt.setTimestamp(10, tp);
			psmt.setString(11, this.comp_code);
			psmt.setString(12, this.approver);
			psmt.setFloat(13, getTotaldays());
			int logType = psmt.executeUpdate();
			if (logType > 0) {
				System.out.println("logType" + logType);
				LeaveEntry lv = new LeaveEntry();
				String lvcatname = null;
				if (this.leavetype.equalsIgnoreCase("LWP"))
					lvcatname = "Leave Without Pay";
				else
					lvcatname = lv.getLeaveCategoryByCode(this.leavetype);
				System.out.println("lvcatname== " + lvcatname);
				if (lvcatname == null) {
					System.out.println("Error in sending mail- Error in filling leave category name.");
					retval = -1;
				} else {
					System.out.println("else== ");
					SSLMail sslmail = new SSLMail();
					String unqid = curtime + this.emp_code;
					System.out.println("unqid==" + unqid);
					String msg = getLeaveApplicationMessageBody(lvcatname, curtime, "1");
					if (msg != null) {
						sslmail.setToaddr(getApproverId());
						sslmail.setMessageSub("FJHRPortal-Leave Application-" + getEmp_name());
						sslmail.setMessagebody(msg);
						logType = sslmail.sendMail(fusr.getUrlAddress());
						if (logType != 1) {
							System.out.println("logType == " + logType);
							mcon.rollback();
							retval = -1;
						} else {
							System.out.println("commit == ");
							mcon.commit();
							retval = 1;
							System.out.print("sent...");
						}
					} else {
						System.out.println("error in email generation: ");
						retval = -1;
					}
				}
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
	 * @return the proc_date
	 */
	public Date getProc_date() {
		return proc_date;
	}

	/**
	 * @param proc_date the proc_date to set
	 */
	public void setProc_date(Date proc_date) {
		this.proc_date = proc_date;
	}

	private int insertOrionLWPApplication() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;

		PreparedStatement psmt = null;
		int retval = 0;

		// StringBuilder sqlstr = new StringBuilder("INSERT INTO ORION.PT_LWP
		// (LWP_COMP_CODE,LWP_DT,LWP_EMP_CODE,LWP_DAYS,");
		StringBuilder sqlstr = new StringBuilder(
				"INSERT INTO FJPORTAL.PT_LWP (LWP_COMP_CODE,LWP_DT,LWP_EMP_CODE,LWP_DAYS,");
		sqlstr.append(
				"LWP_SYS_ID,LWP_TXN_CODE,LWP_NO,LWP_REF_FROM,LWP_CR_UID,LWP_CR_DT,LWP_FROM_DT,LWP_UPTO_DT,LWP_REMARKS)");
		sqlstr.append(" VALUES (?,?,?,?,?,?,?,?,?,CURRENT_DATE,?,?,?)");
		try {
			java.util.Date today = new java.util.Date();
			java.sql.Date appldt = new java.sql.Date(this.getApplied_date().getTime());
			String remarks = "Inserted by FJPortal, Approved by " + this.approverName + "(" + this.approver + ") on "
					+ today.toString();
			psmt = con.prepareStatement(sqlstr.toString());
			psmt.setString(1, this.comp_code);
			psmt.setDate(2, appldt);
			psmt.setString(3, this.emp_code);
			psmt.setFloat(4, this.leavedays);
			psmt.setLong(5, this.reqid);
			psmt.setString(6, "0");
			psmt.setInt(7, (int) this.reqid);
			psmt.setString(8, "D");
			psmt.setString(9, "FJTPORTAL");
			psmt.setDate(10, this.fromdate);
			psmt.setDate(11, this.todate);
			psmt.setString(12, remarks);// remarks inserted by fjport

			retval = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	/**
	 * @return the applied_date
	 */

	public long getApplied_dateinMillis() {
		return applied_date.getTime();
	}

	public Timestamp getApplied_date() {
		return applied_date;
	}

	/**
	 * @pvalue="${current.applied_dateinMillis}"/>aram applied_date the applied_date
	 * to set
	 */
	public void setApplied_date(Timestamp applied_date) {
		this.applied_date = applied_date;
	}

	public void setApplied_dateFromStr(String applieddtStr) {
		long millis = Long.parseLong(applieddtStr);
		this.applied_date = new Timestamp(millis);
		// System.out.println(applied_date);
		// this.applied_date = applied_date;
	}

	public int getCancelLeaveApplication() {
		int appstatus = isLeaveApplicationProcessedAlready();
		if (appstatus == 4 || appstatus == 3) {
			// System.out.println("approved or rejected");
			// approved or rejected
			return -1;
		}
		if (appstatus == -2 || appstatus == 0) {
			// System.out.println("cancelled application or not found");
			return appstatus; // cancelled application or not found.
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;

		//
		String usrsql = "update  leave_application set cancel_date=NOW() where uid=? and applied_date = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setTimestamp(2, this.applied_date);
			retval = psmt.executeUpdate();
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
	 * @return the leavebalance
	 */
	public float getLeavebalance() {
		return leavebalance;
	}

	/**
	 * @param leavebalance the leavebalance to set
	 */
	public void setLeavebalance(float leavebalance) {
		this.leavebalance = leavebalance;
	}

	/**
	 * @return the totaldays
	 */
	public float getTotaldays() {
		return totaldays;
	}

	/**
	 * @param totaldays the totaldays to set
	 */
	public void setTotaldays(float totaldays) {
		this.totaldays = totaldays;
	}

	public String getEmp_divn_code() {
		return emp_divn_code;
	}

	public void setEmp_divn_code(String emp_divn_code) {
		this.emp_divn_code = emp_divn_code;
	}

	public List<LeaveApplication> getSickLeaveRequest() throws ParseException {

		List<LeaveApplication> sickleavesObj = new ArrayList<>();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int year = Calendar.getInstance().get(Calendar.YEAR);
		String s = "01/01/" + year;
		java.util.Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(s);
		java.sql.Date sqlDate = new java.sql.Date(date1.getTime());
		System.out.println("sqlDate== " + sqlDate);

		PreparedStatement psmt = null;
		ResultSet rs = null;
		// Modified to display all the leaves-- compasionate,sick,medical to HR
		// String usrsql = " SELECT leavetype, fromdate, todate,resumedate, leavedays,
		// reason, uid, totaldays,comp_code,authorised_by,applied_date from
		// leave_application where status=2 and cancel_date is NULL and (leavetype='SLV'
		// || leavetype='SLVI' || leavetype='SLVW') and fromdate > ? order by
		// applied_date asc";
		String usrsql = " SELECT leavetype, fromdate, todate,resumedate, leavedays, reason, uid, totaldays,comp_code,authorised_by,applied_date from leave_application where status=2 and cancel_date is NULL  and fromdate > ? order by applied_date asc";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, sqlDate);
			rs = psmt.executeQuery();
			while (rs.next()) {

				this.leavetype = rs.getString(1);
				this.fromdate = rs.getDate(2);
				this.todate = rs.getDate(3);
				this.resumedate = rs.getDate(4);
				this.leavedays = rs.getFloat(5);
				this.reason = rs.getString(6);
				this.emp_code = rs.getString(7);
				this.totaldays = rs.getFloat(8);
				this.comp_code = rs.getString(9);
				this.approver = rs.getString(10);
				this.applied_date = rs.getTimestamp(11);
				boolean empExists = getEmpNameByUid(this.emp_code);
				if (empExists) {
					LeaveApplication empslvlist = new LeaveApplication(leavetype, fromdate, todate, resumedate,
							leavedays, reason, emp_code, totaldays, comp_code, approver, emp_name, emp_divn_code,
							applied_date);
					sickleavesObj.add(empslvlist);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

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
			}
		}

		return sickleavesObj;
	}

	public boolean getEmpNameByUid(String id) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		boolean isExists = false;
		Connection con = orcl.getOrclConn();
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String sqlstr = "SELECT EMP_NAME,EMP_DIVN_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.emp_name = rs.getString(1);
				this.emp_divn_code = rs.getString(2);
				isExists = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return isExists;
	}

}
