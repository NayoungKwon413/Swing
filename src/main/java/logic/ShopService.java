package logic;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public List<User> userlist(int pageNum, int limit, String column, String find) {
		return userDao.list(pageNum,limit,column,find);
	}

	public void userUpdate(User user) {
		userDao.update(user);
	}
	
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

	public List<Review> getReview(Integer classid) {
		return reviewDao.select(classid);
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

	public int classcount(String location1, String location2, Integer type, Integer maxtutee, Integer cate) {
		return classDao.count(location1,location2,type,maxtutee,cate);
	}

	public List<Class> classList(Integer pageNum,Integer sorted, int limit, String location1, String location2, Integer type,
			Integer maxtutee,Integer cate) {
		return classDao.list(pageNum,sorted,limit,location1,location2,type,maxtutee,cate);
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
	//
	public int checkClass(String userid) {
		return classDao.checkclass(userid);
	}
	public void userUpdate2(User user) {
		userDao.update2(user);
		
	}

	public void classInsert(Class clas) {
		classDao.insert(clas);
	}

	public void licenseInsert(License license) {
		licenseDao.insert(license);
	}

	public void classUpdate(Class clas) {
		classDao.update(clas);
		
	}

	public Integer classTemp(String userid) {
		return classDao.temp(userid);
	}

	public License getLicenseOne(String userid) {
		return licenseDao.selectOne(userid);
	}

	public int licenseCnt() {
		return licenseDao.count();
	}

	public int classCnt() {
		return classDao.count2();
	}
	public ApplyList getapply(int classid, String userid) {
		return applylistDao.selectOne(classid,userid);
	}

	public List<Class> mainlist(int type) {
		return classDao.mainlist(type);
	}
	

	

}
