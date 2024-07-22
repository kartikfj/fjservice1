package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipDStage2LostSummary;
import beans.SipDivBillingSummary;
import beans.SipDivBookingSummary;
import beans.SipDivEnquirtToQtnAnalysis;
import beans.SipDivForecast;
import beans.SipDivForecastPercAccuracyDetails;
import beans.SipDivJihvSummary;
import beans.SipDivLoiToSoAnalysis;
import beans.SipDivQuotationToLoiAnalysis;
import beans.SipDivSoToInvoiceAnalysis;
import beans.SipDivStage2LostDetails;
import beans.SipJihvDetails;
import beans.SipLayer2SubDivisionLevelBillingDetailsYTD;
import beans.SipOutRecvbleReprt;
import beans.Stage1Details;
import beans.Stage3Details;
import beans.Stage4Details;

public class SipDivisionChartDbUtil {

	public List<SipDivJihvSummary> getDivisionListforDM(String dm_emp_code) throws SQLException {
		// function for fetching division list under a Division Manager
		List<SipDivJihvSummary> divisionDetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		String dmSpclCaseCodes = "E004853";
		try {
			myCon = orcl.getOrclConn();
			String sql_bkp = "SELECT DISTINCT FJTDIVNCODE,FJTDIVNNAME FROM FJT_DIVNNAME_DM,FJT_DMSM_TBL "
					+ "WHERE FJT_DIVNNAME_DM.DIVN_NAME = FJTDIVNCODE " + "AND DM_EMP_CODE = DMEMPCODE "
					+ "AND FJTDIVNNAME IS NOT NULL  AND FJTSTATUS = 'Y' "
					+ "AND DMEMPCODE = ?  and FJTDIVNNAME != 'VALVES-KSA' "
					// +"AND FJTDIVNCODE != 'VALVES' " //removedTemporory solution asper arun reqst
					// for avoiding multiple VALVES sub division list, Discuss with arun for
					// permenant solution
					+ "ORDER BY 1";
			String sql = "SELECT DISTINCT FJTDIVNCODE, FJTDIVNNAME,FM_DIVISION.DIVN_NAME DIVNFULLNAME"
					+ "  FROM FJT_DIVNNAME_DM, FJT_DMSM_TBL,FM_DIVISION "
					+ " WHERE     FJT_DIVNNAME_DM.DIVN_NAME = FJTDIVNCODE " + "       AND DM_EMP_CODE = DMEMPCODE "
					+ "       AND FJTDIVNNAME IS NOT NULL " + "       AND FJTSTATUS = 'Y' " + "       AND DMEMPCODE =? "
					+ "       AND FJTDIVNNAME != 'VALVES-KSA' " + "       AND DMEMPCODE NOT LIKE 'E004853' "
					+ "       AND FJTDIVNCODE = FM_DIVISION.DIVN_CODE " + " UNION "
					+ "SELECT DISTINCT FJTDIVNCODE, FJTDIVNNAME,FM_DIVISION.DIVN_NAME DIVNFULLNAME "
					+ "  FROM FJT_DMSM_TBL,FM_DIVISION " + "WHERE     FJTDIVNCODE IN (SELECT DISTINCT DIVN_NAME "
					+ "                             FROM FJT_DIVNNAME_DM "
					+ "                            WHERE DM_EMP_CODE = ?) " + "       AND FJTDIVNNAME IS NOT NULL "
					+ "       AND FJTSTATUS = 'Y' " + "       AND FJTDIVNCODE = FM_DIVISION.DIVN_CODE " + "ORDER BY 2";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myStmt.setString(2, dm_emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div_code = myRes.getString(1);
				String div_desc = myRes.getString(2);
				String div_full_name = myRes.getString(3);
				SipDivJihvSummary tempdivisionDetailsList = new SipDivJihvSummary(div_code, div_desc, div_full_name);
				divisionDetailsList.add(tempdivisionDetailsList);
			}
			return divisionDetailsList;
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

	public List<SipDStage2LostSummary> getStage2LostCountforDivisionDeafault(String dm_emp_code, String division)
			throws SQLException {
		// this function for Stage 2 Aging - JIH Stages Qtns where no LOI received
		// used for finding default division
		List<SipDStage2LostSummary> stage2LostQtnList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_emp_code.equals("E004853")) {
				sql = "SELECT * FROM AM_JIH_AGING_SUM_TBL WHERE  DIVN = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT * FROM AM_JIH_AGING_SUM_TBL WHERE  DM_CODE = ?  AND DIVN = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_emp_code);
				myStmt.setString(2, division);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div_tmp = myRes.getString(14);
				String aging1_count_tmp = myRes.getString(1);
				String aging1_lost_count_tmp = myRes.getString(2);
				String ging1_amount = myRes.getString(3);
				String aging1_lost_amount_tmp = myRes.getString(4);
				String aging2_count_tmp = myRes.getString(5);
				String aging2_lost_count_tmp = myRes.getString(6);
				String aging2_amount_tmp = myRes.getString(7);
				String aging2_lost_amount_tmp = myRes.getString(8);
				String aging3_count_tmp = myRes.getString(9);
				String aging3_lost_count_tmp = myRes.getString(10);
				String aging3_amount_tmp = myRes.getString(11);
				String aging3_lost_amount_tmp = myRes.getString(12);
				SipDStage2LostSummary tempStage2LostSummary = new SipDStage2LostSummary(div_tmp, aging1_count_tmp,
						aging1_lost_count_tmp, ging1_amount, aging1_lost_amount_tmp, aging2_count_tmp,
						aging2_lost_count_tmp, aging2_amount_tmp, aging2_lost_amount_tmp, aging3_count_tmp,
						aging3_lost_count_tmp, aging3_amount_tmp, aging3_lost_amount_tmp);
				stage2LostQtnList.add(tempStage2LostSummary);
			}
			return stage2LostQtnList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<SipDStage2LostSummary> getStage2LostCountforDivision(String dm_emp_code, String division)
			throws SQLException {
		// this function for Stage 2 Aging - JIH Stages Qtns where no LOI received
		// used for passing division from division list on user side
		List<SipDStage2LostSummary> stage2LostQtnList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT * FROM AM_JIH_AGING_SUM_TBL WHERE  DM_CODE = ?  AND DIVN = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myStmt.setString(2, division);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div_tmp = myRes.getString(14);
				String aging1_count_tmp = myRes.getString(1);
				String aging1_lost_count_tmp = myRes.getString(2);
				String ging1_amount = myRes.getString(3);
				String aging1_lost_amount_tmp = myRes.getString(4);
				String aging2_count_tmp = myRes.getString(5);
				String aging2_lost_count_tmp = myRes.getString(6);
				String aging2_amount_tmp = myRes.getString(7);
				String aging2_lost_amount_tmp = myRes.getString(8);
				String aging3_count_tmp = myRes.getString(9);
				String aging3_lost_count_tmp = myRes.getString(10);
				String aging3_amount_tmp = myRes.getString(11);
				String aging3_lost_amount_tmp = myRes.getString(12);
				SipDStage2LostSummary tempStage2LostSummary = new SipDStage2LostSummary(div_tmp, aging1_count_tmp,
						aging1_lost_count_tmp, ging1_amount, aging1_lost_amount_tmp, aging2_count_tmp,
						aging2_lost_count_tmp, aging2_amount_tmp, aging2_lost_amount_tmp, aging3_count_tmp,
						aging3_lost_count_tmp, aging3_amount_tmp, aging3_lost_amount_tmp);
				stage2LostQtnList.add(tempStage2LostSummary);
			}
			return stage2LostQtnList;
		} finally {// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDivStage2LostDetails> getStage2LostAging_Details_Division(String dM_Code, String aging,
			String div_Code) throws SQLException {
		// function for fetching Job in hand volume Aging wise Details List for division
		// under an division manager
		// System.out.println("dm code"+dM_Code+" aging"+aging+" division"+div_Code);
		List<SipDivStage2LostDetails> agingDetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dM_Code.equals("E004853")) {
				sql = "SELECT distinct COMP_CODE,WEEK,QTN_DT,QTN_CODE,QTN_NO,CUST_CODE,CUST_NAME,SALES_EGR_CODE,SALES_ENG_NAME,PROJECT_NAME, "
						+ "CONSULTANT,INVOICING_YEAR,PROD_TYPE,PROD_CLASSFCN,ZONE,PROFIT_PERC,QTN_AMOUNT,QTN_STATUS from FJT_DM_JIH_AGING_DET_ALL_STAT,FJT_DMSM_TBL "
						+ "WHERE DM_CODE = DMEMPCODE  " + "AND JIH_AGING= ? " + "AND QTN_CODE = FJTTXNCODE "
						+ "AND FJTDIVNCODE = ? " + " ORDER BY QTN_STATUS,QTN_DT ";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dM_Code);
				// myStmt.setString(2, dM_Code);
				myStmt.setString(1, aging);
				myStmt.setString(2, div_Code);
			} else {
				sql = "SELECT distinct COMP_CODE,WEEK,QTN_DT,QTN_CODE,QTN_NO,CUST_CODE,CUST_NAME,SALES_EGR_CODE,SALES_ENG_NAME,PROJECT_NAME, "
						+ "CONSULTANT,INVOICING_YEAR,PROD_TYPE,PROD_CLASSFCN,ZONE,PROFIT_PERC,QTN_AMOUNT,QTN_STATUS from FJT_DM_JIH_AGING_DET_ALL_STAT,FJT_DMSM_TBL "
						+ "WHERE DM_CODE = DMEMPCODE AND DM_CODE= ? " + "AND DMEMPCODE = ? " + "AND JIH_AGING= ? "
						+ "AND QTN_CODE = FJTTXNCODE " + "AND FJTDIVNCODE = ? " + " ORDER BY QTN_STATUS,QTN_DT ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dM_Code);
				myStmt.setString(2, dM_Code);
				myStmt.setString(3, aging);
				myStmt.setString(4, div_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String week = myRes.getString(1);
				String cmp_code = myRes.getString(2);
				String qtn_date = myRes.getString(3);
				String qtn_code = myRes.getString(4);
				String qtn_numbr = myRes.getString(5);
				String cust_code = myRes.getString(6);
				String cust_name = myRes.getString(7);
				String sales_egr_code = myRes.getString(8);
				String sales_egr_name = myRes.getString(9);
				String project_name = myRes.getString(10);
				String consultant = myRes.getString(11);
				String invoice_yr = myRes.getString(12);
				String product_type = myRes.getString(13);
				String product_classfctn = myRes.getString(14);
				String zone = myRes.getString(15);
				String profit = myRes.getString(16);
				String qtn_amount = myRes.getString(17);
				String qtn_status = myRes.getString(18);
				SipDivStage2LostDetails tempagingdetailsList = new SipDivStage2LostDetails(week, cmp_code, qtn_date,
						qtn_code, qtn_numbr, cust_code, cust_name, sales_egr_code, sales_egr_name, project_name,
						consultant, invoice_yr, product_type, product_classfctn, zone, profit, qtn_amount, qtn_status);
				agingDetailsList.add(tempagingdetailsList);
			}
			return agingDetailsList;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}
	////////////////////////////////////////////

