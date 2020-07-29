package org.hyojung.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hyojung.domain.BoardAttachVO;
import org.hyojung.domain.BoardVO;
import org.hyojung.domain.Criteria;
import org.hyojung.domain.PageDTO;
import org.hyojung.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/board/*")
@Controller
@Log4j
@AllArgsConstructor
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("/list:" +cri);
		int total = service.getTotal(cri);
		PageDTO pagedto = new PageDTO(cri, total);
		log.info("total : "+total);
		log.info("pageDTP : "+pagedto);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", pagedto);
	}
	
	@GetMapping("/insert")
	public void insert() {
		
	}
	
	@PostMapping("/insert")
	public String insert(BoardVO vo, RedirectAttributes rttr) {
		log.info("/insert :" +vo);
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> log.info(attach));
		}
		
		if(service.insert(vo)) {
			rttr.addFlashAttribute("result", "작성이 완료되었습니다.");
		}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri,
			Model model, HttpServletRequest request, HttpServletResponse response) {
		log.info("/get :"+id +" : "+cri);
		
		//조회수 중복 증가 방지	
		Cookie[] cookies = request.getCookies();
		Cookie viewcookie = null;
		
		if(cookies != null && cookies.length > 0) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("view"+id)) {
					log.info("have viewcookie");
					viewcookie = cookies[i];
				}
			}
		}
		
		if(viewcookie == null) {
			log.info("view ++");
			
			Cookie newcookie = new Cookie("view"+id, "view++");
			newcookie.setMaxAge(60*60*24);
			response.addCookie(newcookie);
			service.updateView(id);
		}
		
		model.addAttribute("board", service.get(id));
		return "/board/get";
	}

	@GetMapping("/update")
	public void update(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/update :"+id+"/"+cri);
		model.addAttribute("board", service.get(id));
	}
	@PostMapping("/update")
	public String update(BoardVO vo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("/update :"+vo);
		
		if(service.update(vo)) {
			rttr.addFlashAttribute("result", "수정이 완료되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("id") int id, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("/delete :"+id);
		
		List<BoardAttachVO> attachList = service.getAttachList(id);
		
		if(service.delete(id)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "삭제가 완료되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int board_id){
		log.info("/getAttachList"+board_id);
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachList(board_id), HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) return;
		
		log.info("delete attachList file......");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
					
				}
			} catch (Exception e) {
				log.error("delete file error..."+e.getMessage());
			}
		});
	}
}
