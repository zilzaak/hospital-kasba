package pervez.controller;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Emailtexting {

	public void sendplaintext(String host,String port, final String user ,final String password,String address,
			String subject,String message
			) throws AddressException, MessagingException {
		
		//smtp server properties
		Properties pro = new Properties();
		pro.put("mail.smtp.host", host);
		pro.put("mail.smtp.port",port);
		pro.put("mail.smtp.auth","true");
		pro.put("mail.smtp.starttls.enable","true");
		
		//create a session with an authenticator
		Authenticator auth=new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user,password);
				
			}
		};
	
		Session session = Session.getInstance(pro,auth);
		//create a new email message
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(user));
		InternetAddress[] toAddresses = {new InternetAddress(address)};
		msg.setRecipients(Message.RecipientType.TO,toAddresses );
		msg.setSubject(subject);
		msg.setSentDate(new Date());
		msg.setText(message);
		Transport.send(msg);
			
	}
	
	public void sendsms(String user,String pass,String text,String to) throws AddressException, MessagingException {
		String host="smtp.gmail.com";
		String port="587";
		String subject = "Doctor APPOINTMENT from PUST Medical center";
	sendplaintext(host,port,user,pass,to,subject,text);
		
	
		
	}
	
}
