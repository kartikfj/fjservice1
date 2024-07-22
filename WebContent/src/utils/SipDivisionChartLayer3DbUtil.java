package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipDivEnquirtToQtnLayer3Details;
import beans.SipDivLoiToSoLayer3Details;
import beans.SipDivQtnToLoiLayer3Details;
import beans.SipDivSoToInvoiceLayer3Details;
import beans.SipOutsRecvbleCustWise_Layer3Details;

public class SipDivisionChartLayer3DbUtil {

	// enquirty to qtn month wise third layer data Year and division wise details
	public List<SipDivEnquirtToQtnLayer3Details> getEnquiryToQuotationMonthDetails(String dm_Emp_Code, String division,
			String year_temp, String month_temp) throws SQLException {
		List<SipDivEnquirtToQtnLayer3Details> enqToQtnAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = "SELECT   CQH_TXN_CODE QUOT_CODE,  CQH_NO QUOT_NO,CQH_DT QUOT_DT,TO_CHAR(CQH_CR_DT,'DD/MM/RRRR') QUOT_FIRST_DT,  "
						+ " (SELECT CEH_TXN_CODE||'-'||CEH_NO||'-'||CEH_DT FROM OT_CUST_ENQUIRY_HEAD   "
						+ "  WHERE CEH_SYS_ID = CQH_QH_SYS_ID ) ENQDETAIL,  BV_QTN_ZONE (CQH_COMP_CODE, CQH_TXN_CODE, CQH_NO) ZONE,   "
						+ "  CQH_SM_CODE SALESMAN,  A.SM_NAME,  CQH_FLEX_04 PROD_CATG,  CQH_FLEX_05 PROD_SUB_CATG,   "
						+ "  F_GET_PROJ_NAME_MA (CQH_FLEX_01) PROJECT_NAME,  F_GET_CONSULTANT_MA (CQH_FLEX_01) CONSULTANT,   "
						+ "  F_GET_CUST_NAME_MA (CQH_CUST_CODE) CUSTOMER,  DECODE (CQH_FLEX_20,  NULL, BV_GET_QT_AMT_AED (CQH_SYS_ID),   "
						+ "  CQH_FLEX_20)  AMOUNT   FROM FJT_DMSM_TBL B, OT_CUST_QUOT_HEAD,OM_SALESMAN A  WHERE  CQH_SM_CODE = B.SM_CODE  "
						+ "  AND A.SM_CODE = B.SM_CODE  AND CQH_TXN_CODE = B.FJTTXNCODE   "
						+ "  AND B.FJTDIVNCODE = ? AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?    AND TO_CHAR (CQH_DT, 'MON') = ?  "
						+ " AND (CQH_DT BETWEEN TO_DATE (   TO_CHAR ('01')|| ?  || ?  ,  'DDMONRRRR')   AND TO_DATE (  "
						+ "  TO_CHAR (SYSDATE, 'DDMON')  ||?  ,  'DDMONRRRR')    )     order by 4,5  ";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, month_temp);
				myStmt.setString(4, month_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, year_temp);
			} else {
				sql = "SELECT   CQH_TXN_CODE QUOT_CODE,  CQH_NO QUOT_NO,CQH_DT QUOT_DT,TO_CHAR(CQH_CR_DT,'DD/MM/RRRR') QUOT_FIRST_DT,  "
						+ " (SELECT CEH_TXN_CODE||'-'||CEH_NO||'-'||CEH_DT FROM OT_CUST_ENQUIRY_HEAD   "
						+ "  WHERE CEH_SYS_ID = CQH_QH_SYS_ID ) ENQDETAIL,  BV_QTN_ZONE (CQH_COMP_CODE, CQH_TXN_CODE, CQH_NO) ZONE,   "
						+ "  CQH_SM_CODE SALESMAN,  A.SM_NAME,  CQH_FLEX_04 PROD_CATG,  CQH_FLEX_05 PROD_SUB_CATG,   "
						+ "  F_GET_PROJ_NAME_MA (CQH_FLEX_01) PROJECT_NAME,  F_GET_CONSULTANT_MA (CQH_FLEX_01) CONSULTANT,   "
						+ "  F_GET_CUST_NAME_MA (CQH_CUST_CODE) CUSTOMER,  DECODE (CQH_FLEX_20,  NULL, BV_GET_QT_AMT_AED (CQH_SYS_ID),   "
						+ "  CQH_FLEX_20)  AMOUNT   FROM FJT_DMSM_TBL B, OT_CUST_QUOT_HEAD,OM_SALESMAN A  WHERE  CQH_SM_CODE = B.SM_CODE  "
						+ "  AND A.SM_CODE = B.SM_CODE   AND B.DMEMPCODE = ?  AND CQH_TXN_CODE = B.FJTTXNCODE   "
						+ "  AND B.FJTDIVNCODE = ? AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?    AND TO_CHAR (CQH_DT, 'MON') = ?  "
						+ " AND (CQH_DT BETWEEN TO_DATE (   TO_CHAR ('01')|| ?  || ?  ,  'DDMONRRRR')   AND TO_DATE (  "
						+ "  TO_CHAR (SYSDATE, 'DDMON')  ||?  ,  'DDMONRRRR')    )     order by 4,5  ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, month_temp);
				myStmt.setString(5, month_temp);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, year_temp);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String qtn_code_temp = myRes.getString(1);
				String quot_no_temp = myRes.getString(2);
				String qtn_dt_temp = myRes.getString(3);
				String qtn_fist_dt_temp = myRes.getString(4);// newly created on 08/09/2019, quotation first date
				String enq_dt__temp = myRes.getString(5);// enquiry details
				String zone_temp = myRes.getString(6);
				String salesman_temp = myRes.getString(7);
				String sm_name_temp = myRes.getString(8);
				String prod_cat_temp = myRes.getString(9);
				String prod_sub_cat_temp = myRes.getString(10);
				String project_name_temp = myRes.getString(11);
				String consultant_temp = myRes.getString(12);
				String customer_temp = myRes.getString(13);
				String amount_temp = myRes.getString(14);
				SipDivEnquirtToQtnLayer3Details tempenqToQtnAnalysisSummary = new SipDivEnquirtToQtnLayer3Details(
						qtn_code_temp, quot_no_temp, qtn_dt_temp, qtn_fist_dt_temp, enq_dt__temp, zone_temp,
						salesman_temp, sm_name_temp, prod_cat_temp, prod_sub_cat_temp, project_name_temp,
						consultant_temp, customer_temp, amount_temp);
				enqToQtnAnalysisSummary.add(tempenqToQtnAnalysisSummary);
			}
			return enqToQtnAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// JIH Qtn to LOI month wise third layer data Year and division wise details
	public List<SipDivQtnToLoiLayer3Details> getQuotationTOLoiMonthDetails(String dm_Emp_Code, String division,
			String year_temp, String month_temp) throws SQLException {
		List<SipDivQtnToLoiLayer3Details> qtnToLoiAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {// Modified to give access to Mr.Nagib
				sql = "SELECT CQH_DT QUOT_DT,  CQH_TXN_CODE QUOT_CODE,  CQH_NO QUOT_NO,  "
						+ " BV_QTN_ZONE (CQH_COMP_CODE, CQH_TXN_CODE, CQH_NO) ZONE,  "
						+ " CQH_SM_CODE SALESMAN,  A.SM_NAME,  CQH_FLEX_04 PROD_CATG,  "
						+ " CQH_FLEX_05 PROD_SUB_CATG,  F_GET_PROJ_NAME_MA (CQH_FLEX_01) PROJECT_NAME,  "
						+ " F_GET_CONSULTANT_MA (CQH_FLEX_01) CONSULTANT,  F_GET_CUST_NAME_MA (CQH_CUST_CODE) CUSTOMER,  "
						+ " DECODE(CQH_FLEX_20,NULL,BV_GET_LC_AMT(CQH_COMP_CODE,QUOT_AMT*CQH_EXGE_RATE) ,CQH_FLEX_20) AMOUNT,  "
						+ " TO_DATE (CQH_FLEX_12, 'DD/MM/RRRR') LOI_RCD_DT,  NVL (TO_DATE (CQH_FLEX_11, 'DD/MM/RRRR'),  "
						+ "  TO_DATE (CQH_FLEX_07, 'DD/MM/RRRR'))     EXP_PO_DT,  TO_DATE (CQH_FLEX_07, 'DD/MM/RRRR') INVOICING_YEAR  "
						+ "    FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B,( SELECT CQI_CQH_SYS_ID, SUM(DECODE(NVL(CQI_FC_VAL_AFT_H_DISC,0),0 ,NVL( CQI_FC_VAL,0)   "
						+ ",CQI_FC_VAL_AFT_H_DISC ) ) QUOT_AMT  FROM OT_CUST_QUOT_ITEM  WHERE CQI_CQH_SYS_ID IS NOT NULL  GROUP BY  CQI_CQH_SYS_ID   "
						+ ") QUOT    WHERE     CQH_SM_CODE = B.SM_CODE  AND CQI_CQH_SYS_ID(+) = OT_CUST_QUOT_HEAD.CQH_SYS_ID  AND A.SM_CODE = B.SM_CODE  "
						+ " AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ? AND CQH_FLEX_12 IS NOT NULL  "
						+ " AND NVL (CQH_FLEX_17, 'L') <> 'L'  AND CQH_CUST_CODE NOT LIKE 'RP%'  AND CQH_CUST_CODE NOT IN (SELECT RP_CODE  "
						+ " FROM FJT_RELPARTY_LIST     WHERE RP_EXCLUDE_YN_NUM = 1)    AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?  "
						+ " AND TO_CHAR (TO_CHAR (CQH_DT, 'MON')) = ?  AND (CQH_DT BETWEEN TO_DATE (TO_CHAR ('01') || ? || ?,   'DDMONRRRR')  "
						+ " AND TO_DATE (TO_CHAR (SYSDATE, 'DDMON') || ?,   'DDMONRRRR')) ORDER BY 9,12";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, month_temp);
				myStmt.setString(4, month_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, year_temp);
			} else {
				sql = "SELECT CQH_DT QUOT_DT,  CQH_TXN_CODE QUOT_CODE,  CQH_NO QUOT_NO,  "
						+ " BV_QTN_ZONE (CQH_COMP_CODE, CQH_TXN_CODE, CQH_NO) ZONE,  "
						+ " CQH_SM_CODE SALESMAN,  A.SM_NAME,  CQH_FLEX_04 PROD_CATG,  "
						+ " CQH_FLEX_05 PROD_SUB_CATG,  F_GET_PROJ_NAME_MA (CQH_FLEX_01) PROJECT_NAME,  "
						+ " F_GET_CONSULTANT_MA (CQH_FLEX_01) CONSULTANT,  F_GET_CUST_NAME_MA (CQH_CUST_CODE) CUSTOMER,  "
						+ " DECODE(CQH_FLEX_20,NULL,BV_GET_LC_AMT(CQH_COMP_CODE,QUOT_AMT*CQH_EXGE_RATE) ,CQH_FLEX_20) AMOUNT,  "
						+ " TO_DATE (CQH_FLEX_12, 'DD/MM/RRRR') LOI_RCD_DT,  NVL (TO_DATE (CQH_FLEX_11, 'DD/MM/RRRR'),  "
						+ "  TO_DATE (CQH_FLEX_07, 'DD/MM/RRRR'))     EXP_PO_DT,  TO_DATE (CQH_FLEX_07, 'DD/MM/RRRR') INVOICING_YEAR  "
						+ "    FROM OT_CUST_QUOT_HEAD, OM_SALESMAN A,FJT_DMSM_TBL B,( SELECT CQI_CQH_SYS_ID, SUM(DECODE(NVL(CQI_FC_VAL_AFT_H_DISC,0),0 ,NVL( CQI_FC_VAL,0)   "
						+ ",CQI_FC_VAL_AFT_H_DISC ) ) QUOT_AMT  FROM OT_CUST_QUOT_ITEM  WHERE CQI_CQH_SYS_ID IS NOT NULL  GROUP BY  CQI_CQH_SYS_ID   "
						+ ") QUOT    WHERE     CQH_SM_CODE = B.SM_CODE  AND CQI_CQH_SYS_ID(+) = OT_CUST_QUOT_HEAD.CQH_SYS_ID  AND A.SM_CODE = B.SM_CODE  "
						+ " AND B.DMEMPCODE = ? AND CQH_TXN_CODE = B.FJTTXNCODE  AND B.FJTDIVNCODE = ? AND CQH_FLEX_12 IS NOT NULL  "
						+ " AND NVL (CQH_FLEX_17, 'L') <> 'L'  AND CQH_CUST_CODE NOT LIKE 'RP%'  AND CQH_CUST_CODE NOT IN (SELECT RP_CODE  "
						+ " FROM FJT_RELPARTY_LIST     WHERE RP_EXCLUDE_YN_NUM = 1)    AND TO_NUMBER (TO_CHAR (CQH_DT, 'RRRR')) = ?  "
						+ " AND TO_CHAR (TO_CHAR (CQH_DT, 'MON')) = ?  AND (CQH_DT BETWEEN TO_DATE (TO_CHAR ('01') || ? || ?,   'DDMONRRRR')  "
						+ " AND TO_DATE (TO_CHAR (SYSDATE, 'DDMON') || ?,   'DDMONRRRR')) ORDER BY 9,12";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, month_temp);
				myStmt.setString(5, month_temp);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, year_temp);
			}

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String qtn_date_temp = myRes.getString(1);
				String quot_code_temp = myRes.getString(2);
				String qtn_no_temp = myRes.getString(3);
				String zone_temp = myRes.getString(4);
				String se_code_temp = myRes.getString(5);
				String se_name_temp = myRes.getString(6);
				String prod_cat_temp = myRes.getString(7);
				String prod_sub_cat_temp = myRes.getString(8);
				String project_name_temp = myRes.getString(9);
				String consultant_temp = myRes.getString(10);
				String customer_temp = myRes.getString(11);
				String amount_temp = myRes.getString(12);
				// String avg_gross_profit_temp=myRes.getString(13);
				String loi_recieved_dt_temp = myRes.getString(13);
				String expct_po_date_temp = myRes.getString(14);
				String invc_yr_temp = myRes.getString(15);
				SipDivQtnToLoiLayer3Details tempqtnToLoiAnalysisSummary = new SipDivQtnToLoiLayer3Details(qtn_date_temp,
						quot_code_temp, qtn_no_temp, zone_temp, se_code_temp, se_name_temp, prod_cat_temp,
						prod_sub_cat_temp, project_name_temp, consultant_temp, customer_temp, amount_temp,
						loi_recieved_dt_temp, expct_po_date_temp, invc_yr_temp);
				qtnToLoiAnalysisSummary.add(tempqtnToLoiAnalysisSummary);
			}
			return qtnToLoiAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// LOI to ORDER month wise third layer data Year and division wise details
	public List<SipDivLoiToSoLayer3Details> getLoiToOrderMonthDetails(String dm_Emp_Code, String division,
			String year_temp, String month_temp) throws SQLException {
		List<SipDivLoiToSoLayer3Details> loiToSoAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {// Modified to give access to Mr.Nagib
				sql = " SELECT SOH_COMP_CODE COMP_CODE,  SOH_TXN_CODE,  SOH_NO,  SOH_DT,  SOH_SM_CODE SALESMAN,  "
						+ " A.SM_NAME,  SOH_CUST_CODE  || '-'  || (SELECT CUST_NAME  FROM OM_CUSTOMER  "
						+ " WHERE CUST_CODE = SOH_CUST_CODE)  CUSTOMER,  B.FJTDIVNCODE DIVN,  (BV_GET_SO_LC_AMT (SOH_SYS_ID)) SOVAL  "
						+ " FROM OM_SALESMAN A,  OT_SO_HEAD,FJT_DMSM_TBL B  WHERE SOH_SM_CODE = B.SM_CODE  AND A.SM_CODE = B.SM_CODE  "
						+ " AND SOH_CUST_CODE NOT LIKE 'RP%'  AND SOH_CUST_CODE NOT IN (SELECT RP_CODE  FROM FJT_RELPARTY_LIST  "
						+ " WHERE RP_EXCLUDE_YN_NUM = 1)   AND SOH_TXN_CODE = B.FJTTXNCODE  "
						+ " AND B.FJTDIVNCODE = ?  AND TO_NUMBER (TO_CHAR (SOH_DT, 'RRRR')) = ?  "
						+ " AND (SOH_DT BETWEEN TO_DATE (  TO_CHAR ('01')|| ?  || ?,  'DDMONRRRR')  "
						+ " AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMON')  || ?,  'DDMONRRRR') )   "
						+ " AND TO_CHAR (SOH_DT, 'MON') = ? ";

				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, month_temp);
				myStmt.setString(4, year_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, month_temp);
			} else {
				sql = " SELECT SOH_COMP_CODE COMP_CODE,  SOH_TXN_CODE,  SOH_NO,  SOH_DT,  SOH_SM_CODE SALESMAN,  "
						+ " A.SM_NAME,  SOH_CUST_CODE  || '-'  || (SELECT CUST_NAME  FROM OM_CUSTOMER  "
						+ " WHERE CUST_CODE = SOH_CUST_CODE)  CUSTOMER,  B.FJTDIVNCODE DIVN,  (BV_GET_SO_LC_AMT (SOH_SYS_ID)) SOVAL  "
						+ " FROM OM_SALESMAN A,  OT_SO_HEAD,FJT_DMSM_TBL B  WHERE SOH_SM_CODE = B.SM_CODE  AND A.SM_CODE = B.SM_CODE  "
						+ " AND SOH_CUST_CODE NOT LIKE 'RP%'  AND SOH_CUST_CODE NOT IN (SELECT RP_CODE  FROM FJT_RELPARTY_LIST  "
						+ " WHERE RP_EXCLUDE_YN_NUM = 1)  AND B.DMEMPCODE = ?  AND SOH_TXN_CODE = B.FJTTXNCODE  "
						+ " AND B.FJTDIVNCODE = ?  AND TO_NUMBER (TO_CHAR (SOH_DT, 'RRRR')) = ?  "
						+ " AND (SOH_DT BETWEEN TO_DATE (  TO_CHAR ('01')|| ?  || ?,  'DDMONRRRR')  "
						+ " AND TO_DATE (  TO_CHAR (SYSDATE, 'DDMON')  || ?,  'DDMONRRRR') )   "
						+ " AND TO_CHAR (SOH_DT, 'MON') = ? ";

				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, month_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, month_temp);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String comp_code_temp = myRes.getString(1);
				String so_txn_temp = myRes.getString(2);
				String so_no_temp = myRes.getString(3);
				String so_date_temp = myRes.getString(4);
				String se_code_temp = myRes.getString(5);
				String se_name_temp = myRes.getString(6);
				String customer_temp = myRes.getString(7);
				String division_temp = myRes.getString(8);
				String so_value_temp = myRes.getString(9);
				SipDivLoiToSoLayer3Details tempLoiToSoAnalysisSummary = new SipDivLoiToSoLayer3Details(comp_code_temp,
						so_txn_temp, so_no_temp, so_date_temp, se_code_temp, se_name_temp, customer_temp, division_temp,
						so_value_temp);
				loiToSoAnalysisSummary.add(tempLoiToSoAnalysisSummary);
			}
			return loiToSoAnalysisSummary;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// ORDER to Invoicing month wise third layer data Year and division wise details
	public List<SipDivSoToInvoiceLayer3Details> getOrderTOInvoiceMonthDetails(String dm_Emp_Code, String division,
			String year_temp, String month_temp) throws SQLException {
		List<SipDivSoToInvoiceLayer3Details> soToInvcAnalysisSummary = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			if (dm_Emp_Code.equals("E004853")) {
				sql = " SELECT INVH_COMP_CODE COMP_CODE, INVH_TXN_CODE||'-'||INVH_NO INVOICE,  "
						+ "INVH_DT, INVH_SM_CODE SM_CODE,  "
						+ "SM_NAME SALESMAN,INVH_CUST_CODE CUST_CODE, (SELECT CUST_NAME FROM OM_CUSTOMER  "
						+ "WHERE CUST_CODE = INVH_CUST_CODE) CUST_NAME,  "
						+ "(F_GET_INVH_TED_FJT (INVH_SYS_ID)) INVVAL,(F_GET_CSRH_TED_FJT(INVH_SYS_ID)) RETVAL  "
						+ "FROM OT_INVOICE_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B  WHERE  INVH_SM_CODE = B.SM_CODE  "
						+ "AND A.SM_CODE = B.SM_CODE AND  INVH_TXN_CODE = B.FJTTXNCODE  "
						+ "AND B.FJTDIVNCODE = ? AND INVH_APPR_UID IS NOT NULL  "
						+ "AND INVH_CUST_CODE NOT LIKE 'RP%'    "
						+ "AND INVH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ "AND TO_NUMBER (TO_CHAR (INVH_DT, 'RRRR')) = ? AND (INVH_DT BETWEEN TO_DATE (  "
						+ "TO_CHAR ('01')|| ? || ?, 'DDMONRRRR')  AND TO_DATE ( TO_CHAR (SYSDATE, 'DDMON')  "
						+ "|| ?, 'DDMONRRRR') )  AND TO_CHAR (INVH_DT, 'MON') = ? ";
				myStmt = myCon.prepareStatement(sql);
				// myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(1, division);
				myStmt.setString(2, year_temp);
				myStmt.setString(3, month_temp);
				myStmt.setString(4, year_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, month_temp);
			} else {
				sql = " SELECT INVH_COMP_CODE COMP_CODE, INVH_TXN_CODE||'-'||INVH_NO INVOICE,  "
						+ "INVH_DT, INVH_SM_CODE SM_CODE,  "
						+ "SM_NAME SALESMAN,INVH_CUST_CODE CUST_CODE, (SELECT CUST_NAME FROM OM_CUSTOMER  "
						+ "WHERE CUST_CODE = INVH_CUST_CODE) CUST_NAME,  "
						+ "(F_GET_INVH_TED_FJT (INVH_SYS_ID)) INVVAL,(F_GET_CSRH_TED_FJT(INVH_SYS_ID)) RETVAL  "
						+ "FROM OT_INVOICE_HEAD, OM_SALESMAN A, FJT_DMSM_TBL B  WHERE  INVH_SM_CODE = B.SM_CODE  "
						+ "AND A.SM_CODE = B.SM_CODE AND B.DMEMPCODE = ? AND INVH_TXN_CODE = B.FJTTXNCODE  "
						+ "AND B.FJTDIVNCODE = ? AND INVH_APPR_UID IS NOT NULL  "
						+ "AND INVH_CUST_CODE NOT LIKE 'RP%'    "
						+ "AND INVH_CUST_CODE NOT IN (SELECT RP_CODE FROM FJT_RELPARTY_LIST WHERE RP_EXCLUDE_YN_NUM = 1)  "
						+ "AND TO_NUMBER (TO_CHAR (INVH_DT, 'RRRR')) = ? AND (INVH_DT BETWEEN TO_DATE (  "
						+ "TO_CHAR ('01')|| ? || ?, 'DDMONRRRR')  AND TO_DATE ( TO_CHAR (SYSDATE, 'DDMON')  "
						+ "|| ?, 'DDMONRRRR') )  AND TO_CHAR (INVH_DT, 'MON') = ? ";
				myStmt = myCon.prepareStatement(sql);
				myStmt.setString(1, dm_Emp_Code);
				myStmt.setString(2, division);
				myStmt.setString(3, year_temp);
				myStmt.setString(4, month_temp);
				myStmt.setString(5, year_temp);
				myStmt.setString(6, year_temp);
				myStmt.setString(7, month_temp);
			}
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String cmp_code_temp = myRes.getString(1);
				String invoice_temp = myRes.getString(2);
				String invoice_date_temp = myRes.getString(3);
				String se_code_temp = myRes.getString(4);
				String se_name_temp = myRes.getString(5);
				String customer_code_temp = myRes.getString(6);
				String customer_name_temp = myRes.getString(7);
				String invoice_val_temp = myRes.getString(8);
				String return_val_temp = myRes.getString(9);
				SipDivSoToInvoiceLayer3Details tempsoToInvcAnalysisSummary = new SipDivSoToInvoiceLayer3Details(
						cmp_code_temp, invoice_temp, invoice_date_temp, se_code_temp, se_name_temp, customer_code_temp,
						customer_name_temp, invoice_val_temp, return_val_temp);
				soToInvcAnalysisSummary.add(tempsoToInvcAnalysisSummary);
			}
			return soToInvcAnalysisSummary;
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

	public HashMap<String, List<SipOutsRecvbleCustWise_Layer3Details>> getOustRecvblOnAccntDataDetails(
			String customer_Code, String title, String segOrdivn) throws SQLException {
		// Oustanding Recievables - On Account Customer Code Wise Details
		List<SipOutsRecvbleCustWise_Layer3Details> onAccntCustmrDtls = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		Double balance_amont_total = (double) 0;
		Double onaccnt_total = (double) 0;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = "";
			// Modified as we are getting all the division details.
//			String sql = " SELECT ENTITY,CUST_CODE,TO_CHAR(TO_DATE(DOC_DT,'DD/MM/YYYY'), 'DD/MM/YYYY'),DOCNO,DIVN, "
//					+ " NVL(SALES_EGR,'-'),NVL(LPONO,'-'), "
//					+ " NVL(PROJECT,'-'),NVL(PAYMENTTERMS,'-'),NVL(CURR,'-'),NVL(BALAMT,0),NVL(ONAC,0),"
//					+ "TO_DATE(DOC_DT,'DD/MM/YYYY') DATEFRORDER  " + " FROM AKM_CUST_OS_TBL  "
//					+ " WHERE CUST_CODE = ? Order by DATEFRORDER  ASC ";
			if (segOrdivn.equals("SEG")) {
				sql = " SELECT ENTITY,CUST_CODE,TO_CHAR(TO_DATE(DOC_DT,'DD/MM/YYYY'), 'DD/MM/YYYY'),DOCNO,DIVN, "
						+ " NVL(SALES_EGR,'-'),NVL(LPONO,'-'), "
						+ " NVL(PROJECT,'-'),NVL(PAYMENTTERMS,'-'),NVL(CURR,'-'),NVL(BALAMT,0),NVL(ONAC,0),"
						+ "TO_DATE(DOC_DT,'DD/MM/YYYY') DATEFRORDER  " + " FROM AKM_CUST_OS_TBL  "
						+ " WHERE CUST_CODE = ?    AND SALES_EGR IN "
						+ " (SELECT SM_NAME  FROM OM_SALESMAN WHERE SM_CODE = ? )" + " Order by DATEFRORDER  ASC ";
			} else if (segOrdivn.equals("DIVN")) {
				sql = " SELECT ENTITY,CUST_CODE,TO_CHAR(TO_DATE(DOC_DT,'DD/MM/YYYY'), 'DD/MM/YYYY'),DOCNO,DIVN, "
						+ " NVL(SALES_EGR,'-'),NVL(LPONO,'-'), "
						+ " NVL(PROJECT,'-'),NVL(PAYMENTTERMS,'-'),NVL(CURR,'-'),NVL(BALAMT,0),NVL(ONAC,0),"
						+ "TO_DATE(DOC_DT,'DD/MM/YYYY') DATEFRORDER  " + " FROM AKM_CUST_OS_TBL  "
						+ " WHERE CUST_CODE = ?    AND   DIVN IN(select FJTDIVNCODE from  FJT_TXN_FLEX where FJTMAINDIVN = ?)  Order by DATEFRORDER  ASC ";
			} else {
				sql = " SELECT ENTITY,CUST_CODE,TO_CHAR(TO_DATE(DOC_DT,'DD/MM/YYYY'), 'DD/MM/YYYY'),DOCNO,DIVN, "
						+ " NVL(SALES_EGR,'-'),NVL(LPONO,'-'), "
						+ " NVL(PROJECT,'-'),NVL(PAYMENTTERMS,'-'),NVL(CURR,'-'),NVL(BALAMT,0),NVL(ONAC,0),"
						+ "TO_DATE(DOC_DT,'DD/MM/YYYY') DATEFRORDER  " + " FROM AKM_CUST_OS_TBL  "
						+ " WHERE CUST_CODE = ?    AND   DIVN = ?  Order by DATEFRORDER  ASC ";
			}

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, customer_Code);
			myStmt.setString(2, title);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String comp_code_temp = myRes.getString(1);
				String cust_code_temp = myRes.getString(2);
				String doc_date_temp = myRes.getString(3);
				String doc_no_temp = myRes.getString(4);
				String division_temp = myRes.getString(5);
				String sales_egr_temp = myRes.getString(6);
				String lponum_temp = myRes.getString(7);
				String project_temp = myRes.getString(8);
				String payment_term_temp = myRes.getString(9);
				String currency_temp = myRes.getString(10);
				String balance_amt_temp = myRes.getString(11);
				String onac_value_temp = myRes.getString(12);
				SipOutsRecvbleCustWise_Layer3Details temponAccntCustmrDtls = new SipOutsRecvbleCustWise_Layer3Details(
						comp_code_temp, cust_code_temp, doc_date_temp, doc_no_temp, division_temp, sales_egr_temp,
						lponum_temp, project_temp, payment_term_temp, currency_temp, balance_amt_temp, onac_value_temp);
				onAccntCustmrDtls.add(temponAccntCustmrDtls);

				balance_amont_total = balance_amont_total + Double.parseDouble(balance_amt_temp);
				onaccnt_total = onaccnt_total + Double.parseDouble(onac_value_temp);
			}

			// getCalculatedOnAccountNetBalance(balance_amont_total,onaccnt_total);
			HashMap<String, List<SipOutsRecvbleCustWise_Layer3Details>> map = new HashMap<String, List<SipOutsRecvbleCustWise_Layer3Details>>();
			map.put("onAcccntLst", onAccntCustmrDtls);
			map.put("onNetAmtLst", getCalculatedOnAccountNetBalance(balance_amont_total, onaccnt_total));
			return map;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	private List<SipOutsRecvbleCustWise_Layer3Details> getCalculatedOnAccountNetBalance(double net_balnce_amt,
			double net_on_accnt) {
		List<SipOutsRecvbleCustWise_Layer3Details> onAccntCustmrDtls = new ArrayList<>();
		DecimalFormat df = new DecimalFormat("#,###.00");
		String netTotalValStr = "";
		double netTotal = net_balnce_amt + net_on_accnt;

		if (netTotal >= 0) {
			netTotalValStr = df.format(netTotal) + " Dr";
		} else {
			netTotalValStr = df.format(netTotal) + " Cr";
		}

		String netBlncAmt = df.format(net_balnce_amt);
		String netOnAcnt = df.format(net_on_accnt);

		// System.out.println("Total Balance = "+netBlncAmt);
		// System.out.println("Total Balance = "+netOnAcnt);

		SipOutsRecvbleCustWise_Layer3Details temponAccntCustmrDtls = new SipOutsRecvbleCustWise_Layer3Details(
				netBlncAmt, netOnAcnt, netTotalValStr);
		onAccntCustmrDtls.add(temponAccntCustmrDtls);

		return onAccntCustmrDtls;

	}
}
