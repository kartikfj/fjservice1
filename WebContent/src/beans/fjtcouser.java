/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author  
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

public class fjtcouser {
	private String uname = null;
	private int acsno = 0;
	private String calander_code = null;
	private String emp_com_code = null;
	private String emp_code = null;
	private String form_uid = null;
	private String form_pwd = null;
	private String pwd = null;
	private String tmp_pwd = null;
	private int homepage = 0;
	private String approver = null;
	private String onduty = null;
	private String emailid = null;
	private String role = null;
	private ConcurrentHashMap subordinatelist = null;
	private String outvisit = "n";
	private String sales_code = null;
	private String urlAddress = null;
	private String emp_divn_code = null;
	private int salesDMYn = 0; // sales division manager or not if yes = 1, no =0

	private List<CustomerVisit> projectDetails = null;
	private List<CustomerVisit> visitActions = null;
	private String emp_type = null;
	private String designation = null;

	public fjtcouser() {

		this.getSystemUrlAddress();
	}

	public String getApproverId() {

		if (this.approver == null)
			return null;
		return getEmailIdByEmpcode(this.approver);
	}

	public String getEmailIdByEmpcode(String newempcode) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String retval = null;
		String sqlstr = "SELECT TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		// String sqlstr = "SELECT TXNFIELD_FLD5 FROM ORION.PT_TXN_FLEX_FIELDS WHERE
		// TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, newempcode);
			rs = psmt.executeQuery();
			if (rs.next()) {
				retval = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// DB error
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

	public int getMoreUserDetails() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// String sqlstr = "SELECT
		// TXNFIELD_FLD2,TXNFIELD_FLD3,TXNFIELD_FLD4,TXNFIELD_FLD5 FROM
		// ORION.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND
		// TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		String sqlstr = "SELECT TXNFIELD_FLD2,TXNFIELD_FLD3,TXNFIELD_FLD4,TXNFIELD_FLD5 FROM FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_EMP_CODE = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.acsno = rs.getInt(1);
				this.approver = rs.getString(2);
				this.setOnduty(rs.getString(3));
				this.emailid = rs.getString(4);
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;

	}

	public int getSubordinatesDetails() {
		subordinatelist = new ConcurrentHashMap<String, fjtcouser>();
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// SELECT EMP_COMP_CODE,EMP_NAME,EMP_CALENDAR_CODE FROM PAYROLL.PM_EMP_KEY WHERE
		// EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS
		// ='2')";
		String sqlstr = "SELECT TXNFIELD_EMP_CODE,TXNFIELD_FLD2 FROM PAYROLL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_FLD3 = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1   AND TXNFIELD_EMP_CODE  IN ( SELECT EMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE   EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') )";
		// String sqlstr = "SELECT TXNFIELD_EMP_CODE,TXNFIELD_FLD2 FROM
		// FJPORTAL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_FLD3 = ? AND
		// TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			while (rs.next()) {

				String empcode = rs.getString(1);
				fjtcouser sub1 = new fjtcouser();
				sub1.setEmp_code(empcode);
				sub1.setForm_uid(empcode);
				if (sub1.isNotFrozenAccount() != 1)
					continue;
				Integer sacno = rs.getInt(2);
				sub1.setAcsno(sacno);
				sub1.getMoreUserDetails();
				this.getSubordinatelist().put(empcode, sub1);
				System.out.println("getSubordinatelist== " + this.getSubordinatelist().get(empcode));
			}
			retval = this.getSubordinatelist().size();
			System.out.println("getSubordinatelist== " + retval);
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int getCheckSalesDMorNot() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// SELECT SM_FLEX_18 FROM OM_SALESMAN
		// WHERE SM_FLEX_09='Y' AND SM_FRZ_FLAG_NUM=2 AND SM_FLEX_08 = :SDM AND
		// SM_FLEX_18 =: SDM
		// WHERE SM_FLEX_09='Y' AND SM_FRZ_FLAG_NUM=2 AND SM_FLEX_08 = :SDM AND
		// SM_FLEX_18 =: SDM
		String sqlstr = "SELECT  COUNT(SM_FLEX_18) SDM_YN  FROM OM_SALESMAN "
				+ " WHERE  SM_FLEX_09='Y' AND SM_FRZ_FLAG_NUM=2 AND SM_FLEX_08 = ? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			while (rs.next()) {

