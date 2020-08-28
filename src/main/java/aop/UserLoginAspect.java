package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component //객체화
@Aspect //AOP 실행 클래스
@Order(1) //AOP 실행 순서
public class UserLoginAspect {
// pointcut : controller 패키지의 User 이름으로 시작하는 클래스.
// 				메서드의 이름이 loginCheck로 시작
//				매개변수는 상관없음
	@Around //기본메서드 실행 전, 후
	("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	//execution(* controller.User*.loginCheck*(..)) 이 방식으로는 session 매개변수 전달이 안되서
	//  && args(..,session) : 마지막 매개변수가 session인 메서드
	public Object userLoginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable{
		User loingUser = (User)session.getAttribute("loginUser");
		if(loingUser==null) {
			throw new LoginException("로그인 후 거래하세요","login.shop");
		}
		return joinPoint.proceed();
	}
	
	@Around
	("execution(* controller.User*.*(..)) && args(id,session)")
	public Object adminCheck(ProceedingJoinPoint joinPoint,
			HttpSession session, String id) throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		
		if(loginUser==null) {
			throw new LoginException("로그인 후 거래하세요","login.shop");
		}else if(!loginUser.getUserid().equals("admin") && !loginUser.getUserid().equals(id)) {
			throw new LoginException("본인 정보만 조회 가능합니다","../class/main.shop");
		}
		return joinPoint.proceed();
	}
}