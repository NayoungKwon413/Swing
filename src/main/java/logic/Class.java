package logic;

import java.util.Date;

public class Class {
	private int classid;
	private String userid;
	private String location1;
	private String location2;
	private int category;
	private int type;
	private int maxtutee;
	private String subject;
	private String coverimg;
	private int price; // 시간당 가격
	private int time;  // 회당 수업시간
	private int totaltime; // 총 수업 횟수
	private int totalprice; // 총 가격
	private String tutorintro;
	private String classintro;
	private int level;
	private int readcnt;
	private int state;
	private Date regdate;
	//참여인원수
	private int totaltutee;
	//클래스 리뷰 평점, 갯수
	private int staravg;
	private int reviewcnt;
	
	// getter, setter, toString
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
	public String getLocation1() {
		return location1;
	}
	public void setLocation1(String location1) {
		this.location1 = location1;
	}
	public String getLocation2() {
		return location2;
	}
	public void setLocation2(String location2) {
		this.location2 = location2;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getMaxtutee() {
		return maxtutee;
	}
	public void setMaxtutee(int maxtutee) {
		this.maxtutee = maxtutee;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCoverimg() {
		return coverimg;
	}
	public void setCoverimg(String coverimg) {
		this.coverimg = coverimg;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public int getTotaltime() {
		return totaltime;
	}
	public void setTotaltime(int totaltime) {
		this.totaltime = totaltime;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public String getTutorintro() {
		return tutorintro;
	}
	public void setTutorintro(String tutorintro) {
		this.tutorintro = tutorintro;
	}
	public String getClassintro() {
		return classintro;
	}
	public void setClassintro(String classintro) {
		this.classintro = classintro;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	public int getTotaltutee() {
		return totaltutee;
	}
	public void setTotaltutee(int totaltutee) {
		this.totaltutee = totaltutee;
	}
	
	public int getStaravg() {
		return staravg;
	}
	public void setStaravg(int staravg) {
		this.staravg = staravg;
	}
	public int getReviewcnt() {
		return reviewcnt;
	}
	public void setReviewcnt(int reviewcnt) {
		this.reviewcnt = reviewcnt;
	}
	@Override
	public String toString() {
		return "Class [classid=" + classid + ", userid=" + userid + ", location1=" + location1 + ", location2="
				+ location2 + ", category=" + category + ", type=" + type + ", maxtutee=" + maxtutee + ", subject="
				+ subject + ", coverimg=" + coverimg + ", price=" + price + ", time=" + time + ", totaltime="
				+ totaltime + ", totalprice=" + totalprice + ", tutorintro=" + tutorintro + ", classintro=" + classintro
				+ ", level=" + level + ", readcnt=" + readcnt + ", state=" + state + ", regdate=" + regdate + "]";
	}
}
