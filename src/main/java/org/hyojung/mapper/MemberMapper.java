package org.hyojung.mapper;

import org.hyojung.domain.MemberVO;

public interface MemberMapper {
	
	//CRUD
	public int register(MemberVO vo);
	
	public MemberVO get(String id);
	
	public int update(MemberVO vo);
	
	public int delete(String id);
	
	//���̵� �ߺ�üũ
	public int checkId(String id);
	
	//�α���
	public String login(String id);
	
	//�۾��� ����
	public void updateAuth(String id);
	
	//�̸��� �������� 
	public boolean getAuth(String id);
}
