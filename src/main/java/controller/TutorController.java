package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import logic.Class;
import logic.Course;
import logic.License;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("tutor")
public class TutorController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*") //  /index.shop 요청시 호출되는 메서드
	public ModelAndView tutorForm() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@GetMapping("applylist")
	public ModelAndView applylist(Integer classid, Integer classno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> applylist = service.getApplylist(classid,classno);
		Class c = service.getClass(classid);
		
		Course date = service.getClassDate(classid,classno);
		
		mav.addObject("date",date);
		mav.addObject("c",c);
		mav.addObject("applynum",applylist.size());
		mav.addObject("applylist",applylist);
		return mav;
	}
	
	/* 수업 등록 페이지 접근시 작성 중인 수업 정보가 있는지 확인
	 * 
	 */
	@RequestMapping("register")
	public ModelAndView register(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		int classid = service.checkClass(loginUser.getUserid());
		System.out.println(classid);
		
		if(classid > 0) {
			
		}else {
			return mav;
		}
		
	}
	
	/* 수업 등록 
	 1.유저 정보 update 2. 자격증 정보 insert 3. 수업 정보 insert
	 @RequestParam Map<String,Object> map
	*/
	@PostMapping("classEntry")
	public ModelAndView classEntry(User user, License license, Class clas, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		
		/* 1. 유저 정보 update
		 * : 회원가입시 file 과 겹치는데 어떻게?
		 *   학력 (edulevel) 은 뭐야?
		 */
		user.setUserid(userid);
		service.userUpdate2(user);
		
		/* 2. 자격증 정보 insert
		 * 
		 */
		
		/* 3. 수업 정보 insert
		 * : classid 설정, userid 설정 필요
		 *   readcnt(0), state(1.등록진행중 2.승인대기), regdate(now) 는 쿼리에서 설정
		 */
		clas.setUserid(userid);
		
		service.classInsert(clas);
		return mav;
	}
}
