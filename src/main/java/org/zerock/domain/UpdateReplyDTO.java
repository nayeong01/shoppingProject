package org.zerock.domain;

import lombok.Data;

@Data
public class UpdateReplyDTO {
	
	//상품코드
	private int goodsCode;
	
	//평점 평균 값
	private double ratingAvg;

}
