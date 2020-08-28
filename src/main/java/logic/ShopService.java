package logic;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.ClassDao;
import dao.ClassInfoDao;
import dao.ApplyListDao;
import dao.ChattingDao;
import dao.LicenseDao;
import dao.ReviewDao;
import dao.TutorDao;
import dao.UserDao;
import dao.WishlistDao;

@Service
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private TutorDao tutorDao;
	@Autowired
	private ClassDao classDao;
	@Autowired
	private ClassInfoDao classinfoDao;
	@Autowired
	private WishlistDao wishlistDao;
	/*----User----*/
	@Autowired
	private LicenseDao licenseDao;
	@Autowired
	private ApplyListDao applylistDao;
	@Autowired
	private ChattingDao chattingDao;
	public List<User> userList() {
		return userDao.list();
	}
	
	public void userInsert(User user) {		
		userDao.insert(user);
	}
	public User getUser(String userid) {
		return userDao.selectOne(userid);
	}

	public User getUserByEmail(String email) {
		return userDao.selectOneByEmail(email);
	}

	public List<User> userlist(int pageNum, int limit, String column, String find) {
		return userDao.list(pageNum,limit,column,find);
	}

	public void userUpdate(User user) {
		userDao.update(user);
	}

	public int getTutorCount() {
		return userDao.selectTutorCount();
	}
	
	public int getTuteeCount() {
		return userDao.selectTuteeCount();
	}
	
	public void deleteUser(String userid) {
		userDao.delete(userid);
		
	}
	

	/*----Class----*/
//	public List<Class> searchList(String find){
//		return classDao.searchlist(find);
//	}
	
	/*----Class----*/
	public List<Class> classlist() {
		return classDao.list();
	}
	
	public List<Class> classlistByState(int state) {
		return classDao.listByState(state);
	}
	public List<Class> classlistByState(int pageNum, int limit,int state) {
		return classDao.listByState(pageNum,limit,state);
	}

	public List<Class> classlistById(String userid) {
		return classDao.listById(userid);
	}

	public void updateState(int classid,int state) {
		classDao.updateState(classid,state);
	}
	
	public void reviewWrite(Review review) {
		int max = reviewDao.maxnum();
		review.setReviewno(++max);
		reviewDao.insert(review);
	}
	
	public List<Integer> getTotalprice() {
		return classDao.selectTotPrice();
	}

	public List<Rank> getTutorRank() {
		return classDao.selectTutorRank();
	}

	public List<Rank> getTuteeRank() {
		return classDao.selectTuteeRank();
	}

	public Map<Object, Object> graph() {
		Map<Object, Object> map = new HashMap<Object, Object>();
		for(Map<Object,Object> m: classDao.graph()) {
			map.put(m.get("date"),m.get("total"));
		}
		return map;
	}
	
	/*----ClassInfo----*/
	public List<Classinfo> classinfolist() {
		return classinfoDao.list();
	}
	
	public List<Classinfo> classinfolistByState(int seqstate) {
		return classinfoDao.listByState(seqstate);
	}

	public List<Classinfo> classinfolistById(String userid) {
		return classinfoDao.listById(userid);
	}

	/*----mypage(Tutor)----*/
	public List<Class> getClassList(String userid, Integer state) {		//my.jsp
		return tutorDao.list(userid, state);
	}
	public int classCount(String userid, Integer state) {
		return tutorDao.count(userid, state);
	}	
	public List<Class> getClassList2(String userid, Integer state) {    //result.jsp
		return tutorDao.list2(userid, state);
	}
	public int classCount2(String userid, Integer state) {
		return tutorDao.count2(userid, state);
	}
	public List<Classinfo> getClassInfoList(String userid, Integer state) {
		return tutorDao.classinfolist(userid, state);
	}
	public void classDelete(String userid, Integer classid) {
		tutorDao.delete(userid, classid);
	}
	public Date getClDate(Integer classid) {
		return tutorDao.getClassDate(classid);
	}	
	public void updateState(String userid, int classid) {
		tutorDao.updateState(userid, classid);
	}
	public Map<String, Object> bargraph(String userid) {
		Map<String, Object> map = new HashMap<String, Object>();
		for(Map<String, Object> m : tutorDao.bargraph(userid)) {
			map.put((String) m.get("subject"), m.get("cnt"));
		}
		return map;
	}
	public List<Integer> getPriceList(String userid) {
		return tutorDao.selectTotalPrice(userid);
	}
	public List<Review> getAvgStar(String userid) {
		return tutorDao.avgStar(userid);
	}
