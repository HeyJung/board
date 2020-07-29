package org.hyojung.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum;
	private int limitNum;
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1);
	}

	public Criteria(int pageNum) {
		this.pageNum = pageNum;
		this.limitNum = (pageNum -1)*10;
	}
	
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		this.limitNum = (pageNum -1)*10;
	}
	
	public String getType() {
		return type == null? new String("") : type;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
