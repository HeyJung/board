package org.hyojung.mapper;

import java.util.List;

import org.hyojung.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBid(int board_id);
	
	public void deleteAll(int board_id);
	
	public List<BoardAttachVO> getOldFiles();
	
	
}
