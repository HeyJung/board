package org.hyojung.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CmtVO {

	private int id;
	private int board_id;
	private int depth;
	private int bundle_id;
	private long bundle_order;
	private String writer_id;
	private String cmt;
	private boolean is_deleted;
	private Date created_date;
	private Date updated_date;
}
