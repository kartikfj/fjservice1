package beans;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MysqlDBConnectionPool {
	Context initCtx = null;
	Context envCtx = null;
	DataSource ds;
	Connection con = null;

	public MysqlDBConnectionPool() {
	}

	public synchronized Connection getMysqlConn() {

		try {
			initCtx = new InitialContext();
			envCtx = (Context) initCtx.lookup("java:comp/env");
			ds = (DataSource) envCtx.lookup("jdbc/mysqlfjtcolocal");
			System.out.println("Created connection to mysql database.");
			con = ds.getConnection();
		} catch (Exception e) {
			System.out.println("Couldn't create mysql db connection." + e.getMessage());
		}
		return con;
	}

	public synchronized void closeConnection() {
		try {
			con.close();
			System.out.println("closed connection to mysql database.");
			initCtx.close();
		} catch (Exception e) {
			System.out.println("error in close connection or context.");
		}
	}

}
