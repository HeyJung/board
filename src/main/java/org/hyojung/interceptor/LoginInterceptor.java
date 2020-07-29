package org.hyojung.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("login interceptor.........");
		
		HttpSession session = request.getSession();
		if(session != null) {
			Object obj = session.getAttribute("user");
			if(obj != null) return true;
		}
		
		log.info("need login.........");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('로그인이 필요한 서비스입니다');location.href='/member/login';</script>");
        out.flush();
        out.close();	
        return false;
	}
}
