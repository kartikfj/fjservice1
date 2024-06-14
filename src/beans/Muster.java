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
import java.util.GregorianCalendar;

/**
 *
 * @author
 */
public class Muster {
	private String compcode;
	private Holiday hhh;
	private java.sql.Date startdt;
	private java.sql.Date enddt;
	private String sectionCode;
	private ArrayList<MusterEntry> lst = null;

	public Muster() {
		hhh = new Holiday();
	}

	public int getProcessAllEmployeeDeatilsOfThecompany() throws SQLException {
		int retval = 0;
		OrclDBConnectionPool mcon = new OrclDBConnectionPool();
		Connection con = mcon.getOrclConn();
		if (con == null) {
			System.out.println("DB error with oracle.");
			return -2;
		}
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String sqlstr = "";

		if (lst == null)
			setLst(new ArrayList<MusterEntry>());
		else
			lst.clear();

		if (this.compcode.equals("ALL")) {
			sqlstr = "SELECT EMP_CODE,EMP_NAME,EMP_CALENDAR_CODE,EMP_COMP_CODE,EMP_DIVN_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_CONT_TYPE_CODE ='STAFF'";
			psmt = con.prepareStatement(sqlstr);
			rs = psmt.executeQuery();
		} else {
			sqlstr = "SELECT EMP_CODE,EMP_NAME,EMP_CALENDAR_CODE,EMP_COMP_CODE,EMP_DIVN_CODE FROM  FJPORTAL.PM_EMP_KEY WHERE EMP_COMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') AND EMP_DIVN_CODE=? ";
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.compcode);
			psmt.setString(2, this.getSectionCode());
			rs = psmt.executeQuery();
		}
		// System.out.println("compamny code " + this.compcode + " --- division code " +
		// this.getSectionCode());
		try {

			while (rs.next()) {
				fjtcouser fjtusr = new fjtcouser();
				Company comp = new Company();
				String emcode = rs.getString(1);
				String empname = rs.getString(2);
				String calcode = rs.getString(3);
				String compcode = rs.getString(4);
				String divncode = rs.getString(5);
				if (emcode == null || empname == null || calcode == null) {
					System.out.println("Employee data missing");
					retval = -2;
					break;
				}
				comp.setCompCode(compcode);
				hhh.setCompCode(compcode);
				hhh.getAllHolidaysBetween(startdt, enddt);
				fjtusr.setEmp_com_code(compcode);
				fjtusr.setEmp_divn_code(divncode);
				fjtusr.setEmp_code(emcode);
				fjtusr.setUname(empname);
				fjtusr.setCalander_code(calcode);
				fjtusr.getMoreUserDetails();
				System.out.println("Processing employee :" + fjtusr.getEmp_code() + " " + fjtusr.getCalander_code()
						+ "startdt== " + startdt + "enddt==" + enddt);

				Attendance attendance = new Attendance();
				if (fjtusr.getCalander_code().equalsIgnoreCase("SUN-THU")
						|| fjtusr.getCalander_code().equalsIgnoreCase("MON-FRI")) {
					attendance.setDStart(comp.getStaffDayStartValuesOfCurProcMonth(0, startdt, enddt));
					attendance.setDEnd(comp.getStaffDayEndValuesOfCurProcMonth(0, startdt, enddt));
				} else {
					System.out.println("labour employee, skip");
					/*
					 * attendance.setDStart(getComp().getLabourDayStartValuesOfCurProcMonth(0));
					 * attendance.setDEnd(getComp().getLabourDayEndValuesOfCurProcMonth(0));
					 */
					continue; // only calculate for staff
				}
				if (fjtusr.getOnduty().equalsIgnoreCase("Y")) {
					System.out.println("Manager, skip");
					continue;
				}
				attendance.setAcno(fjtusr.getAcsno());
				attendance.getAttendanceForCurProcMonth(startdt, enddt);
				// System.out.println("Got attendance"+attendance.getDStart());
				Leave leaveO = new Leave();
				leaveO.setEmp_code(fjtusr.getEmp_code());
				leaveO.setEmp_comp_code(fjtusr.getEmp_com_code());
				leaveO.setCur_procm_startdt(startdt);
				leaveO.getAllApprovedLeaveApplications();
				java.sql.Date curdate = startdt;
				MusterEntry entry = new MusterEntry();
				entry.setDivision(fjtusr.getEmp_divn_code());
				entry.setEmpcode(fjtusr.getEmp_code());
				entry.setEmpname(fjtusr.getUname());
				entry.setEmp_com_code(fjtusr.getEmp_com_code());
				float leaveno = 0;
				float latecome = 0;
				float absent = 0;
				float sswp = 0, pendlv = 0, pendreg = 0, present = 0;
				int totaldays = 0;
				do {
					// process all
					Calendar cal = new GregorianCalendar();
					cal.setTime(curdate);
					// System.out.println("Current :"+curdate);
					int thisdate = cal.get(Calendar.DAY_OF_MONTH);

					int j = cal.get(cal.DAY_OF_WEEK);
					String leavestatus = "";
					int isH = 0, status = 4;
					// System.out.println(thisdate+ " - "+j);
					// String chkin = attendance.getCheckinOnDay((thisdate));
					// String chkout = attendance.getCheckoutOnDay((thisdate));
					// System.out.println( chkin + ": "+chkout);
					isH = hhh.isAHoliday(curdate);
					int rgstatus = 0;
					int businesstrplv = 0;
					if (curdate != null && isH == 2) { // future dates and not a holiday
						leavestatus = leaveO.getLeaveStatusOfDay(curdate);
						if (!leavestatus.isEmpty())
							status = 0; // future leave
					} else if (isH == 1 && curdate != null) {
						status = 5; // holiday

					} else {
						status = attendance.getDayStatusByCalculation(thisdate, curdate);
						System.out.println("DAY STATUS : " + status + " FOR : " + curdate);
					}

					if (j >= Calendar.FRIDAY && (calcode.equalsIgnoreCase("SUN-THU")
							|| (calcode.equalsIgnoreCase("MON-FRI") && cal.get(Calendar.YEAR) < 2022))) { // weekend
						// System.out.println("SUN-THU Emp code: "+emcode+" cal code "+calcode);
						status = 4;
					} else if ((j == Calendar.SATURDAY || j == Calendar.SUNDAY)
							&& calcode.equalsIgnoreCase("MON-FRI")) { // weekend
						// System.out.println(" day "+j+" sat : "+Calendar.SATURDAY+" sun :
						// "+Calendar.SUNDAY);
						// System.out.println("MON-FRI Emp code: "+emcode+" cal code "+calcode+"
						// calendar code "+j+" date : "+cal.get(Calendar.YEAR));
						status = 4;
					} else if (status == 0 || status == 2 || status == -1 || status == -3) { // absent, single swipe or
																								// late, or early+late
						int leaveHstatus = leaveO.getLeaveStatusAsFullOrHalf(curdate);
						// System.out.println("LEAVE STATUS : "+status);
						if (leaveHstatus == 2) // halfday
							status = 12;
						else if (leaveHstatus == 0) {
							businesstrplv = leaveO.getBusinessTripLVApplStatus(curdate);
							if (businesstrplv != 0) {
								if (businesstrplv == 1) {
									status = 7;
								} else if (businesstrplv == 4) {
									status = 3;
								} else if (businesstrplv == 3) {
									status = 6;
								}

							} else {
								rgstatus = attendance.getRegularisationStatus(curdate, fjtusr.getEmp_code());
								// System.out.println("REGLTN STATUS : "+rgstatus);
								if (rgstatus == 1 && status == 0) // request sent , absent
									status = 7;
								else if (rgstatus == 1 && status == 2) // request sent, swsp
									status = 9;
								else if (rgstatus == 1 && status == -1)
									status = 10; // request sent, late or early
								else if (rgstatus == 1 && status == -3)
									status = 11; // request absent;
								else if (rgstatus == 4)
									status = 3; // regularised, treat it as present
								/*
								 * else if(rgstatus == 3) status=8;
								 */ // rejected request , retain oroninal status
								else if ((rgstatus == 0 || rgstatus == 3) && status == 0) { // if rgstatus=0, status is
									System.out.println("rgstatus== " + rgstatus + "-- " + status); // retained. no
																									// request sent
									status = 6;
								} else if ((rgstatus == 0 || rgstatus == 3) && status == -3) { // early and late
									status = 6;
									System.out.println("rgstatus== " + rgstatus + "-status " + status);
								}
							}
						} else {
							status = 0; // leave
						}
					}
					System.out.println("date " + curdate + " status: " + status + "emp code==" + fjtusr.getEmp_code());
					switch (status) {
					case 0:
						++leaveno;
						break;
					case 1:
						++present;
						break;
					case 2:
						sswp += 0.5;
						break;
					case 3:
						++present;
						break;
					case 4:
						// weekend
						break;
					case 5:
						// holiday
						break;
					case 6:
						++absent;
						break;
					case 7:
						++pendreg;
						++absent;
						break;
					case 8:
						++absent;
						break;
					case 9:
						pendreg += 0.5;
						sswp = sswp + 0.5f;
						break;
					case 10:
						pendreg += 0.5;
						latecome += 0.5f;
						break;
					case 11:
						++pendreg;
						++absent;
						break;
					case -1:
						latecome += 0.5;
						break;
					case 12:
						leaveno = (leaveno + 0.5f);
						break;
					}

					cal.add(Calendar.DATE, 1);
					++totaldays;
					curdate = new java.sql.Date(cal.getTimeInMillis());
				} while (curdate.compareTo(enddt) <= 0);

				pendlv = leaveO.getNoOfPendingLeaveDays(startdt, enddt); // acually leave days
				System.out.println("Employee code " + fjtusr.getEmp_code());
				System.out.println(" leave : " + leaveno + " Late/Early: " + latecome + " Fullday absent: " + absent
						+ " SingleSwipe :" + sswp + "Pending Lv : " + pendlv + " Pend Reg : " + pendreg + " Present: "
						+ present);
				entry.setFulldayAbsent(absent);
				entry.setLvdays(leaveno);
				entry.setLvpend(pendlv);
				// entry.setPresent(present);
				entry.setRegpend(pendreg);
				entry.setSingleswipe(sswp);
				entry.setEarlyOrlate(latecome);
				float totalabsent = absent + sswp + latecome;
				float totalpresent = totaldays - totalabsent - leaveno;
				entry.setPresent(totalpresent);
				entry.setAbsent(totalabsent);

				getLst().add(entry);
			}
			retval = lst.size();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("DB error with oracle.");
			retval = -2;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				mcon.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				System.out.println("DB error with oracle.");
				retval = -2;
			}
		}
		return retval;
	}

	/**
	 * @return the comp
	 */
	public String getCompcode() {
		return compcode;
	}

	/**
	 * @param comp the comp to set
	 */
	public void setCompcode(String comp) {
		this.compcode = comp;
	}

	/**
	 * @return the hhh
	 */
	public Holiday getHhh() {
		return hhh;
	}

	/**
	 * @param hhh the hhh to set
	 */
	public void setHhh(Holiday hhh) {
		this.hhh = hhh;
	}

	/**
	 * @return the startdt
	 */
	public void setStartdtStr(String valid_fromstr) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(valid_fromstr);
			this.startdt = new Date(dt.getTime());
		} catch (ParseException ex) {

			this.startdt = null;
		}
	}

	public java.sql.Date getStartdt() {
		return startdt;
	}

	/**
	 * @param startdt the startdt to set
	 */
	public void setStartdt(java.sql.Date startdt) {
		this.startdt = startdt;
	}

	/**
	 * @return the enddt
	 */
	public java.sql.Date getEnddt() {
		return enddt;
	}

	/**
	 * @param enddt the enddt to set
	 */
	public void setEnddt(java.sql.Date enddt) {
		this.enddt = enddt;
	}

	public void setEnddtStr(String valid_fromstr) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(valid_fromstr);
			this.enddt = new Date(dt.getTime());
		} catch (ParseException ex) {

			this.enddt = null;
		}
	}

	/**
	 * @return the sectionCode
	 */
	public String getSectionCode() {
		return sectionCode;
	}

	/**
	 * @param sectionCode the sectionCode to set
	 */
	public void setSectionCode(String sectionCode) {
		this.sectionCode = sectionCode;
	}

	/**
	 * @return the lst
	 */
	public ArrayList<MusterEntry> getLst() {
		return lst;
	}

	/**
	 * @param lst the lst to set
	 */
	public void setLst(ArrayList<MusterEntry> lst) {
		this.lst = lst;
	}

}
