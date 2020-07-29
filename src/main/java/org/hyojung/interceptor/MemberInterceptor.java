package org.hyojung.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class MemberInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("member interceptor.........");
		
		HttpSession session = request.getSession();
		if(session != null) {
			Object obj = session.getAttribute("user");
			if(obj == null) return true;
		}
		
		log.info("need logout.........");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('잘못된 접근입니다');history.back();</script>");
        out.flush();
        out.close();	
        return false;
	}
}
