package org.hyojung.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class CmtPageDTO {
	
	private int cmtCount;
	private List<CmtVO> list;
}
