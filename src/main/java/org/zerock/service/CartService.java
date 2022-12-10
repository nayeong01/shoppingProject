package org.zerock.service;

import java.util.List;

import org.zerock.domain.CartDTO;

public interface CartService {
	
	/* 장바구니 추가 */
	public int addCart(CartDTO cart);
	
	/* 장바구니 정보 리스트 */
	public List<CartDTO> getCartList(String memberId);
	
	/* 카트 수량 수정 */
	public int modifyCount(CartDTO cart);
	
	/* 카트 삭제 */
	public int deleteCart(int cartId);
	
	
	/* 탈퇴할 회원 카트 삭제 */
	public void memberDelete(String memberId);
}
