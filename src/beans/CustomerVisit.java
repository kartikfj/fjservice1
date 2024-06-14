package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CustomerVisit {
	private String id = null;
	private String documentId = null;
	private String partyName = null;
	private String contact = null;
	private String project = null;
	private String projectStage = null;
	private String consultant = null;
	private String actionType = null;
	private String actnDesc = null;
	private String fromTime = null;
	private String toTime = null;
	private String segCode = null;
	private String visitDate = null;

	private String customerName = null;
	private String customerContactNo = null;
	private String userType = null;

	private int month;
	private int day;
	private int visitCount;
	private String year;

	private int totalVisits;

	private String smName = null;

	private int hsysId;

	public int getHsysId() {
		return hsysId;
	}

	public void setHsysId(int hsysId) {
		this.hsysId = hsysId;
	}

	public CustomerVisit() {
		super();
	}

	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public String getProjectStage() {
		return projectStage;
	}

	public void setProjectStage(String projectStage) {
		this.projectStage = projectStage;
	}

	public String getConsultant() {
		return consultant;
	}

	public void setConsultant(String consultant) {
		this.consultant = consultant;
	}

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public String getActnDesc() {
		return actnDesc;
	}

	public void setActnDesc(String actnDesc) {
		this.actnDesc = actnDesc;
	}

	public String getFromTime() {
		return fromTime;
	}

	public void setFromTime(String fromTime) {
		this.fromTime = fromTime;
	}

	public String getToTime() {
		return toTime;
	}

	public void setToTime(String toTime) {
		this.toTime = toTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getTotalVisits() {
		return totalVisits;
	}

	public void setTotalVisits(int totalVisits) {
		this.totalVisits = totalVisits;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getSegCode() {
		return segCode;
	}

	public void setSegCode(String segCode) {
		this.segCode = segCode;
	}

	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerContactNo() {
		return customerContactNo;
	}

	public void setCustomerContactNo(String customerContactNo) {
		this.customerContactNo = customerContactNo;
	}

	public String getSmName() {
		return smName;
	}

	public void setSmName(String smName) {
		this.smName = smName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public CustomerVisit(String documentId, String partyName, String contact, String project, String projectStage,
			String consultant) {
		super();
		this.documentId = documentId;
		this.partyName = partyName;
		this.contact = contact;
		this.project = project;
		this.projectStage = projectStage;
		this.consultant = consultant;
	}

	public CustomerVisit(String documentId, String partyName, String contact, String project, String projectStage,
			String consultant, int sysId) {
		super();
		this.documentId = documentId;
		this.partyName = partyName;
		this.contact = contact;
		this.project = project;
		this.projectStage = projectStage;
		this.consultant = consultant;
		this.hsysId = sysId;
	}

	public CustomerVisit(String documentId, String partyName, String project, String actnDesc, String userType) {
		super();
		this.documentId = documentId;
		this.partyName = partyName;
		this.project = project;
		this.actnDesc = actnDesc;
		this.userType = userType;
	}

	public CustomerVisit(String actionType) {
		super();
		this.actionType = actionType;
	}

	public CustomerVisit(String id, String documentId, String project, String actionType, String fromTime,
			String toTime, String actnDesc, String partyName) {
		super();
		this.id = id;
		this.documentId = documentId;
		this.project = project;
		this.actionType = actionType;
		this.fromTime = fromTime;
		this.toTime = toTime;
		this.actnDesc = actnDesc;
		this.partyName = partyName;
	}

	public CustomerVisit(int month, int day, int visitCount) {
		super();
		this.month = month;
		this.day = day;
		this.visitCount = visitCount;
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

	public List<CustomerVisit> getMonthlyCustomerVisitDays(int month, int year, String smCode, String empCode) {
		List<CustomerVisit> custVisitDays = new ArrayList<>();
		if (smCode == null || smCode.isEmpty()) {
			smCode = getSalesEgsCode(empCode);
			// if(smCode == null || smCode.isEmpty()) {
			System.out.println("getMonthlyCustomerVisitDays SM code null " + empCode);
			// smCode = "NA";
			// }
		}
		custVisitDays.clear();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		ResultSet myRes = null;
		PreparedStatement myStmt = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT EXTRACT(DAY FROM ACT_DT) \"CUST_VISIT_DAYS\", COUNT(ACT_DT) \"VISTS_COUNT\" FROM  FJPORTAL.CUS_VIST_ACTION WHERE EXTRACT(YEAR FROM ACT_DT) = ? "
					+ " AND EXTRACT(MONTH FROM ACT_DT) = ? AND ACT_SM_CODE IN ( SELECT SM_CODE FROM OM_SALESMAN WHERE SM_FLEX_08 = ? ) "
					+ " GROUP BY ACT_SM_CODE, ACT_DT  " + " ORDER BY 1 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myStmt.setInt(2, month);
			myStmt.setString(3, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int day = myRes.getInt(1);
				int visitCount = myRes.getInt(2);
				CustomerVisit tmpVisitDay = new CustomerVisit(month, day, visitCount);
				custVisitDays.add(tmpVisitDay);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("SALES EGR EMP CODE FOR ERROR IN  CustomerVisit.getMonthlyCustomerVisitDays " + empCode
					+ " SM CODE " + smCode);
			e.printStackTrace();
			System.out.println("Exception  DB Connection");
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return custVisitDays;
	}

	public String getSalesEgsCode(String emp_code) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = "";
		String sqlstr = "SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 ";

		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			} else {
				retval = "NA";// not applicable
			}
		} catch (Exception e) {
			System.out.println("SALES EGR EMP CODE FOR ERROR IN  CustomerVisit  getSalesEgsCode " + emp_code);
			e.printStackTrace();
			retval = "NA";
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
				retval = "";
			}
		}
		return retval;
	}

	public int getCustomVisitDayStatus(List<CustomerVisit> cvList, int day) {
		// checking customer visit status ( count of visits) for each day by passing
		// particular day
		int status = 0;

		if (cvList.stream().anyMatch(item -> item.getDay() == day)) {
			// status = 1;
			Optional<CustomerVisit> matchingObject = cvList.stream().filter(p -> p.getDay() == day).findFirst();
			CustomerVisit cv = matchingObject.get();
			// System.out.println(cv.getDay()+" "+cv.getVisitCount());
			status = cv.getVisitCount();

		} else {
			status = 0;
		}
		return status;
	}

	public CustomerVisit(String year, int month, int totalVisits) {
		super();
		this.year = year;
		this.month = month;
		this.totalVisits = totalVisits;
	}

	public String getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(String visitDate) {
		this.visitDate = visitDate;
	}

	public CustomerVisit(String documentId, String segCode, String visitDate, String actnDesc, String actionType,
			String fromTime, String toTime, String project, String partyName, String customerName,
			String customerContactNo) {
		super();
		this.documentId = documentId;
		this.segCode = segCode;
		this.visitDate = visitDate;
		this.actnDesc = actnDesc;
		this.actionType = actionType;
		this.fromTime = fromTime;
		this.toTime = toTime;
		this.project = project;
		this.partyName = partyName;
		this.customerName = customerName;
		this.customerContactNo = customerContactNo;
	}

	public CustomerVisit(String documentId, String segCode, String visitDate, String actnDesc, String actionType,
			String fromTime, String toTime, String project, String partyName, String customerName,
			String customerContactNo, String smName) {
		super();
		this.documentId = documentId;
		this.segCode = segCode;
		this.visitDate = visitDate;
		this.actnDesc = actnDesc;
		this.actionType = actionType;
		this.fromTime = fromTime;
		this.toTime = toTime;
		this.project = project;
		this.partyName = partyName;
		this.customerName = customerName;
		this.customerContactNo = customerContactNo;
		this.smName = smName;
	}

	public CustomerVisit(String visitDate, String actnDesc) {
		super();
		this.visitDate = visitDate;
		this.actnDesc = actnDesc;
	}

}
