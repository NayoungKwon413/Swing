package logic;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.web.multipart.MultipartFile;

import util.CipherUtil;

public class Mail {
	private String recipient;
	private String title;
	private String mtype;
	private String contents;
	private List<MultipartFile> file1;
	private String naverid;
	private String naverpw;
	private String type;
	private String reason;
	
	// getter,setter,toString
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public List<MultipartFile> getFile1() {
		return file1;
	}
	public void setFile1(List<MultipartFile> file1) {
		this.file1 = file1;
	}
	public String getNaverid() {
		return naverid;
	}
	public void setNaverid(String naverid) {
		this.naverid = naverid;
	}
	public String getNaverpw() {
		return naverpw;
	}
	public void setNaverpw(String naverpw) {
		this.naverpw = naverpw;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	@Override
	public String toString() {
		return "Mail [recipient=" + recipient + ", title=" + title + ", mtype=" + mtype + ", contents=" + contents
				+ ", file1=" + file1 + ", naverid=" + naverid + ", naverpw=" + naverpw + "]";
	}

	public void mailSend(Mail mail) {
		System.out.println(mail);
		try{
			String subject="";
			mail.setRecipient(CipherUtil.decrypt(mail.getRecipient(), CipherUtil.makehash().substring(0,16)));
			mail.setNaverid(CipherUtil.decrypt(mail.getNaverid(),CipherUtil.makehash().substring(0,16)));
			String[] ids = mail.getRecipient().split("@");
			System.out.println(ids);
			if(mail.type.equals("반려")) {
				subject ="클래스 승인이 반려됨을 알려드립니다.";
				setContents("사유:"+mail.getReason());
			}
			else if(mail.type.equals("탈퇴")){
				subject ="강제탈퇴됨을 알려드립니다.";	
			}
			else if(mail.type.equals("비밀번호찾기")) {
				subject ="임시비밀번호가 발급되었습니다.";
				setContents("임시비밀번호:"+mail.getReason());
			}

			for(String id : ids) {
				try {
					mail.setTitle(id+"님 "+subject+",");
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			send(mail);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void send(Mail mail) {
		//네이버 메일 전송을 위한 인증 객체
		MyAuthenticator auth = new MyAuthenticator(mail.getNaverid(), mail.getNaverpw());
		Properties prop = new Properties();
		try {
			FileInputStream fis = new FileInputStream("C:\\Users\\GDJ-24\\git\\Swing\\pp\\src\\main\\resources\\mail.properties");
			prop.load(fis); //mail.properties의 내용을 Properties(Map)객체로 
			prop.put("mail.smtp.user",mail.getNaverid());
		} catch (IOException e) {
			e.printStackTrace();
		}
		//메일 전송을 위한 객체
		Session session = Session.getInstance(prop,auth);
		//메일의 내용을 저장하기 위한 객체
		MimeMessage mimeMsg = new MimeMessage(session);
		try {
			//보내는 사람 설정
			mimeMsg.setFrom(new InternetAddress(mail.getNaverid()));
			List<InternetAddress> addrs = new ArrayList<InternetAddress>();
			//홍길동 <hong@aaa.bbb>,김삿갓<kim@aaa.bbb>,..
			String[] emails = mail.getRecipient().split(",");
			for(String email : emails) {
				try {
					
					addrs.add(new InternetAddress(new String(email.getBytes("utf-8"),"8859_1")));
				} catch(UnsupportedEncodingException ue) {
					ue.printStackTrace();
				}
			}
			InternetAddress[] arr= new InternetAddress[emails.length];
			for(int i=0; i<addrs.size(); i++) {
				arr[i] = addrs.get(i);
			}
			//보낸일자
			mimeMsg.setSentDate(new Date());
			//받는사람
			mimeMsg.setRecipients(Message.RecipientType.TO , arr);
			//제목
			String[] subjects = mail.getTitle().split(",");
			for(String subject : subjects) {
				try {
					mimeMsg.setSubject(subject);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			MimeMultipart multipart = new MimeMultipart();
			MimeBodyPart message = new MimeBodyPart();
			
			message.setContent(mail.getContents(),"text/plain; charset=utf-8");
			multipart.addBodyPart(message);

			mimeMsg.setContent(multipart);
			Transport.send(mimeMsg);
		} catch(MessagingException me) {
			me.printStackTrace();
		}
	}

	private final class MyAuthenticator extends Authenticator {
		private String id;
		private String pw;
		public MyAuthenticator(String id, String pw) {
			this.id = id;
			this.pw = pw;
		}
		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(id,pw);
		}
	}	
}
