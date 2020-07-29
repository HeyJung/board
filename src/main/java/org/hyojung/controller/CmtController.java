package org.hyojung.controller;

import java.sql.SQLSyntaxErrorException;
import java.util.List;

import org.hyojung.domain.CmtPageDTO;
import org.hyojung.domain.CmtVO;
import org.hyojung.domain.Criteria;
import org.hyojung.service.CmtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/cmt/*")
@RestController
@Log4j
public class CmtController {
	
	@Setter(onMethod_ = @Autowired)
	private CmtService service;
	
	@PostMapping(value="/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insert(@RequestBody CmtVO vo){
		if(vo.getDepth() == 0) {
			vo.setBundle_id(service.getNextId());
		}
		log.info("Cmt insert vo" + vo);
		
		int count = service.insert(vo);
		
		log.info("Cmt insert count :"+ count);
		
		return count == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{board_id}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CmtPageDTO> getList(
			@PathVariable("page") int page, @PathVariable("board_id") int board_id){
		Criteria cri = new Criteria(page);
		
		log.info("getList......"+board_id);
		log.info("cri :"+cri);
		if(page == -1) {
			log.info("last page request......");
			int count = service.getCountByBid(board_id);
			cri.setPageNum((int)Math.ceil(count/10.0));
		}
		return new ResponseEntity<CmtPageDTO>(service.getList(cri, board_id), HttpStatus.OK);
	}
	
	@GetMapping(value="/{id}",
			produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CmtVO> get(@PathVariable("id") int id){
		log.info("get :"+id);
		return new ResponseEntity<CmtVO>(service.get(id), HttpStatus.OK);
		
	}
	
	@DeleteMapping(value="/{id}",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> delete(@PathVariable("id") int id){
		log.info("delete : "+id);
		
		return service.delete(id) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{id}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> update(@RequestBody CmtVO vo, @PathVariable("id") int id){
		log.info("update : "+id +"->"+vo);
		vo.setId(id);
		return service.update(vo) == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
