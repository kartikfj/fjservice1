package utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.PortalITProjects;

public class PortalITProjectsDbUtil {
	private List<PortalITProjects> ITREQLIST = null;

	public List<PortalITProjects> displayDefaultItProjects() throws SQLException {
		// List<PortalITProjects> itReqList = new ArrayList<>();
		if (ITREQLIST == null)
			ITREQLIST = new ArrayList<PortalITProjects>();
		else
			ITREQLIST.clear();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * from PORTAL_IT_PROJECTS  ORDER BY CREATEDON DESC";
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				int serialNo = myRes.getInt(1);
				String division = myRes.getString(2);
				String requestedBy = myRes.getString(3);
				String project = myRes.getString(4);
				String usedBy = myRes.getString(5);
				String Priority = myRes.getString(6);
				String monthlySavings = myRes.getString(7);
				String approxComplDate = myRes.getString(8);
				String outSrcCost = myRes.getString(9);
				String status = myRes.getString(10);
				String remarks = myRes.getString(11);
				String feedback = myRes.getString(12);
				String createdBy = myRes.getString(13);
				String createdOn = myRes.getString(14);
				String updatedBy = getEmpNameByUid(myRes.getString(15));
				Date updatedOn = myRes.getDate(16);
				int divisionStatus = myRes.getInt(17);
				int itStatus = myRes.getInt(18);
				String remarksbydiv = myRes.getString(19);

				PortalITProjects tempitReqList = new PortalITProjects(serialNo, division, requestedBy, project, usedBy,
						Priority, monthlySavings, approxComplDate, outSrcCost, status, remarks, feedback, createdBy,
						createdOn, updatedBy, updatedOn, divisionStatus, itStatus, remarksbydiv);
				ITREQLIST.add(tempitReqList);
			}
			return ITREQLIST;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<PortalITProjects> getITREQLIST() {
		return ITREQLIST;
	}

	public void setITREQLIST(List<PortalITProjects> iTREQLIST) {
		ITREQLIST = iTREQLIST;
	}

	public int updateProjectRequestByIT() throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "UPDATE PORTAL_IT_PROJECTS SET ESTI_COMPL_DATE=?,OUTSRC_COST=?,STATUS=?,REMARKS=?,UPDATEDBY=?,UPDATEDON=?,IT_STATUS=? WHERE SYS_ID=?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setLong(1, 1);
			myStmt.setString(2, "");
			myStmt.setInt(3, 2);
			myStmt.setString(4, "");
			myStmt.setInt(5, 2);
			myStmt.setString(6, "");
			int d = myStmt.executeUpdate();
			return d;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
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

	public String getEmpNameByUid(String id) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String empname = null;
		// String sqlstr = "SELECT EMP_NAME FROM ORION.PM_EMP_KEY WHERE EMP_CODE =? AND
		// EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		String sqlstr = "SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				empname = rs.getString(1);

			}

		} catch (Exception e) {
			e.printStackTrace();

			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				empname = null;
			}
		}
		return empname;
	}

}
