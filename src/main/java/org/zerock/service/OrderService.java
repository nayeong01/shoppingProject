package org.zerock.service;

import java.util.List;

import org.zerock.domain.OrderCancelDTO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.OrderListDTO;
import org.zerock.domain.OrderPageItemDTO;

public interface OrderService {
	
	//주문 정보
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders);
	
	//주문 정보 처리
	public void order(OrderDTO orw); 
	
	//주문 취소
	public void orderCancel(OrderCancelDTO dto);
	
	//주문 상품 리스트(마이페이지)
	public List<OrderDTO> getOrderList(OrderDTO dto) throws Exception;
	
	//특정주문목록
	public List<OrderListDTO> orderView(OrderDTO dto) throws Exception;
	
	/* 회원 삭제 */
	public void memberDelete(String memberId);
	
	//주문 리스트 삭제
	public void orderListDelete(String orderId);
}
