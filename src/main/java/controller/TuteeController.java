package controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.Course;
import logic.ShopService;
import logic.User;
import logic.WishList;

@Controller
@RequestMapping("tutee")
public class TuteeController {
	@Autowired
	private ShopService service;

	@RequestMapping("*") // /index.shop 요청시 호출되는 메서드
	public ModelAndView tuteeForm() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	/* 위시리스트 */
	@RequestMapping("wishAdd") // 위시리스트 추가
	public ModelAndView wishAdd(Integer classid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		WishList wish = new WishList();
		User user = (User) session.getAttribute("loginUser");
		String userid = user.getUserid();
		wish.setUserid(userid);
		wish.setClassid(classid);
		service.wishInsert(wish);
		return mav;
	}

	@RequestMapping("wishlist") // 위시리스트 조회
	public ModelAndView wishlist(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		String userid = user.getUserid();
		List<WishList> wishlist = service.getWishlist(userid);
		for (WishList w : wishlist) {
			w.setStartdate(service.getStartDate(w.getClassid())); // 수업시작일
			w.setParticinum(service.getParticiNum(w.getClassid())); // 참여인원
			w.setStar(service.getStar(w.getClassid())); // 리뷰별점
			w.setReviewnum(service.getReviewcnt(w.getClassid())); // 리뷰갯수
		}
		int wishnum = wishlist.size();

		mav.addObject("wishlist", wishlist);
		mav.addObject("wishnum", wishnum);
		return mav;
	}

	@RequestMapping("wishDelete") // 위시리스트 삭제
	public ModelAndView wishDelete(Integer classid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		String userid = user.getUserid();
		WishList wish = new WishList();
		wish.setUserid(userid);
		wish.setClassid(classid);
		service.wishDelete(wish);
		mav.setViewName("redirect:wishlist.shop");
		return mav;
	}

	/* 수강목록 */
	@RequestMapping("classlist")
	public ModelAndView classlist(String userid,Integer state, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			List<Course> list = service.getCourselist(userid);
			Date now = new Date();
			List<Course> classlist = new ArrayList<Course>();
			for (Course c : list) {
				c.setStar(service.getStar(c.getClassid()));
				c.setreviewnum(service.getReviewcnt(c.getClassid()));
				if (state == 1) {
					c.setClassseq(service.getCurseq(userid,c.getClassid(),c.getClassno()));
					if (c.getEnddate().after(now)) {
						classlist.add(c);
					}
				} else if (state == 2) {
					if (c.getEnddate().before(now)) {
						classlist.add(c);
					}
				}
			}
			int classnum = classlist.size();
			mav.addObject("state", state);
			mav.addObject("userid", userid);
			mav.addObject("classlist", classlist);
			mav.addObject("classnum", classnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
}
