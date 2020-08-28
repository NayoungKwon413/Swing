package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.TalkException;
import logic.User;

@Component
@Aspect
public class TalkAspect {
	@Around
	("execution(* controller.talk*.loginCheck*(..)) && args(..,session)")
	public Object LoginCheck(ProceedingJoinPoint joinPoint,HttpSession session) throws Throwable{
		User loingUser = (User)session.getAttribute("loginUser");
		if(loingUser==null) {
			throw new TalkException("로그인 후 이용가능합니다.");
		}
		return joinPoint.proceed();
	}
}