	// Booking details for current month
	public List<SipDivBookingSummary> getBookingSummary(String dm_Emp_Code, String division) throws SQLException {
		List<SipDivBookingSummary> bookingSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT DIVN,BKG_MTH_PERC,YTD_PERC,BKG_ACT_MTH,BKG_TGT_MTH,YTD_ACT,YTD_TGT FROM DM_BKNG_MTH_YTD_SUM_TBL  "
						+ "WHERE DIVN  = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT DIVN,BKG_MTH_PERC,YTD_PERC,BKG_ACT_MTH,BKG_TGT_MTH,YTD_ACT,YTD_TGT FROM DM_BKNG_MTH_YTD_SUM_TBL  "
						+ "WHERE DIVN = ? " + "AND DMCODE =  ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String mnt_perc = myRes.getString(2);
				String ytd_perc = myRes.getString(3);
				String mnt_actual = myRes.getString(4);
				String mnt_target = myRes.getString(5);
				SipDivBookingSummary tempBookingSummary = new SipDivBookingSummary(div, mnt_perc, ytd_perc, mnt_actual,
						mnt_target);
				bookingSummary.add(tempBookingSummary);
			}
			return bookingSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// Booking Summery for last 2 years
	public List<SipDivBookingSummary> getBookingLastTwoyears(String dm_Emp_Code, String division) throws SQLException {
		List<SipDivBookingSummary> bookingSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = " SELECT * FROM DM_BKNG_YTD_CUR_LAST2_TBL  WHERE DIVISION =  ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = " SELECT * FROM DM_BKNG_YTD_CUR_LAST2_TBL  " + " WHERE DIVISION =  ? " + " AND DMCODE = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String cyrTarget = myRes.getString(3);
				String cyrActual = myRes.getString(4);
				String prevYrTarget = myRes.getString(5);
				String prevYrActual = myRes.getString(6);
				String second_prv_yr_target = myRes.getString(7);
				String second_prv_yr_actual = myRes.getString(8);
				SipDivBookingSummary tempBookingSummary = new SipDivBookingSummary(div, cyrTarget, cyrActual,
						prevYrTarget, prevYrActual, second_prv_yr_target, second_prv_yr_actual);
				bookingSummary.add(tempBookingSummary);
			}
			return bookingSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	////////////////////////////////////////////

