package org.hyojung.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ErrorPageController {
	
	@GetMapping("/errors")
	public String renderErrorPage(Model model, HttpServletRequest request) {
		String errorMsg ="";
		int httpErrorCode = getErrorCode(request);

		switch (httpErrorCode) {
		case 400:
			errorMsg = "Http Error Code: 400 �߸��� ��û�Դϴ�";
			break;
		case 401:
			errorMsg = "Http Error Code: 401 ���ٱ����� �����ϴ�";
			break;
		case 404:
			errorMsg = "Http Error Code: 404 �������� �ʴ� �������Դϴ�";
			break;			
		case 500:
			errorMsg = "Http Error Code: 500 ���������� �߻��߽��ϴ�";
			break;	
		default:
			errorMsg = "������ �߻��߽��ϴ�";
			break;
		}
		
		model.addAttribute("errorMsg", errorMsg);
		return "errorPage";
	}
	
	private int getErrorCode(HttpServletRequest request) {
		return (Integer)request.getAttribute("javax.servlet.error.status_code");
	}
}
