package org.zerock.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyDTO {
	
	private int replyId;
	
	private int goodsId;
	
	private String memberId;
	
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date regDate;
		
	private String content;
		
	private double rating;
		
	@Override
	public String toString() {
		return "ReplyDTO [replyId=" + replyId + ", goodsId=" + goodsId + ", memberId=" + memberId + ", regDate=" + regDate
				+ ", content=" + content + ", rating=" + rating + "]";
	}
}
