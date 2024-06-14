package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import beans.EmailMarketing;
import beans.MktConfig;
import beans.MktSalesLeads;
import beans.Mkt_SEFollowUp;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class MktSalesLeadsDbUtil {

	public List<MktConfig> getMarketingTypesConfig(String category) throws SQLException {
		// leads details for Sales Engineers
		List<MktConfig> typeList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select * from mkt_types  where category = ?  and status = 1 ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, category);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String id_temp = myRes.getString(1);
				String type_temp = myRes.getString(2);
				String category_temp = myRes.getString(3);
				String typeCode_temp = myRes.getString(5);
				String noOfProcess = myRes.getString(6);

				MktConfig tempTypeList = new MktConfig(id_temp, type_temp, category_temp, typeCode_temp, noOfProcess);
				typeList.add(tempTypeList);

			}
			return typeList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	private String formatDate(String dateValue) {
		// System.out.println(dateValue);
		String formattedDate = "";
		String[] tempArray;
		String delimiter = "-";
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

		return formattedDate;

	}

	public List<MktSalesLeads> getLeadDetailsGeneral(String from, String to) throws SQLException {
		// leads details for Marketing TEAM and Managment
		List<MktSalesLeads> leadsList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			myCon = con.getMysqlConn();
			String sql = " CALL  get_custDate_complete_sales_leads(?, ?) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, formatDate(from));
			myStmt.setString(2, formatDate(to));
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String leadUnificationCode = myRes.getString(2);
				String type_temp = myRes.getString(3);
				String divn_temp = myRes.getString(4);
				String product_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String consultant_temp = myRes.getString(7);
				String projectDetails_temp = myRes.getString(8);
				String leadRemarks = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String submittedBy_temp = myRes.getString(12);
				String submittedOn_temp = myRes.getString(13);
				String submitStatus_temp = myRes.getString(14);
				String ackRemarks_temp = myRes.getString(15);
				String ackStatus_temp = myRes.getString(16);
				String ackOn_temp = myRes.getString(17);
				String sales_orderNo_temp = myRes.getString(18);
				String projectCode_temp = myRes.getString(19);
				float offerVal_temp = myRes.getFloat(20);
				String loi_temp = myRes.getString(21);
				String lpo_temp = myRes.getString(22);
				String seRemarks_tmp = myRes.getString(23);
				String folloupOn_temp = myRes.getString(24);
				String folloupStatus_temp = myRes.getString(25);
				String mktRemark_temp = myRes.getString(26);
				String leadStatus_temp = myRes.getString(27);
				String leadClosedOn_temp = myRes.getString(28);
				String leadClosedBy_temp = myRes.getString(29);
				String leadCloseStatus_temp = myRes.getString(30);
				String leadTypeCode = myRes.getString(31);
				String noOfProcess = myRes.getString(32);
				String ackDesc = myRes.getString(33);
				String followUpDesc = myRes.getString(34);
				String stage2QtdDivisions = myRes.getString(35);
				String location = myRes.getString(36);

				// System.out.println("Acknlodgment desc "+ackDesc+" p2= "+ackStatus_temp+" lead
				// code "+leadUnificationCode);

				if (ackDesc == null || ackDesc.isEmpty()) {
					ackDesc = getacknowledgmentDescrption(ackStatus_temp);// method for old data
				}

				if (followUpDesc == null || followUpDesc.isEmpty()) {
					followUpDesc = getSeFollowUpacknowledgmentDescrption(folloupStatus_temp);// method for old data
				}

				MktSalesLeads tempLeadsList = new MktSalesLeads(mktid, leadUnificationCode, type_temp, divn_temp,
						product_temp, contact_temp, consultant_temp, projectDetails_temp, leadRemarks, seempCode_temp,
						seempName_temp, submittedBy_temp, submittedOn_temp, submitStatus_temp, ackRemarks_temp,
						ackStatus_temp, ackOn_temp, sales_orderNo_temp, projectCode_temp, offerVal_temp, loi_temp,
						lpo_temp, seRemarks_tmp, folloupOn_temp, folloupStatus_temp, mktRemark_temp, leadStatus_temp,
						leadClosedOn_temp, leadClosedBy_temp, leadCloseStatus_temp, leadTypeCode, noOfProcess, ackDesc,
						followUpDesc, stage2QtdDivisions, location);
				leadsList.add(tempLeadsList);

			}
			return leadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktSalesLeads> getLeadDetailsGeneralByLocation(String from, String to, String employeeCode)
			throws SQLException {
		// leads details for Marketing TEAM and Managment
		List<MktSalesLeads> leadsList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			myCon = con.getMysqlConn();
			String sql = " CALL  get_custDate_complete_sales_leads_byLctn(?, ?, ?) ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, formatDate(from));
			myStmt.setString(2, formatDate(to));
			myStmt.setString(3, employeeCode);
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String leadUnificationCode = myRes.getString(2);
				String type_temp = myRes.getString(3);
				String divn_temp = myRes.getString(4);
				String product_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String consultant_temp = myRes.getString(7);
				String projectDetails_temp = myRes.getString(8);
				String leadRemarks = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String submittedBy_temp = myRes.getString(12);
				String submittedOn_temp = myRes.getString(13);
				String submitStatus_temp = myRes.getString(14);
				String ackRemarks_temp = myRes.getString(15);
				String ackStatus_temp = myRes.getString(16);
				String ackOn_temp = myRes.getString(17);
				String sales_orderNo_temp = myRes.getString(18);
				String projectCode_temp = myRes.getString(19);
				float offerVal_temp = myRes.getFloat(20);
				String loi_temp = myRes.getString(21);
				String lpo_temp = myRes.getString(22);
				String seRemarks_tmp = myRes.getString(23);
				String folloupOn_temp = myRes.getString(24);
				String folloupStatus_temp = myRes.getString(25);
				String mktRemark_temp = myRes.getString(26);
				String leadStatus_temp = myRes.getString(27);
				String leadClosedOn_temp = myRes.getString(28);
				String leadClosedBy_temp = myRes.getString(29);
				String leadCloseStatus_temp = myRes.getString(30);
				String leadTypeCode = myRes.getString(31);
				String noOfProcess = myRes.getString(32);
				String ackDesc = myRes.getString(33);
				String followUpDesc = myRes.getString(34);
				String stage2QtdDivisions = myRes.getString(35);
				String location = myRes.getString(36);
				// System.out.println("Acknlodgment desc "+ackDesc+" p2= "+ackStatus_temp+" lead
				// code "+leadUnificationCode);

				if (ackDesc == null || ackDesc.isEmpty()) {
					ackDesc = getacknowledgmentDescrption(ackStatus_temp);// method for old data
				}

				if (followUpDesc == null || followUpDesc.isEmpty()) {
					followUpDesc = getSeFollowUpacknowledgmentDescrption(folloupStatus_temp);// method for old data
				}

				MktSalesLeads tempLeadsList = new MktSalesLeads(mktid, leadUnificationCode, type_temp, divn_temp,
						product_temp, contact_temp, consultant_temp, projectDetails_temp, leadRemarks, seempCode_temp,
						seempName_temp, submittedBy_temp, submittedOn_temp, submitStatus_temp, ackRemarks_temp,
						ackStatus_temp, ackOn_temp, sales_orderNo_temp, projectCode_temp, offerVal_temp, loi_temp,
						lpo_temp, seRemarks_tmp, folloupOn_temp, folloupStatus_temp, mktRemark_temp, leadStatus_temp,
						leadClosedOn_temp, leadClosedBy_temp, leadCloseStatus_temp, leadTypeCode, noOfProcess, ackDesc,
						followUpDesc, stage2QtdDivisions, location);
				leadsList.add(tempLeadsList);

			}
			return leadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktSalesLeads> getLeadDetailsForSalesEng(String empCode, String from, String to) throws SQLException {
		// leads details for Sales Engineers
		List<MktSalesLeads> leadsList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "CALL get_custDate_salesEng_sales_leads(?, ?, ?) ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, empCode);
			myStmt.setString(2, formatDate(from));
			myStmt.setString(3, formatDate(to));
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String leadUnificationCode = myRes.getString(2);
				String type_temp = myRes.getString(3);
				String divn_temp = myRes.getString(4);
				String product_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String consultant_temp = myRes.getString(7);
				String projectDetails_temp = myRes.getString(8);
				String leadRemarks = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String submittedBy_temp = myRes.getString(12);
				String submittedOn_temp = myRes.getString(13);
				String submitStatus_temp = myRes.getString(14);
				String ackRemarks_temp = myRes.getString(15);
				String ackStatus_temp = myRes.getString(16);
				String ackOn_temp = myRes.getString(17);
				String sales_orderNo_temp = myRes.getString(18);
				String projectCode_temp = myRes.getString(19);
				float offerVal_temp = myRes.getFloat(20);
				String loi_temp = myRes.getString(21);
				String lpo_temp = myRes.getString(22);
				String seRemarks_tmp = myRes.getString(23);
				String folloupOn_temp = myRes.getString(24);
				String folloupStatus_temp = myRes.getString(25);
				String mktRemark_temp = myRes.getString(26);
				String leadStatus_temp = myRes.getString(27);
				String leadClosedOn_temp = myRes.getString(28);
				String leadClosedBy_temp = myRes.getString(29);
				String leadCloseStatus_temp = myRes.getString(30);
				String leadTypeCode = myRes.getString(31);
				String noOfProcess = myRes.getString(32);
				String ackDesc = myRes.getString(33);
				String followUpDesc = myRes.getString(34);
				String stage2QtdDivisions = myRes.getString(35);
				String location = myRes.getString(36);

				// System.out.println("Acknlodgment desc "+ackDesc+" p2= "+ackStatus_temp+" lead
				// code "+leadUnificationCode);

				if (ackDesc == null || ackDesc.isEmpty()) {

					ackDesc = getacknowledgmentDescrption(ackStatus_temp);// method for old data

				}

				if (followUpDesc == null || followUpDesc.isEmpty()) {
					followUpDesc = getSeFollowUpacknowledgmentDescrption(folloupStatus_temp);// method for old data
				}

				MktSalesLeads tempLeadsList = new MktSalesLeads(mktid, leadUnificationCode, type_temp, divn_temp,
						product_temp, contact_temp, consultant_temp, projectDetails_temp, leadRemarks, seempCode_temp,
						seempName_temp, submittedBy_temp, submittedOn_temp, submitStatus_temp, ackRemarks_temp,
						ackStatus_temp, ackOn_temp, sales_orderNo_temp, projectCode_temp, offerVal_temp, loi_temp,
						lpo_temp, seRemarks_tmp, folloupOn_temp, folloupStatus_temp, mktRemark_temp, leadStatus_temp,
						leadClosedOn_temp, leadClosedBy_temp, leadCloseStatus_temp, leadTypeCode, noOfProcess, ackDesc,
						followUpDesc, stage2QtdDivisions, location);
				leadsList.add(tempLeadsList);

			}
			return leadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	private String getSeFollowUpacknowledgmentDescrption(String p3Status) {

		int p3 = Integer.parseInt(p3Status);
		String description = "N/A";
		if (p3 == 0) {
			description = "Pending";
		} else if (p3 == 2) {
			description = "Still Working";
		} else if (p3 == 1) {
			description = "Completed";
		}
		return description;
	}

	private String getacknowledgmentDescrption(String p2Status) {
		int p2 = Integer.parseInt(p2Status);
		String description = "N/A";
		if (p2 == 0) {
			description = "Pending";
		} else if (p2 == 2) {
			description = "Received, but declined";
		} else if (p2 == 1) {
			description = "Received & Will Quote";
		}
		return description;
	}

	public List<MktSalesLeads> getLeadDetailsForDM(String empCode, String salesEngList, String from, String to)
			throws SQLException {
		// leads details for Sales Engineers
		List<MktSalesLeads> leadsList = new ArrayList<>();
		// System.out.println(salesEngList);
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " CALL get_custDate_DMWise_sales_leads(?, '" + salesEngList + "',  ?, ?) ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, empCode);
			myStmt.setString(2, formatDate(from));
			myStmt.setString(3, formatDate(to));
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String leadUnificationCode = myRes.getString(2);
				String type_temp = myRes.getString(3);
				String divn_temp = myRes.getString(4);
				String product_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String consultant_temp = myRes.getString(7);
				String projectDetails_temp = myRes.getString(8);
				String leadRemarks = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String submittedBy_temp = myRes.getString(12);
				String submittedOn_temp = myRes.getString(13);
				String submitStatus_temp = myRes.getString(14);
				String ackRemarks_temp = myRes.getString(15);
				String ackStatus_temp = myRes.getString(16);
				String ackOn_temp = myRes.getString(17);
				String sales_orderNo_temp = myRes.getString(18);
				String projectCode_temp = myRes.getString(19);
				float offerVal_temp = myRes.getFloat(20);
				String loi_temp = myRes.getString(21);
				String lpo_temp = myRes.getString(22);
				String seRemarks_tmp = myRes.getString(23);
				String folloupOn_temp = myRes.getString(24);
				String folloupStatus_temp = myRes.getString(25);
				String mktRemark_temp = myRes.getString(26);
				String leadStatus_temp = myRes.getString(27);
				String leadClosedOn_temp = myRes.getString(28);
				String leadClosedBy_temp = myRes.getString(29);
				String leadCloseStatus_temp = myRes.getString(30);
				String leadTypeCode = myRes.getString(31);
				String noOfProcess = myRes.getString(32);
				String ackDesc = myRes.getString(33);
				String followUpDesc = myRes.getString(34);
				String stage2QtdDivisions = myRes.getString(35);
				String location = myRes.getString(36);

				// System.out.println("Acknlodgment desc "+ackDesc+" p2= "+ackStatus_temp+" lead
				// code "+leadUnificationCode);

				if (ackDesc == null || ackDesc.isEmpty()) {
					ackDesc = getacknowledgmentDescrption(ackStatus_temp);// method for old data
				}

				if (followUpDesc == null || followUpDesc.isEmpty()) {
					followUpDesc = getSeFollowUpacknowledgmentDescrption(folloupStatus_temp);// method for old data
				}

				MktSalesLeads tempLeadsList = new MktSalesLeads(mktid, leadUnificationCode, type_temp, divn_temp,
						product_temp, contact_temp, consultant_temp, projectDetails_temp, leadRemarks, seempCode_temp,
						seempName_temp, submittedBy_temp, submittedOn_temp, submitStatus_temp, ackRemarks_temp,
						ackStatus_temp, ackOn_temp, sales_orderNo_temp, projectCode_temp, offerVal_temp, loi_temp,
						lpo_temp, seRemarks_tmp, folloupOn_temp, folloupStatus_temp, mktRemark_temp, leadStatus_temp,
						leadClosedOn_temp, leadClosedBy_temp, leadCloseStatus_temp, leadTypeCode, noOfProcess, ackDesc,
						followUpDesc, stage2QtdDivisions, location);
				leadsList.add(tempLeadsList);
			}
			return leadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int insertLeads(List<MktSalesLeads> theList, String location) throws SQLException {
		int logType = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();

		Iterator<MktSalesLeads> iterator = theList.iterator();
		try {
			myCon = con.getMysqlConn();
			String sql = "insert into sales_leads(lead_unification_code, type, division, product, se_emp_code, se_name, "
					+ " project_details, lead_remarks, consultant, contractor, submitted_by, leadTypeCode, noOfProcess, stage2QuotedDivn, submitted_on, submitted_status, project_code, marketing_location) "
					+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate(), 1, ?, ?) ";
			myStmt = myCon.prepareStatement(sql);
			myCon.setAutoCommit(false);

			while (iterator.hasNext()) {
				// System.out.println("ITERATOR ");
				MktSalesLeads theLData = (MktSalesLeads) iterator.next();

				myStmt.setString(1, theLData.getLeadUnfctnCode());
				myStmt.setString(2, theLData.getType()); // type desc
				myStmt.setString(3, theLData.getDivision());
				myStmt.setString(4, theLData.getPrdct());
				myStmt.setString(5, theLData.getSeEmpCode());
				myStmt.setString(6, theLData.getSeName());
				// System.out.println("SEG : "+theLData.getSeName()+" "+theLData.getPrdct());
				myStmt.setString(7, theLData.getProjectDetails());
				myStmt.setString(8, theLData.getLeadRemarks());
				myStmt.setString(9, theLData.getConsultant());
				myStmt.setString(10, theLData.getContractor());
				myStmt.setString(11, theLData.getCreatedBy());
				myStmt.setString(12, theLData.getTypeCode());
				myStmt.setString(13, theLData.getProcessCount());
				myStmt.setString(14, theLData.getStage2QtdDivisions());
				myStmt.setString(15, theLData.getPrjctCode());
				myStmt.setString(16, location);
				myStmt.addBatch();
			}

			// Create an int[] to hold returned values
			int[] affectedRecords = myStmt.executeBatch();
			// System.out.println("Affected ROWST "+affectedRecords.length);
			/*
			 * for(int i=0;i< affectedRecords.length;i++) {
			 * System.out.println("INSERT "+affectedRecords[i]); logType=logType +
			 * affectedRecords[i]; }
			 */

			myCon.commit();
			logType = affectedRecords.length;
			System.out.println("Inser sales lead Log  " + logType);

		} catch (SQLException e) {
			System.out.print("SQL ERRORR FOR SALES LEAD  INSERT");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}
		return logType;

	}

	public List<MktSalesLeads> getProductList(String divisionCode) throws SQLException {
		List<MktSalesLeads> productList = new ArrayList<>();
		if (divisionCode.equals("AD")) {
			Connection myCon = null;
			Statement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {
				// Get Connection
				myCon = con.getMysqlConn();
				// Execute sql stamt
				String sql = "SELECT distinct prduct from mkt_products  order by 1 asc ";
				myStmt = myCon.createStatement();
				// set the param values

				// Execute a SQL query
				myRes = myStmt.executeQuery(sql);
				// Process the result set
				while (myRes.next()) {
					String product_tmp = myRes.getString(1);
					MktSalesLeads tempproductList = new MktSalesLeads(product_tmp);
					productList.add(tempproductList);
				}
				return productList;
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				con.closeConnection();
			}
		} else {
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {
				// Get Connection
				myCon = con.getMysqlConn();
				// Execute sql stamt
				String sql = "SELECT prduct from mkt_products where division = ? order by 1 asc ";
				myStmt = myCon.prepareStatement(sql);
				// set the param values
				myStmt.setString(1, divisionCode);
				// Execute a SQL query
				myRes = myStmt.executeQuery();
				// Process the result set
				while (myRes.next()) {
					String product_tmp = myRes.getString(1);
					MktSalesLeads tempproductList = new MktSalesLeads(product_tmp);
					productList.add(tempproductList);
				}
				return productList;
			} finally {
				// close jdbc objects
				close(myStmt, myRes);
				con.closeConnection();
			}
		}

	}

	public List<MktSalesLeads> getSalesEngList() throws SQLException {
		// sales engineer list expect EME - SEG's and Sales with DM status
		List<MktSalesLeads> salesEngList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SM_CODE,SM_NAME,SM_FLEX_08 FROM OM_SALESMAN WHERE sm_frz_flag_num=2   "
					+ " AND SM_FLEX_08 IN ( SELECT EMP_CODE FROM PM_EMP_KEY WHERE EMP_FRZ_FLAG = 'N'"
					+ " AND (EMP_STATUS = '1' OR EMP_STATUS ='2')"
					// + " and EMP_COMP_CODE NOT IN ('EME') " // -- COMMENTED TO GET EME SALES
					// ENGINEERS
					+ ") Order by SM_NAME  ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String salesman_code = myRes.getString(1);
				String salesman_name = myRes.getString(2);
				String salesman_emp_code = myRes.getString(3);
				MktSalesLeads tempSalesmanList = new MktSalesLeads(salesman_code, salesman_name, salesman_emp_code);
				salesEngList.add(tempSalesmanList);
			}
			return salesEngList;
		} finally {
			// close jdbc objects
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

	public List<MktSalesLeads> getLeadsForEdit(int id) throws SQLException {
		// leads details for Sales Engineers
		List<MktSalesLeads> leadsList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select * " + " from sales_leads where id = ?  order  by lead_unification_code desc ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setInt(1, id);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String leadUnificationCode = myRes.getString(2);
				String type_temp = myRes.getString(3);
				String divn_temp = myRes.getString(4);
				String product_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String consultant_temp = myRes.getString(7);
				String projectDetails_temp = myRes.getString(8);
				String leadRemarks = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String submittedBy_temp = myRes.getString(12);
				String submittedOn_temp = myRes.getString(13);
				String submitStatus_temp = myRes.getString(14);
				String ackRemarks_temp = myRes.getString(15);
				String ackStatus_temp = myRes.getString(16);
				String ackOn_temp = myRes.getString(17);
				String sales_orderNo_temp = myRes.getString(18);
				String projectCode_temp = myRes.getString(19);
				float offerVal_temp = myRes.getFloat(20);
				String loi_temp = myRes.getString(21);
				String lpo_temp = myRes.getString(22);
				String seRemarks_tmp = myRes.getString(23);
				String folloupOn_temp = myRes.getString(24);
				String folloupStatus_temp = myRes.getString(25);
				String mktRemark_temp = myRes.getString(26);
				String leadStatus_temp = myRes.getString(27);
				String leadClosedOn_temp = myRes.getString(28);
				String leadClosedBy_temp = myRes.getString(29);
				String leadCloseStatus_temp = myRes.getString(30);
				String leadTypeCode = myRes.getString(31);
				String noOfProcess = myRes.getString(32);
				String ackDesc = myRes.getString(33);
				String followUpDesc = myRes.getString(34);
				String stage2QtdDivisions = myRes.getString(35);
				String location = myRes.getString(36);
				MktSalesLeads tempLeadsList = new MktSalesLeads(mktid, leadUnificationCode, type_temp, divn_temp,
						product_temp, contact_temp, consultant_temp, projectDetails_temp, leadRemarks, seempCode_temp,
						seempName_temp, submittedBy_temp, submittedOn_temp, submitStatus_temp, ackRemarks_temp,
						ackStatus_temp, ackOn_temp, sales_orderNo_temp, projectCode_temp, offerVal_temp, loi_temp,
						lpo_temp, seRemarks_tmp, folloupOn_temp, folloupStatus_temp, mktRemark_temp, leadStatus_temp,
						leadClosedOn_temp, leadClosedBy_temp, leadCloseStatus_temp, leadTypeCode, noOfProcess, ackDesc,
						followUpDesc, stage2QtdDivisions, location);
				leadsList.add(tempLeadsList);

			}
			return leadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public int updateSalesEngineerAcknowledgment(MktSalesLeads updatedtls, String processDescription)
			throws SQLException {
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update sales_leads set  acknowledgment_remarks =?, se_acknowledgment_on = sysdate() ,se_acknowledgment_status =  ?, p2Desc = ? "
					+ " where id = ?  and se_emp_code = ? ";

			// very important
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, updatedtls.getAckRemarks());
			myStmt.setInt(2, Integer.parseInt(updatedtls.getP2Status()));
			myStmt.setString(3, processDescription);
			myStmt.setString(4, updatedtls.getId());
			myStmt.setString(5, updatedtls.getSeEmpCode());

			// execute sql query
			logType = myStmt.executeUpdate();

			return logType;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int updateSalesEngineerAcknowledgmentTxn(MktSalesLeads updatedtls, String processDescription)
			throws SQLException {
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myInsertStmt = null;
		PreparedStatement myUpdateStmt = null;
		ResultSet myRes = null;

		String sqlUpdate = "update sales_leads set  acknowledgment_remarks =?, se_acknowledgment_on = sysdate() ,se_acknowledgment_status =  ?, p2Desc = ? "
				+ " where id = ?  and se_emp_code = ? ";

		// String sqlInsert= "insert into mkt_seFollowUp_Process( lead_id ) "
		// + " values(?) ";

		String sqlInsert = " INSERT INTO mkt_seFollowUp_Process (lead_id)  " + " SELECT * FROM (SELECT ? ) AS tmp  "
				+ " WHERE NOT EXISTS (  " + "    SELECT lead_id FROM mkt_seFollowUp_Process WHERE lead_id = ? "
				+ " ) LIMIT 1";
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();

		try {
			myCon = con.getMysqlConn();

			// STEP 1 - Disable auto commit mode
			myCon.setAutoCommit(false);
			myInsertStmt = myCon.prepareStatement(sqlInsert);
			myUpdateStmt = myCon.prepareStatement(sqlUpdate);

			// Create update statement
			myUpdateStmt.setString(1, updatedtls.getAckRemarks());
			myUpdateStmt.setInt(2, Integer.parseInt(updatedtls.getP2Status()));
			myUpdateStmt.setString(3, processDescription);
			myUpdateStmt.setString(4, updatedtls.getId());
			myUpdateStmt.setString(5, updatedtls.getSeEmpCode());
			myUpdateStmt.execute();

			// Create insert statement
			myInsertStmt.setString(1, updatedtls.getId());
			myInsertStmt.setString(2, updatedtls.getId());
			logType = myInsertStmt.executeUpdate();

			// STEP 2 - Commit insert and update statement
			myCon.commit();
			// System.out.println("SALES LEAD SE Acknwoledgment Transaction is commited
			// successfully.");

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					// STEP 3 - Roll back transaction
					System.out.println(
							"Transaction is being rolled back. SE acknowledgment process" + updatedtls.getId());
					myCon.rollback();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}

		} finally {
			// close jdbc objects
			close(myInsertStmt, myRes);
			close(myUpdateStmt, myRes);
			con.closeConnection();

		}
		return logType;
	}

	public int updateSalesEngineerFollowup(MktSalesLeads updatedtls, int newFollowUpStage, int fpProcessId,
			int fpProcessStatus) throws SQLException {
		// System.out.println("SE FOLLOWUP DB");
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myUpdateTxn1Stmt = null;
		PreparedStatement myUpdateTxn2Stmt = null;
		ResultSet myRes = null;
		String sqlUpdateFollowUpTxn = "";
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sqlUpdateLeadTxn = "update sales_leads set  se_remarks =?, project_code=?, so_num = ?, offervalue = ?, followup_on = sysdate() ,followup_ststus = ? , loi = IFNULL(?,0),  lpo = IFNULL(?,0), p3Desc = ? "
					+ " where id = ?  and se_emp_code = ? ";
			if (newFollowUpStage == 1) {
				sqlUpdateFollowUpTxn = "update mkt_seFollowUp_Process set  process31_status =?, process31_desc = ?, lastProceesedStage = ?, process31_on = sysdate() "
						+ " where lead_id = ?  and process_id = ? ";
			} else if (newFollowUpStage == 2) {
				sqlUpdateFollowUpTxn = "update mkt_seFollowUp_Process set  process32_status =?, process32_desc = ?, lastProceesedStage = ?, process32_on = sysdate() "
						+ " where lead_id = ?  and process_id = ? ";
			} else if (newFollowUpStage == 3) {
				sqlUpdateFollowUpTxn = "update mkt_seFollowUp_Process set  process33_status =?, process33_desc = ?, lastProceesedStage = ?, process33_on = sysdate() "
						+ " where lead_id = ?  and process_id = ? ";
			} else {
				System.out.println("WRONG SE FOLLOWUP IN SUB PROCESS");
			}

			// very important
			myCon.setAutoCommit(false);
			myUpdateTxn1Stmt = myCon.prepareStatement(sqlUpdateLeadTxn);
			myUpdateTxn2Stmt = myCon.prepareStatement(sqlUpdateFollowUpTxn);

			myUpdateTxn1Stmt.setString(1, updatedtls.getSeRemarks());
			myUpdateTxn1Stmt.setString(2, updatedtls.getPrjctCode());
			myUpdateTxn1Stmt.setString(3, updatedtls.getSoNumber());
			myUpdateTxn1Stmt.setDouble(4, updatedtls.getOfferValue());
			myUpdateTxn1Stmt.setInt(5, Integer.parseInt(updatedtls.getP3Status()));
			myUpdateTxn1Stmt.setString(6, updatedtls.getLoi());
			myUpdateTxn1Stmt.setString(7, updatedtls.getLpo());
			myUpdateTxn1Stmt.setString(8, updatedtls.getFollowUpAckDesc());
			myUpdateTxn1Stmt.setString(9, updatedtls.getId());
			myUpdateTxn1Stmt.setString(10, updatedtls.getSeEmpCode());
			myUpdateTxn1Stmt.execute();

			myUpdateTxn2Stmt.setInt(1, fpProcessStatus);
			myUpdateTxn2Stmt.setString(2, updatedtls.getFollowUpAckDesc());
			myUpdateTxn2Stmt.setInt(3, newFollowUpStage);
			myUpdateTxn2Stmt.setString(4, updatedtls.getId());
			myUpdateTxn2Stmt.setInt(5, fpProcessId);
			logType = myUpdateTxn2Stmt.executeUpdate();

			// STEP 2 - Commit insert and update statement
			myCon.commit();
			// System.out.println("SE FP Process Transaction is commited successfully.");

		} catch (SQLException e) {

			e.printStackTrace();
			if (myCon != null) {
				try {
					// STEP 3 - Roll back transaction
					System.out.println("Transaction is being rolled back. Sales Engineer followup process for "
							+ updatedtls.getId());
					myCon.rollback();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		} finally {
			// close jdbc objects
			close(myUpdateTxn1Stmt, myRes);
			close(myUpdateTxn2Stmt, myRes);
			// close(myStmt,myRes);
			con.closeConnection();
		}
		return logType;
	}

	public int closeLead(MktSalesLeads updatedtls) throws SQLException {
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update sales_leads set  mkt_remarks =?, status=?,  mkt_update_on = sysdate() ,mkt_update_status = 1 , mkt_update_by = ? "
					+ " where id = ? ";

			// very important
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, updatedtls.getMktRemarks());
			myStmt.setString(2, updatedtls.getMktStatus());
			myStmt.setString(3, updatedtls.getMktUpdatedBy());
			myStmt.setString(4, updatedtls.getId());

			// execute sql query
			logType = myStmt.executeUpdate();
			return logType;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void deleteLead(String cid) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from  sales_leads  " + " where  id =? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, cid);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}
	}

	public int sendAcknowledgmentMailToMktProcees2(MktSalesLeads theLData, String leadType, String processDescription,
			String empployee_Code) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead
		String leadTypeText = leadType;
		/*
		 * String seResponse = "";
		 * 
		 * if(Integer.parseInt(theLData.getP2Status()) == 1) { seResponse =
		 * "Recieved and Will Quote"; }else { seResponse = "Recieved but declined"; }
		 */
		String ccAddress = getEmailIdByEmpcode(theLData.getSeEmpCode()) + ","
				+ getDmEmailIdByEmpcode(theLData.getSeEmpCode());
		String toAddress = "";
		try {
			toAddress = getMarketingTeamMailIds(empployee_Code);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("To Address : " + toAddress);
		System.out.println("To Address : " + ccAddress);

		String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>"
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>  "
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>" + "<p>Sales engineer has <b>ACKNOWLEDGED</b> the sales lead code  FJMKT-"
				+ theLData.getLeadUnfctnCode() + ". Please check the details.<br />  " + "<h4><u>Details</u></h4>"
				+ "<b>Lead Type :</b> <b style=\"color:blue;\"> " + leadTypeText + "</b><br/> "
				+ "<b>Lead Code :</b>  FJMKT" + theLData.getLeadUnfctnCode() + "<br/>" + "<b>Sales Eng.:</b> "
				+ theLData.getSeName() + "<br/>" + "<b>SE Response :</b> <b style=\"color:blue;\">" + processDescription
				+ "</b><br/>" + "<b>Remarks :</b>   " + theLData.getAckRemarks() + "<br/>" + "</p>";

		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub("FJ Marketing Portal- " + leadTypeText + " Lead Acknowledgment By Sales Engineer - FJMKT"
				+ theLData.getLeadUnfctnCode());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to marketing team P2  for lead : " + theLData.getId() + " status : "
					+ status);
			return 0;
		} else {
			System.out.print("Sent SE acknwoledgment mail  Sucessfully P2 for lead : " + theLData.getId() + " status : "
					+ status);
		}
		return status;
	}

	public int sendFollowupMailToMktProcees3(MktSalesLeads theLData, String leadType, String p3AckDesc,
			String processWorkingStatus, String empployee_Code) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead
		String leadTypeText = leadType;
		String ccAddress = getEmailIdByEmpcode(theLData.getSeEmpCode()); // +","+getDmEmailIdByEmpcode(se_Emp_Code);//
																			// no need to sent mail to DM on this stage
		String toAddress = "";
		try {
			toAddress = getMarketingTeamMailIds(empployee_Code);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("To Address : " + toAddress);
		System.out.println("To Address : " + ccAddress);

		String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>"
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>  "
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>" + "<p>Sales engineer has <b>" + processWorkingStatus
				+ "</b>  the sales lead code  FJMKT" + theLData.getLeadUnfctnCode()
				+ ". Please check the details.<br />  " + "<h4><u>Details</u></h4>"
				+ "<b>Lead Type :</b>  <b style=\"color:blue;\">" + leadTypeText + "</b><br/> "
				+ "<b>Lead Code :</b>  FJMKT" + theLData.getLeadUnfctnCode() + "<br/>" + "<b>Sales Eng. :</b> "
				+ theLData.getSeName() + "<br/>" + "<b>Follow-Up Status :</b> " + p3AckDesc + "<br/>"
				+ "<b>SO Number :</b>  " + checkNullValidation(theLData.getSoNumber()) + " <br/>"
				+ "<b>Project Code :</b>  " + theLData.getPrjctCode() + " <br/>" + "<b>LOI Received? :</b>  "
				+ checkLoiLpoValidation(theLData.getLoi()) + " <br/>" + "<b>LPO Received? :</b>  "
				+ checkLoiLpoValidation(theLData.getLpo()) + " <br/>" + "<b>Offer Value (AED) :</b>  "
				+ theLData.getOfferValue() + "<br/>" + "<b>Sales Eng. Remarks :</b>  <b style=\"color:blue;\"> "
				+ theLData.getSeRemarks() + "</b><br/></p>";

		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub("FJ Marketing Portal- " + leadTypeText + " Response By Sales Engineer - FJMKT"
				+ theLData.getLeadUnfctnCode());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to marketing team P3 (marketing sales lead) for lead : "
					+ theLData.getId() + " status : " + status);
			return 0;
		} else {
			System.out
					.print("P3 Sent Submit Form Sucessfully P3 for lead : " + theLData.getId() + " status : " + status);
		}
		return status;
	}

	private String checkLoiLpoValidation(String value) {
		String out = "NO";
		if (value == null || value.equals("0")) {
			return out;
		} else {

			return "YES";
		}

	}

	private String checkNullValidation(String value) {
		String out = "-";
		if (value == null) {
			return out;
		} else {

			return value;
		}

	}

	public int sendCloseLeadMailToSalesEngineerProcees4(MktSalesLeads theLData, String empployee_Code,
			String leadType) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead
		int leadStatus = Integer.parseInt(theLData.getMktStatus());
		String leadTypeText = leadType;
		String leadStatusText = "";
		String ccAddress = "";
		try {
			ccAddress = getMarketingTeamMailIds(empployee_Code) + "," + getDmEmailIdByEmpcode(empployee_Code);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String toAddress = getEmailIdByEmpcode(empployee_Code);// to address
		System.out.println("TO Address : " + toAddress);
		System.out.println("CC Address : " + ccAddress);

		if (leadStatus == 1) {
			leadStatusText = "Success";
		} else if (leadStatus == 2) {
			leadStatusText = "Not Success";
		} else {
			leadStatusText = "Other";
		}

		String msg = " <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">"
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>  "
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>  "
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>" + "<p>FJ Marketing team has <b>closed/completed</b> lead code  FJMKT"
				+ theLData.getLeadUnfctnCode() + ". Please check the details,<br />  " + "<h4><u>Details</u></h4>"
				+ "<b>Lead Type :</b> <b style=\"color:blue;\">" + leadTypeText + "</b><br/>"
				+ "<b>Leade Code :</b>  FJMKT" + theLData.getLeadUnfctnCode() + "<br/>" + "<b>Sales Eng. :</b> "
				+ theLData.getSeName() + "<br/>" + "<b> Remarks :  </b><b style=\"color:blue;\"> "
				+ theLData.getMktRemarks() + "</b><br/>" + "<b>Lead Close Status :</b>" + leadStatusText + "<br/>"
				+ "Contact FJ Marketing Team  for more information.</p>";
		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub("FJ Marketing Portal - " + leadTypeText + " Closed By Marketing Team - FJMKT"
				+ theLData.getLeadUnfctnCode());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to sales engineer P4  for lead : " + theLData.getId() + " status : "
					+ status);
			return 0;
		} else {
			System.out.print(
					"Sent close lead mail Sucessfully P4 for lead : " + theLData.getId() + " status : " + status);
		}
		return status;
	}

	public int sendMailToSalesEngineerProcees1(MktSalesLeads theLData, String employeeCode) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead
		String ccAddress = "";
		try {
			ccAddress = getMarketingTeamMailIds(employeeCode) + "," + getDmEmailIdByEmpcode(theLData.getSeEmpCode());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String toAddress = getEmailIdByEmpcode(theLData.getSeEmpCode());

		System.out.println("TO Address : " + toAddress);
		System.out.println("CC Address : " + ccAddress);

		String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>"
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>"
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>"
				+ "<p>FJ Marketing team has created new sales lead intiative. Please check the type of lead and details,<br/> "
				+ "<h4><u>Details</u></h4> " + "<b>Lead Code :</b>  FJMKT" + theLData.getLeadUnfctnCode() + "<br/>"
				+ "<b>Lead Type :</b> <b style=\"color:blue;\"> " + theLData.getType() + "</b><br/>"
				+ "<b>Division :</b>  " + theLData.getDivision() + "<br/>" + "<b>Sales Engineer :  </b> "
				+ theLData.getSeName() + "<br/> " + "<b>Product :</b>   " + theLData.getPrdct() + "<br />  "
				+ "<b>Contractor :</b>  " + theLData.getContractor() + "<br/>" + "<b>Consultant :</b>  "
				+ theLData.getConsultant() + "<br/>" + "<b>Project Details :</b>  " + theLData.getProjectDetails()
				+ "<br/>";
		if (theLData.getTypeCode().equals("SL013")) {
			msg += "<b>Project Code :</b>  <b style=\"color:blue;\">  " + theLData.getPrjctCode() + "</b><br/>"
					+ "<b>Already Quoted Divisions :</b> <b style=\"color:blue;\">  " + theLData.getStage2QtdDivisions()
					+ "</b><br/>";
		}
		msg += "<b>Lead Remarks :</b> <b style=\"color:blue;\"> " + theLData.getLeadRemarks() + "</b><br/>";

		msg += "Contact FJ Marketing Team  for more information.</p>";

		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		// sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub(
				"FJ Marketing Portal - " + theLData.getType() + " - FJMKT" + theLData.getLeadUnfctnCode());
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to sales engineer P1  for lead : " + theLData.getId() + " status : "
					+ status);
		} else {
			System.out.print("Sent Submit Form Sucessfully P1  for lead : " + theLData.getId() + " status : " + status);
		}
		return status;
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

	public String getDmEmailIdByEmpcode(String empcode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;

		String sql = "SELECT SM_FLEX_05 FROM OM_SALESMAN Where SM_FLEX_08 = ? ";

		/*
		 * String sqlstr =
		 * "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS  WHERE TXNFIELD_EMP_CODE = ("
		 * + "SELECT TXNFIELD_FLD3 FROM FJPORTAL.PT_TXN_FLEX_FIELDS " +
		 * "WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1"
		 * + ") AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		 */
		// String sqlstr = "SELECT TXNFIELD_FLD5 FROM ORION.PT_TXN_FLEX_FIELDS WHERE
		// TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, empcode);
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

	public String getSalesEngListfor_Dm(String dm_emp_code) throws SQLException {

		String salesEngList = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "SELECT SM_FLEX_08 FROM OM_SALESMAN  "
					+ "WHERE SM_FLEX_08 IN (SELECT EMP_CODE FROM PM_EMP_KEY "
					+ "WHERE EMP_STATUS IN (1,2)  AND EMP_FRZ_FLAG='N') "
					+ "AND SM_FLEX_07='Y' AND SM_FRZ_FLAG_NUM=2 and SM_FLEX_18 = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);// division manager employee code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				salesEngList += "" + myRes.getString(1) + ",";
			}
			if (salesEngList != null && salesEngList.length() > 0) {
				salesEngList = salesEngList.substring(0, salesEngList.length() - 1);
			}
			// System.out.println(salesEngList);
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<MktConfig> getAcknowledgmentLists(String typeCode, int processStage) throws SQLException {
		// System.out.println("CODE : "+typeCode+" stage: "+processStage);
		// TODO get acknowledment type for process 2 and 3
		List<MktConfig> ackList = new ArrayList<>();
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			if (processStage == 3) {// sales engineer follow up stage
				sql = " select description, status, sendMail, seFpStage  "
						+ " from mkt_acknowledgments where ( type_code = ? or type_code = 'SL000' ) and seFpStage != 0 and process = ?  ";
			} else {
				sql = " select description, status, sendMail, seFpStage  "
						+ " from mkt_acknowledgments where type_code = ? and process = ? ";
			}
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, typeCode);
			myStmt.setInt(2, processStage);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String description = myRes.getString(1);
				int status = myRes.getInt(2);
				int mailSendYN = myRes.getInt(3);
				int seFpStage = myRes.getInt(4);

				// System.out.println(description+" "+status+" "+mailSendYN);
				MktConfig tempAckList = new MktConfig(description, status, mailSendYN, seFpStage);
				ackList.add(tempAckList);

			}

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
		return ackList;
	}

	public List<MktSalesLeads> getStage2ProjectDetails(String projectCode) throws SQLException {

		List<MktSalesLeads> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = " SELECT B.VSSV_CODE,B.VSSV_NAME PROJNAME, " + "B.VSSV_BL_SHORT_NAME CONSULCODE, "
					+ "(SELECT A.VSSV_NAME FROM IM_VS_STATIC_VALUE A WHERE A.VSSV_VS_CODE = 'CONSULT' "
					+ "AND A.VSSV_CODE = B.VSSV_BL_SHORT_NAME ) CONSULNAME, " + "B.VSSV_FIELD_01 MAINCONTCODE, "
					+ "(SELECT CUST_NAME FROM OM_CUSTOMER WHERE CUST_CODE= B.VSSV_FIELD_01) MAINCONTNAME, "
					+ "B.VSSV_FIELD_02 MEPCONTCODE, "
					+ "(SELECT CUST_NAME FROM OM_CUSTOMER WHERE CUST_CODE= B.VSSV_FIELD_02) MEPCONTNAME, "
					+ "B.VSSV_FIELD_03 ZONE, " + "B.VSSV_FIELD_04 CLIENT, " + "NULL QUOTDETAIL "
					+ "FROM IM_VS_STATIC_VALUE B " + "WHERE B.VSSV_VS_CODE='PROJECT' " + "AND B.VSSV_CODE LIKE ? "
					+ "AND B.VSSV_CODE NOT IN (SELECT DISTINCT A.CQH_FLEX_01 FROM OT_CUST_QUOT_HEAD A) " + "UNION ALL "
					+ "SELECT DISTINCT B.VSSV_CODE,B.VSSV_NAME PROJNAME, "
					+ "NVL(B.VSSV_BL_SHORT_NAME,'-') CONSULCODE, "
					+ "NVL((SELECT A.VSSV_NAME FROM IM_VS_STATIC_VALUE A WHERE A.VSSV_VS_CODE = 'CONSULT' "
					+ "AND A.VSSV_CODE = B.VSSV_BL_SHORT_NAME ),'-') CONSULNAME, "
					+ "NVL(B.VSSV_FIELD_01,'-') MAINCONTCODE, "
					+ "NVL((SELECT CUST_NAME FROM OM_CUSTOMER WHERE CUST_CODE= B.VSSV_FIELD_01),'-') MAINCONTNAME, "
					+ "NVL(B.VSSV_FIELD_02,'-') MEPCONTCODE, "
					+ "NVL((SELECT CUST_NAME FROM OM_CUSTOMER WHERE CUST_CODE= B.VSSV_FIELD_02),'-') MEPCONTNAME, "
					+ "NVL(B.VSSV_FIELD_03,'-') ZONE, " + "NVL(B.VSSV_FIELD_04,'-') CLIENT, "
					+ "NVL((D.FJTDIVNNAME||'-'||C.SM_NAME  " + "),'-')  QUOTDETAIL "
					+ "FROM IM_VS_STATIC_VALUE B ,OT_CUST_QUOT_HEAD A,OM_SALESMAN C,FJT_DMSM_TBL D "
					+ "WHERE B.VSSV_VS_CODE='PROJECT' " + "AND B.VSSV_CODE LIKE ? "
					+ "AND A.CQH_SM_CODE = C.SM_CODE AND A.CQH_SM_CODE = D.SM_CODE AND C.SM_CODE = D.SM_CODE "
					+ "AND A.CQH_TXN_CODE = D.FJTTXNCODE " + "  AND A.CQH_FLEX_01 = B.VSSV_CODE ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, projectCode);// project unification code
			myStmt.setString(2, projectCode);// project unification code
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String code = myRes.getString(1);
				String projectName = myRes.getString(2);
				String consultantCode = myRes.getString(3);
				String consultantName = myRes.getString(4);
				String mainContractor = myRes.getString(5);
				String mainContractorName = myRes.getString(6);
				String mepContractor = myRes.getString(7);
				String mepContractorName = myRes.getString(8);
				String zone = myRes.getString(9);
				String client = myRes.getString(10);
				String segDivDetails = myRes.getString(11);

				// System.out.println(description+" "+status+" "+mailSendYN);
				MktSalesLeads tempProjectList = new MktSalesLeads(code, projectName, consultantCode, consultantName,
						mainContractor, mainContractorName, mepContractor, mepContractorName, zone, client,
						segDivDetails);
				projectList.add(tempProjectList);
			}
			// System.out.println(salesEngList);
			return projectList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Mkt_SEFollowUp> getSalesEngineerFollowUpAckStageWiseDetails(int leadId) throws SQLException {
		// leads details for Sales Engineers
		List<Mkt_SEFollowUp> segFpList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT * FROM mkt_seFollowUp_Process where lead_id = ? limit 1";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setInt(1, leadId);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String process_id = myRes.getString(1);
				String lead_id = myRes.getString(2);
				String process31_status = myRes.getString(3);
				String process31_desc = myRes.getString(4);
				String process31_on = myRes.getString(5);
				String process32_status = myRes.getString(6);
				String process32_desc = myRes.getString(7);
				String process32_on = myRes.getString(8);
				String process33_status = myRes.getString(9);
				String process33_desc = myRes.getString(10);
				String process33_on = myRes.getString(11);
				String lastPrccsdStage = myRes.getString(12);

				Mkt_SEFollowUp tempSegFpList = new Mkt_SEFollowUp(process_id, lead_id, process31_status, process31_desc,
						process31_on, process32_status, process32_desc, process32_on, process33_status, process33_desc,
						process33_on, lastPrccsdStage);
				segFpList.add(tempSegFpList);

			}
			return segFpList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public String checkDMorNot(String seEmpCode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD3 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		// String sqlstr = "SELECT TXNFIELD_FLD5 FROM ORION.PT_TXN_FLEX_FIELDS WHERE
		// TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, seEmpCode);
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

	public String getMarketingTeamMailIds(String employeeCode) throws SQLException {

		String mailAddresses = "";
		String type = "MKTMD";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt, password means loaction
			String sql = " select emailid from  emailconf where usagetype = ?  and password = (SELECT location FROM  mkt_employee_location "
					+ " where employee_id = ? LIMIT 1)";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, type);
			myStmt.setString(2, employeeCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
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

	public String getSalesLocation(String empployee_Code) throws SQLException {
		String location = "";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT location FROM  mkt_employee_location " + "where employee_id = ? LIMIT 1";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, empployee_Code);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				location = myRes.getString(1);
			}
			return location;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}
}
