package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component
@Aspect
public class TutorAspect {
	@Around
	("execution(* controller.Tutor*.*(..))") 
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
	("execution(* controller.Tutor*.*(..)) && args(id,..,session)")
	public Object TuteeAdminCheck(ProceedingJoinPoint joinPoint,HttpSession session, String id) throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser==null) {
			throw new LoginException("로그인 후 조회 가능합니다.","../user/login.shop");
		}else if(!loginUser.getUserid().equals("admin") && !loginUser.getUserid().equals(id)) {
			throw new LoginException("본인 정보만 조회 가능합니다","../class/main.shop");
		}
		return joinPoint.proceed();
	}
}