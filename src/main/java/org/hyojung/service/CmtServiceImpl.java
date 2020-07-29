package org.hyojung.service;

import java.util.List;

import org.hyojung.domain.CmtPageDTO;
import org.hyojung.domain.CmtVO;
import org.hyojung.domain.Criteria;
import org.hyojung.mapper.CmtMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CmtServiceImpl implements CmtService{
	
	@Setter(onMethod_ = @Autowired)
	private CmtMapper mapper;
	
	@Override
	public int insert(CmtVO vo) {
		log.info("insert......" + vo);
		return mapper.insert(vo);
	}

	@Override
	public CmtVO get(int id) {
		log.info("get......" + id);
		return mapper.get(id);
	}

	@Override
	public int delete(int id) {
		log.info("delete......" + id);
		return mapper.delete(id);
	}

	@Override
	public int update(CmtVO vo) {
		log.info("update......"+vo);
		return mapper.update(vo);
	}

	@Override
	public CmtPageDTO getList(Criteria cri, int board_id) {
		log.info("get List with paging......"+ cri+"/"+board_id);
		return new CmtPageDTO(mapper.getCountByBid(board_id), mapper.getListWithPagint(cri, board_id));
	}

	@Override
	public int getNextId() {
		log.info("next Id...");
		return mapper.getNextId();
	}

	@Override
	public int getCountByBid(int board_id) {
		log.info("only get cmtCount......");
		return mapper.getCountByBid(board_id);
	}
	

	
	
}
