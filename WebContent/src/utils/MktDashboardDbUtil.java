package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import beans.ConsultantLeads;
import beans.MktDashboard;
import beans.MysqlDBConnectionPool;

public class MktDashboardDbUtil {

	public List<MktDashboard> getSingleEngineerCustDateSalesLeadAnalysis(String from, String to, String empCode)
			throws SQLException {
		// lead dashboard for single sales engineer
		List<MktDashboard> leadAnalysisList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			myCon = con.getMysqlConn();

			String sql = "call get_custDate_single_sales_engineer_salesleads_analysys(?, ?, ?)";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, formatDate(from));
			myStmt.setString(2, formatDate(to));
			myStmt.setString(3, empCode);

			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String mainDivision = myRes.getString(1);
				String leadType = myRes.getString(2);
				String emp_code = myRes.getString(3);
				String emp_name = myRes.getString(4);
				String totalLeadCount = myRes.getString(5);
				String pendingLeadCount = myRes.getString(6);
				String ackLeadCount = myRes.getString(7);
				String declinedLeads = myRes.getString(8);
				String Stage3LeadCount = myRes.getString(9);
				String Stage3LeadValue = myRes.getString(10);
				String Stage4LeadCount = myRes.getString(11);
				String Stage4LeadValue = myRes.getString(12);
				String Stage4NotConfrmedCount = myRes.getString(13);
				String qtdLeads = myRes.getString(14);
				String lostleadsAtOfferValue = myRes.getString(15);
				String lostleadsAtStage3 = myRes.getString(16);

