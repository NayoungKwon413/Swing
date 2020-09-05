package controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Review;
import logic.ShopService;
import logic.User;
import logic.WishList;
import logic.ApplyList;
import logic.Class;
import logic.Classinfo;
import logic.License;

@Controller
@RequestMapping("class")
public class ClassController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*") //  /index.shop 요청시 호출되는 메서드
	public ModelAndView classForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		int type=1;
		try {
			List<Class> hotlist = service.mainlist(type);
			type=2;
			List<Class> latestlist = service.mainlist(type);
			User user = (User)session.getAttribute("loginUser");
			if(user!=null) {
				WishList wish = new WishList();
				for(Class c : hotlist) {
					wish.setUserid(user.getUserid());
					wish.setClassid(c.getClassid());
					c.setWish(service.checkwish(wish));
				}
				for(Class c : latestlist) {
					wish.setUserid(user.getUserid());
					wish.setClassid(c.getClassid());
					c.setWish(service.checkwish(wish));
				}
			}
//			System.out.println(hotlist.get(0).getWish());
			mav.addObject("hotlist", hotlist);
			mav.addObject("latestlist", latestlist);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("review")
	public ModelAndView reviewform(Model model,Integer classid, Integer classno,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Class c = service.getClass(classid);
		model.addAttribute(new Review());
		mav.addObject("subject",c.getSubject());
		return mav;
	}
	
	@PostMapping("review")
	public ModelAndView review(Review review,Integer classid, Integer classno, HttpSession session){
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		review.setUserid(loginUser.getUserid());
		try {
			service.reviewWrite(review);
			System.out.println(review);
			mav.setViewName("redirect:detail.shop?classid="+classid);
			System.out.println("등록성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("등록실패");
		}
		return mav;
	}
	
	@RequestMapping("reviewEdit")
	public ModelAndView reviewEditForm(Integer reviewno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Review review = null;
		Class c = null;
		try {
			review = service.getReviewOne(reviewno);
			c = service.getClass(review.getClassid());
		} catch(Exception e) {
			e.printStackTrace();
		}
	
		mav.addObject("subject",c.getSubject());
		mav.addObject("review",review);
		System.out.println(review);
		return mav;
	}
	
	@PostMapping("reviewEdit")
	public ModelAndView reviewEdit(Review review, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			service.reviewUpdate(review);
			System.out.println(review);
			System.out.println("수정완료");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("등록실패");
		}
	
		return mav;
	}
	
	@RequestMapping("reviewDelete")
	public ModelAndView reviewDelete(Integer reviewno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Review re = service.getReviewOne(reviewno);
		try {
			service.reviewDelete(reviewno);
			
			System.out.println("리뷰삭제완료");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("리뷰삭제실패");
		}
		mav.setViewName("redirect:detail.shop?classid="+ re.getClassid());
		//mav.setViewName("redirect:javascript:Move('review')");
		return mav;
	}
	
	
	@GetMapping("detail")
	public ModelAndView detail(Integer classid, Integer pageNum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum==null||pageNum.toString().equals("")) {
			pageNum=1;
		}
		int limit=10;
		Integer classno=0;
		try {
			Class cls = service.getClass(classid);
			cls.setStaravg(service.getStar(classid));
//			System.out.println(cls.getStaravg());
			cls.setReviewcnt(service.getReviewcnt(classid));
			User user = (User)session.getAttribute("loginUser");
			if(user!=null) {
				WishList wish = new WishList();
				wish.setUserid(user.getUserid());
				wish.setClassid(classid);
				cls.setWish(service.checkwish(wish));
				classno = service.maxclassno(user.getUserid(), classid);
				if(classno==null) {
					classno = 0;
				}
			}
			List<Classinfo> clsinfo = service.getClassInfo(classid);
			List<Classinfo> clscurri = null;
			if(cls.getType()==2) {
				clscurri = service.getClassCurri(classid,cls.getTotaltime());
				for(Classinfo info : clsinfo) {
					info.setList(service.getClassSeq(info.getClassid(),info.getClassno()));
				}
			}
			User tutor = service.getUser(cls.getUserid());
			List<Review> review = service.getReview(classid,pageNum,limit);
			List<License> license = service.getLicense(cls.getUserid());
//			double sum = 0;
			int reviewcnt = cls.getReviewcnt();
			int maxpage = (int)((double)reviewcnt/limit+0.95);
			int startpage =((int)(pageNum/10.0+0.9)-1)*10+1;
			int endpage = startpage+9;
			if(endpage>maxpage) endpage=maxpage;
			
			mav.addObject("classno",classno);
			mav.addObject("reviewcnt",reviewcnt);
			mav.addObject("pageNum",pageNum);  
			mav.addObject("maxpage",maxpage);
			mav.addObject("startpage",startpage);
			mav.addObject("endpage",endpage);
			mav.addObject("clscurri",clscurri);
			mav.addObject("cls",cls);
			mav.addObject("tutor",tutor);
			mav.addObject("clsinfo", clsinfo);
			mav.addObject("review",review);
			mav.addObject("license",license);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("check")
	public ModelAndView loginCheckcheck(Integer classid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			Class cls = service.getClass(classid);
			User tutor = service.getUser(cls.getUserid());			
			List<Classinfo> clsinfo = service.getClassInfo(classid);
			if(cls.getType()==2) {
				for(Classinfo info : clsinfo) {
					info.setList(service.getClassSeq(info.getClassid(),info.getClassno()));
				}
			}
			mav.addObject("cls",cls);
			mav.addObject("tutor",tutor);
			mav.addObject("clsinfo", clsinfo);			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("apply")
	public ModelAndView apply(Integer classid,Integer classno,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			Class cls = service.getClass(classid);
			User tutor = service.getUser(cls.getUserid());	
			User tutee = (User)session.getAttribute("loginUser");
			mav.addObject("cls",cls);
			mav.addObject("tutor",tutor);
			mav.addObject("tutee",tutee);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@RequestMapping("paysuccess")
	public ModelAndView paysuccess(Integer classid,Integer classno,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User tutee = (User)session.getAttribute("loginUser");
		try {
			ApplyList apply = new ApplyList();
			apply.setClassid(classid);
			apply.setClassno(classno);
			apply.setUserid(tutee.getUserid());
			service.applyClass(apply);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="checkwishlist")
	public String checkwishlist(Integer classid,HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		WishList wish = new WishList();
		wish.setUserid(user.getUserid());
		wish.setClassid(classid);
		int check = service.checkwish(wish);
		if(check==1) { //이미 존재하는경우 delete
			service.wishDelete(wish);
			return "1";
		}else {
			service.wishInsert(wish);
			return "0";
		}
	}
	@RequestMapping("classlist")
	public ModelAndView classlist(Integer pageNum, String location1, String location2, Integer type, 
			Integer maxtutee,Integer sorted,Integer cate, String text) {
		ModelAndView mav = new ModelAndView();
		if(pageNum==null||pageNum.toString().equals("")) {
			pageNum=1;
		}
		if(sorted==null||sorted.toString().equals("")) {
			sorted=1;
		}
		if(cate==null||cate.toString().equals("")) {
			cate=null;
		}
		if(location1==null||location1.toString().equals("")) {
			location1=null;
		}
		if(location2==null||location2.toString().equals("")) {
			location2=null;
		}
		if(type==null||type.toString().equals("")) {
			type=null;
		}
		if(maxtutee==null||maxtutee.toString().equals("")) {
			maxtutee=null;
		}
		if(text==null||text.toString().equals("")) {
			text=null;
		}
		try {
			int limit=15;
			int listcount = service.classcount(location1,location2,type,maxtutee,cate,text);
			System.out.println(listcount);
			List<Class> classlist = service.classList(pageNum,sorted,limit,location1,location2,type,maxtutee,cate,text);
//			System.out.println(classlist.get(0).getSubject());
			List<User> tutor = new ArrayList<>();
			for(Class c : classlist) {
				c.setTotaltutee(service.getParticiNum(c.getClassid()));
				c.setStaravg(service.getStar(c.getClassid()));
				c.setReviewcnt(service.getReviewcnt(c.getClassid()));
				tutor.add(service.getUser(c.getUserid()));
			}
			int maxpage = (int)((double)listcount/limit+0.95);
			int startpage =((int)(pageNum/10.0+0.9)-1)*10+1;
			int endpage = startpage+9;
			if(endpage>maxpage) endpage=maxpage;
			int listno = listcount-(pageNum-1)*limit;
			mav.addObject("text",text);
			mav.addObject("pageNum",pageNum);  
			mav.addObject("maxpage",maxpage);
			mav.addObject("startpage",startpage);
			mav.addObject("endpage",endpage);
			mav.addObject("listcount",listcount);
			mav.addObject("classlist",classlist);
			mav.addObject("listno",listno);
			mav.addObject("tutor",tutor);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

//	@PostMapping("searchlist")
//	public ModelAndView classlist(String text) {
//		ModelAndView mav = new ModelAndView();
//		System.out.println("find:"+text);
//		
//		List<Class> classlist = service.searchList(text);
//		List<User> tutor = new ArrayList<>();
//		int listcount = classlist.size();
//		
//		for(Class c : classlist) {
//			try {
//			c.setTotaltutee(service.getParticiNum(c.getClassid()));
//			c.setStaravg(service.getStar(c.getClassid()));
//			c.setReviewcnt(service.getReviewcnt(c.getClassid()));
//			tutor.add(service.getUser(c.getUserid()));
//			}catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		System.out.println("searchList:"+classlist);
//		System.out.println("listcount:"+listcount);
//
//		mav.addObject("listcount",listcount);
//		mav.addObject("classlist",classlist);
//		mav.addObject("tutor",tutor);
//		mav.setViewName("redirect:classlist.shop");
//		return mav;
//	}
	
}
