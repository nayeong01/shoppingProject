package org.zerock.domain;

import lombok.Data;

@Data
public class OrderListDTO {

	//주문번호
	private String orderId;

	//주문자
	private String addressee;
	
	//우편번호
	private String memberAddr1;
	
	//회원 주소
	private String memberAddr2;
	
	//회원 상세 주소
	private String memberAddr3;
	
	private String memberTel;
	
	//상품 정보
	//상품 번호
	private int goodsCode;
	
	//주문 수량
	private int goodsCount;
	
	//zero_orderItem 기본키
	private int orderItemId;
	
	//상품 한 개 가격
	private int goodsPrice;
	
	private String goodsName;
	
}
