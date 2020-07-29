package org.hyojung.service;

import static org.junit.Assert.assertNotNull;

import org.hyojung.domain.BoardVO;
import org.hyojung.domain.Criteria;
import org.hyojung.mapper.BoardMapperTests;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	//@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("service Insert Test");
		vo.setWriter_id("user01");
		vo.setContent("test Content");
		
		log.info("생성된 게시물 갯수 : "+service.insert(vo));
	}
	
	//@Test
	public void testGetList() {
		//service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(1)).forEach(board -> log.info(board));
		
	}
	
	//@Test
	public void testGet() {
		log.info(service.get(6));
	}
	
	//@Test
	public void testDelete() {
		log.info("게시물 삭제 :"+service.delete(5));
	}
	
	//@Test
	public void testUpdate() {
		BoardVO vo = service.get(1);
		
		if(vo == null) return;
		
		vo.setTitle("서비스 업데이트 테스트중");
		log.info("게시물 수정 :"+service.update(vo));
	}
	
}
