package org.hyojung.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.hyojung.service.MailService;
import org.hyojung.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/email/*")
@Controller
@Log4j
public class EmailController {
	
	@Setter(onMethod_ = @Autowired)
	private MailService service;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberservice;
	
	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		log.info("/email home page");
		
		String id = (String) session.getAttribute("user");
		String email = memberservice.get(id).getEmail();
		
		int random = new Random().nextInt(900000)+100000;
		
		model.addAttribute("random", random);
		model.addAttribute("email", email);
		return "/mypage/email";
	}
	
	@GetMapping("/send")
	@ResponseBody
	public ResponseEntity<String> send(@RequestParam("email") String email,
			@RequestParam("random") int random, HttpSession session){
		log.info("/send");
		int ran = new Random().nextInt(900000) + 100000;
		String authCode = String.valueOf(ran);

		session.setAttribute("authCode", authCode);
		session.setAttribute("pageCode", random);
		
		String subject = "이메일 인증 코드 발급 안내입니다";
		StringBuilder sb = new StringBuilder();
		sb.append("코드번호 ["+authCode+"] 를 입력해주세요");
		
		if(!service.send(subject, sb.toString(), "j3h2j5@gmail.com", email, null)) {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@GetMapping("/auth")
	@ResponseBody
	public ResponseEntity<String> auth(@RequestParam("authCode") String authCode,
			@RequestParam("random") String random, HttpSession session){
		String id = (String) session.getAttribute("user");
		String originalAuthCode = (String) session.getAttribute("authCode");
		String originalPageCode = Integer.toString((int) session.getAttribute("pageCode"));
		
		log.info("/auth :"+id+"  " +authCode+"  " +"random");
		
		if(originalAuthCode.equals(authCode) && originalPageCode.equals(random)) {
			log.info("update auth!");
			memberservice.updateAuth(id);
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		log.info("false auth!");
		return new ResponseEntity<String>("false", HttpStatus.OK);
	}
}
