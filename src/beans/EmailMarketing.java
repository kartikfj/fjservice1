 
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

public class EmailMarketing {

	private String messageSub = null;
	private String toaddr = null;
	private String ccaddr = null;
	private String fromaddr = null;
	private String password = null;
	private String messagebody = "";
	private String host = null;
	private int port = 0;
	private int is_ssl = 0;
	private String userName =null;
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
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

	public String getCcaddr() {
		return ccaddr;
	}

	public void setCcaddr(String ccaddr) {
		this.ccaddr = ccaddr;
	}

	@SuppressWarnings("finally")
	public int sendMail() {
		readDefaultSenderMailProps();
		Properties props = new Properties();
		props.put("mail.smtp.host", this.host);

		props.put("mail.smtp.host", host);
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
			message.setFrom(new InternetAddress(this.fromaddr, "FJ-SYNERGY"));
			System.out.println(this.toaddr);
			message.setRecipients(Message.RecipientType.TO,
					//InternetAddress.parse(this.toaddr));
					InternetAddress.parse("nufail.a@fjtco.com"));
			message.setRecipients(Message.RecipientType.CC,
				InternetAddress.parse("nufail.a@fjtco.com"));
				  // InternetAddress.parse(this.ccaddr));
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
		String usql = "select emailid,password,host,port,is_ssl,user_name from  emailconf where usagetype='FJMKT'";
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
		String div = " <span style=\"color:red;\">Please login to  <a href=\"https://portal.fjtco.com:8444/fjhr/\" style=\"font-weight:700;\">FJ Portal</a> for acknowledging and further updates.</span><br /><br />  "
				+ "This is an auto-generated email. Please do not reply to this email. <br/>  "
				+ "Thank you <br/> Regards</td></tr>"
				+ "<tr><td bgcolor=\"#60676d\" style=\"padding:1px 2px;color:#60676d;\">-</td></tr>" + "<tr><td>"
				+ "<div style=\"min-width:100%;width:100%;background-color:#014888\">  "
				+ "<table style=\"width:100%;max-width:600px;margin-left:auto;margin-right:auto;padding-left:20px;padding-right:20px;padding-bottom:10px;color:#ffffff;line-height:1.4;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI','Roboto','Ubuntu','Open Sans','Helvetica Neue',sans-serif;background:#ffffff;background-color:#014888\"><tbody><tr><td><div style=\"text-align:center;margin-top:50px;\"><div style=\"font-size:20px;font-weight:700;margin-bottom:20px\">"
				+ "Faisal Jassim Group.</div><div style=\"text-align:center\">" + "</div></div>"
				+ "<div style=\"background: #014888;padding-top:15px;padding-right:0;padding-bottom:0;padding-left:0;margin-top:30px;color:#ffffff;font-size:12px;text-align:center;border-top:1px solid #8e8e8e\">Sent by  "
				+ "<a href=\"http://www.faisaljassim.ae/\" style=\"color:#ffc107;text-decoration:underline\" target=\"_blank\" data-saferedirecturl=\"http://www.faisaljassim.ae/\" > FJ-Group</a> · P.O. Box 1871, Dubai Investment Park - 1 - Dubai<div>"
				+ "</div></div></td></tr></tbody></table></div>  " + "</td></tr></table>";
		StringBuilder mbody = new StringBuilder("");
		mbody.append(div);
		return mbody.toString();
	}

}
