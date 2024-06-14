package beans;

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

/**
 * @author  
 */
public class EmailConfig {

	private String messageSub = null;
	private String toaddr = null;
	private String fromaddr = null;
	private String password = null;
	private String messagebody = "";
	private String host = null;
	private int port = 0;
	private int is_ssl = 0;
	private String userName = null;

	public String getMessageSub() {
		return messageSub;
	}

	public void setMessageSub(String messageSub) {
		this.messageSub = messageSub;
	}

	public String getToaddr() {
		return toaddr;
	}

	public void setToaddr(String toaddr) {
		this.toaddr = toaddr;
	}

	public String getFromaddr() {
		return fromaddr;
	}

	public void setFromaddr(String fromaddr) {
		this.fromaddr = fromaddr;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMessagebody() {
		return messagebody;
	}

	public void setMessagebody(String messagebody) {
		this.messagebody = messagebody;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public int getIs_ssl() {
		return is_ssl;
	}

	public void setIs_ssl(int is_ssl) {
		this.is_ssl = is_ssl;
	}
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@SuppressWarnings("finally")
	public int sendMail() {
		readDefaultSenderMailProps();
		Properties props = new Properties();
		props.put("mail.smtp.host", this.host); 
		props.put("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.port", port); 

		int status = 0;
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(this.fromaddr));
			System.out.println(this.toaddr);
			//message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(this.toaddr));
			 message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("nufail.a@fjtco.com"));
			message.setSubject(this.messageSub);
			this.messagebody += getMessageFooter();
			message.setContent(this.messagebody, "text/html");
			Transport.send(message);
			status = 1;
			// System.out.println("Done");

		} catch (MessagingException e) {
			System.out.print(e);
			// throw new RuntimeException(e);
			status = -1;
		} finally {
			return status;
		}
	}

	private int readDefaultSenderMailProps() {
		MysqlDBConnectionPool con = new MysqlDBConnectionPool();
		Connection mcon = con.getMysqlConn();
		if (mcon == null)
			return -2;
		int retval = 0;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String usql = "select emailid,password,host,port,is_ssl,user_name from  emailconf where usagetype='ITDEPT'";
		try {
			psmt = mcon.prepareStatement(usql);
			rs = psmt.executeQuery();
			if (rs.next()) {
				this.fromaddr = rs.getString(1);
				this.password = rs.getString(2);
				this.host = rs.getString(3);
				this.port = rs.getInt(4);
				this.is_ssl = rs.getInt(5);
				this.userName = rs.getString(6);
				// System.out.println(this.fromaddr+ " "+ this.password+ " "+host+" "+port+ "
				// "+is_ssl);
			} else {
				System.out.println("no mail details");
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

	public String getMessageFooter() {
		String div = "<div style=\"width: auto;\n" + "padding: 5px 10px;\n" + "margin: 0 2px;\n"
				+ "font-family: Arial, Helvetica, sans-serif;\n" + "" + "\">";
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		// mbody.append("<a style=\"color:#065685;\"
		// href=\"http://fjprtl.dyndns.org:6080/fjhr/\">Go To FJ PORTAL</a>");
		mbody.append("<br/><strong style=\"color:#065685;\"><hr></strong><br/>"
				+ "This is an auto-generated email. Please do not reply to this email.<br/>" + " <br/>"
				+ "Thank you. <br/>" + "<br/>" + "<span style=\"color:#065685;\">FJHR Portal Admin Team.</span> <br/>"
				+ "<br/>");
		mbody.append("</div>");
		return mbody.toString();
	}
}
