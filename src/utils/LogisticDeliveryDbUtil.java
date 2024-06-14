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
import java.util.List; 
import beans.EmailLogistic; 
import beans.Logistic;
import beans.LogisticDelivery;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool; 

public class LogisticDeliveryDbUtil {
	   
		public List<LogisticDelivery> getCompleteDeliveryDetails(String divnCode, String deliveryType) throws SQLException { 
			String orderCodition = "";
			String  sql = "SELECT FJ_INVH_SYS_ID, FJ_INVH_TXN_CODE, FJ_INVH_NO,  FJ_INVH_DATE, FJ_INVH_CUST_CODE, FJ_INVH_CUST_NAME, FJ_INVH_PROJ, "
					+ "FJ_INVH_PMT_TERMS, FJ_INVH_PMT_STAT,  FJ_INVH_CONT_NAME,  FJ_INVH_CONT_NUM, FJ_INVH_SITE_LOCN, FJ_INVH_EXP_DEL_DT, FJ_INVH_VEH_DET, FJ_INVH_DIVN_REMARKS,   " + 
					"FJ_INVH_DIVN_UPD_BY, (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_DIVN_UPD_BY AND ROWNUM = 1 ) DIV_EMP_NAME, FJ_INVH_DIVN_UPD_DT,    " + 
					"FJ_INVH_FIN_APPR, FJ_INVH_FIN_REMARKS, FJ_INVH_FIN_UPD_BY,  (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_FIN_UPD_BY AND ROWNUM = 1 ) FIN_EMP_NAME, FJ_INVH_FIN_UPD_DT,    " + 
					"FJ_INVH_LOG_APPR, FJ_INVH_LOG_REMARKS,  " + 
					"FJ_INVH_LOG_UPD_BY,  (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_LOG_UPD_BY AND ROWNUM = 1 ) LOG_EMP_NAME, FJ_INVH_LOG_UPD_DT   " + 
					"FROM FJPORTAL.INV_DB_TXN ";
			if(divnCode.equalsIgnoreCase("FN")) { 
				orderCodition = " FJ_INVH_EXP_DEL_DT ASC";
				if(deliveryType.equalsIgnoreCase("Y")) {
				 sql +=  "WHERE  FJ_INVH_FIN_APPR = 'OK'  AND FJ_INVH_DIVN_UPD_BY IS NOT NULL "
						+ " ORDER BY  "+orderCodition+" ";
				}else {
					sql +=  "WHERE  ( NVL(FJ_INVH_FIN_UPD_BY,'N') = '"+deliveryType+"' AND FJ_INVH_DIVN_UPD_BY IS NOT  NULL ) OR (FJ_INVH_FIN_APPR = 'NOT OK' AND FJ_INVH_FIN_UPD_BY IS NOT  NULL AND  FJ_INVH_DIVN_UPD_BY IS NOT  NULL ) "
							+ " ORDER BY  "+orderCodition+" ";
				}
			}else if(divnCode.equalsIgnoreCase("LG")) {
				orderCodition = " FJ_INVH_EXP_DEL_DT ASC";
				sql +=  "WHERE NVL(FJ_INVH_LOG_APPR,'N') = '"+deliveryType+"' AND FJ_INVH_FIN_UPD_BY IS NOT NULL AND FJ_INVH_FIN_APPR = 'OK' "
						+ " ORDER BY  "+orderCodition+" ";
			}else {
				orderCodition = " FJ_INVH_SYS_ID ASC";
				sql +=   "WHERE NVL(FJ_INVH_LOG_APPR,'N') = '"+deliveryType+"' "
						+ " ORDER BY  "+orderCodition+" ";
			}
			
			
			List<LogisticDelivery> deliveryList = new ArrayList<>(); 
			Connection myCon = null;
			Statement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn(); 
				myStmt = myCon.createStatement();
				myRes = myStmt.executeQuery(sql);
				while (myRes.next()) {			
					String  id = encrypt(myRes.getString(1)); 	
					String  txnCode = myRes.getString(2); 
					String  invcNumber = myRes.getString(3); 
					String  invcDate = myRes.getString(4); 
					String  customerCode = myRes.getString(5); 
					String  customername = myRes.getString(6); 
					String  project = myRes.getString(7); 
					
					String  paymentTerms = myRes.getString(8); 
					String  paymentStatus = myRes.getString(9); 
					String  contactName = myRes.getString(10); 
					String  contactNumber = myRes.getString(11); 
					String  siteLocation = myRes.getString(12); 
					String  expectedDeliveryDate = myRes.getString(13); 
					String  numberOfvehicleRequired = myRes.getString(14); 
					String  divnRemarks = myRes.getString(15); 
					String  divnUpdatedBy = myRes.getString(16); 
					String  divnEmpName = myRes.getString(17); 
					String  divnUpdatedDate = myRes.getString(18); 
					
					String  finStatus =  myRes.getString(19);
					String  finRemarks = myRes.getString(20); 
					String  finUpdatedBy = myRes.getString(21); 
					String  finEmpName= myRes.getString(22); 
					String  finUpdatedDate= myRes.getString(23); 
					
					String  logisticApproved = myRes.getString(24); 
					String  logisticRemark = myRes.getString(25); 
					String  logisticUpdBy = myRes.getString(26); 
					String  logEmpName = myRes.getString(27); 
					String  logisticUpdDate = myRes.getString(28);  
					
					LogisticDelivery tempDeliveryList = new LogisticDelivery(id,txnCode ,invcNumber ,invcDate ,customerCode,customername ,project, paymentTerms ,paymentStatus,
							contactName ,contactNumber ,siteLocation ,expectedDeliveryDate ,numberOfvehicleRequired, divnRemarks 
							,divnUpdatedBy ,divnEmpName ,divnUpdatedDate ,finStatus ,finRemarks,finUpdatedBy 
							,finEmpName, finUpdatedDate, logisticApproved ,logisticRemark ,logisticUpdBy ,logEmpName ,logisticUpdDate  );
					deliveryList.add(tempDeliveryList); 
				}
				return deliveryList;
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
			}
		}
		public List<LogisticDelivery> getDeliveryDetailsforTXNCode(String empCode, String deliveryType) throws SQLException {   
			List<LogisticDelivery> deliveryList = new ArrayList<>();  
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				String sql = "SELECT FJ_INVH_SYS_ID, FJ_INVH_TXN_CODE, FJ_INVH_NO,  FJ_INVH_DATE, FJ_INVH_CUST_CODE, FJ_INVH_CUST_NAME, FJ_INVH_PROJ, FJ_INVH_PMT_TERMS, " + 
						"FJ_INVH_PMT_STAT,  FJ_INVH_CONT_NAME,  FJ_INVH_CONT_NUM, FJ_INVH_SITE_LOCN, FJ_INVH_EXP_DEL_DT, FJ_INVH_VEH_DET, FJ_INVH_DIVN_REMARKS,   " + 
						"FJ_INVH_DIVN_UPD_BY, (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_DIVN_UPD_BY AND ROWNUM = 1 ) DIV_EMP_NAME, FJ_INVH_DIVN_UPD_DT,    " + 
						"FJ_INVH_FIN_APPR, FJ_INVH_FIN_REMARKS, FJ_INVH_FIN_UPD_BY,  (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_FIN_UPD_BY AND ROWNUM = 1 ) FIN_EMP_NAME, FJ_INVH_FIN_UPD_DT,    " + 
						"FJ_INVH_LOG_APPR, FJ_INVH_LOG_REMARKS,  " + 
						"FJ_INVH_LOG_UPD_BY,  (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_LOG_UPD_BY AND ROWNUM = 1 ) LOG_EMP_NAME,FJ_INVH_LOG_UPD_DT   " + 
						"FROM FJPORTAL.INV_DB_TXN  " + 
						"WHERE REGEXP_LIKE (FJ_INVH_TXN_CODE, (SELECT LISTAGG(INV_CODE,'|') WITHIN GROUP (ORDER BY INV_CODE) list FROM DEL_DB_DIVN_EMP   WHERE EMP_CODE = ? ), 'i') " + 
						 "AND  NVL(FJ_INVH_LOG_APPR,'N')= ?  " + 
						"ORDER BY   FJ_INVH_EXP_DEL_DT ASC";  
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, empCode); 
				myStmt.setString(2, deliveryType); 
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					String  id = encrypt(myRes.getString(1)); 	
					String  txnCode = myRes.getString(2); 
					String  invcNumber = myRes.getString(3); 
					String  invcDate = myRes.getString(4); 
					String  customerCode = myRes.getString(5); 
					String  customername = myRes.getString(6); 
					String  project = myRes.getString(7); 
					String  paymentTerms = myRes.getString(8); 
					String  paymentStatus = myRes.getString(9); 
					String  contactName = myRes.getString(10); 
					String  contactNumber = myRes.getString(11); 
					String  siteLocation = myRes.getString(12); 
					String  expectedDeliveryDate = myRes.getString(13); 
					String  numberOfvehicleRequired = myRes.getString(14); 
					String  divnRemarks = myRes.getString(15); 
					String  divnUpdatedBy = myRes.getString(16); 
					String  divnEmpName = myRes.getString(17); 
					String  divnUpdatedDate = myRes.getString(18); 
					String  finStatus =  myRes.getString(19); 
					String  finRemarks = myRes.getString(20); 
					String  finUpdatedBy = myRes.getString(21); 
					String  finEmpName= myRes.getString(22); 
					String  finUpdatedDate= myRes.getString(23); 
					String  logisticApproved = myRes.getString(24); 
					String  logisticRemark = myRes.getString(25); 
					String  logisticUpdBy = myRes.getString(26); 
					String  logEmpName = myRes.getString(27); 
					String  logisticUpdDate = myRes.getString(28);  
					LogisticDelivery tempDeliveryList = new LogisticDelivery(id,txnCode ,invcNumber ,invcDate ,customerCode,customername ,project, paymentTerms ,paymentStatus,
							contactName ,contactNumber ,siteLocation ,expectedDeliveryDate ,numberOfvehicleRequired, divnRemarks 
							,divnUpdatedBy ,divnEmpName ,divnUpdatedDate ,finStatus ,finRemarks,finUpdatedBy 
							,finEmpName, finUpdatedDate, logisticApproved ,logisticRemark ,logisticUpdBy ,logEmpName ,logisticUpdDate  );
					deliveryList.add(tempDeliveryList); 
				}
				return deliveryList;
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
			}
		}
		public List<LogisticDelivery> getDeliveryDetailsforTXNCodeForDM(String dmCode, String deliveryType) throws SQLException {   
			List<LogisticDelivery> deliveryList = new ArrayList<>();  
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {  
				myCon = orcl.getOrclConn();
				String sql = "SELECT FJ_INVH_SYS_ID, FJ_INVH_TXN_CODE, FJ_INVH_NO,  FJ_INVH_DATE, FJ_INVH_CUST_CODE, FJ_INVH_CUST_NAME, FJ_INVH_PROJ, FJ_INVH_PMT_TERMS, " + 
						"FJ_INVH_PMT_STAT,  FJ_INVH_CONT_NAME,  FJ_INVH_CONT_NUM, FJ_INVH_SITE_LOCN, FJ_INVH_EXP_DEL_DT, FJ_INVH_VEH_DET, FJ_INVH_DIVN_REMARKS,   " + 
						"FJ_INVH_DIVN_UPD_BY, (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_DIVN_UPD_BY AND ROWNUM = 1 ) DIV_EMP_NAME, FJ_INVH_DIVN_UPD_DT,    " + 
						"FJ_INVH_FIN_APPR, FJ_INVH_FIN_REMARKS, FJ_INVH_FIN_UPD_BY,  (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_FIN_UPD_BY AND ROWNUM = 1 ) FIN_EMP_NAME, FJ_INVH_FIN_UPD_DT,    " + 
						"FJ_INVH_LOG_APPR, FJ_INVH_LOG_REMARKS,  " + 
						"FJ_INVH_LOG_UPD_BY,  (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = FJ_INVH_LOG_UPD_BY AND ROWNUM = 1 ) LOG_EMP_NAME,FJ_INVH_LOG_UPD_DT   " + 
						"FROM FJPORTAL.INV_DB_TXN  " + 
						"WHERE REGEXP_LIKE (FJ_INVH_TXN_CODE, (SELECT LISTAGG(INV_CODE,'|') WITHIN GROUP (ORDER BY INV_CODE) list FROM DEL_DB_DIVN_EMP   WHERE DM_CODE = ? ), 'i') " + 
						"AND  NVL(FJ_INVH_LOG_APPR,'N')= ?  " + 
						"ORDER BY   FJ_INVH_EXP_DEL_DT ASC";  
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dmCode); 
				myStmt.setString(2, deliveryType); 
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					String  id = encrypt(myRes.getString(1)); 	
					String  txnCode = myRes.getString(2); 
					String  invcNumber = myRes.getString(3); 
					String  invcDate = myRes.getString(4); 
					String  customerCode = myRes.getString(5); 
					String  customername = myRes.getString(6); 
					String  project = myRes.getString(7); 
					String  paymentTerms = myRes.getString(8); 
					String  paymentStatus = myRes.getString(9); 
					String  contactName = myRes.getString(10); 
					String  contactNumber = myRes.getString(11); 
					String  siteLocation = myRes.getString(12); 
					String  expectedDeliveryDate = myRes.getString(13); 
					String  numberOfvehicleRequired =  myRes.getString(14); 
					String  divnRemarks = myRes.getString(15); 
					String  divnUpdatedBy = myRes.getString(16); 
					String  divnEmpName = myRes.getString(17); 
					String  divnUpdatedDate = myRes.getString(18); 
					String  finStatus =  myRes.getString(19);
					String  finRemarks = myRes.getString(20); 
					String  finUpdatedBy = myRes.getString(21); 
					String  finEmpName= myRes.getString(22); 
					String  finUpdatedDate= myRes.getString(23); 
					String  logisticApproved = myRes.getString(24); 
					String  logisticRemark = myRes.getString(25); 
					String  logisticUpdBy = myRes.getString(26); 
					String  logEmpName = myRes.getString(27); 
					String  logisticUpdDate = myRes.getString(28);  
					LogisticDelivery tempDeliveryList = new LogisticDelivery(id,txnCode ,invcNumber ,invcDate ,customerCode,customername ,project, paymentTerms ,paymentStatus,
							contactName ,contactNumber ,siteLocation ,expectedDeliveryDate ,numberOfvehicleRequired, divnRemarks 
							,divnUpdatedBy ,divnEmpName ,divnUpdatedDate ,finStatus ,finRemarks,finUpdatedBy 
							,finEmpName, finUpdatedDate, logisticApproved ,logisticRemark ,logisticUpdBy ,logEmpName ,logisticUpdDate  );
					deliveryList.add(tempDeliveryList); 
				}
				return deliveryList;
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
			}
		}
		public List<LogisticDelivery> getRemarksHistory(String dlvyId) throws SQLException {  
			String id = decrypt(dlvyId); 
			List<LogisticDelivery> remarksList = new ArrayList<>(); 
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {  
				myCon = orcl.getOrclConn();
				String sql = "SELECT REM_SYS_ID, REM_INVH_SYS_ID, REM_REMARKS, (SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE = REM_INVH_CR_UID AND ROWNUM = 1 ) EMP_NAME, REM_INVH_CR_DT ,REM_ACTION_BY FROM INV_REMARK " + 
						"WHERE  REM_INVH_SYS_ID = ?    " + 
						"ORDER BY   REM_INVH_CR_DT DESC";  
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, id);  
				myRes = myStmt.executeQuery();
				while (myRes.next()) { 	
					String  remarksId = myRes.getString(1);
					String  deliveryId = myRes.getString(2); 
					String  remarks = myRes.getString(3);  
					String  createdBy = myRes.getString(4); 
					String  createdDate = myRes.getString(5);  
					String  action = getActionDescription(myRes.getString(6));  
					LogisticDelivery tempRemark  = new LogisticDelivery(remarksId, deliveryId, remarks, createdBy, createdDate, action);
					remarksList.add(tempRemark); 
				}
				return remarksList;
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
			}
		}
		private String getActionDescription(String action) {
			String description = "";
			switch(action) {
			case "LG":
				description = "Logistics";
				break;
			case "DV":
				description = "Divsion";
				break;
			case "FN":
				description = "Finance";
				break;
			default:
				break;
			}
			return description;
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
		public int updateDeliveryDetailsByDivision(LogisticDelivery dlvryDetails) {
			String id = decrypt(dlvryDetails.getId());
			int logType = -2; 
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				if(myCon == null) return -2;
				
				String sql = " UPDATE FJPORTAL.INV_DB_TXN   "
						+ " SET FJ_INVH_PMT_TERMS = ? , FJ_INVH_PMT_STAT = ?,  FJ_INVH_CONT_NAME = ?,  FJ_INVH_CONT_NUM = ?, FJ_INVH_SITE_LOCN = ?, FJ_INVH_EXP_DEL_DT = ?, "
						+ "FJ_INVH_VEH_DET = ?, FJ_INVH_DIVN_REMARKS =?, FJ_INVH_DIVN_UPD_BY = ?, FJ_INVH_DIVN_UPD_DT = SYSDATE "
						+ " WHERE FJ_INVH_SYS_ID = ?  AND NVL(FJ_INVH_LOG_APPR,'N')='N' ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dlvryDetails.getPaymentTerms());
				myStmt.setString(2, dlvryDetails.getPaymentStatus());
				myStmt.setString(3, dlvryDetails.getContactName()); 
				myStmt.setString(4, dlvryDetails.getContactNumber()); 
				myStmt.setString(5, dlvryDetails.getSiteLocation()); 
				myStmt.setDate(6, getSqlDate(dlvryDetails.getExpectedDeliveryDate())); 
				myStmt.setString(7, dlvryDetails.getNumberOfvehicleRequired()); 
				myStmt.setString(8, dlvryDetails.getDivnRemarks()); 
				myStmt.setString(9, dlvryDetails.getDivnUpdatedBy());    
				myStmt.setString(10, id);
				
				logType = myStmt.executeUpdate();
				//System.out.println("LOG VALUE : "+logType);
			} catch (SQLException ex) {
				logType = -2;
				System.out.println("Exception in closing DB resources at the time updating division user delivery details by "+dlvryDetails.getDivnUpdatedBy()+"  for id  "+id+" log = "+logType+"");
				ex.printStackTrace();
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
				//System.out.println("Updated and closed db Successfully ");
			}
			return logType;
		}
		public int updateDeliveryDetailsByFinance(LogisticDelivery dlvryDetails) { 
			String id = decrypt(dlvryDetails.getId());
			int logType = -2; 
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				if(myCon == null) return -2;
				
				String sql = " UPDATE FJPORTAL.INV_DB_TXN   "
						+ " SET FJ_INVH_FIN_APPR = ?, FJ_INVH_FIN_REMARKS = ?, FJ_INVH_FIN_UPD_DT  = SYSDATE, FJ_INVH_FIN_UPD_BY = ? "
						+ " WHERE FJ_INVH_SYS_ID = ?  AND NVL(FJ_INVH_LOG_APPR,'N')='N' " 
						+ "  AND FJ_INVH_DIVN_UPD_BY IS NOT NULL ";
				myStmt = myCon.prepareStatement(sql); 
				myStmt.setString(1, dlvryDetails.getFinStatus()); 
				myStmt.setString(2, dlvryDetails.getFinRemarks()); 
				myStmt.setString(3, dlvryDetails.getFinUpdatedBy()); 
				myStmt.setString(4, id);
				
				logType = myStmt.executeUpdate();
				//System.out.println("LOG VALUE : "+logType);
			} catch (SQLException ex) {
				logType = -2;
				System.out.println("Exception in closing DB resources at the time updating finance user delivery details by "+dlvryDetails.getFinUpdatedBy()+" for id  "+id+" log = "+logType+"");
				ex.printStackTrace();
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
				//System.out.println("Updated and closed db Successfully ");
			}
			return logType;
		}
		public int updateDeliveryDetailsByLogistic(LogisticDelivery dlvryDetails) {
			String id = decrypt(dlvryDetails.getId());
			int logType = -2; 
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				if(myCon == null) return -2; 
				String sql = " UPDATE FJPORTAL.INV_DB_TXN   "
						+ " SET FJ_INVH_LOG_APPR = ?, FJ_INVH_LOG_REMARKS = ?,    FJ_INVH_LOG_UPD_DT  = SYSDATE, FJ_INVH_LOG_UPD_BY = ? "
						+ " WHERE FJ_INVH_SYS_ID = ?  AND NVL(FJ_INVH_LOG_APPR,'N')='N' " 
						+ "  AND FJ_INVH_DIVN_UPD_BY IS NOT NULL ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dlvryDetails.getLogisticApproved()); 
				myStmt.setString(2, dlvryDetails.getLogisticRemark()); 
				myStmt.setString(3, dlvryDetails.getLogisticUpdBy()); 
				myStmt.setString(4, id);
				
				logType = myStmt.executeUpdate();
				//System.out.println("LOG VALUE : "+logType);
			} catch (SQLException ex) {
				logType = -2;
				System.out.println("Exception in closing DB resources at the time updating Logistic user delivery details by "+dlvryDetails.getLogisticUpdBy()+"  for id  "+id+" log = "+logType+"");
				ex.printStackTrace();
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
				//System.out.println("Updated and closed db Successfully ");
			}
			return logType;
		}
		public int updateDeliveryRemarksGeneral(String dlvryid, String remarks, String employeeCode, String divnCode) {
			String actionBy;
			if(divnCode.equalsIgnoreCase("FN")) { 
				actionBy = "FN";
			}else if(divnCode.equalsIgnoreCase("LG")) {
				actionBy = "LG";
			}else {
				actionBy = "DV";
			}
			String id = decrypt(dlvryid);
			int logType = -2; 
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				if(myCon == null) return -2;   
				String sql = " INSERT INTO FJPORTAL.INV_REMARK (REM_INVH_SYS_ID, REM_REMARKS, REM_INVH_CR_UID,  REM_INVH_CR_DT, REM_ACTION_BY)       "
						+ " VALUES( ?, ?, ?, SYSDATE, ?) "  ;
				myStmt = myCon.prepareStatement(sql);
				myStmt.setInt(1, Integer.parseInt(id));
				myStmt.setString(2, remarks);  
				myStmt.setString(3, employeeCode); 
				myStmt.setString(4, actionBy); 
				
				logType = myStmt.executeUpdate();
				//System.out.println("LOG VALUE : "+logType);
			} catch (SQLException ex) {
				logType = -2;
				System.out.println("Exception in closing DB resources at the time of creating remarks by "+actionBy+", "+employeeCode+"  for id  "+id+" log = "+logType+"");
				ex.printStackTrace();
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
				//System.out.println("Updated and closed db Successfully ");
			}
			return logType;
		}
		
		public Date getSqlDate(String str) {
			if(str == null || str.equals("") || str.isEmpty()) {
				return null;
			}else {
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
		}
		
		 
		 
		    private  String encrypt(String str) {	    	 	    	
//		    	 Random rand = new Random();
//		         BASE64Encoder encoder = new BASE64Encoder();	 
//		         byte[] salt = new byte[8];
//		         rand.nextBytes(salt);
//		         return encoder.encode(salt) + encoder.encode(str.getBytes());	  
		    	return str;
		    }
		 
		    private String decrypt(String encstr) {	 
//		    	String decyptedVal = "notValid";
//		    	if (encstr.length() > 12) {	    	 
//		    		String cipher = encstr.substring(12);	    	 
//		    		BASE64Decoder decoder = new BASE64Decoder();	    	 
//		    		try {	    	 
//		    			decyptedVal =  new String(decoder.decodeBuffer(cipher));	    	 
//		    		} catch (IOException e) { 
//		    			decyptedVal = "notValid";
//		    		  	e.printStackTrace(); 
//		    		}	    		   	    	 
//		    	}
//		    	 return decyptedVal;
		    	return encstr;
				
		   }
			
			public String getLogisticTeamMailIds() throws SQLException {
				 
				String mailAddresses = "";
				String type = "LGDVRY";
				
				Connection myCon = null;
				PreparedStatement myStmt = null;
				ResultSet myRes = null;
				MysqlDBConnectionPool con = new MysqlDBConnectionPool();
				try { 
					myCon = con.getMysqlConn();
					String sql = " select emailid from  emailconf where usagetype = ? ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, type); 
					myRes = myStmt.executeQuery();
					while (myRes.next()) {
						mailAddresses = myRes.getString(1);
					}
					return mailAddresses;

				} finally {
					// close jdbc objects
					close(myStmt, myRes);
					con.closeConnection();

				}
			}
			public String getFinanceTeamMailIds() throws SQLException {
				 
				String mailAddresses = "";
				String type = "LGFIN";
				
				Connection myCon = null;
				PreparedStatement myStmt = null;
				ResultSet myRes = null;
				MysqlDBConnectionPool con = new MysqlDBConnectionPool();
				try { 
					myCon = con.getMysqlConn();
					String sql = " select emailid from  emailconf where usagetype = ? ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, type); 
					myRes = myStmt.executeQuery();
					while (myRes.next()) {
						mailAddresses = myRes.getString(1);
					}
					return mailAddresses;

				} finally {
					// close jdbc objects
					close(myStmt, myRes);
					con.closeConnection();

				}
			}
			private String getCurrentDateString() { 
		        SimpleDateFormat formatter= new SimpleDateFormat("dd/MM/yyyy");
			    Date date = new Date(System.currentTimeMillis()); 
		       // System.out.println(" date : "+formatter.format(date));
			    return formatter.format(date);
		    }
			private String getCurrentDateTimeString() { 
		        SimpleDateFormat formatter= new SimpleDateFormat("dd/MM/yyyy, hh:mm a");
			    Date date = new Date(System.currentTimeMillis()); 
		       // System.out.println(" date time : "+formatter.format(date));
			    return formatter.format(date);
		    }
//			private java.util.Date currentDay() {
//			    final Calendar cal = Calendar.getInstance();
//			    cal.add(Calendar.DATE, 0);
//			    SimpleDateFormat formatter= new SimpleDateFormat("dd-MM-yyyy 'at' HH:mm:ss z");
//			    Date date = new Date(System.currentTimeMillis());
//			    System.out.println("new date "+formatter.format(date));
//			    return cal.getTime();
//			}	
			public int sendMailToDivisionTeam(LogisticDelivery deliveryDetails) {  
				EmailLogistic sslmail = new EmailLogistic(); 
				String ccAddress = "";
				String toAddress = "";
				String approvedOrNot = "Not Approved";
				if(deliveryDetails.getLogisticApproved().equalsIgnoreCase("Y")) {
					approvedOrNot = "Approved";
				}
				String today = getCurrentDateString();
				String todayTime = getCurrentDateTimeString();
				try {
					ccAddress = getLogisticTeamMailIds();
					toAddress = getEmailIdByEmpcode(deliveryDetails.getDivnUpdatedBy());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
				 
				System.out.println("Logistic to Division, TO Address : " + toAddress);
				System.out.println("Logistic to Division,  CC Address : " + ccAddress);
			 
				
				String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
				+ "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "Dear <b>"+checkNullValidation(deliveryDetails.getDivnEmpName())+",</b><br/>"
				+ "<p>Local Delivery Request updated by logistic team.  <br/><br/> "
				+ "<h4><u>Details</u></h4> "  
				+ "<b>Invoice Number :</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getInvcNumber()) + "</b><br/>"					
				+ "<b>Logistic Approved ? :</b>  <b style=\"color:blue;\">" +approvedOrNot+ "</b> <br/>"  
				+ "<b>Remarks :</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getLogisticRemark())+ "</b><br/> " 
				+ "<b>Updated By :</b>  <b style=\"color:red;\">" +checkNullValidation(deliveryDetails.getLogEmpName())+ "</b><br/>"  
				+ "<b>Updated On :</b>  <b style=\"color:red;\">" +todayTime+ "</b><br/>"  ;

				sslmail.setToaddr(toAddress);
				sslmail.setCcaddr(ccAddress); 
				sslmail.setMessageSub( "Local Delivery Request Updates By Logistics Team  for, "+deliveryDetails.getInvcNumber()+", Dt:"+today);
				sslmail.setMessagebody(msg);
				int status = sslmail.sendMail();
				if (status != 1) {

					System.out.print("Error in sending Mail to logistic team : "  +checkNullValidation(deliveryDetails.getInvcNumber())+ " status : " + status);
				} else {
					System.out.print("Successfully sent  Mail to logistic team : "  +checkNullValidation(deliveryDetails.getInvcNumber())+ " status : " + status);
				}
				return status;
				
			}
			public int sendmailToFinanceTeam(LogisticDelivery deliveryDetails, String ccAddress, int actionType) {
				String today = getCurrentDateString();
				String todayTime = getCurrentDateTimeString();
				String divnActionTxt = "Initiated";
				EmailLogistic sslmail = new EmailLogistic();
				String toAddress = "";
				try {
					toAddress = getFinanceTeamMailIds();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
				
				if(actionType == 1) {
					divnActionTxt = "Updated";
				} 
				System.out.println("Division to Finance,  TO Address : " + toAddress);
				System.out.println("Division to Finance, CC Address : " + ccAddress);
			 								
				String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
						+ "<tr>"
						+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
						+ "Dear <b>Finance Team,</b>"
						+ "<p> Local Delivery Request  "+divnActionTxt+". Please check and  approve delivery as per below payment terms,<br/> "
						+ "<h4><u>Details</u></h4> "  
						+ "<b>Invoice Number :</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getInvcNumber()) + "</b><br/>"	
						+ "<b>Payment term :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getPaymentTerms())+"</b>  <br/>"
						+ "<b>Payment Status :</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getPaymentStatus())+ "</b><br/> " 
						+ "<b>Contact Name :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getContactName())+"</b>  <br/>"
						+ "<b>Contact Number :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getContactNumber())+"</b>  <br/>"
						+ "<b>Site Location :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getSiteLocation())+"</b>  <br/>"
						+ "<b>Expected Delivery Date :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getExpectedDeliveryDate())+"</b>  <br/>"
						+ "<b>No. & Type Of Vehicles Required :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getNumberOfvehicleRequired())+"</b>  <br/>"
						+ "<b>Remarks :</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getDivnRemarks())+ "</b><br/> "
						+ "<b>"+divnActionTxt+" By :</b>  <b style=\"color:red;\">" +checkNullValidation(deliveryDetails.getDivnEmpName())+ "</b><br/>"  
						+ "<b>"+divnActionTxt+" On :</b>  <b style=\"color:red;\">" +todayTime+ "</b><br/>"  ;

				sslmail.setToaddr(toAddress);
				sslmail.setCcaddr(ccAddress); 
				sslmail.setMessageSub( "Local Delivery Request "+divnActionTxt+" for " +deliveryDetails.getInvcNumber()+",  Dt:"+today);
				sslmail.setMessagebody(msg);
				int status = sslmail.sendMail();
				if (status != 1) {

					System.out.print("Error in sending Mail to logistic team : " +deliveryDetails.getInvcNumber()+ " status : " + status);
				} else {
					System.out.print("Successfully sent  Mail to logistic team : "+deliveryDetails.getInvcNumber()+" status : " + status);
				}
				return status;
				
			}
			public int sendmailToLogisticTeam(LogisticDelivery deliveryDetails, String ccAddress) {
				String today = getCurrentDateString();
				String todayTime = getCurrentDateTimeString();
				EmailLogistic sslmail = new EmailLogistic();
				String toAddress = "";
				try {
					toAddress = getLogisticTeamMailIds();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
				
				
				System.out.println("Division to Logistic,  TO Address : " + toAddress);
				System.out.println("Division to Logistic, CC Address : " + ccAddress);
			 								
				String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
						+ "<tr>"
						+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
						+ "Dear <b>Logistics Team,</b>"
						+ "<p> Local Delivery Request delivery approved by finance team. Please arrange the delivery,<br/> "
						+ "<h4><u>Details</u></h4> "  
						+ "<b>Invoice Number :</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getInvcNumber()) + "</b><br/>"	
						+ "<b>Contact Name :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getContactName())+"</b>  <br/>"
						+ "<b>Contact Number :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getContactNumber())+"</b>  <br/>"
						+ "<b>Site Location :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getSiteLocation())+"</b>  <br/>"
						+ "<b>Expected Delivery Date :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getExpectedDeliveryDate())+"</b>  <br/>"
						+ "<b>No. & Type Of Vehicles Required :  </b>   <b style=\"color:blue;\">"+ checkNullValidation(deliveryDetails.getNumberOfvehicleRequired())+"</b>  <br/><br/><br/>"
						+ "<b>Delivery Approved:</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getFinStatus())+ "</b><br/> "
						+ "<b>Remarks By Finance:</b>  <b style=\"color:blue;\">" + checkNullValidation(deliveryDetails.getFinRemarks())+ "</b><br/> "
						+ "<b> Updated By :</b>  <b style=\"color:red;\">" +checkNullValidation(deliveryDetails.getFinEmpName())+ "</b><br/>"  
						+ "<b>Updated On :</b>  <b style=\"color:red;\">" +todayTime+ "</b><br/>"  ;

				sslmail.setToaddr(toAddress);
				sslmail.setCcaddr(ccAddress); 
				sslmail.setMessageSub( "Local Delivery Request  Delivery Approved By Finance  for " +deliveryDetails.getInvcNumber()+",  Dt:"+today);
				sslmail.setMessagebody(msg);
				int status = sslmail.sendMail();
				if (status != 1) {

					System.out.print("Error in sending Mail to logistic team : " +deliveryDetails.getInvcNumber()+ " status : " + status);
				} else {
					System.out.print("Successfully sent  Mail to logistic team : "+deliveryDetails.getInvcNumber()+" status : " + status);
				}
				return status;
				
			}
			private String checkNullValidation(String value) {
				String out = "-";
				if (value == null || value.isEmpty() || value.equalsIgnoreCase("undefined")) {
					return out;
				} else {

					return value;
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
				String sqlstr = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
				// String sqlstr = "SELECT TXNFIELD_FLD5 FROM ORION.PT_TXN_FLEX_FIELDS WHERE
				// TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
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
			public boolean checkDMLogisticDashbaordAccess(String empCode) { 
				boolean logType = false;  
				Connection myCon = null;
				PreparedStatement myStmt = null;
				ResultSet myRes = null;
				OrclDBConnectionPool orcl = new OrclDBConnectionPool();
				try {
					myCon = orcl.getOrclConn();
					String sql = " SELECT * FROM FJPORTAL.DEL_DB_DIVN_EMP   " + 
							" WHERE DM_CODE = ? AND ROWNUM=1 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, empCode); 
					myRes = myStmt.executeQuery();
					if (myRes.next()) {  
						logType = true;
					}  
				} catch (SQLException ex) {
					logType = false;
					System.out.println("Exception in closing DB resources at  DM lg db permission check");
					ex.printStackTrace();
				}finally {
					close(myStmt, myRes);
					orcl.closeConnection();
				}
				return logType;
			}
			public Logistic getDivsionEmployeeAccessStatus(String empCode) throws SQLException {  
				Logistic permissionData =  new Logistic(0, "");
				Connection myCon = null;
				PreparedStatement myStmt = null;
				ResultSet myRes = null;
				OrclDBConnectionPool orcl = new OrclDBConnectionPool();
				try {
					myCon = orcl.getOrclConn();
					String sql = " SELECT * FROM FJPORTAL.DEL_DB_DIVN_EMP  " + 
							" WHERE EMP_CODE = ? AND ROWNUM=1 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, empCode); 
					myRes = myStmt.executeQuery();
					if (myRes.next()) { 
						String txnCode = myRes.getString(1); 
						permissionData = new Logistic(1,  txnCode); 
					} 
					return permissionData;
				} finally {
					close(myStmt, myRes);
					orcl.closeConnection();
				}

			}
	}
