package org.hyojung.service;

import org.hyojung.domain.MemberVO;
import org.hyojung.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public int register(MemberVO vo) {
		log.info("register......"+vo);
		return mapper.register(vo);
	}

	@Override
	public MemberVO get(String id) {
		log.info("get......"+id);
		return mapper.get(id);
	}

	@Override
	public int update(MemberVO vo) {
		log.info("update......"+vo);
		return mapper.update(vo);
	}

	@Override
	public int delete(String id) {
		log.info("delete......."+id);
		return mapper.delete(id);
	}

	@Override
	public int checkId(String id) {
		log.info("check id......"+id);
		return mapper.checkId(id);
	}

	@Override
	public String login(String id) {
		log.info("login......."+id);
		return mapper.login(id);
	}

	@Override
	public void updateAuth(String id) {
		log.info("update auth.......");
		mapper.updateAuth(id);
	}

	@Override
	public boolean getAuth(String id) {
		log.info("get auth.......");
		return mapper.getAuth(id);
	}

}
