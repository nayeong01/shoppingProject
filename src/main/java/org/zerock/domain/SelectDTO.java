package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class SelectDTO {
	
	//상품 id
	private int goodsCode;
	
	//상품이름
	private String goodsName;
	
	//카테고리 이름
	private String cateName;
	
	//상품 평점 평균
	private double ratingAvg;
	
	//상품 이미지
	private List<AttachImageVO> imageList;
	

}
