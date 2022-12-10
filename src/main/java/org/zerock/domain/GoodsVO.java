package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class GoodsVO {
	
	//이미지 정보
	private List<AttachImageVO> imageList;
	
	//상품 코드
	private int goodsCode;
	
	//상품 분류 카테고리
	private String goodsCate;
	
	//상품 이름
	private String goodsName;
	
	//상품 가격
	private int goodsPrice;
	
	//상품 재고량
	private int goodsStock;
	
	//카테고리 이름
	private String cateName;
	
	//상품 이미지
	private String goodsImage;
	
	//상품 상세설명
	private String goodsDetail;
	
	//상품 구매 수
	private int goodsSell;
	
	//상품 등록 날짜
	private Date goodsDate;
	
	//상품 수정 날짜
	private Date goodsUpdateDate;
	
	//평점 평균
	private double ratingAvg;
	
	
}
