package aop;


import java.util.Date;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import exception.LoginException;
import exception.ReviewException;
import logic.ApplyList;
import logic.ShopService;
import logic.User;

@Component
@Aspect
public class TuteeAspect {
	@Autowired
	private ShopService service;
	
	@Around
	("execution(* controller.Tutee*.*(..))")
	public Object TuteeLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		User loginUser  = null;
		for(Object o : joinPoint.getArgs()) {
			if(o instanceof HttpSession) {
				HttpSession session = (HttpSession)o;
				loginUser = (User)session.getAttribute("loginUser");
			}
		}
		if(loginUser==null) { 
			throw new LoginException("로그인 후 조회 가능합니다.","../user/login.shop");
		} 
		Object ret = joinPoint.proceed();
		return ret;
	}
	@Around
	("execution(* controller.Tutee*.*(..)) && args(id,..,session)")
	public Object TuteeAdminCheck(ProceedingJoinPoint joinPoint,HttpSession session, String id) throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser==null) {
			throw new LoginException("로그인 후 조회 가능합니다.","../user/login.shop");
		}else if(!loginUser.getUserid().equals("admin") && !loginUser.getUserid().equals(id)) {
			throw new LoginException("본인 정보만 조회 가능합니다","../class/main.shop");
		}
		return joinPoint.proceed();
	}
	@Around
	("execution(* controller.Class*.review*(..)) && args(..,classid,classno,session)")
	public Object reviewCheck(ProceedingJoinPoint joinPoint,Integer classid, Integer classno, HttpSession session) throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		Date now = new Date();
		
		if(loginUser==null) {
			throw new ReviewException("로그인 후 작성 가능합니다.");
		} else {
			Date enddate = service.enddate(classid,classno);
			if(enddate.after(now)) {
				throw new ReviewException("수강 완료 후 리뷰를 작성해주세요.");
			}
			int cnt = service.alreadyReview(loginUser.getUserid(), classid, classno);
			if(cnt==1) {
				throw new ReviewException("해당 클래스 리뷰를 이미 작성하셨습니다.");
			}
			
		}
		return joinPoint.proceed();
	}
}
