package org.hyojung.service;

import java.util.ArrayList;
import java.util.List;

import org.hyojung.domain.BoardAttachVO;
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
public class TransactionTest {

	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	//@Test
	public void insertTransactionTest() {
		List<BoardAttachVO> list = new ArrayList<BoardAttachVO>();
		BoardVO board = new BoardVO();
		board.setTitle("transaction test");
		board.setWriter_id("user04");
		board.setContent("test");
		
		BoardAttachVO attach = new BoardAttachVO();
		attach.setFileName("test");
		attach.setUploadPath("Test path");
		//attach.setUuid("1"); primary 키 null로 추가 에러 
		
		list.add(attach);
		board.setAttachList(list);
		
		log.info("test board======================="+board);
		log.info("before insert - "+service.getList(new Criteria()));
		service.insert(board);
		
		log.info("after insert - "+service.getList(new Criteria()));
	}
	
}
