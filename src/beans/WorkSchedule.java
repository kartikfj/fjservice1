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
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author  
 */
public class WorkSchedule {
	private Time dayStart;
	private Time dayEnd;
	private Date valid_from;
	private Date valid_to;
	private String type;
	private String editor;
	private String companyCode;

	/**
	 * @return the dayStart
	 */
	public Time getDayStart() {
		return dayStart;
	}

	/**
	 * @param dayStart
	 *            the dayStart to set
	 */
	public void setDayStart(Time dayStart) {
		this.dayStart = dayStart;
	}

	public void setDayStartStr(String timestr) {
		DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
		java.util.Date dtr;
		try {
			dtr = formatter.parse(timestr);
			this.dayStart = new Time(dtr.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(WorkSchedule.class.getName()).log(Level.SEVERE, null, ex);
		}

	}

	public void setDayEndStr(String timestr) {
		DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
		java.util.Date dtr;
		try {
			dtr = formatter.parse(timestr);
			this.dayEnd = new Time(dtr.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(WorkSchedule.class.getName()).log(Level.SEVERE, null, ex);
		}

	}

	/**
	 * @return the dayEnd
	 */
	public Time getDayEnd() {
		return dayEnd;
	}

	/**
	 * @param dayEnd
	 *            the dayEnd to set
	 */
	public void setDayEnd(Time dayEnd) {
		this.dayEnd = dayEnd;
	}

	/**
	 * @return the valid_from
	 */
	public Date getValid_from() {
		return valid_from;
	}

	/**
	 * @param valid_from
	 *            the valid_from to set
	 */
	public void setValid_from(Date valid_from) {
		this.valid_from = valid_from;
	}

	public void setValid_fromStr(String valid_fromstr) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(valid_fromstr);
			this.valid_from = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.valid_from = null;
		}
	}

	/**
	 * @return the valid_to
	 */
	public Date getValid_to() {
		return valid_to;
	}

