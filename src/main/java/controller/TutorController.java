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
	
	@GetMapping("register")
	public ModelAndView register(HttpSession session) {
		
	}
	
	/* 수업 등록 
	 1.유저 정보 update 2. 자격증 정보 insert 3. 수업 정보 insert
	 @RequestParam Map<String,Object> map
	*/
	@PostMapping("classEntry")
	public ModelAndView classEntry(User user, License license, Class clas, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		
		//3. 수업 정보
		// classid 설정
		// userid 설정
		// readcnt(0), state(1.등록진행중 2.승인대기), regdate(now)
		clas.setUserid(userid);
		service.classInsert(clas);
		return mav;
	}
}
