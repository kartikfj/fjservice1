package utils;

 
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import beans.EmailServiceRequest; 
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;
import beans.ServicePortalReportStaffs;
import beans.ServicePortalStaffs;
import beans.ServiceReport;
import beans.ServiceRequest; 

public class ServicePortalDbUtil {
	
	
	public List<ServiceRequest> getFldEngineersList(String employeeCode) throws SQLException {  
		String userType = "FU";
		List<ServiceRequest> fieldUsersList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "  SELECT EMP_CODE, EMP_NAME, HRLY_RATE  " + 
					"  FROM SERVICE_FLDSTAFF_ALLWNCE " + 
					"  RIGHT JOIN PM_EMP_KEY " + 
					"  ON EMPID = EMP_CODE AND  EMP_FRZ_FLAG = ? AND ACTV_YN = ? " + 
					"  WHERE  USER_TYPE = ? AND  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )  ";
			myStmt = myCon.prepareStatement(sql); 
			myStmt.setString(1, "N"); 
			myStmt.setString(2, "Y"); 
			myStmt.setString(3, "FU"); 
			myStmt.setString(4, employeeCode); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String fldUserId = myRes.getString(1);
				String fldUsrName = myRes.getString(2); 
				ServiceRequest tmpFieldUsersList = new ServiceRequest(fldUserId, fldUsrName, userType );
				fieldUsersList.add(tmpFieldUsersList);
			}
			return fieldUsersList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}
	public List<ServiceRequest> getRegions() throws SQLException {  
		List<ServiceRequest> regionList = new ArrayList<>();
		 Connection myCon = null;
		 Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT REGION FROM FJPORTAL.SERVICE_REGIONS ";	
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String region = myRes.getString(1); 
				ServiceRequest tmpRegionList = new ServiceRequest(1, region);
				regionList.add(tmpRegionList);
			}
			return regionList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}
	public ServiceRequest getUserType(String empCode) throws SQLException {
		ServiceRequest userDtls = null ;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT USER_TYPE, DIVN_CODE FROM FJPORTAL.SERVICE_USER WHERE  EMPID = ?  AND ROWNUM = 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {			
				String user_type = myRes.getString(1); 	
				String user_divn = myRes.getString(2);
				userDtls = new ServiceRequest(user_type, user_divn);
				 
			}
			
			return userDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

 

	public List<ServiceRequest> getStage2ProjectDetails(String salesOrderNo) throws SQLException {
		List<ServiceRequest> projectDtls = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql =" SELECT * FROM FJPORTAL.FJSERVICE_PROJECT_DETAILS WHERE SO_CODE = ?  AND  ROWNUM = 1 ";
			//String sql = " SELECT * FROM PUMP_PROJECT WHERE PROJECT_CODE = ?  AND  ROWNUM = 1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, salesOrderNo);// ORION sales order number 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String soCodeNo = myRes.getString(1);
				String projectName = myRes.getString(2);
				String customer = myRes.getString(3);
				String consultantName = myRes.getString(4); 

				// System.out.println(description+" "+status+" "+mailSendYN);
				ServiceRequest tempProjectDtls = new ServiceRequest(soCodeNo, projectName,  customer, consultantName);
				projectDtls.add(tempProjectDtls);
			}
			// System.out.println(salesEngList);
			return projectDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServicePortalStaffs> viewFieldAssistantVisitDetails(String visitId) throws SQLException {
		List<ServicePortalStaffs> visitDtls = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql =" SELECT * FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS WHERE VISIT_DETL_SYS_ID = ?  "; 
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, visitId); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String fldAsst_empid = myRes.getString(2);
				String visitDate = myRes.getString(3); 
				String checkin = myRes.getString(4);
				String checkout = myRes.getString(5);
				int totalTime = myRes.getInt(6); 
				int hrlyRate = myRes.getInt(8); 

				// System.out.println(description+" "+status+" "+mailSendYN);
				ServicePortalStaffs tempVisitDtls = new ServicePortalStaffs(fldAsst_empid, visitDate, checkin,  checkout, totalTime, hrlyRate);
				visitDtls.add(tempVisitDtls);
			} 
			return visitDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServicePortalStaffs> viewCompleteVisitTimeDetails(String serviceId) throws SQLException {
		List<ServicePortalStaffs> visitDtls = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql =" SELECT  FLD_STF_UID, FLD_VISIT_DATE, CHECK_IN_TIME,CHECK_OUT_TIME , TTL_VST_TIME_MNT, HRLY_RATE, EMP_NAME FROM ( " + 
					" SELECT FLD_STF_UID, FLD_VISIT_DATE, CHECK_IN_TIME,CHECK_OUT_TIME , TTL_VST_TIME_MNT, HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ENTRY " + 
					" WHERE VISIT_HEAD_SYS_ID = ? " + 
					" UNION ALL " + 
					" SELECT FLD_ASSTNT_UID, FLD_VISIT_DATE, CHECK_IN_TIME, CHECK_OUT_TIME, TTL_VST_TIME_MNT,HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS  " + 
					" WHERE VISIT_DETL_SYS_ID IN (SELECT VISIT_DETL_SYS_ID from FJPORTAL.SERVICE_FLD_ENTRY  " + 
					" WHERE VISIT_HEAD_SYS_ID = ?))  COMPLE_VISIT " + 
					" LEFT JOIN PM_EMP_KEY " + 
					" ON FLD_STF_UID = EMP_CODE " + 
					" ORDER BY FLD_VISIT_DATE  "; 
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, serviceId); 
			myStmt.setString(2, serviceId); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String fldAsst_empid = myRes.getString(1);
				String visitDate = myRes.getString(2); 
				String checkin = myRes.getString(3);
				String checkout = myRes.getString(4);
				int totalTime = myRes.getInt(5); 
				int hrlyRate = myRes.getInt(6); 
				String empName = myRes.getString(7);

				// System.out.println(description+" "+status+" "+mailSendYN);
				ServicePortalStaffs tempVisitDtls = new ServicePortalStaffs(fldAsst_empid, visitDate, checkin,  checkout, totalTime, hrlyRate, empName);
				visitDtls.add(tempVisitDtls);
			} 
			return visitDtls;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServiceRequest> getVisitType() throws SQLException {
		List<ServiceRequest> visitTypes = new ArrayList<>(); 
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT VISIT_TYPE FROM FJPORTAL.VISIT_TYPE ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {			
				String visitType = myRes.getString(1); 	
				
				ServiceRequest tempVisits = new ServiceRequest(visitType);
				visitTypes.add(tempVisits);
			}
			return visitTypes;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public int deleteFieldVisit(String serviceId, String visitId, String empCode) throws SQLException {
		//System.out.println(serviceId+" "+visitId+" "+empCode);
		int logType = -2; 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if(myCon == null) return -2;
			
			String sql = " DELETE FROM  FJPORTAL.SERVICE_FLD_ENTRY   " 
					+ " WHERE VISIT_HEAD_SYS_ID = ?  AND VISIT_DETL_SYS_ID = ? AND  FLD_STF_UID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, serviceId);
			myStmt.setString(2, visitId); 
			myStmt.setString(3, empCode);
			
			logType = myStmt.executeUpdate();
           // System.out.println("Delete status : "+logType);
		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at FV DELETE OP FOR  "+visitId);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			//System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}
	public int deleteFieldAssistantVisit(String visitId) throws SQLException {
		//System.out.println(serviceId+" "+visitId+" "+empCode);
		int logType = -2; 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if(myCon == null) return -2;
			
			String sql = " DELETE FROM  SERVICE_FLD_ASSTNT_VISITS   " 
					+ " WHERE VISIT_DETL_SYS_ID = ?  ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, visitId); 
			
			logType = myStmt.executeUpdate();
           // System.out.println("Delete status : "+logType);
		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at FV Assitant visits DELETE OP FOR  "+visitId);
			ex.printStackTrace();
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			//System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}
	public int deleteServiceRqst(String serviceId, String empCode) throws SQLException {
		int logType = -2; 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if(myCon == null) return -2;
			
			String sql = " UPDATE FJPORTAL.SERVICE_OFC_ENTRY   "
					+ " SET OFC_STF_UPD_DT  = SYSDATE, INTL_REQST_STATUS = 2, OFC_STF_UPD_UID = ? "
					+ " WHERE VISIT_SYS_ID = ?  AND INTL_REQST_STATUS = ? AND  OFC_STF_CR_UID = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empCode);
			myStmt.setString(2, serviceId);
			myStmt.setInt(3, 1);
			myStmt.setString(4, empCode);
			
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at SR DELETE OP FOR  "+serviceId);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			//System.out.println("Updated and closed db Successfully ");
		}
		return logType;
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
	
	public int insertNewServiceRequest(ServiceRequest serviceDetails) { 
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			Connection con = orcl.getOrclConn();
			if (con == null)
				return -2;
			PreparedStatement psmt = null;
			int retval = 0; 
			StringBuilder sqlstr = new StringBuilder( "INSERT INTO FJPORTAL.SERVICE_OFC_ENTRY ");
			sqlstr.append( "( PROJ_ID, PROJ_NAME, CUSTOMER_NAME, CONSULTANT_NAME, LOCATION, VISIT_TYPE, OFC_STF_INIT_REMARKS, EST_MATERIAL_COST, EST_LABOUR_COST, EST_OTHER_COST, FLD_STF_UID,  FLD_STF_NAME, OFC_STF_CR_UID, OFC_STF_CR_NAME, REGION, INTL_REQST_STATUS, OFC_STF_CR_DT )");
			sqlstr.append(" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE)");
			try {
				psmt = con.prepareStatement(sqlstr.toString());
				psmt.setString(1, serviceDetails.getSoCodeNo());
				psmt.setString(2, serviceDetails.getProjectName());
				psmt.setString(3, serviceDetails.getCustomer());
				psmt.setString(4, serviceDetails.getConsultant());
				psmt.setString(5, serviceDetails.getLocation());
				psmt.setString(6, serviceDetails.getVisitType());
				psmt.setString(7, serviceDetails.getOfcInitialRemarks());
				psmt.setDouble(8, serviceDetails.getMaterialCost());
				psmt.setDouble(9, serviceDetails.getLaborCost());
				psmt.setDouble(10, serviceDetails.getOtherCost());
				psmt.setString(11, serviceDetails.getFieldUserId());
				psmt.setString(12, serviceDetails.getFieldUserName());
				psmt.setString(13, serviceDetails.getOfficeUserId());
				psmt.setString(14, serviceDetails.getOfficeUserName());
				psmt.setString(15, serviceDetails.getRegion());
				psmt.setInt(16, 1);
				retval = psmt.executeUpdate();

			} catch (Exception e) {
				System.out.println("SERVICE REQST INSERT DB ERROR");
				e.printStackTrace();
				retval = -2;
				// DB error
			} finally {
				try {
					// if(rs!=null)
					// rs.close();
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

	
	public String getEmpNameByUid(String id) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String empname = null; 
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
	
	public List<ServiceRequest> getSeriveRequestList(ServiceRequest filterOptions) throws SQLException {
		List<ServiceRequest> serviceList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String sql = "";
		try {
			myCon = orcl.getOrclConn();
			//System.out.println("Status "+filterOptions.getStatus());
			switch(filterOptions.getStatus()) {
			case 0 : // pending requests
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND ( FINL_REQST_STATUS = ?  OR FINL_REQST_STATUS = 2 ) AND FLD_STF_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ? )  "
						+ " ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			case 1 : // closed requests
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND  FINL_REQST_STATUS = ?  AND FLD_STF_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ?) "
						+ " ORDER BY OFC_STF_CR_DT DESC ";
			    break;
			case 2 : // all requests
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  "
					+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
					+ " AND ( FINL_REQST_STATUS = 0  OR FINL_REQST_STATUS = 1  OR FINL_REQST_STATUS = ?) AND FLD_STF_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ?) "
					+ " ORDER BY OFC_STF_CR_DT DESC ";
			    break;
			default:
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND ( FINL_REQST_STATUS = ?  OR FINL_REQST_STATUS = 2 ) AND FLD_STF_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ?) "
						+ " ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "1");
			myStmt.setString(2, filterOptions.getStartDate());
			myStmt.setString(3, filterOptions.getToDate());
			myStmt.setInt(4, filterOptions.getStatus());
			myStmt.setString(5, "FU"); 
			myStmt.setString(6, filterOptions.getDivnCode());
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String id = myRes.getString(1);
				String soCodeNo = myRes.getString(2);
				String prjctName = myRes.getString(3);
				String customer = myRes.getString(4);
				String consultant = myRes.getString(5);
				String location = myRes.getString(6);
				String type = myRes.getString(7);
				String initialRemarks = myRes.getString(8);
				String finalRemarks = myRes.getString(9);
				double estMaterialCost = myRes.getDouble(10);
				double estLaborCost = myRes.getDouble(11);
				double estOtherCost = myRes.getDouble(12);
				double actMaterialCost = myRes.getDouble(13);
				double actLaborCost = myRes.getDouble(14);
				double actOtherCost = myRes.getDouble(15);
				String fldUsrID = myRes.getString(16);
				String fldUsrName = myRes.getString(17);
				String ofcUsrID = myRes.getString(18);
				String ofcUsrName = myRes.getString(19);
				String createdDate = myRes.getString(20);
				int intlStatus = myRes.getInt(24);
				int fldStatus = myRes.getInt(25);
				int finalStatus = myRes.getInt(26);
				int noOfVisits = myRes.getInt(27);
				double totalEstCost = 	myRes.getDouble(28);
				double totalActCost = 	myRes.getDouble(29);
				String region = myRes.getString(30);
				long totalServiceMinutes = myRes.getLong(31); 
				long totalServiceLaborExpense  = myRes.getLong(32);
				
				ServiceRequest tempServiceList = new ServiceRequest(id, soCodeNo, prjctName, customer, consultant, location, type, initialRemarks, finalRemarks, estMaterialCost, estLaborCost, estOtherCost, actMaterialCost, actLaborCost, 
						actOtherCost, fldUsrID, fldUsrName, ofcUsrID, ofcUsrName, createdDate, intlStatus, fldStatus, finalStatus, noOfVisits, totalEstCost, totalActCost, region, totalServiceMinutes, totalServiceLaborExpense);
				serviceList.add(tempServiceList);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServiceRequest> getSeriveRequestListOfficeUser(String empCode, ServiceRequest filterOptions) throws SQLException {
		List<ServiceRequest> serviceList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String sql = "";
		try {
			myCon = orcl.getOrclConn();
			switch(filterOptions.getStatus()) {
			case 0 : // pending requests, OFC UIDE VALIDATION REMOVED TOO ALL RQUEST TO ALL OU
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? "
						//+ "AND OFC_STF_CR_UID = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND ( FINL_REQST_STATUS = ?  OR FINL_REQST_STATUS = 2 ) "
						+ " AND  FLD_STF_UID IN ( SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )) "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			case 1 : // closed requests
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? "
					//	+ "AND OFC_STF_CR_UID = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND FINL_REQST_STATUS = ?   "
						+ " AND  FLD_STF_UID IN ( SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )) "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			case 2 : // all requests
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? "
					//	+ "AND OFC_STF_CR_UID = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND ( FINL_REQST_STATUS = 0  OR FINL_REQST_STATUS = 1  OR FINL_REQST_STATUS = ?) "
						+ " AND  FLD_STF_UID IN ( SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )) "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			default:
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? "
						//+ "AND OFC_STF_CR_UID = ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ " AND ( FINL_REQST_STATUS = ?  OR FINL_REQST_STATUS = 2 ) "
						+ " AND  FLD_STF_UID IN ( SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )) "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "1");
			//myStmt.setString(2, empCode);
			myStmt.setString(2, filterOptions.getStartDate());
			myStmt.setString(3, filterOptions.getToDate());
			myStmt.setInt(4, filterOptions.getStatus());
			myStmt.setString(5, empCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String id = myRes.getString(1);
				String soCodeNo = myRes.getString(2);
				String prjctName = myRes.getString(3);
				String customer = myRes.getString(4);
				String consultant = myRes.getString(5);
				String location = myRes.getString(6);
				String type = myRes.getString(7);
				String initialRemarks = myRes.getString(8);
				String finalRemarks = myRes.getString(9);
				double estMaterialCost = myRes.getDouble(10);
				double estLaborCost = myRes.getDouble(11);
				double estOtherCost = myRes.getDouble(12);
				double actMaterialCost = myRes.getDouble(13);
				double actLaborCost = myRes.getDouble(14);
				double actOtherCost = myRes.getDouble(15);
				String fldUsrID = myRes.getString(16);
				String fldUsrName = myRes.getString(17);
				String ofcUsrID = myRes.getString(18);
				String ofcUsrName = myRes.getString(19);
				String createdDate = myRes.getString(20);
				int intlStatus = myRes.getInt(24);
				int fldStatus = myRes.getInt(25);
				int finalStatus = myRes.getInt(26);
				int noOfVisits = myRes.getInt(27);
				double totalEstCost = 	myRes.getDouble(28);
				double totalActCost = 	myRes.getDouble(29);
				String region = myRes.getString(30);
				long totalServiceMinutes = myRes.getLong(31); 
				long totalServiceLaborExpense  = myRes.getLong(32);
				
				ServiceRequest tempServiceList = new ServiceRequest(id, soCodeNo, prjctName, customer, consultant, location, type, initialRemarks, finalRemarks, estMaterialCost, estLaborCost, estOtherCost, actMaterialCost, actLaborCost, 
						actOtherCost, fldUsrID, fldUsrName, ofcUsrID, ofcUsrName, createdDate, intlStatus,
						fldStatus, finalStatus, noOfVisits, totalEstCost, totalActCost, region, totalServiceMinutes, totalServiceLaborExpense);
				serviceList.add(tempServiceList);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServiceRequest> getSeriveRequestListFieldUser(String empCode, ServiceRequest filterOptions) throws SQLException {
		List<ServiceRequest> serviceList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			switch(filterOptions.getStatus()) {
			case 0 : // pending requests 
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? AND FLD_STF_UID = ? "
						+ " AND FLD_VST_STATUS = ? "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			case 1 : // closed requests 
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? AND FLD_STF_UID = ? "
						+ " AND FLD_VST_STATUS = ? "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			case 2 : // all requests 
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? AND FLD_STF_UID = ? "
						+ " AND FLD_VST_STATUS < ? "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			default: 
				sql = "SELECT * FROM  FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ? AND FLD_STF_UID = ? "
						+ " FLD_VST_STATUS < ?  "
						+ " AND OFC_STF_CR_DT >= TO_DATE( ?, 'DD/MM/YYYY') AND OFC_STF_CR_DT <= TO_DATE( ?, 'DD/MM/YYYY')+1  "
						+ "ORDER BY OFC_STF_CR_DT DESC ";
				    break;
			}
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "1");
			myStmt.setString(2, empCode);
			myStmt.setInt(3, filterOptions.getStatus());
			myStmt.setString(4, filterOptions.getStartDate());
			myStmt.setString(5, filterOptions.getToDate());
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String id = myRes.getString(1);
				String soCodeNo = myRes.getString(2);
				String prjctName = myRes.getString(3);
				String customer = myRes.getString(4);
				String consultant = myRes.getString(5);
				String location = myRes.getString(6);
				String type = myRes.getString(7);
				String initialRemarks = myRes.getString(8);
				String finalRemarks = myRes.getString(9);
				double estMaterialCost = myRes.getDouble(10);
				double estLaborCost = myRes.getDouble(11);
				double estOtherCost = myRes.getDouble(12);
				double actMaterialCost = myRes.getDouble(13);
				double actLaborCost = myRes.getDouble(14);
				double actOtherCost = myRes.getDouble(15);
				String fldUsrID = myRes.getString(16);
				String fldUsrName = myRes.getString(17);
				String ofcUsrID = myRes.getString(18);
				String ofcUsrName = myRes.getString(19);
				String createdDate = myRes.getString(20);
				int intlStatus = myRes.getInt(24);
				int fldStatus = myRes.getInt(25);
				int finalStatus = myRes.getInt(26);
				int noOfVisits = myRes.getInt(27);
				double totalEstCost = 	myRes.getDouble(28);
				double totalActCost = 	myRes.getDouble(29);
				String region = myRes.getString(30);

				long totalServiceMinutes = myRes.getLong(31); 
				long totalServiceLaborExpense  = myRes.getLong(32);
				
				ServiceRequest tempServiceList = new ServiceRequest(id, soCodeNo, prjctName, customer, consultant, location, type, initialRemarks, finalRemarks, estMaterialCost, estLaborCost, estOtherCost, actMaterialCost, actLaborCost, 
						actOtherCost, fldUsrID, fldUsrName, ofcUsrID, ofcUsrName, createdDate, intlStatus, 
						fldStatus, finalStatus, noOfVisits, totalEstCost, totalActCost, region, totalServiceMinutes, totalServiceLaborExpense);
				serviceList.add(tempServiceList);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public ServiceRequest getSingleSeriveRequest(String serviceId, String fldUserEmpCode) throws SQLException {
		ServiceRequest serviceList = null ;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  AND VISIT_SYS_ID = ? AND FLD_STF_UID = ? AND ROWNUM = 1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "1");
			myStmt.setString(2, serviceId);
			myStmt.setString(3, fldUserEmpCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String id = myRes.getString(1);
				String soCodeNo = myRes.getString(2);
				String prjctName = myRes.getString(3);
				String customer = myRes.getString(4);
				String consultant = myRes.getString(5);
				String location = myRes.getString(6);
				String type = myRes.getString(7);
				String initialRemarks = myRes.getString(8);
				String finalRemarks = myRes.getString(9);
				double estMaterialCost = myRes.getDouble(10);
				double estLaborCost = myRes.getDouble(11);
				double estOtherCost = myRes.getDouble(12);
				double actMaterialCost = myRes.getDouble(13);
				double actLaborCost = myRes.getDouble(14);
				double actOtherCost = myRes.getDouble(15);
				String fldUsrID = myRes.getString(16);
				String fldUsrName = myRes.getString(17);
				String ofcUsrID = myRes.getString(18);
				String ofcUsrName = myRes.getString(19);
				String createdDate = myRes.getString(20);
				int intlStatus = myRes.getInt(24);
				int fldStatus = myRes.getInt(25);
				int finalStatus = myRes.getInt(26);
				int noOfVisits = myRes.getInt(27); 
				double totalEstCost = 	myRes.getDouble(28);
				double totalActCost = 	myRes.getDouble(29);
				String region = myRes.getString(30);	
				long totalServiceMinutes = myRes.getLong(31); 
				long totalServiceLaborExpense  = myRes.getLong(32);
						 
				serviceList = new ServiceRequest(id, soCodeNo, prjctName, customer, consultant, location, type, initialRemarks, finalRemarks, estMaterialCost, estLaborCost, estOtherCost, actMaterialCost, actLaborCost, 
						actOtherCost, fldUsrID, fldUsrName, ofcUsrID, ofcUsrName, createdDate, intlStatus, 
						fldStatus, finalStatus, noOfVisits, totalEstCost, totalActCost, region, totalServiceMinutes, totalServiceLaborExpense);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	
	public ServiceRequest getSingleSeriveRequestForViewUser(String serviceId) throws SQLException {
		ServiceRequest serviceList = null ;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  AND VISIT_SYS_ID = ? AND ROWNUM = 1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "1");
			myStmt.setString(2, serviceId); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String id = myRes.getString(1);
				String soCodeNo = myRes.getString(2);
				String prjctName = myRes.getString(3);
				String customer = myRes.getString(4);
				String consultant = myRes.getString(5);
				String location = myRes.getString(6);
				String type = myRes.getString(7);
				String initialRemarks = myRes.getString(8);
				String finalRemarks = myRes.getString(9);
				double estMaterialCost = myRes.getDouble(10);
				double estLaborCost = myRes.getDouble(11);
				double estOtherCost = myRes.getDouble(12);
				double actMaterialCost = myRes.getDouble(13);
				double actLaborCost = myRes.getDouble(14);
				double actOtherCost = myRes.getDouble(15);
				String fldUsrID = myRes.getString(16);
				String fldUsrName = myRes.getString(17);
				String ofcUsrID = myRes.getString(18);
				String ofcUsrName = myRes.getString(19);
				String createdDate = myRes.getString(20);
				int intlStatus = myRes.getInt(24);
				int fldStatus = myRes.getInt(25);
				int finalStatus = myRes.getInt(26);
				int noOfVisits = myRes.getInt(27); 
				double totalEstCost = 	myRes.getDouble(28);
				double totalActCost = 	myRes.getDouble(29);
				String region = myRes.getString(30);
				long totalServiceMinutes = myRes.getLong(31);
				long totalServiceLaborExpense = myRes.getLong(32);
												 
				serviceList = new ServiceRequest(id, soCodeNo, prjctName, customer, consultant, location, type, initialRemarks, finalRemarks, estMaterialCost, estLaborCost, estOtherCost, actMaterialCost, actLaborCost, 
						actOtherCost, fldUsrID, fldUsrName, ofcUsrID, ofcUsrName, createdDate, intlStatus, 
						fldStatus, finalStatus, noOfVisits, totalEstCost, totalActCost, region, totalServiceMinutes, totalServiceLaborExpense);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	
	public ServiceRequest getSingleSeriveRequestForOfficeStaff(String serviceId, String offcUsrEmpCode) throws SQLException {
		ServiceRequest serviceList = null ;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJPORTAL.SERVICE_REQUESTS_LISTS_VIEW WHERE INTL_REQST_STATUS = ?  AND VISIT_SYS_ID = ? "
				//	+ "AND OFC_STF_CR_UID = ? "
					+ "AND ROWNUM = 1 ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, "1");
			myStmt.setString(2, serviceId);
		//	myStmt.setString(3, offcUsrEmpCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String id = myRes.getString(1);
				String soCodeNo = myRes.getString(2);
				String prjctName = myRes.getString(3);
				String customer = myRes.getString(4);
				String consultant = myRes.getString(5);
				String location = myRes.getString(6);
				String type = myRes.getString(7);
				String initialRemarks = myRes.getString(8);
				String finalRemarks = myRes.getString(9);
				double estMaterialCost = myRes.getDouble(10);
				double estLaborCost = myRes.getDouble(11);
				double estOtherCost = myRes.getDouble(12);
				double actMaterialCost = myRes.getDouble(13);
				double actLaborCost = myRes.getDouble(14);
				double actOtherCost = myRes.getDouble(15);
				String fldUsrID = myRes.getString(16);
				String fldUsrName = myRes.getString(17);
				String ofcUsrID = myRes.getString(18);
				String ofcUsrName = myRes.getString(19);
				String createdDate = myRes.getString(20);
				int intlStatus = myRes.getInt(24);
				int fldStatus = myRes.getInt(25);
				int finalStatus = myRes.getInt(26);
				int noOfVisits = myRes.getInt(27); 
				double totalEstCost = 	myRes.getDouble(28);
				double totalActCost = 	myRes.getDouble(29);
				String region = myRes.getString(30);
				long totalServiceMinutes = myRes.getLong(31); 
				long totalServiceLaborExpense = myRes.getLong(32);
				
				serviceList = new ServiceRequest(id, soCodeNo, prjctName, customer, consultant, location, type, initialRemarks, finalRemarks, estMaterialCost, estLaborCost, estOtherCost, actMaterialCost, actLaborCost, 
						actOtherCost, fldUsrID, fldUsrName, ofcUsrID, ofcUsrName, createdDate, intlStatus, fldStatus, 
						finalStatus, noOfVisits, totalEstCost, totalActCost, region, totalServiceMinutes, totalServiceLaborExpense);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	
	public List<ServiceRequest> getEntryVisitofServiceRquest(String serviceId, String fldUserEmpCode) throws SQLException {
		List<ServiceRequest> serviceList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJPORTAL.SERVICE_FLD_ENTRY WHERE   VISIT_HEAD_SYS_ID = ? AND FLD_STF_UID = ? ORDER BY VISIT_DETL_SYS_ID ASC";
			myStmt = myCon.prepareStatement(sql); 
			myStmt.setString(1, serviceId);
			myStmt.setString(2, fldUserEmpCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String serviceHeadId = myRes.getString(1);
				String fldVstId = myRes.getString(2);
				String fldUser = myRes.getString(3);
				String visitDate = myRes.getString(4);
				String checkIn = myRes.getString(5);
				String checkOut = myRes.getString(6);
				String visitRemarks = myRes.getString(7);
				int noOfAsstnc = myRes.getInt(8);
				int fldStatus = myRes.getInt(9);
				String createdDate = myRes.getString(10);
				int totMinutes = myRes.getInt(12);		
						
				ServiceRequest tempServiceList = new ServiceRequest(serviceHeadId, fldVstId, fldUser, visitDate, checkIn, checkOut, visitRemarks, noOfAsstnc, fldStatus, createdDate, totMinutes);
				serviceList.add(tempServiceList);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServiceRequest> getEntryVisitofServiceRquestForOffcStaff(String serviceId) throws SQLException {
		List<ServiceRequest> serviceList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM FJPORTAL.SERVICE_FLD_ENTRY WHERE   VISIT_HEAD_SYS_ID = ?  ORDER BY VISIT_DETL_SYS_ID ASC";
			myStmt = myCon.prepareStatement(sql); 
			myStmt.setString(1, serviceId);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String serviceHeadId = myRes.getString(1);
				String fldVstId = myRes.getString(2);
				String fldUser = myRes.getString(3);
				String visitDate = myRes.getString(4);
				String checkIn = myRes.getString(5);
				String checkOut = myRes.getString(6);
				String visitRemarks = myRes.getString(7);
				int noOfAsstnc = myRes.getInt(8);
				int fldStatus = myRes.getInt(9);
				String createdDate = myRes.getString(10);
				int totMinutes = myRes.getInt(12);
						
						
				ServiceRequest tempServiceList = new ServiceRequest(serviceHeadId, fldVstId, fldUser, visitDate, checkIn, checkOut, visitRemarks, noOfAsstnc, fldStatus, createdDate, totMinutes);
				serviceList.add(tempServiceList);
			}
			return serviceList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public ServicePortalStaffs insertNewFieldVisit(ServiceRequest visit_Details) {
		ServicePortalStaffs optnFlags = null;
		 // this part breaked to 2 , insert 6 parameter first, then 4
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			 return new ServicePortalStaffs(0, -2);
		PreparedStatement psmt = null;
		int retval = 0; 
		String generatedColumns[] = { "VISIT_DETL_SYS_ID" };
		StringBuilder sqlstr = new StringBuilder( "INSERT INTO FJPORTAL.SERVICE_FLD_ENTRY ");
		sqlstr.append( "( VISIT_HEAD_SYS_ID,  FLD_ASST_NOS, FLD_VISIT_DATE, FLD_STF_UID, FLD_STATUS, FLD_CR_DT )");
		sqlstr.append(" VALUES ( ?, ?, ?, ?, ?,  SYSDATE) ");
		
		//--ORIGINAL --//
		//sqlstr.append( "( VISIT_HEAD_SYS_ID, CHECK_IN_TIME, CHECK_OUT_TIME, VISIT_REMARK, FLD_ASST_NOS, FLD_VISIT_DATE, FLD_STF_UID, FLD_STATUS, TTL_VST_TIME_MNT, FLD_CR_DT )");
		//sqlstr.append(" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,  SYSDATE) ");
		try { 
			
			psmt = con.prepareStatement(sqlstr.toString(), generatedColumns);
			psmt.setString(1, visit_Details.getId());
			//psmt.setString(2, visit_Details.getCheckin());
			//psmt.setString(3, visit_Details.getCheckout());
			//psmt.setString(4, visit_Details.getFieldRemark());
			psmt.setInt(2, visit_Details.getNoOfAssistants());
			psmt.setDate(3, getSqlDate(visit_Details.getVisitDate()));
		   // psmt.setString(6, "");
			psmt.setString(4, visit_Details.getFieldUserId());
			psmt.setInt(5, visit_Details.getFldVisitStatus());
			//psmt.setInt(9, visit_Details.getTotMinutes());
			retval = psmt.executeUpdate();  			
			ResultSet rs = psmt.getGeneratedKeys();
			if (rs.next()) { 
				
				//System.out.println("LOG = "+retval+" GEN KEY = "+rs.getRow()+" "+rs.getLong(1));
				optnFlags = new ServicePortalStaffs(rs.getLong(1), retval);
			}

		} catch (SQLException e) {
			System.out.println("SERVICE REQST INSERT DB ERROR");
			e.printStackTrace();
			//retval = -2;
			optnFlags = new ServicePortalStaffs(0, -2);
			// DB error
		} finally {
			try {
				// if(rs!=null)
				// rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				//retval = -2;
				optnFlags = new ServicePortalStaffs(0, -2);
			}
		}
		//return retval;
		return optnFlags;
	}
	public int updateFieldVistStusInMasterTableForAll(long visitId, ServiceRequest visit_Details) {
  // this method due to ojdbc lower version more than 7 parameter not support issue when returning gen key
		int logType = -2; 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if(myCon == null) return -2;
			String sql = " UPDATE FJPORTAL.SERVICE_FLD_ENTRY   "
					+ " SET CHECK_IN_TIME  = ? , CHECK_OUT_TIME = ? ,  VISIT_REMARK = ?, TTL_VST_TIME_MNT = ?, HRLY_RATE = ? "
					+ " WHERE VISIT_HEAD_SYS_ID = ?  AND VISIT_DETL_SYS_ID = ? ";
			myStmt = myCon.prepareStatement(sql); 
			myStmt.setString(1, visit_Details.getCheckin());
			myStmt.setString(2, visit_Details.getCheckout());
			myStmt.setString(3, visit_Details.getFieldRemark()); 
			myStmt.setInt(4, visit_Details.getTotMinutes());
			myStmt.setInt(5, visit_Details.getFldEngnrHrlyRate());
			myStmt.setString(6, visit_Details.getId());
			myStmt.setLong(7, visitId);
			
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at the time updating fld vst master tble for secnd optn   status to "+logType+" for visit id"+visitId);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			//System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}
 
	public Date getSqlDate(String str) {
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date date;
		java.util.Date dt;
		try {
			dt = formatter.parse(str);
			//System.out.println(dt);
			date = new Date(dt.getTime());
		} catch (ParseException ex) { 
			ex.printStackTrace();
			date = null;
		}

		//System.out.println(date);
		return date;

	}
	public int updateFieldVistStusInMasterTable(String serviceId, int visitFinalStatus) {

		int logType = -2; 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if(myCon == null) return -2;
			
			String sql = " UPDATE FJPORTAL.SERVICE_OFC_ENTRY   "
					+ " SET FLD_STF_UPD_DT  = SYSDATE, FLD_VST_STATUS = ? "
					+ " WHERE VISIT_SYS_ID = ?  AND INTL_REQST_STATUS = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, visitFinalStatus);
			myStmt.setString(2, serviceId);
			myStmt.setInt(3, 1);
			
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at the time updating master service tbl status status to "+visitFinalStatus+" for service id"+serviceId);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			//System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}
 
	public int updateFinalRqstStusInMasterTable(int fldStatus, ServiceRequest finalRqst_Details) {

		int logType = -2; 
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if(myCon == null) return -2;
			
			String sql = " UPDATE FJPORTAL.SERVICE_OFC_ENTRY   "
					+ " SET  FLD_VST_STATUS = ?, FINL_REQST_STATUS =?, OFC_STF_UPD_DT = SYSDATE, OFC_STF_UPD_UID = ?, OFC_STF_CLOS_REMARKS = ?,  "
					+" ACT_MATERIAL_COST = ?, ACT_LABOUR_COST = ?, ACT_OTHER_COST = ? " 
					+ " WHERE VISIT_SYS_ID = ?  AND INTL_REQST_STATUS = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setInt(1, fldStatus);
			myStmt.setInt(2, finalRqst_Details.getFinalStatus());
			myStmt.setString(3, finalRqst_Details.getOfficeUserId());
			myStmt.setString(4, finalRqst_Details.getOfcFinalRemarks());
			myStmt.setDouble(5, finalRqst_Details.getActMaterialCost());
			myStmt.setDouble(6, finalRqst_Details.getActLaborCost());
			myStmt.setDouble(7, finalRqst_Details.getActOtherCost());
			myStmt.setString(8, finalRqst_Details.getId());
			myStmt.setInt(9, 1);
			
			logType = myStmt.executeUpdate();

		} catch (SQLException ex) {
			logType = -2;
			System.out.println("Exception in closing DB resources at the time updating master service tbl final status to "+finalRqst_Details.getId()+"");
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
			//System.out.println("Updated and closed db Successfully ");
		}
		return logType;
	}
	
	public ServiceRequest getHourlyRateFieldStaffs() throws SQLException { 
		String userDivision = "PP";
		int fielEngRate = 0 , fieldAsstRate =0 ;
		ServiceRequest hourlyRates = null;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT * FROM FJPORTAL.SERVICE_HOURLY_ALLWNCE WHERE DIVN_CODE = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, userDivision); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				
				String userType = myRes.getString(1); 
				switch(userType) {
				case "SE":// Field Engineer
						//System.out.println("FILED ENGINEER ");
						fielEngRate = myRes.getInt(2);
						break;
				case "FA": // Field Assistant
						//System.out.println("FILED STAFF");
						fieldAsstRate = myRes.getInt(2);
						break;
				default :
						//System.out.println("DEFAULT");
						fielEngRate = 0 ;
						fieldAsstRate =0 ;
						break;
				}
				
			}
			
			hourlyRates = new ServiceRequest(fielEngRate, fieldAsstRate);
			return hourlyRates;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	} 
	public String getEmailIdByEmpcode(String newempcode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS  " + 
				" WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1"; 
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
	public String getDmEmailIdByEmpcode(String newempcode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS " + "WHERE TXNFIELD_EMP_CODE = ("
				+ "SELECT TXNFIELD_FLD3 FROM FJPORTAL.PT_TXN_FLEX_FIELDS "
				+ "WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1"
				+ ") AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1"; 
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
	public String getFieldStaffNames(String employeeLists) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		StringBuilder mbody = new StringBuilder("");
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		mbody.append("");
		String sql = " SELECT   EMP_NAME  FROM PM_EMP_KEY " + 
				" WHERE EMP_CODE IN (" + employeeLists + ")AND EMP_FRZ_FLAG = ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, "N");
			rs = psmt.executeQuery();
			while (rs.next()) { 
				mbody.append(rs.getString(1)+", ");
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
				mbody.append("");
			}
		}
		return mbody.toString();
	}
	public int sendMailToFieldEngineer(ServiceRequest serviceDetails, String ccAddress ) {
		int logType = -2;
		EmailServiceRequest  sslmail = new EmailServiceRequest();
		String toAddress = getEmailIdByEmpcode(serviceDetails.getFieldUserId());
		
		if(toAddress != null) {
			if(ccAddress == null) ccAddress = "";
			String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
					+ "<tr>" + "<td align=\"left\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
					+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>"
					+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
					+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Service Portal</div>"
					+ "</td>" + "</tr>" + "<tr>"
					+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
					+ "<b>Dear "+serviceDetails.getFieldUserName()+",</b>"
					+ "<p>New service request has allocated to you by "+ serviceDetails.getOfficeUserName() +". <br/>Please take the necessary actions.<br/> "
					+ "<h4><u>Details</u></h4> " 
					+ "<b>SO-CODE :</b>  " + serviceDetails.getSoCodeNo() + "<br/>"
					+"<b>Project :</b>  " + serviceDetails.getProjectName() + "<br/>"
					+ "<b>Service Type :</b> <b style=\"color:blue;\"> " + serviceDetails.getVisitType() + "</b><br/>" 
					+"<b>Region :</b>  " + serviceDetails.getRegion() + "<br/>"
					+"<b>Location :</b>  " + serviceDetails.getLocation() + "<br/>"  
					+ "<b>Remarks :</b> <b style=\"color:blue;\"> " + serviceDetails.getOfcInitialRemarks() + "</b><br/>"
					+ "<br/>";
			sslmail.setToaddr(toAddress);
			sslmail.setCcaddr(ccAddress); 
			sslmail.setMessageSub(serviceDetails.getSoCodeNo()+" - "+serviceDetails.getVisitType()+" Request");
			sslmail.setMessagebody(msg);
			int status = sslmail.sendMail();
			if (status != 1) {

				System.out.print("Error in sending Mail to Field Engineer  status : "+ status);
			} else {
				System.out.print("Sent Mail to Field Engineer successfully, status : " + status);
			}
			logType = status;
		}
		
		return logType;
	}
	// TOTAL UNIQUE OR DISTINCT FLD STAFF COUNT PARTICIPATED IN PARTICULAR PERIOD
	public int getVisitedFieldStaffUniqueCount(ServiceReport filterOptions) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		int logType = 0;
		if (con == null)
			return logType;
		ResultSet rs = null;
		PreparedStatement psmt = null; 
		String sql = "";
	
		try {
			if(filterOptions.getFieldStaffList().equalsIgnoreCase("All")) { 
		/*	 sql = "  SELECT  COUNT(DISTINCT FLD_STF_UID) FROM (   " + 
			 		"  SELECT VISIT_HEAD_SYS_ID,FLD_STF_UID, FLD_VISIT_DATE, CHECK_IN_TIME,CHECK_OUT_TIME , TTL_VST_TIME_MNT, HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ENTRY    " + 
			 		" WHERE  FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY')  " + 
			 		" UNION ALL   " + 
			 		"  SELECT VISIT_DETL_SYS_ID,FLD_ASSTNT_UID, FLD_VISIT_DATE, CHECK_IN_TIME, CHECK_OUT_TIME, TTL_VST_TIME_MNT,HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS     " + 
			 		"  WHERE VISIT_DETL_SYS_ID IN (SELECT VISIT_DETL_SYS_ID from FJPORTAL.SERVICE_FLD_ENTRY     " + 
			 		"  WHERE  FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY') )   " + 
			 		" )T1";
			 */
				sql = " SELECT SUM(FLD_STF_COUNT) FROM (  " + 
						"  SELECT  FLD_VISIT_DATE, COUNT( DISTINCT FLD_STF_UID) FLD_STF_COUNT FROM (    " + 
						"  SELECT VISIT_HEAD_SYS_ID,FLD_STF_UID, FLD_VISIT_DATE, CHECK_IN_TIME,CHECK_OUT_TIME , TTL_VST_TIME_MNT, HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ENTRY     " + 
						" WHERE  FLD_VISIT_DATE >= TO_DATE(?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY') AND FLD_STF_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ?)   " + 
						" UNION ALL    " + 
						"  SELECT VISIT_DETL_SYS_ID,FLD_ASSTNT_UID, FLD_VISIT_DATE, CHECK_IN_TIME, CHECK_OUT_TIME, TTL_VST_TIME_MNT,HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS      " + 
						"  WHERE VISIT_DETL_SYS_ID IN (SELECT VISIT_DETL_SYS_ID from FJPORTAL.SERVICE_FLD_ENTRY      " + 
						"  WHERE  FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE(?, 'DD/MM/YYYY') )   AND FLD_ASSTNT_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ?) " + 
						" )T1  " + 
						" GROUP BY FLD_VISIT_DATE  " + 
						" ORDER BY FLD_VISIT_DATE ASC  " + 
						" ) T2";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, filterOptions.getStartDate());
				psmt.setString(2, filterOptions.getToDate());
				psmt.setString(3, "FU"); 
				psmt.setString(4, filterOptions.getDivision());
				psmt.setString(5, filterOptions.getStartDate());
				psmt.setString(6, filterOptions.getToDate()); 
				psmt.setString(7, "FU"); 
				psmt.setString(8, filterOptions.getDivision());
			}else { 
				sql = " SELECT SUM(FLD_STF_COUNT) FROM (  " + 
						"  SELECT  FLD_VISIT_DATE, COUNT( DISTINCT FLD_STF_UID) FLD_STF_COUNT FROM (    " + 
						"  SELECT VISIT_HEAD_SYS_ID,FLD_STF_UID, FLD_VISIT_DATE, CHECK_IN_TIME,CHECK_OUT_TIME , TTL_VST_TIME_MNT, HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ENTRY     " + 
						" WHERE  FLD_VISIT_DATE >= TO_DATE(?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY')   " + 
						" AND FLD_STF_UID in (?) "+ 
						" UNION ALL    " + 
						"  SELECT VISIT_DETL_SYS_ID,FLD_ASSTNT_UID, FLD_VISIT_DATE, CHECK_IN_TIME, CHECK_OUT_TIME, TTL_VST_TIME_MNT,HRLY_RATE  FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS      " + 
						"  WHERE VISIT_DETL_SYS_ID IN (SELECT VISIT_DETL_SYS_ID from FJPORTAL.SERVICE_FLD_ENTRY      " + 
						"  WHERE  FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE(?, 'DD/MM/YYYY') "+
						"  AND FLD_ASSTNT_UID in (?) "+ 
						"))T1  " + 
						" GROUP BY FLD_VISIT_DATE  " + 
						" ORDER BY FLD_VISIT_DATE ASC  " + 
						" ) T2";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, filterOptions.getStartDate());
				psmt.setString(2, filterOptions.getToDate());
				psmt.setString(3, filterOptions.getStartDate());
				psmt.setString(4, filterOptions.getToDate());
				psmt.setString(5,filterOptions.getFieldStaffList());
			}
			
			rs = psmt.executeQuery();
			while (rs.next()) { 
				logType = rs.getInt(1);
			}
		} catch (Exception e) {
			logType = 0;
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
				logType = 0;
			}
		}
		return logType;
	}
	// SERVICE REPORTS DASHBOARD  QUERY
	public List<ServiceReport> getSeriveReportTableForCustDate(ServiceReport filterOptions) throws SQLException { 
		List<ServiceReport> reportList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String sql = "";
		try {
			myCon = orcl.getOrclConn();
		if(filterOptions.getFieldStaffList().equalsIgnoreCase("All")) {
		   sql = " SELECT  T2.VISIT_TYPE, "+   
					" COALESCE(COUNT(T1.VISIT_TYPE),0)  as totalServiceCall, "+   
					" COALESCE(SUM(T1.TOTAL_COUNT),0) as totalServiceVisit, "+  
					" COALESCE(SUM(T1.TOT_MAN_POWER),0) as totalManPowers, "+  
					" COALESCE(SUM(T1.TOT_SERVICE_HRS),0) as totalServiceHrs, "+  
					" COALESCE(SUM(T1.ACT_TOT_COST),0) as totalIncurredCost, "+
					" COALESCE(SUM(T1.ACT_OTHER_COST),0) as totalOtherExpCost "+  
					" FROM FJPORTAL.SERVICE_RQSTS_DTLS_RPRT_VIEW T1 "+  
					" RIGHT JOIN  FJPORTAL.VISIT_TYPE  T2 "+  
					" ON T1.VISIT_TYPE =  T2.VISIT_TYPE    "+  
					" AND ( "+
					"T1.VISIT_SYS_ID IN (SELECT  VISIT_HEAD_SYS_ID FROM FJPORTAL.SERVICE_FLD_ENTRY WHERE FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY') )"+ 
					" OR T1.VISIT_SYS_ID IN (SELECT  VISIT_DETL_SYS_ID FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS WHERE FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY') ) "+
					")"+
					" AND T1.FLD_STF_UID IN (SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE WHERE  USER_TYPE = ?    AND  DIVN = ? )   " + 					
					" GROUP BY T2.VISIT_TYPE  "+  
					" ORDER BY 1 ";
		    myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, filterOptions.getStartDate());
			myStmt.setString(2, filterOptions.getToDate());
			myStmt.setString(3, filterOptions.getStartDate());
			myStmt.setString(4, filterOptions.getToDate());
			myStmt.setString(5, "FU");
			myStmt.setString(6, filterOptions.getDivision());
		}else {
			  sql = " SELECT  T2.VISIT_TYPE, "+   
						" COALESCE(COUNT(T1.VISIT_TYPE),0)  as totalServiceCall, "+   
						" COALESCE(SUM(T1.TOTAL_COUNT),0) as totalServiceVisit, "+  
						" COALESCE(SUM(T1.TOT_MAN_POWER),0) as totalManPowers, "+  
						" COALESCE(SUM(T1.TOT_SERVICE_HRS),0) as totalServiceHrs, "+  
						" COALESCE(SUM(T1.ACT_TOT_COST),0) as totalIncurredCost, "+
						" COALESCE(SUM(T1.ACT_OTHER_COST),0) as totalOtherExpCost "+  
						" FROM FJPORTAL.SERVICE_RQSTS_DTLS_RPRT_VIEW T1 "+  
						" RIGHT JOIN  FJPORTAL.VISIT_TYPE  T2 "+  
						" ON T1.VISIT_TYPE =  T2.VISIT_TYPE    "+  
						" AND ( "+
						"T1.VISIT_SYS_ID IN (SELECT  VISIT_HEAD_SYS_ID FROM FJPORTAL.SERVICE_FLD_ENTRY WHERE FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY') )"+ 
						" OR T1.VISIT_SYS_ID IN (SELECT  VISIT_DETL_SYS_ID FROM FJPORTAL.SERVICE_FLD_ASSTNT_VISITS WHERE FLD_VISIT_DATE >= TO_DATE( ?, 'DD/MM/YYYY') AND  FLD_VISIT_DATE <= TO_DATE( ?, 'DD/MM/YYYY') ) "+
						")"+
						" AND FLD_STF_UID in (?) "+  
						" GROUP BY T2.VISIT_TYPE  "+  
						" ORDER BY 1 "    ;	
			    myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, filterOptions.getStartDate());
				myStmt.setString(2, filterOptions.getToDate());
				myStmt.setString(3, filterOptions.getStartDate());
				myStmt.setString(4, filterOptions.getToDate());
				myStmt.setString(5, filterOptions.getFieldStaffList());
			}	
			
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String type = myRes.getString(1);
				int totalServices = myRes.getInt(2);
				int totalVisits = myRes.getInt(3);
				int totalManPowers = myRes.getInt(4);
				double TotalHrs = myRes.getDouble(5);
				double totalCost = myRes.getDouble(6); 
				double totalOtherExp = myRes.getDouble(7); 
				ServiceReport tempReportList = new ServiceReport(type, totalServices, totalVisits, totalManPowers, TotalHrs, totalCost, totalOtherExp );
				reportList.add(tempReportList);
			}
			return reportList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServicePortalReportStaffs> getDivisionList(String userType, String empCode) throws SQLException {  
		List<ServicePortalReportStaffs> fieldStaffList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String sql = "";
		try {

			myCon = orcl.getOrclConn(); 
			if(userType.equals("MU")) {
				 sql = "   SELECT DISTINCT DIVN " + 
					  		"  FROM SERVICE_FLDSTAFF_ALLWNCE    " +  
					  		"  WHERE ACTV_YN = ?     ";
						myStmt = myCon.prepareStatement(sql); 
						myStmt.setString(1, "Y");
			}else {
				 sql = "   SELECT  DIVN_CODE " + 
					  		"  FROM SERVICE_USER     " +  
					  		"  WHERE EMPID = ?  AND ROWNUM = 1    ";
						myStmt = myCon.prepareStatement(sql); 
						myStmt.setString(1, empCode);
			}
				 
					
					
			myRes = myStmt.executeQuery();
			while (myRes.next()) { 
				 String division = myRes.getString(1); 
				ServicePortalReportStaffs tempFieldStaffList = new ServicePortalReportStaffs(  division);
				fieldStaffList.add(tempFieldStaffList);
			}
			return fieldStaffList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	public List<ServicePortalReportStaffs> getFieldEngineers(String employeeCode, String userType, ServiceReport filterOptions) throws SQLException {  
		List<ServicePortalReportStaffs> fieldStaffList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String sql = "";
		try {

			myCon = orcl.getOrclConn();
			if(userType.equalsIgnoreCase("MU")) {
				  sql = "   SELECT EMP_CODE, EMP_NAME, DIVN " + 
				  		"  FROM SERVICE_FLDSTAFF_ALLWNCE    " + 
				  		"  RIGHT JOIN PM_EMP_KEY    " + 
				  		"  ON EMPID = EMP_CODE AND  EMP_FRZ_FLAG = ? AND ACTV_YN = ?   " + 
				  		"  WHERE  USER_TYPE = ?  AND  DIVN = ? ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, "N");
					myStmt.setString(2, "Y"); 
					myStmt.setString(3, "FU"); 
					myStmt.setString(4, filterOptions.getDivision()); 
			}else {
				  sql = " SELECT EMP_CODE, EMP_NAME, DIVN  FROM PM_EMP_KEY  " + 
							"  WHERE EMP_CODE IN ( SELECT DISTINCT EMPID  FROM SERVICE_FLDSTAFF_ALLWNCE " + 
							"  WHERE  USER_TYPE = ?  AND ACTV_YN = ? AND  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 ) ) AND EMP_FRZ_FLAG = ? ";
				  
				  sql = "   SELECT EMP_CODE, EMP_NAME, DIVN " + 
					  		"  FROM SERVICE_FLDSTAFF_ALLWNCE    " + 
					  		"  RIGHT JOIN PM_EMP_KEY    " + 
					  		"  ON EMPID = EMP_CODE AND  EMP_FRZ_FLAG = ? AND ACTV_YN = ?   " + 
					  		"  WHERE  USER_TYPE = ?    AND  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )  ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, "N");
					myStmt.setString(2, "Y"); 
					myStmt.setString(3, "FU");
					myStmt.setString(4, employeeCode);  
			}
		 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empCode = myRes.getString(1); 
				String empName = myRes.getString(2);  
				 String division = myRes.getString(3); 
				ServicePortalReportStaffs tempFieldStaffList = new ServicePortalReportStaffs(empCode, empName, division);
				fieldStaffList.add(tempFieldStaffList);
			}
			return fieldStaffList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	
	
	public List<ServicePortalStaffs> getFieldAssistants(String employeeCode) throws SQLException {  
		List<ServicePortalStaffs> fieldStaffList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {

			myCon = orcl.getOrclConn();
			String sql = "  SELECT EMP_CODE, EMP_NAME, HRLY_RATE  " + 
					"  FROM SERVICE_FLDSTAFF_ALLWNCE " + 
					"  RIGHT JOIN PM_EMP_KEY " + 
					"  ON EMPID = EMP_CODE AND  EMP_FRZ_FLAG = ? AND ACTV_YN = ? " + 
					"  WHERE  USER_TYPE = ? AND  DIVN = ( SELECT DIVN_CODE FROM SERVICE_USER  WHERE EMPID = ? AND ROWNUM =1 )  ";
			myStmt = myCon.prepareStatement(sql); 
			myStmt.setString(1, "N"); 
			myStmt.setString(2, "Y"); 
			myStmt.setString(3, "FU"); 
			myStmt.setString(4, employeeCode); 
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String empCode = myRes.getString(1); 
				String empName = myRes.getString(2);
				int hourlyRate = myRes.getInt(3);  
				ServicePortalStaffs tempFieldStaffList = new ServicePortalStaffs(empCode, empName, hourlyRate);
				fieldStaffList.add(tempFieldStaffList);
			}
			return fieldStaffList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
			public List<ServiceReport> getHolidayListforCustomeDateRange(ServiceReport filterOptions) throws SQLException {
				// Custome holidays in between dates 
				List<ServiceReport> holidaysList = new ArrayList<>();
				Connection myCon = null;
				PreparedStatement myStmt = null;
				ResultSet myRes = null;
				MysqlDBConnectionPool con = new MysqlDBConnectionPool();
				try {

					myCon = con.getMysqlConn();
					String sql = "select distinct hday from  holidays where hday  between ? and ?  and company_code= '001' and status=1";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, formatMysqlDate(filterOptions.getStartDate()));
					myStmt.setString(2, formatMysqlDate(filterOptions.getToDate())); 
					myRes = myStmt.executeQuery();
					while (myRes.next()) {
						String hday = myRes.getString(1); 
						ServiceReport tempHolidayList = new ServiceReport(hday);
						holidaysList.add(tempHolidayList);
					}
					return holidaysList;
				} finally {
					// close jdbc objects
					close(myStmt, myRes);
					con.closeConnection();
				}
			}
			private String formatMysqlDate(String dateValue) {
				String formattedDate = "";
				String[] tempArray;
				String delimiter = "/";
				tempArray = dateValue.split(delimiter);
				String[] newArray = new String[3];
				for (int i = 0, j = 2; i <= 2; i++) {
					// System.out.println(tempArray[i] +" j = "+j);
					newArray[j] = tempArray[i];
					j--;
				}

				formattedDate = Arrays.toString(newArray);
				formattedDate = formattedDate.substring(1, formattedDate.length() - 1).replace(", ", "-");
				// System.out.println(formattedDate);
              //  System.out.println(" Date -fmt"+formattedDate);
				return formattedDate;

			}
			public int updateAssitantVstsTxn(long visitId, String visitDate, List<ServicePortalStaffs> assistantVisitsList) {
				/*
				 for (CustomerVisit visits : this.visitData){
				    	
				        System.out.println( "ID : "+visits.getId() + "Document : " + visits.getDocumentId() + " Project : " + visits.getProject()+" F-T : "+visits.getFromTime()+" - "+visits.getToTime()+" Description : "+visits.getActnDesc());
				    }
				*/  
				int logCount = 0;
			//	System.out.println(" VISIT LIST LENGTH =  "+assistantVisitsList.size()+" visit id "+visitId+" "+visitDate);
				if(assistantVisitsList != null && assistantVisitsList.size() > 0) {				
						Connection myCon = null;
						PreparedStatement myStmt = null;
						ResultSet myRes = null;
						OrclDBConnectionPool orcl = new OrclDBConnectionPool(); 
						Iterator<ServicePortalStaffs> iterator = assistantVisitsList.iterator();
						try {
							myCon = orcl.getOrclConn();
							String sql = " INSERT  INTO FJPORTAL.SERVICE_FLD_ASSTNT_VISITS(VISIT_DETL_SYS_ID, FLD_ASSTNT_UID, FLD_VISIT_DATE, CHECK_IN_TIME, CHECK_OUT_TIME, TTL_VST_TIME_MNT,  HRLY_RATE, CR_DT) "
									+ " VALUES(?, ?, ?, ?, ?, ?, ?, SYSDATE) ";
							myStmt = myCon.prepareStatement(sql);
							myCon.setAutoCommit(false);
		
							while (iterator.hasNext()) { 
								ServicePortalStaffs theVisitData = (ServicePortalStaffs) iterator.next();
		
								myStmt.setLong(1, visitId);
								myStmt.setString(2, theVisitData.getFldStaffCode());  
								myStmt.setDate(3, getSqlDate(visitDate));
								myStmt.setString(4, theVisitData.getChkIn());
								myStmt.setString(5, theVisitData.getChkOut());
								myStmt.setInt(6, theVisitData.getTtim());
								myStmt.setInt(7, theVisitData.getHourlyRate());  
		
								myStmt.addBatch();
							}
		
							// Create an int[] to hold returned values
							int[] affectedRecords = myStmt.executeBatch();  
							myCon.commit();
							logCount = affectedRecords.length;
							System.out.println("Assiitant field visit count after insert  =  " + logCount+" expected count = "+assistantVisitsList.size());
		
						} catch (SQLException e) {

							e.printStackTrace();
							if (myCon != null) {
								try {
									// STEP 3 - Roll back transaction
									System.out.println("Transaction is being rolled back. Service Field Assitant Visit assitant entry insertion" +logCount );
									myCon.rollback();
									logCount = 0;
								} catch (Exception ex) {
									ex.printStackTrace();
								}
							}

						}  finally {
							close(myStmt, myRes);
							orcl.closeConnection();
						}
						return logCount;
					}else {
						return logCount;
					}
				
			}
			public String getDefaultDivisionForManager(String empCode) {
				OrclDBConnectionPool orcl = new OrclDBConnectionPool();
				Connection con = orcl.getOrclConn();
				if (con == null)
					return null;
				ResultSet rs = null;
				PreparedStatement psmt = null;
				String retval = null;
				String sqlstr = " select DISTINCT DIVN_CODE from FJPORTAL.SERVICE_USER WHERE EMPID = ?  AND ROWNUM = 1 "; 
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
}
