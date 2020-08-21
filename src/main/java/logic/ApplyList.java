package logic;

import java.util.Date;

public class ApplyList {
	private String userid;
	private int classid;
	private int classno;
	private Date applydate;

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
	public int getClassno() {
		return classno;
	}
	public void setClassno(int classno) {
		this.classno = classno;
	}
	public Date getApplydate() {
		return applydate;
	}
	public void setApplydate(Date applydate) {
		this.applydate = applydate;
	}
	@Override
	public String toString() {
		return "ApplyList [userid=" + userid + ", classid=" + classid + ", classno=" + classno + ", applydate="
				+ applydate + "]";
	}
}
