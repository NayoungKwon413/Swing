package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;

import exception.RegisterException;
import logic.Class;
import logic.Classinfo;
import logic.ClassinfoList;
import logic.Course;
import logic.License;
import logic.Review;
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
		logic.Class c = service.getClass(classid);
		
		Course date = service.getClassDate(classid,classno);
		
		mav.addObject("date",date);
		mav.addObject("c",c);
		mav.addObject("applynum",applylist.size());
		mav.addObject("applylist",applylist);
		return mav;
	}
	
	@RequestMapping("my")
	public ModelAndView checkmy(Integer state, HttpSession session) {
		ModelAndView mav = new ModelAndView();	
		User loginUser = (User)session.getAttribute("loginUser");
		List<logic.Class> classlist = service.getClassList(loginUser.getUserid(), state);
		int classcount = service.classCount(loginUser.getUserid(), state);
		mav.addObject("classlist", classlist);
		mav.addObject("classcount", classcount);
		return mav;
	}
	
	@RequestMapping("result")
	public ModelAndView result(Integer state, HttpSession session) {
		ModelAndView mav = new ModelAndView();		
		User loginUser = (User)session.getAttribute("loginUser");
		List<logic.Class> classlist = service.getClassList2(loginUser.getUserid(), state);
		int classcount = service.classCount2(loginUser.getUserid(), state);
		List<Classinfo> classinfolist = service.getClassInfoList(loginUser.getUserid(), state);
		Date today = new Date();
		for(int i=0; i<classlist.size(); i++) {
			logic.Class cl = service.getClass(classlist.get(i).getClassid());
			Date classdate = service.getClDate(cl.getClassid());
			if(classdate.before(today)) {
				service.updateState(loginUser.getUserid(),cl.getClassid());
			}
		}
		mav.addObject("classlist", classlist);
		mav.addObject("classinfolist", classinfolist);
		mav.addObject("classcount", classcount);
		mav.addObject("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		return mav;
	}

	@RequestMapping("classDelete")
	public ModelAndView delete(Integer classid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");
		service.classDelete(loginUser.getUserid(),classid);
		mav.setViewName("redirect:/tutor/my.shop");
		return mav;
	}
	
	@RequestMapping("outcome")
	public ModelAndView outcome(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, Object> map = service.bargraph(loginUser.getUserid());
		List<Integer> pricelist = service.getPriceList(loginUser.getUserid());
		List<Review> starlist = service.getAvgStar(loginUser.getUserid());
		mav.addObject("map", map);
		mav.addObject("pricelist", pricelist);
		mav.addObject("starlist", starlist); 
		return mav;
	}
	
	@RequestMapping("register-class")
	public ModelAndView registerClassView(Integer classid,@ModelAttribute ClassinfoList classinfoList, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			Class c = service.getClass(classid);
			User tutor = service.getUser(c.getUserid());
			String tutorimg = tutor.getFile();
			int classno = service.maxClassno(classid); 
			Classinfo ci = service.getClassInfoOne(classid,classno,1);
			// 현재 클래스 정보 classno가 1이고 해당 클래스의 첫 클래스 정보의 날짜가 null이면 classno 그대로 
			// 아니면 classno 증가
			if(!(classno==1 && ci.getDate()==null)) { 
				classno++;
			} 
			
			mav.addObject("c",c);
			mav.addObject("tutorimg",tutorimg);
			mav.addObject("classinfoList",classinfoList);
			mav.addObject("newclassno",classno);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("registerClassinfo")
	public ModelAndView registerClass(Integer classid, @ModelAttribute ClassinfoList classinfoList, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			for(Classinfo ci : classinfoList.getClassinfos()) {
				if(ci.getDate()!=null) {
					Classinfo ciInfo = service.getClassInfoOne(classid, 1, ci.getClassseq()); // 클래스 제목, 커리 정보 가져오기
					ci.setTitle(ciInfo.getTitle());
					ci.setCurri(ciInfo.getCurri());
					if(ci.getClassno()==1 && ciInfo.getDate()==null) { // 현재 클래스 정보 classno가 1이면 첫등록-> update
						service.firstClassinfo(ci);
					} else{
						service.registerClassinfo(ci);
					}
					service.updateState(ci.getClassid(), 5); // 해당 클래스 state=5로 변경하기 (수업진행중
				}
			}
		} catch(Exception e) {
			throw new RegisterException("수업 등록에 실패하였습니다.","my.shop");
		} 
		throw new RegisterException("해당 수업 정보가 등록되었습니다.","result.shop");
	}
	
	
	
	/* 수업 등록 페이지 접근시 작성 중인 수업 정보가 있는지 확인
	 * 
	 */ 
	@RequestMapping("register")
	public ModelAndView register(HttpSession session, HttpServletRequest request,String cid) {
		ModelAndView mav = new ModelAndView();
		System.out.println(request.getServletContext().getRealPath("/"));
		User loginUser = (User)session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		User user = service.getUser(userid);
		License license = new License();
		try {
			license = service.getLicense(userid).get(0);
		}catch(IndexOutOfBoundsException e) {
		}
		Class clas = new Class();
		
		int classid = 0;
		if( service.classTemp(userid) != null) {
			classid = service.classTemp(userid);
			clas = service.getClass(classid);
		};
		
		System.out.println(user.toString());
		System.out.println(license.toString());
		System.out.println(clas.toString());
		
		mav.addObject("license", license);
		mav.addObject("user",user);
		mav.addObject("clas",clas);
		mav.addObject("cid",classid);
		
		return mav;
	}
	
	/* 수업 등록 
	 1.유저 정보 update 2. 자격증 정보 insert 3. 수업 정보 insert
	*/
	@PostMapping("classEntry")
	public ModelAndView classEntry(User user, License license, Class clas, @RequestParam(name="title") List<String> titlelist,@RequestParam(name="curri") List<String> currilist, String button, Integer cid, Integer numtutee, HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println(request.getServletContext().getRealPath("/"));
		User loginUser = (User)session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		user.setUserid(userid);
		license.setUserid(userid);
		clas.setUserid(userid);
		clas.setTotalprice(clas.getPrice()*clas.getTime()*clas.getTotaltime());
		List<Classinfo> clasinfo = new ArrayList<Classinfo>();
		
		for(int i=0;i<titlelist.size();i++) {
			Classinfo temp = new Classinfo();
			temp.setClassseq(i+1);
			temp.setTitle(titlelist.get(i));
			temp.setCurri(currilist.get(i));
			clasinfo.add(temp);
		}
		System.out.println("모든회차정보:"+clasinfo.toString());
		if(button.equals("임시저장")) {
			user.setKbn(1); // kbn(회원구분정보) : 1. 튜티 , 2.튜터
			clas.setState(1); // state : 1.등록진행중 2.승인대기
			if(clas.getMaxtutee()==2) {
				clas.setMaxtutee(numtutee);
			}
			// 유저 정보 업데이트
			service.userUpdate2(user,request);  
			// 자격증 정보 insert
			int cnt = service.licenseCnt();
			license.setLcno(++cnt);
			service.licenseInsert(license);
			
			if(cid == null) { // 새로 만들어지는 수업이라면 class insert,classinfo insert
				int cnt2 = service.classCnt();
				System.out.println(cnt2);
				cid = cnt2 + 1;
				clas.setClassid(cnt2+1);
				service.classInsert(clas,request);
				
				for(int i=0;i<clasinfo.size();i++) {
					clasinfo.get(i).setClassid(cnt2+1);
					service.classinfoInsert(clasinfo.get(i));
				}
				// classid 알아내서 임시저장시 보내야함
				//cid = service.classTemp(userid);
				//license.setClassid(cid);
				//service.licenseInsert(license);
			}else { // 원래 임시저장된 수업이라면 class update,classinfo delete 후 insert
				clas.setClassid(cid);
				service.classUpdate(clas,request);
				service.classinfoDelete(cid);
				for(int i=0;i<clasinfo.size();i++) {
					clasinfo.get(i).setClassid(cid);
					service.classinfoInsert(clasinfo.get(i));
				}
				//license.setClassid(cid);
				//service.licenseUpdate(license);
			}
			
			System.out.println(user.toString());
			System.out.println(clas.toString());
			System.out.println(license.toString());
			
			mav.setViewName("/alert");
			mav.addObject("msg","임시저장 되었습니다.");
			mav.addObject("url", "register.shop?cid="+cid); 
			return mav;
			
		}else if(button.equals("승인요청")) {
			user.setKbn(2);
			clas.setState(2);
			if(clas.getMaxtutee()==2) {
				clas.setMaxtutee(numtutee);
			}
			
			// 유저 정보 업데이트
			service.userUpdate2(user,request);  
			// 자격증 정보 insert
			int cnt = service.licenseCnt();
			license.setLcno(++cnt);
			service.licenseInsert(license);
			
			if(cid == 0) { // 새로 만들어지는 수업이라면 class insert, classinfo insert
				int cnt2 = service.classCnt();
				cid = cnt2 + 1;
				clas.setClassid(cnt2+1);
				service.classInsert(clas,request);
				
				for(int i=0;i<clasinfo.size();i++) {
					clasinfo.get(i).setClassid(cnt2+1);
					service.classinfoInsert(clasinfo.get(i));
				}
				// classid 알아내서 임시저장시 보내야함
				//cid = service.classTemp(userid);
				//license.setClassid(cid);
				//service.licenseInsert(license);
			}else { // 원래 임시저장된 수업이라면 class update
				clas.setClassid(cid);
				service.classUpdate(clas,request);
				service.classinfoDelete(cid);
				for(int i=0;i<clasinfo.size();i++) {
					clasinfo.get(i).setClassid(cid);
					service.classinfoInsert(clasinfo.get(i));
				}
				//license.setClassid(cid);
				//service.licenseUpdate(license);
			}
			System.out.println(user.toString());
			System.out.println(clas.toString());
			System.out.println(license.toString());
			
			mav.setViewName("/alert");
			mav.addObject("msg","승인요청 되었습니다.");
			mav.addObject("url","my.shop");
			return mav;
		}
		return mav;
	}
}
