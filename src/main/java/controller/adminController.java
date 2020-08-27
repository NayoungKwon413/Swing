package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;
import logic.User;
import util.CipherUtil;
import logic.Class;
import logic.Classinfo;
import logic.Mail;
import logic.Rank;

@Controller
@RequestMapping("admin")
public class adminController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*") //  /index.shop 요청시 호출되는 메서드
	public ModelAndView adminForm() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("userlist")
	public ModelAndView userList(String pageNum, HttpServletRequest request,HttpSession session, String column, String find) {
		
		ModelAndView mav = new ModelAndView();
		
		int pageNum_=1; //페이지 번호 초기화
	 	try{
	 		pageNum_ = Integer.parseInt(request.getParameter("pageNum"));
	 	}catch(NumberFormatException e ){}
	 	
	 	
	 	if(column==null||column.trim().equals("")) { //column값이 없음
	 		column = null;
	 		find = null;
	 	}
	 	if(find==null || find.trim().equals("")) {
	 		column = null;
	 		find = null;
	 	}
	 	
	 	int tutorcnt = service.getTutorCount();
	 	int tuteecnt = service.getTuteeCount();
	 	List<User> userList = service.userList();
		int usercount = userList.size()+1;
	 	int limit = 5;
		userList.clear();
	 	userList = service.userlist(pageNum_,limit,column,find);
	 	int maxpage = (int)((double)usercount/limit+0.95);
		/*
			startpage : 화면에 출력될 첫번째 페이지 번호
			pageNum : 현재 페이지
		*/
		int startpage = ((int)(pageNum_/10.0+0.9)-1)*10+1; //페이지 시작 번호
		int endpage = startpage+9;//종료 페이지 번호
		if(endpage>maxpage)endpage = maxpage;
		
	 	for(User u : userList) {
	 		try {
	 			String email = CipherUtil.decrypt(u.getEmail(), CipherUtil.makehash().substring(0,16));
	 			u.setEmail(email);
	 			
	 			}catch (Exception e) {
	 				e.printStackTrace();
	 			}	
	 	}
		mav.addObject("list", userList);
		mav.addObject("tutorcnt", tutorcnt);
		mav.addObject("tuteecnt", tuteecnt);
		mav.addObject("usercount", usercount);
		mav.addObject("pageNum", pageNum_);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		return mav;
	}

	@RequestMapping("applylist")
	public ModelAndView applyList(String get,String id,String pageNum,HttpServletRequest request,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		try {
			/*for(User u: userList) {
				String userid = CipherUtil.makehash(u.getUserid());
				String email = CipherUtil.decrypt(u.getEmail(),userid.substring(0,16));
				u.setEmail(email);
			}*/
		}catch(Exception e){
			e.printStackTrace();
		}
		
		int pageNum_=1;
		int limit = 4;
		try{
	 		pageNum_ = Integer.parseInt(pageNum);
	 		
	 	}catch(NumberFormatException e ){}

		int doneCount=0,reCount=0,classCount=0;

		List<Class> classlist;
		int classSize;
		int state = 2;
		
		classlist = service.classlistByState(state);
		classCount = classlist.size();
		doneCount = service.classlistByState(4).size();
		reCount = service.classlistByState(3).size();
		
		if(get.equals("1")) { //승인완료
			state = 4;
		}
		else if(get.equals("2")) { //반려
			state = 3;
		}
		
		classlist = service.classlistByState(state);		
		classSize = classlist.size();
		classlist.clear();
		classlist = service.classlistByState(pageNum_,limit,state);
			
	 	int maxpage = (int)((double)classSize/limit+0.95);
	 	
		int startpage = ((int)(pageNum_/10.0+0.9)-1)*10+1;
		int endpage = startpage+9;
		if(endpage>maxpage)endpage = maxpage;
		
		mav.addObject("list",classlist);
		mav.addObject("classCount", classCount);
		mav.addObject("classSize", classSize);
		mav.addObject("doneCount", doneCount);
		mav.addObject("reCount", reCount);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		return mav;
	}
	
	@RequestMapping("classlist")
	public ModelAndView classList(String get,String id,String pageNum,HttpServletRequest request,HttpSession session) {
ModelAndView mav = new ModelAndView();
		
		try {
			/*for(User u: userList) {
				String userid = CipherUtil.makehash(u.getUserid());
				String email = CipherUtil.decrypt(u.getEmail(),userid.substring(0,16));
				u.setEmail(email);
			}*/
		}catch(Exception e){
			e.printStackTrace();
		}
		
		int pageNum_=1;
		int limit = 4;
		try{
	 		pageNum_ = Integer.parseInt(pageNum);
	 		
	 	}catch(NumberFormatException e ){}

		int doneCount=0,reCount=0,classCount=0;

		List<Class> classlist;
		int classSize;
		int state = 5;
		
		classlist = service.classlistByState(state);
		classCount = classlist.size();
		doneCount = service.classlistByState(6).size();
		
		if(get.equals("1")) { //수업완료
			state = 6;
		}
		
		classlist = service.classlistByState(state);		
		classSize = classlist.size();
		classlist.clear();
		classlist = service.classlistByState(pageNum_,limit,state);
			
	 	int maxpage = (int)((double)classSize/limit+0.95);
	 	
		int startpage = ((int)(pageNum_/10.0+0.9)-1)*10+1;
		int endpage = startpage+9;
		if(endpage>maxpage)endpage = maxpage;
		
		mav.addObject("list",classlist);
		mav.addObject("classCount", classCount);
		mav.addObject("classSize", classSize);
		mav.addObject("doneCount", doneCount);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		return mav;
	}
	
	@PostMapping("chageClassState")
	public ModelAndView changeState(String get,String id,String classid) {
		ModelAndView mav = new ModelAndView();
        int cid = Integer.parseInt(classid);
        service.updateState(cid,4);  
		mav.addObject("get", get);
		mav.addObject("id", id);
		mav.setViewName("redirect:applylist.shop");
		return mav;
	}
	
	
	@PostMapping("reason01")
    public ModelAndView reason1(String id,String classid,String pass,String reason) {
		ModelAndView mav = new ModelAndView();
		try{
			User user = service.getUser(id);
			User admin = service.getUser("admin");
			Mail mail = new Mail();
			mail.setType("반려");
			mail.setReason(reason);
			mail.setRecipient(user.getEmail());
			mail.setNaverid(admin.getEmail());
			mail.setNaverpw(pass);
			
			mail.mailSend(mail);
	
	        int cid = Integer.parseInt(classid);
	        service.updateState(cid,3);  
		}catch (Exception e) {
			e.printStackTrace();
		}

		mav.setViewName("redirect:reason.shop");
		return mav;
    }
		

	@RequestMapping("chart")
	public ModelAndView chartList(HttpServletRequest request,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		List<Integer> list = service.getTotalprice();
		List<Rank> tutor = service.getTutorRank();
		List<Rank> tutee = service.getTuteeRank();
		Map<Object,Object> map = service.graph();
		
		try {
			/*for(User u: userList) {
				String userid = CipherUtil.makehash(u.getUserid());
				String email = CipherUtil.decrypt(u.getEmail(),userid.substring(0,16));
				u.setEmail(email);
			}*/
		}catch(Exception e){
			e.printStackTrace();
		}

		mav.addObject("list", list);
		mav.addObject("tutor", tutor);
		mav.addObject("tutee", tutee); 
		mav.addObject("map",map);

		
		return mav;
	}
	
}
