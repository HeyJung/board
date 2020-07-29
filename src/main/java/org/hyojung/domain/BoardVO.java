package org.hyojung.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private int id;
	private String title;
	private String writer_id;
	private String content;
	private Date date;
	private int view;
	
	private List<BoardAttachVO> attachList;
}