	// Billing details for current month
	public List<SipDivBillingSummary> getBillingSummary(String dm_Emp_Code, String division) throws SQLException {
		List<SipDivBillingSummary> billingSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = " SELECT DIVN,BL_MTH_PERC,YTD_PERC,BL_ACT_MTH, BL_TGT_MTH,YTD_ACT,YTD_TGT FROM DM_BLNG_MTH_YTD_SUM_TBL "
						+ " WHERE DIVN = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = " SELECT DIVN,BL_MTH_PERC,YTD_PERC,BL_ACT_MTH, BL_TGT_MTH,YTD_ACT,YTD_TGT FROM DM_BLNG_MTH_YTD_SUM_TBL "
						+ " WHERE DIVN = ?  AND DMCODE = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				long mnt_perc = myRes.getLong(2);
				String ytd_perc = myRes.getString(3);
				String mnt_actual = myRes.getString(4);
				String mnt_target = myRes.getString(5);
				String ytm_actual = myRes.getString(6);
				String ytm_target = myRes.getString(7);
				SipDivBillingSummary tempBillingSummary = new SipDivBillingSummary(div, mnt_perc, ytd_perc, mnt_actual,
						mnt_target, ytm_actual, ytm_target);
				billingSummary.add(tempBillingSummary);
			}
			return billingSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// Billing Summary for last 2 years
	public List<SipDivBillingSummary> getBillingLastTwoyears(String dm_Emp_Code, String division) throws SQLException {
		List<SipDivBillingSummary> billingSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT * FROM DM_BLNG_YTD_CUR_LAST2_TBL  WHERE DIVN  =  ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT * FROM DM_BLNG_YTD_CUR_LAST2_TBL  WHERE DIVN =  ? AND DMCODE = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String cyrTarget = myRes.getString(3);
				String cyrActual = myRes.getString(4);
				String prevYrTarget = myRes.getString(5);
				String prevYrActual = myRes.getString(6);
				String second_prv_yr_target = myRes.getString(7);
				String second_prv_yr_actual = myRes.getString(8);
				SipDivBillingSummary tempBillingSummary = new SipDivBillingSummary(div, cyrTarget, cyrActual,
						prevYrTarget, prevYrActual, second_prv_yr_target, second_prv_yr_actual);
				billingSummary.add(tempBillingSummary);
			}
			return billingSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	////////////////////////////////////////////