				retval = Integer.parseInt(rs.getString(1));
				this.setSalesDMYn(retval);
			}

		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int getSalesVisitStatus() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// String sqlstr = "SELECT SM_FLEX_07 FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08
		// = ? ";
		String sqlstr = "SELECT SM_FLEX_07 FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? ";

		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				// System.out.println("Before "+this.outvisit); // important
				this.setOutvisit(rs.getString(1));
				// System.out.println("After "+this.outvisit); // important
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public int getRegisteruser() {
		System.out.println("reg usr");
		if (this.form_pwd == null) {
			System.out.println("reg in iff");
			return -1;
		}
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int status = -1;
		if (mcon == null) {
			System.out.println("my sqlcon " + mcon);
			return status;
		}

		PreparedStatement psmt = null;
		String usrsql = "insert into  fjtcouser (user_id,accesscrdNo,password,role,temppassword) values (?,?,?,?,?) ";
		try {
			mcon.setAutoCommit(false);
			System.out.println("getRegisteruser== " + this.acsno + " " + this.emp_code + " " + this.form_pwd);
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.emp_code);
			psmt.setInt(2, this.acsno);
			psmt.setString(3, this.form_pwd);
			psmt.setString(4, "normal");
			psmt.setString(5, this.form_pwd);
			int count = psmt.executeUpdate();
			if (count == 1)
				status = 1;
			///////////
			SSLMail sslmail = new SSLMail();
			String div = "<br/><br/><div style=\"width: auto;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
					+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
			String msg = div + "Welcome to Fjhr portal. Fjhr registration completed. Your password is : "
					+ this.form_pwd + " In order to change your password, login to fjportal and go to settings.</div>";
			sslmail.setToaddr(this.getEmailid());
			sslmail.setMessageSub("Fjhr registration for " + this.emp_code);
			sslmail.setMessagebody(msg);
			status = sslmail.sendMail(this.urlAddress);
			if (status != 1)
				mcon.rollback();
			else
				mcon.commit();
			//////////

		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e);
			status = -2; // DB error
		} finally {
			try {
				// rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				status = -2;
			}
		}
		// System.out.println("reg status"+status);
		return status;
	}

	public int getCheckLogin() {
		/*
		 * int logType=-1; logType=isNotFrozenAccount();
		 * System.out.println("frozen acc "+logType); if(logType !=1) return logType;
		 * this.emp_code = form_uid; logType = getMoreUserDetails();
		 * System.out.println("getMoreUserDetails "+logType); if(logType !=1) return
		 * logType;
		 */
		// System.out.println("checkLogin");
		int logType = -1;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;

		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "select  password, temppassword, homepage , role from fjtcouser where user_id =?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, form_uid);
			rs = psmt.executeQuery();
			logType = 2; // no user id in mysql

			if (rs.next()) {
				String pwd = rs.getString(1);
				String temppwd = rs.getString(2);
				int hwp = rs.getInt(3);
				String role = rs.getString(4);
				// this.emp_code = form_uid;
				if (form_pwd.equals(pwd)) { // regular user logType 1
					logType = 1;
					this.setPwd(pwd);
					this.role = role;
					this.setHomepage(hwp);
					this.getSalesVisitStatus();
					this.getSubordinatesDetails();
					this.getSalesEgsCode();
					if (this.sales_code != null) {
						// this.getSalesEngineerProjectListForCustVisit();
						this.getCustomerVisitActions();
						this.getCheckSalesDMorNot();
					}

				} else
					logType = 0; // wrong password
			} else {
				// new fjtco user , existing orion user.-- set password
				System.out.println("not in mysql " + logType);
				logType = 2;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		// System.out.println(logType);
		return logType;
	}

	////
	public int getCheckUid() {
		if (getCheckValidSession() == 1 && this.form_uid != this.emp_code) {
			System.out.println("existing session");
			return -4;
		}
		int logType = -1;
		logType = isNotFrozenAccount();
		// System.out.println("frozen acc "+logType);
		if (logType != 1)
			return logType;
		this.emp_code = form_uid;
		logType = getMoreUserDetails();
		// System.out.println("get more details"+logType);
		if (logType != 1)
			return logType;

		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;

		ResultSet rs = null;
		PreparedStatement psmt = null;
		String usrsql = "select password from  fjtcouser where user_id =?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, form_uid);
			rs = psmt.executeQuery();
			// logType = 2; //no user id in mysql

			if (rs.next()) // existing user
			{
				logType = 1;
			} else {
				// new fjtco user , existing orion user.-- set password
				// System.out.println("not in mysql "+logType);
				logType = 2;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logType = -2; // DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
			}
		}
		// System.out.println(logType);
		return logType;
	}

	///
	public int getChangeForgottenPwd() {
		int status = getResetPassword();
		if (status != 1)
			return status;
		SSLMail sslmail = new SSLMail();
		String div = "<br/><br/><div style=\"width: auto;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "font-size: 15px;\n" + "\">";
		String msg = div + "New password is : " + this.form_pwd
				+ " In order to change your password, login to fjportal and go to settings.</div>";
		sslmail.setToaddr(this.getEmailid());
		sslmail.setMessageSub("New password for fjhr portal for user " + this.emp_code);
		sslmail.setMessagebody(msg);
		status = sslmail.sendMail(this.urlAddress);
		if (status != 1) {
			this.form_pwd = this.pwd;
			getResetPassword();
		}
		// System.out.print("sent...");
		// status=1;
		return status;
	}

	public int getResetPassword() {
		if (this.form_pwd == null || this.emp_code == null)
			return -1;
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		int status = -1;
		if (mcon == null)
			return status;
		// ResultSet rs=null;
		PreparedStatement psmt = null;
		// System.out.println(this.emp_code);
		// System.out.println(this.pwd);
		String usrsql = "update  fjtcouser set password = ? , temppassword = ? where user_id = ?";
		try {
			psmt = mcon.prepareStatement(usrsql);
			psmt.setString(1, this.form_pwd);
			psmt.setNull(2, Types.VARCHAR);
			psmt.setString(3, this.emp_code);
			int count = psmt.executeUpdate();
			if (count == 1)
				status = 1;

		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e);
			status = -2; // DB error
		} finally {
			try {
				// rs.close();
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				status = -2;
			}
		}
		return status;
	}

	public boolean resetHomePage() {
		return false;
	}

	public int isNotFrozenAccount() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = -1;
		// String sqlstr = "SELECT
		// EMP_COMP_CODE,EMP_NAME,EMP_CALENDAR_CODE,EMP_DIVN_CODE FROM ORION.PM_EMP_KEY
		// WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS
		// ='2')";
		String sqlstr = "SELECT EMP_COMP_CODE,EMP_NAME,EMP_CALENDAR_CODE,EMP_DIVN_CODE,EMP_JOB_LONG_DESC FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, form_uid);
			rs = psmt.executeQuery();
			if (rs.next()) {

				this.emp_com_code = rs.getString(1);
				this.uname = rs.getString(2);
				this.calander_code = rs.getString(3);
				String division = rs.getString(4);
				if (division != null && division.equalsIgnoreCase("UAEE")) {
					this.setEmp_divn_code(getEmiratisDivision(form_uid));
				} else {
					this.setEmp_divn_code(division);
				}

				this.setDesignation(rs.getString(5));
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public String getEmiratisDivision(String uid) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String division = null;
		String sqlstr = "SELECT EMP_DIVN_CODE FROM FJPORTAL.EMIRATIS_DIVN_DET WHERE EMP_CODE =? ";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, form_uid);
			rs = psmt.executeQuery();
			if (rs.next()) {
				division = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();

			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");

			}
		}
		return division;
	}

	public String getEmpNameByUid(String id) {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return null;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		String empname = null;
		// String sqlstr = "SELECT EMP_NAME FROM ORION.PM_EMP_KEY WHERE EMP_CODE =? AND
		// EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		String sqlstr = "SELECT EMP_NAME FROM FJPORTAL.PM_EMP_KEY WHERE EMP_CODE =? AND EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2')";
		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if (rs.next()) {
				empname = rs.getString(1);

			}

		} catch (Exception e) {
			e.printStackTrace();

			// DB error
		} finally {
			try {
				rs.close();
				psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				empname = null;
			}
		}
		return empname;
	}

	// sales code retrv function
	public int getSalesEgsCode() {
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		Connection con = orcl.getOrclConn();
		if (con == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = 0;
		// String sqlstr = "SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 =
		// ? ";
		String sqlstr = "SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 ";

		try {
			psmt = con.prepareStatement(sqlstr);
			psmt.setString(1, this.emp_code);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.setSales_code(rs.getString(1));
				retval = 1;
			} else
				retval = -1;
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;
			// DB error
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (psmt != null)
					psmt.close();
				orcl.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	/**
	 * @return the form_uid
	 */
	public String getForm_uid() {
		return form_uid;
	}

	/**
	 * @param form_uid the form_uid to set
	 */
	public void setForm_uid(String form_uid) {
		this.form_uid = form_uid;
	}

	/**
	 * @return the form_pwd
	 */
	public String getForm_pwd() {
		return form_pwd;
	}

	/**
	 * @param form_pwd the form_pwd to set
	 */
	public void setForm_pwd(String form_pwd) {

		this.form_pwd = form_pwd;

	}

	/**
	 * @return the uname
	 */
	public String getUname() {
		return uname;
	}

	/**
	 * @param uname the uname to set
	 */
	public void setUname(String uname) {
		this.uname = uname;
	}

	/**
	 * @return the emp_com_code
	 */
	public String getEmp_com_code() {
		return emp_com_code;
	}

	/**
	 * @param emp_com_code the emp_com_code to set
	 */
	public void setEmp_com_code(String emp_com_code) {
		this.emp_com_code = emp_com_code;
	}

	/**
	 * @return the emp_code
	 */
	public String getEmp_code() {
		return emp_code;
	}

	/**
	 * @param emp_code the emp_code to set
	 */
	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}

	/**
	 * @return the acsno
	 */
	public int getAcsno() {
		return acsno;
	}

	/**
	 * @param acsno the acsno to set
	 */
	public void setAcsno(int acsno) {
		this.acsno = acsno;
	}

	/**
	 * @return the pwd
	 */
	public String getPwd() {
		return pwd;
	}

	/**
	 * @param pwd the pwd to set
	 */
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	/**
	 * @return the tmp_pwd
	 */
	public String getTmp_pwd() {
		return tmp_pwd;
	}

	/**
	 * @param tmp_pwd the tmp_pwd to set
	 */
	public void setTmp_pwd(String tmp_pwd) {
		this.tmp_pwd = tmp_pwd;
	}

	/**
	 * @return the homepage
	 */
	public int getHomepage() {
		return homepage;
	}

	/**
	 * @param homepage the homepage to set
	 */
	public void setHomepage(int homepage) {
		this.homepage = homepage;
	}

	/**
	 * @return the approver
	 */
	public String getApprover() {
		return approver;
	}

	/**
	 * @param approver the approver to set
	 */
	public void setApprover(String approver) {
		this.approver = approver;
	}

	/**
	 * @return the onduty
	 */
	public String isOnduty() {
		return getOnduty();
	}

	/**
	 * @param onduty the onduty to set
	 */
	public void setOnduty(String onduty) {
		this.onduty = onduty;
	}

	/**
	 * @return the emailid
	 */
	public String getEmailid() {
		return emailid;
	}

	/**
	 * @param emailid the emailid to set
	 */
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}

	/**
	 * @return the subordinatelist
	 */
	public ConcurrentHashMap getSubordinatelist() {
		return subordinatelist;
	}

	/**
	 * @return the onduty
	 */
	public String getOnduty() {
		return onduty;
	}

	public String getApproverName() {
		if (this.approver == null)
			return null;
		else
			return this.getEmpNameByUid(this.approver);
	}

	/**
	 * @return the calander_code
	 */
	public String getCalander_code() {
		return calander_code;
	}

	/**
	 * @param calander_code the calander_code to set
	 */
	public void setCalander_code(String calander_code) {
		this.calander_code = calander_code;
	}

	/**
	 * @return the role
	 */
	public String getRole() {
		return role;
	}

	/**
	 * @param role the role to set
	 */
	public void setRole(String role) {
		this.role = role;
	}

	/**
	 * @return the outvisit
	 */
	public String getOutvisit() {
		return outvisit;
	}

	/**
	 * @param outvisit the outvisit to set
	 */
	public void setOutvisit(String outvisit) {
		this.outvisit = outvisit;
	}

	public int getCheckValidSession() {
		if (this.emp_code != null && this.pwd != null)
			return 1;
		else
			return 0;
	}

	public String getSales_code() {
		return sales_code;
	}

	public void setSales_code(String sales_code) {
		this.sales_code = sales_code;
	}

	public String getUrlAddress() {
		return urlAddress;
	}

	public void setUrlAddress(String urlAddress) {
		this.urlAddress = urlAddress;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public int getSystemUrlAddress() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usql = "select emailid  from  emailconf where usagetype='HTTPS' ";
		try {
			psmt = mcon.prepareStatement(usql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				// this.setUrlAddress(rs.getString(1));
				System.out.println("New URL : " + this.urlAddress);
				this.setUrlAddress("http://10.10.5.143:8080/FJPORTAL_DEV/");
				System.out.println("New URLlllllllllll : " + this.getUrlAddress());
				retval = 1;

			} else {
				System.out.println("no url address details, connection issue");
				retval = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			retval = -2;

		} finally {
			try {
				if (psmt != null)
					;
				psmt.close();
				con.closeConnection();

			} catch (SQLException e) {

				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;
	}

	public String getEmp_divn_code() {
		return emp_divn_code;
	}

	public void setEmp_divn_code(String emp_divn_code) {
		this.emp_divn_code = emp_divn_code;
	}

	public List<CustomerVisit> getProjectDetails() {
		return projectDetails;
	}

	public void setProjectDetails(List<CustomerVisit> projectDetails) throws SQLException {
		this.projectDetails = projectDetails;
	}

	public List<CustomerVisit> getVisitActions() {
		return visitActions;
	}

	public void setVisitActions(List<CustomerVisit> visitActions) {
		this.visitActions = visitActions;

	}

	public void getSalesEngineerProjectListForCustVisit() throws SQLException {
		List<CustomerVisit> projectList = new ArrayList<>();
		Connection myCon = null;
		PreparedStatement myStmt = null;
		ResultSet myRes = null;
		OrclDBConnectionPool orcl = new OrclDBConnectionPool();
		try {
			myCon = orcl.getOrclConn();
			String sql = " SELECT DOC_ID, PARTY_NAME, CONTACT_PERSON, PROJ_NAME, PROJ_STAGE, CONSULTANT FROM CUS_VIST_ACTION_VIEW "
					+ " WHERE  SM_CODE IN (SELECT SM_CODE FROM FJPORTAL.OM_SALESMAN WHERE SM_FLEX_08 = ? and  SM_FRZ_FLAG_NUM=2 )  "
					+ "  AND  DOC_DATE BETWEEN ADD_MONTHS (TRUNC (SYSDATE,'YEAR'), -12) AND SYSDATE   "
					+ " ORDER BY DOC_DATE DESC ";
			myStmt = myCon.prepareStatement(sql);
			myStmt.setString(1, this.emp_code);
			myRes = myStmt.executeQuery();
			while (myRes.next()) {
				String documentId = myRes.getString(1);
				String partyName = myRes.getString(2);
				String contacts = myRes.getString(3);
				String projectName = myRes.getString(4);
				String projectStage = myRes.getString(5);
				String consultant = myRes.getString(6);
				CustomerVisit tmpProjectList = new CustomerVisit(documentId, partyName, contacts, projectName,
						projectStage, consultant);
				projectList.add(tmpProjectList);
			}
			this.setProjectDetails(projectList);
		} finally { // close jdbc objects
			close(myStmt, myRes);
			orcl.closeConnection();
		}
	}

	public void getCustomerVisitActions() throws SQLException {
		if (this.sales_code != null) {
			List<CustomerVisit> actionList = new ArrayList<>();
			Connection myCon = null;
			Statement myStmt = null;
			ResultSet myRes = null;
			OrclDBConnectionPool orcl = new OrclDBConnectionPool();
			try {
				myCon = orcl.getOrclConn();
				String sql = " SELECT * FROM CUS_VIS_TYPE  ";
				myStmt = myCon.createStatement();
				myRes = myStmt.executeQuery(sql);
				while (myRes.next()) {
					String action = myRes.getString(1);
					CustomerVisit tmpActionList = new CustomerVisit(action);
					actionList.add(tmpActionList);
				}
				this.setVisitActions(actionList);
			} finally { // close jdbc objects
				close(myStmt, myRes);
				orcl.closeConnection();
			}
		}
	}

	public int getSalesDMYn() {
		return salesDMYn;
	}

	public void setSalesDMYn(int salesDMYn) {
		this.salesDMYn = salesDMYn;
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
