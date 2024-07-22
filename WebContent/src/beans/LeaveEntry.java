/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author  
 */
public class LeaveEntry {
	private String lv_desc;
	private float balance;

	/**
	 * @return the lv_desc
	 */
	public String getLv_desc() {
		return lv_desc;
	}

	/**
	 * @param lv_desc
	 *            the lv_desc to set
	 */
	public void setLv_desc(String lv_desc) {
		this.lv_desc = lv_desc;
	}

	/**
	 * @return the balance
	 */
	public float getBalance() {
		return balance;
	}

	/**
	 * @param balance
	 *            the balance to set
	 */
	public void setBalance(float balance) {
		this.balance = balance;
	}

	public String getLeaveCategoryByCode(String lvcode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT LV_DESC FROM PAYROLL.FJT_LEAVE_CURR_INFO WHERE LVAC_LV_CODE = ?";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, lvcode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
				// System.out.println("function "+retval);
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = null;

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
}
