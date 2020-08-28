package logic;

import java.util.Date;

/* 조회용 객체 */
public class Course {
	private String tutor;
	private String userid;
	private String tutorimg;
	private int classid;
	private int classno;
	private int classseq;
	private String subject;
	private String location1;
	private String place;
	private int type;
	private int totaltime;
	private int totalprice;
	private Date startdate;
	private Date enddate;
	private int reviewnum;
	private double star;
	public String getTutor() {
		return tutor;
	}
	public void setTutor(String tutor) {
		this.tutor = tutor;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTutorimg() {
		return tutorimg;
	}
	public void setTutorimg(String tutorimg) {
		this.tutorimg = tutorimg;
	}
	public int getClassid() {
		return classid;
	}
	public void setClassid(int classid) {
		this.classid = classid;
	}
	public int getClassno() {
		return classno;
	}
	public void setClassno(int classno) {
		this.classno = classno;
	}
	public int getClassseq() {
		return classseq;
	}
	public void setClassseq(int classseq) {
		this.classseq = classseq;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getLocation1() {
		return location1;
	}
	public void setLocation1(String location1) {
		this.location1 = location1;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
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
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public int getReviewnum() {
		return reviewnum;
	}
	public void setReviewnum(int reviewnum) {
		this.reviewnum = reviewnum;
	}
	public double getStar() {
		return star;
	}
	public void setStar(double star) {
		this.star = star;
	}
	@Override
	public String toString() {
		return "Course [tutor=" + tutor + ", userid=" + userid + ", tutorimg=" + tutorimg + ", classid=" + classid
				+ ", classno=" + classno + ", classseq=" + classseq + ", subject=" + subject + ", location1="
				+ location1 + ", place=" + place + ", type=" + type + ", totaltime=" + totaltime + ", totalprice="
				+ totalprice + ", startdate=" + startdate + ", enddate=" + enddate + ", reviewnum=" + reviewnum
				+ ", star=" + star + "]";
	}
	 
}
