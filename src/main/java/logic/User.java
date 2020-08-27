
package logic;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class User {
	@Size(min=3,max=10,message="아이디는 3자이상 10자이하로 입력하세요")
	private String userid;
	@Size(min=3,max=10,message="비밀번호는 3자이상 10자이하로 입력하세요")
	private String pass;
	@NotEmpty(message="사용자이름은 필수 입력입니다.")
	private String name;
	@Email(message="email 형식으로 입력하세요")
	private String email;
	private String file;
	private int kbn;
	private String nickname;
	private int edulevel;
	private String school;
	private String major;
	private String edufile;
	private MultipartFile edufileurl;
	private MultipartFile fileurl2;
	private String fileurl;
	@NotEmpty(message="비밀번호를 한번 더 입력해주세요.")
	private String pass1;
	// getter, setter, toString
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getKbn() {
		return kbn;
	}
	public void setKbn(int kbn) {
		this.kbn = kbn;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getEdulevel() {
		return edulevel;
	}
	public void setEdulevel(int edulevel) {
		this.edulevel = edulevel;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getEdufile() {
		return edufile;
	}
	public void setEdufile(String edufile) {
		this.edufile = edufile;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	
	public MultipartFile getFileurl2() {
		return fileurl2;
	}
	public void setFileurl2(MultipartFile fileurl2) {
		this.fileurl2 = fileurl2;
	}
	
	public MultipartFile getEdufileurl() {
		return edufileurl;
	}
	public void setEdufileurl(MultipartFile edufileurl) {
		this.edufileurl = edufileurl;
	}
	public String getPass1() {
		return pass1;
	}
	public void setPass1(String pass1) {
		this.pass1 = pass1;
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", pass=" + pass + ", pass1=" + pass1 + ", name=" + name + ", email=" + email + ", file=" + file
				+ ", kbn=" + kbn + ", nickname=" + nickname + ", edulevel=" + edulevel + ", school=" + school
				+ ", major=" + major + ", edufile=" + edufile + ", fileurl=" + fileurl + "]";
	}
}


