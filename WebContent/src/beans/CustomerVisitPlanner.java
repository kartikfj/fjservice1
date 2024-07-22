package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class CustomerVisitPlanner {
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

	private int month;
	private int day;
	private int visitCount;
	private String year;
	private int totalVisits;
	private String smName = null;
	private Map<Integer, Integer> categoryMapping = null;

	public Map<Integer, Integer> getCategoryMapping() {
		return categoryMapping;
	}

	public void setCategoryMapping(Map<Integer, Integer> categoryMapping) {
		this.categoryMapping = categoryMapping;
	}

	public CustomerVisitPlanner() {

	}

	public CustomerVisitPlanner(int month, int day, int visitCount) {
		super();
		this.month = month;
		this.day = day;
		this.visitCount = visitCount;
	}

	public CustomerVisitPlanner(int day, int visitCount) {
		super();
		this.day = day;
		this.visitCount = visitCount;
	}

	public CustomerVisitPlanner(Map<Integer, Integer> catMapObj) {
		super();
		this.categoryMapping = catMapObj;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getSegCode() {
		return segCode;
	}

	public void setSegCode(String segCode) {
		this.segCode = segCode;
	}

	public String getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(String visitDate) {
		this.visitDate = visitDate;
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

	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public int getTotalVisits() {
		return totalVisits;
	}

	public void setTotalVisits(int totalVisits) {
		this.totalVisits = totalVisits;
	}

	public String getSmName() {
		return smName;
	}

	public void setSmName(String smName) {
		this.smName = smName;
	}

	public List<CustomerVisitPlanner> getMonthlyCustomerVisitDays(int month, int year, String smCode, String empCode) {
		List<CustomerVisitPlanner> custVisitDays = new ArrayList<>();
		List<CustomerVisitPlanner> custVisitPlDays = new ArrayList<>();
		Map<Integer, Integer> catMapObj = new LinkedHashMap();
		if (smCode == null || smCode.isEmpty()) {
			smCode = getSalesEgsCode(empCode);
			// if(smCode == null || smCode.isEmpty()) {
			System.out.println("getMonthlyCustomerVisitDays SM code null " + empCode);
			// smCode = "NA";
			// }
		}
		custVisitDays.clear();
		custVisitPlDays.clear();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		ResultSet myRes = null;
		PreparedStatement myStmt = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT EXTRACT(DAY FROM ACT_DT) \"CUST_VISIT_DAYS\", COUNT(ACT_DT) \"VISTS_COUNT\" FROM  FJPORTAL.CUS_VIST_PLANNER WHERE EXTRACT(YEAR FROM ACT_DT) = ? "
					+ " AND ACT_SM_CODE = ? " + " GROUP BY ACT_SM_CODE, ACT_DT  " + " ORDER BY 1 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			// myStmt.setInt(2, month);
			myStmt.setString(2, smCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int day = myRes.getInt(1);
				int visitCount = myRes.getInt(2);
				catMapObj.put(day, visitCount);
				CustomerVisitPlanner tmpVisitPlDay = new CustomerVisitPlanner(month, day, visitCount);
				custVisitPlDays.add(tmpVisitPlDay);
				CustomerVisitPlanner tmpVisitDay = new CustomerVisitPlanner(catMapObj);
				custVisitDays.add(tmpVisitDay);
				// custVisitDays.add(catMapObj);
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

	public int getCustomVisitPlannerDayStatus(List<CustomerVisitPlanner> cvList, int day) {
		// checking customer visit status ( count of visits) for each day by passing
		// particular day
		int status = 0;

		if (cvList.stream().anyMatch(item -> item.getDay() == day)) {
			// status = 1;
			Optional<CustomerVisitPlanner> matchingObject = cvList.stream().filter(p -> p.getDay() == day).findFirst();
			CustomerVisitPlanner cv = matchingObject.get();
			// System.out.println(cv.getDay()+" "+cv.getVisitCount());
			status = cv.getVisitCount();

		} else {
			status = 0;
		}
		return status;
	}

	public List<CustomerVisitPlanner> getMonthlyCustomerVisitPlannedDays(int month, int year, String smCode,
			String empCode) {

		List<CustomerVisitPlanner> custVisitPlDays = new ArrayList<>();

		if (smCode == null || smCode.isEmpty()) {
			smCode = getSalesEgsCode(empCode);
			// if(smCode == null || smCode.isEmpty()) {
			System.out.println("getMonthlyCustomerVisitDays SM code null " + empCode);
			// smCode = "NA";
			// }
		}

		custVisitPlDays.clear();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		ResultSet myRes = null;
		PreparedStatement myStmt = null;
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT EXTRACT(DAY FROM ACT_DT) \"CUST_VISIT_DAYS\", COUNT(ACT_DT) \"VISTS_COUNT\" FROM  FJPORTAL.CUS_VIST_PLANNER WHERE EXTRACT(YEAR FROM ACT_DT) = ? "
					+ "  AND EXTRACT(MONTH FROM ACT_DT) = ? AND ACT_SM_CODE = ? " + " GROUP BY ACT_SM_CODE, ACT_DT  "
					+ " ORDER BY 1 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myStmt.setInt(2, month);
			myStmt.setString(3, smCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int day = myRes.getInt(1);
				int visitCount = myRes.getInt(2);
				CustomerVisitPlanner tmpVisitPlDay = new CustomerVisitPlanner(month, day, visitCount);
				custVisitPlDays.add(tmpVisitPlDay);

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
		return custVisitPlDays;
	}

	public List<CustomerVisitPlanner> getMonthlyRemindersDays(int month, int year, String smCode, String empCode) {

		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		ResultSet myRes = null;
		PreparedStatement myStmt = null;
		List<CustomerVisitPlanner> reminderDays = new ArrayList<>();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT EXTRACT(DAY FROM REMINDER_DATE) DAY, COUNT(REMINDER_DATE) REMINDER_COUNT FROM  FJPORTAL.SIP_REMINDER WHERE EXTRACT(YEAR FROM REMINDER_DATE) = ? "
					+ "  AND EXTRACT(MONTH FROM REMINDER_DATE) = ? AND EMP_CODE = ? AND REMINDER_DATE >= SYSDATE  GROUP BY EMP_CODE, REMINDER_DATE  ORDER BY 1 ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, year);
			myStmt.setInt(2, month);
			myStmt.setString(3, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int day = myRes.getInt(1);
				int visitCount = myRes.getInt(2);
				CustomerVisitPlanner tmpVisitPlDay = new CustomerVisitPlanner(month, day, visitCount);
				reminderDays.add(tmpVisitPlDay);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getMonthlyRemindersDays" + empCode + " SM CODE " + smCode);
			e.printStackTrace();
			System.out.println("Exception  DB Connection");
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
		return reminderDays;
	}

	public int getReminderDayStatus(List<CustomerVisitPlanner> cvList, int day) {
		// checking customer visit status ( count of visits) for each day by passing
		// particular day
		int status = 0;

		if (cvList.stream().anyMatch(item -> item.getDay() == day)) {
			// status = 1;
			Optional<CustomerVisitPlanner> matchingObject = cvList.stream().filter(p -> p.getDay() == day).findFirst();
			CustomerVisitPlanner cv = matchingObject.get();
			// System.out.println(cv.getDay()+" "+cv.getVisitCount());
			status = cv.getVisitCount();

		} else {
			status = 0;
		}
		return status;
	}

}
