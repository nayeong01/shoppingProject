package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.ReplyDTO;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.UpdateReplyDTO;
import org.zerock.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper replyMapper;	
	
	public void setRating(int goodsId) {
		
		Double ratingAvg = replyMapper.getRatingAverage(goodsId);
		
		if(ratingAvg == null) {
			ratingAvg = 0.0;
		}
		
		ratingAvg = (double) (Math.round(ratingAvg*10));
		ratingAvg = ratingAvg/10;
		
		UpdateReplyDTO urd = new UpdateReplyDTO();
		urd.setGoodsCode(goodsId);
		urd.setRatingAvg(ratingAvg);
		
		System.out.println(urd);
		
		replyMapper.updateRating(urd);
	}
	
	/* 댓글 등록 */
	@Override
	public int enrollReply(ReplyDTO dto) {
		
		int result = replyMapper.enrollReply(dto);
		
		setRating(dto.getGoodsId());
		
		return result;
	}
	
	/* 댓글 체크 */
	@Override
	public String checkReply(ReplyDTO dto) {
		Integer result = replyMapper.checkReply(dto);
		
		if(result == null) {
			return "0";
		}else {
			return "1";
		}		
	}

	@Override
	public ReplyPageDTO replyList(Criteria cri) {
		ReplyPageDTO dto = new ReplyPageDTO();
		
		dto.setList(replyMapper.getReplyList(cri));
		dto.setPageInfo(new PageDTO(cri, replyMapper.getReplyTotal(cri.getGoodsId())));
		
		return dto;
	}
	
	/* 댓글 수정 */
	@Override
	public int updateReply(ReplyDTO dto) {
		int result = replyMapper.updateReply(dto);
		
		setRating(dto.getGoodsId());
		
		return result;
	}
	
	/* 댓글 한개 정보 */
	@Override
	public ReplyDTO getUpdateReply(int replyId) {
		// TODO Auto-generated method stub
		return replyMapper.getUpdateReply(replyId);
	}

	@Override
	public int deleteReply(ReplyDTO dto) {
		int result = replyMapper.deleteReply(dto.getReplyId()); 
		
		setRating(dto.getGoodsId());
		
		return result;
	}
	
	@Override
	public void memberDelete(String memberId) {
		replyMapper.memberDelete(memberId);
	}
}
