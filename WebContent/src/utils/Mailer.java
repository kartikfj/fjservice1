/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.MysqlDBConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage; 
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 
 */
public class Mailer {

	private String fromAdd = null;
	private String toAdd = null;
	private String message = null;

	public int getSendMail() {
		if (message == null)
			return -1;
		MysqlDBConnectionPool mdb = new MysqlDBConnectionPool();
		Connection mcon = mdb.getMysqlConn();
		if (mcon == null)
			return -2;
		ResultSet rs = null;
		PreparedStatement psmt = null;
		int retval = -1;
		String sqlstr = "select emailid,password,host,port,is_ssl from  emailconf where usagetype='ITDEPT'";
		try {
			psmt = mcon.prepareStatement(sqlstr);
			rs = psmt.executeQuery();
			if (rs.next()) {
				final String email = rs.getString(1);
				final String password = rs.getString(2);
				String host = rs.getString(3);
				int port = rs.getInt(4);
				//int ssltype = rs.getInt(5);

				Properties props = new Properties();

				// props.put("mail.smtp.socketFactory.port", port);
				// props.put("mail.smtp.socketFactory.class",
				// "javax.net.ssl.SSLSocketFactory");
				// props.setProperty("mail.smtp.**ssl.required", "true");
				// props.put("mail.smtp.ssl.enable", "true");
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.auth", "true");
				props.setProperty("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.port", port);
				props.put("mail.debug", "true");
				// String newpwd = new PasswordGenerator().getRandomPassword();
				// message = "Your new password is "+newpwd;
				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(email, password);
					}
				});

				Message messageMail = new MimeMessage(session);
				messageMail.setFrom(new InternetAddress(email));
				messageMail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAdd)); // get client email
				messageMail.setSubject("New password for fjtco portal ");
				messageMail.setText("New password is : " + message
						+ " In order to change your password, login to fjportal and go to settings.");
				Transport.send(messageMail);

				// System.out.println("Done");
				retval = 1;

			} else {
				retval = 0;
			}
		} catch (MessagingException e) {
			System.out.println(e);
			retval = -1;
		} catch (SQLException ex) {
			Logger.getLogger(Mailer.class.getName()).log(Level.SEVERE, null, ex);
			retval = -2;
		} finally {
			try {
				rs.close();
				psmt.close();
				mdb.closeConnection();

			} catch (SQLException e) {
				System.out.println("Exception in closing DB resources");
				retval = -2;
			}
		}
		return retval;

	}

	/**
	 * @return the FromAdd
	 */
	public String getFromAdd() {
		return fromAdd;
	}

	/**
	 * @param FromAdd
	 *            the FromAdd to set
	 */
	public void setFromAdd(String FromAdd) {
		this.fromAdd = FromAdd;
	}

	/**
	 * @return the ToAdd
	 */
	public String getToAdd() {
		return toAdd;
	}

	/**
	 * @param ToAdd
	 *            the ToAdd to set
	 */
	public void setToAdd(String ToAdd) {
		this.toAdd = ToAdd;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message
	 *            the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
}