				MktDashboard tempLeadAnalysisList = new MktDashboard(mainDivision, leadType, emp_code, emp_name,
						totalLeadCount, pendingLeadCount, ackLeadCount, declinedLeads, Stage3LeadCount, Stage3LeadValue,
						Stage4LeadCount, Stage4LeadValue, Stage4NotConfrmedCount, qtdLeads, lostleadsAtOfferValue,
						lostleadsAtStage3);
				leadAnalysisList.add(tempLeadAnalysisList);

			}
			return leadAnalysisList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();
		}
	}

	public List<MktDashboard> getSingleEngineerMonthlySalesLeadAnalysis(int year, int month, String empCode)
			throws SQLException {
		// lead dashboard for single sales engineer
		List<MktDashboard> leadAnalysisList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			myCon = con.getMysqlConn();

			String sql = "call get_monthly_single_sales_engineer_salesleads_analysys(?, ?, ?)";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setInt(1, year);
			myStmt.setInt(2, month);
			myStmt.setString(3, empCode);

			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String mainDivision = myRes.getString(1);
				String leadType = myRes.getString(2);
				String emp_code = myRes.getString(3);
				String emp_name = myRes.getString(4);
				String totalLeadCount = myRes.getString(5);
				String pendingLeadCount = myRes.getString(6);
				String ackLeadCount = myRes.getString(7);
				String declinedLeads = myRes.getString(8);
				String Stage3LeadCount = myRes.getString(9);
				String Stage3LeadValue = myRes.getString(10);
				String Stage4LeadCount = myRes.getString(11);
				String Stage4LeadValue = myRes.getString(12);
				String Stage4NotConfrmedCount = myRes.getString(13);
				String qtdLeads = myRes.getString(14);
				String lostleadsAtOfferValue = myRes.getString(15);
				String lostleadsAtStage3 = myRes.getString(16);

				MktDashboard tempLeadAnalysisList = new MktDashboard(mainDivision, leadType, emp_code, emp_name,
						totalLeadCount, pendingLeadCount, ackLeadCount, declinedLeads, Stage3LeadCount, Stage3LeadValue,
						Stage4LeadCount, Stage4LeadValue, Stage4NotConfrmedCount, qtdLeads, lostleadsAtOfferValue,
						lostleadsAtStage3);
				leadAnalysisList.add(tempLeadAnalysisList);

			}
			return leadAnalysisList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();
		}
	}

	public List<MktDashboard> getSingleDivisionYearlySalesLeadAnalysis(int year, String divisionCode)
			throws SQLException {
		// lead dashboard for single division
		List<MktDashboard> leadAnalysisList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "call get_yrly_single_division_salesleads_analysys(?, ?)";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setInt(1, year);
			myStmt.setString(2, divisionCode);

			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				String mainDivision = myRes.getString(1);
				String leadType = myRes.getString(2);
				String emp_code = myRes.getString(3);
				String emp_name = myRes.getString(4);
				String totalLeadCount = myRes.getString(5);
				String pendingLeadCount = myRes.getString(6);
				String ackLeadCount = myRes.getString(7);
				String declinedLeads = myRes.getString(8);
				String Stage3LeadCount = myRes.getString(9);
				String Stage3LeadValue = myRes.getString(10);
				String Stage4LeadCount = myRes.getString(11);
				String Stage4LeadValue = myRes.getString(12);
				String Stage4NotConfrmedCount = myRes.getString(13);
				String qtdLeads = myRes.getString(14);
				String lostleadsAtOfferValue = myRes.getString(15);
				String lostleadsAtStage3 = myRes.getString(16);

				MktDashboard tempLeadAnalysisList = new MktDashboard(mainDivision, leadType, emp_code, emp_name,
						totalLeadCount, pendingLeadCount, ackLeadCount, declinedLeads, Stage3LeadCount, Stage3LeadValue,
						Stage4LeadCount, Stage4LeadValue, Stage4NotConfrmedCount, qtdLeads, lostleadsAtOfferValue,
						lostleadsAtStage3);
				leadAnalysisList.add(tempLeadAnalysisList);

			}
			return leadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktDashboard> getSingleDivisionCustDateSalesLeadAnalysis(String from, String to, String divisionCode)
			throws SQLException {
		// lead dashboard for single division
		List<MktDashboard> leadAnalysisList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "call get_custDate_single_division_salesleads_analysys( ?, ?, ?)";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, formatDate(from));
			myStmt.setString(2, formatDate(to));
			myStmt.setString(3, divisionCode);

			myRes = myStmt.executeQuery();

			while (myRes.next()) {

				String mainDivision = myRes.getString(1);
				String leadType = myRes.getString(2);
				String emp_code = myRes.getString(3);
				String emp_name = myRes.getString(4);
				String totalLeadCount = myRes.getString(5);
				String pendingLeadCount = myRes.getString(6);
				String ackLeadCount = myRes.getString(7);
				String declinedLeads = myRes.getString(8);
				String Stage3LeadCount = myRes.getString(9);
				String Stage3LeadValue = myRes.getString(10);
				String Stage4LeadCount = myRes.getString(11);
				String Stage4LeadValue = myRes.getString(12);
				String Stage4NotConfrmedCount = myRes.getString(13);
				String qtdLeads = myRes.getString(14);
				String lostleadsAtOfferValue = myRes.getString(15);
				String lostleadsAtStage3 = myRes.getString(16);

				MktDashboard tempLeadAnalysisList = new MktDashboard(mainDivision, leadType, emp_code, emp_name,
						totalLeadCount, pendingLeadCount, ackLeadCount, declinedLeads, Stage3LeadCount, Stage3LeadValue,
						Stage4LeadCount, Stage4LeadValue, Stage4NotConfrmedCount, qtdLeads, lostleadsAtOfferValue,
						lostleadsAtStage3);
				leadAnalysisList.add(tempLeadAnalysisList);

			}
			return leadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktDashboard> getCompleteDivisionYearlySalesLeadAnalysis(int year) throws SQLException {
		// lead dashboard for complete division
		List<MktDashboard> leadAnalysisList = new ArrayList<>();

		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "call get_yrly_complete_division_salesleads_analysys(?)";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setInt(1, year);

			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String mainDivision = myRes.getString(1);
				String leadType = myRes.getString(2);
				String totalLeadCount = myRes.getString(3);
				String pendingLeadCount = myRes.getString(4);
				String ackLeadCount = myRes.getString(5);
				String declinedLeads = myRes.getString(6);
				String Stage3LeadCount = myRes.getString(7);
				String Stage3LeadValue = myRes.getString(8);
				String Stage4LeadCount = myRes.getString(9);
				String Stage4LeadValue = myRes.getString(10);
				String Stage4NotConfrmedCount = myRes.getString(11);
				String qtdLeads = myRes.getString(12);
				String lostleadsAtOfferValue = myRes.getString(13);
				String lostleadsAtStage3 = myRes.getString(14);

				MktDashboard tempLeadAnalysisList = new MktDashboard(mainDivision, leadType, totalLeadCount,
						pendingLeadCount, ackLeadCount, declinedLeads, Stage3LeadCount, Stage3LeadValue,
						Stage4LeadCount, Stage4LeadValue, Stage4NotConfrmedCount, qtdLeads, lostleadsAtOfferValue,
						lostleadsAtStage3);
				leadAnalysisList.add(tempLeadAnalysisList);

			}
			return leadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	private String formatDate(String dateValue) {
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

	public List<MktDashboard> getCompleteDivisionCustDateSalesLeadAnalysis(String from, String to) throws SQLException {
		// lead dashboard for complete division
		// System.out.println(formatDate(from));
		List<MktDashboard> leadAnalysisList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {
			myCon = con.getMysqlConn();

			String sql = "call get_custDate_complete_division_salesleads_analysys( ?, ?) ";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, formatDate(from));
			myStmt.setString(2, formatDate(to));

			myRes = myStmt.executeQuery();

			while (myRes.next()) {
				String mainDivision = myRes.getString(1);
				String leadType = myRes.getString(2);
				String totalLeadCount = myRes.getString(3);
				String pendingLeadCount = myRes.getString(4);
				String ackLeadCount = myRes.getString(5);
				String declinedLeads = myRes.getString(6);
				String Stage3LeadCount = myRes.getString(7);
				String Stage3LeadValue = myRes.getString(8);
				String Stage4LeadCount = myRes.getString(9);
				String Stage4LeadValue = myRes.getString(10);
				String Stage4NotConfrmedCount = myRes.getString(11);
				String qtdLeads = myRes.getString(12);
				String lostleadsAtOfferValue = myRes.getString(13);
				String lostleadsAtStage3 = myRes.getString(14);

				MktDashboard tempLeadAnalysisList = new MktDashboard(mainDivision, leadType, totalLeadCount,
						pendingLeadCount, ackLeadCount, declinedLeads, Stage3LeadCount, Stage3LeadValue,
						Stage4LeadCount, Stage4LeadValue, Stage4NotConfrmedCount, qtdLeads, lostleadsAtOfferValue,
						lostleadsAtStage3);
				leadAnalysisList.add(tempLeadAnalysisList);

			}
			return leadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktDashboard> getCompleteDivisionYearlyGeneralDetails(int year) throws SQLException {
		// uniquelead details
		List<MktDashboard> uniqueLeadAnalysisList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "CALL get_general_details_for_complete_division(?)";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, year);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String count = myRes.getString(1);
				String value = myRes.getString(2);

				MktDashboard tempUniqueLeadAnalysisList = new MktDashboard(count, value);
				uniqueLeadAnalysisList.add(tempUniqueLeadAnalysisList);

			}
			return uniqueLeadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktDashboard> getSingleDivisionYearlyGeneralDetails(int year, String divisionCode) throws SQLException {
		// uniquelead details
		List<MktDashboard> uniqueLeadAnalysisList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "CALL get_general_details_for_single_division(?, ?)";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, year);
			myStmt.setString(2, divisionCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String count = myRes.getString(1);
				String value = myRes.getString(2);

				MktDashboard tempUniqueLeadAnalysisList = new MktDashboard(count, value);
				uniqueLeadAnalysisList.add(tempUniqueLeadAnalysisList);

			}
			return uniqueLeadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

		}
	}

	public List<MktDashboard> getSalesEngineerYearlyGeneralDetails(int year, String empCode) throws SQLException {
		// uniquelead details
		List<MktDashboard> uniqueLeadAnalysisList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = "CALL get_general_details_for_sales_engineer(?, ?)";
			myStmt = myCon.prepareStatement(sql);

			// set the param values for the student
			myStmt.setInt(1, year);
			myStmt.setString(2, empCode);
			// Execute a SQL query
			myRes = myStmt.executeQuery();

			// Process the result set
			while (myRes.next()) {
				String count = myRes.getString(1);
				String value = myRes.getString(2);

				MktDashboard tempUniqueLeadAnalysisList = new MktDashboard(count, value);
				uniqueLeadAnalysisList.add(tempUniqueLeadAnalysisList);

			}
			return uniqueLeadAnalysisList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			con.closeConnection();

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
			String sql = " SELECT distinct division, divn_name FROM  mkt_products  "
					+ "  WHERE frz_status = ?  order by  display_order  asc ";
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

	public String getDefaultDivision(String defDeivCode) throws SQLException {

		String frz_value = "N";
		String division = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		try {

			// Get Connection
			myCon = con.getMysqlConn();

			// Execute sql stamt
			String sql = " SELECT distinct division FROM  mkt_products  "
					+ "  WHERE  divn_code = ? and frz_status = ?  order by  display_order  asc ";
			myStmt = myCon.prepareStatement(sql);

			myStmt.setString(1, defDeivCode);
			myStmt.setString(2, frz_value);
			myRes = myStmt.executeQuery();
			// Process the result set
			while (myRes.next()) {
				division = myRes.getString(1);

			}
			return division;

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

}
