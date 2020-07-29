package org.hyojung.mapper;

import java.util.List;

import org.hyojung.domain.BoardVO;
import org.hyojung.domain.Criteria;
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
public class BoardMapperTests {
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	//@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("새로 작성하는 글");
		vo.setWriter_id("user01");
		vo.setContent("새로 작성하는 내용");
		
		log.info("INSERT COUNT :"+mapper.insert(vo));
	}
	
	//@Test
	public void testGetNextId() {
		log.info(mapper.getNextId());
	}
	
	//@Test
	public void testGet() {
		BoardVO board = mapper.get(2);
		log.info(board);
	}
	
	//@Test
	public void testDelete() {
		log.info("DELETE COUNT :" + mapper.delete(4));
	}
	
	//@Test
	public void testUpdate() {
		BoardVO vo = new BoardVO();
		vo.setId(1);
		vo.setTitle("수정되었습니다");
		vo.setContent("수정된 내용");
		
		log.info("UPDATE COUNT :" + mapper.update(vo));
	}
	
	//@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(2);

		List<BoardVO> list = mapper.getListWithPage(cri);
		list.forEach(board -> log.info(board));
	}
	
	//@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("test");
		cri.setType("title");
		
		List<BoardVO> list = mapper.getListWithPage(cri);
		list.forEach(board -> log.info(board));
	}
	
	//@Test 
	public void testTotalCount() {
		Criteria cri = new Criteria();
		cri.setKeyword("test");
		cri.setType("title");
		
		log.info(mapper.getTotal(cri));
	
	}
	
	
	
}
