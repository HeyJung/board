package org.hyojung.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hyojung.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter{
	
	@Setter(onMethod_ = {@Autowired})
	private MemberService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("auth interceptor.........");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("user");
		
		boolean auth = service.getAuth(id);
		
		if(auth) {
			log.info("auth true.....");
			return true;
		}
		
		log.info("auth false.....");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('이메일 인증이 필요합니다');history.back();</script>");
        out.flush();
        out.close();	
        return false;
	}
}
