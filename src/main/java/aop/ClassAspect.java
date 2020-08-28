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
public class ClassAspect {
	@Around
	("execution(* controller.Class*.loginCheck*(..)) && args(..,session)")
	public Object LoginCheck(ProceedingJoinPoint joinPoint,HttpSession session) throws Throwable{
		User loingUser = (User)session.getAttribute("loginUser");
		if(loingUser==null) {
			throw new LoginException("로그인 후 거래하세요","../user/login.shop");
		}
		return joinPoint.proceed();
	}
}
