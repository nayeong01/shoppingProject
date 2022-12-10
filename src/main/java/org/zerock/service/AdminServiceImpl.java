package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.CateVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderCancelDTO;
import org.zerock.domain.OrderDTO;
import org.zerock.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	//상품 등록
	@Override
	@Transactional
	public void goodsEnroll(GoodsVO goods) {
		// TODO Auto-generated method stub
		
		log.info("(service)상품 등록...........");
		
		adminMapper.goodsEnroll(goods);
		
		//등록 이미지가 없으면 그냥 리턴해버린다.
		if(goods.getImageList() ==null || goods.getImageList().size() <=0 ) {
			return;
		}
		
		goods.getImageList().forEach(attach ->{
			
			attach.setGoodsCode(goods.getGoodsCode());
			
			adminMapper.imageEnroll(attach);
			
		});
		
	}
	
	
	@Override
	public List<CateVO> cateList() {
		// TODO Auto-generated method stub
		
		log.info("(service)카테고리 리스트.........");
		return adminMapper.cateList();
	}
	
	//상품 리스트
	@Override
	public List<GoodsVO> goodsGetList(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("goodsGetTotalList()..........");
		return adminMapper.goodsGetList(cri);
	}
	
	//상품 총 개수
	@Override
	public int goodsGetTotal(Criteria cri) {
		// TODO Auto-generated method stub
		
		log.info("goodsGetTotal()...........");
		return adminMapper.goodsGetTotal(cri);
	}

	//상품 조회 페이지
	@Override
	public GoodsVO goodsGetDetail(int goodsCode) {
		// TODO Auto-generated method stub
		
		log.info("(service)GoodsGetDetail...........");
		return adminMapper.goodsGetDetail(goodsCode);
	}

	//상품 정보 수정
	@Transactional
	@Override
	public int goodsModify(GoodsVO vo) {
		
		int result = adminMapper.goodsModify(vo);
		
		if (result ==1 && vo.getImageList() !=null && vo.getImageList().size() >0) {
			
			adminMapper.deleteImageAll(vo.getGoodsCode()); // 전체 삭제하고,
			
			//새로운 이미지 리스트를 하나씩 넣는다.
			vo.getImageList().forEach(attach->{ 
				
				attach.setGoodsCode(vo.getGoodsCode());
				
				adminMapper.imageEnroll(attach);
			});
			
		}
		return result;
	}

	//상품 정보 삭제
	@Override
	@Transactional
	public int goodsDelete(int goodsCode) {
		// TODO Auto-generated method stub
		log.info("goodsDelete.............");
		
		adminMapper.deleteImageAll(goodsCode);
		
		return adminMapper.goodsDelete(goodsCode);
	}


	@Override
	public List<AttachImageVO> getAttachInfo(int goodsCode) {
		// TODO Auto-generated method stub
		
		log.info("getAttachInfo...............");
		
		return adminMapper.getAttachInfo(goodsCode);
	}


	@Override
	public List<OrderDTO> getOrderList(Criteria cri) {
		// TODO Auto-generated method stub
		return adminMapper.getOrderList(cri);
	}


	@Override
	public int getOrderTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return adminMapper.getOrderTotal(cri);
	}
	
	@Override
	public List<MemberVO> memberGetList(Criteria cri) {
		log.info("memberGetList()........");
		return adminMapper.memberGetList(cri);
	}

	@Override
	public void memberDelete(String memberId) {
		log.info("memberDelete()........");
		adminMapper.memberDelete(memberId);
	}


	@Override
	public int getMemberTotal(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("goodsGetTotal()...........");
		return adminMapper.getMemberTotal(cri);
	}


	@Override
	public OrderCancelDTO memberGetDetail(String memberId) {
		// TODO Auto-generated method stub
		return adminMapper.memberGetDetail(memberId);
	}


	@Override
	public int memberModify(OrderCancelDTO dto) {
		// TODO Auto-generated method stub
		return adminMapper.memberModify(dto);
	}	

}
