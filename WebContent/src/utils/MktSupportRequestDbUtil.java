package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import beans.EmailMarketing;
import beans.MktConfig;
import beans.MktSalesLeads;
import beans.MktSupportRequest;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class MktSupportRequestDbUtil {

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

			// set the param values for the student
			myStmt.setString(1, category);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String id_temp = myRes.getString(1);
				String type_temp = myRes.getString(2);
				String category_temp = myRes.getString(3);

				MktConfig tempTypeList = new MktConfig(id_temp, type_temp, category_temp);
				typeList.add(tempTypeList);

			}
			return typeList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktSupportRequest> getRequestDetailsGeneral() throws SQLException {
		// leads details for Marketing TEAM and Managment
		List<MktSupportRequest> requestList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "select * from support_requests order by id desc ";
			// String sql = "select sr.*,bdmflup.bdm_followup_remarks from support_requests
			// sr left join bdm_followup_data AS bdmflup ON sr.id=bdmflup.req_id order by id
			// desc";
			myStmt = myCon.prepareStatement(sql);

			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String type_temp = myRes.getString(2);
				String divn_temp = myRes.getString(3);
				String product_temp = myRes.getString(4);
				String consultant_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				float offerVal_temp = myRes.getFloat(7);
				String projectDtls_tmp = myRes.getString(8);
				String initialSeRemarks_tmp = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String requestedOn_temp = myRes.getString(12);
				String requestedStatus_temp = myRes.getString(13);

				String mktAccptRemarkss_temp = myRes.getString(14);
				String mktAccptStatus_temp = myRes.getString(15);
				String mktAcceptBy_temp = myRes.getString(16);
				String mktAcceptOn_temp = myRes.getString(17);

				String mktRemark_temp = myRes.getString(18);
				String mktfolloupBy_temp = myRes.getString(19);
				String mktActedOn_temp = myRes.getString(20);
				String mktfpStatus_temp = myRes.getString(21);

				String seRemarks_tmp = myRes.getString(22);
				String se_folloupOn_temp = myRes.getString(23);
				String se_folloupStatus_temp = myRes.getString(24);
				MktSupportRequest tempRequestList = new MktSupportRequest(mktid, type_temp, divn_temp, product_temp,
						consultant_temp, contact_temp, offerVal_temp, projectDtls_tmp, initialSeRemarks_tmp,
						seempCode_temp, seempName_temp, requestedOn_temp, requestedStatus_temp, mktAccptRemarkss_temp,
						mktAccptStatus_temp, mktAcceptBy_temp, mktAcceptOn_temp, mktRemark_temp, mktfolloupBy_temp,
						mktActedOn_temp, mktfpStatus_temp, seRemarks_tmp, se_folloupOn_temp, se_folloupStatus_temp);
				requestList.add(tempRequestList);

			}
			return requestList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktSupportRequest> getSupportRequestDetailsForSalesEng(String empCode) throws SQLException {
		// leads details for Sales Engineers
		List<MktSupportRequest> requestList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select * from support_requests  where se_emp_code = ?  order by id desc";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, empCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String type_temp = myRes.getString(2);
				String divn_temp = myRes.getString(3);
				String product_temp = myRes.getString(4);
				String consultant_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				float offerVal_temp = myRes.getFloat(7);
				String projectDtls_tmp = myRes.getString(8);
				String initialSeRemarks_tmp = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String requestedOn_temp = myRes.getString(12);
				String requestedStatus_temp = myRes.getString(13);

				String mktAccptRemarkss_temp = myRes.getString(14);
				String mktAccptStatus_temp = myRes.getString(15);
				String mktAcceptBy_temp = myRes.getString(16);
				String mktAcceptOn_temp = myRes.getString(17);

				String mktRemark_temp = myRes.getString(18);
				String mktfolloupBy_temp = myRes.getString(19);
				String mktActedOn_temp = myRes.getString(20);
				String mktfpStatus_temp = myRes.getString(21);

				String seRemarks_tmp = myRes.getString(22);
				String se_folloupOn_temp = myRes.getString(23);
				String se_folloupStatus_temp = myRes.getString(24);

				MktSupportRequest tempRequestList = new MktSupportRequest(mktid, type_temp, divn_temp, product_temp,
						consultant_temp, contact_temp, offerVal_temp, projectDtls_tmp, initialSeRemarks_tmp,
						seempCode_temp, seempName_temp, requestedOn_temp, requestedStatus_temp, mktAccptRemarkss_temp,
						mktAccptStatus_temp, mktAcceptBy_temp, mktAcceptOn_temp, mktRemark_temp, mktfolloupBy_temp,
						mktActedOn_temp, mktfpStatus_temp, seRemarks_tmp, se_folloupOn_temp, se_folloupStatus_temp);
				requestList.add(tempRequestList);

			}
			return requestList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktSupportRequest> getSupportRequestDetailsForDm(String empCode, String salesEngList)
			throws SQLException {
		// leads details for Sales Engineers
		List<MktSupportRequest> requestList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select * from support_requests  where se_emp_code = ?  or  se_emp_code in  (" + salesEngList
					+ ")  order by id desc";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, empCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String type_temp = myRes.getString(2);
				String divn_temp = myRes.getString(3);
				String product_temp = myRes.getString(4);
				String consultant_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				float offerVal_temp = myRes.getFloat(7);
				String projectDtls_tmp = myRes.getString(8);
				String initialSeRemarks_tmp = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String requestedOn_temp = myRes.getString(12);
				String requestedStatus_temp = myRes.getString(13);

				String mktAccptRemarkss_temp = myRes.getString(14);
				String mktAccptStatus_temp = myRes.getString(15);
				String mktAcceptBy_temp = myRes.getString(16);
				String mktAcceptOn_temp = myRes.getString(17);

				String mktRemark_temp = myRes.getString(18);
				String mktfolloupBy_temp = myRes.getString(19);
				String mktActedOn_temp = myRes.getString(20);
				String mktfpStatus_temp = myRes.getString(21);

				String seRemarks_tmp = myRes.getString(22);
				String se_folloupOn_temp = myRes.getString(23);
				String se_folloupStatus_temp = myRes.getString(24);

				MktSupportRequest tempRequestList = new MktSupportRequest(mktid, type_temp, divn_temp, product_temp,
						consultant_temp, contact_temp, offerVal_temp, projectDtls_tmp, initialSeRemarks_tmp,
						seempCode_temp, seempName_temp, requestedOn_temp, requestedStatus_temp, mktAccptRemarkss_temp,
						mktAccptStatus_temp, mktAcceptBy_temp, mktAcceptOn_temp, mktRemark_temp, mktfolloupBy_temp,
						mktActedOn_temp, mktfpStatus_temp, seRemarks_tmp, se_folloupOn_temp, se_folloupStatus_temp);
				requestList.add(tempRequestList);
			}
			return requestList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public MktSupportRequest createNewSupportRequest(MktSupportRequest theLData) throws SQLException {
		int logType = -1;
		int leadId = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();

		try {
			myCon = con.getMysqlConn();

			String sql = "insert into support_requests(type, division, product, consultant, contractor, offervalue, project_details, initialSeRemarks, se_emp_code, se_name, requestedOn, request_status) "
					+ "values(?,?,?,?,?,?,?,?,?,?, sysdate(),1)";

			// very important
			myStmt = myCon.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			// set the param values for the student
			myStmt.setString(1, theLData.getType());
			myStmt.setString(2, theLData.getDivision());
			myStmt.setString(3, theLData.getProduct());
			myStmt.setString(4, theLData.getConsultant());
			myStmt.setString(5, theLData.getContractor());
			myStmt.setDouble(6, theLData.getOfferValue());
			myStmt.setString(7, theLData.getProjectDetails());
			myStmt.setString(8, theLData.getInitialReamrks());
			myStmt.setString(9, theLData.getSeEmpCode());
			myStmt.setString(10, theLData.getSeName());

			// execute sql query
			logType = myStmt.executeUpdate();
			ResultSet rs = myStmt.getGeneratedKeys();
			if (rs.next()) {
				leadId = rs.getInt(1);
			}

			// System.out.println("RETURN KEY WORD - "+leadId);
			// System.out.println("Update Status - "+logType);
			return new MktSupportRequest(logType, leadId);

		} finally {
			// close jdbc objects
			// System.out.println(" "+logType);
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public List<MktSalesLeads> getProductList(String divisionCode) throws SQLException {
		List<MktSalesLeads> productList = new ArrayList<>();
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
			// set the param values for the student
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

	public List<MktSalesLeads> getSalesEngList() throws SQLException {
		// sales engineer list expect EME - SEG's and Sales with DM status
		List<MktSalesLeads> salesEngList = new ArrayList<>();
		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SM_CODE,SM_NAME,SM_FLEX_08 FROM OM_SALESMAN " + "WHERE sm_frz_flag_num=2   "
					+ "AND (sm_flex_07='Y') AND SM_FLEX_08 IN ( SELECT EMP_CODE FROM PM_EMP_KEY WHERE EMP_FRZ_FLAG = 'N'"
					+ " AND (EMP_STATUS = '1' OR EMP_STATUS ='2') and EMP_COMP_CODE NOT IN ('EME')) Order by SM_NAME  ";
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

	public List<MktSupportRequest> getSupportRequestForMktEdit(int id) throws SQLException {
		// leads details for Sales Engineers
		List<MktSupportRequest> requestList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select * from support_requests  where id = ?  order by id desc";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, id);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String type_temp = myRes.getString(2);
				String divn_temp = myRes.getString(3);
				String product_temp = myRes.getString(4);
				String consultant_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				float offerVal_temp = myRes.getFloat(7);
				String projectDtls_tmp = myRes.getString(8);
				String initialSeRemarks_tmp = myRes.getString(9);
				String seempCode_temp = myRes.getString(10);
				String seempName_temp = myRes.getString(11);
				String requestedOn_temp = myRes.getString(12);
				String requestedStatus_temp = myRes.getString(13);

				String mktAccptRemarkss_temp = myRes.getString(14);
				String mktAccptStatus_temp = myRes.getString(15);
				String mktAcceptBy_temp = myRes.getString(16);
				String mktAcceptOn_temp = myRes.getString(17);

				String mktRemark_temp = myRes.getString(18);
				String mktfolloupBy_temp = myRes.getString(19);
				String mktActedOn_temp = myRes.getString(20);
				String mktfpStatus_temp = myRes.getString(21);

				String seRemarks_tmp = myRes.getString(22);
				String se_folloupOn_temp = myRes.getString(23);
				String se_folloupStatus_temp = myRes.getString(24);
				List<String> followupRemarks = getFollowupDataofCurrentObject(mktid);
				MktSupportRequest tempRequestList = new MktSupportRequest(mktid, type_temp, divn_temp, product_temp,
						consultant_temp, contact_temp, offerVal_temp, projectDtls_tmp, initialSeRemarks_tmp,
						seempCode_temp, seempName_temp, requestedOn_temp, requestedStatus_temp, mktAccptRemarkss_temp,
						mktAccptStatus_temp, mktAcceptBy_temp, mktAcceptOn_temp, mktRemark_temp, mktfolloupBy_temp,
						mktActedOn_temp, mktfpStatus_temp, seRemarks_tmp, se_folloupOn_temp, se_folloupStatus_temp,
						followupRemarks);
				requestList.add(tempRequestList);

			}
			return requestList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public int updateSupportRequestAcceptOrNotProcess2(MktSupportRequest updatedtls) throws SQLException {
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update support_requests set  support_accept_status =?, support_accept_by = ?, support_accept_remarks = ?, support_accept_on = sysdate() "
					+ " where id = ? ";

			// very important
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, updatedtls.getP2Status());
			myStmt.setString(2, updatedtls.getSupport_accept_by());
			myStmt.setString(3, updatedtls.getSupport_accept_remarks());
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

	public int updateSalesEngineerFollowupProcess4(MktSupportRequest updatedtls, String seEmpCode) throws SQLException {
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update support_requests set  se_remarks =?, se_update_on = sysdate() ,se_update_status = 1 "
					+ " where id = ?  and se_emp_code = ? ";

			// very important
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, updatedtls.getSe_remarks());
			myStmt.setString(2, updatedtls.getId());
			myStmt.setString(3, seEmpCode);

			// execute sql query
			logType = myStmt.executeUpdate();

			return logType;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int updateMarketingTeamFollowupProcess3(MktSupportRequest updatedtls, String empployee_Code, String status)
			throws SQLException {
		// UPDATE MARKETING TEAM FOLLOWUPS, Process 3
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		int logUpdate = -1;
		String sql = "";
		try {
			myCon = con.getMysqlConn();
			if (status.equals("FLUP")) {
				logUpdate = updateFollowupdata(updatedtls, empployee_Code);
			}
			if (status.equals("FLUP")) {
				sql = "update support_requests set  mkt_followup_on = sysdate(), mkt_followup_status = 0 , mkt_followup_by = ?"
						+ " where id = ? ";
			} else if (status.equals("COMPL")) {
				sql = "update support_requests set  mkt_followup_on = sysdate(), mkt_followup_status = 1 , mkt_followup_by = ?"
						+ " where id = ? ";
			}
			// very important
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empployee_Code);
			myStmt.setString(2, updatedtls.getId());

			// execute sql query
			logType = myStmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Error in updateMarketingTeamFollowupProcess3" + e);
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
		return logType;
	}

	public int updateFollowupdata(MktSupportRequest updatedtls, String empployee_Code) throws SQLException {
		// UPDATE MARKETING TEAM FOLLOWUPS, Process 3
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();
			String sql = "insert into  bdm_followup_data (bdm_followup_by,bdm_followup_remarks,req_id,bdm_followup_on) values(?,?,?,sysdate())";

			// very important
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, empployee_Code);
			myStmt.setString(2, updatedtls.getMkt_remarks());
			myStmt.setString(3, updatedtls.getId());
			// execute sql query
			logType = myStmt.executeUpdate();
			return logType;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int deleteLead(String cid) throws SQLException {
		int logType = -1;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from  support_requests  " + " where  id = ? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, cid);
			logType = myStmt.executeUpdate();

			return logType;

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public int sendMailToMarketingProcees1(MktSupportRequest theLData, int requestId) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead
		String leadTypeText = theLData.getType();
		String ccAddress = getEmailIdByEmpcode(theLData.getSeEmpCode()) + ","
				+ getDmEmailIdByEmpcode(theLData.getSeEmpCode());
		String toAddress = "";
		try {
			toAddress = getMarketingTeamMailIds();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("To Address : " + toAddress);
		System.out.println("To Address : " + ccAddress);
		double valueOfferDb = theLData.getOfferValue();
		String offerValue = new DecimalFormat("###").format(valueOfferDb);

		String msg = "<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">  "
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>"
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>  "
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>"
				+ "<p>Sales engineer has created new support request. Please check the type of request and details.<br />  "
				+ "<h4><u>Deatils</u></h4>" + "<b>Request Code :</b> FJMSR" + requestId + "<br/>"
				+ "<b>Request Type :</b> " + leadTypeText + "<br/>" + "<b>Division :</b>   " + theLData.getDivision()
				+ "<br/>" + "<b>Product :</b>  " + theLData.getProduct() + " <br/>" + "<b>Consultant :</b>  "
				+ theLData.getConsultant() + " <br/>" + "<b>Contractor :</b>  " + theLData.getContractor() + " <br/>"
				+ "<b>Offer Value :</b>  " + offerValue + " <br/>" + "<b>Project Details :</b>  "
				+ theLData.getProjectDetails() + " <br/>" + "<b style=\"color:blue;\"> Remarks :  "
				+ theLData.getInitialReamrks() + "</b><br/>" + "<b>Requested by :</b>  " + theLData.getSeName()
				+ "</p>";

		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub("FJ Marketing Portal- New Support Request for " + leadTypeText + " / FJMSR" + requestId);
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to marketing team P1 (marketing support request)..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
		}
		return status;
	}

	public int sendMailToSaleEngProccess2(MktSupportRequest theLData, String salesEng_Emp_Code) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead

		String ccAddress = "";
		try {
			ccAddress = getMarketingTeamMailIds() + "," + getDmEmailIdByEmpcode(salesEng_Emp_Code);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String toAddress = getEmailIdByEmpcode(salesEng_Emp_Code);// to address

		System.out.println("To Address : " + toAddress);
		System.out.println("To Address : " + ccAddress);

		String acceptStatus = "";
		if (Integer.parseInt(theLData.getP2Status()) == 1) {
			acceptStatus = "Accepted/Initiated";
		} else {
			acceptStatus = "Declined";
		}

		String msg = " <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">"
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>  "
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>  "
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>" + "<p>FJ Marketing team  has " + acceptStatus + "  to the support request ("
				+ theLData.getType() + ")  code  FJMSR" + theLData.getId() + ".<br />  "
				+ "<b style=\"color:blue;\">Ack. Remarks by Mkt. :  " + theLData.getSupport_accept_remarks()
				+ ".</b><br />  " + "Contact FJ Marketing Team  for more information.</p>";
		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub("FJ Marketing Portal Support request acknowledgment by marketing team for "
				+ theLData.getType() + " / FJMSR" + theLData.getId() + "");
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to sales engineer P2 (marketing support reqst)..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
		}
		return status;
	}

	public int sendFollowupMailToSalesEngineerProcees3(MktSupportRequest theLData, String saleEng_Emp_Code) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer

		String ccAddress = "";
		try {
			ccAddress = getMarketingTeamMailIds() + "," + getDmEmailIdByEmpcode(saleEng_Emp_Code);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String toAddress = getEmailIdByEmpcode(saleEng_Emp_Code);// to address
		System.out.println("To Address : " + toAddress);
		System.out.println("To Address : " + ccAddress);
		String msg = " <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"width: 100%;\">"
				+ "<tr>" + "<td align=\"center\" style=\"padding: 40px 0 30px 0;background-color:#ffffff;\">"
				+ "<Strong style=\"font-size: 2em;\"><b style=\"color: #014888;font-family: sans-serif;\">FJ</b> <b style=\"color: #989090;font-family: sans-serif;\">Group</b></Strong>  "
				+ "<div style=\"height:2px;border-bottom:1px solid #014888\"></div>"
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>  "
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>" + "<p>FJ Marketing team has completed follow-up  to the support request "
				+ theLData.getType() + " FJMSR" + theLData.getId() + ".<br />  " + "<h4><u>Deatils</u></h4>"
				+ "<b style=\"color:blue;\">Follow-Up Remarks by MKT. : " + theLData.getMkt_remarks() + ". </b>  <br/>"
				+ "Contact FJ Marketing Team  for more information.</p>";
		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub("FJ Marketing Portal Support Request Follow-Up for " + theLData.getType() + " / FJMSR"
				+ theLData.getId() + "");
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to sales engineer P3 (marketing  support request)..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
		}
		return status;

	}

	public int sendMailToSalesEngineerProcees4(MktSupportRequest theLData, String empCode) {
		EmailMarketing sslmail = new EmailMarketing();
		// send mail to sales engineer for informing new lead
		String ccAddress = getEmailIdByEmpcode(empCode) + "," + getDmEmailIdByEmpcode(empCode);
		String toAddress = "";
		try {
			toAddress = getMarketingTeamMailIds();
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
				+ "<div style=\"font-size:18px;font-weight:700;margin-bottom:1px;margin-top:3px\">Marketing Portal</div>"
				+ "</td>" + "</tr>" + "<tr>"
				+ "<td bgcolor=\"#ffffff\" style=\"font-size:14px;padding:1em;font-family: monospace;\">"
				+ "<b>Dear User,</b>" + "<p>Sales engineer has  closed/completed  support request code FJMSR"
				+ theLData.getId() + "<br/>" + "Please check the dtails" + "<h4><u>Deatils</u></h4> "
				+ "<b>Code  :</b>  FJMSR" + theLData.getId() + "<br/> "
				+ "<b style=\"color:blue;\"> SE Final Remarks :   " + theLData.getSe_remarks() + ".</b> </p>  ";
		sslmail.setToaddr(toAddress);
		sslmail.setCcaddr(ccAddress);
		// sslmail.setCcaddr(ccAddress);
		sslmail.setMessageSub(
				"FJ Marketing Portal Support Request Closed By Sales Engineer for FJMSR" + theLData.getId() + " ");
		sslmail.setMessagebody(msg);
		int status = sslmail.sendMail();
		if (status != 1) {

			System.out.print("Error in sending Mail to marketing team P4 (marketing support request)..." + status);
			return 0;
		} else {
			System.out.print("Sent Submit Form Sucessfully..." + status);
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
		String sqlstr = " SELECT SM_FLEX_05 FROM OM_SALESMAN Where SM_FLEX_08 = ? ";
		// String sqlstr = "SELECT TXNFIELD_FLD5 FROM ORION.PT_TXN_FLEX_FIELDS WHERE
		// TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
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
				salesEngList += "'" + myRes.getString(1) + "',";
			}
			if (salesEngList != null && salesEngList.length() > 0) {
				salesEngList = salesEngList.substring(0, salesEngList.length() - 1);
			} else if (salesEngList.isEmpty()) {
				salesEngList = "''";
			}
			// System.out.println(salesEngList);
			return salesEngList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public String getMarketingTeamMailIds() throws SQLException {

		String mailAddresses = "";
		String type = "MKTMD";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select emailid from  emailconf where usagetype = ? ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values
			myStmt.setString(1, type);
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

	public List<String> getFollowupDataofCurrentObject(String id) throws SQLException {
		// leads details for Sales Engineers
		List<String> remarksList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " select bdm_followup_remarks from bdm_followup_data  where req_id = ?";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, id);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String followupremarks = myRes.getString(1);
				remarksList.add(followupremarks);

			}
			return remarksList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}
}
