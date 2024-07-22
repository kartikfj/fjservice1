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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 
 */
public class LeaveEncashment {

	private Date effectivedate;
	private String leavetype;
	private float encashdays;
	private String reason;
	private String emp_code;
	private String comp_code;
	private String status;
	private String emp_name;
	private String approver_id;
	private String approverEId;
	private String approverName;
	private Timestamp applied_date;
	private int reqid;
	private String lv_desc;
	private Date responsedate;

	/**
	 * check if there is enough balance days to meet the request.
	 */
	int isApplicationFeasible() {
		Leave lv = new Leave();
		lv.setEmp_code(this.emp_code);
		lv.setEmp_comp_code(this.comp_code);
		lv.setCur_leave_type(this.leavetype);
		int status = lv.getCurrentAccruedLeave();
		if (status < 0) {
			return -1; // error in processing.
		}
		if (this.encashdays <= status) {
			return 1;
		} else {
			return 0;
		}
	}

	/**
	 * receives strings and construct date
	 */
	public void setEffectivedateStr(String str) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.effectivedate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.effectivedate = null;
		}
	}

	/**
	 * check if application is processed already
	 */
	public int isLeaveApplicationProcessedAlready() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null) {
			return -2;
		}
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usrsql = "select status,leave_catcode,effective_date,leave_encash_days,remarks,cmp_code,reqid from  leave_encashments where emp_code=? and applied_date = ? and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setTimestamp(2, this.applied_date);
			rs = psmt.executeQuery();
			if (rs.next()) {
				int status = rs.getInt(1);
				// System.out.println(status);
				if (status == 1) {
					this.leavetype = rs.getString(2);
					this.effectivedate = rs.getDate(3);
					this.encashdays = rs.getFloat(4);
					this.reason = rs.getString(5);
					this.comp_code = rs.getString(6);
					this.reqid = rs.getInt(7);

				}
				retval = status;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;

		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
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
	 * process the response of leave encashment request
	 */
	public int processApplicationApproval(long tp, int status) {
		java.sql.Timestamp tmp = new java.sql.Timestamp(tp);
		this.applied_date = tmp;
		int appstatus = isLeaveApplicationProcessedAlready();
		if (appstatus == 4 || appstatus == 3) {
			return -1;
		}
		if (appstatus == -2 || appstatus == 0) {
			return appstatus;
		}
		int retval = -2;
		if (appstatus == 1) {
			fjtcouser fusr = new fjtcouser();
			if (isApplicationFeasible() != 1 && status == 4) {
				System.out.print("Not a viable application");
				String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
				// System.out.print(toaddr);
				StringBuilder msgl = new StringBuilder("Your leave encashment application cannot be processed.");
				msgl.append(" You do not have enough leave balance.");
				msgl.append("Please cancel this application and submit a new one.");
				String msg = this.getLeavResponseMessageBody(msgl.toString());
				SSLMail sslmail = new SSLMail();
				sslmail.setToaddr(toaddr);
				sslmail.setMessageSub("Leave Encashment Application can not be processed");
				sslmail.setMessagebody(msg);
				int mstatus = sslmail.sendMail(fusr.getUrlAddress());
				if (mstatus == 1) {
					System.out.print("Mail sent...");
					retval = -3;
				} else {
					System.out.print("Error in Mail...");
					retval = -4;
				}
			}
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			Connection mcon = con.getMysqlConn();
			if (mcon == null) {
				return -2;
			}
			PreparedStatement psmt = null;
			// System.out.println(tp);
			String usrsql = "update  leave_encashments  set status = ?, approved_by = ?, response_date = ? where emp_code=? and applied_date = ?";
			try {
				java.util.Date utilDate = new java.util.Date();
				java.sql.Date today = new java.sql.Date(utilDate.getTime());
				this.responsedate = today;
				mcon.setAutoCommit(false);
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
						this.approverName = fusr.getEmpNameByUid(this.approver_id);
						int oranstatus = insertOrionLeaveApplication();
						if (oranstatus == 1) {
							mcon.commit();
							retval = 1;
							// System.out.println("updated");

							String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
							System.out.print(toaddr);
							String msg = this
									.getLeavResponseMessageBody("Your leave encashment application is approved.");
							SSLMail sslmail = new SSLMail();
							sslmail.setToaddr(toaddr);
							sslmail.setMessageSub("Leave Encashment Application approved");
							sslmail.setMessagebody(msg);
							int mstatus = sslmail.sendMail(fusr.getUrlAddress());
							if (mstatus == 1) {
								System.out.print("Mail sent...");

							} else {
								System.out.print("Error in mail...");
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
						String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
						System.out.print(toaddr);
						String msg = this.getLeavResponseMessageBody("Your leave encashment application is rejected.");
						SSLMail sslmail = new SSLMail();
						sslmail.setToaddr(toaddr);
						sslmail.setMessageSub("Leave Encashment Application");
						sslmail.setMessagebody(msg);
						// sslmail.sendMail();
						// System.out.print("sent...");
						////////////
						int mailstatus = sslmail.sendMail(fusr.getUrlAddress());
						if (mailstatus == 1) {
							retval = 1;
							System.out.print("Mail sent...");
						} else {
							System.out.print("Error in mail...");
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
		return retval;

	}

	/**
	 *
	 * sends the encashment application for approval
	 */
	public int getSendLeaveEncashmentForApproval() {
		fjtcouser fusr = new fjtcouser();
		int valid = isApplicationFeasible();
		// System.out.println(valid);
		if (valid != 1) {
			return valid;
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null) {
			return -2;
		}
		int retval = 0;

		PreparedStatement psmt = null;

		String usrsql = "insert into  leave_encashments (emp_code,cmp_code,effective_date,leave_catcode,leave_encash_days,remarks,applied_date,status,authorised_by) values (?,?,?,?,?,?,?,?,?)";
		try {
			psmt = mcon.prepareStatement(usrsql);
			long curtime = System.currentTimeMillis();
			java.sql.Timestamp tp = new java.sql.Timestamp(curtime);
			// System.out.println(tp);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.comp_code);
			psmt.setDate(3, this.effectivedate);
			psmt.setString(4, this.leavetype);
			psmt.setFloat(5, this.encashdays);
			psmt.setString(6, this.reason);
			psmt.setTimestamp(7, tp);
			psmt.setInt(8, 1);
			psmt.setString(9, this.approver_id);
			psmt.executeUpdate();
			SSLMail sslmail = new SSLMail();
			long unqid = curtime;
			String msg = getLeaveEncashmentMessageBody(unqid);
			sslmail.setToaddr(getApproverEId());
			sslmail.setMessageSub("FJHRPortal-Leave Encashment Application-" + getEmp_name());
			sslmail.setMessagebody(msg);
			int mailstatus = sslmail.sendMail(fusr.getUrlAddress());
			if (mailstatus == 1) {
				System.out.print("sent...");
				retval = 1;
			} else {
				System.out.print("Error in mail...");
				retval = -3;
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
	/*
	 * generates message for for leave encashment application
	 */

	public String getLeaveEncashmentMessageBody(long unqid) {
		fjtcouser fusr = new fjtcouser();
		if (this.emp_name == null) {
			System.out.println("employee details not available.");
			return null;
		}

		if (this.effectivedate == null || this.encashdays == 0 || this.leavetype == null || this.reason == null) {
			System.out.println("Not all leave details available.");
			return null;
		}
		// System.out.println(unqid);
		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		mbody.append("A leave encashment application is submitted for your approval.<br/><br/>");
		mbody.append("Employee name: " + emp_name + "<br/>");
		mbody.append("Effective date: " + getFormatedDateStr(this.effectivedate) + "<br/>");
		mbody.append("Number of days: " + this.encashdays + "<br/>");
		mbody.append("Remarks : " + this.reason + "<br/></br></div>");
		mbody.append("<div style=\"width: auto;\n" + "float: left;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "border-radius: 3px;\n"
				+ "-webkit-border-radius: 3px;\n" + "-moz-border-radius: 3px;\n" + "border: 1px solid #a31d16;\n"
				+ "cursor: pointer;\">");
		mbody.append(
				"<a style='text-decoration: none;' href='"+fusr.getUrlAddress()+"LeaveProcess?ocjtfdinu=");
		// mbody.append("<a style='text-decoration: none;'
		// href=\'http://127.0.01:8090/fjhr/LeaveProcess?ocjtfdinu=");
		mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver_id
				+ "&dpsroe=7&ntac=hsacne&signedBy=fjtco' target='_blank'>Approve</a></div>");
		mbody.append("<div style=\"width: auto;\n" + "float: left;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "border-radius: 3px;\n"
				+ "-webkit-border-radius: 3px;\n" + "-moz-border-radius: 3px;\n" + "border: 1px solid #a31d16;\n"
				+ "cursor: pointer;\">");
		mbody.append(
				"&nbsp;<a style='text-decoration: none;' href='"+fusr.getUrlAddress()+"LeaveProcess?ocjtfdinu=");
		// mbody.append("<a style='text-decoration: none;'
		// href=\'http://127.0.01:8090/fjtco/LeaveProcess?ocjtfdinu=");
		mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approver_id
				+ "&dpsroe=5&ntac=hsacne&signedBy=fjtco' target='_blank'>Reject</a></div>");
		return mbody.toString();
	}

	/**
	 * @return the effectivedate
	 */
	public Date getEffectivedate() {
		return effectivedate;
	}

	public String getFormatedDateStr(Date dt) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String text = formatter.format(dt);
		return text;
	}

	/**
	 * @param effectivedate
	 *            the effectivedate to set
	 */
	public void setEffectivedate(Date effectivedate) {
		this.effectivedate = effectivedate;
	}

	/**
	 * @return the leavetype
	 */
	public String getLeavetype() {
		return leavetype;
	}

	/**
	 * @param leavetype
	 *            the leavetype to set
	 */
	public void setLeavetype(String leavetype) {
		this.leavetype = leavetype;
	}

	/**
	 * @return the encashdays
	 */
	public float getEncashdays() {
		return encashdays;
	}

	/**
	 * @param encashdays
	 *            the encashdays to set
	 */
	public void setEncashdays(float encashdays) {
		this.encashdays = encashdays;
	}

	/**
	 * @return the reason
	 */
	public String getReason() {
		return reason;
	}

	/**
	 * @param reason
	 *            the reason to set
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * @return the emp_code
	 */
	public String getEmp_code() {
		return emp_code;
	}

	/**
	 * @param emp_code
	 *            the emp_code to set
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
	 * @param comp_code
	 *            the comp_code to set
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
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the emp_name
	 */
	public String getEmp_name() {
		return emp_name;
	}

	/**
	 * @param emp_name
	 *            the emp_name to set
	 */
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	/**
	 * @return the approver_id
	 */
	public String getApprover_id() {
		return approver_id;
	}

	/**
	 * @param approver_id
	 *            the approver_id to set
	 */
	public void setApprover_id(String approver_id) {
		this.approver_id = approver_id;
	}

	/**
	 * @return the approverEId
	 */
	public String getApproverEId() {
		return approverEId;
	}

	/**
	 * @param approverEId
	 *            the approverEId to set
	 */
	public void setApproverEId(String approverEId) {
		this.approverEId = approverEId;
	}

	/**
	 * @return the approverName
	 */
	public String getApproverName() {
		return approverName;
	}

	/**
	 * @param approverName
	 *            the approverName to set
	 */
	public void setApproverName(String approverName) {
		this.approverName = approverName;
	}

	/**
	 * @return the applied_date
	 */
	public Timestamp getApplied_date() {
		return applied_date;
	}

	/**
	 * @param applied_date
	 *            the applied_date to set
	 */
	public void setApplied_date(Timestamp applied_date) {
		this.applied_date = applied_date;
	}

	/**
	 * @return the reqid
	 */
	public int getReqid() {
		return reqid;
	}

	/**
	 * @param reqid
	 *            the reqid to set
	 */
	public void setReqid(int reqid) {
		this.reqid = reqid;
	}

	/**
	 * @return the lv_desc
	 */
	public String getLv_desc() {
		return lv_desc;
	}

	/**
	 * @param lv_desc
	 *            the lv_desc to set
	 */
	public void setLv_desc(String lv_desc) {
		this.lv_desc = lv_desc;
	}

	private String getLeavResponseMessageBody(String response) {
		if (this.emp_code == null) {
			return null;
		}
		LeaveEntry lv = new LeaveEntry();
		String leavecatName = lv.getLeaveCategoryByCode(this.leavetype);
		if (leavecatName == null) {
			return null;
		}
		StringBuilder mbody = new StringBuilder("");
		mbody.append(response);
		mbody.append("<br/>Application type: Leave encashment.<br/>");
		mbody.append("Effective date: " + getFormatedDateStr(this.effectivedate) + "<br/>");
		mbody.append("Number of days: " + this.encashdays + "<br/>");
		mbody.append("Reason : " + this.reason + "<br/>");
		return mbody.toString();
	}

	private int insertOrionLeaveApplication() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null) {
			return -2;
		}

		PreparedStatement psmt = null;
		int retval = 0;

		StringBuilder sqlstr = new StringBuilder();
		// sqlstr.append("INSERT INTO ORION.PT_LEAVE_ENCASH_HEAD
		// (LVEH_SYS_ID,LVEH_COMP_CODE,LVEH_TXN_CODE,LVEH_NO,LVEH_DT,LVEH_REF_FROM,"
		sqlstr.append(
				"INSERT INTO FJPORTAL.PT_LEAVE_ENCASH_HEAD (LVEH_SYS_ID,LVEH_COMP_CODE,LVEH_TXN_CODE,LVEH_NO,LVEH_DT,LVEH_REF_FROM,"
						+ "LVEH_EMP_CODE,LVEH_LV_CATG_CODE,LVEH_ALLW_CODE,LVEH_ENCASH_NO_DAYS,LVEH_CURR_CODE,LVEH_ENCASH_LC_AMOUNT,LVEH_ENCASH_FC_AMOUNT,LVEH_WS,LVEH_CR_UID,LVEH_CR_DT,LVEH_ANNOTATION,LVEH_EFFECTIVE_DT)");
		sqlstr.append("VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,CURRENT_DATE,?,?)");
		java.util.Date today = new java.util.Date();
		String annotation = "Inserted by FJPortal, Approved by " + this.approverName + "(" + this.approverName + ") on "
				+ today.toString();
		try {
			psmt = con.prepareStatement(sqlstr.toString());
			psmt.setInt(1, reqid);
			psmt.setString(2, this.comp_code);
			psmt.setString(3, "0");
			psmt.setInt(4, (int) reqid);
			psmt.setTimestamp(5, this.applied_date);
			psmt.setString(6, "D");
			psmt.setString(7, this.emp_code);
			psmt.setString(8, this.leavetype);
			psmt.setString(9, "LEN");
			psmt.setFloat(10, encashdays);
			psmt.setString(11, "0");
			psmt.setFloat(12, 0);
			psmt.setFloat(13, 0);
			psmt.setString(14, "S");
			psmt.setString(15, "FJPORTAL");
			psmt.setString(16, annotation);
			psmt.setDate(17, this.effectivedate);
			retval = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (psmt != null) {
					psmt.close();
				}
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public void setApplied_dateFromStr(String applieddtStr) {
		long millis = Long.parseLong(applieddtStr);
		this.applied_date = new Timestamp(millis);
		// System.out.println(applied_date);
	}

	public long getApplied_dateinMillis() {
		return applied_date.getTime();
	}

	public int getCancelEncashApplication() {
		int appstatus = isLeaveApplicationProcessedAlready();
		if (appstatus == 2 || appstatus == 3) { // approved or rejected
			return -1;
		}
		if (appstatus == -2 || appstatus == 0) {
			return appstatus; // cancelled application or not found or db error
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null) {
			return -2;
		}
		int retval = 0;
		PreparedStatement psmt = null;

		//
		String usrsql = "update  leave_encashments set cancel_date=NOW() where emp_code=? and applied_date = ?";
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
}
