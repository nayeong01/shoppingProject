package org.zerock.service;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyDTO;
import org.zerock.domain.ReplyPageDTO;

public interface ReplyService {
	
	/* 댓글 등록 */
	public int enrollReply(ReplyDTO dto);
	
	/* 댓글 체크 */
	public String checkReply(ReplyDTO dto);
	
	/* 댓글 페이징 */
	public ReplyPageDTO replyList(Criteria cri);
	
	/* 댓글 수정 */
	public int updateReply(ReplyDTO dto);
	
	/* 댓글 한개 정보(수정페이지) */
	public ReplyDTO getUpdateReply(int replyId);
	
	/* 댓글 삭제 */
	public int deleteReply(ReplyDTO dto);
	
	/* 회원 삭제 */
	public void memberDelete(String memberId);
}
