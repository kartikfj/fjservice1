package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.SSLMail;
import beans.SipJihDues;
import beans.fjtcouser;

public class SipJihDuesDbUtil {

	public SipJihDuesDbUtil() {
	}

	public List<SipJihDues> getJihDueDetailsForSalesEng(String emp_code) throws SQLException {

		List<SipJihDues> volumeList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM SM_JIH_LONG_DUE WHERE NVL(QTN_STATUS,'W') <> 'L' AND LOI_DT IS NULL AND EMP_CODE = ?  ORDER BY QTN_DT DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String slesCode = myRes.getString(1);
				String sys_id = myRes.getString(2);
				String qtnDate = formatDate(myRes.getString(3));
				String qtnCode = myRes.getString(4);
				String qtnNo = myRes.getString(5);
				String custCode = myRes.getString(6);
				String custName = myRes.getString(7);
				String projectName = myRes.getString(8);
				String consultant = myRes.getString(9);
				int qtnAMount = myRes.getInt(10);
				String qtnStatus = myRes.getString(11);
				String remarks = myRes.getString(12);
				String poDate = formatDate(myRes.getString(15));
				String invoiceDate = formatDate(myRes.getString(16));
				SipJihDues tempVolumeList = new SipJihDues(slesCode, sys_id, qtnDate, qtnCode, qtnNo, custCode,
						custName, projectName, consultant, qtnAMount, qtnStatus, remarks, poDate, invoiceDate);
				volumeList.add(tempVolumeList);
			}

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipJihDuesDbUtil.getJihDueDetailsForSalesEng " + emp_code);
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return volumeList;
	}

	private Date previousDay() {
		final Calendar cal = Calendar.getInstance();
		return cal.getTime();
	}

	public int updateJIHDeQtnStatus(String qtn_id, String reason, String saleEngEmpCode, String remarkType,
			String newStatus, fjtcouser fjtuser) throws SQLException {

		int logType = -2;
		int retval = 0;
		// String newStatus = "L";
		String mailSubject = "FJPortal-Quotation marked as Lost with reason - NOT IN VENDOR LIST";
		String text;
		if (newStatus.equals("L")) {
			text = "Marked as Lost by ";
		} else {
			text = "Marked as Hold by ";
		}
		String remarks = reason + ", " + text + saleEngEmpCode + " through FJPORTAL, updated on " + previousDay() + "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE SM_JIH_LONG_DUE  " + " SET QTN_STATUS = ?, REMARKS = ?, REMARKS_TYPE = ? "
					+ " WHERE NVL(QTN_STATUS,'W') <> 'L' AND EMP_CODE = ?  AND CQH_SYS_ID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, newStatus);
			myStmt.setString(2, remarks);
			myStmt.setString(3, remarkType);
			myStmt.setString(4, saleEngEmpCode);
			myStmt.setString(5, qtn_id);
			logType = myStmt.executeUpdate();

			if (newStatus.equals("L") && remarkType.equals("VL")) {
				SipJihDues sipJihdues = getJihDueDetailsForQuatation(saleEngEmpCode, qtn_id);
				SSLMail sslmail = new SSLMail();
				String msg = getLostwithNotInVendorListMailBody(fjtuser, reason, sipJihdues);
				System.out.println("approver emailid -- " + fjtuser.getApproverId() + " logged inuser emaild--"
						+ fjtuser.getEmailid());
				sslmail.setToaddr(getMarketingTeamEmailId());
				sslmail.setCcaddr(fjtuser.getApproverId() + "," + fjtuser.getEmailid() + ","
						+ new MktSalesLeadsDbUtil().getDmEmailIdByEmpcode(fjtuser.getEmp_code()));
				sslmail.setMessageSub(mailSubject + " - " + fjtuser.getUname());
				sslmail.setMessagebody(msg);
				int status = sslmail.sendMail(fjtuser.getUrlAddress());
				if (status != 1) {
					System.out.print("Error in sending Email when quotation was lost with not in vendor reason...");
					retval = -1;
				} else {
					System.out.print("sent when quotation was lost with not in vendor reason...");
					retval = 1;
				}
				// sending email to IT dept
				SSLMail sslmailtoIT = new SSLMail();
				String msg1 = getLostwithNotInVendorListMailBody(fjtuser, reason, sipJihdues);
				sslmailtoIT.setToaddr("arun@fjtco.com" + "," + "rajakumari.ch@fjtco.com");
				sslmailtoIT.setMessageSub(mailSubject + " - " + fjtuser.getUname());
				sslmailtoIT.setMessagebody(msg1);
				int status1 = sslmailtoIT.sendMail(fjtuser.getUrlAddress());
				if (status1 != 1) {
					System.out.print("Error in sending Email when quotation was lost with not in vendor reason...");
					retval = -1;
				} else {
					System.out.print("sent when quotation was lost with not in vendor reason...");
					retval = 1;
				}
			}

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of qtn lost update for " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}

		return logType;

	}

	public int updateJIHDeQtnStatusToHold(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode,
			String remarkType, int loiamount) throws SQLException {

		int logType = -2;
		String newStatus = "H";
		// String remarks = reason + ", Marked as Hold by " + saleEngEmpCode + " through
		// FJPORTAL, updated on "+ previousDay() + "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE SM_JIH_LONG_DUE  " + " SET LOI_DT = ?, LOI_AMT = ?, UPD_DT = SYSDATE "
					+ " WHERE NVL(QTN_STATUS,'W') <> 'L' AND EMP_CODE = ?  AND CQH_SYS_ID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setInt(2, loiamount);
			// myStmt.setString(3, remarkType);
			myStmt.setString(3, saleEngEmpCode);
			myStmt.setString(4, qtn_id);

			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in closing DB resources at the time of qtn lost update for " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updatePODate(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE SM_JIH_LONG_DUE  " + " SET EXP_PO_DT = ?, UPD_DT = SYSDATE "
					+ " WHERE NVL(QTN_STATUS,'W') <> 'L' AND EMP_CODE = ?  AND CQH_SYS_ID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updatePODate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public int updateINVDate(String qtn_id, java.sql.Date loiDate, String saleEngEmpCode) throws SQLException {

		int logType = -2;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " UPDATE SM_JIH_LONG_DUE  " + " SET EXP_INV_DT = ?, UPD_DT = SYSDATE "
					+ " WHERE NVL(QTN_STATUS,'W') <> 'L' AND EMP_CODE = ?  AND CQH_SYS_ID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setDate(1, loiDate);
			myStmt.setString(2, saleEngEmpCode);
			myStmt.setString(3, qtn_id);
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			System.out.println("Exception in updatePODate " + qtn_id);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return logType;

	}

	public List<SipJihDues> getRemarksTypes() throws SQLException {
		List<SipJihDues> remarksList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT * FROM  QUOT_LOST_TYPE WHERE CODE NOT IN ( 'H', 'NR') ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String type = myRes.getString(1);
				String desc = myRes.getString(2);
				SipJihDues tempRemarksList = new SipJihDues(type, desc);
				remarksList.add(tempRemarksList);
			}
		} catch (SQLException ex) {
			System.out.println("Exception in closing DB ");
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return remarksList;

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

	private String formatDate(String sqlDate) {
		String dateValue = sqlDate.substring(0, 10);
		// System.out.println(dateValue);
		String formattedDate = "";
		String[] tempArray;
		String delimiter = "-";
		tempArray = dateValue.split(delimiter);
		String[] newArray = new String[3];
		for (int i = 0, j = 2; i <= 2; i++) {
			// System.out.println(tempArray[i] +" j = "+j);
			newArray[j] = tempArray[i];
			j--;
		}

		formattedDate = Arrays.toString(newArray);
		formattedDate = formattedDate.substring(1, formattedDate.length() - 1).replace(", ", "/");
		// System.out.println(formattedDate);

		return formattedDate;

	}

	public List<SipJihDues> getHoldRemarksTypes() throws SQLException {
		List<SipJihDues> remarksList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT * FROM  QUOT_HOLD_TYPE ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String type = myRes.getString(1);
				String desc = myRes.getString(2);
				SipJihDues tempRemarksList = new SipJihDues(type, desc);
				remarksList.add(tempRemarksList);
			}
		} catch (SQLException ex) {
			System.out.println("Exception in closing DB ");
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			// System.out.println("Updated and closed db Successfully ");
		}
		return remarksList;

	}

	public List<SipJihDues> getJihDueDetailsForSalesEngForMG() throws SQLException {

		List<SipJihDues> volumeList = new ArrayList<>();// appraise company code list

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM SM_JIH_LONG_DUE WHERE NVL(QTN_STATUS,'W') <> 'L' ";
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String slesCode = myRes.getString(1);
				String sys_id = myRes.getString(2);
				String qtnDate = formatDate(myRes.getString(3));
				String qtnCode = myRes.getString(4);
				String qtnNo = myRes.getString(5);
				String custCode = myRes.getString(6);
				String custName = myRes.getString(7);
				String projectName = myRes.getString(8);
				String consultant = myRes.getString(9);
				int qtnAMount = myRes.getInt(10);
				String qtnStatus = myRes.getString(11);
				String remarks = myRes.getString(12);
				String poDate = null, invoiceDate = null;
				if (myRes.getString(15) != null) {
					poDate = formatDate(myRes.getString(15));
				}
				if (myRes.getString(15) != null) {
					invoiceDate = formatDate(myRes.getString(16));
				}
				SipJihDues tempVolumeList = new SipJihDues(slesCode, sys_id, qtnDate, qtnCode, qtnNo, custCode,
						custName, projectName, consultant, qtnAMount, qtnStatus, remarks, poDate, invoiceDate);
				volumeList.add(tempVolumeList);
			}

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipJihDuesDbUtil.getJihDueDetailsForSalesEng ");
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return volumeList;
	}

	private String getLostwithNotInVendorListMailBody(fjtcouser fjtuser, String reason, SipJihDues sipJihduesObj) {

		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n"
				+ "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		NumberFormat nf = NumberFormat.getInstance(Locale.US);
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		mbody.append("Dear Business development Team, <br/><br/>");
		mbody.append("A Quotation has been marked as lost with reason \"NOT IN VENDOR LIST\".<br/>");
		mbody.append("Please take necessary action or follow up with salesman.<br/><br/>");
		mbody.append(
				"<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
		mbody.append("<tr><td><b>Salesman</b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + fjtuser.getUname()
				+ "</td></tr><tr><td><b>Email</b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + fjtuser.getEmailid()
				+ "</td></tr>");
		mbody.append("<tr><td><b>Quotation Details </b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
				+ sipJihduesObj.getQtnCode() + " - " + sipJihduesObj.getQtnNo() + "</td></tr>");
		mbody.append("<tr><td><b>Quotation Date </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + sipJihduesObj.getQtnDate()
				+ "</td></tr>");
		mbody.append(
				"<tr><td><b>Quotation Stage </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + "Job In Hand" + "</td></tr>");
		mbody.append("<tr><td><b>Quotation Value </b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
				+ nf.format(sipJihduesObj.getQtnAMount()) + "</td></tr>");
		mbody.append("<tr><td><b>Consultant </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + sipJihduesObj.getConsultant()
				+ "</td></tr><tr><td><b>Project Name </b></td><td><b>&nbsp;:&nbsp; </b></td><td> "
				+ sipJihduesObj.getProjectName() + "</td></tr>");
		mbody.append("</table><br/></div>");
		return mbody.toString();
	}

	public SipJihDues getJihDueDetailsForQuatation(String emp_code, String quotationNo) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		SipJihDues volumeList = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT CONSULTANT,PROJECT_NAME,QTN_CODE,QTN_NO,QTN_DT,QTN_AMOUNT FROM SM_JIH_LONG_DUE WHERE EMP_CODE = ?  AND CQH_SYS_ID = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myStmt.setString(2, quotationNo);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String consultant = myRes.getString(1);
				String projectName = myRes.getString(2);
				String quotationCode = myRes.getString(3);
				String quotatiNo = myRes.getString(4);
				String quotationDate = formatDate(myRes.getString(5));
				int quotationAmount = myRes.getInt(6);
				volumeList = new SipJihDues(projectName, consultant, quotationCode, quotatiNo, quotationDate,
						quotationAmount);
			}

		} catch (SQLException e) {
			System.out
					.println("Exception Sales eng EMp COde SipJihDuesDbUtil.getJihDueDetailsForQuatation " + emp_code);
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return volumeList;
	}

	public String getMarketingTeamEmailId() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return null;
		String retval = null;
		PreparedStatement psmt = null;

		ResultSet rs = null; // status,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid
		String usrsql = "select emailid from  emailconf where usagetype='MKTEAM'";
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
		System.out.println("MK team emaild ids" + retval);
		return retval;
	}

}