package logic;

import java.util.Date;

public class WishList {
	
	private String userid;
	private int classid;
	// 클래스정보
	private String subject;
	private String location2;
	private int type;
	private int totaltime;
	private int totalprice;
	private String coverimg;
	private Date startdate;
	private int particinum;
	private double star;
	private int reviewnum;
	
	// getter, setter, toString
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getClassid() {
		return classid;
	}
	public void setClassid(int classid) {
		this.classid = classid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getLocation2() {
		return location2;
	}
	public void setLocation2(String location2) {
		this.location2 = location2;
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
	public String getCoverimg() {
		return coverimg;
	}
	public void setCoverimg(String coverimg) {
		this.coverimg = coverimg;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public int getParticinum() {
		return particinum;
	}
	public void setParticinum(int particinum) {
		this.particinum = particinum;
	}
	public double getStar() {
		return star;
	}
	public void setStar(double star) {
		this.star = star;
	}
	public int getReviewnum() {
		return reviewnum;
	}
	public void setReviewnum(int reviewnum) {
		this.reviewnum = reviewnum;
	}
	@Override
	public String toString() {
		return "WishList [userid=" + userid + ", classid=" + classid + ", subject=" + subject + ", location2="
				+ location2 + ", type=" + type + ", totaltime=" + totaltime + ", totalprice=" + totalprice
				+ ", coverimg=" + coverimg + ", startdate=" + startdate + ", particinum=" + particinum + ", star="
				+ star + "]";
	}
	
}
