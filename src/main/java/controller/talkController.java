package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.support.SecurityContextProvider;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Chatting;
import logic.ShopService;
import logic.User;
import logic.Class;

@Controller
@RequestMapping("talk")
public class talkController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*") //  /index.shop 요청시 호출되는 메서드
	public ModelAndView talkForm() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	@RequestMapping("mainTutee")
	public ModelAndView mainTutee(String userid) {
		ModelAndView mav = new ModelAndView();
		int tuteecnt=0;
		int type=0;
		try {
			List<Chatting> chat = service.getchat(userid,type);
			for(Chatting ch : chat) {
				ch.setNewtalk(service.tuteenewtalk(ch.getRoomno(),userid));
				tuteecnt+=ch.getNewtalk();
			}
			int tutorcnt=service.tutornewtalk(0,userid);
			mav.addObject("chat",chat);
			mav.addObject("tutorcnt",tutorcnt);
			mav.addObject("tuteecnt",tuteecnt);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	@RequestMapping("mainTutor")
	public ModelAndView mainTutor(String userid) {
		ModelAndView mav = new ModelAndView();
		int tutorcnt=0;
		int type=1;
		try {
			List<Chatting> chat = service.getchat(userid,type);
			for(Chatting ch : chat) {
				ch.setNewtalk(service.tutornewtalk(ch.getRoomno(),userid));
				tutorcnt+=ch.getNewtalk();
			}
			int tuteecnt=service.tuteenewtalk(0, userid);
			mav.addObject("chat",chat);
			mav.addObject("tutorcnt",tutorcnt);
			mav.addObject("tuteecnt",tuteecnt);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@RequestMapping("detail")
	public ModelAndView detail(Integer roomno, Integer classid, Integer newtalk, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		if(newtalk==null||newtalk.toString().equals("")) {
			newtalk=null;
		}else if(newtalk>0) {
			service.readchat(roomno);
		}
		try {
			List<Chatting> chat = service.chatlist(roomno);
			mav.addObject("chat",chat);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("user name:"+ user.getUserid());
		System.out.println("normal chat page");
		mav.addObject("sessionuser",user);
		return mav;
	}
	@ResponseBody
	@RequestMapping(value="talkClose")
	public String talkClose(String TotalJson,Integer roomno, Integer classid, HttpSession session) throws ParseException, java.text.ParseException {
		System.out.println(TotalJson);
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject)jsonParser.parse(TotalJson);
		JSONArray jsonArr = (JSONArray)jsonObj.get("talk");
		System.out.println(jsonArr.toString());
		User user = (User)session.getAttribute("loginUser");
		try {
			for(int i=0; i<jsonArr.size(); i++) {
				JSONObject jsonObject = (JSONObject)jsonArr.get(i);
				System.out.println(jsonObject.toString());
				String chat = jsonObject.get("message").toString();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				Date date = format.parse(jsonObject.get("date").toString());
				Chatting chatting = new Chatting();
				chatting.setChat(chat);
				chatting.setChatdate(date);
				chatting.setClassid(classid);
				chatting.setRoomno(roomno);
				chatting.setReadcheck(1);
				chatting.setUserid(user.getUserid());
				service.addChat(chatting);
			}
			return "1";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "0";
	}
	  
	@RequestMapping("newchat")
	public ModelAndView newchat(String classid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int roomno = 0;
		try {
			roomno = service.getroomno(classid,user.getUserid());
			mav.setViewName("redirect:detail.shop?roomno="+roomno+"&classid="+classid);
			return mav;
		}catch(Exception e) {
			e.printStackTrace();
		}
		int max = service.maxroom();
		roomno = ++max;
		mav.setViewName("redirect:detail.shop?roomno="+roomno+"&classid="+classid);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="check")
	public String check(String userid) {
		int tuteecnt = service.tuteenewtalk(0,userid);
		int tutorcnt = service.tutornewtalk(0, userid);
		return tuteecnt+","+tutorcnt;
	}  
	
}
