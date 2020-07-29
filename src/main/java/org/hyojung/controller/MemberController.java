package org.hyojung.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Select;
import org.hyojung.domain.MemberVO;
import org.hyojung.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_ = {@Autowired})
	private MemberService service;
	
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder pwEncoder;
	
	//회원가입
	@GetMapping("/register")
	public void register() {
		log.info("/member/register");
	}
	
	@PostMapping("/register")
	public String register(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		log.info("/member/register :"+vo);
		String pw = vo.getPw();
		String encodePw = pwEncoder.encode(pw);
		vo.setPw(encodePw);
		
		service.register(vo);
		
		session.setAttribute("user", vo.getId());
		rttr.addAttribute("email", vo.getEmail());
		return "redirect:/email/home";
	}
	
	//아이디 중복 확인
	@GetMapping("/registerAjax")
	@ResponseBody
	public ResponseEntity<String> checkId(String id){
		log.info("/registerAjax :"+id);
		String idok = "Y";
		if(service.checkId(id) > 0) {
			idok = "N";
		}
		return new ResponseEntity<String>(idok, HttpStatus.OK);
	}
	
	//로그인
	@GetMapping("/login")
	public void login() {
		log.info("/login");
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("id")String id, @RequestParam("pw")String pw,
			RedirectAttributes rttr, HttpSession session) {
		log.info("/login :"+id+pw);
		String dbPw = service.login(id);
		
		log.info("find pw by id......"+dbPw);
		if(dbPw == null) {
			log.info("존재하지 않는 아이디......");
			rttr.addFlashAttribute("falseMsg", "0");
			rttr.addFlashAttribute("inputid", id);
			return "redirect:/member/login";
		}
		else if(!pwEncoder.matches(pw, dbPw)) {
			log.info("아이디 비밀번호 불일치......");
			rttr.addFlashAttribute("falseMsg", "1");
			rttr.addFlashAttribute("inputid", id);
			return "redirect:/member/login";
		}
		
		log.info("로그인 성공......");
		session.setAttribute("user", id);
		rttr.addFlashAttribute("welcome", "환영합니다");
		return "redirect:/board/list";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("/logout");
		session.invalidate();
		return "redirect:/member/login";
	}
	
	//마이페이지
	@GetMapping("/mypage/home")
	public String mypage(Model model, HttpSession session) {
		log.info("/mypage/home");
		String id = (String) session.getAttribute("user");
		model.addAttribute("userinfo", service.get(id));
		
		return "/mypage/home";
	}
	//회원정보 수정
	@GetMapping("/mypage/update")
	public String update(HttpSession session, Model model) {
		log.info("/update");
		String loginId = (String) session.getAttribute("user");
		
		model.addAttribute("userinfo", service.get(loginId));
		
		return "/mypage/update";
	}
	@PostMapping("/mypage/update")
	public String update(MemberVO vo, String originalPw,
			HttpSession session, RedirectAttributes rttr) {
		log.info("/update : "+vo);
		String loginId = (String) session.getAttribute("user");
		//1. 입력한 기존 비밀번호 확인
		String dbPw = service.login(loginId);
		
		//2. 비밀번호가 틀렸을 경우
		if(!pwEncoder.matches(originalPw, dbPw)) {
			log.info("회원정보 수정 실패 비밀번호 불일치");
			rttr.addFlashAttribute("update", "false");
			return "redirect:/member/mypage/update";
		}
		//3. 비밀번호가 맞았을 경우
		log.info("회원정보 수정 작업 수행");
		String pw = vo.getPw();
		if(pw != null && !pw.equals("")) {
			String encodePw = pwEncoder.encode(pw);
			vo.setPw(encodePw);
		}

		service.update(vo);
		
		return "redirect: /member/mypage/home";
	}
}
