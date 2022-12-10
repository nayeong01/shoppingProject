package org.zerock.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.zerock.domain.MemberVO;

public class AdminInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler) throws Exception{
		
		HttpSession session = request.getSession();
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		
		if(vo == null || vo.getAdminCk() == 0) {	//관리자 계정 아닌 경우
			
			response.sendRedirect("/");		//메인페이지로 Redirect
			
			return false;
		}
		return true;	//관리자 계정 로그인 경우
	}

}
