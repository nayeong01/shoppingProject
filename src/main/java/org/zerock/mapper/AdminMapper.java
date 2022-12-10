package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.AttachImageVO;
import org.zerock.domain.CateVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderCancelDTO;
import org.zerock.domain.OrderDTO;

public interface AdminMapper {
	
	//상품등록
	public void goodsEnroll(GoodsVO goods);
	
	//카테고리 리스트
	public List<CateVO> cateList();
	
	//상품리스트
	public List<GoodsVO> goodsGetList(Criteria cri);
	
	//상품 총 개수
	public int goodsGetTotal(Criteria cri);
	
	//상품 조회 페이지
	public GoodsVO goodsGetDetail(int goodsCode);
	
	//상품 수정
	public int goodsModify(GoodsVO vo);
	
	//상품 정보 삭제
	public int goodsDelete(int GoodsCode);
	
	//이미지 등록
	public void imageEnroll(AttachImageVO vo);
	
	//지정 상품 이미지 전체 삭제
	public void deleteImageAll(int goodsCode);
	
	//어제자 날짜 이미지 리스트
	public List<AttachImageVO> checkFileList();
	
	//지정 상품 이미지 정보 얻기
	public List<AttachImageVO> getAttachInfo(int goodsCode);
	
	//주문 상품 리스트
	public List<OrderDTO> getOrderList(Criteria cri);
	
	//주문 총 갯수
	public int getOrderTotal(Criteria cri);
	
	/* 회원리스트 */
	public List<MemberVO> memberGetList(Criteria cri);
	
	//회원 총 갯수
	public int getMemberTotal(Criteria cri);
	
	/* 회원 삭제 */
	public void memberDelete(String memberId);
	
	//상품 조회 페이지
	public OrderCancelDTO memberGetDetail(String memberId);
	
	//상품 수정
	public int memberModify(OrderCancelDTO dto);
}
