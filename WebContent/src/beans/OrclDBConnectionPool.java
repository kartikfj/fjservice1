/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import javax.naming.*;
import java.sql.*;
import javax.sql.DataSource;

/**
 *
 * @author nufail.a
 */
public class OrclDBConnectionPool {
	Context initCtx = null;
	Context envCtx = null;
	DataSource ds;
	Connection con = null;

	public synchronized Connection getOrclConn() {

		try {
			initCtx = new InitialContext();
			envCtx = (Context) initCtx.lookup("java:comp/env");
			ds = (DataSource) envCtx.lookup("jdbc/orclfjtcolocal");
			// System.out.println("Created connection to database.");
			con = ds.getConnection();
		} catch (Exception e) {
			System.out.println("Couldn't create connection." + e.getMessage());
		}
		return con;
	}

	public synchronized void closeConnection() {
		try {
			con.close();
			initCtx.close();
		} catch (Exception e) {

		}
	}
}
