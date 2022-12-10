package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderCancelDTO {
	
	private String memberId;
	
	private String orderId;

	private String keyword;
	
	private int amount;
	
	private int pageNum;

	//회원 전화번호
	private String memberTel;
		
	//회원 이름
	private String memberName;
		
	//회원 이메일
	private String memberMail;
	
	//회원 돈
	private int money;
		
	//회원 포인트
	private int point;
	
	//등록일자
	private Date regDate;
}
