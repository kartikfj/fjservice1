package beans;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PortalITProjects {

	private int id = 0;
	private String division = null;
	private String requestedBy = null;
	private String project = null;
	private String usedBy = null;
	private String priority = null;
	private String monthlySavings = null;
	private String approxComplDate = null;
	private Date approxComplDateStr = null;
	private String outSrcCost = null;
	private String status = null;
	private String remarks = null;
	private String feedback = null;
	private String createdBy = null;
	private String createdOn = null;
	private String updatedBy = null;
	private Date updatedOn = null;
	private int divisionStatus = 0;
	private int itStatus = 0;
	private String remarksbydiv = null;
	private ArrayList<PortalITProjects> pendITupdates = null;

	public ArrayList<PortalITProjects> getPendITupdates() {
		return pendITupdates;
	}

	public void setPendITupdates(ArrayList<PortalITProjects> pendITupdates) {
		this.pendITupdates = pendITupdates;
	}

	public PortalITProjects() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getRequestedBy() {
		return requestedBy;
	}

	public void setRequestedBy(String requestedBy) {
		this.requestedBy = requestedBy;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public String getUsedBy() {
		return usedBy;
	}

	public void setUsedBy(String usedBy) {
		this.usedBy = usedBy;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getMonthlySavings() {
		return monthlySavings;
	}

	public void setMonthlySavings(String monthlySavings) {
		this.monthlySavings = monthlySavings;
	}

	public String getApproxComplDate() {
		return approxComplDate;
	}

	public void setApproxComplDate(String approxComplDate) {
		this.approxComplDate = approxComplDate;
	}

	public String getOutSrcCost() {
		return outSrcCost;
	}

	public void setOutSrcCost(String outSrcCost) {
		this.outSrcCost = outSrcCost;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getFeedback() {
		return feedback;
	}

	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Date getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	public int getDivisionStatus() {
		return divisionStatus;
	}

	public void setDivisionStatus(int divisionStatus) {
		this.divisionStatus = divisionStatus;
	}

	public int getItStatus() {
		return itStatus;
	}

	public void setItStatus(int itStatus) {
		this.itStatus = itStatus;
	}

	public String getRemarksbydiv() {
		return remarksbydiv;
	}

	public void setRemarksbydiv(String remarksbydiv) {
		this.remarksbydiv = remarksbydiv;
	}

	public void setApproxComplDateStr(String str) {
		System.out.println("setter pf setFromdateStr date " + str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.approxComplDateStr = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.approxComplDateStr = null;
		}

	}

	public PortalITProjects(int serialNo, String division, String requestedBy, String project, String usedBy,
			String Priority, String monthlySavings, String approxComplDate, String outSrcCost, String status,
			String remarks, String feedback, String createdBy, String createdOn, String updatedBy, Date updatedOn,
			int divisionStatus, int itStatus, String remarksbydiv) {

		this.id = serialNo;
		this.division = division;
		this.requestedBy = requestedBy;
		this.project = project;
		this.usedBy = usedBy;
		this.priority = Priority;
		this.monthlySavings = monthlySavings;
		this.approxComplDate = approxComplDate;
		this.outSrcCost = outSrcCost;
		this.status = status;
		this.remarks = remarks;
		this.feedback = feedback;
		this.createdBy = createdBy;
		this.createdOn = createdOn;
		this.updatedBy = updatedBy;
		this.updatedOn = updatedOn;
		this.divisionStatus = divisionStatus;
		this.itStatus = itStatus;
		this.remarksbydiv = remarksbydiv;
	}

	public int getupdateProjectRequestByDivision() throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		String mailSubject = "FJPortal- New Feature Request ";
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		int result = 0;
		fjtcouser fusr = new fjtcouser();
		try {
			myCon = orcl.getOrclConn();
			String sql = "INSERT INTO PORTAL_IT_PROJECTS (DIVISION,REQUESTED_BY,PROJECT,USED_BY,PRIORITY,MONTYLY_SAVING,CREATEDBY,CREATEDON,DIVISION_STATUS,REMARKSBYDIV) VALUES(?,?,?,?,?,?,?,SYSDATE,?,?)";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, this.division);
			myStmt.setString(2, this.requestedBy);
			myStmt.setString(3, this.project);
			myStmt.setString(4, this.usedBy);
			myStmt.setString(5, this.priority);
			myStmt.setString(6, this.monthlySavings);
			myStmt.setString(7, this.createdBy);
			myStmt.setInt(8, 1);
			myStmt.setString(9, this.remarksbydiv);
			result = myStmt.executeUpdate();
			SSLMail sslmail = new SSLMail();
			String msg = getRegularisationRequestMessageBody();
			sslmail.setToaddr(getITEmailidForRequestForIT());
			sslmail.setMessageSub(mailSubject + " - " + this.requestedBy);
			sslmail.setMessagebody(msg);
			int status = sslmail.sendMail(fusr.getUrlAddress());
			if (status != 1) {
				// mcon.rollback();
				System.out.print("Error in sending email while a new feature request is made...");

			} else {
				System.out.print("sent email while a new feature request is made...");
				// mcon.commit();

			}

		} catch (Exception e) {
			System.out.println("Error while inserting getupdateProjectRequestByDivision" + e);
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return result;
	}

	public List<PortalITProjects> getdisplayDefaultItProjects() throws SQLException {
		if (pendITupdates == null)
			pendITupdates = new ArrayList<PortalITProjects>();
		else
			pendITupdates.clear();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * from PORTAL_IT_PROJECTS ORDER BY CREATEDON DESC";
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int serialNo = myRes.getInt(1);
				String division = myRes.getString(2);
				String requestedBy = myRes.getString(3);
				String project = myRes.getString(4);
				String usedBy = myRes.getString(5);
				String Priority = myRes.getString(6);
				String monthlySavings = myRes.getString(7);
				String approxComplDate = myRes.getString(8);
				String outSrcCost = myRes.getString(9);
				String status = myRes.getString(10);
				String remarks = myRes.getString(11);
				String feedback = myRes.getString(12);
				String createdBy = myRes.getString(13);
				String createdOn = myRes.getString(14);
				String updatedBy = getEmpNameByUid(myRes.getString(15));
				Date updatedOn = myRes.getDate(16);
				int divisionStatus = myRes.getInt(17);
				int itStatus = myRes.getInt(18);
				String remarksbydiv = myRes.getString(19);

				PortalITProjects tempitReqList = new PortalITProjects(serialNo, division, requestedBy, project, usedBy,
						Priority, monthlySavings, approxComplDate, outSrcCost, status, remarks, feedback, createdBy,
						createdOn, updatedBy, updatedOn, divisionStatus, itStatus, remarksbydiv);
				pendITupdates.add(tempitReqList);
			}
			return pendITupdates;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int getupdateProjectRequestByIT() throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		int itstatus = 0;
		try {
			myCon = orcl.getOrclConn();
			if (status.equals("Done")) {
				itstatus = 1;
			} else if (status.equals("Cancelled")) {
				itstatus = 1;
			}
			String sql = "UPDATE PORTAL_IT_PROJECTS SET ESTI_COMPL_DATE=?,OUTSRC_COST=?,STATUS=?,REMARKS=?,UPDATEDBY=?,UPDATEDON=SYSDATE,IT_STATUS=? WHERE SYS_ID=?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, this.approxComplDateStr);
			myStmt.setString(2, this.outSrcCost);
			myStmt.setString(3, status);
			myStmt.setString(4, remarks);
			// myStmt.setString(5, feedback);
			myStmt.setString(5, this.updatedBy);
			myStmt.setInt(6, itstatus);
			myStmt.setInt(7, id);
			int d = myStmt.executeUpdate();
			return d;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public int getupdateFeedback() throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "UPDATE PORTAL_IT_PROJECTS SET FEEDBACK=? WHERE SYS_ID=?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, feedback);
			myStmt.setInt(2, this.id);
			int result = myStmt.executeUpdate();
			return result;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
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

	public String getEmpNameByUid(String id) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String empname = null;
		// String sqlstr = "SELECT EMP_NAME FROM ORION.PM_EMP_KEY WHERE EMP_CODE =? AND
		// EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		String sqlstr = "SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				empname = rs.getString(1);

			}

		} catch (Exception e) {
			e.printStackTrace();

			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				empname = null;
			}
		}
		return empname;
	}

	private String getRegularisationRequestMessageBody() {

		if (this.requestedBy == null) {
			System.out.println("employee details not available.");
			return null;
		}

		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n"
				+ "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		mbody.append("A new feature request is submitted through Request for IT. <br/><br/>");
		mbody.append(
				"<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
		mbody.append("<tr><td><b>Employee Name </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + this.requestedBy
				+ "</td></tr><tr><td><b>Employee Code </b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + this.createdBy
				+ "</td></tr>");
		mbody.append("<tr><td><b>Division </b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + division + "</td></tr>");
		mbody.append("<tr><td><b>Project </b></td><td><b>&nbsp;:&nbsp; </b></td><td>" + project + " </td></tr>");
		mbody.append("</table><br/>");
		return mbody.toString();

	}

	public String getITEmailidForRequestForIT() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return null;
		String retval = null;
		PreparedStatement psmt = null;

		ResultSet rs = null; // status,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid
		String usrsql = "select emailid from  emailconf where usagetype='ITTEAM'";
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
		System.out.println("IT team emaild ids" + retval);
		return retval;
	}
}
