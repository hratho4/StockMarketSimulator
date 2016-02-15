/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.uic.cs440.stockmarket.servlets;

import com.uic.cs440.stockmarket.beans.ContactusBean;
import java.util.Properties;
import javax.activation.CommandMap;
import javax.activation.MailcapCommandMap;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author SONY
 */
public class SendMail {

    public static ContactusBean send(ContactusBean bean) {
        
        
        /*
         // Recipient's email ID needs to be mentioned.
      String to = "abcd@gmail.com";

      // Sender's email ID needs to be mentioned
      String from = "web@gmail.com";

      // Assuming you are sending email from localhost
      String host = "localhost";

      // Get system properties
      Properties properties = System.getProperties();

      // Setup mail server
      properties.setProperty("mail.smtp.host", host);

      // Get the default Session object.
      Session session = Session.getDefaultInstance(properties);

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));

         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

         // Set Subject: header field
         message.setSubject("This is the Subject Line!");

         // Now set the actual message
         message.setText("This is actual message");

         // Send message
         Transport.send(message);
         System.out.println("Sent message successfully....");
      }catch (MessagingException mex) {
         mex.printStackTrace();
      }
   }
        */
        
        
        String name = bean.getName();
        String email = bean.getEmail();
        String subject = bean.getSubject();
        String mess = "From:"+email+"\n"+bean.getMessage();
        String tmp = "Name : " + name + "\n" + "Email : " + email + "\n" + "Message : " + mess + "\n";

        final String username = "simplybac@gmail.com";
        final String password = "qwerasdf";
        Properties prop = System.getProperties();
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.starttls.enable", "true");
        System.out.println("Mail Server Properties have been setup successfully..");

      // Get the default Session object.
      Session session = Session.getInstance(prop ,new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("simplybac@gmail.com", "qwerasdf");
                    }
                });
        try {
             // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         System.out.println("........inside sendmail......."+bean.getEmail());
         message.setFrom(new InternetAddress(bean.getEmail()));
         message.setSender(new InternetAddress(bean.getEmail()));
     
         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO, new InternetAddress("simplybac@gmail.com"));

         // Set Subject: header field
         message.setSubject(subject);

         // Now set the actual message
         message.setText(mess);

         // Send message
         Transport.send(message);
         System.out.println("Sent message successfully....");
         bean.setValid(true);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return bean;
    }
}
