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
	
	//ȸ������
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
	
	//���̵� �ߺ� Ȯ��
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
	
	//�α���
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
			log.info("�������� �ʴ� ���̵�......");
			rttr.addFlashAttribute("falseMsg", "0");
			rttr.addFlashAttribute("inputid", id);
			return "redirect:/member/login";
		}
		else if(!pwEncoder.matches(pw, dbPw)) {
			log.info("���̵� ��й�ȣ ����ġ......");
			rttr.addFlashAttribute("falseMsg", "1");
			rttr.addFlashAttribute("inputid", id);
			return "redirect:/member/login";
		}
		
		log.info("�α��� ����......");
		session.setAttribute("user", id);
		rttr.addFlashAttribute("welcome", "ȯ���մϴ�");
		return "redirect:/board/list";
	}
	
	//�α׾ƿ�
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("/logout");
		session.invalidate();
		return "redirect:/member/login";
	}
	
	//����������
	@GetMapping("/mypage/home")
	public String mypage(Model model, HttpSession session) {
		log.info("/mypage/home");
		String id = (String) session.getAttribute("user");
		model.addAttribute("userinfo", service.get(id));
		
		return "/mypage/home";
	}
	//ȸ������ ����
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
		//1. �Է��� ���� ��й�ȣ Ȯ��
		String dbPw = service.login(loginId);
		
		//2. ��й�ȣ�� Ʋ���� ���
		if(!pwEncoder.matches(originalPw, dbPw)) {
			log.info("ȸ������ ���� ���� ��й�ȣ ����ġ");
			rttr.addFlashAttribute("update", "false");
			return "redirect:/member/mypage/update";
		}
		//3. ��й�ȣ�� �¾��� ���
		log.info("ȸ������ ���� �۾� ����");
		String pw = vo.getPw();
		if(pw != null && !pw.equals("")) {
			String encodePw = pwEncoder.encode(pw);
			vo.setPw(encodePw);
		}

		service.update(vo);
		
		return "redirect: /member/mypage/home";
	}
}
