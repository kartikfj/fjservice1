/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author
 */

public class Leave {

	private String emp_code = null;
	private String emp_comp_code = null;
	private ConcurrentHashMap emp_leave_types = null;
	private String cur_leave_type = null;
	private String cur_fromdt = null;
	private String cur_todt = null;
	private Date cur_procm_startdt = null;
	private String last_accrud_date = null;
	private ArrayList pendleaveapplications = null;
	private ArrayList apprleaveapplications = null;
	private ArrayList encashmentapplications = null;

	/**
	 * @return the emp_code
	 */
	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String s) {
		emp_code = s;
	}

	public String getLast_accrud_date() {
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();

		if (mcon == null)
			return null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PreparedStatement psmt = null;
		PreparedStatement psmt2 = null;
		String result = null;
		java.sql.Date resultdt = null;
		// String usrsql="SELECT LAST_DAY((TO_DATE((EXTRACT(YEAR FROM sysdate))|| '-'
		// ||(MAX(LVAC_MONTH)) ||'-01','YYYY-MM-DD' )))FROM ORION.PS_LEAVE_ACCRUAL_CURR
		// WHERE LVAC_YEAR=(EXTRACT(YEAR FROM sysdate)) AND LVAC_EMP_CODE = ? AND
		// LVAC_ACCRUED_DAYS IS NOT NULL";
		String usrsql = "SELECT LAST_DAY((TO_DATE((EXTRACT(YEAR FROM sysdate))|| '-' ||(MAX(LVAC_MONTH)) ||'-01','YYYY-MM-DD' )))FROM FJPORTAL.PS_LEAVE_ACCRUAL_CURR WHERE LVAC_YEAR=(EXTRACT(YEAR FROM sysdate)) AND LVAC_EMP_CODE = ? AND LVAC_ACCRUED_DAYS IS NOT NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				resultdt = rs.getDate(1);
			} else {
				// usrsql="SELECT LAST_DAY((TO_DATE((EXTRACT(YEAR FROM sysdate)-1)|| '-'
				// ||(MAX(LVAP_MONTH)) ||'-01','YYYY-MM-DD' )))FROM ORION.PS_LEAVE_ACCRUAL_PREV
				// WHERE LVAP_YEAR=(EXTRACT(YEAR FROM sysdate)-1) AND LVAP_EMP_CODE = ? AND
				// LVAP_ACCRUED_DAYS IS NOT NULL";
				usrsql = "SELECT LAST_DAY((TO_DATE((EXTRACT(YEAR FROM sysdate)-1)|| '-' ||(MAX(LVAP_MONTH)) ||'-01','YYYY-MM-DD' )))FROM FJPORTAL.PS_LEAVE_ACCRUAL_PREV WHERE LVAP_YEAR=(EXTRACT(YEAR FROM sysdate)-1) AND LVAP_EMP_CODE = ? AND LVAP_ACCRUED_DAYS IS NOT NULL";
				psmt2 = mcon.prepareStatement(usrsql);
				psmt2.setString(1, this.emp_code);
				rs2 = psmt2.executeQuery();
				if (rs2.next()) {
					resultdt = rs2.getDate(1);
				}

			}
			if (resultdt != null)
				result = resultdt.toString();

		} catch (Exception e) {
			e.printStackTrace();
			result = null; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				if (rs2 != null)
					rs2.close();
				if (psmt2 != null)
					psmt2.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return result;
	}

	public String getLeaveStatusOfDay(Date sd) {
		String status = "";
		try {
			for (Object o : this.apprleaveapplications) {
				LeaveApplication lv = (LeaveApplication) o;
				if (sd.getTime() >= lv.getFromdate().getTime() && sd.getTime() <= lv.getTodate().getTime()) {
					System.out.println("Date== " + sd);
					status = lv.getLeavetype();
					return status;
				}
				if (sd.getTime() == lv.getFromdate().getTime() || sd.getTime() == lv.getTodate().getTime()) {
					status = lv.getLeavetype();
					return status;
				}
			}
		} catch (Exception e) {
			status = "";
			System.out.println("Exception in leave status day for " + sd);
			e.printStackTrace();
		} finally {
			status = "";
		}
		System.out.println("Date== " + sd);
		System.out.println("getLeaveStatusOfDay status" + status);
		return status;
	}

	public int getLeaveStatusAsFullOrHalf(Date sd) {
		for (Object o : this.apprleaveapplications) {
			LeaveApplication lv = (LeaveApplication) o;
			if (sd.getTime() == lv.getFromdate().getTime() && sd.getTime() == lv.getTodate().getTime()
					&& lv.getLeavedays() == 0.5) {
				return 2; // halfday
			} else if (sd.getTime() >= lv.getFromdate().getTime() && sd.getTime() <= lv.getTodate().getTime()) {
				return 1; // fullday
			}

		}
		return 0;
	}

	public String getLeaveStatusOf(String d) { // check if a date is availed or approved leave.
		// java.sql.Date sd = java.sql.Date.valueOf(d);
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date dt;
		try {
			dt = formatter.parse(d);
		} catch (ParseException ex) {
			Logger.getLogger(Holiday.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
		Date sd = new Date(dt.getTime());
		// System.out.println(sd);
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();

		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String leavetype = null;
		// String usrsql="SELECT LVAH_LV_CATG_CODE FROM ORION.PT_LEAVE_APPLICATION_HEAD
		// WHERE ? BETWEEN LVAH_START_DT AND LVAH_END_DT AND LVAH_EMP_CODE = ? AND
		// LVAH_COMP_CODE =? AND LVAH_CANC_UID IS NULL";
		String usrsql = "SELECT LVAH_LV_CATG_CODE FROM FJPORTAL.PT_LEAVE_APPLICATION_HEAD WHERE ? BETWEEN LVAH_START_DT AND LVAH_END_DT AND LVAH_EMP_CODE = ? AND LVAH_COMP_CODE =? AND LVAH_CANC_UID IS NULL";

		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, sd);
			psmt.setString(2, this.emp_code);
			psmt.setString(3, this.emp_comp_code);
			rs = psmt.executeQuery();
			leavetype = ""; // no such leave application
			if (rs.next()) {
				leavetype = rs.getString(1);
				// System.out.print(d+leavetype);
			}

		} catch (Exception e) {
			e.printStackTrace();
			leavetype = null; // DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				leavetype = null; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return leavetype;
	}

	/**
	 * @return the emp_leave_types
	 */
	public ConcurrentHashMap getEmp_leave_types() {
		return emp_leave_types;
	}

	/**
	 * @param emp_leave_types the emp_leave_types to set
	 */
	public void setEmp_leave_types(ConcurrentHashMap emp_leave_types) {
		this.emp_leave_types = emp_leave_types;
	}

	/**
	 * @return current leave balances for all leave types of an employee
	 */
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
			psmt.setString(2, this.getEmp_comp_code());
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

	public int getCurrentAccruedLeave() { // leave balance of a particular leave as on the current processing month
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null || this.cur_leave_type == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// System.out.println("Current accrued params: "+this.emp_code+"
		// "+this.emp_comp_code+" "+this.cur_leave_type);

		String sqlstr = "SELECT PAYROLL.FJT_LEAVE_CURR_INFO.BALANCE_DAYS FROM PAYROLL.FJT_LEAVE_CURR_INFO WHERE LVAC_EMP_CODE = ? AND LVAC_COMP_CODE = ? AND LVAC_LV_CODE = ? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.getEmp_comp_code());
			psmt.setString(3, this.cur_leave_type);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getInt(1);
				System.out.println("balance, " + retval + " " + this.cur_leave_type + " " + rs.getFloat(1));
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

	public int getFutureAccuredLeaveOn() { // from last accrued date to applied date
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		Connection con = orcl.getOrclConn();
		if (con == null || this.cur_fromdt == null || this.cur_leave_type == null)
			return -2;
		int retval = 0;
		String[] datecomps = cur_fromdt.split("/");
		if (datecomps.length != 3)
			return -2;
		String formated_dt = datecomps[2] + "-" + datecomps[1] + "-" + datecomps[0];
		java.sql.Date sd = java.sql.Date.valueOf(formated_dt);
		// System.out.println(sd);
		// System.out.println("future accrued leave params: "+this.emp_code+"
		// "+this.emp_comp_code+" "+this.cur_fromdt+" "+this.cur_leave_type);
		CallableStatement cstmt = null;
		try {
			cstmt = con.prepareCall("{? = call PAYROLL.FJT_GET_LVE_ACCR (?,?,?,?) }");

			cstmt.registerOutParameter(1, Types.INTEGER);
			cstmt.setString(2, this.emp_code);
			cstmt.setString(3, this.getEmp_comp_code());
			cstmt.setString(4, this.cur_leave_type);
			cstmt.setDate(5, sd);
			cstmt.execute();
			retval = cstmt.getInt(1);
			// System.out.println("got "+retval);
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (cstmt != null)
					cstmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;

	}

	public float getLeaveBalanceOf() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		float retval = 0;
		if (this.cur_leave_type.equalsIgnoreCase("LWP")) {
			return getLWPBalance();
		}
		String sqlstr = "SELECT BALANCE_DAYS FROM PAYROLL.FJT_LEAVE_CURR_INFO WHERE LVAC_EMP_CODE = ? AND LVAC_COMP_CODE = ? AND LVAC_LV_CODE=?";
		if (this.cur_leave_type.equalsIgnoreCase("LENC")) {
			sqlstr = "SELECT BALANCE_DAYS FROM PAYROLL.FJT_LEAVE_CURR_INFO WHERE LVAC_EMP_CODE = ? AND LVAC_COMP_CODE = ? AND (LVAC_LV_CODE='AN60' OR LVAC_LV_CODE='AN30' OR LVAC_LV_CODE='AN15')";
		}

		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.emp_comp_code);
			if (!this.cur_leave_type.equalsIgnoreCase("LENC"))
				psmt.setString(3, this.cur_leave_type);
			rs = psmt.executeQuery();

			if (rs.next()) {
				retval = rs.getFloat(1);
			}
		} catch (Exception e) {
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

	/**
	 * @return the leave balance accrued on specific date.
	 */
	public double getCallfunctionasSQL()

	{
		//
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		double retval = 0;
		String[] datecomps = cur_fromdt.split("/");
		if (datecomps.length != 3)
			return -2;

		String sqlstr = "select PAYROLL.FJT_GET_LVE_ACCR('" + this.emp_comp_code + "','" + this.emp_code + "','"
				+ this.cur_leave_type + "',to_date('" + cur_fromdt + "','DD/MM/YYYY')) FROM dual";
		try {
			psmt = con.prepareStatement(sqlstr);
			rs = psmt.executeQuery();
			ResultSetMetaData rsm = rs.getMetaData();
			while (rs.next()) {
				retval = rs.getDouble(1);

			}

		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
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

	public float getLWPBalance() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		float retval = 0;
		String sqlstr = "select SUM(LWP_UPTO_DT - LWP_FROM_DT) FROM PT_LWP WHERE (to_char(LWP_UPTO_DT,'YYYY')=to_char(sysdate, 'YYYY'))AND LWP_EMP_CODE = ? AND LWP_COMP_CODE = ?";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.emp_comp_code);
			rs = psmt.executeQuery();

			if (rs.next()) {
				retval = rs.getFloat(1);
				retval = (float) (60.0 - retval);
			}
		} catch (Exception e) {
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

	/**
	 * @ retrieve all approved leave applications after last processing date of
	 * month
	 */

	public int getAllApprovedLeaveApplications() {
		if (this.apprleaveapplications == null)
			apprleaveapplications = new ArrayList<LeaveApplication>();
		else
			apprleaveapplications.clear();
		int retval1 = getAllApprovedNormalLeaveApplications();
		// System.out.print(retval1);
		if (retval1 >= 0)
			retval1 += getAllApprovedLWPApplications();
		// System.out.print(retval1);
		return retval1;
	}

	private int getAllApprovedNormalLeaveApplications() {
		if (this.apprleaveapplications == null)
			apprleaveapplications = new ArrayList<LeaveApplication>();

		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();

		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;

		// String usrsql="SELECT
		// LVAH_START_DT,LVAH_END_DT,LVAH_DAYS,LVAH_LV_CATG_CODE,LVAH_REMARKS,LVAH_RESU_DT
		// FROM ORION.PT_LEAVE_APPLICATION_HEAD WHERE LVAH_START_DT >= ? AND
		// LVAH_EMP_CODE = ? AND LVAH_CANC_UID IS NULL AND LVAH_COMP_CODE =?";
		String usrsql = "SELECT LVAH_START_DT,LVAH_END_DT,LVAH_DAYS,LVAH_LV_CATG_CODE,LVAH_REMARKS,LVAH_RESU_DT FROM FJPORTAL.PT_LEAVE_APPLICATION_HEAD WHERE  LVAH_EMP_CODE = ? AND LVAH_CANC_UID IS NULL AND LVAH_COMP_CODE =?";
		try {
			// System.out.println(this.cur_procm_startdt+" "+this.emp_code+"
			// "+this.emp_comp_code);
			psmt = mcon.prepareStatement(usrsql);
			// psmt.setDate(1,this.cur_procm_startdt);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.emp_comp_code);
			rs = psmt.executeQuery();
			while (rs.next()) {
				LeaveApplication lva = new LeaveApplication();
				lva.setFromdate(rs.getDate(1));
				lva.setTodate(rs.getDate(2));
				lva.setLeavedays(rs.getFloat(3));
				lva.setLeavetype(rs.getString(4));
				lva.setReason(rs.getString(5));
				lva.setResumedate(rs.getDate(6));
				this.apprleaveapplications.add(lva);
			}
			retval = getApprleaveapplications().size();
			// System.out.println("approved :"+retval);
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

	private int getAllApprovedLWPApplications() {
		if (this.apprleaveapplications == null)
			apprleaveapplications = new ArrayList<LeaveApplication>();
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();

		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;

		// String usrsql="SELECT LWP_FROM_DT,LWP_UPTO_DT,LWP_DAYS,LWP_REMARKS FROM
		// ORION.PT_LWP WHERE LWP_EMP_CODE = ? AND LWP_COMP_CODE =?";
		String usrsql = "SELECT LWP_FROM_DT,LWP_UPTO_DT,LWP_DAYS,LWP_REMARKS FROM FJPORTAL.PT_LWP WHERE LWP_EMP_CODE = ? AND LWP_COMP_CODE =?";
		try {
			// System.out.println(this.cur_procm_startdt+" "+this.emp_code+"
			// "+this.emp_comp_code);
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setString(2, this.emp_comp_code);
			rs = psmt.executeQuery();
			while (rs.next()) {
				LeaveApplication lva = new LeaveApplication();
				lva.setFromdate(rs.getDate(1));
				lva.setTodate(rs.getDate(2));
				lva.setLeavedays(rs.getFloat(3));
				lva.setLeavetype("LWP");
				lva.setReason(rs.getString(4));
				lva.setResumedate(null);
				this.apprleaveapplications.add(lva);
			}
			retval = getApprleaveapplications().size();
			// System.out.println("approved :"+retval);
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
	 * @read all valid pending leave applications
	 */
	public int getAllPendingLeaveApplications() {
		if (pendleaveapplications == null)
			pendleaveapplications = new ArrayList<LeaveApplication>();
		else
			pendleaveapplications.clear();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		String value = null;
		if (mcon == null)
			return -2;
		int retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		java.util.Date returntype = null;
		String usrsql = "SELECT fromdate,todate,leavedays,leavetype,reason,resumedate,applied_date,totaldays FROM  leave_application where fromdate > ? and (status=1||status=2) and uid = ? and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, cur_procm_startdt);
			psmt.setString(2, this.emp_code);
			rs = psmt.executeQuery();

			while (rs.next()) {
				LeaveApplication lva = new LeaveApplication();
				lva.setFromdate(rs.getDate(1));
				lva.setTodate(rs.getDate(2));
				lva.setLeavedays(rs.getFloat(3));
				lva.setLeavetype(rs.getString(4));
				lva.setReason(rs.getString(5));
				lva.setResumedate(rs.getDate(6));
				lva.setApplied_date(rs.getTimestamp(7));
				lva.setTotaldays(rs.getFloat(8));
				this.pendleaveapplications.add(lva);
			}
			retval = this.pendleaveapplications.size();
			// System.out.println("Pending :"+retval);
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

	public String getEmp_comp_code() {
		return emp_comp_code;
	}

	/**
	 * @param emp_comp_code the emp_comp_code to set
	 */
	public void setEmp_comp_code(String emp_comp_code) {
		this.emp_comp_code = emp_comp_code;
	}

	/**
	 * @return the cur_leave_type
	 */
	public String getCur_leave_type() {
		return cur_leave_type;
	}

	/**
	 * @param cur_leave_type the cur_leave_type to set
	 */
	public void setCur_leave_type(String cur_leave_type) {
		this.cur_leave_type = cur_leave_type;
	}

	/**
	 * @return the cur_fromdt
	 */
	public String getCur_fromdt() {
		return cur_fromdt;
	}

	/**
	 * @param cur_fromdt the cur_fromdt to set
	 */
	public void setCur_fromdt(String cur_fromdt) {
		this.cur_fromdt = cur_fromdt;
	}

	/**
	 * @return the cur_todt
	 */
	public String getCur_todt() {
		return cur_todt;
	}

	/**
	 * @param cur_todt the cur_todt to set
	 */
	public void setCur_todt(String cur_todt) {
		this.cur_todt = cur_todt;
	}

	/**
	 * @return the cur_procm_startdt
	 */
	public Date getCur_procm_startdt() {
		return cur_procm_startdt;
	}

	/**
	 * @param cur_procm_startdt the cur_procm_startdt to set
	 */
	public void setCur_procm_startdt(Date cur_procm_startdt) {
		this.cur_procm_startdt = cur_procm_startdt;
	}

	/**
	 * @return the pendleaveapplications
	 */
	public ArrayList getPendleaveapplications() {

		return pendleaveapplications;
	}

	/**
	 * @return the apprleaveapplications
	 */
	public ArrayList getApprleaveapplications() {

		return apprleaveapplications;
	}

	public int getAllPendingEncashmentApplications() {
		if (encashmentapplications == null)
			encashmentapplications = new ArrayList<LeaveEncashment>();
		else
			encashmentapplications.clear();

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "SELECT effective_date,leave_encash_days,leave_catcode,remarks,applied_date FROM  leave_encashments where effective_date > ? and emp_code=? and status=1 and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, cur_procm_startdt);
			psmt.setString(2, this.emp_code);
			rs = psmt.executeQuery();

			while (rs.next()) {
				LeaveEncashment lva = new LeaveEncashment();
				lva.setEffectivedate(rs.getDate(1));
				lva.setEncashdays(rs.getFloat(2));
				lva.setLeavetype(rs.getString(3));
				lva.setReason(rs.getString(4));
				lva.setApplied_date(rs.getTimestamp(5));

				this.encashmentapplications.add(lva);
			}
			retval = this.encashmentapplications.size();
			// System.out.println();
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

	/**
	 * @return the encashmentapplications
	 */
	public ArrayList getEncashmentapplications() {
		return encashmentapplications;
	}

	/**
	 * @param encashmentapplications the encashmentapplications to set
	 */
	public void setEncashmentapplications(ArrayList encashmentapplications) {
		this.encashmentapplications = encashmentapplications;
	}

	/**
	 * list of incoming leave requests
	 */
	public float getNoOfPendingLeaveDays(Date fromdt, Date todt) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		String value = null;
		if (mcon == null)
			return -2;
		float retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		java.util.Date returntype = null;
		// "SELECT count(*) FROM leave_application where fromdate >= ? and todate <=?
		// and (status=1 || status=2) and uid = ? and cancel_date is NULL";
		String usrsql = "SELECT sum(leavedays) FROM  leave_application where fromdate >= ? and  todate <=? and (status=1 || status=2) and uid = ? and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, fromdt);
			psmt.setDate(2, todt);
			psmt.setString(3, this.emp_code);
			rs = psmt.executeQuery();

			if (rs.next()) {
				retval = rs.getFloat(1);
			}
			float begnoverlapp = getNoOfPendingLeaveDaysOverlappingBeginning(fromdt, todt);
			if (begnoverlapp > 0)
				retval += begnoverlapp;
			float endoverlapp = getNoOfPendingLeaveDaysOverlappingEnding(fromdt, todt);
			if (endoverlapp > 0)
				retval += endoverlapp;

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

	public float getNoOfPendingLeaveDaysOverlappingBeginning(Date fromdt, Date todt) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		String value = null;
		if (mcon == null)
			return -2;
		float retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		java.util.Date returntype = null;
		// "SELECT count(*) FROM leave_application where fromdate >= ? and todate <=?
		// and (status=1 || status=2) and uid = ? and cancel_date is NULL";
		String usrsql = "SELECT leavedays - (? - fromdate) FROM  leave_application where fromdate < ? and  todate <=? and (status=1 || status=2) and uid = ? and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, fromdt);
			psmt.setDate(2, fromdt);
			psmt.setDate(3, todt);
			psmt.setString(4, this.emp_code);
			rs = psmt.executeQuery();

			if (rs.next()) {
				retval = rs.getFloat(1);

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

	public float getNoOfPendingLeaveDaysOverlappingEnding(Date fromdt, Date todt) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		String value = null;
		if (mcon == null)
			return -2;
		float retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		java.util.Date returntype = null;
		// "SELECT count(*) FROM leave_application where fromdate >= ? and todate <=?
		// and (status=1 || status=2) and uid = ? and cancel_date is NULL";
		String usrsql = "SELECT (? - fromdate) FROM  leave_application where fromdate  >= ? and  todate > ? and (status=1 || status=2) and uid = ? and cancel_date is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, todt);
			psmt.setDate(2, fromdt);
			psmt.setDate(3, todt);
			psmt.setString(4, this.emp_code);
			rs = psmt.executeQuery();

			if (rs.next()) {
				retval = rs.getFloat(1);
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

	public Date getJoiningDate() {

		OrclDBConnectionPool con = new OrclDBConnectionPool();
		Connection mcon = con.getOrclConn();

		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String result = null;
		java.sql.Date resultdt = null;
		String strDate = null;

		String usrsql = "SELECT EMP_JOIN_DT FROM PAYROLL.PM_EMP_KEY WHERE EMP_CODE =?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				resultdt = rs.getDate(1);
				System.out.println("getJoiningDate== " + resultdt);

			}

		} catch (Exception e) {
			e.printStackTrace();
			result = null; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return resultdt;
	}

	public int getBusinessTripLVApplStatus(Date d) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date dt;
//	        try {
//	            dt = formatter.parse(d);
//	        } catch (ParseException ex) {
//	            Logger.getLogger(Holiday.class.getName()).log(Level.SEVERE, null, ex);
//	            return -2;
//	        }
//	        Date sd= new Date(dt.getTime()); 

		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usrsql = "select status from  businesstrip_leave_application where ? BETWEEN  fromdate AND todate AND uid=? and comp_code = ? AND canceldate IS NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, d);
			psmt.setString(2, this.emp_code);
			psmt.setString(3, this.emp_comp_code);
			rs = psmt.executeQuery();
			while (rs.next()) {
				retval = rs.getInt(1);
				if (retval == 4 || retval == 1)
					break;
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

}
