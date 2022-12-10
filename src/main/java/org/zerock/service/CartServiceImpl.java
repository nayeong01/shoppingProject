package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.CartDTO;
import org.zerock.mapper.AttachMapper;
import org.zerock.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private AttachMapper attachMapper;

	@Override
	public int addCart(CartDTO cart) {
		
		//장바구니 데이터 체크
		CartDTO checkCart = cartMapper.checkCart(cart);
		
		if(checkCart != null) {
			return 2;
		}
		
		//장바구니 등록 & 에러 시 0 반환
		try {
			return cartMapper.addCart(cart);
		}catch(Exception e) {
			return 0;
		}
	}

	@Override
	public List<CartDTO> getCartList(String memberId) {
		
		List<CartDTO> cart = cartMapper.getCart(memberId);
		
		for(CartDTO dto : cart) {
			
			//종합 정보 초기화
			dto.initSaleTotal();
			
			/* 이미지 정보 얻기 */
			int goodsId = dto.getGoodsId();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsId);
			
			dto.setImageList(imageList);
		}
		
		return cart;
	}

	@Override
	public int modifyCount(CartDTO cart) {
		// TODO Auto-generated method stub
		return cartMapper.modifyCount(cart);
	}

	@Override
	public int deleteCart(int cartId) {
		// TODO Auto-generated method stub
		return cartMapper.deleteCart(cartId);
	}
	
	@Override
	public void memberDelete(String memberId) {
		cartMapper.memberDelete(memberId);
	}

}
