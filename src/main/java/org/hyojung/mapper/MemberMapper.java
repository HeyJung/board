package org.hyojung.mapper;

import org.hyojung.domain.MemberVO;

public interface MemberMapper {
	
	//CRUD
	public int register(MemberVO vo);
	
	public MemberVO get(String id);
	
	public int update(MemberVO vo);
	
	public int delete(String id);
	
	//아이디 중복체크
	public int checkId(String id);
	
	//로그인
	public String login(String id);
	
	//글쓰기 권한
	public void updateAuth(String id);
	
	//이메일 인증여부 
	public boolean getAuth(String id);
}
