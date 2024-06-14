package utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import beans.ConsultantLeads;
import beans.ConsultantVisits;
import beans.MarketingLeads;
import beans.MktSalesLeads;
import beans.MysqlDBConnectionPool;
import beans.OrclDBConnectionPool;

public class MarketingLeadsDbUtil {

	public void insertNewMarketingLeads(MarketingLeads theMLData) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "insert into marketing(oprtunity, status, location, leads, contact, product, remark, main_contractor, mep_contractor, updated_year, updated_by,week, updated_date, created_date) values(?,?,?,?,?,?,?,?,?,?,?,?,sysdate(),sysdate())";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, theMLData.getOpt());
			myStmt.setString(2, theMLData.getStatus());
			myStmt.setString(3, theMLData.getLocation());
			myStmt.setString(4, theMLData.getLeads());
			myStmt.setString(5, theMLData.getContactDtls());
			myStmt.setString(6, theMLData.getProducts());
			myStmt.setString(7, theMLData.getRemarks());
			myStmt.setString(8, theMLData.getMainContractor());
			myStmt.setString(9, theMLData.getMepContractor());
			myStmt.setString(10, theMLData.getUpdatedYr());
			myStmt.setString(11, theMLData.getUpdatedBy());
			myStmt.setString(12, theMLData.getUpdtdWeek());

			// execute sql query
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			con.closeConnection();

		}

	}

	public List<MarketingLeads> getMarketingLeadsDetails(String currYear) throws SQLException {
		int currentYear = Integer.parseInt(currYear);
		int prevYear = currentYear - 1;
		List<MarketingLeads> marketLeadsList = new ArrayList<>();
		String oppStatus = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "SELECT * from marketing where YEAR(created_date) in (?,?) order by updated_date desc ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, prevYear);
			myStmt.setInt(2, currentYear);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String opt_temp = myRes.getString(2);
				String status_temp = myRes.getString(3);
				String location_temp = myRes.getString(4);
				String leads_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String product_temp = myRes.getString(7);
				String remark_temp = myRes.getString(8);
				String main_contra_temp = myRes.getString(9);
				String mep_contra_temp = myRes.getString(10);
				String update_year_temp = myRes.getString(11);
				String updateby_temp = myRes.getString(12);
				String updateWeek_tmp = myRes.getString(13);
				String created_date_temp = myRes.getString(14);
				String updatedate_temp = myRes.getString(15);
				try {
					oppStatus = dateDiffStatus(updatedate_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				MarketingLeads tempmarketLeadsList = new MarketingLeads(mktid, opt_temp, status_temp, location_temp,
						leads_temp, contact_temp, product_temp, remark_temp, main_contra_temp, mep_contra_temp,
						update_year_temp, updateby_temp, updateWeek_tmp, created_date_temp, updatedate_temp, oppStatus);
				// System.out.println("goal_list"+goal_id);
				// add this to a array list of AppraisalHr
				marketLeadsList.add(tempmarketLeadsList);

			}
			return marketLeadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MarketingLeads> getAllMarketingLeadsDetailsforSalesEng(String currYear, String companyCode,
			String divnCode) throws SQLException {
		int currentYear = Integer.parseInt(currYear);
		int prevYear = currentYear - 1;
		List<MarketingLeads> marketLeadsList = new ArrayList<>();
		String oppStatus = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "SELECT * from marketing where YEAR(created_date) in(?,?) and product in(?,?,'AD')  order by updated_date desc ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, prevYear);
			myStmt.setInt(2, currentYear);
			myStmt.setString(3, companyCode);
			myStmt.setString(4, divnCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String opt_temp = myRes.getString(2);
				String status_temp = myRes.getString(3);
				String location_temp = myRes.getString(4);
				String leads_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String product_temp = myRes.getString(7);
				String remark_temp = myRes.getString(8);
				String main_contra_temp = myRes.getString(9);
				String mep_contra_temp = myRes.getString(10);
				String update_year_temp = myRes.getString(11);
				String updateby_temp = myRes.getString(12);
				String updateWeek_tmp = myRes.getString(13);
				String created_date_temp = myRes.getString(14);
				String updatedate_temp = myRes.getString(15);
				try {
					oppStatus = dateDiffStatus(updatedate_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				MarketingLeads tempmarketLeadsList = new MarketingLeads(mktid, opt_temp, status_temp, location_temp,
						leads_temp, contact_temp, product_temp, remark_temp, main_contra_temp, mep_contra_temp,
						update_year_temp, updateby_temp, updateWeek_tmp, created_date_temp, updatedate_temp, oppStatus);
				// System.out.println("goal_list"+goal_id);
				// add this to a array list of AppraisalHr
				marketLeadsList.add(tempmarketLeadsList);

			}
			return marketLeadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MarketingLeads> getMarketingLeadsforLast2Week(String currentYear) throws SQLException {
		List<MarketingLeads> marketLeadsList = new ArrayList<>();
		String oppStatus = "";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT * FROM marketing  "
					+ " WHERE week BETWEEN (select max(week) from  newfjtco.marketing  "
					+ " where updated_year=YEAR(sysdate()))-3 AND (select max(week) from  newfjtco.marketing  "
					+ " where updated_year=YEAR(sysdate()))  " + " and updated_year= ? "
					+ " order by updated_date desc ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, currentYear);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String opt_temp = myRes.getString(2);
				String status_temp = myRes.getString(3);
				String location_temp = myRes.getString(4);
				String leads_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String product_temp = myRes.getString(7);
				String remark_temp = myRes.getString(8);
				String main_contra_temp = myRes.getString(9);
				String mep_contra_temp = myRes.getString(10);
				String update_year_temp = myRes.getString(11);
				String updateby_temp = myRes.getString(12);
				String updateWeek_tmp = myRes.getString(13);
				String created_date_temp = myRes.getString(14);
				String updatedate_temp = myRes.getString(15);
				try {
					oppStatus = dateDiffStatus(updatedate_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				MarketingLeads tempmarketLeadsList = new MarketingLeads(mktid, opt_temp, status_temp, location_temp,
						leads_temp, contact_temp, product_temp, remark_temp, main_contra_temp, mep_contra_temp,
						update_year_temp, updateby_temp, updateWeek_tmp, created_date_temp, updatedate_temp, oppStatus);

				marketLeadsList.add(tempmarketLeadsList);

			}
			return marketLeadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MarketingLeads> getMarketingLeadsforLast2Week_Sales_Eng(String currentYear, String companyCode,
			String divnCode) throws SQLException {
		List<MarketingLeads> marketLeadsList = new ArrayList<>();
		String oppStatus = "";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT * FROM marketing  "
					+ " WHERE week BETWEEN (select max(week) from  newfjtco.marketing  "
					+ " where updated_year=YEAR(sysdate()))-3 AND (select max(week) from  newfjtco.marketing  "
					+ " where updated_year=YEAR(sysdate()))  " + " and  updated_year= ?  and product in(?,?,'AD')  "
					+ " order by updated_date desc ";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, currentYear);
			myStmt.setString(2, companyCode);
			myStmt.setString(3, divnCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String mktid = myRes.getString(1);
				String opt_temp = myRes.getString(2);
				String status_temp = myRes.getString(3);
				String location_temp = myRes.getString(4);
				String leads_temp = myRes.getString(5);
				String contact_temp = myRes.getString(6);
				String product_temp = myRes.getString(7);
				String remark_temp = myRes.getString(8);
				String main_contra_temp = myRes.getString(9);
				String mep_contra_temp = myRes.getString(10);
				String update_year_temp = myRes.getString(11);
				String updateby_temp = myRes.getString(12);
				String updateWeek_tmp = myRes.getString(13);
				String created_date_temp = myRes.getString(14);
				String updatedate_temp = myRes.getString(15);
				try {
					oppStatus = dateDiffStatus(updatedate_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				MarketingLeads tempmarketLeadsList = new MarketingLeads(mktid, opt_temp, status_temp, location_temp,
						leads_temp, contact_temp, product_temp, remark_temp, main_contra_temp, mep_contra_temp,
						update_year_temp, updateby_temp, updateWeek_tmp, created_date_temp, updatedate_temp, oppStatus);

				marketLeadsList.add(tempmarketLeadsList);

			}
			return marketLeadsList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

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

	public void editUpdateMarketingLeads(MarketingLeads theMLData) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "update marketing set oprtunity = ?, status =?, location =?, leads =?, contact =?, product =?, remark =?, main_contractor = ?, mep_contractor = ?, updated_year =?, updated_by =?, week=?, updated_date = sysdate() "
					+ " where id = ? ";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, theMLData.getOpt());
			myStmt.setString(2, theMLData.getStatus());
			myStmt.setString(3, theMLData.getLocation());
			myStmt.setString(4, theMLData.getLeads());
			myStmt.setString(5, theMLData.getContactDtls());
			myStmt.setString(6, theMLData.getProducts());
			myStmt.setString(7, theMLData.getRemarks());
			myStmt.setString(8, theMLData.getMainContractor());
			myStmt.setString(9, theMLData.getMepContractor());
			myStmt.setString(10, theMLData.getUpdatedYr());
			myStmt.setString(11, theMLData.getUpdatedBy());
			myStmt.setString(12, theMLData.getUpdtdWeek());
			myStmt.setString(13, theMLData.getId());

			// execute sql query
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void deleteUpdateMarketingLeads(String mlId) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "delete from  marketing  " + " where  id =? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, mlId);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	/*
	 * public int createnewConsultantLeads(ConsultantLeads consultant_Leads_Dtls)
	 * throws SQLException {
	 * 
	 * Connection myCon = null; PreparedStatement myStmt = null; ResultSet myRes =
	 * null; MysqlDBConnectionPool con = new MysqlDBConnectionPool(); int logType =
	 * 0; try { myCon = con.getMysqlConn();
	 * 
	 * String sql =
	 * "insert into consultant_leads(consultant,product,cnslt_status,division,remarks,create_year,created_by,created_date,updated_date,contact_details,byBDM) values(?,?,?,?,?,?,?,sysdate(),sysdate(),?,?)"
	 * ;
	 * 
	 * // very important myStmt = myCon.prepareStatement(sql);
	 * 
	 * // set the param values for the student myStmt.setString(1,
	 * consultant_Leads_Dtls.getConslt_name()); myStmt.setString(2,
	 * consultant_Leads_Dtls.getProduct()); myStmt.setString(3,
	 * consultant_Leads_Dtls.getStatus()); myStmt.setString(4,
	 * consultant_Leads_Dtls.getDivision()); myStmt.setString(5,
	 * consultant_Leads_Dtls.getRemarks()); myStmt.setString(6,
	 * consultant_Leads_Dtls.getCyr()); myStmt.setString(7,
	 * consultant_Leads_Dtls.getCby()); myStmt.setString(8,
	 * consultant_Leads_Dtls.getContactDetails()); myStmt.setString(9,
	 * consultant_Leads_Dtls.getIsUpdateByBDM()); // execute sql query logType =
	 * myStmt.executeUpdate();
	 * 
	 * } finally { // close jdbc objects
	 * 
	 * close(myStmt, myRes); con.closeConnection();
	 * 
	 * }
	 * 
	 * return logType; }
	 */
	public int createnewConsultantLeads(ConsultantLeads consultant_Leads_Dtls) throws SQLException {

		int logType = 0;
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();

			String sql = "insert into CONSULTANT_LEADS(consultant,product,cnslt_status,division,remarks,create_year,created_by,created_date,updated_date,contact_details,byBDM,CONSULTANT_TYPE) values(?,?,?,?,?,?,?,SYSDATE,SYSDATE,?,?,?)";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, consultant_Leads_Dtls.getConslt_name());
			myStmt.setString(2, consultant_Leads_Dtls.getProduct());
			myStmt.setString(3, consultant_Leads_Dtls.getStatus());
			myStmt.setString(4, consultant_Leads_Dtls.getDivision());
			myStmt.setString(5, consultant_Leads_Dtls.getRemarks());
			myStmt.setString(6, consultant_Leads_Dtls.getCyr());
			myStmt.setString(7, consultant_Leads_Dtls.getCby());
			myStmt.setString(8, consultant_Leads_Dtls.getContactDetails());
			myStmt.setString(9, consultant_Leads_Dtls.getIsUpdateByBDM());
			myStmt.setString(10, consultant_Leads_Dtls.getConsultantType());
			// execute sql query
			logType = myStmt.executeUpdate();

		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			orcl.closeConnection();

		}

		return logType;
	}

	/*
	 * public List<ConsultantLeads> getAllConsultantLeadsDetails(String currYear)
	 * throws SQLException { int currentYear = Integer.parseInt(currYear); int
	 * prevYear = currentYear - 1; String oppStatus = ""; List<ConsultantLeads>
	 * consultantLeads = new ArrayList<>();
	 * 
	 * Connection myCon = null; // PreparedStatement myStmt = null; Statement myStmt
	 * = null; ResultSet myRes = null; MysqlDBConnectionPool con = new
	 * MysqlDBConnectionPool(); try {
	 * 
	 * // Get Connection myCon = con.getMysqlConn();
	 * 
	 * // Execute sql stamt String sql =
	 * " SELECT id,consultant,product,cnslt_status,division,remarks,created_date,updated_date,contact_details,byBDM FROM consultant_leads  order by updated_date desc "
	 * ; myStmt = myCon.createStatement(); // Execute a SQL query myRes =
	 * myStmt.executeQuery(sql);
	 * 
	 * // Process the result set while (myRes.next()) { String cnsltid =
	 * myRes.getString(1); String cnslt_name_temp = myRes.getString(2); //
	 * System.out.println("consultant debug : "+cnslt_name_temp); String
	 * product_temp = myRes.getString(3); String status_temp = myRes.getString(4);
	 * String division_temp = myRes.getString(5); ArrayList<String> productList =
	 * this.getProductListForSelDivn(division_temp); HashMap<String,
	 * ArrayList<String>> hashmap = new HashMap<String, ArrayList<String>>();
	 * hashmap.put(division_temp, productList); String remarks_temp =
	 * myRes.getString(6); String created_date_temp = myRes.getString(7); String
	 * updated_date_temp = myRes.getString(8); String contact_details =
	 * myRes.getString(9); String byBDM = myRes.getString(10); try { oppStatus =
	 * dateDiffStatus(updated_date_temp, created_date_temp);
	 * 
	 * // System.out.println(oppStatus); } catch (ParseException e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); }
	 * 
	 * ConsultantLeads tempConsultantLeadsList = new ConsultantLeads(cnsltid,
	 * cnslt_name_temp, product_temp, status_temp, division_temp, remarks_temp,
	 * created_date_temp, updated_date_temp, oppStatus, hashmap, contact_details,
	 * byBDM);
	 * 
	 * consultantLeads.add(tempConsultantLeadsList);
	 * 
	 * } return consultantLeads;
	 * 
	 * } finally { // close jdbc objects close(myStmt, myRes);
	 * con.closeConnection();
	 * 
	 * } }
	 */
	public List<ConsultantLeads> getAllConsultantLeadsDetails(String currYear) throws SQLException {
		int currentYear = Integer.parseInt(currYear);
		int prevYear = currentYear - 1;
		String oppStatus = "";
		List<ConsultantLeads> consultantLeads = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		ResultSet myRes = null;
		try {

			// Get Connection
			myCon = orcl.getOrclConn();

			// Execute sql stamt
			String sql = " SELECT id,consultant,product,cnslt_status,division,remarks,created_date,updated_date,contact_details,byBDM,(select EMP_NAME from FJPORTAL.PM_EMP_KEY where EMP_CODE = CREATED_BY and EMP_END_OF_SERVICE_DT is null) AS CREATED_BY,CONSULTANT_TYPE FROM CONSULTANT_LEADS  order by updated_date desc ";
			myStmt = myCon.prepareStatement(sql);
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);

			// Process the result set
			while (myRes.next()) {
				String cnsltid = myRes.getString(1);
				String cnslt_name_temp = myRes.getString(2);
				// System.out.println("consultant debug : "+cnslt_name_temp);
				String product_temp = myRes.getString(3);
				String status_temp = myRes.getString(4);
				String division_temp = myRes.getString(5);
				ArrayList<String> productList = this.getProductListForSelDivn(division_temp);
				HashMap<String, ArrayList<String>> hashmap = new HashMap<String, ArrayList<String>>();
				hashmap.put(division_temp, productList);
				String remarks_temp = myRes.getString(6);
				String created_date_temp = myRes.getString(7);
				String updated_date_temp = myRes.getString(8);
				String contact_details = myRes.getString(9);
				String byBDM = myRes.getString(10);
				String createdBy = myRes.getString(11);
				String consultantType = myRes.getString(12);
				try {
					oppStatus = dateDiffStatus(updated_date_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				ConsultantLeads tempConsultantLeadsList = new ConsultantLeads(cnsltid, cnslt_name_temp, product_temp,
						status_temp, division_temp, remarks_temp, created_date_temp, updated_date_temp, oppStatus,
						hashmap, contact_details, byBDM, createdBy, consultantType);

				consultantLeads.add(tempConsultantLeadsList);

			}
			return consultantLeads;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<ConsultantLeads> getAllConsultantLeadsDetailsForSalesEng(String currYear, String companyCode,
			String divnCode) throws SQLException {
		int currentYear = Integer.parseInt(currYear);
		int prevYear = currentYear - 1;
		String oppStatus = "";
		List<ConsultantLeads> consultantLeads = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		ResultSet myRes = null;
		try {

			// Get Connection
			myCon = orcl.getOrclConn();

			// Execute sql stamt
			String sql = " SELECT id,consultant,product,cnslt_status,division,remarks,created_date,updated_date FROM CONSULTANT_LEADS where create_year in (?,?) and division in(?,?,'AD') order by updated_date desc ";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setInt(1, prevYear);
			myStmt.setInt(2, currentYear);
			myStmt.setString(3, companyCode);
			myStmt.setString(4, divnCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String cnsltid = myRes.getString(1);
				String cnslt_name_temp = myRes.getString(2);
				// System.out.println("consultant debug : "+cnslt_name_temp);
				String product_temp = myRes.getString(3);
				String status_temp = myRes.getString(4);
				String division_temp = myRes.getString(5);
				String remarks_temp = myRes.getString(6);
				String created_date_temp = myRes.getString(7);
				String updated_date_temp = myRes.getString(8);
				try {
					oppStatus = dateDiffStatus(updated_date_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				ConsultantLeads tempConsultantLeadsList = new ConsultantLeads(cnsltid, cnslt_name_temp, product_temp,
						status_temp, division_temp, remarks_temp, created_date_temp, updated_date_temp, oppStatus);

				consultantLeads.add(tempConsultantLeadsList);

			}
			return consultantLeads;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<ConsultantLeads> getAllDivisionList() throws SQLException {

		List<ConsultantLeads> divisionList = new ArrayList<>();
		String frz_value = "N";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT distinct division,divn_name FROM  mkt_products  "
					+ "  WHERE frz_status = ?  order by  displayorder asc";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, frz_value);
			myRes = myStmt.executeQuery();
			// Process the result set
			while (myRes.next()) {
				String dvn_code_tmp = myRes.getString(1);
				String dvn_name_temp = myRes.getString(2);

				ConsultantLeads tempdivisionList = new ConsultantLeads(dvn_code_tmp, dvn_name_temp);

				divisionList.add(tempdivisionList);

			}
			return divisionList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public void editUpdateConsultantLeads(ConsultantLeads updatedtls) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();

		ResultSet myRes = null;
		try {
			myCon = orcl.getOrclConn();

			String sql = "update CONSULTANT_LEADS set  cnslt_status =?, remarks=?, updated_date = SYSDATE,contact_details=?,product=?  "
					+ " where id = ? ";

			// very important
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, updatedtls.getStatus());
			myStmt.setString(2, updatedtls.getRemarks());
			myStmt.setString(3, updatedtls.getContactDetails());
			myStmt.setString(4, updatedtls.getProduct());
			myStmt.setString(5, updatedtls.getCnslt_id());
			// execute sql query
			myStmt.execute();

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public void deleteUpdateConsultantLeads(String cid) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		try {
			myCon = con.getOrclConn();

			String sql = "delete from  consultant_leads  " + " where  id =? ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, cid);
			myStmt.execute();

		} finally {
			// close jdbc objects

			close(myStmt, null);
			con.closeConnection();

		}

	}

	public List<ConsultantLeads> getSerachResultConsultantleads(String search_word, String year) throws SQLException {
		// System.out.println("consultant debug : entered to vie all db");
		String oppStatus = "";
		List<ConsultantLeads> consultantLeads = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getOrclConn();

			// Execute sql stamt
			String sql = " SELECT id,consultant,product,cnslt_status,division,remarks,created_date,updated_date "
					+ " FROM CONSULTANT_LEADS where create_year = ? and consultant like ? ";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, year);
			myStmt.setString(2, "%" + search_word + "%");
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String cnsltid = myRes.getString(1);
				String cnslt_name_temp = myRes.getString(2);
				// System.out.println("consultant debug : "+cnslt_name_temp);
				String product_temp = myRes.getString(3);
				String status_temp = myRes.getString(4);
				String division_temp = myRes.getString(5);
				String remarks_temp = myRes.getString(6);
				String created_date_temp = myRes.getString(7);
				String updated_date_temp = myRes.getString(8);
				try {
					oppStatus = dateDiffStatus(updated_date_temp, created_date_temp);

					// System.out.println(oppStatus);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ConsultantLeads tempConsultantLeadsList = new ConsultantLeads(cnsltid, cnslt_name_temp, product_temp,
						status_temp, division_temp, remarks_temp, created_date_temp, updated_date_temp, oppStatus);

				consultantLeads.add(tempConsultantLeadsList);

			}
			return consultantLeads;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public String dateDiffStatus(String updatedate, String createddate) throws ParseException {
		Calendar cal = Calendar.getInstance();
		String status = "";
		long diffD1 = 0, diffD2 = 0;
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date d1 = sdformat.parse(updatedate);
		java.util.Date d2 = sdformat.parse(createddate);
		java.util.Date now = cal.getTime();
		diffD1 = (now.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24);
		diffD2 = (now.getTime() - d2.getTime()) / (1000 * 60 * 60 * 24);
		// System.out.print(" d1d2comp "+d1.compareTo(d2)+" nowd1: "+(diffD1)+" nowd2:
		// "+diffD2);
		if ((d1.compareTo(d2) == 0) && (diffD2 <= 7)) {
			status = "(New)";
		} else if ((d1.compareTo(d2) > 0) && (diffD1 <= 7)) {
			status = "(Updated)";
		} else if (((d1.compareTo(d2) > 0) && (diffD2 > 7)) || ((d1.compareTo(d2) == 0) && (diffD2 > 7))) {
			status = " ";
		}
		return status;

	}

	public List<ConsultantLeads> getAllConsultantList() throws SQLException {

		List<ConsultantLeads> consultantsList = new ArrayList<>();
		String frz_value = "CONSULT";

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT VSSV_CODE,VSSV_NAME FROM IM_VS_STATIC_VALUE WHERE VSSV_VS_CODE=? ORDER BY VSSV_NAME ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, frz_value);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String consultant_code_tmp = myRes.getString(1);
				String consultant_name_temp = myRes.getString(2);
				ConsultantLeads tempdivisionList = new ConsultantLeads(consultant_code_tmp, consultant_name_temp, "");
				consultantsList.add(tempdivisionList);
			}
			return consultantsList;

		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	/*
	 * public List<ConsultantLeads> getConsultantProductreport(String[] emplList,
	 * String[] leave_type_list) throws SQLException {
	 * 
	 * List<ConsultantLeads> consultantLeads = new ArrayList<>(); Connection myCon =
	 * null; PreparedStatement myStmt = null; ResultSet myRes = null;
	 * 
	 * MysqlDBConnectionPool con = new MysqlDBConnectionPool(); try { StringBuilder
	 * sql = new StringBuilder("SELECT  * FROM   consultant_leads WHERE (");
	 * 
	 * myCon = con.getMysqlConn(); if (emplList.length > 0) { for (int i = 0; i <=
	 * emplList.length - 1; i++) { sql.append("FIND_IN_SET('" + emplList[i] +
	 * "', consultant)"); if (i < emplList.length - 1) { sql.append(" OR "); } } }
	 * if (leave_type_list.length > 0) { sql.append(") AND ("); for (int i = 0; i <=
	 * leave_type_list.length - 1; i++) { sql.append("FIND_IN_SET(" +
	 * leave_type_list[i] + ", product)"); if (i < leave_type_list.length - 1) {
	 * sql.append(" OR "); } } sql.append(") "); }
	 * System.out.println("query for the report " + sql); myStmt =
	 * myCon.prepareStatement(sql.toString()); myRes = myStmt.executeQuery();
	 * 
	 * // Process the result set while (myRes.next()) { String cnsltid =
	 * myRes.getString(1); String cnslt_name_temp = myRes.getString(2); String
	 * product_temp = myRes.getString(3); String status_temp = myRes.getString(4);
	 * String division_temp = myRes.getString(5); String remarks_temp =
	 * myRes.getString(6); ConsultantLeads tempConsultantLeadsList = new
	 * ConsultantLeads(cnslt_name_temp, product_temp, status_temp, division_temp,
	 * remarks_temp);
	 * 
	 * consultantLeads.add(tempConsultantLeadsList);
	 * 
	 * } return consultantLeads;
	 * 
	 * } finally { // close jdbc objects close(myStmt, myRes);
	 * con.closeConnection();
	 * 
	 * } }
	 */

	public List<MktSalesLeads> getProductList() throws SQLException {
		List<MktSalesLeads> productList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "SELECT distinct prduct from mkt_products  order by displayorder,division,prduct ";
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String product_tmp = myRes.getString(1);
				MktSalesLeads tempproductList = new MktSalesLeads(product_tmp);
				productList.add(tempproductList);
			}
			return productList;
		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}
	}

	public ArrayList<String> getDivisionNameForProducts(String products) throws SQLException {
		ArrayList<String> productList = new ArrayList<>();

		Connection myCon = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "SELECT divn_name from mkt_products where prduct IN (" + products
					+ ") order by displayorder,division,prduct ";
			System.out.println("sql in division name " + sql);
			myStmt = myCon.createStatement();
			myRes = myStmt.executeQuery(sql);
			while (myRes.next()) {
				String product_tmp = myRes.getString(1);
				productList.add(product_tmp);
			}
			return productList;
		} finally {
			close(myStmt, myRes);
			con.closeConnection();
		}
	}

	public ArrayList<String> getProductListForSelDivn(String divisionCode) throws SQLException {
		ArrayList<String> productList = new ArrayList<>();
		if (divisionCode.equals("AD")) {
			Connection myCon = null;
			Statement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {
				myCon = con.getMysqlConn();
				String sql = "SELECT distinct prduct from mkt_products  order by 1 asc ";
				myStmt = myCon.createStatement();
				myRes = myStmt.executeQuery(sql);
				while (myRes.next()) {
					String product_tmp = myRes.getString(1);
					productList.add(product_tmp);
				}
				return productList;
			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
		} else {
			Connection myCon = null;
			PreparedStatement myStmt = null;
			ResultSet myRes = null;
			MysqlDBConnectionPool con = new MysqlDBConnectionPool();
			try {
				myCon = con.getMysqlConn();
				String sql = "SELECT prduct from mkt_products where division = ? order by 1 asc ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, divisionCode);
				myRes = myStmt.executeQuery();
				while (myRes.next()) {
					String product_tmp = myRes.getString(1);
					productList.add(product_tmp);
				}
				return productList;
			} finally {
				close(myStmt, myRes);
				con.closeConnection();
			}
		}

	}

	public String[][] getConsultantProductReport(String consulList, String productList, String[] consultantListUI,
			String[] prodListUI) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		String[][] consultantProduct = new String[consultantListUI.length + 2][prodListUI.length + 1];
		OrclDBConnectionPool con = new OrclDBConnectionPool();
		System.out.println("products" + productList);
		System.out.println("consulList" + consulList);
		try {
			String sql = "SELECT  * FROM   CONSULTANT_LEADS WHERE " + consulList;
			System.out.println("sql query " + sql);
			myCon = con.getOrclConn();
			myStmt = myCon.prepareStatement(sql);
			myRes = myStmt.executeQuery();
			int consCtr = 0;
			String cnslt_name_temp, cnslt_product_temp;

			ArrayList<String> divisionListDB = getDivisionNameForProducts(productList);

			String[] dbProductsStringArry = divisionListDB.toArray(new String[0]);

			for (int i = 0; i < consultantListUI.length; i++) {
				consultantProduct[i + 2][0] = consultantListUI[i];
			}
			for (int j = 0; j < prodListUI.length; j++) {
				consultantProduct[0][j + 1] = dbProductsStringArry[j];
				consultantProduct[1][j + 1] = prodListUI[j];
			}

			while (myRes.next()) {
				consCtr = -1;
				cnslt_name_temp = myRes.getString(2);
				cnslt_product_temp = myRes.getString(3);
				for (int i = 0; i < consultantProduct.length; i++) {
					System.out.println("DB Consultant" + cnslt_name_temp + " For loop consultant:" + i + " : "
							+ consultantProduct[i][0]);
					if (cnslt_name_temp.equalsIgnoreCase(consultantProduct[i][0])) {
						consCtr = i;
						break;
					}
				}

				ArrayList<String> consPrdlistDB = new ArrayList<>(Arrays.asList(cnslt_product_temp.split(",")));
				for (int j = 0; j < prodListUI.length; j++) {
					System.out.println("prodList:" + j + ":" + prodListUI[j]);
					if (consPrdlistDB.contains(prodListUI[j])) {
						consultantProduct[consCtr][j + 1] = "Yes";
					}
				}
			}

			for (int i = 0; i < consultantListUI.length + 1; i++) {
				for (int j = 0; j < prodListUI.length + 1; j++) {
					System.out.println("prodList in for loop:" + j + ":" + consultantProduct[i][j]);
					if (i != 0 && (j != 0 || j != 1))
						if (consultantProduct[i][j] == null) {
							consultantProduct[i][j] = "";
						}

				}
			}
			return consultantProduct;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<ConsultantVisits> getAllConsultantVisitDetails(String currYear) throws SQLException {

		List<ConsultantVisits> consultantVisits = new ArrayList<>();

		Connection myCon = null;
		// PreparedStatement myStmt = null;
		Statement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT * FROM consultant_visits ";
			myStmt = myCon.createStatement();
			// Execute a SQL query
			myRes = myStmt.executeQuery(sql);

			// Process the result set
			while (myRes.next()) {
				String cnslt_name_temp = myRes.getString(1);
				Date visit_date = myRes.getDate(2);
				String visit_reason = myRes.getString(3);
				int noof_attendees = myRes.getInt(4);
				String meetingperson_details = myRes.getString(5);
				String meeting_notes = myRes.getString(6);
				String empcode = myRes.getString(8);
				String division = myRes.getString(9);
				String product = myRes.getString(10);
				String consultantType = myRes.getString(11);
				ConsultantVisits tempConsultantVisitssList = new ConsultantVisits(cnslt_name_temp, visit_reason,
						visit_date, noof_attendees, meetingperson_details, meeting_notes, empcode, division, product,
						consultantType);
				consultantVisits.add(tempConsultantVisitssList);

			}
			return consultantVisits;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public int createnewConsultantVisits(ConsultantVisits consultant_Visits_Dtls) throws SQLException {

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		int logType = 0;
		try {
			myCon = con.getMysqlConn();

			String sql = "insert into consultant_visits(consultant,visit_date,visit_reason,noof_attendees,meetingperson_details,meeting_notes,empid,created_on,division,product,consultantType) values(?,?,?,?,?,?,?,sysdate(),?,?,?)";

			// very important
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setString(1, consultant_Visits_Dtls.getConslt_name());
			myStmt.setDate(2, consultant_Visits_Dtls.getDate());
			myStmt.setString(3, consultant_Visits_Dtls.getVisit_reason());
			myStmt.setInt(4, consultant_Visits_Dtls.getNoofattendees());
			myStmt.setString(5, consultant_Visits_Dtls.getMeetingperson_details());
			myStmt.setString(6, consultant_Visits_Dtls.getMeeting_notes());
			myStmt.setString(7, consultant_Visits_Dtls.getEmployee_Code());
			myStmt.setString(8, consultant_Visits_Dtls.getDivision());
			myStmt.setString(9, consultant_Visits_Dtls.getProduct());
			myStmt.setString(10, consultant_Visits_Dtls.getConsultantType());
			// execute sql query
			logType = myStmt.executeUpdate();

		} catch (SQLIntegrityConstraintViolationException ex) {
			logType = -1;
		} catch (Exception e) {
			System.out.println("Exception " + e);
		} finally {
			// close jdbc objects

			close(myStmt, myRes);
			con.closeConnection();

		}

		return logType;
	}
}
