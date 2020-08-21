package logic;

import java.util.Date;

public class Chatting {
	private int roomno;
	private int talkno;
	private String userid;
	private int classid;
	private String chat;
	private Date chatdate;
	private int readcheck;
	//클래스 제목
	private String subject;
	//user 프로필사진, 이름
	private String file;
	private String name;
	//새로운 메시지
	private int newtalk;
	
	// getter, setter, toString
	public int getRoomno() {
		return roomno;
	}
	public void setRoomno(int roomno) {
		this.roomno = roomno;
	}
	public int getTalkno() {
		return talkno;
	}
	public void setTalkno(int talkno) {
		this.talkno = talkno;
	}
	public int getClassid() {
		return classid;
	}
	public void setClassid(int classid) {
		this.classid = classid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getChat() {
		return chat;
	}
	public void setChat(String chat) {
		this.chat = chat;
	}
	public Date getChatdate() {
		return chatdate;
	}
	public void setChatdate(Date chatdate) {
		this.chatdate = chatdate;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getNewtalk() {
		return newtalk;
	}
	public void setNewtalk(int newtalk) {
		this.newtalk = newtalk;
	}
	public int getReadcheck() {
		return readcheck;
	}
	public void setReadcheck(int readcheck) {
		this.readcheck = readcheck;
	}
	@Override
	public String toString() {
		return "Chatting [roomno=" + roomno + ", talkno=" + talkno + ", userid=" + userid + ", classid=" + classid
				+ ", chat=" + chat + ", chatdate=" + chatdate + "]";
	}
}