	public void setValid_toStr(String valid_tostr) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(valid_tostr);
			this.valid_to = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(WorkSchedule.class.getName()).log(Level.SEVERE, null, ex);
			this.valid_to = null;
		}
	}

	/**
	 * @param valid_to
	 *            the valid_to to set
	 */
	public void setValid_to(Date valid_to) {
		this.valid_to = valid_to;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	public int getCheckScheduleValidity() {
		if (this.valid_to == null || this.valid_from == null || this.dayEnd == null || this.dayStart == null
				|| this.type == null)
			return -1;
		String paramname1 = null, paramname2 = null;
		if (this.type.equalsIgnoreCase("LABOUR")) {
			paramname1 = "LABOUR_DAY_START";
			paramname2 = "LABOUR_DAY_END";
		} else if (this.type.equalsIgnoreCase("STAFF")) {
			paramname1 = "STAFF_DAY_START";
			paramname2 = "STAFF_DAY_END";
		} else
			return -1;
		int returntype = this.isSchExisting(paramname1, paramname2);
		if (returntype < 0)
			return returntype;
		else if (returntype == 0)
			return 1;
		else
			return 0;
		/*
		 * if(returntype == 0 ){ returntype = this.isSchOverlapping(paramname1,
		 * paramname2); if(returntype < 0) return returntype; if(returntype == 0){
		 * returntype=this.isSchEncompassing(paramname1, paramname2); if(returntype < 0)
		 * return returntype; if(returntype == 0) return 1; //valid new sch else return
		 * 3; //encompassing more than one sch } else{ return 2; // overlapping sch; } }
		 * else{ return 0; //existing sch }
		 */

	}

	public int getAddNewWorkSchedule() {
		if (this.valid_to == null || this.valid_from == null || this.dayEnd == null || this.dayStart == null
				|| this.type == null)
			return -1;
		String paramname1, paramname2;
		if (this.type.equalsIgnoreCase("LABOUR")) {
			paramname1 = "LABOUR_DAY_START";
			paramname2 = "LABOUR_DAY_END";
		} else if (this.type.equalsIgnoreCase("STAFF")) {
			paramname1 = "STAFF_DAY_START";
			paramname2 = "STAFF_DAY_END";
		} else {
			return -1;
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		PreparedStatement psmt = null;
		PreparedStatement psmt2 = null;
		String usrsql, usrsql2;

		try {
			usrsql = "insert into  system_params (param_name,param_value,param_type,valid_from,valid_to,editor_id,company_code,status) values(?,?,'TIME',?,?,?,?,?)";
			mcon.setAutoCommit(false);
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, paramname1);
			psmt.setTime(2, getDayStart());
			psmt.setDate(3, getValid_from());
			psmt.setDate(4, getValid_to());
			psmt.setString(5, this.editor);
			psmt.setString(6, this.companyCode);
			psmt.setInt(7, 1);
			logType = psmt.executeUpdate();
			if (logType == 1) {
				usrsql2 = "insert into  system_params (param_name,param_value,param_type,valid_from,valid_to,editor_id,company_code,status) values(?,?,'TIME',?,?,?,?,?)";
				psmt2 = mcon.prepareStatement(usrsql2);
				psmt2.setString(1, paramname2);
				psmt2.setTime(2, getDayEnd());
				psmt2.setDate(3, getValid_from());
				psmt2.setDate(4, getValid_to());
				psmt2.setString(5, this.editor);
				psmt2.setString(6, this.companyCode);
				psmt2.setInt(7, 1);
				logType = psmt2.executeUpdate();

				if (logType == 1)
					mcon.commit();
				else {
					mcon.rollback();
					logType = -1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (psmt != null)
					psmt.close();
				if (psmt2 != null)
					psmt2.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	public int getDelWorkSchedule() {
		if (this.valid_to == null || this.valid_from == null || this.dayEnd == null || this.dayStart == null
				|| this.type == null)
			return -1;
		String paramname1, paramname2;
		if (this.type.equalsIgnoreCase("LABOUR")) {
			paramname1 = "LABOUR_DAY_START";
			paramname2 = "LABOUR_DAY_END";
		} else if (this.type.equalsIgnoreCase("STAFF")) {
			paramname1 = "STAFF_DAY_START";
			paramname2 = "STAFF_DAY_END";
		} else {
			return -1;
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		PreparedStatement psmt = null;
		String usrsql;

		try {
			usrsql = "update system_params set status=2, editor_id=? where (param_name=? or param_name=?) and valid_from=? and valid_to=? and company_code=?";
			// mcon.setAutoCommit(false);
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.editor);
			psmt.setString(2, paramname1);
			psmt.setString(3, paramname2);
			psmt.setDate(4, getValid_from());
			psmt.setDate(5, getValid_to());
			psmt.setString(6, this.companyCode);
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

	/*
	 * public int updateWorkSchedule(){ if(this.valid_to == null || this.valid_from
	 * ==null || this.dayEnd == null || this.dayStart == null || this.type ==null)
	 * return -1; String paramname1,paramname2;
	 * if(this.type.equalsIgnoreCase("LABOUR")){ paramname1="LABOUR_DAY_START";
	 * paramname2="LABOUR_DAY_END"; } else if(this.type.equalsIgnoreCase("STAFF")){
	 * paramname1="STAFF_DAY_START"; paramname2="STAFF_DAY_END"; } else{ return -1;
	 * } }
	 */
	public int isSchOverlapping(String param1, String param2) { // new schedule is contained with in a scheduled period.
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int returntype = 0;
		// check for overlapping
		String usrsql = "select param_value from system_params where (( ? between valid_from and valid_to ) and (? between valid_from and valid_to)) and (param_name= ? or param_name =?) and company_code=? and status=1";
		try {

			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, this.valid_from);
			psmt.setDate(2, this.valid_to);
			// psmt.setDate(3, this.valid_from);
			// psmt.setDate(4, this.valid_to);
			psmt.setString(3, param1);
			psmt.setString(4, param2);
			psmt.setString(5, this.companyCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				System.out.println("overlaps");
				returntype = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			returntype = -2;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				returntype = -2;
				System.out.println("Exception in closing DB resources");
			}
		}

		return returntype;
	}

	public int isSchExisting(String param1, String param2) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int returntype = 0;
		// check for duplication
		String usrsql = "select param_value from system_params where valid_from=? and valid_to=? and (param_name= ? or param_name =?) and company_code=? and status=1";
		try {

			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, this.valid_from);
			psmt.setDate(2, this.valid_to);
			psmt.setString(3, param1);
			psmt.setString(4, param2);
			psmt.setString(5, this.companyCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				System.out.println("exists");
				returntype = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			returntype = -2;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				returntype = -2;
				System.out.println("Exception in closing DB resources");
			}
		}

		return returntype;
	}

	public Date getLastScheduleStartDateForStaff() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		if (mcon == null || this.companyCode == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		Date scStart = null;
		///////////
		String usrsql = "select max(valid_from) from system_params where (param_name='STAFF_DAY_START' OR param_name='STAFF_DAY_END') and company_code=? and status=1 ";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.companyCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				scStart = rs.getDate(1);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return scStart;
	}

	public Date getLastScheduleStartDateForLabour() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		Date scStart = null;
		///////////
		String usrsql = "select max(valid_from) from system_params where (param_name='LABOUR_DAY_START' OR param_name='LABOUR_DAY_END') and company_code=? and status=1;";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.companyCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				scStart = rs.getDate(1);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return scStart;
	}

	public int isSchEncompassing(String param1, String param2) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int returntype = 0;
		// check for duplication
		String usrsql = "SELECT param_value FROM  system_params where (valid_from <=? and valid_to>=?) and (param_name= ? or param_name =?) and company_code=? and status=1";
		try {

			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, this.valid_from);
			psmt.setDate(2, this.valid_to);
			// psmt.setDate(3, this.valid_from);
			// psmt.setDate(4, this.valid_to);
			psmt.setString(3, param1);
			psmt.setString(4, param2);
			psmt.setString(5, this.companyCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				System.out.println("encompass");
				returntype = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			returntype = -2;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				returntype = -2;
				System.out.println("Exception in closing DB resources");
			}
		}

		return returntype;
	}

	/**
	 * @return the editor
	 */
	public String getEditor() {
		return editor;
	}

	/**
	 * @param editor
	 *            the editor to set
	 */
	public void setEditor(String editor) {
		this.editor = editor;
	}

	/**
	 * @return the companyCode
	 */
	public String getCompanyCode() {
		return companyCode;
	}

	/**
	 * @param companyCode
	 *            the companyCode to set
	 */
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}

}
