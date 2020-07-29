package org.hyojung.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hyojung.domain.CmtVO;
import org.hyojung.domain.Criteria;

public interface CmtMapper {
	
	public int insert(CmtVO vo);
	
	public CmtVO get(int id);
	
	public int delete(int id);
	
	public int update(CmtVO vo);
	
	public List<CmtVO> getListWithPagint (
			@Param("cri") Criteria cri,
			@Param("board_id") int board_id
			);
	
	public int getNextId();
	
	public int getCountByBid(int board_id);
}