//	public List<Class> getClassListforConfirm(String userid, Integer state) {
//		return tutorDao.listforConfirm(userid, state);
//  }
	

	public Class getClass(Integer classid) {
		return classDao.selectOne(classid);
	}

	public List<Classinfo> getClassInfo(Integer classid) {
		return classinfoDao.select(classid);
	}

	public List<Review> getReview(Integer classid, Integer pageNum, int limit) {
		return reviewDao.select(classid,pageNum,limit);
	}


	
	/*----WishList----*/
	public void wishInsert(WishList wish) {
		wishlistDao.insert(wish);
	}
	public List<WishList> getWishlist(String userid) {
		return wishlistDao.list(userid);
	}
	public Date getStartDate(Integer classid) {
		return wishlistDao.startDate(classid);
	}
	public double getStar(Integer classid) {
		return wishlistDao.star(classid);
	}
	public int getParticiNum(Integer classid) {
		return wishlistDao.particiNum(classid);
	}
	public void wishDelete(WishList wish) {
		wishlistDao.delete(wish);
	}
	/*--tutee_classList--*/
	public List<Course> getCourselist(String userid) {
		return applylistDao.clist(userid);
	}	
	public int getCurseq(String userid, Integer classid,Integer classno) {
		return applylistDao.curseq(userid,classid,classno);
	}


	public List<License> getLicense(String userid) {
		return licenseDao.select(userid);
	}

	public void applyClass(ApplyList apply) {
		applylistDao.insert(apply);
	}


	public List<User> getApplylist(Integer classid, Integer classno) {
		return applylistDao.select(classid,classno);
	}
	public Course getClassDate(Integer classid, Integer classno) {
		return classinfoDao.date(classid,classno);
	}

	public int checkwish(WishList wish) {
		return wishlistDao.checkwish(wish);
	}

	public int classcount(String location1, String location2, Integer type, Integer maxtutee, Integer cate, String text) {
		return classDao.count(location1,location2,type,maxtutee,cate,text);
	}  

	public List<Class> classList(Integer pageNum,Integer sorted, int limit, String location1, String location2, Integer type,
			Integer maxtutee,Integer cate, String text) {
		return classDao.list(pageNum,sorted,limit,location1,location2,type,maxtutee,cate, text);
	}

	public int getReviewcnt(Integer classid) {
		return reviewDao.cnt(classid);
	}

	public void addChat(Chatting chatting) {
		int maxtalk = chattingDao.maxtalk(chatting.getRoomno());
		chatting.setTalkno(++maxtalk);
		chattingDao.insert(chatting);	
	}

	public List<Chatting> chattutee(String userid) {
		return chattingDao.tutee(userid);
	}

	public int newtalk(int roomno, String userid) {
		return chattingDao.newtalk(roomno,userid);
	}

	public List<Chatting> chatlist(Integer roomno) {
		return chattingDao.chatlist(roomno);
	}

	public void readchat(Integer roomno) {
		chattingDao.readchat(roomno);
		
	}


	public int maxroom() {
		return chattingDao.maxroom();
	}

	public int maxClassno(Integer classid) {
		return classinfoDao.maxnum(classid);
	}

	public void firstClassinfo(Classinfo ci) {
		classinfoDao.firstRegister(ci);
	}	
	public void registerClassinfo(Classinfo ci) {
		classinfoDao.register(ci);
	}	
	public Classinfo getClassInfoOne(Integer classid, int classno, int classseq) {
		return classinfoDao.selectOne(classid,classno,classseq);
	}
	
	// tutor : yhl
	public void userUpdate2(User user) {
		userDao.update2(user);
		
	}

	public void classInsert(Class clas, HttpServletRequest request) {
		if(clas.getCoverimgurl() != null && !clas.getCoverimgurl().isEmpty()) {
			uploadFileCreate(clas.getCoverimgurl(),request,"class/coverimg/",clas.getClassid());
			clas.setCoverimg(clas.getCoverimgurl().getOriginalFilename());
		}
		classDao.insert(clas);
	}

	public void licenseInsert(License license, HttpServletRequest request) {
		if(license.getLcfileurl() != null && !license.getLcfileurl().isEmpty()) {
			uploadFileCreate2(license.getLcfileurl(),request,"user/license/",license.getUserid());
			license.setLcfile(license.getLcfileurl().getOriginalFilename());
		}
		licenseDao.insert(license);
	}
	
	public void licenseUpdate(License license, HttpServletRequest request) {
		if(license.getLcfileurl() != null && !license.getLcfileurl().isEmpty()) {
			uploadFileCreate2(license.getLcfileurl(),request,"user/license/",license.getUserid());
			license.setLcfile(license.getLcfileurl().getOriginalFilename());
		}
		licenseDao.update(license);
	}
	
	public void licenseDelete(Integer lcno) {
		licenseDao.delete(lcno);
	}

	public void classUpdate(Class clas, HttpServletRequest request) {
		if(clas.getCoverimgurl() != null && !clas.getCoverimgurl().isEmpty()) {
			uploadFileCreate(clas.getCoverimgurl(),request,"class/coverimg/",clas.getClassid());
			clas.setCoverimg(clas.getCoverimgurl().getOriginalFilename());
		}
		classDao.update(clas);
		
	}
	
	public void classinfoInsert(Classinfo classinfo) {
		classinfoDao.insert(classinfo);
	}

	public void classinfoDelete(Integer cid) {
		classinfoDao.delete(cid);
	}
	
	public List<Classinfo> getClassinfo(Integer cid) {
		return classinfoDao.getclassinfo(cid);
	}
	
	public void userUpdate2(User user,HttpServletRequest request) {
		System.out.println("유저프로필이미지:" + user.getFileurl2());
		System.out.println("유저학력이미지:" + user.getEdufileurl());
		if(user.getFileurl2() != null && !user.getFileurl2().isEmpty()) {
			uploadFileCreate2(user.getFileurl2(),request,"user/save/",user.getUserid());
			user.setFile(user.getFileurl2().getOriginalFilename());
		}
		if(user.getEdufileurl() != null && !user.getEdufileurl().isEmpty()) {
			uploadFileCreate2(user.getEdufileurl(),request,"user/edufile/",user.getUserid());
			user.setEdufile(user.getEdufileurl().getOriginalFilename());
		}
		userDao.update2(user);
		
	}
	
	public int checkClass(String userid) {
		return classDao.checkclass(userid);
	}
	
	private void uploadFileCreate(MultipartFile pictureurl, HttpServletRequest request, String path, int id) {
		String orgFile = id+"_"+pictureurl.getOriginalFilename();
		String uploadPath = request.getServletContext().getRealPath("/") +  path;
	
		File fpath = new File(uploadPath);
		if(!fpath.exists()) fpath.mkdirs();
		try {
			pictureurl.transferTo(new File(uploadPath + orgFile));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void uploadFileCreate2(MultipartFile pictureurl, HttpServletRequest request, String path, String id) {
		String orgFile = id+"_"+pictureurl.getOriginalFilename();
		String uploadPath = request.getServletContext().getRealPath("/") +  path;
	
		File fpath = new File(uploadPath);
		if(!fpath.exists()) fpath.mkdirs();
		try {
			pictureurl.transferTo(new File(uploadPath + orgFile));
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//

	public Integer classTemp(String userid) {
		return classDao.temp(userid);
	}

	public License getLicenseOne(String userid) {
		return licenseDao.selectOne(userid);
	}

	public Integer licenseCnt() {
		return licenseDao.count();
	}

	public int classCnt() {
		return classDao.count2();
	}
	public ApplyList getapply(Integer classid, Integer classno, String userid) {
		return applylistDao.selectOne(classid,classno,userid);
	}

	public List<Class> mainlist(int type) {
		return classDao.mainlist(type);
	}

	public int getroomno(String classid, String userid) {
		return chattingDao.roomno(classid,userid);
	}

	public List<Chatting> getchat(String userid, int type) {
		return chattingDao.getchat(userid,type);
	}

	public Integer maxclassno(String userid, Integer classid) {
		return applylistDao.maxClassno(userid,classid);
	}
	
	public Integer alreadyReview(String userid, Integer classid, Integer classno) {
		return reviewDao.alreadyReview(userid,classid,classno);
	}

	public Date enddate(Integer classid, Integer classno) {
		return classinfoDao.enddate(classid,classno);
	}


	public List<Classinfo> getClassCurri(Integer classid, int totaltime) {
		return classinfoDao.getClassCurri(classid,totaltime);
	}

	public List<Classinfo> getClassSeq(int classid, int classno) {
		return classinfoDao.getClassSeq(classid, classno);
	}

	public int tutornewtalk(int roomno, String userid) {
		return chattingDao.tutornewtalk(roomno,userid);
	}
	public List<Classinfo> getClassCurri(Integer classid, int totaltime) {
		return classinfoDao.getClassCurri(classid,totaltime);
	}

	public List<Classinfo> getClassSeq(int classid, int classno) {
		return classinfoDao.getClassSeq(classid, classno);
	}

	public int tutornewtalk(int roomno, String userid) {
		return chattingDao.tutornewtalk(roomno,userid);
	}
}
