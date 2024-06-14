package utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
 

import beans.HrRegularisationCorrection;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.SSLMail; 
import beans.fjtcouser;
import beans.HrBackendRegInOutTiming;


public class HrRegularisationCorrectionDbUtil {
	public String getEmailIdByEmpcode(String newempcode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1"; 
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, newempcode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = null;
			}
		}
		return retval;
	}

	public int isAlreadyRegularisationRequestSend(String empCode, String datetoregularise) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usrsql = "select status,date_to_regularise,reason from  regularisation_application where uid=? and date_to_regularise = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, empCode);
			psmt.setDate(2, setRegularise_dateStr(datetoregularise));
			rs = psmt.executeQuery();
			if (rs.next()) { 
				retval = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;

		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)  psmt.close();
				con.closeConnection();
			} catch (SQLException e) {

				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}

		return retval;
	}

	public HrRegularisationCorrection getEmployeeApproverDetails(String empCode) throws SQLException {
		HrRegularisationCorrection empDetails = null ;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT TXNFIELD_EMP_CODE, (SELECT EMP_NAME FROM PM_EMP_KEY WHERE EMP_CODE = TXNFIELD_EMP_CODE AND ROWNUM  = 1 ) \"EMP NAME\",  " + 
					"TXNFIELD_FLD3, (SELECT EMP_NAME FROM PM_EMP_KEY WHERE EMP_CODE =TXNFIELD_FLD3 AND ROWNUM  = 1 ) \"APPROVER NAME\",  " + 
					"(SELECT EMP_COMP_CODE FROM PM_EMP_KEY WHERE EMP_CODE = TXNFIELD_FLD3 AND ROWNUM  = 1  ) \"COMPANY CODE\", TXNFIELD_FLD2    " + 
					"FROM  PT_TXN_FLEX_FIELDS  " + 
					"WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empid = myRes.getString(1);
				String empName = myRes.getString(2);
				String approverId = myRes.getString(3);
				String aproverName = myRes.getString(4);
				String company = myRes.getString(5); 
				String accessCrd = myRes.getString(6); 
				empDetails = new HrRegularisationCorrection(empid,empName, approverId,aproverName, company, accessCrd );
			}
			return empDetails;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	private HrBackendRegInOutTiming getSwipeDetails(String employeeCode, Date dateToRegularise) throws SQLException, ParseException { 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null; 
		String swipeDetails = "Absent";
		HrBackendRegInOutTiming out = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn(); 
			// Execute sql stamt
			String sql = "SELECT checkin, checkout FROM newfjtco.attendance "
					+ " where accessCrdNo = (SELECT accesscrdNo FROM newfjtco.fjtcouser where user_id = ? limit 1) and workdate = ?  limit 1";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, employeeCode);
			myStmt.setDate(2, dateToRegularise);
			myRes = myStmt.executeQuery();
			if (myRes.next()) {
				String  checkin = myRes.getString(1).substring(11, 16); 
				String  checkout = myRes.getString(2).substring(11, 16); 
				swipeDetails = checkin+" - "+checkout;
				DateFormat formatter = new SimpleDateFormat("hh:mm");
				java.util.Date dtr1 = formatter.parse(checkin);
				java.util.Date dtr2 = formatter.parse(checkout);
				Time convertedTmSchIn = new Time(dtr1.getTime()); 
				Time convertedTmSchOut = new Time(dtr2.getTime()); 
				out = new HrBackendRegInOutTiming(convertedTmSchIn, convertedTmSchOut, swipeDetails);
			}else {
				out = new HrBackendRegInOutTiming(null, null, swipeDetails);
			}
           // System.out.println("check in : "+out.getCheckin()+" chout : "+out.getCheckout()+" swipe status : "+out.getStatus());
			return out;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
		
	}
	public int insertRegularisation(HrRegularisationCorrection detailsForRegularisation) { 
				String projectDetails = ""; 
				String mailSubject = "FJPortal-Regularisation Application ";
				String approverEmployeeCode = getEmailIdByEmpcode(detailsForRegularisation.getApproverCode());
				fjtcouser fusr = new fjtcouser();
				MysqlDBConnectionPool con = new MysqlDBConnectionPool();
				Connection mcon = con.getMysqlConn();
				if (mcon == null)
					return -2;
				int retval = 0;

				PreparedStatement psmt = null;
				//System.out.println(this.approver_eid + " " + this.approver_id + " " + this.emp_name + " " + this.emp_code + " " + reason + " " + this.regularise_date + " " + this.comp_code);
				String usrsql = "insert into  regularisation_application (uid,date_to_regularise,reason,applied_date,status,authorised_by,comp_code,project_code, backend_applied_by) values (?,?,?,?,?,?,?,?, ?)";
				try {
					mcon.setAutoCommit(false);
					psmt = mcon.prepareStatement(usrsql);
					long curtime = System.currentTimeMillis();
					java.sql.Timestamp appliedDate = new java.sql.Timestamp(curtime); 
					psmt.setString(1, detailsForRegularisation.getEmployeeCode());
					psmt.setDate(2, setRegularise_dateStr(detailsForRegularisation.getDateToRegularise()));
					psmt.setString(3, detailsForRegularisation.getReason());
					psmt.setTimestamp(4, appliedDate);
					psmt.setInt(5, 1);
					psmt.setString(6, detailsForRegularisation.getApproverCode());
					psmt.setString(7, detailsForRegularisation.getCompanyCode());
					psmt.setString(8, projectDetails);
					psmt.setString(9, detailsForRegularisation.getAppliedBy());
					psmt.executeUpdate();
					SSLMail sslmail = new SSLMail(); 
					String msg = getRegularisationRequestMessageBody(detailsForRegularisation,   approverEmployeeCode, appliedDate);
					sslmail.setToaddr(approverEmployeeCode);
					sslmail.setMessageSub(mailSubject+" - " + detailsForRegularisation.getEmployeeName());
					sslmail.setMessagebody(msg);
					int status = sslmail.sendMail(fusr.getUrlAddress());
					if (status != 1) {
						mcon.rollback();
						System.out.print("Error in sending regularisation request...");
						retval = -1;
					} else {
						System.out.print("sent regularisation request...");
						mcon.commit();
						retval = 1;
					}
				} catch (Exception e) {
					e.printStackTrace();
					retval = -2;

				} finally {
					try {
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
	private String getCheckInDetails(String accesscrdNumber, String dateToRegularize) throws SQLException { 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		String output = "Absent";
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn(); 
			// Execute sql stamt
			String sql = "SELECT checkin,checkout FROM newfjtco.attendance where accessCrdNo = ? and workdate = ? limit 1  ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, accesscrdNumber);
			myStmt.setDate(2, setRegularise_dateStr(dateToRegularize));
			myRes = myStmt.executeQuery();
			if (myRes.next()) {
				output = myRes.getString(1).substring(11, 16)+"-"+myRes.getString(2).substring(11, 16);
				  
			} 
       //  System.out.println(accesscrdNumber+"  "+dateToRegularize+" : "+output);
			return output;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
		
	}
	private String getRegularisationRequestMessageBody(HrRegularisationCorrection detailsForRegularisation, String approverEmployeeCode, Timestamp appliedDate) throws SQLException {
		fjtcouser fjuser = new fjtcouser();
		if (detailsForRegularisation.getEmployeeName() == null) {
			System.out.println("employee details not available.");
			return null;
		}
		 String chkinTime = getCheckInDetails(detailsForRegularisation.getAccessCrd(), detailsForRegularisation.getDateToRegularise());
		if(detailsForRegularisation.getDateToRegularise() == null || detailsForRegularisation.getReason() == null || detailsForRegularisation.getApproverCode() == null ||  chkinTime == null || approverEmployeeCode == null) {
			System.out.println("Not all details available. Regularisation Only");
			return null;
		}else {
			String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n" + "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
			StringBuilder mbody = new StringBuilder("");
			mbody.append(div);
			mbody.append("A regularisation application is submitted for your approval.<br/>");
			mbody.append("<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
			mbody.append("<tr><td><b>Employee Name </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" +detailsForRegularisation.getEmployeeName() + "</td></tr><tr><td><b>Employee code </b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + detailsForRegularisation.getEmployeeCode()+ "</td></tr>");
			mbody.append("<tr><td><b>Regularisation Date </b></td><td><b>&nbsp;:&nbsp; </b></td><td> " + detailsForRegularisation.getDateToRegularise() + "</td></tr>");
			mbody.append("<tr><td><b>Reason </b></td><td><b>&nbsp;:&nbsp; </b></td><td>" + detailsForRegularisation.getReason() + "</td></tr>"); 
			mbody.append("<tr><td><b>Swipe Details </b></td><td>&nbsp;:&nbsp;</td><td> <span style=\"color:red;\"> " +chkinTime + "</span></td><tr></table><br/>");
			
			mbody.append("<tr><td colsap=\"3\">  <span style=\"color:red;\"> Regularised from Backend By HR </span></td><tr></table><br/>");

			
			mbody.append("<br/></div><table><tr><td align=\"center\"  bgcolor=\"#34a853\" style=\"padding: 5px;border-radius:2px;color:#ffffff;display:block\" >");
			mbody.append("<a style=\"text-decoration:none;font-size:15px;font-family:Helvetica,Arial,sans-serif;text-decoration:none!important;width:100%;font-weight:bold;\" target=\"_blank\" data-saferedirecturl=\'"+fjuser.getUrlAddress()+"\' href=\'"+fjuser.getUrlAddress()+"LeaveProcess?ocjtfdinu=");
			mbody.append(appliedDate.getTime() + "&edocmpe=" + detailsForRegularisation.getEmployeeCode() + "&revorppa=" + detailsForRegularisation.getApproverCode()
					+ "&dpsroe=7&ntac=raluger' > <span style=\"color:#ffffff\"> Approve </span> </a> </td><td width=\"20\"></td>");
			mbody.append("<td align=\"center\"  bgcolor=\"#ce3325\" style=\"padding: 5px;border-radius:2px;color:#ffffff;display:block\" >");
			mbody.append("<a style=\"text-decoration:none;font-size:15px;font-family:Helvetica,Arial,sans-serif;text-decoration:none!important;width:100%;font-weight:bold;\" target=\"_blank\" ata-saferedirecturl=\'"+fjuser.getUrlAddress()+"\' href=\'" + fjuser.getUrlAddress() + "LeaveProcess?ocjtfdinu=");
			mbody.append(appliedDate.getTime() + "&edocmpe=" + detailsForRegularisation.getEmployeeCode() + "&revorppa=" + detailsForRegularisation.getApproverCode()
					+ "&dpsroe=5&ntac=raluger'> <span style=\"color:#ffffff\"> Reject</span> </a> </td></tr></table>");
			return mbody.toString();
			 
		}
	    
	}
	public Date setRegularise_dateStr(String str) {
		//System.out.println(str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			return  new Date(dt.getTime());
		} catch (ParseException ex) {

			System.out.println("date error");
			return  null;
		}
	}
	
	public boolean getDayStatusByCalculation(String employeeCode, String dateToRegularise,Time st, Time en) throws SQLException, ParseException { 
		HrBackendRegInOutTiming tp = getSwipeDetails(employeeCode, setRegularise_dateStr(dateToRegularise));
		//System.out.println("tp.getCheckin() :  "+tp.getCheckin()+" tp.getCheckout():  "+tp.getCheckout());
	   // System.out.println("st :  "+st+" en : "+en);
		if (tp.getCheckin() == null || tp.getCheckout() == null) {
			return true; // absent
		} else if (tp.getCheckin() == tp.getCheckout()) {
			return true; // single swipe
		} else { 
			if (st == null || en == null)
				return false; // enexpected no time range set
			else if (tp.getCheckin().getTime() <= (st.getTime() + 1800000)
					&& tp.getCheckout().getTime() >= (en.getTime() - 600000))
				return false;//present
			else if (tp.getCheckin().getTime() <= (st.getTime() + 1800000)
					&&  tp.getCheckout().getTime() < (en.getTime() - 600000))
				return true; // early go
			else if (tp.getCheckin().getTime() > (st.getTime() + 1800000)
					&& tp.getCheckout().getTime() >= (en.getTime() - 600000))
				return true; // late come
			else if (tp.getCheckin().getTime() > (st.getTime() + 1800000) && tp.getCheckout().getTime() < (en.getTime() - 600000))
				return true; // early go+late;
			else
				return false;// not a proper regularisation finding
		}

	}
 

	public Time getStaffDayStartValuesOfTheMonth(String dateToRegularise, String companyCode) {
		Date regDate = setRegularise_dateStr(dateToRegularise);
		Time startTime = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn(); 
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params  " + 
				"where   ( ?     between  valid_from and  valid_to) and  " + 
				"param_name='STAFF_DAY_START' and status=1 and company_code= ? order by valid_from desc limit 1";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, regDate); 
			psmt.setString(2,  companyCode);
			rs = psmt.executeQuery();
			String str;
			if (rs.next()) { 
				str = rs.getString(3);

				if ( str == null) {
					System.out.println("Error in reading parameter");
					return null;
				}
				DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
				java.util.Date dtr = formatter.parse(str);
				Time convertedTm = new Time(dtr.getTime()); 
				startTime = convertedTm;
			}

		} catch (Exception e) {
			e.printStackTrace();
			startTime = null;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				startTime = null;
				System.out.println("Exception in closing DB resources");
			}
		}

		return startTime;
	}
	public Time getStaffDayEndValuesOfTheMonth(String dateToRegularise, String companyCode) {
		Date regDate = setRegularise_dateStr(dateToRegularise);
		Time endTime = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn(); 
		if (mcon == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "SELECT valid_from,valid_to,param_value FROM  system_params  " + 
				"where   ( ?    between  valid_from and  valid_to) and  " + 
				"param_name='STAFF_DAY_END' and status=1 and company_code=? order by valid_from desc limit 1";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, regDate); 
			psmt.setString(2,  companyCode);
			rs = psmt.executeQuery();
			String str;
			if (rs.next()) { 
				str = rs.getString(3);

				if ( str == null) {
					System.out.println("Error in reading parameter");
					return null;
				}
				DateFormat formatter = new SimpleDateFormat("hh:mm:ss");
				java.util.Date dtr = formatter.parse(str);
				Time convertedTm = new Time(dtr.getTime()); 
				endTime = convertedTm;
			}

		} catch (Exception e) {
			e.printStackTrace();
			endTime = null;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				endTime = null;
				System.out.println("Exception in closing DB resources");
			}
		}

		return endTime;
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

	public String validateIdandGetEmpName(String empCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')"; 
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, empCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = null;
			}
		}
		return retval;
	}
	public boolean validateEmployee(String empCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		
		if (con == null)
			return false;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		boolean retval = false;
		String sqlstr = "SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')"; 
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, empCode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			   retval = false;
			}
		}
		return retval;
	}

	public boolean checkDateToRegulariseHaveAlreadyLeave(String empCode, String datetoregularise, String companyCode) {
		Date regDate = setRegularise_dateStr(datetoregularise);
		boolean retVal = false;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn(); 
		if (mcon == null)
			return true;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "select * from  leave_application " + 
				"where uid = ? and cancel_date IS NULL and comp_code = ?  " + 
				"and  status = 4 and ( ? between fromdate and todate)";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1,  empCode);
			psmt.setString(2,  companyCode);
			psmt.setDate(3, regDate); 
			rs = psmt.executeQuery(); 
			if (rs.next()) {  
				retVal = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			retVal = true;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				retVal = true;
				System.out.println("Exception in closing DB resources");
			}
		}
		//System.out.println("Leave check "+retVal);
		return retVal;
	} 

	public boolean checkDateToRegulariseHaveHoliday(String companyCode, String datetoregularise) {
		Date regDate = setRegularise_dateStr(datetoregularise);
		boolean retVal = false;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn(); 
		if (mcon == null)
			return true;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "SELECT * FROM  holidays where company_code = ? and hday= ? limit 1";
		try {
			psmt = mcon.prepareStatement(usrsql); 
			psmt.setString(1,  companyCode);
			psmt.setDate(2, regDate); 
			rs = psmt.executeQuery(); 
			if (rs.next()) {  
				retVal = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			retVal = true;

		} finally {
			try {
				rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				retVal = true;
				System.out.println("Exception in closing DB resources");
			}
		}
		//System.out.println("holiday check "+retVal);
		return retVal;
	}

}
