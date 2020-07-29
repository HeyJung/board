package org.hyojung.service;

import java.util.List;

import org.hyojung.domain.BoardAttachVO;
import org.hyojung.domain.BoardVO;
import org.hyojung.domain.Criteria;

public interface BoardService {
	
	public boolean insert(BoardVO vo);
	//public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri);
	public BoardVO get(int id);
	public boolean delete(int id);
	public boolean update(BoardVO vo);
	public int getTotal(Criteria cri);
	public List<BoardAttachVO> getAttachList(int board_id);
	public void updateView(int id);
}
