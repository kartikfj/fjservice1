package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipDivPdcOnHand;
import beans.SipOutRecvbleReprt;

public class SipReceivablesDbUtil {
	public List<SipOutRecvbleReprt> getOustndngReceivableReportforDivision(String dm_emp_code) throws SQLException {
		// this function for outstanding recievable report for division with passing dm
		// code
		List<SipOutRecvbleReprt> receivableList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select * from FJT_SM_RCVBLE " + "where SM_CODE IN ( SELECT SM_CODE FROM ORION.OM_SALESMAN "
					+ "WHERE SM_FLEX_18 = ? )" + "ORDER BY 2";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String s_code = myRes.getString(1);
				String s_name = myRes.getString(2);
				String aging1_tmp = myRes.getString(3);
				String aging2_tmp = myRes.getString(4);
				String aging3_tmp = myRes.getString(5);
				String aging4_tmp = myRes.getString(6);
				String aging5_tmp = myRes.getString(7);
				String aging6_tmp = myRes.getString(8);
				String pr_date = myRes.getString(9);
				SipOutRecvbleReprt tempOutRecvbleReprt = new SipOutRecvbleReprt(s_code, s_name, aging1_tmp, aging2_tmp,
						aging3_tmp, aging4_tmp, aging5_tmp, aging6_tmp, pr_date);
				receivableList.add(tempOutRecvbleReprt);
			}
			return receivableList;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipDivPdcOnHand> getPdcOnHand(String dm_emp_code) throws SQLException {
		// this function for pdc on hand report for all divisions under dm with passing
		// dm code
		List<SipDivPdcOnHand> pdcList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "SELECT DIVN, NVL(SUM (JAN_AMT),0) JAN, NVL(SUM (FEB_AMT),0) FEB, NVL(SUM (MAR_AMT),0) MAR,NVL(SUM (APR_AMT),0) APR, NVL(SUM (MAY_AMT),0) MAY,NVL(SUM (JUN_AMT),0) JUN, "
					+ " NVL(SUM (JUL_AMT),0) JUL,  NVL(SUM (AUG_AMT),0) AUG, NVL(SUM (SEP_AMT),0) SEP,NVL(SUM (OCT_AMT),0) OCT, NVL(SUM (NOV_AMT),0) NOV, NVL(SUM (DEC_AMT),0) DEC "
					+ "FROM (  SELECT DIVN,SUM (LC_AMT) JAN_AMT, NULL FEB_AMT, NULL MAR_AMT, NULL APR_AMT, NULL MAY_AMT, NULL JUN_AMT,  "
					+ "NULL JUL_AMT, NULL AUG_AMT,  NULL SEP_AMT,NULL OCT_AMT,NULL NOV_AMT, NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'JAN'  GROUP BY DIVN  " + "UNION ALL   "
					+ "SELECT DIVN,NULL JAN_AMT, SUM (LC_AMT) FEB_AMT,NULL MAR_AMT, NULL APR_AMT,  NULL MAY_AMT,  "
					+ "NULL JUN_AMT,  NULL JUL_AMT, NULL AUG_AMT,NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT, NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'FEB' GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,SUM (LC_AMT) MAR_AMT, NULL APR_AMT, NULL MAY_AMT,  NULL JUN_AMT, NULL JUL_AMT,    "
					+ "NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT,  "
					+ "NULL NOV_AMT, NULL DEC_AMT FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'MAR' GROUP BY DIVN  "
					+ "UNION ALL  "
					+ "SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,NULL MAR_AMT,SUM (LC_AMT) APR_AMT,NULL MAY_AMT,  "
					+ "NULL JUN_AMT, NULL JUL_AMT,NULL AUG_AMT,NULL SEP_AMT, NULL OCT_AMT,NULL NOV_AMT, NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'APR' GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,  NULL MAR_AMT,NULL APR_AMT,SUM (LC_AMT) MAY_AMT,  "
					+ "NULL JUN_AMT, NULL JUL_AMT,NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT,NULL NOV_AMT, NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'MAY' GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN,NULL JAN_AMT,  NULL FEB_AMT, NULL MAR_AMT, NULL APR_AMT, NULL MAY_AMT, SUM (LC_AMT) JUN_AMT,  "
					+ "NULL JUL_AMT,NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT,NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'JUN' GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT, NULL MAR_AMT,NULL APR_AMT,NULL MAY_AMT,NULL JUN_AMT,  "
					+ "SUM (LC_AMT) JUL_AMT,  NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT, NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'JUL' GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN,NULL JAN_AMT, NULL FEB_AMT,NULL MAR_AMT, NULL APR_AMT,NULL MAY_AMT,  "
					+ "NULL JUN_AMT,NULL JUL_AMT, SUM (LC_AMT) AUG_AMT,NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT,NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'AUG' GROUP BY DIVN  "
					+ "UNION ALL SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT, NULL MAR_AMT, NULL APR_AMT, NULL MAY_AMT,  "
					+ "NULL JUN_AMT, NULL JUL_AMT, NULL AUG_AMT, SUM (LC_AMT) SEP_AMT,NULL OCT_AMT,  NULL NOV_AMT,NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'SEP'  GROUP BY DIVN  "
					+ "UNION ALL SELECT DIVN,NULL JAN_AMT, NULL FEB_AMT, NULL MAR_AMT,NULL APR_AMT, NULL MAY_AMT, NULL JUN_AMT,  "
					+ "NULL JUL_AMT, NULL AUG_AMT,NULL SEP_AMT, SUM (LC_AMT) OCT_AMT, NULL NOV_AMT, NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'OCT'  GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN,NULL JAN_AMT,NULL FEB_AMT, NULL MAR_AMT,NULL APR_AMT,NULL MAY_AMT,  NULL JUN_AMT,  NULL JUL_AMT,  "
					+ "NULL AUG_AMT, NULL SEP_AMT,  NULL OCT_AMT, SUM (LC_AMT) NOV_AMT,NULL DEC_AMT  "
					+ "FROM FJT_PDC_HAND WHERE DM_EMP_CODE = ? AND MONTH = 'NOV'  GROUP BY DIVN  " + "UNION ALL  "
					+ "SELECT DIVN, NULL JAN_AMT, NULL FEB_AMT,NULL MAR_AMT,  NULL APR_AMT, NULL MAY_AMT, NULL JUN_AMT, NULL JUL_AMT,   "
					+ "NULL AUG_AMT, NULL SEP_AMT, NULL OCT_AMT, NULL NOV_AMT, SUM (LC_AMT) DEC_AMT  "
					+ "FROM FJT_PDC_HAND  WHERE DM_EMP_CODE = ?  AND MONTH = 'DEC' GROUP BY DIVN) GROUP BY DIVN";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myStmt.setString(2, dm_emp_code);
			myStmt.setString(3, dm_emp_code);
			myStmt.setString(4, dm_emp_code);
			myStmt.setString(5, dm_emp_code);
			myStmt.setString(6, dm_emp_code);
			myStmt.setString(7, dm_emp_code);
			myStmt.setString(8, dm_emp_code);
			myStmt.setString(9, dm_emp_code);
			myStmt.setString(10, dm_emp_code);
			myStmt.setString(11, dm_emp_code);
			myStmt.setString(12, dm_emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String divname = myRes.getString(1);
				String jan_data_tmp = myRes.getString(2);
				String feb_data_tmp = myRes.getString(3);
				String mar_data_tmp = myRes.getString(4);
				String apr_data_tmp = myRes.getString(5);
				String may_data_tmp = myRes.getString(6);
				String jun_data_tmp = myRes.getString(7);
				String jul_data_tmp = myRes.getString(8);
				String aug_data_tmp = myRes.getString(9);
				String sep_data_tmp = myRes.getString(10);
				String oct_data_tmp = myRes.getString(11);
				String nov_data_tmp = myRes.getString(12);
				String dec_data_tmp = myRes.getString(13);
				SipDivPdcOnHand tempPdcReprt = new SipDivPdcOnHand(divname, jan_data_tmp, feb_data_tmp, mar_data_tmp,
						apr_data_tmp, may_data_tmp, jun_data_tmp, jul_data_tmp, aug_data_tmp, sep_data_tmp,
						oct_data_tmp, nov_data_tmp, dec_data_tmp);
				pdcList.add(tempPdcReprt);
			}
			return pdcList;

		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();

		}
	}

	public String getDivisionListforDM(String dm_emp_code) throws SQLException {
		// function for fetching division list under a Division Manager
		String divisionDetailsList = null;
		StringBuilder sb = new StringBuilder();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "select distinct FJTDIVNCODE from FJT_DMSM_TBL where DMEMPCODE=? "
					+ " and FJTDIVNCODE is not null and FJTDIVNNAME is not null  AND FJTSTATUS = 'Y' " + "ORDER BY 1";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, dm_emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div_code = myRes.getString(1);
				sb.append("'" + div_code + "',");
				divisionDetailsList = sb.toString();
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

}