	// Forecast v/s Invoice Summary
	public List<SipDivForecast> getForecastDetails(String dm_Emp_Code, String division) throws SQLException {
		List<SipDivForecast> forecastSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT FJT_FCST_BILL.DIVN_NAME \"Div. Name\", " + "FJT_FCST_BILL.B_F \"Forecast\" , "
						+ "FJT_FCST_BILL.BILLING \"Invoiced\" , " + "B_F_1 \"Forecast1\", "
						+ "FJT_FCST_BILL.VRC \"Variance\", " + "FJT_FCST_BILL.TGR_PERC \"Target_Achieved%\", "
						+ "FJT_FCST_BILL.CR_DT \"Creation_Date\" " + "FROM FJT_FCST_BILL,FJT_DIVNNAME_DM "
						+ "WHERE FJT_FCST_BILL.DIVN_NAME = FJT_DIVNNAME_DM.DIVN_NAME "
						+ "AND FJT_DIVNNAME_DM.DIVN_NAME = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT FJT_FCST_BILL.DIVN_NAME \"Div. Name\", " + "FJT_FCST_BILL.B_F \"Forecast\" , "
						+ "FJT_FCST_BILL.BILLING \"Invoiced\" , " + "B_F_1 \"Forecast1\", "
						+ "FJT_FCST_BILL.VRC \"Variance\", " + "FJT_FCST_BILL.TGR_PERC \"Target_Achieved%\", "
						+ "FJT_FCST_BILL.CR_DT \"Creation_Date\" " + "FROM FJT_FCST_BILL,FJT_DIVNNAME_DM "
						+ "WHERE FJT_FCST_BILL.DIVN_NAME = FJT_DIVNNAME_DM.DIVN_NAME "
						+ "AND FJT_DIVNNAME_DM.DM_EMP_CODE = ? AND FJT_DIVNNAME_DM.DIVN_NAME= ?";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String forecast = myRes.getString(2);
				String invoice = myRes.getString(3);
				String rev_forecast = myRes.getString(4);
				String variance = myRes.getString(5);
				String target_perc = myRes.getString(6);
				String proccessed_date = myRes.getString(7);
				// System.out.println(div+" "+forecast+" "+invoice+" "+rev_forecast+"
				// "+variance+" "+target_perc);
				SipDivForecast tempForecastSummary = new SipDivForecast(div, forecast, invoice, rev_forecast, variance,
						target_perc, proccessed_date);
				forecastSummary.add(tempForecastSummary);
			}
			return forecastSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// Forecast Accuracy percentage for all month
	public List<SipDivForecastPercAccuracyDetails> getForecastAccuracyPercDetails(String division) throws SQLException {
		List<SipDivForecastPercAccuracyDetails> forecastPerAccSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String divisionName = "";
			switch (division) {
			case "KSAAHU":
				divisionName = "AHU-KSA";
				break;
			case "KSABL":
				divisionName = "BL-KSA";
				break;
			case "KSACT":
				divisionName = "KSA-CT";
				break;
			case "KSAEME":
				divisionName = "EME-KSA";
				break;
			case "KSAFT":
				divisionName = "FT-KSA";
				break;
			case "KSAPP":
				divisionName = "PP-KSA";
				break;
			case "KSAVALVES":
				divisionName = "VAL-KSA";
				break;
			default:
				divisionName = division;
				break;
			}
			String sql = " SELECT DIVN_NAME,CR_DT, NVL(JAN,0), NVL(FEB,0), NVL(MAR,0), NVL(APR,0), "
					+ " NVL(MAY,0), NVL(JUN,0), NVL(JUL,0), NVL(AUG,0), NVL(SEP,0), NVL(OCT,0), "
					+ " NVL(NOV,0), NVL(DEC,0),NVL(DIVN_ORDER_NUM,0), NVL(DIVN_SLS_CONV_RATE,0) FROM DIVN_MTH_ACH_PERC WHERE DIVN_NAME = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, divisionName);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div_temp = myRes.getString(1);
				String jan_temp = myRes.getString(3);
				String feb_temp = myRes.getString(4);
				String mar_temp = myRes.getString(5);
				String apr_temp = myRes.getString(6);
				String may_temp = myRes.getString(7);
				String jun_temp = myRes.getString(8);
				String jul_temp = myRes.getString(9);
				String aug_temp = myRes.getString(10);
				String sep_temp = myRes.getString(11);
				String oct_temp = myRes.getString(12);
				String nov_temp = myRes.getString(13);
				String dec_temp = myRes.getString(14);
				SipDivForecastPercAccuracyDetails tempForecastPerAccSummary = new SipDivForecastPercAccuracyDetails(
						div_temp, jan_temp, feb_temp, mar_temp, apr_temp, may_temp, jun_temp, jul_temp, aug_temp,
						sep_temp, oct_temp, nov_temp, dec_temp);
				forecastPerAccSummary.add(tempForecastPerAccSummary);
			}
			return forecastPerAccSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public String getDeafultDivisionforDm(String dm_Emp_Code) throws SQLException {
		// Find default division for each DM
		String div = "-";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SM_BL_SHORT_NAME FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_Emp_Code);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				div = myRes.getString(1);
			}
			return div;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// Enquiry to Quotation Analysis
	public List<SipDivEnquirtToQtnAnalysis> getEnqToQtnAnalysis(String dm_Emp_Code, String division)
			throws SQLException {
		List<SipDivEnquirtToQtnAnalysis> enqQtnAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT DIVN,NVL(YEAR,0),NVL(TOTENQRCVD,0),NVL(TOTQTD,0),NVL(NOQTD,0),NVL(AVGDAYS,0) FROM ENQ_QTD_SUM_TBL "
						+ "WHERE DIVN = ? ORDER BY YEAR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT DIVN,NVL(YEAR,0),NVL(TOTENQRCVD,0),NVL(TOTQTD,0),NVL(NOQTD,0),NVL(AVGDAYS,0) FROM ENQ_QTD_SUM_TBL "
						+ "WHERE DIVN = ? " + "AND DMCODE  = ? " + " ORDER BY YEAR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String year1 = myRes.getString(2);
				String enquiry_temp = myRes.getString(3);
				String qtn_temp = myRes.getString(4);
				String noQtn_temp = myRes.getString(5);
				String avg_days_temp = myRes.getString(6);
				SipDivEnquirtToQtnAnalysis tempenqQtnAnalysisSummary = new SipDivEnquirtToQtnAnalysis(div, year1,
						enquiry_temp, qtn_temp, noQtn_temp, avg_days_temp);
				enqQtnAnalysisSummary.add(tempenqQtnAnalysisSummary);
			}
			return enqQtnAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// JIH Qutation to LOI Analysis
	public List<SipDivQuotationToLoiAnalysis> getQtnToLoiAnalysis(String dm_Emp_Code, String division)
			throws SQLException {
		List<SipDivQuotationToLoiAnalysis> qtnLoiAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT DIVN,NVL(YEAR,0),NVL(QTN,0),NVL(QTNVAL,0),NVL(LOI,0),NVL(LOIVAL,0) FROM JIH_LOI_SUM_TBL "
						+ "WHERE DIVN = ? ORDER BY YEAR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT DIVN,NVL(YEAR,0),NVL(QTN,0),NVL(QTNVAL,0),NVL(LOI,0),NVL(LOIVAL,0) FROM JIH_LOI_SUM_TBL "
						+ "WHERE DIVN = ? " + "AND DMCODE  = ? " + " ORDER BY YEAR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String year1 = myRes.getString(2);
				String qtn_temp = myRes.getString(3);
				String qtn_val_temp = myRes.getString(4);
				String loi_temp = myRes.getString(5);
				String loi_val_temp = myRes.getString(6);
				SipDivQuotationToLoiAnalysis tempQtnLoiAnalysisSummary = new SipDivQuotationToLoiAnalysis(div, year1,
						qtn_temp, qtn_val_temp, loi_temp, loi_val_temp);
				qtnLoiAnalysisSummary.add(tempQtnLoiAnalysisSummary);
			}
			return qtnLoiAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	// LOI to SO Analysis
	public List<SipDivLoiToSoAnalysis> getLoiToSOAnalysis(String dm_Emp_Code, String division) throws SQLException {
		List<SipDivLoiToSoAnalysis> loiSoAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = " SELECT DIVN,NVL(YEARR,0),NVL(LOI,0),NVL(LOIVAL,0),NVL(SO,0),NVL(SOVAL,0) FROM LOI_ORDER_SUM_TBL "
						+ "WHERE DIVN = ? ORDER BY YEARR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = " SELECT DIVN,NVL(YEARR,0),NVL(LOI,0),NVL(LOIVAL,0),NVL(SO,0),NVL(SOVAL,0) FROM LOI_ORDER_SUM_TBL "
						+ "WHERE DIVN = ? " + "AND DMCODE  = ?  " + " ORDER BY YEARR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String year1 = myRes.getString(2);
				String loi_temp = myRes.getString(3);
				String loi_val_temp = myRes.getString(4);
				String so_temp = myRes.getString(5);
				String so_val_temp = myRes.getString(6);
				SipDivLoiToSoAnalysis tempLoiSoAnalysisSummary = new SipDivLoiToSoAnalysis(div, year1, loi_temp,
						loi_val_temp, so_temp, so_val_temp);
				loiSoAnalysisSummary.add(tempLoiSoAnalysisSummary);
			}
			return loiSoAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	// SO to Invoice Analysis
	public List<SipDivSoToInvoiceAnalysis> getSoToInvoiceAnalysis(String dm_Emp_Code, String division)
			throws SQLException {
		List<SipDivSoToInvoiceAnalysis> soInvoiceAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT DIVN,NVL(YEAR,0),NVL(SO,0),NVL(SOVAL,0),NVL(INV,0),NVL(INVVAL,0) FROM SO_INV_SUM_TBL "
						+ "WHERE DIVN = ? ORDER BY YEAR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
			} else {
				sql = "SELECT DIVN,NVL(YEAR,0),NVL(SO,0),NVL(SOVAL,0),NVL(INV,0),NVL(INVVAL,0) FROM SO_INV_SUM_TBL "
						+ "WHERE DIVN = ? " + "AND DMCODE  = ?  " + "ORDER BY YEAR ASC ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, division);
				myStmt.setString(2, dm_Emp_Code);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String year1 = myRes.getString(2);
				String so_temp = myRes.getString(3);
				String so_val_temp = myRes.getString(4);
				String invoice_temp = myRes.getString(5);
				String invoice_val_temp = myRes.getString(6);
				SipDivSoToInvoiceAnalysis tempSoInvoiceAnalysisSummary = new SipDivSoToInvoiceAnalysis(div, year1,
						so_temp, so_val_temp, invoice_temp, invoice_val_temp);
				soInvoiceAnalysisSummary.add(tempSoInvoiceAnalysisSummary);
			}
			return soInvoiceAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<SipOutRecvbleReprt> getOutstandingRecievableforSubDivn(String div_code, String dm_code)
			throws SQLException {
		List<SipOutRecvbleReprt> outstRcvbleRprt = new ArrayList<>();// Outstanding recvble aging repport list
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			if (dm_code.equals("E004853")) {
				String sql = " SELECT FJTDIVNCODE, SUM (BAL_AMT_0_30) BAL_AMT_0_30, SUM (BAL_AMT_30_60) BAL_AMT_30_60,  "
						+ " SUM (BAL_AMT_60_90) BAL_AMT_60_90, SUM (BAL_AMT_90_120) BAL_AMT_90_120,SUM (BAL_AMT_120_180) BAL_AMT_120_180,  "
						+ " SUM (BAL_AMT_181) BAL_AMT_181,CR_DT  FROM FJT_SM_RCVBLE_DET,  FJT_DMSM_TBL  "
						+ " WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ " FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,  "
						+ " (INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1))) AND FJTDIVNCODE = ?    "
						+ " GROUP BY FJTDIVNCODE,CR_DT ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, div_code);// sub divn code
			} else {
				String sql = " SELECT FJTDIVNCODE, SUM (BAL_AMT_0_30) BAL_AMT_0_30, SUM (BAL_AMT_30_60) BAL_AMT_30_60,  "
						+ " SUM (BAL_AMT_60_90) BAL_AMT_60_90, SUM (BAL_AMT_90_120) BAL_AMT_90_120,SUM (BAL_AMT_120_180) BAL_AMT_120_180,  "
						+ " SUM (BAL_AMT_181) BAL_AMT_181,CR_DT  FROM FJT_SM_RCVBLE_DET,  FJT_DMSM_TBL  "
						+ " WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
						+ " FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,  "
						+ " (INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1))) AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
						+ " GROUP BY FJTDIVNCODE,CR_DT ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, div_code);// sub divn code
				myStmt.setString(2, dm_code);// dm code
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String divn_code = myRes.getString(1);
				String aging1 = myRes.getString(2);
				String aging2 = myRes.getString(3);
				String aging3 = myRes.getString(4);
				String aging4 = myRes.getString(5);
				String aging5 = myRes.getString(6);
				String aging6 = myRes.getString(7);
				String cr_date = myRes.getString(8);
				SipOutRecvbleReprt tempOutRecvbleReprt = new SipOutRecvbleReprt(divn_code, aging1, aging2, aging3,
						aging4, aging5, aging6, cr_date);
				outstRcvbleRprt.add(tempOutRecvbleReprt);
			}
			return outstRcvbleRprt;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage3Summary(String theDmCode, String selSubDivn) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s3 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE3 FOR A GIVEN DM CODE .
			String sql = "SELECT SUM(AMOUNT) FROM STG3_DM_DETAIL,OM_SALESMAN " + "WHERE SALES_EGR_CODE = SM_CODE "
					+ "AND DMEMPCODE = ? AND SM_FLEX_14 = ?";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myStmt.setString(2, selSubDivn);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s3 = myRes.getLong(1);
			}
			return s3;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage4Summary(String theDmCode, String selSubDivn) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s4 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE4 FOR A GIVEN DM CODE .
			String sql = " SELECT SUM(BALANCE_VALUE) FROM FJT_STG4_DETAILS_TBL WHERE DMEMPCODE = ? AND DIVN = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, theDmCode);
			myStmt.setString(2, selSubDivn);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s4 = myRes.getLong(1);
			}
			return s4;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage1Summary(String theDmCode, String selSubDivn) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s4 = 0;
		try {
			myCon = orcl.getOrclConn();
			// SUMMARY VALUE OF STAGE1 FOR A GIVEN DM CODE .
			String sql = " SELECT NVL(ROUND(SUM(QTN_AMOUNT),0),0) AMT FROM STG1_DM_TBL,OM_SALESMAN WHERE SALES_EGR_CODE = SM_CODE "
					+ "AND SM_FLEX_14 = ? AND DM_CODE = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, selSubDivn);
			myStmt.setString(2, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s4 = myRes.getLong(1);
			}
			return s4;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long getJobInHandVolume(String dm_Emp_code, String defaultDivision) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		long s2 = 0;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT SUM(QTN_AMOUNT) FROM FJT_SM_JIH_AGEING_TBL,OM_SALESMAN WHERE SALES_EGR_CODE = SM_CODE "
					+ " AND DMEMPCODE = ? AND SM_FLEX_14 = ?";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_Emp_code);// division manager employee code
			myStmt.setString(2, defaultDivision);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				// String duration_tmp = myRes.getString(1);
				s2 = myRes.getLong(1);
			}
			return s2;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage1Details> stage1SummaryDetails(String dmCode, String selDivn) throws SQLException {
		List<Stage1Details> s1DetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE, CUST_NAME, PROJECT_NAME, CONSULTANT, JOB_STAGES, PROD_TYPE,  PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT, SALES_EGR_CODE, SALES_ENG_NAME  "
					+ " FROM STG1_DM_TBL ,OM_SALESMAN WHERE SALES_EGR_CODE = SM_CODE  AND SM_FLEX_14 = ? AND DM_CODE = ? order by QTN_DT ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, selDivn);
			myStmt.setString(2, dmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {

				String comp_code = myRes.getString(1);
				String week = myRes.getString(2);
				String qtn_date = myRes.getString(3);
				String qtn_code = myRes.getString(4);
				String qtn_number = myRes.getString(5);
				String customer_code = myRes.getString(6);
				String customer_name = myRes.getString(7);
				String project = myRes.getString(8);
				String consultant = myRes.getString(9);
				String job_stage = myRes.getString(10);
				String product_type = myRes.getString(11);
				String product_classifctn = myRes.getString(12);
				String zone = myRes.getString(13);
				String profit_perc = myRes.getString(14);
				int qtn_amount = myRes.getInt(15);
				String seg_code = myRes.getString(16);
				String seg_name = myRes.getString(17);
				Stage1Details temps1DetailsList = new Stage1Details(comp_code, week, qtn_date, qtn_code, qtn_number,
						customer_code, customer_name, project, consultant, job_stage, product_type, product_classifctn,
						zone, profit_perc, qtn_amount, seg_code, seg_name);
				s1DetailsList.add(temps1DetailsList);
			}
			return s1DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipJihvDetails> getStage2DetailsForDivision(String theDmCode, String selDivn) throws SQLException {
		List<SipJihvDetails> agingDetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT COMP_CODE, WEEK, QTN_DT, QTN_CODE, QTN_NO, CUST_CODE,   CUST_NAME, PROJECT_NAME, CONSULTANT, INVOICING_YEAR, PROD_TYPE,  PROD_CLASSFCN, ZONE,PROFIT_PERC, QTN_AMOUNT "
					+ " FROM FJT_SM_JIH_AGEING_TBL,OM_SALESMAN "
					+ "WHERE  SALES_EGR_CODE = SM_CODE AND SM_FLEX_14 = ? AND DMEMPCODE = ?  ORDER BY QTN_DT";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, selDivn);
			myStmt.setString(2, theDmCode);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String cmp_code = myRes.getString(1);
				String week = myRes.getString(2);
				String quatation_dt = myRes.getString(3);
				String quatation_code = myRes.getString(4);
				String quatation_num = myRes.getString(5);
				String customer_code = myRes.getString(6);
				String customer_name = myRes.getString(7);
				String project_name = myRes.getString(8);
				String consultant = myRes.getString(9);
				String invoicing_yr = myRes.getString(10);
				String prdct_type = myRes.getString(11);
				String product_classf = myRes.getString(12);
				String zone = myRes.getString(13);
				String profit_perc = myRes.getString(14);
				int qtn_amount = myRes.getInt(15);

				SipJihvDetails tempagingDetailsList = new SipJihvDetails(cmp_code, week, quatation_dt, quatation_code,
						quatation_num, customer_code, customer_name, project_name, consultant, invoicing_yr, prdct_type,
						product_classf, zone, profit_perc, qtn_amount);
				agingDetailsList.add(tempagingDetailsList);
			}
			return agingDetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public List<Stage3Details> stage3SummaryDetails(String thedM_code, String selDivn) throws SQLException {
		List<Stage3Details> s3DetailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT  WEEK, ZONE, SALES_EGR_CODE, PROD_CATG, PROD_SUB_CATG, PROJECT_NAME, CONSULTANT,  CUSTOMER, QUOT_DT, QUOT_CODE, QUOT_NO, AMOUNT, AVG_GP, LOI_RCD_DT, EXP_PO_DT, INVOICING_YEAR "
					+ "FROM STG3_DM_DETAIL , OM_SALESMAN WHERE SALES_EGR_CODE = SM_CODE AND SM_FLEX_14 = ? AND DMEMPCODE = ?  ORDER BY LOI_RCD_DT DESC ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, selDivn);
			myStmt.setString(2, thedM_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String week = myRes.getString(1);
				String zone = myRes.getString(2);
				String sales_eg_code = myRes.getString(3);
				String prod_cat = myRes.getString(4);
				String prod_sub_catg = myRes.getString(5);
				String prjct_name = myRes.getString(6);
				String consultnt = myRes.getString(7);
				String custmr = myRes.getString(8);
				String qt_dt = myRes.getString(9);
				String qtn_code = myRes.getString(10);
				String qtn_num = myRes.getString(11);
				int amount = myRes.getInt(12);
				String avg_gp = myRes.getString(13);
				String loi_rcd_dt = myRes.getString(14);
				String exp_po_dt = myRes.getString(15);
				String invoicing_year = myRes.getString(16);
				Stage3Details temps3DetailsList = new Stage3Details(week, zone, sales_eg_code, prod_cat, prod_sub_catg,
						prjct_name, consultnt, custmr, qt_dt, qtn_code, qtn_num, amount, avg_gp, loi_rcd_dt, exp_po_dt,
						invoicing_year);
				s3DetailsList.add(temps3DetailsList);
			}
			return s3DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<Stage4Details> stage4SummaryDetails(String thedm_code, String selDivn) throws SQLException {
		List<Stage4Details> s4DetailsList = new ArrayList<>();// aging details
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT SO_DT,SO_TXN_CODE, SO_NO, SOH_SM_CODE,SALES_ENG,  SH_LC_NO,LC_EXP_DT,ZONE,PROD_CATG,PROD_SUB_CATG,PROJECT, CONSULTANT,PMT_TERM,CUSTOMER,PROF_PERC,BALANCE_VALUE, PROJECTED_INV_DT,SO_LOCN_CODE "
					+ "FROM FJT_STG4_DETAILS_TBL WHERE DMEMPCODE = ? AND DIVN = ? ORDER BY SO_DT DESC ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, thedm_code);
			myStmt.setString(2, selDivn);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String so_date = myRes.getString(1);
				String so_trxn_code = myRes.getString(2);
				String so_number = myRes.getString(3);
				String sm_code = myRes.getString(4);
				String sm_name = myRes.getString(5);
				String sh_lc_nu = myRes.getString(6);
				String lc_exp_dt = myRes.getString(7);
				String zone = myRes.getString(8);
				String pdct_cat = myRes.getString(9);
				String pdct_sub_cat = myRes.getString(10);
				String prjct = myRes.getString(11);
				String consultant = myRes.getString(12);
				String pmt_term = myRes.getString(13);
				String customer = myRes.getString(14);
				String prof_perc = myRes.getString(15);
				int balance_value = myRes.getInt(16);
				String projected_inv_dt = myRes.getString(17);
				String so_lcn_code = myRes.getString(18);
				Stage4Details temps4DetailsList = new Stage4Details(so_date, so_trxn_code, so_number, sm_code, sm_name,
						sh_lc_nu, lc_exp_dt, zone, pdct_cat, pdct_sub_cat, prjct, consultant, pmt_term, customer,
						prof_perc, balance_value, projected_inv_dt, so_lcn_code);
				s4DetailsList.add(temps4DetailsList);
			}
			return s4DetailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public long stage5Summary(String dm_Emp_Code, String division) throws SQLException {
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		long s5 = 0;
		try {
			myCon = orcl.getOrclConn();
			String sql = "  SELECT NVL(CURYRACT,0) FROM DM_BLNG_YTD_CUR_LAST2_TBL  WHERE DIVN =  ? AND DMCODE = ? ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, division);
			myStmt.setString(2, dm_Emp_Code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				s5 = myRes.getLong(1);
			}
			return s5;
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipLayer2SubDivisionLevelBillingDetailsYTD> stage5SummaryDetails(String theDmCode, String theDivision)
			throws SQLException {
		List<SipLayer2SubDivisionLevelBillingDetailsYTD> detailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (theDmCode.equals("E004853")) {
				sql = " SELECT * FROM SIP_DM_BLNG_TBL  " + " WHERE DIVN_CODE = ?   "
						+ " AND  TO_CHAR(DOC_DATE,'YYYY')= TO_CHAR(SYSDATE,'YYYY') ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDivision);
			} else {
				sql = "  SELECT * FROM SIP_DM_BLNG_TBL   WHERE DIVN_CODE = ?    AND DM_CODE = ? AND TO_CHAR(DOC_DATE,'YYYY')= TO_CHAR(SYSDATE,'YYYY')";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDivision);
				myStmt.setString(2, theDmCode);

			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String company = myRes.getString(1);
				String week = myRes.getString(2);
				String documentID = myRes.getString(3);
				String documentDate = myRes.getString(4);
				String smCode = myRes.getString(5);
				String smName = myRes.getString(6);
				String dmCode = myRes.getString(7);
				String division = myRes.getString(8);
				String partyName = myRes.getString(9);
				String contact = myRes.getString(10);
				String telePhone = myRes.getString(11);
				String projectName = myRes.getString(12);
				String product = myRes.getString(13);
				String zone = myRes.getString(14);
				String currency = myRes.getString(15);
				String amount = myRes.getString(16);

				SipLayer2SubDivisionLevelBillingDetailsYTD tempdetailsList = new SipLayer2SubDivisionLevelBillingDetailsYTD(
						company, week, documentID, documentDate, smCode, smName, dmCode, division, partyName, contact,
						telePhone, projectName, product, zone, currency, amount);
				detailsList.add(tempdetailsList);
			}
			return detailsList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}
}
