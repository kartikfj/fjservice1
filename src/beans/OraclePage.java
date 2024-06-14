package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class OraclePage {
	private String name;
	private String description;
	private String travelUName = null;
	private String traveler_emp_code = null;
	private String travelerUid = null;
	private String emp_code = null;
	private ArrayList pendleaveapplications = null;

	public String getTraveler_emp_code() {
		return traveler_emp_code;
	}

	public void setTraveler_emp_code(String traveler_emp_code) {
		this.traveler_emp_code = traveler_emp_code;
	}

	public OraclePage() {
	}

	public String getTravelUName() {
		return travelUName;
	}

	public void setTravelUName(String travelUName) {
		this.travelUName = travelUName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTravelerUid() {
		return travelerUid;
	}

	public void setTravelerUid(String travelerUid) {
		this.travelerUid = travelerUid;
	}

	public ArrayList getPendleaveapplications() {
		return pendleaveapplications;
	}

	public void setPendleaveapplications(ArrayList pendleaveapplications) {
		this.pendleaveapplications = pendleaveapplications;
	}

	public String getEmp_code() {
		return emp_code;
	}

	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	public OraclePage(String name, String description) {
		this.name = name;
		this.description = description;
	}

	public String getCheckUid() {
		// String url = "jdbc:oracle:thin:@10.10.0.46:1521:orcl";
		Connection myCon = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		ResultSet myRes = null;
		PreparedStatement pstmt = null;
		String custcode = null;
		this.travelerUid = traveler_emp_code;
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT CUST_BL_NAME FROM ORION.OM_CUSTOMER WHERE CUST_CODE=?";
			pstmt = myCon.prepareStatement(sql);
			pstmt.setString(1, traveler_emp_code);
			myRes = pstmt.executeQuery();
			while (myRes.next()) {
				this.travelUName = myRes.getString(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt, myRes);
			orcl.closeConnection();
		}
		return custcode;
	}

	public int getSaveOraclePage() {
		// String url = "jdbc:oracle:thin:@10.10.0.46:1521:orcl";
		int logCount = 0;
		Connection myCon = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		ResultSet myRes = null;
		PreparedStatement pstmt = null;
		try {
			myCon = orcl.getOrclConn();
			// String sql = "UPDATE ORION.OM_CUSTOMER SET CUST_BL_NAME = ?, CUST_UPD_UID= ?,
			// CUST_UPD_DT=SYSDATE WHERE CUST_CODE=?";
			String sql = "INSERT INTO ORALCE_TEST1(NAME,DESCRIPTION) VALUES(?,?)";
			pstmt = myCon.prepareStatement(sql);
			pstmt.setString(1, travelUName);
			// pstmt.setString(2, emp_code);
			pstmt.setString(2, travelerUid);
			logCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt, myRes);
			orcl.closeConnection();
		}
		return logCount;
	}

	public int getRefreshOraclePage() {
		// String url = "jdbc:oracle:thin:@10.10.0.46:1521:orcl";
		ResultSet myRes = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		if (pendleaveapplications == null)
			pendleaveapplications = new ArrayList<LeaveApplication>();
		else
			pendleaveapplications.clear();
		int retval = 0;
		// this.travelerUid = traveler_emp_code;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			conn = orcl.getOrclConn();
			String sql = "SELECT CUST_CODE,CUST_BL_NAME  FROM ORION.OM_CUSTOMER WHERE CUST_BL_NAME IS NOT NULL";
			pstmt = conn.prepareStatement(sql);
			myRes = pstmt.executeQuery();
			while (myRes.next()) {
				OraclePage btlva = new OraclePage();
				btlva.setName(myRes.getString(1));
				btlva.setDescription(myRes.getString(2));
				this.pendleaveapplications.add(btlva);
			}
			retval = this.pendleaveapplications.size();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt, myRes);
			orcl.closeConnection();
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
}
