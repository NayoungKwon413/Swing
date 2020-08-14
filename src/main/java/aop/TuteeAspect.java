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
public class TuteeAspect {
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
}
