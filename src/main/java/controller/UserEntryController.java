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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Mail;
import logic.ShopService;
import logic.User;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserEntryController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*")
	public String userEntryForm(Model model) {
		//email 복호화
		model.addAttribute(new User());
		return null;
	}
	
	@PostMapping("join")
	public ModelAndView userEntry(@Valid User user, BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.user");
			return mav;
		}
		
		User dbUser = null;
		try{
			dbUser = service.getUser(user.getUserid());
			
			if(dbUser.getUserid().length()>0) {
				bresult.reject("error.input.alreadyid");
				return mav;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			if(user.getEmail().equals("")||user.getEmail()==null) {
				bresult.reject("error.required.email");
				return mav;
			}
			
			String e = CipherUtil.encrypt(user.getEmail(), CipherUtil.makehash().substring(0,16));
			
			dbUser = service.getUserByEmail(e);
			
			if(dbUser.getEmail().equals(e)) {
				bresult.reject("error.input.alreadyemail");
				return mav;				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			if(!user.getPass().equals(user.getPass1())) {
				bresult.reject("error.required.passcheck");
				return mav;				
			}
			user.setPass(CipherUtil.makehash(user.getPass()));
			String email = CipherUtil.encrypt(user.getEmail(), CipherUtil.makehash().substring(0,16));
			
			user.setEmail(email);
			
			try {

				String path = request.getServletContext().getRealPath("/")+"user/save/";
				
				File f = new File(path);
			    if(!f.exists()){
			    	f.mkdirs(); //폴더 생성됨
			    }
			    
			    BufferedImage bi = null;
			    
			    if(user.getFileurl().length()>0) {
			    	String str = user.getFileurl();
					byte[] imagedata = java.util.Base64.getDecoder().decode(str.substring(str.indexOf(",") + 1));
					bi = ImageIO.read(new ByteArrayInputStream(imagedata));
			    }else {
			    	bi = ImageIO.read(new File("../assets/img/icon/back.png"));
			    }
			    		
				int width = bi.getWidth();
				int height = bi.getHeight();
				BufferedImage thumb = new BufferedImage
						(width,height,BufferedImage.TYPE_INT_RGB);
				Graphics2D g = thumb.createGraphics();
				g.drawImage(bi,0,0,width,height,null);
				f = new File(path+user.getUserid()+"_"+user.getFile());
				ImageIO.write(thumb,"png",f);
				user.setFileurl("");
			    
			}catch (Exception e) {
				e.printStackTrace();
			}
		    
			service.userInsert(user);
			
		}catch(Exception e) {
			e.printStackTrace();
			bresult.reject("error.duplicate.user");
			mav.getModel().putAll(bresult.getModel());
		}
		

		mav.setViewName("/alert");
		mav.addObject("msg",user.getUserid()+"님 회원가입이 완료되었습니다. 로그인후 이용하세요.");
		mav.addObject("url","/swing/class/main.shop");
		return mav;
	}

	@PostMapping("password")
	public ModelAndView password(String userid, String oldpass, String pass, String pass1, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//비밀번호 검증
		User loginUser = (User)session.getAttribute("loginUser");
		//로그인한 정보의 비밀번호와 입력된 비밀번호 검증
		
		try {
			if(!CipherUtil.makehash(oldpass).equals(loginUser.getPass())) {
				throw new LoginException("비밀번호를 확인해주세요","password.shop?id="+userid);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		if(!pass.equals(pass1)) {
			throw new LoginException("비밀번호가 같지않습니다","password.shop?id="+userid);
		}
		try {
			User user = service.getUser(userid);
			user.setPass(CipherUtil.makehash(pass));
	         service.userUpdate(user);
		}catch(Exception e){
			e.printStackTrace();
			throw new LoginException("오류가 발생했습니다. 전산부로 문의해주세요","password.shop?id="+userid);
		}

		//mav.addObject("userid",userid);

		mav.setViewName("/alert");
		mav.addObject("msg",userid+"님의 비밀번호가 변경 되었습니다.");
		mav.addObject("url","/swing/user/password.shop?id="+userid);
     	return mav;
	}
	
	@PostMapping("login")
	public ModelAndView login(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		try{
			User dbUser =  service.getUser(user.getUserid());
			String password = CipherUtil.makehash(user.getPass());
			if(password.equals(dbUser.getPass())) {
				String email = CipherUtil.decrypt(dbUser.getEmail(), CipherUtil.makehash().substring(0,16));
				dbUser.setEmail(email);
				session.setAttribute("loginUser", dbUser);
				mav.setViewName("redirect:../class/main.shop");
			}else {
				bresult.reject("error.login.password");
				return mav;
			}
			session.setAttribute("loginUser", dbUser);
		}catch(Exception e) {
			e.printStackTrace();
			bresult.reject("error.login.id");
			return mav;
		}

		mav.setViewName("/alert");
		mav.addObject("msg",user.getUserid()+"님 로그인 되었습니다.");
		mav.addObject("url","/swing/class/main.shop");
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
		try {
		String email = CipherUtil.decrypt(user.getEmail(), CipherUtil.makehash().substring(0,16));
		user.setEmail(email);
		}catch (Exception e) {
			e.printStackTrace();
		}	
		mav.addObject("user",user);
		return mav;
	}
	
	@GetMapping(value= {"update","delete"})
	   public ModelAndView checkview(String id, HttpSession session) {
	      ModelAndView mav = new ModelAndView();
	      User user = service.getUser(id);
	      try {
	         //키값
	         String email = CipherUtil.decrypt(user.getEmail(),CipherUtil.makehash().substring(0, 16));
	         user.setEmail(email);
	         user.setPass(null);
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      mav.addObject("user",user);
	      return mav;
	   }

	@PostMapping("delete")
	public ModelAndView delete(String userid, String password, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//비밀번호 검증
		User loginUser = (User)session.getAttribute("loginUser");
		//로그인한 정보의 비밀번호와 입력된 비밀번호 검증
		if(userid.equals("admin")) {
			throw new LoginException("관리자 탈퇴는 불가능합니다", "main.shop");
		}
		try {
			password = CipherUtil.makehash(password);
		}
		catch(Exception e1) {
			e1.printStackTrace();
		}
		if(!password.equals(loginUser.getPass())) {
			throw new LoginException("비밀번호를 확인해주세요","delete.shop?id="+userid);
		}
		
		try {
		 service.deleteUser(userid);
		}catch(Exception e){
			e.printStackTrace();
			throw new LoginException("회원 탈퇴 시 오류가 발생했습니다. 전산부로 문의해주세요","delete.shop?id="+userid);
		}
		
		if(loginUser.getUserid().equals("admin")) {
			 mav.setViewName("redirect:/class/main.shop");		
		 }else {//일반사용자가 탈퇴시
			 session.invalidate();//로그아웃
				throw new LoginException(userid+"회원님. 탈퇴 되었습니다.","login.shop");
		 }		 
		 return mav;
	}
	
	@RequestMapping("update")
	public ModelAndView updateform(@Valid User user,BindingResult bresult,HttpServletRequest request,HttpSession session){
		ModelAndView mav = new ModelAndView();
	      User loginUser = (User)session.getAttribute("loginUser");
	     
	      String password = null;
	      try {
	         password = CipherUtil.makehash(user.getPass());
	         
	         if(!password.equals(loginUser.getPass())) {
	            bresult.reject("error.login.password");
	            return mav;
	         }
	    	 
	         user.setPass(password);
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      try {
	         String email = CipherUtil.encrypt(user.getEmail(),CipherUtil.makehash().substring(0,16));
	         user.setEmail(email);
	         
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
	 			  mav.setViewName("redirect:info.shop?id="+user.getUserid());
	// 		      session.setAttribute("loginUser", user);
	 		}

	         service.userUpdate(user);
	         mav.setViewName("redirect:info.shop?id="+user.getUserid());
	         if(loginUser.getUserid().equals(user.getUserid())) {
	            user.setEmail(CipherUtil.decrypt(email, CipherUtil.makehash().substring(0, 16)));
//	            session.setAttribute("loginUser", user);
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	         bresult.reject("error.user.update");
	      }
	      return mav;
	}
	
	
	
	@PostMapping("findid")
	public ModelAndView findid(String email,HttpServletRequest request,HttpSession session){
		ModelAndView mav = new ModelAndView();
		String id="";
		try{
			 String e = CipherUtil.encrypt(email, CipherUtil.makehash().substring(0,16));
			User user = service.getUserByEmail(e);
			id = user.getUserid();
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:find.shop?userid="+id);
	    return mav;
	   }
	

	
	@PostMapping("findpw")
	public ModelAndView findpw(String id,String email,String pass,HttpServletRequest request,HttpSession session){
		ModelAndView mav = new ModelAndView();
		try{
			if(id.equals("")||id.equals(null)||email.equals("")||email.equals(null)) {
				request.setAttribute("msg", "입력");
				mav.setViewName("redirect:find.shop?email="+email);
			    return mav;
			}
			
			User user = service.getUser(id);
			if(user.getEmail().equals(email)) {
				User admin = service.getUser("admin");
				Mail mail = new Mail();
				String randompass = getRamdomPassword();
				user.setPass(randompass);
				mail.setType("비밀번호찾기");
				mail.setReason(randompass);
				mail.setRecipient(user.getEmail());
				mail.setNaverid(admin.getEmail());
				mail.setNaverpw(pass);
				mail.mailSend(mail);
				service.userUpdate(user);				
				mail.mailSend(mail);
		
			}
			else {
				//에러처리
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:find.shop?email="+email);
	    return mav;
	   }
	
	public static String getRamdomPassword() {
		int len = 8;
		char[] charSet = new char[] { 
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
				'U', 'V', 'W', 'X', 'Y', 'Z' }; 
		int idx = 0; StringBuffer sb = new StringBuffer(); 
		for (int i = 0; i < len; i++) { 
			idx = (int) (charSet.length * Math.random());
			sb.append(charSet[idx]); 
			} 
		return sb.toString(); 
	}
}