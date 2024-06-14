package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipDivEnquirtToQtnLayer2Details;
import beans.SipDivLoiToOrderLayer2Details;
import beans.SipDivOrderToInvcLayer2Details;
import beans.SipDivQtnToLoiLayer2Details;
import beans.SipDivisionOutstandingRecivablesDtls;
import beans.SipLayer2SubDivisionLevelBillingDetailsYTD;
import beans.SipLayer2SubDivisionLevelBookingDetailsYTD;

public class SipDivisionChartLayer2DbUtil {

	public List<SipDivEnquirtToQtnLayer2Details> getEnqToQtnYearWiseDetails(String dm_Emp_Code, String division,
			String year_temp) throws SQLException {
		// Enquiry to Quotation Year and division wise details
		List<SipDivEnquirtToQtnLayer2Details> enqQtnAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {// Modified to give access to Mr.Nagib
				sql = "SELECT DIVN,  MON,  NVL(SUM (TOTENQ),0) TOTENQRCVD,  NVL(SUM (TOTQUOT),0) TOTQTD,  CASE  WHEN SUM (TOTENQ) > SUM (TOTQUOT)  THEN  "
						+ " (SUM (TOTENQ) - SUM (TOTQUOT))  ELSE  0  END  AS NOQTD,  ROUND (SUM (DAYS) / SUM (TOTQUOT)) AVGDAYS   FROM (  "
						+ " SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CEH_DT, 'MON') MON,  TO_CHAR (CEH_DT, 'MM') MM,  COUNT (CEH_SYS_ID) TOTENQ, "
						+ " NULL TOTQUOT,  NULL DAYS  FROM OT_CUST_ENQUIRY_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B    WHERE  CEH_SM_CODE = B.SM_CODE "
						+ " AND A.SM_CODE = B.SM_CODE  AND CEH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ? "
						+ " AND TO_NUMBER (TO_CHAR (CEH_DT, 'RRRR')) = :YEAR  AND (CEH_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ? , 'DDMMRRRR')   "
						+ " AND TO_DATE (TO_CHAR (SYSDATE, 'DDMM') || ? ,    'DDMMRRRR')) "
						+ " GROUP BY B.FJTDIVNCODE, TO_CHAR (CEH_DT, 'MON'), TO_CHAR (CEH_DT, 'MM') UNION ALL  "
						+ " SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CQH_CR_DT, 'MON') MON,  TO_CHAR (CQH_CR_DT, 'MM') MM,  NULL TOTENQ, "
						+ " COUNT (DISTINCT CQH_SYS_ID) TOTQUOT,  SUM (  CQH_CR_DT   - (SELECT CEH_DT   FROM OT_CUST_ENQUIRY_HEAD "
						+ " WHERE CEH_SYS_ID = CQH_QH_SYS_ID))    DAYS  FROM OM_SALESMAN A, OT_CUST_QUOT_HEAD, FJT_DMSM_TBL B    WHERE  CQH_SM_CODE = B.SM_CODE "
						+ " AND CQH_SM_CODE = A.SM_CODE  AND A.SM_CODE = B.SM_CODE  AND CQH_TXN_CODE = B.FJTTXNCODE "
						+ " AND B.FJTDIVNCODE = ?    AND TO_NUMBER (TO_CHAR (CQH_CR_DT, 'RRRR')) = ?  "
						+ " AND (CQH_CR_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ? , 'DDMMRRRR')  AND TO_DATE (TO_CHAR (SYSDATE, 'DDMM') || ? , "
						+ " 'DDMMRRRR')) GROUP BY B.FJTDIVNCODE, TO_CHAR (CQH_CR_DT, 'MON'), TO_CHAR (CQH_CR_DT, 'MM')  ) GROUP BY DIVN,MON,MM ORDER BY DIVN, MM";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				// myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(5, division);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, year_temp);
				myStmt.setString(8, year_temp);
			} else {
				sql = "SELECT DIVN,  MON,  NVL(SUM (TOTENQ),0) TOTENQRCVD,  NVL(SUM (TOTQUOT),0) TOTQTD,  CASE  WHEN SUM (TOTENQ) > SUM (TOTQUOT)  THEN  "
						+ " (SUM (TOTENQ) - SUM (TOTQUOT))  ELSE  0  END  AS NOQTD,  ROUND (SUM (DAYS) / SUM (TOTQUOT)) AVGDAYS   FROM (  "
						+ " SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CEH_DT, 'MON') MON,  TO_CHAR (CEH_DT, 'MM') MM,  COUNT (CEH_SYS_ID) TOTENQ, "
						+ " NULL TOTQUOT,  NULL DAYS  FROM OT_CUST_ENQUIRY_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B    WHERE  CEH_SM_CODE = B.SM_CODE "
						+ " AND A.SM_CODE = B.SM_CODE  AND B.DMEMPCODE = ? AND CEH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ? "
						+ " AND TO_NUMBER (TO_CHAR (CEH_DT, 'RRRR')) = :YEAR  AND (CEH_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ? , 'DDMMRRRR')   "
						+ " AND TO_DATE (TO_CHAR (SYSDATE, 'DDMM') || ? ,    'DDMMRRRR')) "
						+ " GROUP BY B.FJTDIVNCODE, TO_CHAR (CEH_DT, 'MON'), TO_CHAR (CEH_DT, 'MM') UNION ALL  "
						+ " SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CQH_CR_DT, 'MON') MON,  TO_CHAR (CQH_CR_DT, 'MM') MM,  NULL TOTENQ, "
						+ " COUNT (DISTINCT CQH_SYS_ID) TOTQUOT,  SUM (  CQH_CR_DT   - (SELECT CEH_DT   FROM OT_CUST_ENQUIRY_HEAD "
						+ " WHERE CEH_SYS_ID = CQH_QH_SYS_ID))    DAYS  FROM OM_SALESMAN A, OT_CUST_QUOT_HEAD, FJT_DMSM_TBL B    WHERE  CQH_SM_CODE = B.SM_CODE "
						+ " AND CQH_SM_CODE = A.SM_CODE  AND A.SM_CODE = B.SM_CODE  AND B.DMEMPCODE = ? AND CQH_TXN_CODE = B.FJTTXNCODE "
						+ " AND B.FJTDIVNCODE = ?    AND TO_NUMBER (TO_CHAR (CQH_CR_DT, 'RRRR')) = ?  "
						+ " AND (CQH_CR_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ? , 'DDMMRRRR')  AND TO_DATE (TO_CHAR (SYSDATE, 'DDMM') || ? , "
						+ " 'DDMMRRRR')) GROUP BY B.FJTDIVNCODE, TO_CHAR (CQH_CR_DT, 'MON'), TO_CHAR (CQH_CR_DT, 'MM')  ) GROUP BY DIVN,MON,MM ORDER BY DIVN, MM";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(7, division);
				myStmt.setString(8, year_temp);
				myStmt.setString(9, year_temp);
				myStmt.setString(10, year_temp);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String month = myRes.getString(2);
				String tot_enq_rcvd_temp = myRes.getString(3);
				String tot_qtd_temp = myRes.getString(4);
				String noQtd_temp = myRes.getString(5);
				String avg_days_temp = myRes.getString(6);
				SipDivEnquirtToQtnLayer2Details tempenqQtnAnalysisSummary = new SipDivEnquirtToQtnLayer2Details(div,
						month, tot_enq_rcvd_temp, tot_qtd_temp, noQtd_temp, avg_days_temp);
				enqQtnAnalysisSummary.add(tempenqQtnAnalysisSummary);
			}
			return enqQtnAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<SipDivQtnToLoiLayer2Details> getQtnToLoiYearWiseDetails(String dm_Emp_Code, String division,
			String year_temp) throws SQLException {
		// JIH Qtn to LOI Year and division wise details
		List<SipDivQtnToLoiLayer2Details> qtnToLoiAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {// Modified to give access to Mr.Nagib
				sql = "  SELECT DIVN,  MON,  SUM (TOTQTN) QTN,  TRUNC ( (SUM (QUOTLCVAL) / 1000000), 2) QTNVAL,  "
						+ " NVL (SUM (TOTLOI), 0) LOI,  NVL (TRUNC ( (SUM (LOIVAL) / 1000000), 2), 0) LOIVAL  "
						+ " FROM ( SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CQH_DT, 'MON') MON,  "
						+ " TO_CHAR (CQH_DT, 'MM') MM,  COUNT (CQH_SYS_ID) TOTQTN,  SUM (BV_GET_QT_AMT_AED (CQH_SYS_ID)) QUOTLCVAL,  "
						+ " NULL LOIVAL,  NULL TOTLOI  FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B  WHERE CQH_SM_CODE = B.SM_CODE  "
						+ " AND A.SM_CODE = B.SM_CODE   AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  "
						+ " AND F_GET_JOB_NAME_MA (CQH_FLEX_03) = 'JOB IN HAND'  AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?   "
						+ " AND (CQH_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM') || ?,  "
						+ " 'DDMMRRRR'))  GROUP BY B.FJTDIVNCODE,  TO_CHAR (CQH_DT, 'MON'),  TO_CHAR (CQH_DT, 'MM')  UNION ALL  "
						+ " SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CQH_DT, 'MON') MON,  TO_CHAR (CQH_DT, 'MM') MM,  NULL TOTQTN,  "
						+ " NULL QUOTLCVAL,  "
						+ " SUM(DECODE(CQH_FLEX_20,NULL,BV_GET_LC_AMT(CQH_COMP_CODE,QUOT_AMT*CQH_EXGE_RATE) ,CQH_FLEX_20)) LOIVAL,  "
						+ " COUNT (CQH_SYS_ID) TOTLOI  "
						+ " FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B,( SELECT CQI_CQH_SYS_ID, SUM(DECODE(NVL(CQI_FC_VAL_AFT_H_DISC,0),0 ,NVL( CQI_FC_VAL,0)   "
						+ ",CQI_FC_VAL_AFT_H_DISC ) ) QUOT_AMT FROM OT_CUST_QUOT_ITEM WHERE CQI_CQH_SYS_ID IS NOT NULL GROUP BY CQI_CQH_SYS_ID   "
						+ ") QUOT  WHERE   CQH_SM_CODE = B.SM_CODE  AND CQI_CQH_SYS_ID(+) = OT_CUST_QUOT_HEAD.CQH_SYS_ID  AND A.SM_CODE = B.SM_CODE  "
						+ " AND B.DMEMPCODE = ? AND CQH_TXN_CODE = B.FJTTXNCODE  AND CQH_FLEX_12 IS NOT NULL  "
						+ " AND CQH_FLEX_20 IS NOT NULL  AND NVL (CQH_FLEX_17, 'L') <> 'L'  AND TO_DATE (CQH_FLEX_12, 'DD/MM/RRRR') <=  "
						+ " TO_DATE (SYSDATE, 'DD/MM/RRRR')  AND CQH_CUST_CODE NOT LIKE 'RP%'  AND CQH_CUST_CODE NOT IN (SELECT RP_CODE  "
						+ "  FROM FJT_RELPARTY_LIST  WHERE RP_EXCLUDE_YN_NUM = 1)  AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?   "
						+ "  AND (CQH_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM') || ?,  "
						+ " 'DDMMRRRR'))  GROUP BY B.FJTDIVNCODE,  TO_CHAR (CQH_DT, 'MON'),  TO_CHAR (CQH_DT, 'MM')) GROUP BY DIVN, MON, MM  "
						+ "ORDER BY DIVN, MM ";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				// myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(5, division);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, year_temp);
				myStmt.setString(8, year_temp);
			} else {
				sql = "  SELECT DIVN,  MON,  SUM (TOTQTN) QTN,  TRUNC ( (SUM (QUOTLCVAL) / 1000000), 2) QTNVAL,  "
						+ " NVL (SUM (TOTLOI), 0) LOI,  NVL (TRUNC ( (SUM (LOIVAL) / 1000000), 2), 0) LOIVAL  "
						+ " FROM ( SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CQH_DT, 'MON') MON,  "
						+ " TO_CHAR (CQH_DT, 'MM') MM,  COUNT (CQH_SYS_ID) TOTQTN,  SUM (BV_GET_QT_AMT_AED (CQH_SYS_ID)) QUOTLCVAL,  "
						+ " NULL LOIVAL,  NULL TOTLOI  FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B  WHERE CQH_SM_CODE = B.SM_CODE  "
						+ " AND A.SM_CODE = B.SM_CODE  AND B.DMEMPCODE = ?  AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  "
						+ " AND F_GET_JOB_NAME_MA (CQH_FLEX_03) = 'JOB IN HAND'  AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?   "
						+ " AND (CQH_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM') || ?,  "
						+ " 'DDMMRRRR'))  GROUP BY B.FJTDIVNCODE,  TO_CHAR (CQH_DT, 'MON'),  TO_CHAR (CQH_DT, 'MM')  UNION ALL  "
						+ " SELECT B.FJTDIVNCODE DIVN,  TO_CHAR (CQH_DT, 'MON') MON,  TO_CHAR (CQH_DT, 'MM') MM,  NULL TOTQTN,  "
						+ " NULL QUOTLCVAL,  "
						+ " SUM(DECODE(CQH_FLEX_20,NULL,BV_GET_LC_AMT(CQH_COMP_CODE,QUOT_AMT*CQH_EXGE_RATE) ,CQH_FLEX_20)) LOIVAL,  "
						+ " COUNT (CQH_SYS_ID) TOTLOI  "
						+ " FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B,( SELECT CQI_CQH_SYS_ID, SUM(DECODE(NVL(CQI_FC_VAL_AFT_H_DISC,0),0 ,NVL( CQI_FC_VAL,0)   "
						+ ",CQI_FC_VAL_AFT_H_DISC ) ) QUOT_AMT FROM OT_CUST_QUOT_ITEM WHERE CQI_CQH_SYS_ID IS NOT NULL GROUP BY CQI_CQH_SYS_ID   "
						+ ") QUOT  WHERE   CQH_SM_CODE = B.SM_CODE  AND CQI_CQH_SYS_ID(+) = OT_CUST_QUOT_HEAD.CQH_SYS_ID  AND A.SM_CODE = B.SM_CODE  "
						+ " AND B.DMEMPCODE = ? AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  AND CQH_FLEX_12 IS NOT NULL  "
						+ " AND CQH_FLEX_20 IS NOT NULL  AND NVL (CQH_FLEX_17, 'L') <> 'L'  AND TO_DATE (CQH_FLEX_12, 'DD/MM/RRRR') <=  "
						+ " TO_DATE (SYSDATE, 'DD/MM/RRRR')  AND CQH_CUST_CODE NOT LIKE 'RP%'  AND CQH_CUST_CODE NOT IN (SELECT RP_CODE  "
						+ "  FROM FJT_RELPARTY_LIST  WHERE RP_EXCLUDE_YN_NUM = 1)  AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?   "
						+ "  AND (CQH_DT BETWEEN TO_DATE (TO_CHAR ('0101') || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM') || ?,  "
						+ " 'DDMMRRRR'))  GROUP BY B.FJTDIVNCODE,  TO_CHAR (CQH_DT, 'MON'),  TO_CHAR (CQH_DT, 'MM')) GROUP BY DIVN, MON, MM  "
						+ "ORDER BY DIVN, MM ";

				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(7, division);
				myStmt.setString(8, year_temp);
				myStmt.setString(9, year_temp);
				myStmt.setString(10, year_temp);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String month = myRes.getString(2);
				String qtn_temp = myRes.getString(3);
				String qtn_value_temp = myRes.getString(4);
				String loi_temp = myRes.getString(5);
				String loi_value_temp = myRes.getString(6);
				SipDivQtnToLoiLayer2Details tempqtnToLoiAnalysisSummary = new SipDivQtnToLoiLayer2Details(div, month,
						qtn_temp, qtn_value_temp, loi_temp, loi_value_temp);
				qtnToLoiAnalysisSummary.add(tempqtnToLoiAnalysisSummary);
			}
			return qtnToLoiAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<SipDivLoiToOrderLayer2Details> getLoiToOrderYearWiseDetails(String dm_Emp_Code, String division,
			String year_temp) throws SQLException {
		// LOI to So Year and division wise details
		List<SipDivLoiToOrderLayer2Details> qtnToLoiAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {// Modified to give access to Mr.Nagib
				sql = " SELECT DIVN,MON, NVL(SUM (TOTLOI),0) LOI,NVL(TRUNC((SUM(LOIVAL)/1000000),2),0) LOIVAL,  "
						+ " NVL(SUM (TOTSO),0) SO,NVL(TRUNC((SUM(SOVAL)/1000000),2),0) SOVAL  "
						+ " FROM (  SELECT B.FJTDIVNCODE DIVN, TO_CHAR (CQH_DT, 'MON') MON, TO_CHAR (CQH_DT, 'MM') MM,  "
						+ " COUNT (CQH_SYS_ID) TOTLOI,SUM (NVL(CQH_FLEX_20,F_GET_QUOT_TED_FJT(CQH_SYS_ID)))LOIVAL,  "
						+ " NULL SOVAL,  NULL TOTSO   FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B  "
						+ " WHERE     CQH_SM_CODE = B.SM_CODE  AND A.SM_CODE = B.SM_CODE   "
						+ " AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  AND CQH_FLEX_12 IS NOT NULL  "
						+ " AND CQH_FLEX_20 IS NOT NULL  AND NVL(CQH_FLEX_17,'L') <> 'L'   "
						+ " AND TO_DATE (CQH_FLEX_12, 'DD/MM/RRRR') <= TO_DATE (SYSDATE, 'DD/MM/RRRR')  "
						+ " AND CQH_CUST_CODE NOT LIKE 'RP%'    AND CQH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)     "
						+ " AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?    AND (CQH_DT BETWEEN TO_DATE (     TO_CHAR ('0101')  "
						+ " || ?,  'DDMMRRRR')       AND TO_DATE (     TO_CHAR (SYSDATE, 'DDMM')  || ?,  'DDMMRRRR')  )     "
						+ " GROUP BY B.FJTDIVNCODE, TO_CHAR (CQH_DT, 'MON'), TO_CHAR (CQH_DT, 'MM')  " + " UNION ALL   "
						+ " SELECT B.FJTDIVNCODE DIVN, TO_CHAR (SOH_DT, 'MON') MON, TO_CHAR (SOH_DT, 'MM') MM,  "
						+ " NULL TOTLOI,NULL LOIVAL,SUM(BV_GET_SO_LC_AMT(SOH_SYS_ID)) SOVAL,   "
						+ " COUNT (SOH_SYS_ID) TOTLOI   FROM OT_SO_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B  "
						+ " WHERE     SOH_SM_CODE = B.SM_CODE       AND A.SM_CODE = B.SM_CODE    "
						+ " AND SOH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  AND SOH_CUST_CODE NOT LIKE 'RP%'    "
						+ " AND SOH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ " AND TO_NUMBER (TO_CHAR (SOH_DT, 'RRRR')) = ?  AND (SOH_DT BETWEEN TO_DATE (  "
						+ " TO_CHAR ('0101')  || ?,  'DDMMRRRR')       AND TO_DATE (     TO_CHAR (SYSDATE, 'DDMM')  "
						+ " || ?,  'DDMMRRRR')  )   GROUP BY B.FJTDIVNCODE, TO_CHAR (SOH_DT, 'MON'), TO_CHAR (SOH_DT, 'MM')     "
						+ " ) GROUP BY DIVN,MON,MM ORDER BY DIVN, MM";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				// myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(5, division);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, year_temp);
				myStmt.setString(8, year_temp);
			} else {
				sql = " SELECT DIVN,MON, NVL(SUM (TOTLOI),0) LOI,NVL(TRUNC((SUM(LOIVAL)/1000000),2),0) LOIVAL,  "
						+ " NVL(SUM (TOTSO),0) SO,NVL(TRUNC((SUM(SOVAL)/1000000),2),0) SOVAL  "
						+ " FROM (  SELECT B.FJTDIVNCODE DIVN, TO_CHAR (CQH_DT, 'MON') MON, TO_CHAR (CQH_DT, 'MM') MM,  "
						+ " COUNT (CQH_SYS_ID) TOTLOI,SUM (NVL(CQH_FLEX_20,F_GET_QUOT_TED_FJT(CQH_SYS_ID)))LOIVAL,  "
						+ " NULL SOVAL,  NULL TOTSO   FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B  "
						+ " WHERE     CQH_SM_CODE = B.SM_CODE  AND A.SM_CODE = B.SM_CODE  AND B.DMEMPCODE = ?  "
						+ " AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  AND CQH_FLEX_12 IS NOT NULL  "
						+ " AND CQH_FLEX_20 IS NOT NULL  AND NVL(CQH_FLEX_17,'L') <> 'L'   "
						+ " AND TO_DATE (CQH_FLEX_12, 'DD/MM/RRRR') <= TO_DATE (SYSDATE, 'DD/MM/RRRR')  "
						+ " AND CQH_CUST_CODE NOT LIKE 'RP%'    AND CQH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)     "
						+ " AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?    AND (CQH_DT BETWEEN TO_DATE (     TO_CHAR ('0101')  "
						+ " || ?,  'DDMMRRRR')       AND TO_DATE (     TO_CHAR (SYSDATE, 'DDMM')  || ?,  'DDMMRRRR')  )     "
						+ " GROUP BY B.FJTDIVNCODE, TO_CHAR (CQH_DT, 'MON'), TO_CHAR (CQH_DT, 'MM')  " + " UNION ALL   "
						+ " SELECT B.FJTDIVNCODE DIVN, TO_CHAR (SOH_DT, 'MON') MON, TO_CHAR (SOH_DT, 'MM') MM,  "
						+ " NULL TOTLOI,NULL LOIVAL,SUM(BV_GET_SO_LC_AMT(SOH_SYS_ID)) SOVAL,   "
						+ " COUNT (SOH_SYS_ID) TOTLOI   FROM OT_SO_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B  "
						+ " WHERE     SOH_SM_CODE = B.SM_CODE       AND A.SM_CODE = B.SM_CODE  AND B.DMEMPCODE = ?  "
						+ " AND SOH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  AND SOH_CUST_CODE NOT LIKE 'RP%'    "
						+ " AND SOH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ " AND TO_NUMBER (TO_CHAR (SOH_DT, 'RRRR')) = ?  AND (SOH_DT BETWEEN TO_DATE (  "
						+ " TO_CHAR ('0101')  || ?,  'DDMMRRRR')       AND TO_DATE (     TO_CHAR (SYSDATE, 'DDMM')  "
						+ " || ?,  'DDMMRRRR')  )   GROUP BY B.FJTDIVNCODE, TO_CHAR (SOH_DT, 'MON'), TO_CHAR (SOH_DT, 'MM')     "
						+ " ) GROUP BY DIVN,MON,MM ORDER BY DIVN, MM";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(7, division);
				myStmt.setString(8, year_temp);
				myStmt.setString(9, year_temp);
				myStmt.setString(10, year_temp);

			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String month = myRes.getString(2);
				String tot_enq_rcvd_temp = myRes.getString(3);
				String tot_qtd_temp = myRes.getString(4);
				String noQtd_temp = myRes.getString(5);
				String avg_days_temp = myRes.getString(6);
				SipDivLoiToOrderLayer2Details tempqtnToLoiAnalysisSummary = new SipDivLoiToOrderLayer2Details(div,
						month, tot_enq_rcvd_temp, tot_qtd_temp, noQtd_temp, avg_days_temp);
				qtnToLoiAnalysisSummary.add(tempqtnToLoiAnalysisSummary);
			}
			return qtnToLoiAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	public List<SipDivOrderToInvcLayer2Details> getOrderToInvoiceYearWiseDetails(String dm_Emp_Code, String division,
			String year_temp) throws SQLException {
		// So to invoice Year and division wise details
		List<SipDivOrderToInvcLayer2Details> qtnToLoiAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = " SELECT DIVN,MON,MM,  NVL(SUM (TOTSO),0) SO,NVL(TRUNC((SUM(SOVAL)/1000000),2),0) SOVAL,  "
						+ " NVL(SUM (TOTINV),0) INV,NVL(TRUNC((SUM(INVVAL)/1000000),2),0)INVVAL  "
						+ " FROM (   SELECT B.FJTDIVNCODE DIVN, TO_CHAR (SOH_DT, 'MON') MON,TO_CHAR (SOH_DT, 'MM') MM,  "
						+ " COUNT (SOH_SYS_ID) TOTSO,SUM (BV_GET_SO_LC_AMT(SOH_SYS_ID))SOVAL,NULL TOTINV,  "
						+ " NULL INVVAL  FROM OT_SO_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B    WHERE  SOH_SM_CODE = B.SM_CODE  "
						+ " AND A.SM_CODE = B.SM_CODE   AND SOH_TXN_CODE = B.FJTTXNCODE  "
						+ " AND B.FJTDIVNCODE = ?  AND SOH_CUST_CODE NOT LIKE 'RP%'    "
						+ " AND SOH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ " AND TO_NUMBER (TO_CHAR (SOH_DT, 'RRRR')) = ?  AND (SOH_DT BETWEEN TO_DATE (  "
						+ " TO_CHAR ('0101')  || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM')  "
						+ " || ?,  'DDMMRRRR')  )    GROUP BY B.FJTDIVNCODE, TO_CHAR (SOH_DT, 'MON'),TO_CHAR (SOH_DT, 'MM')   "
						+ " UNION ALL    "
						+ " SELECT B.FJTDIVNCODE DIVN, TO_CHAR (INVH_DT, 'MON') MON,TO_CHAR (INVH_DT, 'MM') MM,  "
						+ " NULL TOTSO,NULL SOVAL,COUNT (INVH_SYS_ID) TOTINV,SUM (F_GET_INVH_TED_FJT(INVH_SYS_ID)-F_GET_CSRH_TED_FJT(INVH_SYS_ID))INVVAL   "
						+ " FROM OT_INVOICE_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B   WHERE  INVH_SM_CODE = B.SM_CODE  AND A.SM_CODE = B.SM_CODE  "
						+ "  AND INVH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  "
						+ " AND INVH_APPR_UID IS NOT NULL   AND INVH_CUST_CODE NOT LIKE 'RP%'    "
						+ " AND INVH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ " AND TO_NUMBER (TO_CHAR (INVH_DT, 'RRRR')) = ?  AND (INVH_DT BETWEEN TO_DATE (  "
						+ " TO_CHAR ('0101')  || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM')  || ?,  "
						+ " 'DDMMRRRR')  )     GROUP BY B.FJTDIVNCODE, TO_CHAR (INVH_DT, 'MON'),TO_CHAR (INVH_DT, 'MM'))  "
						+ "GROUP BY DIVN,MON,MM ORDER BY DIVN, MM";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				// myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(5, division);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, year_temp);
				myStmt.setString(8, year_temp);
			} else {
				sql = " SELECT DIVN,MON,MM,  NVL(SUM (TOTSO),0) SO,NVL(TRUNC((SUM(SOVAL)/1000000),2),0) SOVAL,  "
						+ " NVL(SUM (TOTINV),0) INV,NVL(TRUNC((SUM(INVVAL)/1000000),2),0)INVVAL  "
						+ " FROM (   SELECT B.FJTDIVNCODE DIVN, TO_CHAR (SOH_DT, 'MON') MON,TO_CHAR (SOH_DT, 'MM') MM,  "
						+ " COUNT (SOH_SYS_ID) TOTSO,SUM (BV_GET_SO_LC_AMT(SOH_SYS_ID))SOVAL,NULL TOTINV,  "
						+ " NULL INVVAL  FROM OT_SO_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B    WHERE  SOH_SM_CODE = B.SM_CODE  "
						+ " AND A.SM_CODE = B.SM_CODE  AND B.DMEMPCODE = ?  AND SOH_TXN_CODE = B.FJTTXNCODE  "
						+ " AND B.FJTDIVNCODE = ?  AND SOH_CUST_CODE NOT LIKE 'RP%'    "
						+ " AND SOH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ " AND TO_NUMBER (TO_CHAR (SOH_DT, 'RRRR')) = ?  AND (SOH_DT BETWEEN TO_DATE (  "
						+ " TO_CHAR ('0101')  || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM')  "
						+ " || ?,  'DDMMRRRR')  )    GROUP BY B.FJTDIVNCODE, TO_CHAR (SOH_DT, 'MON'),TO_CHAR (SOH_DT, 'MM')   "
						+ " UNION ALL    "
						+ " SELECT B.FJTDIVNCODE DIVN, TO_CHAR (INVH_DT, 'MON') MON,TO_CHAR (INVH_DT, 'MM') MM,  "
						+ " NULL TOTSO,NULL SOVAL,COUNT (INVH_SYS_ID) TOTINV,SUM (F_GET_INVH_TED_FJT(INVH_SYS_ID)-F_GET_CSRH_TED_FJT(INVH_SYS_ID))INVVAL   "
						+ " FROM OT_INVOICE_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B   WHERE  INVH_SM_CODE = B.SM_CODE  AND A.SM_CODE = B.SM_CODE  "
						+ " AND B.DMEMPCODE = ?  AND INVH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ?  "
						+ " AND INVH_APPR_UID IS NOT NULL   AND INVH_CUST_CODE NOT LIKE 'RP%'    "
						+ " AND INVH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ " AND TO_NUMBER (TO_CHAR (INVH_DT, 'RRRR')) = ?  AND (INVH_DT BETWEEN TO_DATE (  "
						+ " TO_CHAR ('0101')  || ?,  'DDMMRRRR')   AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMM')  || ?,  "
						+ " 'DDMMRRRR')  )     GROUP BY B.FJTDIVNCODE, TO_CHAR (INVH_DT, 'MON'),TO_CHAR (INVH_DT, 'MM'))  "
						+ "GROUP BY DIVN,MON,MM ORDER BY DIVN, MM";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, year_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, dm_Emp_Code);
				myStmt.setString(7, division);
				myStmt.setString(8, year_temp);
				myStmt.setString(9, year_temp);
				myStmt.setString(10, year_temp);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String div = myRes.getString(1);
				String month = myRes.getString(2);
				String tot_enq_rcvd_temp = myRes.getString(4);
				String tot_qtd_temp = myRes.getString(5);
				String noQtd_temp = myRes.getString(6);
				String avg_days_temp = myRes.getString(7);

				SipDivOrderToInvcLayer2Details tempqtnToLoiAnalysisSummary = new SipDivOrderToInvcLayer2Details(div,
						month, tot_enq_rcvd_temp, tot_qtd_temp, noQtd_temp, avg_days_temp);
				qtnToLoiAnalysisSummary.add(tempqtnToLoiAnalysisSummary);
			}
			return qtnToLoiAnalysisSummary;
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

	public List<SipDivisionOutstandingRecivablesDtls> getOutstandingRecievableAgingDetailsforSubDivn(String divnCode,
			String dm_Emp_Code, String aging) throws SQLException {
		// This db function for retrieving out recvbles aging wise details by sub
		// division code
		List<SipDivisionOutstandingRecivablesDtls> outstRcvbleDetails = new ArrayList<>();// Outstanding recvble aging
																							// repport list
		String sql = "";
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			switch (aging) {
			case "30":
				if (dm_Emp_Code.equals("E004853")) {
					sql = " SELECT INVNO,INV_DT,CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME,SUM (BAL_AMT_0_30) BAL_AMT_0_30  "
							+ "FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,  "
							+ "SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "AND FJTDIVNCODE = ?    "
							+ "GROUP BY INVNO, INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "HAVING SUM (BAL_AMT_0_30) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = " SELECT INVNO,INV_DT,CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME,SUM (BAL_AMT_0_30) BAL_AMT_0_30  "
							+ "FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,  "
							+ "SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
							+ "GROUP BY INVNO, INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "HAVING SUM (BAL_AMT_0_30) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			case "3060":
				if (dm_Emp_Code.equals("E004853")) {
					sql = "  SELECT INVNO,  INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME,  SUM (BAL_AMT_30_60) BAL_AMT_30_60  "
							+ " FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ " AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ " FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ " AND FJTDIVNCODE = ? "
							+ " GROUP BY INVNO,  INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_30_60) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = "  SELECT INVNO,  INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME,  SUM (BAL_AMT_30_60) BAL_AMT_30_60  "
							+ " FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ " AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ " FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ " AND FJTDIVNCODE = ? AND DMEMPCODE = ?  "
							+ " GROUP BY INVNO,  INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_30_60) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			case "6090":
				if (dm_Emp_Code.equals("E004853")) {
					sql = "  SELECT INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME, SUM (BAL_AMT_60_90) BAL_AMT_60_90"
							+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "  AND FJTDIVNCODE = ?    "
							+ "  GROUP BY INVNO, INV_DT, CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "  HAVING SUM (BAL_AMT_60_90) > 0  " + "";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = "  SELECT INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT, SM_NAME, SUM (BAL_AMT_60_90) BAL_AMT_60_90"
							+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "  AND FJTDIVNCODE = ?  AND DMEMPCODE   = ?  "
							+ "  GROUP BY INVNO, INV_DT, CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "  HAVING SUM (BAL_AMT_60_90) > 0  " + "";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			case "90120":
				if (dm_Emp_Code.equals("E004853")) {
					sql = "  SELECT INVNO, INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,  SM_NAME,  SUM (BAL_AMT_90_120) BAL_AMT_90_120  "
							+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,  "
							+ "  (INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))   "
							+ "  AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
							+ "  GROUP BY INVNO, INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "  HAVING SUM (BAL_AMT_90_120) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = "  SELECT INVNO, INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,  SM_NAME,  SUM (BAL_AMT_90_120) BAL_AMT_90_120  "
							+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "  AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,  "
							+ "  (INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))   "
							+ "  AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
							+ "  GROUP BY INVNO, INV_DT, CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "  HAVING SUM (BAL_AMT_90_120) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			case "120180":
				if (dm_Emp_Code.equals("E004853")) {
					sql = " SELECT INVNO,  INV_DT,   CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,  SM_NAME,  SUM (BAL_AMT_120_180) BAL_AMT_120_180  "
							+ "   FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "   AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "   AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ "   FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "   AND FJTDIVNCODE = ?   "
							+ "   GROUP BY INVNO,  INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_120_180) > 0  ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = " SELECT INVNO,  INV_DT,   CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,  SM_NAME,  SUM (BAL_AMT_120_180) BAL_AMT_120_180  "
							+ "   FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL  WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "   AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "   AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ "   FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "   AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
							+ "   GROUP BY INVNO,  INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_120_180) > 0  ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			case "181":
				if (dm_Emp_Code.equals("E004853")) {
					sql = " SELECT INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,   SM_NAME, SUM (BAL_AMT_181) BAL_AMT_181  "
							+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE    "
							+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "  AND FJTDIVNCODE = ?    "
							+ "  GROUP BY INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_181) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = " SELECT INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,   SM_NAME, SUM (BAL_AMT_181) BAL_AMT_181  "
							+ "  FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE    "
							+ "  AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,  "
							+ "  FJT_SM_RCVBLE_DET.INVNO,SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "  AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
							+ "  GROUP BY INVNO, INV_DT,  CUST_CODE,  CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  HAVING SUM (BAL_AMT_181) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			default:
				if (dm_Emp_Code.equals("E004853")) {
					sql = " SELECT INVNO,INV_DT,CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME,SUM (BAL_AMT_0_30) BAL_AMT_0_30  "
							+ "FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,  "
							+ "SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "AND FJTDIVNCODE = ?   "
							+ "GROUP BY INVNO, INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "HAVING SUM (BAL_AMT_0_30) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
				} else {
					sql = " SELECT INVNO,INV_DT,CUST_CODE,CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME,SUM (BAL_AMT_0_30) BAL_AMT_0_30  "
							+ "FROM FJT_SM_RCVBLE_DET,OM_SALESMAN,FJT_DMSM_TBL WHERE FJT_SM_RCVBLE_DET.SM_CODE = FJT_DMSM_TBL.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.SM_CODE = OM_SALESMAN.SM_CODE  "
							+ "AND  FJT_DMSM_TBL.FJTTXNCODE = DECODE(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1),0,FJT_SM_RCVBLE_DET.INVNO,  "
							+ "SUBSTR(FJT_SM_RCVBLE_DET.INVNO,1,(INSTR(FJT_SM_RCVBLE_DET.INVNO,'-',1,1)-1)))  "
							+ "AND FJTDIVNCODE = ?  AND DMEMPCODE = ?  "
							+ "GROUP BY INVNO, INV_DT,  CUST_CODE, CUST_NAME,PROJ_NAME,CONSULTANT,SM_NAME  "
							+ "HAVING SUM (BAL_AMT_0_30) > 0 ";
					myStmt = myCon.prepareStatement(sql);
					myStmt.setString(1, divnCode);// sub divn code
					myStmt.setString(2, dm_Emp_Code);// dm emp code
				}
				break;
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String invoiceNo_temp = myRes.getString(1);
				String invoiceDate_temp = myRes.getString(2);
				String customerCode_temp = myRes.getString(3);
				String customerName_temp = myRes.getString(4);
				String prjctName_temp = myRes.getString(5);
				String consultant_temp = myRes.getString(6);
				String salesEg_name_temp = myRes.getString(7);
				String aging_value_temp = myRes.getString(8);
				SipDivisionOutstandingRecivablesDtls tempOutRecvbleDtls = new SipDivisionOutstandingRecivablesDtls(
						invoiceNo_temp, invoiceDate_temp, customerCode_temp, customerName_temp, prjctName_temp,
						consultant_temp, salesEg_name_temp, aging_value_temp);
				outstRcvbleDetails.add(tempOutRecvbleDtls);
			}
			return outstRcvbleDetails;
		} finally {
			// close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public List<SipLayer2SubDivisionLevelBillingDetailsYTD> getSubDivisionBillingDetailsForYTD(String theDmCode,
			String theDivision, String theYear) throws SQLException {
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
						+ " AND  DOC_DATE BETWEEN TO_DATE('01'||'01'|| ? ,'DD/MM/RRRR') AND  "
						+ " TO_DATE(to_char( sysdate, 'dd' )||to_char( sysdate, 'mm' )|| ? ,'DD/MM/RRRR') ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDivision);
				myStmt.setString(2, theYear);
				myStmt.setString(3, theYear);
			} else {
				sql = " SELECT * FROM SIP_DM_BLNG_TBL  " + " WHERE DIVN_CODE = ?   " + " AND DM_CODE = ?    "
						+ " AND  DOC_DATE BETWEEN TO_DATE('01'||'01'|| ? ,'DD/MM/RRRR') AND  "
						+ " TO_DATE(to_char( sysdate, 'dd' )||to_char( sysdate, 'mm' )|| ? ,'DD/MM/RRRR') ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDivision);
				myStmt.setString(2, theDmCode);
				myStmt.setString(3, theYear);
				myStmt.setString(4, theYear);
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

	public List<SipLayer2SubDivisionLevelBookingDetailsYTD> getSubDivisionBookingDetailsForYTD(String theDmCode,
			String theDivision, String theYear) throws SQLException {
		List<SipLayer2SubDivisionLevelBookingDetailsYTD> detailsList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (theDmCode.equals("E004853")) {
				sql = " SELECT * FROM SIP_DM_BKNG_TBL  " + " WHERE DIVN_CODE = ?   "
						+ " AND  LOI_RCVD_DT BETWEEN TO_DATE('01'||'01'|| ? ,'DD/MM/RRRR') AND  "
						+ " TO_DATE(to_char( sysdate, 'dd' )||to_char( sysdate, 'mm' )|| ? ,'DD/MM/RRRR') ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDivision);
				myStmt.setString(2, theYear);
				myStmt.setString(3, theYear);
			} else {
				sql = " SELECT * FROM SIP_DM_BKNG_TBL  " + " WHERE DIVN_CODE = ?   " + " AND DM_CODE = ?    "
						+ " AND  LOI_RCVD_DT BETWEEN TO_DATE('01'||'01'|| ? ,'DD/MM/RRRR') AND  "
						+ " TO_DATE(to_char( sysdate, 'dd' )||to_char( sysdate, 'mm' )|| ? ,'DD/MM/RRRR') ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, theDivision);
				myStmt.setString(2, theDmCode);
				myStmt.setString(3, theYear);
				myStmt.setString(4, theYear);
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
				String zone = myRes.getString(17);
				// String zone = myRes.getString(17);
				String currency = myRes.getString(19);
				String amount = myRes.getString(20);

				SipLayer2SubDivisionLevelBookingDetailsYTD tempdetailsList = new SipLayer2SubDivisionLevelBookingDetailsYTD(
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
