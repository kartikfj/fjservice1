/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Mamatha
 */
public class CompParam {

	private java.sql.Date currentProcMonthStartDate;
	private int month;
	private int year;
	private int procMonth;
	private int procYear;
	String ref_date = null;
	private String companyCode;
	private String editor;
	private WorkSchedule1 newschedule;

	public CompParam() {
		currentProcMonthStartDate = null;

		ref_date = null;
	}

	public Date getCurrentProcMonthStartDate() {
		if (this.currentProcMonthStartDate == null) {
			getReadCurrentProcMonthStartDate();
		}
		return this.currentProcMonthStartDate;
	}

	public int getReadCurrentProcMonthStartDate() {

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		String name = null;
		String type = null;
		String value = null;
		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int returntype = 0;
		// String usrsql="select param_name,param_value,param_type from system_params
		// where now() > valid_from and now() <valid_to order by valid_from desc";
		String usrsql = "SELECT param_value, month(valid_from) as month, year(valid_from) as year from  system_params where param_name='CUR_PROCM_START' and status=1 and valid_from = (select max(valid_from) from  system_params where param_name='CUR_PROCM_START' and status=1)";
		try {
			psmt = mcon.prepareStatement(usrsql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				returntype++;
				value = rs.getString(1);

				if (value == null) {
					System.out.println("Error in reading parameter");
					returntype = -2;
				}
				// System.out.println("as string :"+value);
				DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				java.util.Date dt = formatter.parse(value);
				// System.out.println("date compparam"+dt);
				this.currentProcMonthStartDate = new Date(dt.getTime());
				this.procMonth = rs.getInt(2);
				this.procYear = rs.getInt(3);
			}

		} catch (Exception e) {
			e.printStackTrace();
			returntype = -2;

		} finally {
			try {
				rs.close();
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
	 * @return the ref_date
	 */
	public String getRef_date() {
		return ref_date;
	}

	/**
	 * @param ref_date
	 *            the ref_date to set
	 */
	public void setRef_date(String ref_date) {
		this.ref_date = ref_date;
	}

	public ArrayList<beans.ParamValue> getLabourDayEndValuesOfTheMonth() {
		ArrayList<beans.ParamValue> lst = new ArrayList<beans.ParamValue>();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ? between month(valid_from) and month(valid_to) and  year(valid_from)<=? and year(valid_to)>=? and param_name='LABOUR_DAY_END' and status=1 and company_code=? order by valid_from desc;";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, this.month);
			psmt.setInt(2, this.year);
			psmt.setInt(3, this.year);
			psmt.setString(4, this.companyCode);
			rs = psmt.executeQuery();
			String str;
			while (rs.next()) {
				from = rs.getDate(1);
				to = rs.getDate(2);
				str = rs.getString(3);
				if (from == null || to == null || str == null) {
					System.out.println("Error in reading parameter");
					break;
				}
				DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
				java.util.Date dtr = formatter.parse(str);
				Time convertedTm = new Time(dtr.getTime());
				beans.ParamValue p = new beans.ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				lst.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			lst = null;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				lst = null;
				System.out.println("Exception in closing DB resources");
			}
		}

		return lst;
	}

	public ArrayList<beans.ParamValue> getLabourDayStartValuesOfTheMonth() {
		ArrayList<beans.ParamValue> lst = new ArrayList<beans.ParamValue>();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		// System.out.println("getLabourDayStartValuesOfTheMonth :"+this.month+"
		// :"+this.year+":"+this.companyCode);
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ? between month(valid_from) and month(valid_to) and  year(valid_from)<=? and year(valid_to)>=? and param_name='LABOUR_DAY_START' and status=1 and company_code=? order by valid_from desc";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, this.month);
			psmt.setInt(2, this.year);
			psmt.setInt(3, this.year);
			psmt.setString(4, this.companyCode);
			rs = psmt.executeQuery();
			String str;
			while (rs.next()) {
				from = rs.getDate(1);
				to = rs.getDate(2);
				str = rs.getString(3);
				if (from == null || to == null || str == null) {
					System.out.println("Error in reading parameter");
					break;
				}
				DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
				java.util.Date dtr = formatter.parse(str);
				Time convertedTm = new Time(dtr.getTime());
				beans.ParamValue p = new beans.ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				lst.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			lst = null;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				lst = null;
				System.out.println("Exception in closing DB resources");
			}
		}

		return lst;
	}

	public ArrayList<beans.ParamValue> getStaffDayStartValuesOfTheMonth() {
		ArrayList<beans.ParamValue> lst = new ArrayList<beans.ParamValue>();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		// System.out.println("getStaffDayStartValuesOfTheMonth :"+this.month+"
		// :"+this.year+":"+this.companyCode);
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ? between month(valid_from) and month(valid_to) and  year(valid_from)<=? and year(valid_to)>=? and param_name='STAFF_DAY_START' and status=1 and company_code= ? order by valid_from desc;";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, this.month);
			psmt.setInt(2, this.year);
			psmt.setInt(3, this.year);
			psmt.setString(4, this.companyCode);
			rs = psmt.executeQuery();
			String str, name;
			while (rs.next()) {
				from = rs.getDate(1);
				to = rs.getDate(2);
				str = rs.getString(3);

				if (from == null || to == null || str == null) {
					System.out.println("Error in reading parameter");
					break;
				}
				DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
				java.util.Date dtr = formatter.parse(str);
				Time convertedTm = new Time(dtr.getTime());
				beans.ParamValue p = new beans.ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				lst.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			lst = null;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				lst = null;
				System.out.println("Exception in closing DB resources");
			}
		}
		// System.out.println(lst.size());
		return lst;
	}

