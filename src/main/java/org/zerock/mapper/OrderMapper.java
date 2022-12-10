package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.GoodsVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderDTO;
import org.zerock.domain.OrderItemDTO;
import org.zerock.domain.OrderListDTO;
import org.zerock.domain.OrderPageItemDTO;

public interface OrderMapper {
	
	//주문 상품 정보(주문 페이지)
	public OrderPageItemDTO getGoodsInfo(int goodsCode);
	
	//주문 상품 정보(주문 처리)
	public OrderItemDTO getOrderInfo(int goodsCode);
	
	//주문 테이블 등록
	public int enrollOrder(OrderDTO ord);
	
	//주문 아이템 테이블 등록
	public int enrollOrderItem(OrderItemDTO orid);
	
	//주문 금액 차감
	public int deductMoney(MemberVO member);
	
	//주문 재고 차감
	public int deductStock(GoodsVO goods);
	
	//주문 취소
	public int orderCancel(String orderId);
	
	//주문 상품 정보(주문 취소)
	public List<OrderItemDTO> getOrderItemInfo(String orderId);
	
	//주문 정보(주문 취소)
	public OrderDTO getOrder(String orderId);
	
	//마이페이지 주문 정보
	public List<OrderDTO> getOrderList(OrderDTO dto);

	//특정 주문 목록
	public List<OrderListDTO> orderView(OrderDTO dto);
	
	//회원 삭제
	public void memberDelete(String memberId);
	
	//주문 삭제
	public void orderListDelete(String orderId);
}
