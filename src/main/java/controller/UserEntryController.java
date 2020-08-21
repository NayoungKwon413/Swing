package controller;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.URL;

import javax.activation.URLDataSource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("user")
public class UserEntryController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*")
	public String userEntryForm(Model model) {
		//email 복호화
		System.out.println("userEntryForm");
		model.addAttribute(new User());
		return null;
	}
	
	@PostMapping("join")
	public ModelAndView userEntry(@Valid User user, HttpServletRequest request,BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		System.out.println(user);
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.user");
			return mav;
		}
		try {
			//1. 비밀번호 : 해쉬알고리즘으로 값을 생성 db에 저장
			//2. 이메일: 암호화하여 db에 저장
			//			키는 userid의 해쉬값의 앞16자리로 설정.
			/*user.setPassword(CipherUtil.makehash(user.getPassword()));
			String userid = CipherUtil.makehash(user.getUserid());
			String email = CipherUtil.encrypt(user.getEmail(), userid.substring(0,16));
			
			user.setEmail(email);*/
		    if(user.getFileurl().length()>0) {
				String path = request.getServletContext().getRealPath("/")+"user/save/";
				System.out.println("path:"+path);
				try {
					    File f = new File(path);
					    if(!f.exists()){
					    	f.mkdirs(); //폴더 생성됨
					    }
					String str = user.getFileurl();
					byte[] imagedata = java.util.Base64.getDecoder().decode(str.substring(str.indexOf(",") + 1));
					BufferedImage bi = ImageIO.read(new ByteArrayInputStream(imagedata));
					
					int width = bi.getWidth();
					int height = bi.getHeight();
					BufferedImage thumb = new BufferedImage
							(width,height,BufferedImage.TYPE_INT_RGB);
					Graphics2D g = thumb.createGraphics();
					g.drawImage(bi,0,0,width,height,null);
					f = new File(path+user.getUserid()+"_"+user.getFile());
					ImageIO.write(thumb,"png",f);
					user.setFileurl("");
					
				}catch(IOException e) {
					e.printStackTrace();
				}
			}			
			service.userInsert(user);
			mav.setViewName("redirect:login.shop");
		}catch(Exception e) {
			e.printStackTrace();
			bresult.reject("error.duplicate.user");
			mav.getModel().putAll(bresult.getModel());
		}
		return mav;
	}
	
	@PostMapping("login")
	public ModelAndView login(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			bresult.reject("error.input.user");
			return mav;
		}
		//1. db 정보의 id,password 비교
		//2. 일치: session loginUser 정보 저장
		//3. 불일치: 비밀번호 확인 내용 출력
		//4. db에 해당 id정보가 없는 경우 내용 출력
		try{
			User dbUser =  service.getUser(user.getUserid());
			//user.getPassword() : 입력된 비밀번호
			/*String password = CipherUtil.makehash(user.getPassword());
			if(password.equals(dbUser.getPassword())) {
				String userid = CipherUtil.makehash(user.getUserid());
				String email = CipherUtil.decrypt(dbUser.getEmail(), userid.substring(0,16));
				dbUser.setEmail(email);
				session.setAttribute("loginUser", dbUser);
				mav.setViewName("redirect:main.shop");
			}else {
				bresult.reject("error.login.password");
			}*/
			session.setAttribute("loginUser", dbUser);
			mav.setViewName("redirect:../class/main.shop");
		}catch(Exception e) {
			e.printStackTrace();
			bresult.reject("error.login.id");
		}
		return mav;
	}
	

	@RequestMapping("logout")
	public ModelAndView loginChecklogout(HttpSession session) {
		ModelAndView mav = new ModelAndView("/alert");
		mav.addObject("msg","로그아웃 되었습니다.");
		mav.addObject("url","/swing/class/main.shop");
		session.invalidate();
		return mav;
	}
	

	@RequestMapping("info")
	public ModelAndView infoform(String id,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(id);
		mav.addObject("user",user);
		return mav;
	}
	
	@PostMapping("updateExcute")
	public ModelAndView update(@Valid User user,BindingResult bresult,HttpServletRequest request,HttpSession session){
		ModelAndView mav = new ModelAndView();
		System.out.println(user);
	    User loginUser = (User)session.getAttribute("loginUser");
	    if(bresult.hasErrors()) {
	       bresult.reject("error.input.user");
	       //return mav;
	    }
	    String password = null;
		try {

		    if(user.getFileurl().length()>0) {
		    	String path = request.getServletContext().getRealPath("/")+"user/save/";
			    File f = new File(path);
			    if(!f.exists()){
		    	f.mkdirs();
					    }
					String str = user.getFileurl();
					byte[] imagedata = java.util.Base64.getDecoder().decode(str.substring(str.indexOf(",") + 1));
					BufferedImage bi = ImageIO.read(new ByteArrayInputStream(imagedata));
					
					int width = bi.getWidth();
					int height = bi.getHeight();
					BufferedImage thumb = new BufferedImage
							(width,height,BufferedImage.TYPE_INT_RGB);
					Graphics2D g = thumb.createGraphics();
					g.drawImage(bi,0,0,width,height,null);
					f = new File(path+user.getUserid()+"_"+user.getFile());
					ImageIO.write(thumb,"png",f);
					user.setFileurl("");
		    }
					
				}catch(IOException e) {
					e.printStackTrace();
				}
		finally {

		      service.userUpdate(user);
			  mav.setViewName("redirect:info.shop?id="+user.getUserid());
		      session.setAttribute("loginUser", user);
		}
	      service.userUpdate(user);
		  mav.setViewName("redirect:info.shop?id="+user.getUserid());
	      session.setAttribute("loginUser", user);
	      return mav;
	   }
	

	@RequestMapping("update")
	public ModelAndView updateform(String id,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(id);
		mav.addObject("user",user);
		return mav;
	}
}