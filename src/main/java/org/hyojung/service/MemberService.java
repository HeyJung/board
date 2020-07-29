package org.hyojung.service;

import org.hyojung.domain.MemberVO;

public interface MemberService {
	//CRUD
	public int register(MemberVO vo);
	
	public MemberVO get(String id);
	
	public int update(MemberVO vo);
	
	public int delete(String id);
	
	//아이디 중복체크
	public int checkId(String id);
	
	public String login(String id);
	
	public void updateAuth(String id);
	
	public boolean getAuth(String id);
	
}
