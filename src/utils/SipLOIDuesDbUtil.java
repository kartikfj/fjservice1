package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipLOIDues;

public class SipLOIDuesDbUtil {

	public List<SipLOIDues> getLOIDueDetailsForSalesEng(String emp_code) throws SQLException {

		List<SipLOIDues> volumeList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM SM_LOI_LONG_DUE WHERE NVL(QTN_STATUS,'W') <> 'L' AND EMP_CODE = ? ORDER BY LOI_DT DESC";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String slesCode = myRes.getString(1);
				String sys_id = myRes.getString(2);
				String qtnDate = formatDate(myRes.getString(3));
				String loiDate = formatDate(myRes.getString(4));
				String qtnCode = myRes.getString(5);
				String qtnNo = myRes.getString(6);
				String custCode = myRes.getString(7);
				String custName = myRes.getString(8);
				String projectName = myRes.getString(9);
				String consultant = myRes.getString(10);
				int qtnAMount = myRes.getInt(11);
				String qtnStatus = myRes.getString(12);
				String remarks = myRes.getString(13);
				String poDate = null, invoiceDate = null;
				if (myRes.getString(16) != null) {
					poDate = formatDate(myRes.getString(16));
				}
				if (myRes.getString(17) != null) {
					invoiceDate = formatDate(myRes.getString(17));
				}
				SipLOIDues tempVolumeList = new SipLOIDues(slesCode, sys_id, qtnDate, qtnCode, qtnNo, custCode,
						custName, projectName, consultant, qtnAMount, qtnStatus, remarks, loiDate, poDate, invoiceDate);
				volumeList.add(tempVolumeList);
			}

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipLOIDues.getJihDueDetailsForSalesEng " + emp_code);
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return volumeList;
	}

	public List<SipLOIDues> getLOIDueDetailsForSalesEngForMG() throws SQLException {

		List<SipLOIDues> volumeList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM SM_LOI_LONG_DUE WHERE NVL(QTN_STATUS,'W') <> 'L'  ORDER BY LOI_DT DESC";
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String slesCode = myRes.getString(1);
				String sys_id = myRes.getString(2);
				String qtnDate = formatDate(myRes.getString(3));
				String loiDate = formatDate(myRes.getString(4));
				String qtnCode = myRes.getString(5);
				String qtnNo = myRes.getString(6);
				String custCode = myRes.getString(7);
				String custName = myRes.getString(8);
				String projectName = myRes.getString(9);
				String consultant = myRes.getString(10);
				int qtnAMount = myRes.getInt(11);
				String qtnStatus = myRes.getString(12);
				String remarks = myRes.getString(13);
				String poDate = null, invoiceDate = null;
				if (myRes.getString(16) != null) {
					poDate = formatDate(myRes.getString(16));
				}
				if (myRes.getString(17) != null) {
					invoiceDate = formatDate(myRes.getString(17));
				}
				SipLOIDues tempVolumeList = new SipLOIDues(slesCode, sys_id, qtnDate, qtnCode, qtnNo, custCode,
						custName, projectName, consultant, qtnAMount, qtnStatus, remarks, loiDate, poDate, invoiceDate);
				volumeList.add(tempVolumeList);
			}

		} catch (SQLException e) {
			System.out.println("Exception Sales eng EMp COde SipLOIDues.getJihDueDetailsForSalesEng " + e);
			e.printStackTrace();
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return volumeList;
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

	public List<SipLOIDues> getRemarksTypes() throws SQLException {
		List<SipLOIDues> remarksList = new ArrayList<>();
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
				SipLOIDues tempRemarksList = new SipLOIDues(type, desc);
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

	public List<SipLOIDues> getHoldRemarksTypes() throws SQLException {
		List<SipLOIDues> remarksList = new ArrayList<>();
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
				SipLOIDues tempRemarksList = new SipLOIDues(type, desc);
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

	public int updateLOIDeQtnStatus(String qtn_id, String reason, String saleEngEmpCode, String remarkType,
			String newStatus) throws SQLException {

		int logType = -2;
		// String newStatus = "L";
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

			String sql = " UPDATE SM_LOI_LONG_DUE  " + " SET QTN_STATUS = ?, REMARKS = ?, REMARKS_TYPE = ? "
					+ " WHERE NVL(QTN_STATUS,'W') <> 'L' AND EMP_CODE = ?  AND CQH_SYS_ID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, newStatus);
			myStmt.setString(2, remarks);
			myStmt.setString(3, remarkType);
			myStmt.setString(4, saleEngEmpCode);
			myStmt.setString(5, qtn_id);

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

			String sql = " UPDATE SM_LOI_LONG_DUE  " + " SET EXP_PO_DT = ?, UPD_DT = SYSDATE "
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

			String sql = " UPDATE SM_LOI_LONG_DUE  " + " SET EXP_INV_DT = ?, UPD_DT = SYSDATE "
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

	private Date previousDay() {
		final Calendar cal = Calendar.getInstance();
		return cal.getTime();
	}
}
