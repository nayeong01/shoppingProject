package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class ReplyPageDTO {
	
	private List<ReplyDTO> list;
	
	private PageDTO pageInfo;

}