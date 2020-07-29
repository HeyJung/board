package org.hyojung.mapper;

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
public class BoardAttachMapperTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper mapper;
	
	//@Test
	public void testDelete(){
		mapper.delete("a");
		
	}
	
	//@Test
	public void testDeleteAll() {
		int testid = 30;
		mapper.findByBid(testid).forEach(attach -> log.info(attach));
		mapper.deleteAll(testid);
		mapper.findByBid(testid).forEach(attach -> log.info(attach));
	}
	

}
