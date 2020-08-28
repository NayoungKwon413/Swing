package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
import util.CipherUtil;

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
		for(User u : applylist) {
	          try {
	             String email = CipherUtil.decrypt(u.getEmail(), CipherUtil.makehash().substring(0,16));
	             u.setEmail(email);
	             
	             }catch (Exception e) {
	                e.printStackTrace();
	             }   
	       }
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
//		System.out.println(classcount);
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
			if(!(classno==1 && ci.getPlace()==null)) { 
				classno++;
			} 
			System.out.println(classno);
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
	 */
	@RequestMapping("register")
	public ModelAndView register(Integer cid, HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println(request.getServletContext().getRealPath("/"));
		User loginUser = (User)session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		List<License> lclist = service.getLicense(userid);
		Class clas = new Class();
		List<Classinfo> classinfo = new ArrayList<Classinfo>();
		System.out.println("받은 cid:"+cid);
		// cid없이 새 등록 -> user,license 는 userid 꺼 불러와 class빈 객체 등록
		if(cid==null) {
			try {
				int cidtemp = service.checkClass(userid);
				System.out.println("등록진행중수업확인:"+cidtemp);
				if(cidtemp!=0) {
					mav.setViewName("/alert");
					mav.addObject("msg","등록진행 중인 수업이 있습니다.");
					mav.addObject("url", "register.shop?cid="+cidtemp); 
				}
			}catch(Exception e) {
				System.out.println("예외처리");
				e.printStackTrace();
			}
		}
		// 반려목록,등록진행중목록 -> user,license userid 불러와  class, classinfo cid 인 객체 불러와
		if(cid!=null) {
			loginUser = service.getUser(userid);
			clas = service.getClass(cid);
			classinfo = service.getClassinfo(cid);
			mav.addObject("cid",cid);
			System.out.println("전달한 cid:"+cid);
		}
		
		mav.addObject("lclist", lclist);
		mav.addObject("user",loginUser);
		mav.addObject("clas",clas);
		mav.addObject("classinfo",classinfo);
		System.out.println("전달한 license:"+lclist.toString());
		System.out.println("전달한 user:"+loginUser.toString());
		System.out.println("전달한 class:"+clas.toString());
		System.out.println("전달한 classinfo:"+classinfo.toString());
		
		return mav;
	}
	
	/* 수업 등록 
	 1.유저 정보 update 2. 자격증 정보 insert 3. 수업 정보 insert
	*/
	@PostMapping("classEntry")
	public ModelAndView classEntry(User user, License license, Class clas, Integer cid, @RequestParam(name="title") List<String> titlelist,@RequestParam(name="curri") List<String> currilist, Integer numtutee, HttpSession session, HttpServletRequest request) {
		String kbn = request.getParameter("kbn");
		ModelAndView mav = new ModelAndView();
		System.out.println(request.getServletContext().getRealPath("/"));
		User loginUser = (User)session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		user.setUserid(userid);
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
		System.out.println("cid:"+cid);

		if(kbn.equals("1")) {
			user.setKbn(1); // kbn(회원구분정보) : 1. 튜티 , 2.튜터
			clas.setState(1); // state : 1.등록진행중 2.승인대기
			if(clas.getMaxtutee()==2) {
				clas.setMaxtutee(numtutee);
			}
			// 유저 정보 업데이트
			service.userUpdate2(user,request);  
			// 자격증 정보 insert
			
			for(int i=0;i<license.getLctitlelist().size();i++) {
				License temp = new License();
				temp.setUserid(userid);
				if(license.getLcnolist().get(i) != 0) { //update
					temp.setLcno(license.getLcnolist().get(i));
					temp.setLctitle(license.getLctitlelist().get(i));
					temp.setLcfileurl(license.getLcfilelist().get(i));
					service.licenseUpdate(temp,request);
					System.out.println("저장된"+temp.toString());
				}else if(license.getLcnolist().get(i) == 0){ //insert
					
					int cnt = service.licenseCnt();
					temp.setLcno(++cnt); 
					temp.setLctitle(license.getLctitlelist().get(i));
					temp.setLcfileurl(license.getLcfilelist().get(i));
					service.licenseInsert(temp,request);
					System.out.println("저장된"+temp.toString());
				}
			}
			
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
			
			System.out.println("저장된"+user.toString());
			System.out.println("저장된"+clas.toString());
			
			
			mav.setViewName("/alert");
			mav.addObject("msg","임시저장 되었습니다.");
			mav.addObject("url", "register.shop?cid="+cid); 
			return mav;
			
		}else if(kbn.equals("2")) {
			user.setKbn(2);
			clas.setState(2);
			if(clas.getMaxtutee()==2) {
				clas.setMaxtutee(numtutee);
			}
			
			// 유저 정보 업데이트
			service.userUpdate2(user,request);  
			// 자격증 정보 insert
			for(int i=0;i<license.getLctitlelist().size();i++) {
				License temp = new License();
				temp.setUserid(userid);
				if(license.getLcnolist().get(i) != 0) { //update
					temp.setLcno(license.getLcnolist().get(i));
					temp.setLctitle(license.getLctitlelist().get(i));
					temp.setLcfileurl(license.getLcfilelist().get(i));
					service.licenseUpdate(temp,request);
					System.out.println("저장된"+temp.toString());
				}else if(license.getLcnolist().get(i) == 0){ //insert
					
					int cnt = service.licenseCnt();
					temp.setLcno(++cnt);
					temp.setLctitle(license.getLctitlelist().get(i));
					temp.setLcfileurl(license.getLcfilelist().get(i));
					service.licenseInsert(temp,request);
					System.out.println("저장된"+temp.toString());
				}
			}
			
			if(cid == null) { // 새로 만들어지는 수업이라면 class insert, classinfo insert
				int cnt2 = service.classCnt();
				cid = cnt2 + 1;
				clas.setClassid(cnt2+1);
				service.classInsert(clas,request);
				
				for(int i=0;i<clasinfo.size();i++) {
					clasinfo.get(i).setClassid(cnt2+1);
					service.classinfoInsert(clasinfo.get(i));
				}
				
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
			System.out.println("저장된"+user.toString());
			System.out.println("저장된"+clas.toString());
			
			mav.setViewName("/alert");
			mav.addObject("msg","승인요청 되었습니다.");
			mav.addObject("url","my.shop");
			return mav;
		}
		return mav;
	}
	
	@RequestMapping("detail")
	public ModelAndView detail(HttpSession session){
		ModelAndView mav = new ModelAndView();
		mav.addObject(session);
		return mav;
	}
	
}
