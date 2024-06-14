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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BackDatedLeaveApplication {
	private Date fromdate;
	private Date todate;
	private Date resumedate;
	private String leavetype;
	private float leavedays;
	private String reason;
	private String leaveaddr;
	private String emp_code;
	private String comp_code;
	private String status;
	private String emp_name;
	private String approver;
	private String approverId;
	private long reqid;
	private Date proc_date;
	private Timestamp applied_date;
	private float leavebalance;
	private float totaldays;
	private String emp_divn_code = null;
	private ArrayList pendleaveapplications = null;
	private ConcurrentHashMap emp_leave_types = null;

	/**
	 * @return the fromdate
	 */
	public Date getFromdate() {
		return fromdate;
	}

	public ConcurrentHashMap getEmp_leave_types() {
		return emp_leave_types;
	}

	public void setEmp_leave_types(ConcurrentHashMap emp_leave_types) {
		this.emp_leave_types = emp_leave_types;
	}

	/**
	 * @param fromdate the fromdate to set
	 */
	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public BackDatedLeaveApplication() {

	}

	public BackDatedLeaveApplication(String leavetype, Date fromdate, Date todate, Date resumedate, float leavedays,
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

	public long getReqid() {
		return reqid;
	}

	public void setReqid(long reqid) {
		this.reqid = reqid;
	}

	public ArrayList getPendleaveapplications() {
		return pendleaveapplications;
	}

	public void setPendleaveapplications(ArrayList pendleaveapplications) {
		this.pendleaveapplications = pendleaveapplications;
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
		if (this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("ELV") || this.leavetype.equalsIgnoreCase("COMPASIONATE")) {
			if (stage.equalsIgnoreCase("1")) { // manager approval
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approverId
						+ "&dpsroe=6&ntac=grulae&epyt=1&egats=1&lvbal=" + this.leavebalance
						+ "&signedBy=fjtco' target='_blank'>Authorise</a></div>");
			} else { // hr approval
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approverId
						+ "&dpsroe=7&ntac=grulae&epyt=1&egats=2&lvbal=" + this.leavebalance
						+ "&signedBy=fjtco' target='_blank'>Approve</a></div>");
			}
		} else {
			mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approverId
					+ "&dpsroe=7&ntac=grulae&epyt=2&egats=1&signedBy=fjtco' target='_blank'>Approve</a></div>");
		}

		mbody.append("<div style=\"width: auto;\n" + "float: left;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "border-radius: 3px;\n"
				+ "-webkit-border-radius: 3px;\n" + "-moz-border-radius: 3px;\n" + "border: 1px solid #a31d16;\n"
				+ "cursor: pointer;\">");
		mbody.append(
				"&nbsp;<a style='text-decoration: none;' href='" + fusr.getUrlAddress() + "LeaveProcess?ocjtfdinu=");
		if (this.leavetype.equalsIgnoreCase("SLV") || this.leavetype.equalsIgnoreCase("SLVI")
				|| this.leavetype.equalsIgnoreCase("ELV") || this.leavetype.equalsIgnoreCase("COMPASIONATE")) {
			if (stage.equalsIgnoreCase("1")) {
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approverId
						+ "&dpsroe=5&ntac=grulae&epyt=1&egats=1&lvbal=" + this.leavebalance + "&signedBy=fjtco' "
						+ " target='_blank'>Reject</a></div>");
			} else {
				mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approverId
						+ "&dpsroe=5&ntac=grulae&epyt=1&egats=2&lvbal=" + this.leavebalance
						+ "&signedBy=fjtco' target='_blank'>Reject</a></div>");
			}
		} else
			mbody.append(unqid + "&edocmpe=" + this.emp_code + "&revorppa=" + this.approverId
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
		System.out.println("emp_name" + emp_name);
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
		System.out.println("approverId== " + approverId);
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

	public int getSendBackDatedLVApplnForApproval() {
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
			psmt.setString(12, this.approverId);
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

				if (lvcatname == null) {
					System.out.println("Error in sending mail- Error in filling leave category name.");
					retval = -1;
				} else {
					SSLMail sslmail = new SSLMail();
					String unqid = curtime + this.emp_code;
					System.out.println("unqid==" + unqid);
					String msg = getLeaveApplicationMessageBody(lvcatname, curtime, "1");
					if (msg != null) {
						sslmail.setToaddr(new fjtcouser().getEmailIdByEmpcode(getApproverId()));
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

	public int getCheckUid() {

		int logType = -1;
		logType = isNotFrozenAccount();
		if (logType != 1)
			return logType;
		logType = getMoreUserDetails();
		getCurrentLeaveBalances();
		if (logType != 1)
			return logType;

		return logType;
	}

	public int isNotFrozenAccount() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = -1;
		String sqlstr = "SELECT EMP_NAME,EMP_DIVN_CODE,EMP_JOB_LONG_DESC,EMP_COMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.emp_name = rs.getString(1);
				this.emp_divn_code = rs.getString(2);
				// this.travelUDesignation = rs.getString(4);
				this.comp_code = rs.getString(4);
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int getMoreUserDetails() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		String sqlstr = "SELECT TXNFIELD_FLD3,TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.approverId = rs.getString(1);
				// this.traveler_emailid = rs.getString(2);
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
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

	public int getCurrentLeaveBalances() { // leave balance as on the current processing month

		if (this.emp_leave_types == null) {
			this.emp_leave_types = new ConcurrentHashMap<String, LeaveEntry>();

		} else
			this.emp_leave_types.clear();

		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		float fbal = 0.0f;
		String sqlstr = "SELECT LVAC_LV_CODE ,LV_DESC, BALANCE_DAYS FROM PAYROLL.FJT_LEAVE_CURR_INFO WHERE LVAC_EMP_CODE = ? AND LVAC_COMP_CODE = ? ORDER BY LV_DESC ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.comp_code);
			rs = psmt.executeQuery();
			String lvtp = null, lvdesc = null;
			int bal;
			while (rs.next()) {
				lvtp = rs.getString(1);
				lvdesc = rs.getString(2);
				fbal = rs.getFloat(3); // rs.getInt(3);
				LeaveEntry lve = new LeaveEntry();
				if (lvtp.equalsIgnoreCase("CASUAL") || lvtp.equalsIgnoreCase("SLV") || lvtp.equalsIgnoreCase("SLVI")) {

					lve.setBalance(fbal);
				} else {
					bal = (int) fbal;
					lve.setBalance(bal);
				}
				lve.setLv_desc(lvdesc);
				emp_leave_types.put(lvtp, lve);
				if (lvtp.equalsIgnoreCase("AN30") || lvtp.equalsIgnoreCase("AN60") || lvtp.equalsIgnoreCase("AN15")) {
					LeaveEntry lv = new LeaveEntry();
					bal = (int) fbal;
					lv.setBalance(bal);
					lv.setLv_desc("Leave encashment");
					emp_leave_types.put("LENC", lv);
				}

			}
			retval = emp_leave_types.size();
			if (retval > 0) {
				LeaveEntry lwp = new LeaveEntry();
				float lwpbal = getLWPBalance();
				if (lwpbal > 0)
					lwp.setBalance(lwpbal);
				else
					lwpbal = 0;
				lwp.setLv_desc("Leave without pay");
				emp_leave_types.put("LWP", lwp);
			}
		} catch (Exception e) {
			// e.printStackTrace();
			retval = -2;

		} finally {
			try {
				if (rs != null)
					rs.close();
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
}
