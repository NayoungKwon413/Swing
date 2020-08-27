package logic;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class License {
	private int lcno;
	private String userid;
	private String lctitle;
	private String lcfile;
	private MultipartFile lcfileurl;
	private List<Integer> lcnolist;
	private List<String> lctitlelist;
	private List<MultipartFile> lcfilelist;
	
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
	
	public List<String> getLctitlelist() {
		return lctitlelist;
	}
	public void setLctitlelist(List<String> lctitlelist) {
		this.lctitlelist = lctitlelist;
	}
	public List<MultipartFile> getLcfilelist() {
		return lcfilelist;
	}
	public void setLcfilelist(List<MultipartFile> lcfilelist) {
		this.lcfilelist = lcfilelist;
	}
	
	public MultipartFile getLcfileurl() {
		return lcfileurl;
	}
	public void setLcfileurl(MultipartFile lcfileurl) {
		this.lcfileurl = lcfileurl;
	}
	
	public List<Integer> getLcnolist() {
		return lcnolist;
	}
	public void setLcnolist(List<Integer> lcnolist) {
		this.lcnolist = lcnolist;
	}
	@Override
	public String toString() {
		return "License [lcno=" + lcno + ", userid=" + userid + ", lctitle=" + lctitle + ", lcfile=" + lcfile + "]";
	}
}
