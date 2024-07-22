package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.sql.Statement;  
import beans.OrclDBConnectionPool; 

public class FeedbackDbUtil {

	
	public int inserFeedbackData(String details, String  feedbackType, String  empCode) { 
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection myCon = null;
		ResultSet myRes = null;		
		PreparedStatement myStmt = null;
		int retval = 0; 
		StringBuilder sqlstr = new StringBuilder( "INSERT INTO FJPORTAL.FJ_FEEDBACKS ");
		sqlstr.append( "( FDBCK_TYPE, FDBCK_DESC, ACT_EMP_CODE, SYS_EMP_CODE, UPDATED_DT)");
		sqlstr.append(" VALUES (?, ?, ?, ?, CURRENT_DATE)");
		try {
			myCon = orcl.getOrclConn();
			if (myCon == null) return -2;
			
			myStmt = myCon.prepareStatement(sqlstr.toString());
			myStmt.setString(1, feedbackType);
			myStmt.setString(2, details);
			myStmt.setString(3, empCode); 
			myStmt.setString(4, empCode); 
			retval = myStmt.executeUpdate();
           //System.out.println("RETURN"+retval);
		} catch (Exception e) {
			System.out.println("FEEDBACK DATA INSERT DB ERROR");
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			close(myStmt, myRes);
			orcl.closeConnection(); 
		}
		return retval;
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
