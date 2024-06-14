package beans;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BusinessTripLVApplication {
	private String country;
	private String projectDetails;
	private Date fromdate;
	private Date todate;
	private String purpose;
	private String otherDetails;
	private String emp_name;
	private String emp_code;
	private String comp_code;
	private String status;
	private String approver_eid;
	private String authorised_by;
	private Timestamp authorised_date;
	private Timestamp applied_date;
	private float totaldays;
	private Timestamp cancel_date;
	private ArrayList pendleaveapplications = null;
	private Date cur_procm_startdt = null;
	private int req_id;
	private String travelUName = null;
	private String travelUDesignation = null;
	private String travelUDivision = null;
	private String traveler_emp_code = null;;
	private String traveler_emailid = null;;
	private String travelerUid = null;
	private Date checkInDate;
	private Date checkOutDate;
	private String estimatedTravelBudget;
	private String paymentCharges;
	private String traveleIns;
	private String traveleReqSelfClient;
	private String hotelBookReq;
	private String handBagReq;
	private String luggageAllwReq;
	private String retrunAirport;
	private String preturnTime;
	private String pfromTime;
	private String fromAirport;
	private Date requstDate;
	private String t_approver_eid;
	private String t_comp_code;

	public BusinessTripLVApplication() {
	}

	public BusinessTripLVApplication(Date fromDate, Date toDate, String country, String projectDetails, String purpose,
			String otherdetails) {
		super();
		this.fromdate = fromDate;
		this.todate = toDate;
		// this.applied_date = appliedDate;
		this.projectDetails = projectDetails;
		this.country = country;
		this.purpose = purpose;
		this.otherDetails = otherdetails;
	}

	public BusinessTripLVApplication(Date fromDate, Date toDate, String country, String projectDetails, String purpose,
			String t_name, String t_division, String t_designation, String t_fromAirport, String pfromTime,
			String t_returnAirport, String preturnTime, String luggageAllwReq, String handBagReq, String hotelBookReq,
			String traveleIns, Date checkInDate, Date checkOutDate, String traveleReqSelfClient,
			String estimatedTravelBudget, String paymentCharges, String tuid, Date appliedDate) {
		super();
		this.fromdate = fromDate;
		this.todate = toDate;
		this.projectDetails = projectDetails;
		this.country = country;
		this.purpose = purpose;
		this.travelUName = t_name;
		this.travelUDivision = t_division;
		this.travelUDesignation = t_designation;
		this.fromAirport = t_fromAirport;
		this.pfromTime = pfromTime;
		this.retrunAirport = t_returnAirport;
		this.preturnTime = preturnTime;
		this.luggageAllwReq = luggageAllwReq;
		this.handBagReq = handBagReq;
		this.hotelBookReq = hotelBookReq;
		this.traveleIns = traveleIns;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.traveleReqSelfClient = traveleReqSelfClient;
		this.estimatedTravelBudget = estimatedTravelBudget;
		this.paymentCharges = paymentCharges;
		this.travelerUid = tuid;
		this.requstDate = appliedDate;
	}

	public String getT_comp_code() {
		return t_comp_code;
	}

	public void setT_comp_code(String t_comp_code) {
		this.t_comp_code = t_comp_code;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getProjectDetails() {
		return projectDetails;
	}

	public void setProjectDetails(String projectDetails) {
		this.projectDetails = projectDetails;
	}

	public Date getFromdate() {
		return fromdate;
	}

	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public Date getTodate() {
		return todate;
	}

	public void setTodate(Date todate) {
		this.todate = todate;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getOtherDetails() {
		return otherDetails;
	}

	public void setOtherDetails(String otherDetails) {
		this.otherDetails = otherDetails;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public String getComp_code() {
		return comp_code;
	}

	public void setComp_code(String comp_code) {
		this.comp_code = comp_code;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getApplied_date() {
		return applied_date;
	}

	public void setApplied_date(Timestamp applied_date) {
		this.applied_date = applied_date;
	}

	public float getTotaldays() {
		return totaldays;
	}

	public void setTotaldays(float totaldays) {
		this.totaldays = totaldays;
	}

	public String getAuthorised_by() {
		return authorised_by;
	}

	public void setAuthorised_by(String authorised_by) {
		this.authorised_by = authorised_by;
	}

	public Timestamp getAuthorised_date() {
		return authorised_date;
	}

	public void setAuthorised_date(Timestamp authorised_date) {
		this.authorised_date = authorised_date;
	}

	public Timestamp getCancel_date() {
		return cancel_date;
	}

	public void setCancel_date(Timestamp cancel_date) {
		this.cancel_date = cancel_date;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getApprover_eid() {
		return approver_eid;
	}

	public void setApprover_eid(String approver_eid) {
		this.approver_eid = approver_eid;
	}

	public ArrayList getPendleaveapplications() {
		return pendleaveapplications;
	}

	public void setPendleaveapplications(ArrayList pendleaveapplications) {
		this.pendleaveapplications = pendleaveapplications;
	}

	public Date getCur_procm_startdt() {
		return cur_procm_startdt;
	}

	public void setCur_procm_startdt(Date cur_procm_startdt) {
		this.cur_procm_startdt = cur_procm_startdt;
	}

	public int getReq_id() {
		return req_id;
	}

	public void setReq_id(int req_id) {
		this.req_id = req_id;
	}

	public String getTraveler_emp_code() {
		return traveler_emp_code;
	}

	public String getTraveler_emailid() {
		return traveler_emailid;
	}

	public void setTraveler_emailid(String traveler_emailid) {
		this.traveler_emailid = traveler_emailid;
	}

	public String getTravelUName() {
		return travelUName;
	}

	public void setTravelUName(String travelUName) {
		this.travelUName = travelUName;
	}

	public String getTravelUDesignation() {
		return travelUDesignation;
	}

	public void setTravelUDesignation(String travelUDesignation) {
		this.travelUDesignation = travelUDesignation;
	}

	public String getTravelUDivision() {
		return travelUDivision;
	}

	public void setTravelUDivision(String travelUDivision) {
		this.travelUDivision = travelUDivision;
	}

	public String getTravelerUid() {
		return travelerUid;
	}

	public void setTravelerUid(String travelerUid) {
		this.travelerUid = travelerUid;
	}

	public void setTraveler_emp_code(String travel_emp_code) {
		System.out.println("setter " + traveler_emp_code);
		this.traveler_emp_code = travel_emp_code;
	}

	public Date getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(Date checkInDate) {
		this.checkInDate = checkInDate;
	}

	public Date getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public String getEstimatedTravelBudget() {
		return estimatedTravelBudget;
	}

	public void setEstimatedTravelBudget(String estimatedTravelBudget) {
		this.estimatedTravelBudget = estimatedTravelBudget;
	}

	public String getPaymentCharges() {
		return paymentCharges;
	}

	public void setPaymentCharges(String paymentCharges) {
		this.paymentCharges = paymentCharges;
	}

	public String getTraveleIns() {
		return traveleIns;
	}

	public void setTraveleIns(String traveleIns) {
		this.traveleIns = traveleIns;
	}

	public String getTraveleReqSelfClient() {
		return traveleReqSelfClient;
	}

	public void setTraveleReqSelfClient(String traveleReqSelfClient) {
		this.traveleReqSelfClient = traveleReqSelfClient;
	}

	public String getHotelBookReq() {
		return hotelBookReq;
	}

	public void setHotelBookReq(String hotelBookReq) {
		this.hotelBookReq = hotelBookReq;
	}

	public String getHandBagReq() {
		return handBagReq;
	}

	public void setHandBagReq(String handBagReq) {
		this.handBagReq = handBagReq;
	}

	public String getLuggageAllwReq() {
		return luggageAllwReq;
	}

	public void setLuggageAllwReq(String luggageAllwReq) {
		this.luggageAllwReq = luggageAllwReq;
	}

	public String getRetrunAirport() {
		return retrunAirport;
	}

	public void setRetrunAirport(String retrunAirport) {
		this.retrunAirport = retrunAirport;
	}

	public String getPreturnTime() {
		return preturnTime;
	}

	public void setPreturnTime(String preturnTime) {
		this.preturnTime = preturnTime;
	}

	public String getPfromTime() {
		return pfromTime;
	}

	public void setPfromTime(String pfromTime) {
		this.pfromTime = pfromTime;
	}

	public String getFromAirport() {
		return fromAirport;
	}

	public void setFromAirport(String fromAirport) {
		this.fromAirport = fromAirport;
	}

	public Date getRequstDate() {
		return requstDate;
	}

	public void setRequstDate(Date requstDate) {
		this.requstDate = requstDate;
	}

	public String getT_approver_eid() {
		return t_approver_eid;
	}

	public void setT_approver_eid(String t_approver_eid) {
		this.t_approver_eid = t_approver_eid;
	}

	public void setReqdateStr(String str) {
		System.out.println("setter pf req date " + str);

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		/*
		 * DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); java.util.Date dt;
		 * try { dt = formatter.parse(str); this.requstDate = new Date(dt.getTime()); }
		 * catch (ParseException ex) {
		 * Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null,
		 * ex); this.requstDate = null; }
		 */

	}

	public void setStrcheckInDate(String str) {
		System.out.println("setStrcheckInDate " + str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.checkInDate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.checkInDate = null;
		}

	}

	public void setStrcheckOutDate(String str) {
		System.out.println("setStrcheckOutDate " + str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.checkOutDate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.checkOutDate = null;
		}

	}

	public void setFromdateStr(String str) {
		System.out.println("setter pf setFromdateStr date " + str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.fromdate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.fromdate = null;
		}

	}

	public void setTodateStr(String str) {
		System.out.println("todate date " + str);
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			this.todate = new Date(dt.getTime());
		} catch (ParseException ex) {
			Logger.getLogger(LeaveApplication.class.getName()).log(Level.SEVERE, null, ex);
			this.todate = null;
		}
	}

	public String getFormatedDateStr(Date dt) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String text = formatter.format(dt);
		return text;
	}

	public void setApplied_dateFromStr(String applieddtStr) {
		long millis = Long.parseLong(applieddtStr);
		this.applied_date = new Timestamp(millis);
		// System.out.println(applied_date);
		// this.applied_date = applied_date;
	}

	public long getApplied_dateinMillis() {
		return applied_date.getTime();
	}

	public int getsendBusinessTripApplicationForApproval() {
		System.out.println("getsendBusinessTripApplicationForApproval");
		fjtcouser fusr = new fjtcouser();
		String mailSubject = "FJPortal-Business Trip Application ";
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;

		PreparedStatement psmt = null;
		String usrsql = "insert into  businesstrip_leave_application (uid,fromdate,todate,country,customer_name,purpose,otherdetails,status,applied_date,comp_code,authorised_by,t_name,t_division,t_designation,t_fromAirport,"
				+ "pfromTime,t_returnAirport,preturnTime,luggageAllwReq,handBagReq,hotelBookReq,traveleIns,checkInDate,checkOutDate,traveleReqSelfClient,estimatedTravelBudget,paymentCharges,applied_by) "
				+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			mcon.setAutoCommit(false);
			psmt = mcon.prepareStatement(usrsql, Statement.RETURN_GENERATED_KEYS);
			// psmt = mcon.prepareStatement(usrsql);
			long yourmilliseconds = System.currentTimeMillis();
			SimpleDateFormat sdf = new SimpleDateFormat("MMM dd,yyyy HH:mm");
			Date resultdate = new Date(yourmilliseconds);
			System.out.println("resultdate ==  " + resultdate);
			long curtime = System.currentTimeMillis();
			java.sql.Timestamp tp = new java.sql.Timestamp(curtime);
			this.applied_date = tp;
			this.requstDate = resultdate;
			psmt.setString(1, this.getTravelerUid());
			psmt.setDate(2, this.getFromdate());
			psmt.setDate(3, this.getTodate());
			psmt.setString(4, this.getCountry());
			psmt.setString(5, this.getProjectDetails());
			psmt.setString(6, this.getPurpose());
			psmt.setString(7, this.getOtherDetails());
			psmt.setInt(8, 1);
			psmt.setTimestamp(9, tp);
			psmt.setString(10, this.getT_comp_code());
			psmt.setString(11, this.getT_approver_eid());
			psmt.setString(12, this.getTravelUName());
			psmt.setString(13, this.getTravelUDivision());
			psmt.setString(14, this.getTravelUDesignation());
			psmt.setString(15, this.getFromAirport());
			psmt.setString(16, this.getPfromTime());
			psmt.setString(17, this.getRetrunAirport());
			psmt.setString(18, this.getPreturnTime());
			psmt.setString(19, this.getLuggageAllwReq());
			psmt.setString(20, this.getHandBagReq());
			psmt.setString(21, this.getHotelBookReq());
			psmt.setString(22, this.getTraveleIns());
			psmt.setDate(23, this.getCheckInDate());
			psmt.setDate(24, this.getCheckOutDate());
			psmt.setString(25, this.getTraveleReqSelfClient());
			psmt.setString(26, this.getEstimatedTravelBudget());
			psmt.setString(27, this.getPaymentCharges());
			psmt.setString(28, this.emp_code);
			int affectedRows = psmt.executeUpdate();
			if (affectedRows == 0) {
				throw new SQLException("Creating user failed, no rows affected.");
			}
			try (ResultSet generatedKeys = psmt.getGeneratedKeys()) {
				if (generatedKeys.next()) {
					this.setReq_id(generatedKeys.getInt(1));
					System.out.println("generated ID ==  " + generatedKeys.getInt(1));
				} else {
					throw new SQLException("Creating user failed, no ID obtained.");
				}
			}
			SSLMail sslmail = new SSLMail();
			String msg = getRegularisationRequestMessageBody();
			sslmail.setToaddr(new fjtcouser().getEmailIdByEmpcode(getT_approver_eid()));
			sslmail.setMessageSub(mailSubject + " - " + getTravelUName());
			sslmail.setMessagebody(msg);

//			SSLMail sslhrmail = new SSLMail();
//			String hrmsgbody = getHRRequestMessageBody(this);
//			sslhrmail.setToaddr(getHREmailidForBusinessTripApplication());
//			sslhrmail.setMessageSub(
//					"FJPortal-Business Trip Application(Hotel and Air Ticket)" + " - " + getTravelUName());
//			sslhrmail.setMessagebody(hrmsgbody);
			int status = sslmail.sendMail(fusr.getUrlAddress());
//			int hrEmailstatus = sslhrmail.sendMail(fusr.getUrlAddress());
			if (status != 1) {
				mcon.rollback();
				System.out.print("Error in sending business trip leave request...");
				retval = -1;
			} else {
				System.out.print("sent business trip leav request...");
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

	private String getRegularisationRequestMessageBody() {
		fjtcouser fjuser = new fjtcouser();
		if (this.emp_name == null) {
			System.out.println("employee details not available.");
			return null;
		}

		if ((this.fromdate == null || this.todate == null || this.authorised_by == null)) {
			System.out.println("Not all details available.");
			return null;
		} else {
			String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n"
					+ "margin: 0 2px; font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
			StringBuilder mbody = new StringBuilder("");
			mbody.append(div);
			mbody.append("A Business Trip Application is submitted for your approval.<br/><br/>");
			mbody.append(
					"<table     role=\"presentation\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  bgcolor=\"ffffff\" cellpadding=\"0\" cellspacing=\"0\">");
			mbody.append("<tr><td><b>Employee Name </b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + this.getTravelUName()
					+ "</td></tr><tr><td><b>Employee code </b></td><td><b>&nbsp;:&nbsp; </b></td><td> "
					+ this.getTravelerUid() + "</td></tr>");
			mbody.append("<tr><td><b>Start date</b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
					+ getFormatedDateStr(this.fromdate) + "</td></tr>");
			mbody.append("<tr><td><b>End date</b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
					+ getFormatedDateStr(this.todate) + "</td></tr>");
			mbody.append("<tr><td><b>Country Visited</b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + this.country
					+ "</td></tr>");
			mbody.append("<tr><td><b>Project Details</b></td><td><b>&nbsp;:&nbsp;</b></td><td>"
					+ this.getProjectDetails() + "</td></tr>");
			mbody.append(
					"<tr><td><b>Purpose</b></td><td><b>&nbsp;:&nbsp;</b></td><td>" + this.getPurpose() + "</td></tr>");
			mbody.append("</table><br/>");

			mbody.append(
					"<br/></div><table><tr><td align=\"center\"  bgcolor=\"#34a853\" style=\"padding: 5px;border-radius:2px;color:#ffffff;display:block\" >");
			mbody.append(
					"<a style=\"text-decoration:none;font-size:15px;font-family:Helvetica,Arial,sans-serif;text-decoration:none!important;width:100%;font-weight:bold;\" target=\"_blank\" data-saferedirecturl=\'"
							+ fjuser.getUrlAddress() + "\' href=\'" + fjuser.getUrlAddress()
							+ "LeaveProcess?ocjtfdinu=");
			// mbody.append("<a style='text-decoration: none;'
			// href=\'http://127.0.0.1:8090/fjtco/LeaveProcess?ocjtfdinu=");
			mbody.append(this.applied_date.getTime() + "&edocmpe=" + this.getTravelerUid() + "&reqid=" + this.req_id
					+ "&revorppa=" + this.authorised_by
					+ "&dpsroe=7&ntac=rpiubnst' > <span style=\"color:#ffffff\"> Approve </span> </a> </td><td width=\"20\"></td>");
			mbody.append(
					"<td align=\"center\"  bgcolor=\"#ce3325\" style=\"padding: 5px;border-radius:2px;color:#ffffff;display:block\" >");
			mbody.append(
					"<a style=\"text-decoration:none;font-size:15px;font-family:Helvetica,Arial,sans-serif;text-decoration:none!important;width:100%;font-weight:bold;\" target=\"_blank\" ata-saferedirecturl=\'"
							+ fjuser.getUrlAddress() + "\' href=\'" + fjuser.getUrlAddress()
							+ "LeaveProcess?ocjtfdinu=");
			// mbody.append("<a style='text-decoration: none;'
			// href=\'http://127.0.0.1:8090/fjtco/LeaveProcess?ocjtfdinu=");
			mbody.append(this.applied_date.getTime() + "&edocmpe=" + this.getTravelerUid() + "&reqid=" + this.req_id
					+ "&revorppa=" + this.authorised_by
					+ "&dpsroe=5&ntac=rpiubnst'> <span style=\"color:#ffffff\"> Reject</span> </a> </td></tr></table>");

			mbody.append("<br/>");
			mbody.append("<br/>");
			mbody.append(this.getHRRequestMessageBody(this));
			return mbody.toString();

		}

	}

	public int processBusinesstripApplicationApproval(long tp, int status) {
		java.sql.Timestamp tmp = new java.sql.Timestamp(tp);
		this.applied_date = tmp;
		int appstatus = isLeaveApplicationProcessedAlready();
		if (appstatus == 4 || appstatus == 3) {
			return -1; // already processed
		}
		if (appstatus == -2 || appstatus == 0) {
			return appstatus;
		}
		int retval = -2;
		if (appstatus == 1) {
			fjtcouser fusr = new fjtcouser();
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			Connection mcon = con.getMysqlConn();
			if (mcon == null)
				return -2;
			PreparedStatement psmt = null;
			// System.out.println(tp);
			String usrsql = "update  businesstrip_leave_application  set status = ?, authorised_by = ?, authorised_date = ? where uid=? and req_id = ?";
			try {
				java.util.Date utilDate = new java.util.Date();
				java.sql.Date today = new java.sql.Date(utilDate.getTime());
				psmt = mcon.prepareStatement(usrsql);
				psmt.setInt(1, status);
				psmt.setString(2, this.approver_eid);
				psmt.setDate(3, today);
				psmt.setString(4, this.emp_code);
				psmt.setInt(5, this.req_id);
				int nor = psmt.executeUpdate();
				if (nor == 1) {
					// System.out.println("Updated backend");
					if (status == 4) { // approval
						retval = 1;
						String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
						String msg = this.getResponseMessageBody("Your Business Trip Application is approved.");
						SSLMail sslmail = new SSLMail();
						sslmail.setToaddr(toaddr);
						sslmail.setMessageSub("Business Trip Application Approved");
						sslmail.setMessagebody(msg);
						sslmail.sendMail(fusr.getUrlAddress());
						this.sendEmailToHRAfterApproval();
						System.out.println("mail sent in processBusinesstripApplicationApproval");

					} else if (status == 3) {
						retval = 1;
						String toaddr = fusr.getEmailIdByEmpcode(this.emp_code);
						System.out.print(toaddr);
						String msg = this.getResponseMessageBody("Your Business trip application is rejected.");
						SSLMail sslmail = new SSLMail();
						sslmail.setToaddr(toaddr);
						sslmail.setMessageSub("Business Trip Application Rejected");
						sslmail.setMessagebody(msg);
						sslmail.sendMail(fusr.getUrlAddress());
						System.out.print("sent...");
					} // properly done
				} else {
					System.out.println("No records updated!");
					retval = 0;
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

		}
		return retval;
	}
	/*
	 * private int isApplicationProcessedAlready() { MysqlDBConnectionPool con = new
	 * MysqlDBConnectionPool(); Connection mcon = con.getMysqlConn(); if (mcon ==
	 * null) return -2; int retval = 0; PreparedStatement psmt = null; ResultSet rs
	 * = null; String usrsql =
	 * "select status,fromdate,todate,customer_name,purpose from  businesstrip_leave_application where uid=? and applied_date = ?"
	 * ; try { psmt = mcon.prepareStatement(usrsql); psmt.setString(1,
	 * this.emp_code); psmt.setTimestamp(2, this.applied_date); rs =
	 * psmt.executeQuery(); if (rs.next()) { int status = rs.getInt(1); //
	 * System.out.println(status); if (status == 1) { this.fromdate = rs.getDate(2);
	 * this.todate = rs.getDate(3); this.projectDetails = rs.getString(4);
	 * this.purpose= rs.getString(5); } retval = status; } } catch (Exception e) {
	 * e.printStackTrace(); retval = -2;
	 * 
	 * } finally { try { if (rs != null) rs.close(); if (psmt != null) ;
	 * psmt.close(); con.closeConnection(); } catch (SQLException e) {
	 * 
	 * System.out.println("Exception in closing DB resources"); retval = -2; } }
	 * 
	 * return retval; }
	 */

	/**
	 * @read all valid pending leave applications
	 */
	public int getpendbusinesstripleaveapplications() {
		if (pendleaveapplications == null)
			pendleaveapplications = new ArrayList<LeaveApplication>();
		else
			pendleaveapplications.clear();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();

		if (mcon == null)
			return -2;
		int retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;

		String usrsql = "SELECT fromdate,todate,purpose,customer_name,applied_date,country,otherdetails FROM  businesstrip_leave_application where (status=1) and uid = ? and canceldate is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			// psmt.setDate(1, cur_procm_startdt);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();

			while (rs.next()) {
				BusinessTripLVApplication btlva = new BusinessTripLVApplication();
				btlva.setFromdate(rs.getDate(1));
				btlva.setTodate(rs.getDate(2));
				btlva.setPurpose(rs.getString(3));
				btlva.setProjectDetails(rs.getString(4));
				btlva.setApplied_date(rs.getTimestamp(5));
				btlva.setCountry(rs.getString(6));
				btlva.setOtherDetails(rs.getString(7));
				this.pendleaveapplications.add(btlva);
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

	private String getResponseMessageBody(String response) {
		if (this.emp_code == null)
			return null;
		StringBuilder mbody = new StringBuilder("");
		mbody.append(response);
		mbody.append("<br/><br/>Employee Code &nbsp;&nbsp;: " + this.emp_code + "<br/>");
		mbody.append("Application Type : Business Trip.<br/>");
		mbody.append("From Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: "
				+ getFormatedDateStr(this.fromdate) + "<br/>");
		mbody.append("To Date &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: "
				+ getFormatedDateStr(this.todate) + "<br/>");
		mbody.append("Country Visited &nbsp;: " + this.country + "<br/>");
		mbody.append("Project Details &nbsp;&nbsp;&nbsp;: " + this.projectDetails + "<br/>");
		mbody.append("Purpose &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: "
				+ this.purpose + "<br/>");
		return mbody.toString();
	}

	public int getCancelBusinessLeaveApplication() {
		int appstatus = isLeaveApplicationProcessedAlready();
		if (appstatus == 4 || appstatus == 3) {
			// System.out.println("approved or rejected");
			// approved or rejected
			return -1;
		}
		if (appstatus == -2 || appstatus == 0) {
			// System.out.println("cancelled application or not found");
			return appstatus; // cancelled application or not found.
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;

		//
		String usrsql = "update  businesstrip_leave_application set canceldate=NOW() where uid=? and applied_date = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setTimestamp(2, this.applied_date);
			retval = psmt.executeUpdate();
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

	public int isLeaveApplicationProcessedAlready() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		System.out.println("isLeaveApplicationProcessedAlready  " + this.emp_code + "," + this.applied_date);
		ResultSet rs = null;// uid,fromdate,todate,leavetype,leavedays,reason,resumedate,address,status,applied_date
		String usrsql = "select status,fromdate,todate,customer_name,purpose,comp_code,otherdetails,country from  businesstrip_leave_application where uid=? and applied_date = ? and canceldate is NULL";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setTimestamp(2, this.applied_date);
			rs = psmt.executeQuery();
			if (rs.next()) {
				int status = rs.getInt(1);
				if (status == 1 || status == 2) {
					this.fromdate = rs.getDate(2);
					this.todate = rs.getDate(3);
					this.projectDetails = rs.getString(4);
					this.purpose = rs.getString(5);
					this.comp_code = rs.getString(6);
					this.otherDetails = rs.getString(7);
					this.country = rs.getString(8);
				}
				retval = status;
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

	public int getAllPendingLeaveApplications() {
		if (pendleaveapplications == null)
			pendleaveapplications = new ArrayList<LeaveApplication>();
		else
			pendleaveapplications.clear();
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		ResultSet rs = null;
		PreparedStatement psmt = null;

		String usrsql = "SELECT fromdate,todate,purpose,customer_name,applied_date,country,otherdetails FROM  businesstrip_leave_application where fromdate > ? and uid = ? and canceldate is NULL";
		System.out.println("cur_procm_startdt == " + cur_procm_startdt);
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setDate(1, cur_procm_startdt);
			psmt.setString(2, this.emp_code);
			rs = psmt.executeQuery();

			while (rs.next()) {
				BusinessTripLVApplication btlva = new BusinessTripLVApplication();
				btlva.setFromdate(rs.getDate(1));
				btlva.setTodate(rs.getDate(2));
				btlva.setPurpose(rs.getString(3));
				btlva.setProjectDetails(rs.getString(4));
				btlva.setApplied_date(rs.getTimestamp(5));
				btlva.setCountry(rs.getString(6));
				btlva.setOtherDetails(rs.getString(7));
				this.pendleaveapplications.add(btlva);
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

	public List<BusinessTripLVApplication> getBusinessTripLVApplication(String loginusr, String empid, String fromdate,
			String todate) {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		List<BusinessTripLVApplication> visitList = new ArrayList<BusinessTripLVApplication>();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		Date frmdate = Date.valueOf(fromdate);
		Date todat = Date.valueOf(todate);

		String usrsql = "SELECT fromdate, todate, country,customer_name, purpose, otherdetails  from  businesstrip_leave_application where status=1 and canceldate is NULL and authorised_by=? AND uid=? AND fromdate=? AND todate=? order by applied_date asc";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, loginusr);
			psmt.setString(2, empid);
			psmt.setDate(3, frmdate);
			psmt.setDate(4, todat);
			rs = psmt.executeQuery();

			while (rs.next()) {
				Date fromDate = rs.getDate(1);
				Date toDate = rs.getDate(2);
				String country = rs.getString(3);
				String projectDetails = rs.getString(4);
				String purpose = rs.getString(5);
				String otherdetails = rs.getString(6);
				BusinessTripLVApplication tempVisitList = new BusinessTripLVApplication(fromDate, toDate, country,
						projectDetails, purpose, otherdetails);
				visitList.add(tempVisitList);

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
			}
		}

		return visitList;
	}

	public int getCheckUid() {

		int logType = -1;
		logType = isNotFrozenAccount();
		if (logType != 1)
			return logType;
		// this.traveler_emp_code = traveleruid;
		logType = getMoreUserDetails();
		if (logType != 1)
			return logType;

		return logType;
	}

	public int isNotFrozenAccount() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = -1;
		this.travelerUid = traveler_emp_code;
		String sqlstr = "SELECT EMP_NAME,EMP_DIVN_CODE,EMP_JOB_LONG_DESC,EMP_COMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, traveler_emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.travelUName = rs.getString(1);
				this.travelUDivision = rs.getString(2);
				this.travelUDesignation = rs.getString(3);
				this.t_comp_code = rs.getString(4);
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
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

	public int getMoreUserDetails() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		String sqlstr = "SELECT TXNFIELD_FLD3,TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.traveler_emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.t_approver_eid = rs.getString(1);
				this.traveler_emailid = rs.getString(2);
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
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
				retval = -2;
			}
		}
		return retval;

	}

	public int sendEmailToHRAfterApproval() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		List<BusinessTripLVApplication> visitList = new ArrayList<BusinessTripLVApplication>();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		fjtcouser fusr = new fjtcouser();
		int hrmailstatus = 0;
		String usrsql = "SELECT fromdate,todate,country,customer_name,purpose,t_name,t_division,t_designation,t_fromAirport,pfromTime, t_returnAirport, preturnTime, luggageAllwReq ,handBagReq, hotelBookReq, traveleIns, checkInDate, "
				+ "checkOutDate,traveleReqSelfClient, estimatedTravelBudget, paymentCharges,uid,DATE(applied_date) from businesstrip_leave_application where req_id=?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setInt(1, this.req_id);
			rs = psmt.executeQuery();

			while (rs.next()) {
				Date fromDate = rs.getDate(1);
				Date toDate = rs.getDate(2);
				String country = rs.getString(3);
				String projectDetails = rs.getString(4);
				String purpose = rs.getString(5);
				String t_name = rs.getString(6);
				String t_division = rs.getString(7);
				String t_designation = rs.getString(8);
				String t_fromAirport = rs.getString(9);
				String pfromTime = rs.getString(10);
				String t_returnAirport = rs.getString(11);
				String preturnTime = rs.getString(12);
				String luggageAllwReq = rs.getString(13);
				String handBagReq = rs.getString(14);
				String hotelBookReq = rs.getString(15);
				String traveleIns = rs.getString(16);
				Date checkInDate = rs.getDate(17);
				Date checkOutDate = rs.getDate(18);
				String traveleReqSelfClient = rs.getString(19);
				String estimatedTravelBudget = rs.getString(20);
				String paymentCharges = rs.getString(21);
				String uid = rs.getString(22);
				Date appliedDate = rs.getDate(23);
				BusinessTripLVApplication btlva = new BusinessTripLVApplication(fromDate, toDate, country,
						projectDetails, purpose, t_name, t_division, t_designation, t_fromAirport, pfromTime,
						t_returnAirport, preturnTime, luggageAllwReq, handBagReq, hotelBookReq, traveleIns, checkInDate,
						checkOutDate, traveleReqSelfClient, estimatedTravelBudget, paymentCharges, uid, appliedDate);

				String toaddr = getHREmailidForBusinessTripApplication();
				String msg1 = this.getHRRequestMessageBody(btlva);
				SSLMail sslmail = new SSLMail();
				sslmail.setToaddr(toaddr);
				sslmail.setMessageSub("FJPortal-Business Trip Application(Hotel and Air Ticket)" + " - " + t_name);
				sslmail.setMessagebody(msg1);
				hrmailstatus = sslmail.sendMail(fusr.getUrlAddress());
				System.out.println("mail sent in processBusinesstripApplicationApproval");

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
			}
		}

		return hrmailstatus;
	}

	private String getHRRequestMessageBody(BusinessTripLVApplication btlva) {
		if (this.emp_code == null)
			return null;
		String checkinoutdata;
		if (btlva.getHotelBookReq().equals("Yes")) {
			checkinoutdata = "<tr><td><b>Hotel Booking required  </b> </td><td><b> :</b> </td><td> "
					+ btlva.getHotelBookReq() + " </td></tr>"
					+ "<tr><td><b>Check-In Date  </b> </td><td><b> :</b> </td><td>"
					+ getFormatedDateStr(btlva.getCheckInDate())
					+ "</td><td></td><td></td><td><b>Check-Out Date  </b> </td><td><b> :</b> </td><td>"
					+ getFormatedDateStr(btlva.getCheckOutDate()) + "</td></tr>";
		} else {
			checkinoutdata = "<tr><td><b>Hotel Booking required  </b> </td><td><b> :</b> </td><td> "
					+ btlva.getHotelBookReq() + " </td><td></td><td></td></tr>";
		}
		String msg = " <table><tr><td><b style=\"color:#0089cd;font-weight: bold;\">Employee Details:</b></td><td></td></tr></br>"
				+ "<tr><td><b>Employee Name</b></td><td> <b>:</b> </td><td> " + btlva.getTravelUName()
				+ "</td><td></td><td></td><td><b>Employee Code </b> </td><td><b> :</b> </td><td> "
				+ btlva.getTravelerUid() + " </td></tr>"
				// + "<tr><td><b>Employee Code </b> </td><td><b> :</b> </td><td> " +
				// btlva.getTravelerUid() + " </td></tr>"
				+ "<tr><td><b>Division  </b> </td><td><b> :</b> </td><td> " + btlva.getTravelUDivision()
				+ " </td><td></td><td></td><td><b>Designation  </b> </td><td><b> :</b> </td><td> "
				+ btlva.getTravelUDesignation() + " </td></tr><tr></tr>"
				// + "<tr><td><b>Designation </b> </td><td><b> :</b> </td><td> " +
				// btlva.getTravelUDesignation()+ " </td></tr>"
				+ "<tr><td><b style=\"color:#0089cd;font-weight: bold;\">Travel Details:</b></td><td></td></tr></br>"
				+ "<tr><td><b>Date of Request </b> </td><td><b> :</b> </td><td> "
				+ getFormatedDateStr(btlva.getRequstDate())
				+ " </td><td></td><td></td><td><b>Date of Travel  </b> </td><td><b> :</b> </td><td> "
				+ getFormatedDateStr(btlva.getFromdate()) + " </td></tr>"
				+ "<tr><td><b>Date of Return  </b> </td><td><b> :</b> </td><td> "
				+ getFormatedDateStr(btlva.getTodate()) + " </td><td></td><td></td></tr>"
				+ "<tr><td><b>Traveling from Airport  </b> </td><td><b> :</b> </td><td> " + btlva.getFromAirport()
				+ " </td><td></td><td></td><td><b>Preferable Time </b> </td><td><b> :</b> </td><td> "
				+ btlva.getPfromTime() + " </td> </tr>"
				+ "<tr><td><b>Return from Airport  </b> </td><td><b> :</b> </td><td> " + btlva.getRetrunAirport()
				+ " </td><td></td><td></td><td><b>Preferable Time </b> </td><td><b> :</b> </td><td> "
				+ btlva.getPreturnTime() + " </td></tr>"
				+ "<tr><td><b>Luggage Allowance Required  </b> </td><td><b> :</b> </td><td> "
				+ btlva.getLuggageAllwReq()
				+ " </td><td></td><td></td><td><b>Only Hand Bag  </b> </td><td><b> :</b> </td><td> "
				+ btlva.getHandBagReq() + " </td></tr>" + checkinoutdata
				+ "<tr><td><b>Travel Insurance Required  </b> </td><td><b> :</b> </td><td> " + btlva.getTraveleIns()
				+ " </td><td></td><td></td><td><b>Travel Request By </b> </td><td><b> :</b> </td><td>"
				+ btlva.getTraveleReqSelfClient() + "</td></tr>"
				+ "<tr><td><b>Estimated Travel Budget  </b> </td><td><b> :</b> </td><td>"
				+ btlva.getEstimatedTravelBudget()
				+ " </td><td></td><td></td><td><b>Payment Charges  </b> </td><td><b> :</b> </td><td>"
				+ btlva.getPaymentCharges() + "<td></tr></br>"
				+ "<tr><td><b style=\"color:#0089cd;font-weight: bold;\">Project Details:</b></td><td></td></tr></br>"
				+ "<tr><td><b>Country Visited  </b> </td><td><b> :</b> </td><td>" + btlva.getCountry()
				+ " </td><td></td><td></td><td><b>Project Details  </b> </td><td><b> :</b> </td><td>"
				+ btlva.getProjectDetails() + " </td></tr>" + "<tr><td><b>Purpose</b> </td><td><b> :</b> </td><td>"
				+ btlva.getPurpose() + " </td></tr>" + " .</td></tr>" + "</table>";

		return msg;
	}

	public String getHREmailidForBusinessTripApplication() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return null;
		String retval = null;
		PreparedStatement psmt = null;

		ResultSet rs = null; // status,fromdate,todate,resumedate,leavedays,reason,address,comp_code,reqid
		String usrsql = "select emailid from  emailconf where usagetype='HRTEAM'";
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
		System.out.println("HR team emaild ids" + retval);
		return retval;
	}

}
