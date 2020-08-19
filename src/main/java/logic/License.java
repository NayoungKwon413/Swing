package logic;

public class License {
	private int lcno;
	private String userid;
	private String lctitle;
	private String lcfile;
	
	// getter, setter, toString
	public int getLcno() {
		return lcno;
	}
	public void setLcno(int lcno) {
		this.lcno = lcno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getLctitle() {
		return lctitle;
	}
	public void setLctitle(String lctitle) {
		this.lctitle = lctitle;
	}
	public String getLcfile() {
		return lcfile;
	}
	public void setLcfile(String lcfile) {
		this.lcfile = lcfile;
	}
	@Override
	public String toString() {
		return "License [lcno=" + lcno + ", userid=" + userid + ", lctitle=" + lctitle + ", lcfile=" + lcfile + "]";
	}
}
