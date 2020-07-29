package org.hyojung.mapper;

import java.util.Date;
import java.util.List;
import java.util.stream.IntStream;

import org.hyojung.domain.CmtVO;
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
public class CmtMapperTests {
	
	@Setter(onMethod_ = {@Autowired})
	private CmtMapper mapper;
	
	//@Test
	public void testMapper() {
		log.info(mapper);
	}
//	<!-- 	private int id; -->
//	<!-- 	private int board_id; -->
//	<!-- 	private int depth;(default 0) -->
//	<!-- 	private int bundle_id; -->
//	<!-- 	private int bundle_order; -->
//	<!-- 	private String writer_id; -->
//	<!-- 	private String cmt; -->
//	<!-- 	private boolean id_deleted; (default false)-->
//	<!-- 	private Date created_date;(default timestamp) -->
//	<!-- 	private Date updated_date; -->	
	
	//@Test
	public void getNextInt() {
		log.info("next Id : "+mapper.getNextId());
	}
	
	//@Test
	public void testList() {
		Criteria cri = new Criteria(2);
		List<CmtVO> cmts;
		try {
			cmts = mapper.getListWithPagint(cri, 22);
			cmts.forEach(cmt -> log.info(cmt));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//@Test
	public void testUpdate() {
		int targetId = 5;
		CmtVO vo = mapper.get(targetId);
		
		vo.setCmt("Update Cmt");
		int count = mapper.update(vo);
		
		log.info(count);
	}
	
	//@Test
	public void testDelete() {
		int targetId = 3;
		mapper.delete(targetId);
		
		testGet();
	}
	
	//@Test
	public void testGet() {
		int targetId = 3;
		CmtVO vo = mapper.get(targetId);
		log.info(vo);
	}
	
	//@Test
	public void testInsert() {
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			CmtVO vo = new CmtVO();
//			
//			vo.setBoard_id(22);
//			vo.setDepth(0);
//			vo.setBundle_id(i);
//			vo.setBundle_order(0);
//			vo.setWriter_id("user01");
//			vo.setCmt("´ñ±Û Å×½ºÆ® "+i);
//			
//			mapper.insert(vo);
//		});
		IntStream.rangeClosed(1, 2).forEach(i -> {
		CmtVO vo = new CmtVO();
		
		vo.setBoard_id(22);
		vo.setDepth(1);
		vo.setBundle_id(1);
		vo.setBundle_order(new Date().getTime());
		vo.setWriter_id("user01");
		vo.setCmt("´ë´ñ ´ñ±Û Å×½ºÆ® "+i);
		
		mapper.insert(vo);
		});
	}
}