	public ArrayList<beans.ParamValue> getStaffDayEndValuesOfTheMonth() {
		ArrayList<beans.ParamValue> lst = new ArrayList<beans.ParamValue>();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ? between month(valid_from) and month(valid_to) and  year(valid_from)<=? and year(valid_to)>=? and param_name='STAFF_DAY_END' and status=1 and company_code=? order by valid_from desc;";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, this.month);
			psmt.setInt(2, this.year);
			psmt.setInt(3, this.year);
			psmt.setString(4, this.companyCode);
			rs = psmt.executeQuery();
			String str;
			while (rs.next()) {
				from = rs.getDate(1);
				to = rs.getDate(2);
				str = rs.getString(3);

				if (from == null || to == null || str == null) {
					System.out.println("Error in reading parameter");
					break;
				}
				DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
				java.util.Date dtr = formatter.parse(str);
				Time convertedTm = new Time(dtr.getTime());
				beans.ParamValue p = new beans.ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				lst.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			lst = null;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				lst = null;
				System.out.println("Exception in closing DB resources");
			}
		}

		return lst;
	}

	/**
	 * @return the month
	 */
	public int getMonth() {
		return month;
	}

	/**
	 * @param month
	 *            the month to set
	 */
	public void setMonth(int month) {
		// System.out.print(month);
		this.month = month;
	}

	/**
	 * @return the year
	 */
	public int getYear() {
		return year;
	}

	/**
	 * @param year
	 *            the year to set
	 */
	public void setYear(int year) {
		// System.out.print(year);
		this.year = year;
	}

	/**
	 * @return the procMonth
	 */
	public int getProcMonth() {
		return procMonth;
	}

	/**
	 * @param procMonth
	 *            the procMonth to set
	 */
	public void setProcMonth(int procMonth) {
		this.procMonth = procMonth;
	}

	/**
	 * @return the procYear
	 */
	public int getProcYear() {
		return procYear;
	}

	/**
	 * @param procYear
	 *            the procYear to set
	 */
	public void setProcYear(int procYear) {
		this.procYear = procYear;
	}

	public int getAddCurProcMonth() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		PreparedStatement psmt = null;
		String usrsql;
		String validfrom = "01/" + ((this.month) <= 9 ? "0" + (this.month) : (this.month)) + "/" + this.year;
		// System.out.println("getAddCurProcMonth "+validfrom);
		String validto = "01/01/2099";
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt1, dt2;
		java.sql.Date vfdate = null;
		java.sql.Date vtdate = null;
		try {
			dt1 = formatter.parse(validfrom);
			dt2 = formatter.parse(validto);
			vfdate = new Date(dt1.getTime());
			vtdate = new Date(dt2.getTime());
			// System.out.println(vfdate);
		} catch (ParseException ex) {
			System.out.print("Error in date format");
			logType = -2;
		}
		try {
			usrsql = "insert into  system_params (param_name,param_value,param_type,valid_from,valid_to,status,company_code,editor_id) values('CUR_PROCM_START',?,'DATE',?,?,?,?,?)";
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.ref_date);
			psmt.setDate(2, vfdate);
			psmt.setDate(3, vtdate);
			psmt.setInt(4, 1);
			psmt.setString(5, this.companyCode);
			psmt.setString(6, this.editor);
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
	 * @return the newschedule
	 */
	public WorkSchedule1 getNewschedule() {
		return newschedule;
	}

	/**
	 * @param newschedule
	 *            the newschedule to set
	 */
	public void setNewschedule(WorkSchedule1 newschedule) {
		this.newschedule = newschedule;
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
}
