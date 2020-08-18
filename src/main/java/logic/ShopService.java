package logic;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ApplyListDao;
import dao.ClassDao;
import dao.ClassInfoDao;
import dao.LicenseDao;
import dao.ReviewDao;
import dao.UserDao;
import dao.WishlistDao;

@Service
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ClassDao classDao;
	@Autowired
	private ClassInfoDao classInfoDao;
	@Autowired
	private WishlistDao wishlistDao;
	@Autowired
	private LicenseDao licenseDao;
	@Autowired
	private ApplyListDao applylistDao;

	
	public List<User> userList() {
		return userDao.list();
	}
	
	public void userInsert(User user) {		
		userDao.insert(user);
	}
	public User getUser(String userid) {
		return userDao.selectOne(userid);
	}

	public List<User> userlist() {
		return userDao.list();
	}

	public void userUpdate(User user) {
		userDao.update(user);
	}
	
	public void reviewWrite(Review review) {
		int max = reviewDao.maxnum();
		review.setReviewno(++max);
		reviewDao.insert(review);
	}
	public Class getClass(Integer classid) {
		return classDao.selectOne(classid);
	}

	public List<Classinfo> getClassInfo(Integer classid) {
		return classInfoDao.select(classid);
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
	public int getStar(Integer classid) {
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
	public int getCurseq(String userid, Integer applyno) {
		return applylistDao.curseq(userid,applyno);
	}

	public List<License> getLicense(String userid) {
		return licenseDao.select(userid);
	}

	public void applyClass(ApplyList apply) {
		int maxnum = applylistDao.maxnum();
		apply.setApplyno(++maxnum);
		applylistDao.insert(apply);
	}

	public List<User> getApplylist(Integer classid, Integer classno) {
		return applylistDao.select(classid,classno);
	}
	public Course getClassDate(Integer classid, Integer classno) {
		return classInfoDao.date(classid,classno);
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

	
}
