package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import beans.OrclDBConnectionPool;
import beans.SipLayer4_Pdc_On_Hand;
import beans.SipLayer4_Pdc_Re_Entry;

public class SipDivisionChartLayer4DbUtil {

	// ------PDC's On Hand-------------- Based On Customer Code--------------
	public List<SipLayer4_Pdc_On_Hand> getPpdOnHandCustWiseDetails(String customer_COde) throws SQLException {
		List<SipLayer4_Pdc_On_Hand> pdchandCustDetails = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT PDC_DUE_DT \"PDC Due Dt.\",  " + " PDC_CHQ_NO \"Cheque No\",  "
					+ " PDC_BANK_NAME \"Bank\",  " + " PDC_CURR_CODE \"Currency\",  " + " PDC_FC_AMT \"Amount\",  "
					+ " PDC_LC_AMT \"Amount(AED)\"  " + " FROM FT_PDC, FT_PDC_HEADER  "
					+ " WHERE     PDC_COMP_CODE NOT IN ('ALP', 'IND', 'PALFZ', 'KIQ')  "
					+ " AND PDC_SUB_ACNT_CODE LIKE ?  " + " AND PDC_PDH_SYS_ID = PDH_SYS_ID  "
					+ " AND NVL (PDC_STATUS, 'P') IN ('P', 'O')  " + " AND PDC_TYPE_FLAG = 'R'  "
					+ " AND NVL (PDC_CANCEL_YN, 'N') <> 'Y'  " + " AND PDH_TRAN_CODE NOT LIKE '%REN'  "
					+ " ORDER BY PDC_DUE_DT ASC ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, customer_COde);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String due_date_temp = myRes.getString(1);
				String cheque_no_temp = myRes.getString(2);
				String bank_temp = myRes.getString(3);
				String currency_temp = myRes.getString(4);
				String amount_temp = myRes.getString(5);
				String amount_aed_temp = myRes.getString(6);

				SipLayer4_Pdc_On_Hand temppdchandCustDetails = new SipLayer4_Pdc_On_Hand(due_date_temp, cheque_no_temp,
						bank_temp, currency_temp, amount_temp, amount_aed_temp);
				pdchandCustDetails.add(temppdchandCustDetails);
			}
			return pdchandCustDetails;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// ------PDC's re- Entry -------------- Based On Customer Code--------------
	public List<SipLayer4_Pdc_Re_Entry> getPpdReEntryCustWiseDetails(String customer_COde) throws SQLException {
		List<SipLayer4_Pdc_Re_Entry> pdcrentryCustDetails = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT PDC_DUE_DT \"PDC Due Dt.\",  " + "  PDC_CHQ_NO \"Cheque No\",  "
					+ "  PDC_BANK_NAME \"Bank\",  " + "  PDC_CURR_CODE \"Currency\",  " + "  PDC_FC_AMT \"Amount\",  "
					+ "  PDC_LC_AMT \"Amount(AED)\"  " + "  FROM FT_PDC, FT_PDC_HEADER  "
					+ "  WHERE     PDC_COMP_CODE NOT IN ('ALP', 'IND', 'PALFZ', 'KIQ')  "
					+ "  AND PDC_SUB_ACNT_CODE LIKE ?  " + "  AND PDC_PDH_SYS_ID = PDH_SYS_ID  "
					+ "  AND NVL (PDC_STATUS, 'P') IN ('P', 'O')  " + "  AND PDC_TYPE_FLAG = 'R'  "
					+ "  AND NVL (PDC_CANCEL_YN, 'N') <> 'Y'  " + "  AND PDH_TRAN_CODE LIKE '%REN'  "
					+ "  ORDER BY PDC_DUE_DT ASC ";

			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, customer_COde);

			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String due_date_temp = myRes.getString(1);
				String cheque_no_temp = myRes.getString(2);
				String bank_temp = myRes.getString(3);
				String currency_temp = myRes.getString(4);
				String amount_temp = myRes.getString(5);
				String amount_aed_temp = myRes.getString(6);

				SipLayer4_Pdc_Re_Entry temppdcrentryCustDetails = new SipLayer4_Pdc_Re_Entry(due_date_temp,
						cheque_no_temp, bank_temp, currency_temp, amount_temp, amount_aed_temp);
				pdcrentryCustDetails.add(temppdcrentryCustDetails);
			}
			return pdcrentryCustDetails;
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection();
		}

	}

	// close db
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
