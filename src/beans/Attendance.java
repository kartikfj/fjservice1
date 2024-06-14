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
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

class InoutTimeing {
	Time checkin;
	Time checkout;
	private int status;

	public void setCheckin(Time s) {
		checkin = s;
	}

	public void setCheckout(Time s) {
		checkout = s;
	}

	public Time getCheckout() {
		return checkout;
	}

	public Time getCheckin() {
		return checkin;
	}

	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
}

/**
 *
 * @author
 */
public class Attendance {
	private int month;
	private int year;
	private int acno;
	private Map timing;
	private Time daystart;
	private Time dayend;
	private ArrayList<ParamValue> dStart, dEnd;

	public Attendance() {
		timing = new HashMap<Integer, InoutTimeing>();

	}

	public int isWeekend(String d) {
		return 0;
	}

	public int isHoliday(String d) {
		java.sql.Date sd = java.sql.Date.valueOf(d);
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "select description from  holidays where hday=?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, sd);
			rs = psmt.executeQuery();
			logType = 0; // no such holiday
			if (rs.next()) {
				logType = 1; // holiday
			}

		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				logType = -2; // DB error
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	public String getCheckinOnDay(Integer day) {
		InoutTimeing tp = (InoutTimeing) getTiming().get(day);
		if (tp == null)
			return "";
		else
			return tp.getCheckin().toString().substring(0, 5);
	}

	public String getCheckoutOnDay(Integer day) {
		InoutTimeing tp = (InoutTimeing) getTiming().get(day);
		if (tp == null)
			return "";
		else
			return tp.getCheckout().toString().substring(0, 5);
	}

	public static double DifferenceInTime(Time from, Time to) {

		long MILLISECONDS_IN_HOUR = 60 * 60 * 1000;
		return ((to.getTime() - from.getTime() * 1.0) / MILLISECONDS_IN_HOUR);
	}

	public int getDayStatusByCalculation(Integer day, java.sql.Date sd) {
		/*
		 * InoutTimeing tp =(InoutTimeing) getTiming().get(day); if(tp == null) { return
		 * 0; //absent }
		 * 
		 * if(tp.getCheckin().getTime() == tp.getCheckout().getTime()){ //
		 * System.out.println("singleswipe "+day); return 2; //single swipe } else{ Time
		 * st = this.getDayStartValueByRange(sd); Time en =
		 * this.getDayEndValueByRange(sd); if(st == null || en == null) return -2; //
		 * System.out.println(st+" "+en + " "+sd); if(tp.checkin.getTime() <=
		 * (st.getTime()+1800000) && tp.checkout.getTime() >= (en.getTime()-600000))
		 * return 1; else return -1; }
		 * 
		 */
		InoutTimeing tp = (InoutTimeing) getTiming().get(day);
		if (tp == null) {
			return 0; // absent
		} else if (tp.getCheckin().getTime() == tp.getCheckout().getTime()) {
			System.out.println("singleswipe " + day);
			return 2; // single swipe
		} else {
			Time st = this.getDayStartValueByRange(sd);
			System.out.println("checkin : " + st + " " + tp.checkin + " date : " + sd);
			Time en = this.getDayEndValueByRange(sd);
			System.out.println("checkout : " + en + " " + tp.checkout + " date : " + sd);
			if (st == null || en == null)
				return -2;
			else if (tp.checkin.getTime() <= (st.getTime() + 1800000)
					&& tp.checkout.getTime() >= (en.getTime() - 600000))
				return 1;
			else if (tp.checkin.getTime() <= (st.getTime() + 1800000)
					&& tp.checkout.getTime() < (en.getTime() - 600000))
				return -1; // early go
			else if (tp.checkin.getTime() > (st.getTime() + 1800000)
					&& tp.checkout.getTime() >= (en.getTime() - 600000))
				return -1; // late come
			else if (tp.checkin.getTime() > (st.getTime() + 1800000) && tp.checkout.getTime() < (en.getTime() - 600000))
				return -3; // early go+late;
			else
				return 0;
		}

	}

	public int getMonthlyattendanceByQuery() {
		timing.clear();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String mmyy = "";
		mmyy = (getMonth() > 9 ? getMonth() + "-" + getYear() : "0" + getMonth() + "-" + getYear());
		String usrsql = "select extract(DAY from (swipeTime)), time(min(swipeTime)),time( max(swipeTime)) from  checkinout where accesscrdNo = ? group by date(swipeTime) having DATE_FORMAT(date(max(swipeTime)), \"%m-%Y\") = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, getAcno());
			psmt.setString(2, mmyy);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Integer dt = rs.getInt(1);
				java.sql.Time checkin = rs.getTime(2);
				java.sql.Time checkout = rs.getTime(3);
				InoutTimeing tp = new InoutTimeing();
				tp.setCheckin(checkin);
				tp.setCheckout(checkout);
				getTiming().put(dt, tp);
			}
			logType = timing.size();
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	public int getDayStatus(Integer day, java.sql.Date sd) {
		InoutTimeing tp = (InoutTimeing) getTiming().get(day);
		if (tp == null) {
			return 0; // absent
		}
		return tp.getStatus();
	}

	public int getMonthlyattendance() {
		timing.clear();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String mmyy = "";
		mmyy = (getMonth() > 9 ? getMonth() + "-" + getYear() : "0" + getMonth() + "-" + getYear());
		// String usrsql="select extract(DAY from (swipeTime)),
		// time(min(swipeTime)),time( max(swipeTime)) from checkinout where accesscrdNo
		// = ? group by date(swipeTime) having DATE_FORMAT(date(max(swipeTime)),
		// \"%m-%Y\") = ?";
		String usrsql = "select extract(DAY from (checkin)), time(checkin),time(checkout),status from  attendance where accesscrdNo = ? and DATE_FORMAT(date(checkin), \"%m-%Y\") = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, getAcno());
			psmt.setString(2, mmyy);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Integer dt = rs.getInt(1);
				java.sql.Time checkin = rs.getTime(2);
				java.sql.Time checkout = rs.getTime(3);
				int status = rs.getInt(4);
				InoutTimeing tp = new InoutTimeing();
				tp.setCheckin(checkin);
				tp.setCheckout(checkout);
				tp.setStatus(status);
				getTiming().put(dt, tp);
			}
			logType = timing.size();
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	/**
	 * @return the month
	 */
	public int getMonth() {
		return month;
	}

	/**
	 * @param month the month to set
	 */
	public void setMonth(int month) {
		this.month = month;
	}

	/**
	 * @return the year
	 */
	public int getYear() {
		return year;
	}

	/**
	 * @param year the year to set
	 */
	public void setYear(int year) {
		this.year = year;
	}

	/**
	 * @return the acno
	 */
	public int getAcno() {
		return acno;
	}

	/**
	 * @param acno the acno to set
	 */
	public void setAcno(int acno) {
		this.acno = acno;
	}

	/**
	 * @return the leaveDeatil
	 */

	/**
	 * @return the timing
	 */
	public Map getTiming() {
		return timing;
	}

	/**
	 * @param timing the timing to set
	 */
	public void setTiming(Map timing) {
		this.timing = timing;
	}

	/**
	 * @return the daystart
	 */
	public Time getDaystart() {
		return daystart;
	}

	/**
	 * @param daystart the daystart to set
	 */
	public void setDaystart(Time daystart) {
		this.daystart = daystart;
	}

	/**
	 * @return the dayend
	 */
	public Time getDayend() {
		return dayend;
	}

	/**
	 * @param dayend the dayend to set
	 */
	public void setDayend(Time dayend) {
		this.dayend = dayend;
	}

	public int getRegularisationStatus(java.sql.Date day, String uid) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usrsql = "select status from  regularisation_application where uid=? and date_to_regularise = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, uid);
			psmt.setDate(2, day);
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

	/**
	 * @return the dayStart
	 */
	public ArrayList<ParamValue> getDStart() {
		return dStart;
	}

	/**
	 * @param dayStart the dayStart to set
	 */
	public void setDStart(ArrayList<ParamValue> dayStart) {
		this.dStart = dayStart;
	}

	/**
	 * @return the dayEnd
	 */
	public ArrayList<ParamValue> getDEnd() {
		return dEnd;
	}

	/**
	 * @param dayEnd the dayEnd to set
	 */
	public void setDEnd(ArrayList<ParamValue> dayEnd) {
		this.dEnd = dayEnd;
	}

	public Time getDayStartValueByRange(java.sql.Date sd) {
		System.out.println("this.dStart == " + this.dStart);
		for (ParamValue pv : this.dStart) {
			if (pv.getCheckInRange(sd)) {
				return pv.getValue();
			}
		}
		return null;
	}

	public Time getDayEndValueByRange(java.sql.Date sd) {
		System.out.println("this.dEnd == " + this.dEnd);
		for (ParamValue pv : this.dEnd) {
			if (pv.getCheckInRange(sd)) {
				return pv.getValue();
			}
		}
		return null;
	}

	public int getAttendanceForCurProcMonth(java.sql.Date startdt, java.sql.Date enddt) {
		timing.clear();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int logType = -2;
		if (mcon == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String mmyy = "";
		mmyy = (getMonth() > 9 ? getMonth() + "-" + getYear() : "0" + getMonth() + "-" + getYear());
		// String usrsql="select extract(DAY from (swipeTime)),
		// time(min(swipeTime)),time( max(swipeTime)) from checkinout where accesscrdNo
		// = ? group by date(swipeTime) having DATE_FORMAT(date(max(swipeTime)),
		// \"%m-%Y\") = ?";
		String usrsql = "select extract(DAY from (checkin)), time(checkin),time(checkout),status from  attendance where accesscrdNo = ? and date(checkout) between ? and ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, getAcno());
			psmt.setDate(2, startdt);
			psmt.setDate(3, enddt);
			rs = psmt.executeQuery();
			while (rs.next()) {
				Integer dt = rs.getInt(1);
				java.sql.Time checkin = rs.getTime(2);
				java.sql.Time checkout = rs.getTime(3);
				int status = rs.getInt(4);
				InoutTimeing tp = new InoutTimeing();
				tp.setCheckin(checkin);
				tp.setCheckout(checkout);
				tp.setStatus(status);
				getTiming().put(dt, tp);
			}
			logType = timing.size();
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		return logType;
	}

	// .START 10-04-2020<--newly added temporary on 08-042020 to handle - HR memo-
	// for regularization without daily task restroction -->
	public int getDailyTaskStatus(java.sql.Date day, String uid) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usrsql = "SELECT distinct count(workday) as status from newfjtco.dailytask where empid = ? "
				+ "and  workday = ? ";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, uid);
			psmt.setDate(2, day);
			rs = psmt.executeQuery();
			while (rs.next()) {
				retval = rs.getInt(1);
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
	// .END <--newly added temporary on 08-042020 to handle - HR memo- for
	// regularization without daily task restroction -->

	public boolean checkWeekendsDayOrNot(String weekDays, int dayOfWeek, int calendarYear) {
		boolean weekendOrNot = false;
		if (calendarYear >= 2022) {
			if (weekDays.equalsIgnoreCase("SUN-THU") && dayOfWeek > 5) { // 6th and 7 th day, ie fiday and saturday
				weekendOrNot = true;
			} else if (weekDays.equalsIgnoreCase("MON-FRI") && (dayOfWeek > 6 || dayOfWeek == 1)) { // 7 th or 1 st day,
																									// ie saturday and
																									// sunday
				weekendOrNot = true;
			} else if (weekDays.equalsIgnoreCase("SUN-FRI") && dayOfWeek == 7) { // only 6th day, ie saturday
				weekendOrNot = true;
			} else if (weekDays.equalsIgnoreCase("SAT-THU") && dayOfWeek == 6) { // only 1 day, ie friday
				weekendOrNot = true;
			} else {
				weekendOrNot = false;
			}
		} else {
			if (dayOfWeek > 5) {
				weekendOrNot = true;
			}
		}
		// System.out.println("Weekdays : "+weekDays+" dayOfWeek: "+dayOfWeek+" year :
		// "+calendarYear+" final : "+weekendOrNot);
		return weekendOrNot;
	}

	/*
	 * public boolean checkWeekendsDayOrNot(String weekDays, int dayOfWeek, int
	 * calendarYear) { boolean weekendOrNot = false; if (calendarYear >= 2022) { if
	 * (weekDays.equalsIgnoreCase("SUN-THU") && dayOfWeek > 5) { // 6th and 7 th
	 * day, ie fiday and saturday weekendOrNot = true; } else if
	 * (weekDays.equalsIgnoreCase("MON-FRI") && (dayOfWeek > 5 || dayOfWeek == 7)) {
	 * // 7 th or 1 st day, // ie saturday and // sunday weekendOrNot = true; } else
	 * if (weekDays.equalsIgnoreCase("SUN-FRI") && dayOfWeek == 6) { // only 6th
	 * day, ie saturday weekendOrNot = true; } else if
	 * (weekDays.equalsIgnoreCase("SAT-THU") && dayOfWeek == 5) { // only 1 day, ie
	 * friday weekendOrNot = true; } else { weekendOrNot = false; } } else { if
	 * (dayOfWeek > 5) { weekendOrNot = true; } } //
	 * System.out.println("Weekdays : "+weekDays+" dayOfWeek: "+dayOfWeek+" year :
	 * // "+calendarYear+" final : "+weekendOrNot); return weekendOrNot; }
	 */

}
