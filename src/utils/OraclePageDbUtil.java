package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.OraclePage;

public class OraclePageDbUtil {
	public List<OraclePage> getData(String name) {
		String url = "jdbc:oracle:thin:@10.10.0.46:1521:orcl";
		ResultSet myRes = null;
		List<OraclePage> volumeList = new ArrayList<>();
		try (Connection conn = DriverManager.getConnection(url, "FJPORTAL", "KHLATAM123")) {
			String sql = "SELECT CUST_CODE,CUST_BL_NAME FROM ORION.OM_CUST_TEST WHERE CUST_CODE=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setString(1, name);
				myRes = pstmt.executeQuery();
				while (myRes.next()) {
					String custcode = myRes.getString(1);
					String blName = myRes.getString(2);
					OraclePage tempVolumeList = new OraclePage(custcode, blName);
					volumeList.add(tempVolumeList);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return volumeList;
	}
}
