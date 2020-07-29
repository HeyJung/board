package org.hyojung.mapper;

import org.hyojung.domain.MemberVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
		
		@Setter(onMethod_ = {@Autowired})
		private MemberMapper mapper;
		
		@Setter(onMethod_ = {@Autowired})
		private BCryptPasswordEncoder pwencoder;
		
		//@Test
		public void registerTest() {
			MemberVO member = new MemberVO();
			member.setId("user03");
			member.setPw("1234");
			member.setName("����");
			member.setEmail("hotr905@naver.com");
			member.setPhone("010-1111-2222");
			
			log.info("register count :"+mapper.register(member));
		}
		
		//@Test
		public void getTest() {
			log.info(mapper.get("user01"));
		}
		
		//@Test
		public void updateTest() {
			//MemberVO vo = mapper.get("user04");
			//��й�ȣ�� �Է����� ���� ���
			//vo.setPw("1111");
			MemberVO vo = new MemberVO();
			vo.setId("user04");
			vo.setName("����¯");
			vo.setEmail("j3h2j5@gmail.com");
			vo.setPhone("010-0000-1111");
			
			log.info("update count: "+mapper.update(vo));
		}
		
		//@Test
		public void deleteTest() {
			log.info("delete count: "+ mapper.delete("user03"));
		}
		
		//@Test
		public void checkIdTest() {
			
			log.info("��밡���� ���̵��Դϱ�? "+ (mapper.checkId("user01") == 0));
			log.info("��밡���� ���̵��Դϱ�? "+ (mapper.checkId("user05") == 0));
		}
		
		//@Test
		public void loginTest() {
			
			String idparam = "user04";
			String pwparam = "1234";
			
			boolean login = pwencoder.matches(pwparam, mapper.login(idparam));
			log.info("�α��� Ȯ��  ?"+login);
		}
		
		@Test
		public void authTest() {
			String id = "user10";
			
			log.info("���� Ȯ�� :"+ mapper.getAuth(id));
		}
}
