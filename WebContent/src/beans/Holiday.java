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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author
 */
public class Holiday {

	private ArrayList<java.sql.Date> holidayList = null;
	private HashMap<java.sql.Date, String> holidayDetailLst = null;
	private int curyear;
	private java.util.Date today;
	private java.sql.Date newHday = null;
	private String newDesc = null;
	private String compCode = null;
	private String editor = null;

	public Holiday() {
		Calendar todaycal = Calendar.getInstance();
		// todaycal.clear(Calendar.HOUR); todaycal.clear(Calendar.MINUTE);
		// todaycal.clear(Calendar.SECOND);
		todaycal.set(Calendar.HOUR_OF_DAY, 0);
		todaycal.set(Calendar.MINUTE, 0);
		todaycal.set(Calendar.SECOND, 0);
		todaycal.set(Calendar.MILLISECOND, 0);
		today = todaycal.getTime();
	}

	/**
	 * @return the holidayList
	 */
	public ArrayList<java.sql.Date> getHolidayList() {

		return holidayList;
	}

	public int getAllHolidaysofCurYear() {
		if (getHolidayList() == null)
			setHolidayList(new ArrayList<Date>());
		else
			getHolidayList().clear();

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql;

		try {
			if (curyear == 0) {
				usrsql = "select hday from  holidays where year(hday) = year(CURDATE()) and company_code=? and status=1";
				psmt = mcon.prepareStatement(usrsql);
				psmt.setString(1, this.compCode);
			} else {

				usrsql = "select hday from  holidays where year(hday) = ? and company_code=? and status=1";
				psmt = mcon.prepareStatement(usrsql);
				psmt.setInt(1, curyear);
				psmt.setString(2, this.compCode);

			}

			rs = psmt.executeQuery();
			logType = 0; // no such holiday
			while (rs.next()) {
				// System.out.println(rs.getDate(1));
				getHolidayList().add(rs.getDate(1));
			}

		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	/**
	 * @param holidayList the holidayList to set
	 */
	public void setHolidayList(ArrayList<java.sql.Date> holidayList) {
		this.holidayList = holidayList;
	}

	public int isAHoliday(Date convertedDt) {

		if (getHolidayList().contains(convertedDt)) {
			return 1; // holiday
		}
		int diff = convertedDt.compareTo(today);
		// long diff = convertedDt.getTime() - getToday().getTime();
		// else if( convertedDt.getTime() > getToday().getTime()){
		if (diff > 0) {
			return 2; // a future date
		} else if (diff == 0) { // today
			return 3;
		} else
			return 0; // not a holiday
	}

	public long getDaysDifference(Date convertedDt) {

		long daysdiff = (convertedDt.getTime() - today.getTime()) / (24 * 60 * 60 * 1000);
		return daysdiff;
	}

	/**
	 * @return the curyear
	 */
	public int getCuryear() {
		return curyear;
	}

	/**
	 * @param curyear the curyear to set
	 */
	public void setCuryear(int curyear) {
		this.curyear = curyear;
	}

	/**
	 * @return the today
	 */
	public java.util.Date getToday() {
		return today;
	}

	/**
	 * @param today the today to set
	 */
	public void setToday(java.util.Date today) {
		this.today = today;
	}

	public int getAllHolidaysWithDescofCurYear() {
		if (this.holidayDetailLst == null)
			this.holidayDetailLst = new HashMap<Date, String>();
		else
			this.holidayDetailLst.clear();

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql;

		try {
			if (curyear == 0) {
				usrsql = "select hday,description from  holidays where year(hday) = year(CURDATE()) and  company_code=? and status=1";
				psmt = mcon.prepareStatement(usrsql);
				psmt.setString(1, this.compCode);
			} else {
				usrsql = "select hday from  holidays where year(hday) = ?  and company_code=? and status=1";
				psmt = mcon.prepareStatement(usrsql);
				psmt.setInt(1, curyear);
				psmt.setString(2, this.compCode);
			}

			rs = psmt.executeQuery();
			logType = 0; // no such holiday
			while (rs.next()) {
				java.sql.Date dt = rs.getDate(1);
				String desc = rs.getString(2);
				this.holidayDetailLst.put(dt, desc);
			}

		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	/**
	 * @return the holidayDetailLst
	 */
	public HashMap<java.sql.Date, String> getHolidayDetailLst() {
		return holidayDetailLst;
	}

	/**
	 * @param holidayDetailLst the holidayDetailLst to set
	 */
	public void setHolidayDetailLst(HashMap<java.sql.Date, String> holidayDetailLst) {
		this.holidayDetailLst = holidayDetailLst;
	}

	public int getAddHoliday() {

		if (this.newHday == null || this.newDesc == null || this.compCode == null || this.editor == null)
			return -1;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		PreparedStatement psmt = null;
		String usrsql;
		// System.out.println("getAddHoliday");
		try {
			this.getAllHolidaysofCurYear();
			if (this.isAHoliday(newHday) == 1) {
				usrsql = "update  holidays set description = ?, editor=? where hday =? and company_code =? and status=1";
				psmt = mcon.prepareStatement(usrsql);
				psmt.setString(1, this.newDesc);
				psmt.setString(2, this.editor);
				psmt.setDate(3, this.newHday);
				psmt.setString(4, this.compCode);

				System.out.println("Holiday : updated");
			} else {
				usrsql = "insert into  holidays (description,hday,editor,company_code,status) values(?,?,?,?,?)";
				psmt = mcon.prepareStatement(usrsql);
				psmt.setString(1, this.newDesc);
				psmt.setDate(2, this.newHday);
				psmt.setString(3, this.editor);
				psmt.setString(4, this.compCode);
				psmt.setInt(5, 1);
				System.out.println("Holiday : added");
			}
			logType = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;

	}

	/**
	 * @return the newHday
	 */
	public java.sql.Date getNewHday() {
		return newHday;
	}

	/**
	 * @param newHday the newHday to set
	 */
	public void setNewHday(java.sql.Date newHday) {
		this.newHday = newHday;
	}

	public void setNewHdayStr(String hdaystr) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(hdaystr);
			this.newHday = new Date(dt.getTime());
			// System.out.println(newHday);
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.newHday = null;
		}
		this.newHday = newHday;
	}

	/**
	 * @return the newDesc
	 */
	public String getNewDesc() {
		return newDesc;
	}

	/**
	 * @param newDesc the newDesc to set
	 */
	public void setNewDesc(String newDesc) {
		this.newDesc = newDesc;
	}

	public int getDelHoliday() {

		if (this.newHday == null || this.newDesc == null || this.compCode == null || this.editor == null)
			return -1;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		PreparedStatement psmt = null;
		String usrsql;

		try {

			usrsql = "update holidays set status=2,editor=? where hday = ? and company_code = ?";
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.editor);
			psmt.setDate(2, this.newHday);
			psmt.setString(3, this.compCode);
			logType = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;

	}

	/**
	 * @return the compCode
	 */
	public String getCompCode() {
		return compCode;
	}

	/**
	 * @param compCode the compCode to set
	 */
	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}

	/**
	 * @return the editor
	 */
	public String getEditor() {
		return editor;
	}

	/**
	 * @param editor the editor to set
	 */
	public void setEditor(String editor) {
		this.editor = editor;
	}

	public int getAllHolidaysBetween(Date startdt, Date enddt) {
		if (this.compCode == null)
			return -2;
		if (getHolidayList() == null)
			setHolidayList(new ArrayList<Date>());
		else
			getHolidayList().clear();

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql;

		try {

			usrsql = "select hday from  holidays where hday between ? and ? and company_code=? and status=1";
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, startdt);
			psmt.setDate(2, enddt);
			psmt.setString(3, this.compCode);

			rs = psmt.executeQuery();
			logType = 0; // no such holiday
			while (rs.next()) {
				// System.out.println(rs.getDate(1));
				getHolidayList().add(rs.getDate(1));
			}

		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}
}
