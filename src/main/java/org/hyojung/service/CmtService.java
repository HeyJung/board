package org.hyojung.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hyojung.domain.CmtPageDTO;
import org.hyojung.domain.CmtVO;
import org.hyojung.domain.Criteria;

public interface CmtService {
	public int insert(CmtVO vo);
	
	public CmtVO get(int id);
	
	public int delete(int id);
	
	public int update(CmtVO vo);
	
	public CmtPageDTO getList(Criteria cri,int board_id) ;
	
	public int getNextId();
	
	public int getCountByBid(int board_id);
}
