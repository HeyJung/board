package org.hyojung.service;

import java.util.List;

import org.hyojung.domain.BoardAttachVO;
import org.hyojung.domain.BoardVO;
import org.hyojung.domain.Criteria;
import org.hyojung.mapper.BoardAttachMapper;
import org.hyojung.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachmapper;
	
	@Transactional
	@Override
	public boolean insert(BoardVO vo) {
		log.info("insert......" + vo);
		int nextBoard = mapper.getNextId();
		boolean result = mapper.insert(vo)==1;
		
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) return result;
		
		vo.getAttachList().forEach(attach -> {
			attach.setBoard_id(nextBoard);
			attachmapper.insert(attach);
		});
		
		return result;
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList......");
		return mapper.getListWithPage(cri);
	}
	
	@Override
	public BoardVO get(int id) {
		log.info("get......" + id);
		
		return mapper.get(id);
	}
	
	@Transactional
	@Override
	public boolean delete(int id) {
		log.info("delete......"+id);
		attachmapper.deleteAll(id);
		return mapper.delete(id) == 1;
	}
	
	@Transactional
	@Override
	public boolean update(BoardVO vo) {
		log.info("update......"+vo);
		
		attachmapper.deleteAll(vo.getId());
		boolean result = mapper.update(vo) == 1;
		if(result && vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setBoard_id(vo.getId());
				attachmapper.insert(attach);
			});
		}
		return result;
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count......");
		return mapper.getTotal(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(int board_id) {
		log.info("get Attach list by board_id :"+board_id);
		return attachmapper.findByBid(board_id);
	}

	@Override
	public void updateView(int id) {
		log.info("update view count.......");
		mapper.updateView(id);
		
	}


}
