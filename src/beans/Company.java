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
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author  
 */
public class Company {
	private String compCode;
	private ArrayList lbStartSch = null;
	private ArrayList lbEndSch = null;
	private ArrayList stfStartSch = null;
	private ArrayList stfEndSch = null;
	private Date curProcMonth = null;

	/**
	 * @return the compCode
	 */

	public String getCompCode() {
		return compCode;
	}

	/**
	 * @param compCode
	 *            the compCode to set
	 */
	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}

	public ArrayList getLabourDayEndValuesOfCurProcMonth(int refresh, Date stdt, Date endt) {
		if (refresh == 1) {
			if (getLbEndSch() != null)
				getLbEndSch().clear();
		}
		if (getLbEndSch() != null)
			return this.getLbEndSch();
		setLbEndSch(new ArrayList<ParamValue>());
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null; // select * from newfjtco.system_params where ((valid_from between '2017-01-05'
										// and '2017-02-05') or (valid_to between '2017-01-05' and '2017-02-05') ) and
										// status=1
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ((valid_from between ? and ?) or (valid_to between ? and ?) or  valid_from < ? and valid_to > ? ) and param_name='LABOUR_DAY_END' and status=1 and company_code=? order by valid_from";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, stdt);
			psmt.setDate(2, endt);
			psmt.setDate(3, stdt);
			psmt.setDate(4, endt);
			psmt.setDate(5, stdt);
			psmt.setDate(6, endt);
			psmt.setString(7, this.getCompCode());
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
				ParamValue p = new ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				getLbEndSch().add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			setLbEndSch(null);

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				setLbEndSch(null);
				System.out.println("Exception in closing DB resources");
			}
		}

		return getLbEndSch();
	}

	public ArrayList getLabourDayStartValuesOfCurProcMonth(int refresh, Date stdt, Date endt) {

		if (refresh == 1) {
			if (getLbStartSch() != null)
				getLbStartSch().clear();
		}
		if (getLbStartSch() != null)
			return this.getLbStartSch();
		setLbStartSch(new ArrayList<ParamValue>());
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null; // select * from newfjtco.system_params where ((valid_from between '2017-01-05'
										// and '2017-02-05') or (valid_to between '2017-01-05' and '2017-02-05') ) and
										// status=1
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ((valid_from between ? and ?) or (valid_to between ? and curdate ?) or  valid_from < ? and valid_to > ? ) and param_name='LABOUR_DAY_START' and status=1 and company_code=? order by valid_from";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, stdt);
			psmt.setDate(2, endt);
			psmt.setDate(3, stdt);
			psmt.setDate(4, endt);
			psmt.setDate(5, stdt);
			psmt.setDate(6, endt);
			psmt.setString(7, this.getCompCode());
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
				ParamValue p = new ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				getLbStartSch().add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			setLbStartSch(null);

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				setLbStartSch(null);
				System.out.println("Exception in closing DB resources");
			}
		}

		return getLbStartSch();
	}

	public ArrayList getStaffDayStartValuesOfCurProcMonth(int refresh, Date stdt, Date endt) {
		if (refresh == 1) {
			if (getStfStartSch() != null)
				getStfStartSch().clear();
		}
		if (getStfStartSch() != null)
			return this.getStfStartSch();
		setStfStartSch(new ArrayList<ParamValue>());
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null; // select * from newfjtco.system_params where ((valid_from between '2017-01-05'
										// and '2017-02-05') or (valid_to between '2017-01-05' and '2017-02-05') ) and
										// status=1
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ((valid_from between ? and ?) or (valid_to between ? and ?) or  valid_from < ? and valid_to > ? ) and param_name='STAFF_DAY_START' and status=1 and company_code=? order by valid_from desc";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, stdt);
			psmt.setDate(2, endt);
			psmt.setDate(3, stdt);
			psmt.setDate(4, endt);
			psmt.setDate(5, stdt);
			psmt.setDate(6, endt);
			psmt.setString(7, this.getCompCode());
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
				ParamValue p = new ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);				
				//System.out.println("START DAY FROM: "+from+" TO: "+to+" "+convertedTm);
				getStfStartSch().add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			setStfStartSch(null);

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				setStfStartSch(null);
				System.out.println("Exception in closing DB resources");
			}
		}

		return getStfStartSch();
	}

	public ArrayList getStaffDayEndValuesOfCurProcMonth(int refresh, Date stdt, Date endt) {

		if (refresh == 1) {
			if (getStfEndSch() != null)
				getStfEndSch().clear();
		}
		if (getStfEndSch() != null)
			return this.getStfStartSch();

		setStfEndSch(new ArrayList<ParamValue>());
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		Date from;
		Date to;
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null; // select * from newfjtco.system_params where ((valid_from between '2017-01-05'
										// and '2017-02-05') or (valid_to between '2017-01-05' and '2017-02-05') ) and
										// status=1
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params where ((valid_from between ? and ?) or (valid_to between ? and ?) or  valid_from < ? and valid_to > ? ) and param_name='STAFF_DAY_END' and status=1 and company_code=? order by valid_from desc";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, stdt);
			psmt.setDate(2, endt);
			psmt.setDate(3, stdt);
			psmt.setDate(4, endt);
			psmt.setDate(5, stdt);
			psmt.setDate(6, endt);
			psmt.setString(7, this.getCompCode());
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
				ParamValue p = new ParamValue();
				p.setFrom(from);
				p.setTo(to);
				p.setValue(convertedTm);
				//System.out.println("END DAY FROM: "+from+" TO: "+to+" "+convertedTm);
				getStfEndSch().add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
			setStfEndSch(null);

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				setStfEndSch(null);
				System.out.println("Exception in closing DB resources");
			}
		}

		return getStfEndSch();
	}

	/**
	 * @return the lbStartSch
	 */
	public ArrayList getLbStartSch() {
		return lbStartSch;
	}

	/**
	 * @param lbStartSch
	 *            the lbStartSch to set
	 */
	public void setLbStartSch(ArrayList lbStartSch) {
		this.lbStartSch = lbStartSch;
	}

	/**
	 * @return the lbEndSch
	 */
	public ArrayList getLbEndSch() {
		return lbEndSch;
	}

	/**
	 * @param lbEndSch
	 *            the lbEndSch to set
	 */
	public void setLbEndSch(ArrayList lbEndSch) {
		this.lbEndSch = lbEndSch;
	}

	/**
	 * @return the stfStartSch
	 */
	public ArrayList getStfStartSch() {
		return stfStartSch;
	}

	/**
	 * @param stfStartSch
	 *            the stfStartSch to set
	 */
	public void setStfStartSch(ArrayList stfStartSch) {
		this.stfStartSch = stfStartSch;
	}

	/**
	 * @return the stfEndSch
	 */
	public ArrayList getStfEndSch() {
		return stfEndSch;
	}

	/**
	 * @param stfEndSch
	 *            the stfEndSch to set
	 */
	public void setStfEndSch(ArrayList stfEndSch) {
		this.stfEndSch = stfEndSch;
	}

	/**
	 * @return the curProcMonth
	 */
	public Date getCurProcMonth() {
		return curProcMonth;
	}

	/**
	 * @param curProcMonth
	 *            the curProcMonth to set
	 */
	public void setCurProcMonth(Date curProcMonth) {
		this.curProcMonth = curProcMonth;
	}
}
