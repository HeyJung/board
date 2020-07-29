package org.hyojung.mapper;

import java.util.List;

import org.hyojung.domain.BoardVO;
import org.hyojung.domain.Criteria;

public interface BoardMapper {
	
	//@Select("select * from Board where id > 0")
	public List<BoardVO> getList();
	
	
	public List<BoardVO> getListWithPage(Criteria cri);
	
	public int insert(BoardVO vo);
	
	public int getNextId();
	
	public BoardVO get(int id);
	
	public int delete(int id);
	
	public int update(BoardVO vo);
	
	public int getTotal(Criteria cri);
	
	public void updateView(int id);
	

	
}
