package org.hyojung.controller;

import org.aspectj.lang.annotation.Before;
import org.hyojung.mapper.BoardMapperTests;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@org.junit.Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	//@Test
	public void testList() throws Exception{
		log.info(
			mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
			.param("pageNum", "2"))
			.andReturn()
			.getModelAndView()
			.getModelMap());
	}
	
	//@Test
	public void testInsert() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/insert")
				.param("title", "테스트 새글 제목")
				.param("writer_id", "user01")
				.param("content", "테스트 새글 내용")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	//@Test
	public void testGet() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("id", "6"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	//@Test
	public void testUpdate() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/update")
				.param("id", "7")
				.param("title", "테스트 업데이트 제목")
				.param("content", "수정된 글"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	//@Test
	public void testDelete() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/delete")
				.param("id", "7"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testViewupdate() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("id", "6"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
		
	}
}
